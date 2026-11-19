// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('VisualDiffServer', () {
    late Directory diffDir;
    late Directory webDir;
    late VisualDiffServer server;
    late HttpClient client;

    setUp(() async {
      diffDir = Directory.systemTemp.createTempSync('vd-server-diff-');
      webDir = Directory.systemTemp.createTempSync('vd-server-web-');

      // Create manifest
      final manifestFile = File(path.join(diffDir.path, 'diff_manifest.json'));
      final manifest = DiffManifest.fromEntries(
        site: 'docs',
        baseRef: 'main',
        entries: const [],
      );
      manifest.saveToFile(manifestFile);

      // Create dummy web assets
      File(path.join(webDir.path, 'index.html')).writeAsStringSync(
        '<!DOCTYPE html><html><body>Visual Diff App</body></html>',
      );
      File(path.join(webDir.path, 'app.js')).writeAsStringSync(
        'console.log("ready");',
      );

      server = await VisualDiffServer.start(
        visualDiffDirectory: diffDir,
        webAppDirectory: webDir,
      );
      client = HttpClient();
    });

    tearDown(() async {
      client.close();
      await server.close();
      if (diffDir.existsSync()) {
        diffDir.deleteSync(recursive: true);
      }
      if (webDir.existsSync()) {
        webDir.deleteSync(recursive: true);
      }
    });

    test('serves diff_manifest.json', () async {
      final req = await client.getUrl(
        Uri.parse('${server.url}/diff_manifest.json'),
      );
      final res = await req.close();
      expect(res.statusCode, equals(HttpStatus.ok));
      expect(res.headers.contentType?.mimeType, equals('application/json'));

      final body = await res.transform(utf8.decoder).join();
      final json = jsonDecode(body) as Map<String, dynamic>;
      expect(json['site'], equals('docs'));
    });

    test('serves web assets with proper content types', () async {
      final reqJs = await client.getUrl(Uri.parse('${server.url}/app.js'));
      final resJs = await reqJs.close();
      expect(resJs.statusCode, equals(HttpStatus.ok));
      expect(
        resJs.headers.contentType?.mimeType,
        equals('application/javascript'),
      );

      final reqHtml = await client.getUrl(Uri.parse('${server.url}/'));
      final resHtml = await reqHtml.close();
      expect(resHtml.statusCode, equals(HttpStatus.ok));
      expect(resHtml.headers.contentType?.mimeType, equals('text/html'));
    });

    test('returns 404 for nonexistent asset files', () async {
      final req = await client.getUrl(
        Uri.parse('${server.url}/missing.png'),
      );
      final res = await req.close();
      expect(res.statusCode, equals(HttpStatus.notFound));
    });

    test('updates route baseline and removes diff via API', () async {
      final baselineDir = Directory(
        path.join(diffDir.path, 'baseline'),
      )..createSync();
      final currentDir = Directory(
        path.join(diffDir.path, 'current'),
      )..createSync();
      final diffOutputDir = Directory(
        path.join(diffDir.path, 'diff'),
      )..createSync();

      // Route A (to be updated)
      File(
        path.join(baselineDir.path, 'a@desktop.png'),
      ).writeAsStringSync('old-a');
      File(
        path.join(currentDir.path, 'a@desktop.png'),
      ).writeAsStringSync('new-a');
      File(
        path.join(diffOutputDir.path, 'a@desktop.png'),
      ).writeAsStringSync('diff-a');

      // Route B (should remain unchanged)
      File(
        path.join(baselineDir.path, 'b@desktop.png'),
      ).writeAsStringSync('b');
      File(
        path.join(currentDir.path, 'b@desktop.png'),
      ).writeAsStringSync('b');

      final manifestFile = File(path.join(diffDir.path, 'diff_manifest.json'));
      final manifest = DiffManifest.fromEntries(
        site: 'docs',
        baseRef: 'main',
        entries: [
          const DiffEntry(
            id: 'a@desktop',
            route: '/a',
            viewport: 'desktop',
            filename: 'a@desktop.png',
            status: DiffStatus.changed,
            diffPercentage: 10.0,
            diffPixels: 100,
            totalPixels: 1000,
            width: 10,
            height: 10,
            baselineRelativePath: 'baseline/a@desktop.png',
            currentRelativePath: 'current/a@desktop.png',
            diffRelativePath: 'diff/a@desktop.png',
          ),
          const DiffEntry(
            id: 'b@desktop',
            route: '/b',
            viewport: 'desktop',
            filename: 'b@desktop.png',
            status: DiffStatus.unchanged,
            diffPercentage: 0.0,
            diffPixels: 0,
            totalPixels: 1000,
            width: 10,
            height: 10,
            baselineRelativePath: 'baseline/b@desktop.png',
            currentRelativePath: 'current/b@desktop.png',
          ),
        ],
      );
      manifest.saveToFile(manifestFile);

      // Call API to update /a
      final req = await client.postUrl(
        Uri.parse('${server.url}/api/update-baseline?route=/a'),
      );
      final res = await req.close();
      expect(res.statusCode, equals(HttpStatus.ok));

      // Verify baseline for /a was updated to match current
      expect(
        File(path.join(baselineDir.path, 'a@desktop.png')).readAsStringSync(),
        equals('new-a'),
      );
      // Verify diff file for /a was deleted
      expect(
        File(path.join(diffOutputDir.path, 'a@desktop.png')).existsSync(),
        isFalse,
      );
      // Verify /b was untouched
      expect(
        File(path.join(baselineDir.path, 'b@desktop.png')).readAsStringSync(),
        equals('b'),
      );
    });
  });
}
