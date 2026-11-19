// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('SnapshotServer', () {
    late Directory tempDir;
    late SnapshotServer server;
    late HttpClient client;

    setUp(() async {
      tempDir = Directory.systemTemp.createTempSync('snapshot-server-test-');

      File(path.join(tempDir.path, 'index.html'))
          .writeAsStringSync('<!DOCTYPE html><html><body>Root</body></html>');
      File(path.join(tempDir.path, 'cookbook', 'index.html'))
          .createSync(recursive: true);
      File(
        path.join(tempDir.path, 'cookbook', 'index.html'),
      ).writeAsStringSync('<!DOCTYPE html><html><body>Cookbook</body></html>');
      File(
        path.join(tempDir.path, 'clean.html'),
      ).writeAsStringSync('<!DOCTYPE html><html><body>Clean URL</body></html>');
      File(path.join(tempDir.path, 'styles.css'))
          .writeAsStringSync('body { color: red; }');
      File(path.join(tempDir.path, 'data.json')).writeAsStringSync('{"a": 1}');
      File(path.join(tempDir.path, '404.html')).writeAsStringSync(
        '<!DOCTYPE html><html><body>Custom 404</body></html>',
      );

      server = await SnapshotServer.start(tempDir);
      client = HttpClient();
    });

    tearDown(() async {
      client.close();
      await server.close();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('serves root index.html', () async {
      final req = await client.getUrl(Uri.parse('${server.baseUrl}/'));
      final res = await req.close();
      expect(res.statusCode, equals(HttpStatus.ok));
      expect(res.headers.contentType?.mimeType, equals('text/html'));
    });

    test('serves subdirectory index.html', () async {
      final req = await client.getUrl(Uri.parse('${server.baseUrl}/cookbook'));
      final res = await req.close();
      expect(res.statusCode, equals(HttpStatus.ok));
      expect(res.headers.contentType?.mimeType, equals('text/html'));
    });

    test('serves clean URLs without extension', () async {
      final req = await client.getUrl(Uri.parse('${server.baseUrl}/clean'));
      final res = await req.close();
      expect(res.statusCode, equals(HttpStatus.ok));
      expect(res.headers.contentType?.mimeType, equals('text/html'));
    });

    test('serves static assets with appropriate MIME types', () async {
      final req1 = await client.getUrl(
        Uri.parse('${server.baseUrl}/styles.css'),
      );
      final res1 = await req1.close();
      expect(res1.statusCode, equals(HttpStatus.ok));
      expect(res1.headers.contentType?.mimeType, equals('text/css'));

      final req2 = await client.getUrl(
        Uri.parse('${server.baseUrl}/data.json'),
      );
      final res2 = await req2.close();
      expect(res2.statusCode, equals(HttpStatus.ok));
      expect(res2.headers.contentType?.mimeType, equals('application/json'));
    });

    test('serves custom 404.html on missing routes', () async {
      final req = await client.getUrl(
        Uri.parse('${server.baseUrl}/missing-page'),
      );
      final res = await req.close();
      expect(res.statusCode, equals(HttpStatus.notFound));
      expect(res.headers.contentType?.mimeType, equals('text/html'));
    });
  });
}
