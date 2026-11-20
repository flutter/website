// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('SiteContentHashes', () {
    late Directory tempDir;
    late Directory buildDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('content_hasher_test_');
      buildDir = Directory(path.join(tempDir.path, 'build'))..createSync();

      // Create dummy global assets
      File(path.join(buildDir.path, 'styles.css')).writeAsStringSync(
        'body { margin: 0; }',
      );
      File(path.join(buildDir.path, 'main.js')).writeAsStringSync(
        'console.log("hello");',
      );

      // Create dummy routes
      File(path.join(buildDir.path, 'index.html')).writeAsStringSync(
        '<html><body><h1>Home</h1></body></html>',
      );
      final cookbookDir = Directory(path.join(buildDir.path, 'cookbook'))
        ..createSync();
      File(path.join(cookbookDir.path, 'index.html')).writeAsStringSync(
        '<html><body><h1>Cookbook</h1></body></html>',
      );
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('computes deterministic global assets hash from CSS and JS', () {
      final hash1 = SiteContentHashes.computeGlobalAssetsHash(buildDir);
      final hash2 = SiteContentHashes.computeGlobalAssetsHash(buildDir);
      expect(hash1, isNotEmpty);
      expect(hash1, equals(hash2));

      // Altering CSS changes global assets hash
      File(path.join(buildDir.path, 'styles.css')).writeAsStringSync(
        'body { margin: 8px; }',
      );
      final hash3 = SiteContentHashes.computeGlobalAssetsHash(buildDir);
      expect(hash3, isNot(equals(hash1)));
    });

    test('resolves route HTML files correctly', () {
      final rootFile = SiteContentHashes.resolveRouteHtmlFile(buildDir, '/');
      expect(rootFile, isNotNull);
      expect(rootFile!.path, endsWith('index.html'));

      final cookbookFile = SiteContentHashes.resolveRouteHtmlFile(
        buildDir,
        '/cookbook',
      );
      expect(cookbookFile, isNotNull);
      expect(cookbookFile!.path, endsWith(path.join('cookbook', 'index.html')));

      final nonexistent = SiteContentHashes.resolveRouteHtmlFile(
        buildDir,
        '/nonexistent',
      );
      expect(nonexistent, isNull);
    });

    test('computes site hashes across routes and serializes to JSON', () {
      final hashes = SiteContentHashes.compute(
        buildDir: buildDir,
        routes: ['/', '/cookbook'],
      );

      expect(hashes.globalAssetsHash, isNotEmpty);
      expect(hashes.routeHashes.containsKey('/'), isTrue);
      expect(hashes.routeHashes.containsKey('/cookbook'), isTrue);

      final file = File(path.join(tempDir.path, 'hashes.json'));
      hashes.saveToFile(file);
      expect(file.existsSync(), isTrue);

      final loaded = SiteContentHashes.loadFromFile(file);
      expect(loaded, isNotNull);
      expect(loaded!.globalAssetsHash, equals(hashes.globalAssetsHash));
      expect(loaded.routeHashes['/'], equals(hashes.routeHashes['/']));
      expect(
        loaded.routeHashes['/cookbook'],
        equals(hashes.routeHashes['/cookbook']),
      );
    });
  });
}
