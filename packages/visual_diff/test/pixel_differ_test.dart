// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('PixelDiffer', () {
    test('reports 0 diff for identical images', () {
      final img1 = img.Image(width: 50, height: 50);
      final img2 = img.Image(width: 50, height: 50);

      for (var y = 0; y < 50; y++) {
        for (var x = 0; x < 50; x++) {
          img1.setPixelRgba(x, y, 200, 200, 200, 255);
          img2.setPixelRgba(x, y, 200, 200, 200, 255);
        }
      }

      const differ = PixelDiffer();
      final result = differ.compare(img1, img2);

      expect(result.hasDiff, isFalse);
      expect(result.diffPixels, equals(0));
      expect(result.diffPercentage, equals(0.0));
      expect(result.diffImage, isNull);
      expect(result.boundingBox, isNull);
    });

    test('detects pixel differences and bounding box', () {
      final img1 = img.Image(width: 100, height: 100);
      final img2 = img.Image(width: 100, height: 100);

      // Fill both with white.
      img.fill(img1, color: img.ColorRgba8(255, 255, 255, 255));
      img.fill(img2, color: img.ColorRgba8(255, 255, 255, 255));

      // Draw a 10x10 black square in img2 at (20, 30).
      for (var y = 30; y < 40; y++) {
        for (var x = 20; x < 30; x++) {
          img2.setPixelRgba(x, y, 0, 0, 0, 255);
        }
      }

      const differ = PixelDiffer();
      final result = differ.compare(img1, img2);

      expect(result.hasDiff, isTrue);
      expect(result.diffPixels, equals(100));
      expect(result.totalPixels, equals(10000));
      expect(result.diffPercentage, equals(1.0));
      expect(result.diffImage, isNotNull);
      expect(result.boundingBox?.minX, equals(20));
      expect(result.boundingBox?.maxX, equals(29));
      expect(result.boundingBox?.minY, equals(30));
      expect(result.boundingBox?.maxY, equals(39));
    });

    test('handles dimension shifts gracefully', () {
      final img1 = img.Image(width: 50, height: 50);
      final img2 = img.Image(width: 50, height: 60); // 10 pixels taller

      img.fill(img1, color: img.ColorRgba8(255, 255, 255, 255));
      img.fill(img2, color: img.ColorRgba8(255, 255, 255, 255));

      const differ = PixelDiffer();
      final result = differ.compare(img1, img2);

      expect(result.hasDiff, isTrue);
      expect(result.diffPixels, equals(50 * 10)); // 500 extra pixels
      expect(result.totalPixels, equals(50 * 60)); // 3000
    });
  });

  group('parseSnapshotName', () {
    test('parses root desktop snapshot', () {
      final parsed = parseSnapshotName('__root__@desktop.png');
      expect(parsed.route, equals('/'));
      expect(parsed.viewport, equals('desktop'));
    });

    test('parses nested mobile snapshot', () {
      final parsed = parseSnapshotName('reference__flutter-cli@mobile.png');
      expect(parsed.route, equals('/reference/flutter-cli'));
      expect(parsed.viewport, equals('mobile'));
    });
  });

  group('BatchDiffer', () {
    test('classifies added, removed, changed, unchanged', () async {
      final tempDir = Directory.systemTemp.createTempSync('batch_diff_test_');
      addTearDown(() => tempDir.deleteSync(recursive: true));

      final baselineDir = Directory('${tempDir.path}/baseline')..createSync();
      final currentDir = Directory('${tempDir.path}/current')..createSync();
      final diffDir = Directory('${tempDir.path}/diff');
      final manifestFile = File('${tempDir.path}/manifest.json');

      final redImg = img.Image(width: 20, height: 20);
      img.fill(redImg, color: img.ColorRgba8(255, 0, 0, 255));
      final blueImg = img.Image(width: 20, height: 20);
      img.fill(blueImg, color: img.ColorRgba8(0, 0, 255, 255));

      // 1. unchanged@desktop.png
      File('${baselineDir.path}/unchanged@desktop.png')
          .writeAsBytesSync(img.encodePng(redImg));
      File('${currentDir.path}/unchanged@desktop.png')
          .writeAsBytesSync(img.encodePng(redImg));

      // 2. changed@desktop.png
      File('${baselineDir.path}/changed@desktop.png')
          .writeAsBytesSync(img.encodePng(redImg));
      File('${currentDir.path}/changed@desktop.png')
          .writeAsBytesSync(img.encodePng(blueImg));

      // 3. removed@desktop.png
      File('${baselineDir.path}/removed@desktop.png')
          .writeAsBytesSync(img.encodePng(redImg));

      // 4. added@desktop.png
      File('${currentDir.path}/added@desktop.png')
          .writeAsBytesSync(img.encodePng(blueImg));

      const batch = BatchDiffer();
      final manifest = await batch.run(
        baselineDir: baselineDir,
        currentDir: currentDir,
        diffOutputDir: diffDir,
        manifestFile: manifestFile,
        site: 'docs',
        baseRef: 'main',
        onProgress: (_) {},
      );

      expect(manifest.totalCount, equals(4));
      expect(manifest.changedCount, equals(1));
      expect(manifest.addedCount, equals(1));
      expect(manifest.removedCount, equals(1));
      expect(manifest.unchangedCount, equals(1));

      expect(manifestFile.existsSync(), isTrue);
      expect(File('${diffDir.path}/changed@desktop.png').existsSync(), isTrue);
    });

    test(
      'diffs only targeted routes and merges with existing manifest',
      () async {
        final tempDir = Directory.systemTemp.createTempSync('batch_targeted_');
        addTearDown(() => tempDir.deleteSync(recursive: true));

        final baselineDir = Directory('${tempDir.path}/baseline')..createSync();
        final currentDir = Directory('${tempDir.path}/current')..createSync();
        final diffDir = Directory('${tempDir.path}/diff');
        final manifestFile = File('${tempDir.path}/manifest.json');

        final redImg = img.Image(width: 10, height: 10);
        img.fill(redImg, color: img.ColorRgba8(255, 0, 0, 255));
        final blueImg = img.Image(width: 10, height: 10);
        img.fill(blueImg, color: img.ColorRgba8(0, 0, 255, 255));

        // Route 1: /ui/widgets
        File('${baselineDir.path}/ui__widgets@desktop.png')
            .writeAsBytesSync(img.encodePng(redImg));
        File('${currentDir.path}/ui__widgets@desktop.png')
            .writeAsBytesSync(img.encodePng(blueImg));

        // Route 2: /cookbook
        File('${baselineDir.path}/cookbook@desktop.png')
            .writeAsBytesSync(img.encodePng(redImg));
        File('${currentDir.path}/cookbook@desktop.png')
            .writeAsBytesSync(img.encodePng(redImg));

        const batch = BatchDiffer();

        // 1. Initial run across all routes.
        final initialManifest = await batch.run(
          baselineDir: baselineDir,
          currentDir: currentDir,
          diffOutputDir: diffDir,
          manifestFile: manifestFile,
          site: 'docs',
          baseRef: 'main',
          onProgress: (_) {},
        );

        expect(initialManifest.totalCount, equals(2));
        expect(initialManifest.changedCount, equals(1)); // /ui/widgets
        expect(initialManifest.unchangedCount, equals(1)); // /cookbook

        // Now update /ui/widgets in current to match baseline.
        File('${currentDir.path}/ui__widgets@desktop.png')
            .writeAsBytesSync(img.encodePng(redImg));

        final progressLogs = <String>[];

        // 2. Targeted run for ONLY /ui/widgets.
        final targetedManifest = await batch.run(
          baselineDir: baselineDir,
          currentDir: currentDir,
          diffOutputDir: diffDir,
          manifestFile: manifestFile,
          site: 'docs',
          baseRef: 'main',
          targetRoutes: {'/ui/widgets'},
          onProgress: progressLogs.add,
        );

        // Should only compare 1 snapshot.
        expect(
          progressLogs.any((l) => l.contains('Comparing 1 snapshots')),
          isTrue,
        );
        // /cookbook should NOT have been diffed.
        expect(
          progressLogs.any((l) => l.contains('cookbook')),
          isFalse,
        );

        // Merged manifest still contains both routes, but /ui/widgets is now unchanged!
        expect(targetedManifest.totalCount, equals(2));
        expect(targetedManifest.changedCount, equals(0));
        expect(targetedManifest.unchangedCount, equals(2));

        // The old diff image for /ui/widgets should be deleted.
        expect(
          File('${diffDir.path}/ui__widgets@desktop.png').existsSync(),
          isFalse,
        );
      },
    );

    test(
      'tracks and diffs header metadata between baseline and current',
      () async {
        final tempDir = Directory.systemTemp.createTempSync('batch_meta_test_');
        addTearDown(() => tempDir.deleteSync(recursive: true));

        final baselineDir = Directory('${tempDir.path}/baseline')..createSync();
        final currentDir = Directory('${tempDir.path}/current')..createSync();
        final diffDir = Directory('${tempDir.path}/diff');
        final manifestFile = File('${tempDir.path}/manifest.json');

        final redImg = img.Image(width: 10, height: 10);
        img.fill(redImg, color: img.ColorRgba8(255, 0, 0, 255));

        File('${baselineDir.path}/ui__widgets@desktop.png')
            .writeAsBytesSync(img.encodePng(redImg));
        File('${currentDir.path}/ui__widgets@desktop.png')
            .writeAsBytesSync(img.encodePng(redImg));

        const batch = BatchDiffer();
        final manifest = await batch.run(
          baselineDir: baselineDir,
          currentDir: currentDir,
          diffOutputDir: diffDir,
          manifestFile: manifestFile,
          site: 'docs',
          baseRef: 'main',
          baselineMetadata: {
            '/ui/widgets': const HeaderMetadata(
              title: 'Old Title',
              meta: {'description': 'Old Description'},
            ),
          },
          currentMetadata: {
            '/ui/widgets': const HeaderMetadata(
              title: 'New Title',
              meta: {'description': 'New Description'},
            ),
          },
          onProgress: (_) {},
        );

        // Screenshot is identical, but metadata changed!
        expect(manifest.changedCount, equals(0));
        expect(manifest.unchangedCount, equals(1));
        expect(manifest.metadataChangedCount, equals(1));
        expect(manifest.hasDiff, isTrue);

        final entry = manifest.entries.first;
        expect(entry.hasHeaderDiff, isTrue);
        expect(entry.headerDiff?.titleChanged, isTrue);
        expect(entry.headerDiff?.baselineTitle, equals('Old Title'));
        expect(entry.headerDiff?.currentTitle, equals('New Title'));
        expect(
          entry.headerDiff?.metaChanges['description']?.type,
          equals(HeaderPropertyChangeType.modified),
        );
      },
    );

    test(
      'tracks and diffs header metadata between baseline and current',
      () async {
        final tempDir = Directory.systemTemp.createTempSync('batch_meta_test_');
        addTearDown(() => tempDir.deleteSync(recursive: true));

        final baselineDir = Directory('${tempDir.path}/baseline')..createSync();
        final currentDir = Directory('${tempDir.path}/current')..createSync();
        final diffDir = Directory('${tempDir.path}/diff');
        final manifestFile = File('${tempDir.path}/manifest.json');

        final redImg = img.Image(width: 10, height: 10);
        img.fill(redImg, color: img.ColorRgba8(255, 0, 0, 255));

        File('${baselineDir.path}/ui__widgets@desktop.png')
            .writeAsBytesSync(img.encodePng(redImg));
        File('${currentDir.path}/ui__widgets@desktop.png')
            .writeAsBytesSync(img.encodePng(redImg));

        const batch = BatchDiffer();
        final manifest = await batch.run(
          baselineDir: baselineDir,
          currentDir: currentDir,
          diffOutputDir: diffDir,
          manifestFile: manifestFile,
          site: 'docs',
          baseRef: 'main',
          baselineMetadata: {
            '/ui/widgets': const HeaderMetadata(
              title: 'Old Title',
              meta: {'description': 'Old Description'},
            ),
          },
          currentMetadata: {
            '/ui/widgets': const HeaderMetadata(
              title: 'New Title',
              meta: {'description': 'New Description'},
            ),
          },
          onProgress: (_) {},
        );

        // Screenshot is identical, but metadata changed!
        expect(manifest.changedCount, equals(0));
        expect(manifest.unchangedCount, equals(1));
        expect(manifest.metadataChangedCount, equals(1));
        expect(manifest.hasDiff, isTrue);

        final entry = manifest.entries.first;
        expect(entry.hasHeaderDiff, isTrue);
        expect(entry.headerDiff?.titleChanged, isTrue);
        expect(entry.headerDiff?.baselineTitle, equals('Old Title'));
        expect(entry.headerDiff?.currentTitle, equals('New Title'));
        expect(
          entry.headerDiff?.metaChanges['description']?.type,
          equals(HeaderPropertyChangeType.modified),
        );
      },
    );
  });
}
