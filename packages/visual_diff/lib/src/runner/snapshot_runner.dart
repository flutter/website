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
import 'font_cache.dart';
import 'header_extractor.dart';
import 'route_discovery.dart';
import 'snapshot_backend.dart';
import 'snapshot_server.dart';
import 'snapshot_viewport.dart';

/// Captures screenshots of site routes using headless Chromium or Obscura.
final class SnapshotRunner {
  final SnapshotBackend backend;
  final String? customChromePath;
  final String? customObscuraPath;
  final int concurrency;
  final bool hideCookieBanner;
  final int maxHeight;
  final bool disableJavaScript;
  final FontCache fontCache;

  SnapshotRunner({
    this.backend = SnapshotBackend.chrome,
    this.customChromePath,
    this.customObscuraPath,
    this.concurrency = 6,
    this.hideCookieBanner = true,
    this.maxHeight = 4500,
    this.disableJavaScript = true,
    FontCache? fontCache,
    Directory? fontCacheDirectory,
  }) : fontCache =
           fontCache ??
           FontCache(
             cacheDirectory:
                 fontCacheDirectory ?? FontCache.defaultCacheDirectory(),
           );

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

    if (backend == SnapshotBackend.obscura) {
      return await _captureEagerSnapshotsWithObscura(
        server: server,
        routeStream: routeStream,
        expectedTotalRoutes: expectedTotalRoutes,
        outputDirectory: outputDirectory,
        viewports: viewports,
        buildDirectory: buildDirectory,
        baselineDirectory: baselineDirectory,
        baselineHashes: baselineHashes,
        baselineMetadata: baselineMetadata,
        onProgress: onProgress,
        onSnapshotSaved: onSnapshotSaved,
      );
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

    // Pre-warm font cache concurrently while Chromium instances launch.
    final prewarmFuture = fontCache.prewarm();
    final browsersFuture = Future.wait(
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
            '--force-color-profile=srgb',
            '--font-render-hinting=none',
            '--disable-features=Translate,BackForwardCache,MediaRouter',
            if (disableJavaScript) '--disable-javascript',
          ],
        ),
      ),
    );

    final browsers = await browsersFuture;
    await prewarmFuture;

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
              final hash = SiteContentHashes.tryComputeFileHash(htmlFile);
              if (hash != null) {
                currentRouteHashes[route] = hash;

                if (effectiveBaselineHashes.routeHashes[route] == hash) {
                  var allBaselineSnapshotsExist = true;
                  for (final vp in viewports) {
                    final filename = snapshotFileName(route, vp.name);
                    final src = File(
                      path.join(baselineDirectory.path, filename),
                    );
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
            }
          } else if (buildDirectory != null) {
            final htmlFile = SiteContentHashes.resolveRouteHtmlFile(
              buildDirectory,
              route,
            );
            if (htmlFile != null && htmlFile.existsSync()) {
              final hash = SiteContentHashes.tryComputeFileHash(htmlFile);
              if (hash != null) {
                currentRouteHashes[route] = hash;
              }
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
            page.defaultNavigationTimeout = const Duration(seconds: 15);
            page.defaultTimeout = const Duration(seconds: 15);

            if (disableJavaScript) {
              await page.setJavaScriptEnabled(false);
            }

            // Speed optimization 1: Abort all external third-party requests
            // (e.g. analytics, tracking, ads). Fonts are intercepted and
            // served locally from the FontCache in 0ms without network calls.
            // Domain redirects to production site URLs are rewritten to local.
            var inFlightRequests = 0;
            await page.setRequestInterception(true);
            page.onRequest.listen((request) async {
              try {
                final uri = Uri.tryParse(request.url);
                final host = uri?.host.toLowerCase() ?? '';
                if (uri != null &&
                    (host == 'localhost' ||
                        host == '127.0.0.1' ||
                        uri.scheme == 'data')) {
                  await request.continueRequest();
                } else if (host == 'dart.dev' ||
                    host == 'www.dart.dev' ||
                    host == 'flutter.dev' ||
                    host == 'docs.flutter.dev') {
                  final queryStr = uri != null && uri.hasQuery
                      ? '?${uri.query}'
                      : '';
                  final localUrl =
                      '${server.baseUrl}${uri?.path ?? ''}$queryStr';
                  await request.continueRequest(url: localUrl);
                } else if (FontCache.isFontUrl(request.url)) {
                  inFlightRequests++;
                  try {
                    final cached = await fontCache.getOrFetch(
                      request.url,
                      requestHeaders: request.headers,
                    );
                    if (cached != null) {
                      await request.respond(
                        status: cached.status,
                        contentType: cached.contentType,
                        headers: cached.headers,
                        body: cached.bodyBytes,
                      );
                    } else {
                      await request.continueRequest();
                    }
                  } catch (_) {
                    try {
                      await request.abort();
                    } catch (_) {}
                  } finally {
                    if (inFlightRequests > 0) inFlightRequests--;
                  }
                } else if (request.frame != null &&
                    request.frame != page.mainFrame) {
                  // For subframes/iframes, respond with empty HTML rather than
                  // aborting so Chrome's frame lifecycle watcher does not hang
                  // waiting for an aborted frame's load event.
                  await request.respond(
                    status: HttpStatus.ok,
                    contentType: 'text/html',
                    body: '<!DOCTYPE html><html><body></body></html>',
                  );
                } else {
                  await request.abort();
                }
              } catch (_) {
                try {
                  await request.abort();
                } catch (_) {}
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

              try {
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

                // Speed optimization 3: Use Until.load instead of networkIdle
                // which avoids unnecessary 500ms idling delay per page.
                try {
                  await page.goto(
                    url,
                    wait: Until.load,
                    timeout: const Duration(seconds: 15),
                  );
                } catch (_) {}

                // If an unexpected font URL was missed during prewarming,
                // wait briefly for its in-flight fetch to complete.
                if (inFlightRequests > 0) {
                  final fontDeadline = DateTime.now().add(
                    const Duration(milliseconds: 500),
                  );
                  while (inFlightRequests > 0 &&
                      DateTime.now().isBefore(fontDeadline)) {
                    await Future<void>.delayed(
                      const Duration(milliseconds: 10),
                    );
                  }
                }

                // Ensure local and icon fonts are rendered.
                if (!disableJavaScript) {
                  try {
                    await page.evaluate<Object?>(
                      '() => document.fonts ? document.fonts.ready : null',
                    );
                  } catch (_) {}
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
      fontCache.close();
    }

    _persistHashesAndMetadata(
      outputDirectory: outputDirectory,
      buildDirectory: buildDirectory,
      currentRouteHashes: currentRouteHashes,
      currentGlobalAssetsHash: currentGlobalAssetsHash,
      capturedMetadata: capturedMetadata,
    );

    return (capturedCount: capturedCount, metadata: capturedMetadata);
  }

  /// Concurrently captures snapshots using the lightweight Obscura engine.
  Future<({int capturedCount, Map<String, HeaderMetadata> metadata})>
  _captureEagerSnapshotsWithObscura({
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
    final obscuraBin = customObscuraPath ?? 'obscura';

    try {
      final check = await Process.run(obscuraBin, ['--version']);
      if (check.exitCode != 0) {
        throw ProcessException(
          obscuraBin,
          ['--version'],
          'Exit code ${check.exitCode}',
        );
      }
      log('🌐 Using Obscura engine: ${check.stdout.toString().trim()}');
    } catch (e) {
      stderr.writeln(
        'Error: Could not execute Obscura ($obscuraBin).\n'
        'Install it via "brew install obscura" or pass '
        '--renderer-path=<path>.\n'
        'Details: $e',
      );
      return (capturedCount: 0, metadata: <String, HeaderMetadata>{});
    }

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
    final taskQueue = Queue<({String route, SnapshotViewport viewport})>();
    var streamCompleted = false;
    final completer = Completer<void>();

    try {
      final workerCount = concurrency.clamp(1, 16);
      final workers = <Future<void>>[];

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
              final hash = SiteContentHashes.tryComputeFileHash(htmlFile);
              if (hash != null) {
                currentRouteHashes[route] = hash;

                if (effectiveBaselineHashes.routeHashes[route] == hash) {
                  var allBaselineSnapshotsExist = true;
                  for (final vp in viewports) {
                    final filename = snapshotFileName(route, vp.name);
                    final src = File(
                      path.join(baselineDirectory.path, filename),
                    );
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
            }
          } else if (buildDirectory != null) {
            final htmlFile = SiteContentHashes.resolveRouteHtmlFile(
              buildDirectory,
              route,
            );
            if (htmlFile != null && htmlFile.existsSync()) {
              final hash = SiteContentHashes.tryComputeFileHash(htmlFile);
              if (hash != null) {
                currentRouteHashes[route] = hash;
              }
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
          if (taskQueue.isEmpty && !completer.isCompleted) completer.complete();
        },
        onError: (Object e) {
          streamCompleted = true;
          if (!completer.isCompleted) completer.complete();
        },
      );

      for (var workerIndex = 0; workerIndex < workerCount; workerIndex++) {
        workers.add(() async {
          while (!streamCompleted || taskQueue.isNotEmpty) {
            if (taskQueue.isEmpty) {
              if (streamCompleted) break;
              await Future<void>.delayed(const Duration(milliseconds: 25));
              continue;
            }

            final task = taskQueue.removeFirst();
            final route = task.route;
            final viewport = task.viewport;

            try {
              final filename = snapshotFileName(route, viewport.name);
              final outputPath = path.join(outputDirectory.path, filename);
              final url = '${server.baseUrl}$route';

              final env = {
                'OBSCURA_ALLOW_PRIVATE_NETWORK': '1',
                'OBSCURA_SHOT_W': '${viewport.width}',
                'OBSCURA_SHOT_H': '$maxHeight',
              };

              final proc = await Process.run(
                obscuraBin,
                [
                  '--allow-private-network',
                  'fetch',
                  url,
                  '--wait-until=domcontentloaded',
                  '--wait=0',
                  '--screenshot=$outputPath',
                ],
                environment: env,
              );

              if (proc.exitCode != 0) {
                throw ProcessException(
                  obscuraBin,
                  [],
                  proc.stderr.toString(),
                );
              }

              if (!capturedMetadata.containsKey(route) &&
                  buildDirectory != null) {
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
        }());
      }

      await Future.wait(workers);
      await streamSub.cancel();
    } finally {
      // Obscura worker cleanup
    }

    _persistHashesAndMetadata(
      outputDirectory: outputDirectory,
      buildDirectory: buildDirectory,
      currentRouteHashes: currentRouteHashes,
      currentGlobalAssetsHash: currentGlobalAssetsHash,
      capturedMetadata: capturedMetadata,
    );

    return (capturedCount: capturedCount, metadata: capturedMetadata);
  }

  static void _persistHashesAndMetadata({
    required Directory outputDirectory,
    required Directory? buildDirectory,
    required Map<String, String> currentRouteHashes,
    required String currentGlobalAssetsHash,
    required Map<String, HeaderMetadata> capturedMetadata,
  }) {
    // Persist content hashes to output directory to allow skipping next time.
    if (buildDirectory != null && currentRouteHashes.isNotEmpty) {
      try {
        final hashesFile = File(
          path.join(outputDirectory.path, 'content_hashes.json'),
        );
        final existing = SiteContentHashes.loadFromFile(hashesFile);
        final mergedRouteHashes = <String, String>{
          if (existing != null) ...existing.routeHashes,
          ...currentRouteHashes,
        };
        final siteHashes = SiteContentHashes(
          globalAssetsHash: currentGlobalAssetsHash,
          routeHashes: mergedRouteHashes,
        );
        siteHashes.saveToFile(hashesFile);
      } catch (_) {}
    }

    // Persist all captured header metadata to metadata.json in output dir.
    if (capturedMetadata.isNotEmpty) {
      try {
        final metaFile = File(path.join(outputDirectory.path, 'metadata.json'));
        final mergedMeta = <String, dynamic>{};
        if (metaFile.existsSync()) {
          try {
            final existingJson = jsonDecode(
              metaFile.readAsStringSync(),
            ) as Map<String, dynamic>;
            mergedMeta.addAll(existingJson);
          } catch (_) {}
        }
        for (final entry in capturedMetadata.entries) {
          mergedMeta[entry.key] = entry.value.toJson();
        }
        const encoder = JsonEncoder.withIndent('  ');
        metaFile.writeAsStringSync(encoder.convert(mergedMeta));
      } catch (_) {}
    }
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
