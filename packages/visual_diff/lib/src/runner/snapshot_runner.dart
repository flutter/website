// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:collection';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:puppeteer/puppeteer.dart';

import 'route_discovery.dart';
import 'snapshot_server.dart';
import 'snapshot_viewport.dart';

/// Captures screenshots of site routes using headless Chromium.
final class SnapshotRunner {
  final String? customChromePath;
  final int concurrency;
  final bool hideCookieBanner;

  SnapshotRunner({
    this.customChromePath,
    this.concurrency = 4,
    this.hideCookieBanner = true,
  });

  /// Captures snapshots of [routes] from [server] and saves them
  /// to [outputDirectory].
  Future<int> captureSnapshots({
    required SnapshotServer server,
    required List<String> routes,
    required Directory outputDirectory,
    List<SnapshotViewport> viewports = SnapshotViewport.all,
    void Function(String message)? onProgress,
  }) async {
    final log = onProgress ?? print;

    if (routes.isEmpty) {
      log('⚠️  No routes specified or discovered to snapshot.');
      return 0;
    }

    if (!outputDirectory.existsSync()) {
      outputDirectory.createSync(recursive: true);
    }

    final chromePath = _findChromeExecutable(customChromePath);
    if (chromePath != null) {
      log('🌐 Using Chrome executable: $chromePath');
    } else {
      log('🌐 Auto-resolving / downloading Chromium for Puppeteer...');
    }

    final browser = await puppeteer.launch(
      executablePath: chromePath,
      headless: true,
      args: const [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-gpu',
      ],
    );

    var capturedCount = 0;
    final totalExpected = routes.length * viewports.length;

    try {
      for (final viewport in viewports) {
        log(
          '📸 Capturing ${routes.length} routes for viewport '
          '"${viewport.name}" (${viewport.width}x${viewport.height})...',
        );

        final queue = Queue<String>.from(routes);
        final workerCount = concurrency.clamp(1, routes.length);
        final workers = <Future<void>>[];

        for (var workerIndex = 0; workerIndex < workerCount; workerIndex++) {
          workers.add(() async {
            final page = await browser.newPage();
            try {
              if (hideCookieBanner) {
                await page.evaluateOnNewDocument(r'''() => {
                  const style = document.createElement('style');
                  style.id = '__visual_diff_hide_cookie__';
                  style.textContent = `
                    .glue-cookie-notification-bar,
                    [class*="glue-cookie-notification-bar"],
                    #glue-cookie-notification-bar-1 {
                      display: none !important;
                      visibility: hidden !important;
                      opacity: 0 !important;
                      pointer-events: none !important;
                    }
                  `;
                  (document.head || document.documentElement).appendChild(style);
                }''');
              }

              await page.setViewport(
                DeviceViewport(
                  width: viewport.width,
                  height: viewport.height,
                  deviceScaleFactor: viewport.deviceScaleFactor,
                  isMobile: viewport.isMobile,
                  hasTouch: viewport.hasTouch,
                ),
              );

              while (queue.isNotEmpty) {
                final route = queue.removeFirst();
                final filename = snapshotFileName(route, viewport.name);
                final outputPath = path.join(outputDirectory.path, filename);
                final url = '${server.baseUrl}$route';

                try {
                  try {
                    await page.goto(
                      url,
                      wait: Until.networkIdle,
                      timeout: const Duration(seconds: 30),
                    );
                  } catch (_) {
                    // networkIdle may time out on continuous polling;
                    // page load usually succeeded nonetheless.
                  }

                  try {
                    await page.evaluate<Object?>('() => document.fonts.ready');
                  } catch (_) {}

                  if (hideCookieBanner) {
                    try {
                      await page.addStyleTag(
                        content: '''
                          .glue-cookie-notification-bar,
                          [class*="glue-cookie-notification-bar"],
                          #glue-cookie-notification-bar-1 {
                            display: none !important;
                            visibility: hidden !important;
                            opacity: 0 !important;
                            pointer-events: none !important;
                          }
                        ''',
                      );
                      await page.evaluate<void>(r'''() => {
                        document.querySelectorAll(
                          '.glue-cookie-notification-bar, [class*="glue-cookie-notification-bar"]'
                        ).forEach(el => el.remove());
                      }''');
                    } catch (_) {}
                  }

                  await Future<void>.delayed(const Duration(milliseconds: 150));

                  final bytes = await page.screenshot(
                    format: ScreenshotFormat.png,
                    fullPage: true,
                  );
                  await File(outputPath).writeAsBytes(bytes);
                  capturedCount++;
                  log(
                    '  ✓ [$capturedCount/$totalExpected] Captured: $filename',
                  );
                } catch (error) {
                  stderr.writeln(
                    '  ✗ Failed to snapshot $route (${viewport.name}): $error',
                  );
                }
              }
            } finally {
              await page.close();
            }
          }());
        }

        await Future.wait(workers);
      }
    } finally {
      await browser.close();
    }

    return capturedCount;
  }

  /// Finds a usable Chrome or Chromium executable on the current platform.
  static String? _findChromeExecutable(String? customPath) {
    if (customPath != null && File(customPath).existsSync()) {
      return customPath;
    }

    if (Platform.environment['CHROME_EXECUTABLE'] case final envPath?
        when File(envPath).existsSync()) {
      return envPath;
    }

    if (Platform.environment['PUPPETEER_EXECUTABLE_PATH'] case final envPath?
        when File(envPath).existsSync()) {
      return envPath;
    }

    final candidatePaths = <String>[
      if (Platform.isMacOS) ...const [
        '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
        '/Applications/Chromium.app/Contents/MacOS/Chromium',
        '/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary',
        '/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge',
      ],
      if (Platform.isLinux) ...const [
        '/usr/bin/google-chrome',
        '/usr/bin/google-chrome-stable',
        '/usr/bin/chromium',
        '/usr/bin/chromium-browser',
        '/snap/bin/chromium',
      ],
      if (Platform.isWindows) ...const [
        r'C:\Program Files\Google\Chrome\Application\chrome.exe',
        r'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe',
        r'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe',
      ],
    ];

    for (final candidate in candidatePaths) {
      if (File(candidate).existsSync()) {
        return candidate;
      }
    }

    return null;
  }
}
