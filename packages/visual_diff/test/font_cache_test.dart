// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('FontCache', () {
    late Directory tempDir;
    late HttpServer server;
    var serverRequestCount = 0;

    setUp(() async {
      tempDir = Directory.systemTemp.createTempSync('font-cache-test-');
      serverRequestCount = 0;
      server = await HttpServer.bind('localhost', 0);
      server.listen((HttpRequest request) async {
        serverRequestCount++;
        final path = request.uri.path;
        if (path == '/font.css') {
          request.response.headers.contentType = ContentType('text', 'css');
          request.response.write(
            '@font-face { src: url(https://fonts.gstatic.com/test.woff2); }',
          );
          await request.response.close();
        } else {
          request.response.headers.contentType = ContentType('font', 'woff2');
          request.response.write('WOFF2_BYTES');
          await request.response.close();
        }
      });
    });

    tearDown(() async {
      await server.close(force: true);
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('isFontUrl identifies Google Fonts and gstatic endpoints', () {
      expect(
        FontCache.isFontUrl('https://fonts.googleapis.com/css2?family=Roboto'),
        isTrue,
      );
      expect(
        FontCache.isFontUrl(
          'https://fonts.gstatic.com/s/materialsymbols.woff2',
        ),
        isTrue,
      );
      expect(
        FontCache.isFontUrl('https://ssl.gstatic.com/font.woff2'),
        isTrue,
      );
      expect(FontCache.isFontUrl('http://localhost:8080/font.css'), isFalse);
      expect(FontCache.isFontUrl('https://example.com/styles.css'), isFalse);
    });

    test(
      'caches responses in memory and avoids redundant HTTP calls',
      () async {
        final cache = FontCache(cacheDirectory: tempDir);
        final testUrl = 'http://localhost:${server.port}/font.css';

        final res1 = await cache.getOrFetch(testUrl);
        expect(res1, isNotNull);
        expect(res1!.status, equals(200));
        expect(
          utf8.decode(res1.bodyBytes),
          contains('@font-face'),
        );
        expect(serverRequestCount, equals(1));

        // Second fetch should be served from memory cache.
        final res2 = await cache.getOrFetch(testUrl);
        expect(res2, isNotNull);
        expect(res2!.bodyBytes, equals(res1.bodyBytes));
        expect(serverRequestCount, equals(1));

        cache.close();
      },
    );

    test('persists responses to disk and reloads on new instance', () async {
      final testUrl = 'http://localhost:${server.port}/font.css';

      final cache1 = FontCache(cacheDirectory: tempDir);
      await cache1.getOrFetch(testUrl);
      expect(serverRequestCount, equals(1));
      cache1.close();

      // New cache instance without in-memory items should load from disk.
      final cache2 = FontCache(cacheDirectory: tempDir);
      final res = await cache2.getOrFetch(testUrl);
      expect(res, isNotNull);
      expect(
        utf8.decode(res!.bodyBytes),
        contains('@font-face'),
      );
      // Server request count must remain 1 (served from disk).
      expect(serverRequestCount, equals(1));
      cache2.close();
    });

    test('deduplicates concurrent in-flight requests', () async {
      final cache = FontCache(cacheDirectory: tempDir);
      final testUrl = 'http://localhost:${server.port}/font.css';

      final results = await Future.wait([
        cache.getOrFetch(testUrl),
        cache.getOrFetch(testUrl),
        cache.getOrFetch(testUrl),
      ]);

      expect(results.length, equals(3));
      for (final res in results) {
        expect(res, isNotNull);
        expect(res!.status, equals(200));
      }
      expect(serverRequestCount, equals(1));
      cache.close();
    });
  });
}
