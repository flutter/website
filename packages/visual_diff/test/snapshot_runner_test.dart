// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('SnapshotRunner', () {
    late Directory buildDir;
    late Directory outputDir;
    late SnapshotServer server;

    setUp(() async {
      buildDir = Directory.systemTemp.createTempSync('snapshot-runner-build-');
      outputDir = Directory.systemTemp.createTempSync('snapshot-runner-out-');

      File(path.join(buildDir.path, 'index.html')).writeAsStringSync(
        '<!DOCTYPE html><html><head><title>Visual Diff Test</title></head>'
        '<body style="background: cornflowerblue; color: white;">'
        '<h1>Visual Diff Unit Test</h1>'
        '</body></html>',
      );

      server = await SnapshotServer.start(buildDir);
    });

    tearDown(() async {
      await server.close();
      if (buildDir.existsSync()) {
        buildDir.deleteSync(recursive: true);
      }
      if (outputDir.existsSync()) {
        outputDir.deleteSync(recursive: true);
      }
    });

    test('captures full-page screenshots for all viewports', () async {
      final runner = SnapshotRunner(concurrency: 1);
      final capturedCount = await runner.captureSnapshots(
        server: server,
        routes: ['/'],
        outputDirectory: outputDir,
        viewports: SnapshotViewport.all,
      );

      expect(capturedCount, equals(2));

      final desktopSnapshot = File(
        path.join(outputDir.path, '__root__@desktop.png'),
      );
      final mobileSnapshot = File(
        path.join(outputDir.path, '__root__@mobile.png'),
      );

      expect(desktopSnapshot.existsSync(), isTrue);
      expect(mobileSnapshot.existsSync(), isTrue);
      expect(desktopSnapshot.lengthSync(), greaterThan(100));
      expect(mobileSnapshot.lengthSync(), greaterThan(100));
    });

    test(
      'skips unchanged routes when HTML and global assets match baseline',
      () async {
        final runner = SnapshotRunner(concurrency: 1);

        // 1. Capture baseline with buildDirectory
        final baselineDir = Directory.systemTemp.createTempSync(
          'snapshot-runner-baseline-',
        );
        try {
          await runner.captureSnapshots(
            server: server,
            routes: ['/'],
            outputDirectory: baselineDir,
            viewports: SnapshotViewport.all,
            buildDirectory: buildDir,
          );

          final baselineHashes = File(
            path.join(baselineDir.path, 'content_hashes.json'),
          );
          expect(baselineHashes.existsSync(), isTrue);

          // 2. Capture current with baseline provided: should reuse baseline
          var loggedReused = false;
          final currentCount = await runner.captureSnapshots(
            server: server,
            routes: ['/'],
            outputDirectory: outputDir,
            viewports: SnapshotViewport.all,
            buildDirectory: buildDir,
            baselineDirectory: baselineDir,
            onProgress: (msg) {
              if (msg.contains('Reused baseline')) {
                loggedReused = true;
              }
            },
          );

          expect(currentCount, equals(2));
          expect(loggedReused, isTrue);

          final desktopSnapshot = File(
            path.join(outputDir.path, '__root__@desktop.png'),
          );
          expect(desktopSnapshot.existsSync(), isTrue);
        } finally {
          if (baselineDir.existsSync()) {
            baselineDir.deleteSync(recursive: true);
          }
        }
      },
    );
  });
}
