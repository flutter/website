// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:puppeteer/puppeteer.dart';

import '../models/header_metadata.dart';
import 'content_hasher.dart';
import 'header_extractor.dart';
import 'route_discovery.dart';
import 'snapshot_server.dart';
import 'snapshot_viewport.dart';

/// Captures screenshots of site routes using headless Chromium.
final class SnapshotRunner {
  final String? customChromePath;
  final int concurrency;
  final bool hideCookieBanner;
  final int maxHeight;
  final bool disableJavaScript;

  SnapshotRunner({
    this.customChromePath,
    this.concurrency = 6,
    this.hideCookieBanner = true,
    this.maxHeight = 4500,
    this.disableJavaScript = true,
  });

  /// Captures snapshots of [routes] from [server] and saves them
  /// to [outputDirectory].
  Future<int> captureSnapshots({
    required SnapshotServer server,
    required List<String> routes,
    required Directory outputDirectory,
    List<SnapshotViewport> viewports = SnapshotViewport.all,
    Directory? buildDirectory,
    Directory? baselineDirectory,
    SiteContentHashes? baselineHashes,
    Map<String, HeaderMetadata>? baselineMetadata,
    void Function(String message)? onProgress,
    void Function(String filename)? onSnapshotSaved,
  }) async {
    final result = await captureEagerSnapshots(
      server: server,
      routeStream: Stream.fromIterable(routes),
      expectedTotalRoutes: routes.length,
      outputDirectory: outputDirectory,
      viewports: viewports,
      buildDirectory: buildDirectory,
      baselineDirectory: baselineDirectory,
      baselineHashes: baselineHashes,
      baselineMetadata: baselineMetadata,
      onProgress: onProgress,
      onSnapshotSaved: onSnapshotSaved,
    );
    return result.capturedCount;
  }

  /// Concurrently captures snapshots from a live [routeStream] as routes become
  /// available (e.g. while Jaspr is rendering them in the background).
  Future<({int capturedCount, Map<String, HeaderMetadata> metadata})>
  captureEagerSnapshots({
    required SnapshotServer server,
    required Stream<String> routeStream,
    int? expectedTotalRoutes,
    required Directory outputDirectory,
    List<SnapshotViewport> viewports = SnapshotViewport.all,
    Directory? buildDirectory,
    Directory? baselineDirectory,
    SiteContentHashes? baselineHashes,
    Map<String, HeaderMetadata>? baselineMetadata,
    void Function(String message)? onProgress,
    void Function(String filename)? onSnapshotSaved,
  }) async {
    final log = onProgress ?? print;

    if (!outputDirectory.existsSync()) {
      outputDirectory.createSync(recursive: true);
    }

    final chromePath = _findChromeExecutable(customChromePath);
    if (chromePath != null) {
      log('🌐 Using Chrome executable: $chromePath');
    } else {
      log('🌐 Auto-resolving / downloading Chromium for Puppeteer...');
    }

    final workerCount = concurrency.clamp(1, 16);
    // Launch a pool of Chromium instances (e.g. 1 to 4) so rasterization
    // and libpng compression execute across multiple independent compositor
    // threads instead of bottlenecking on a single process.
    final browserPoolSize = (workerCount / 2).clamp(1, 4).toInt();

    final browsers = await Future.wait(
      List.generate(
        browserPoolSize,
        (_) => puppeteer.launch(
          executablePath: chromePath,
          headless: true,
          args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage',
            '--disable-gpu',
            '--disable-extensions',
            '--disable-background-timer-throttling',
            '--disable-backgrounding-occluded-windows',
            '--disable-renderer-backgrounding',
            '--disable-ipc-flooding-protection',
            '--hide-scrollbars',
            '--mute-audio',
            '--no-first-run',
            '--no-default-browser-check',
            '--disable-features=Translate,BackForwardCache,MediaRouter',
            if (disableJavaScript) '--disable-javascript',
          ],
        ),
      ),
    );

    var capturedCount = 0;
    final totalExpectedSnapshots = expectedTotalRoutes != null
        ? expectedTotalRoutes * viewports.length
        : null;

    final capturedMetadata = <String, HeaderMetadata>{};

    final effectiveBaselineHashes =
        baselineHashes ??
        (baselineDirectory != null
            ? SiteContentHashes.loadFromFile(
                File(path.join(baselineDirectory.path, 'content_hashes.json')),
              )
            : null);

    final currentGlobalAssetsHash = buildDirectory != null
        ? SiteContentHashes.computeGlobalAssetsHash(buildDirectory)
        : '';

    final canSkipUnchanged =
        effectiveBaselineHashes != null &&
        effectiveBaselineHashes.globalAssetsHash == currentGlobalAssetsHash &&
        baselineDirectory != null &&
        baselineDirectory.existsSync();

    if (effectiveBaselineHashes != null &&
        effectiveBaselineHashes.globalAssetsHash != currentGlobalAssetsHash) {
      log(
        '  🎨 Global styles or scripts changed. Full re-snapshotting required.',
      );
    } else if (canSkipUnchanged) {
      log(
        '  ⚡ Global styles and scripts unchanged. Reusing baseline for '
        'unchanged HTML routes...',
      );
    }

    final currentRouteHashes = <String, String>{};

    // Shared work queue containing tasks for each (route, viewport) pair.
    final taskQueue = Queue<({String route, SnapshotViewport viewport})>();
    var streamCompleted = false;
    final completer = Completer<void>();

    try {
      final workers = <Future<void>>[];

      // Listen to incoming routes from the stream and enqueue viewport tasks.
      late final StreamSubscription<String> streamSub;
      streamSub = routeStream.listen(
        (route) {
          var routeSkipped = false;
          if (canSkipUnchanged && buildDirectory != null) {
            final htmlFile = SiteContentHashes.resolveRouteHtmlFile(
              buildDirectory,
              route,
            );
            if (htmlFile != null && htmlFile.existsSync()) {
              final hash = SiteContentHashes.computeFileHash(htmlFile);
              currentRouteHashes[route] = hash;

              if (effectiveBaselineHashes.routeHashes[route] == hash) {
                var allBaselineSnapshotsExist = true;
                for (final vp in viewports) {
                  final filename = snapshotFileName(route, vp.name);
                  final src = File(path.join(baselineDirectory.path, filename));
                  if (!src.existsSync()) {
                    allBaselineSnapshotsExist = false;
                    break;
                  }
                }

                if (allBaselineSnapshotsExist) {
                  for (final vp in viewports) {
                    final filename = snapshotFileName(route, vp.name);
                    final src = File(
                      path.join(baselineDirectory.path, filename),
                    );
                    final dest = File(
                      path.join(outputDirectory.path, filename),
                    );
                    src.copySync(dest.path);
                    capturedCount++;
                    onSnapshotSaved?.call(filename);
                  }
                  if (baselineMetadata?[route] case final meta?) {
                    capturedMetadata[route] = meta;
                  }
                  routeSkipped = true;
                  final progressStr = totalExpectedSnapshots != null
                      ? '$capturedCount/$totalExpectedSnapshots'
                      : '$capturedCount';
                  log('  ⚡ [$progressStr] Reused baseline: $route');
                }
              }
            }
          } else if (buildDirectory != null) {
            final htmlFile = SiteContentHashes.resolveRouteHtmlFile(
              buildDirectory,
              route,
            );
            if (htmlFile != null && htmlFile.existsSync()) {
              currentRouteHashes[route] = SiteContentHashes.computeFileHash(
                htmlFile,
              );
            }
          }

          if (!routeSkipped) {
            for (final vp in viewports) {
              taskQueue.add((route: route, viewport: vp));
            }
          }
        },
        onDone: () {
          streamCompleted = true;
          if (taskQueue.isEmpty) {
            if (!completer.isCompleted) completer.complete();
          }
        },
        onError: (Object e) {
          streamCompleted = true;
          if (!completer.isCompleted) completer.complete();
        },
      );

      for (var workerIndex = 0; workerIndex < workerCount; workerIndex++) {
        final browser = browsers[workerIndex % browsers.length];
        workers.add(() async {
          final page = await browser.newPage();
          try {
            if (disableJavaScript) {
              await page.setJavaScriptEnabled(false);
            }

            // Speed optimization 1: Abort all external third-party requests
            // (e.g. analytics, tracking, ads) while allowing fonts and
            // icon glyphs (Google Fonts, Material Symbols) to load.
            var inFlightRequests = 0;
            await page.setRequestInterception(true);
            page.onRequest.listen((request) async {
              final uri = Uri.tryParse(request.url);
              final host = uri?.host.toLowerCase() ?? '';
              final isAllowed =
                  host == 'localhost' ||
                  host == '127.0.0.1' ||
                  host == 'fonts.googleapis.com' ||
                  host == 'fonts.gstatic.com' ||
                  host.endsWith('.gstatic.com') ||
                  host.endsWith('.googleapis.com') ||
                  uri?.scheme == 'data';
              if (isAllowed) {
                inFlightRequests++;
                await request.continueRequest();
              } else {
                await request.abort();
              }
            });

            page.onRequestFinished.listen((_) {
              if (inFlightRequests > 0) inFlightRequests--;
            });

            page.onRequestFailed.listen((_) {
              if (inFlightRequests > 0) inFlightRequests--;
            });

            // Speed optimization 2: Inject cookie-hiding CSS and disable
            // transitions/animations so rendering is immediate and stable.
            if (!disableJavaScript) {
              await page.evaluateOnNewDocument(r'''() => {
                const style = document.createElement('style');
                style.id = '__visual_diff_injected__';
                style.textContent = `
                  .glue-cookie-notification-bar,
                  [class*="glue-cookie-notification-bar"],
                  #glue-cookie-notification-bar-1 {
                    display: none !important;
                    visibility: hidden !important;
                    opacity: 0 !important;
                    pointer-events: none !important;
                  }
                  *, *::before, *::after {
                    transition-duration: 0s !important;
                    animation-duration: 0s !important;
                    transition-delay: 0s !important;
                    animation-delay: 0s !important;
                  }
                `;
                (document.head || document.documentElement).appendChild(style);
              }''');
            }

            SnapshotViewport? currentViewport;

            while (!streamCompleted || taskQueue.isNotEmpty) {
              if (taskQueue.isEmpty) {
                if (streamCompleted) break;
                // Wait briefly for more routes to arrive from stream.
                await Future<void>.delayed(const Duration(milliseconds: 25));
                continue;
              }

              final task = taskQueue.removeFirst();
              final route = task.route;
              final viewport = task.viewport;

              // Only reconfigure viewport if different from previous task.
              if (currentViewport?.name != viewport.name) {
                await page.setViewport(
                  DeviceViewport(
                    width: viewport.width,
                    height: viewport.height,
                    deviceScaleFactor: viewport.deviceScaleFactor,
                    isMobile: viewport.isMobile,
                    hasTouch: viewport.hasTouch,
                  ),
                );
                currentViewport = viewport;
              }

              final filename = snapshotFileName(route, viewport.name);
              final outputPath = path.join(outputDirectory.path, filename);
              final url = '${server.baseUrl}$route';

              try {
                // Speed optimization 3: Use Until.load instead of networkIdle
                // which avoids unnecessary 500ms idling delay per page.
                try {
                  await page.goto(
                    url,
                    wait: Until.load,
                    timeout: const Duration(seconds: 20),
                  );
                } catch (_) {}

                // Wait for any in-flight font or asset requests to finish.
                final fontDeadline = DateTime.now().add(
                  const Duration(milliseconds: 1000),
                );
                while (inFlightRequests > 0 &&
                    DateTime.now().isBefore(fontDeadline)) {
                  await Future<void>.delayed(const Duration(milliseconds: 20));
                }

                // Ensure local and icon fonts are rendered.
                if (!disableJavaScript) {
                  try {
                    await page.evaluate<Object?>(
                      '() => document.fonts ? document.fonts.ready : null',
                    );
                  } catch (_) {}
                } else {
                  // Settle delay for Chromium to decode and rasterize fonts.
                  await Future<void>.delayed(
                    const Duration(milliseconds: 80),
                  );
                }

                // Extract live HTML header metadata (title, canonical, meta).
                if (!capturedMetadata.containsKey(route)) {
                  if (buildDirectory != null) {
                    final htmlFile = SiteContentHashes.resolveRouteHtmlFile(
                      buildDirectory,
                      route,
                    );
                    if (htmlFile != null && htmlFile.existsSync()) {
                      try {
                        capturedMetadata[route] =
                            await extractHeaderMetadataFromFile(htmlFile);
                      } catch (_) {}
                    }
                  }
                  if (!capturedMetadata.containsKey(route) &&
                      !disableJavaScript) {
                    try {
                      final rawMeta = await page
                          .evaluate<Map<String, dynamic>?>(
                            puppeteerHeaderExtractionScript,
                          );
                      if (rawMeta != null) {
                        capturedMetadata[route] = HeaderMetadata.fromJson(
                          rawMeta,
                        );
                      }
                    } catch (_) {}
                  }
                }

                // Render next animation frame when JS is enabled.
                if (!disableJavaScript) {
                  try {
                    await page.evaluate<void>(
                      '() => new Promise(requestAnimationFrame)',
                    );
                  } catch (_) {}
                }

                final int captureHeight;
                if (maxHeight > 0) {
                  final metrics = await page.devTools.page.getLayoutMetrics();
                  final scrollHeight = metrics.cssContentSize.height.round();
                  captureHeight = min(scrollHeight, maxHeight);
                } else {
                  captureHeight = 0;
                }

                final bytes = await page.screenshot(
                  format: ScreenshotFormat.png,
                  fullPage: captureHeight <= 0,
                  clip: captureHeight > 0
                      ? Rectangle(0, 0, viewport.width, captureHeight)
                      : null,
                );
                await File(outputPath).writeAsBytes(bytes);
                capturedCount++;

                onSnapshotSaved?.call(filename);

                final progressStr = totalExpectedSnapshots != null
                    ? '$capturedCount/$totalExpectedSnapshots'
                    : '$capturedCount';
                log('  ✓ [$progressStr] Captured: $filename');
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
      await streamSub.cancel();
    } finally {
      await Future.wait(browsers.map((b) => b.close()));
    }

    // Persist content hashes to output directory to allow skipping next time.
    if (buildDirectory != null && currentRouteHashes.isNotEmpty) {
      try {
        final siteHashes = SiteContentHashes(
          globalAssetsHash: currentGlobalAssetsHash,
          routeHashes: currentRouteHashes,
        );
        siteHashes.saveToFile(
          File(path.join(outputDirectory.path, 'content_hashes.json')),
        );
      } catch (_) {}
    }

    // Persist all captured header metadata to metadata.json in output dir.
    if (capturedMetadata.isNotEmpty) {
      try {
        final metaFile = File(path.join(outputDirectory.path, 'metadata.json'));
        const encoder = JsonEncoder.withIndent('  ');
        final json = capturedMetadata.map((k, v) => MapEntry(k, v.toJson()));
        metaFile.writeAsStringSync(encoder.convert(json));
      } catch (_) {}
    }

    return (capturedCount: capturedCount, metadata: capturedMetadata);
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
