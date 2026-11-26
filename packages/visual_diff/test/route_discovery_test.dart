// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('Route discovery', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('route-discovery-test-');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('discovers routes across hierarchy', () {
      File(path.join(tempDir.path, 'index.html')).createSync(recursive: true);
      File(path.join(tempDir.path, 'cookbook', 'index.html'))
          .createSync(recursive: true);
      File(path.join(tempDir.path, 'cookbook', 'effects', 'drag.html'))
          .createSync(recursive: true);
      File(path.join(tempDir.path, '404.html')).createSync(recursive: true);

      // Non-html files should be ignored
      File(path.join(tempDir.path, 'styles.css')).createSync(recursive: true);
      File(path.join(tempDir.path, '.hidden', 'index.html'))
          .createSync(recursive: true);

      final routes = discoverRoutes(tempDir);
      expect(
        routes,
        equals(['/', '/404', '/cookbook', '/cookbook/effects/drag']),
      );
    });

    test('respects explicit routes', () {
      final routes = discoverRoutes(
        tempDir,
        explicitRoutes: ['cookbook', '/ui/design/', 'docs'],
      );
      expect(routes, equals(['/cookbook', '/docs', '/ui/design']));
    });

    test('applies regex filter', () {
      File(path.join(tempDir.path, 'index.html')).createSync(recursive: true);
      File(path.join(tempDir.path, 'cookbook', 'index.html'))
          .createSync(recursive: true);
      File(path.join(tempDir.path, 'ui', 'index.html'))
          .createSync(recursive: true);

      final routes = discoverRoutes(
        tempDir,
        filter: RegExp(r'^/(cookbook|ui)'),
      );
      expect(routes, equals(['/cookbook', '/ui']));
    });

    test('applies route limit', () {
      File(path.join(tempDir.path, 'a.html')).createSync(recursive: true);
      File(path.join(tempDir.path, 'b.html')).createSync(recursive: true);
      File(path.join(tempDir.path, 'c.html')).createSync(recursive: true);

      final routes = discoverRoutes(tempDir, limit: 2);
      expect(routes.length, equals(2));
      expect(routes, equals(['/a', '/b']));
    });

    test(
      'applies visual_diff config rules while preserving changedHtmlRoutes',
      () {
        File(path.join(tempDir.path, 'blog', 'post-1', 'index.html'))
            .createSync(recursive: true);
        File(path.join(tempDir.path, 'blog', 'post-2', 'index.html'))
            .createSync(recursive: true);
        File(path.join(tempDir.path, 'blog', 'post-3', 'index.html'))
            .createSync(recursive: true);
        File(path.join(tempDir.path, 'docs', 'intro.html'))
            .createSync(recursive: true);

        final config = VisualDiffConfig(
          routeRules: [
            RouteRule(
              pattern: '/blog/*',
              limit: 1,
              sort: RouteSortOrder.descending,
            ),
          ],
        );

        // Without changed routes: only post-3 (newest/descending) + docs/intro
        final sampled = discoverRoutes(tempDir, config: config);
        expect(sampled, equals(['/blog/post-3', '/docs/intro']));

        // With changed post-1: post-3 (sampled) + post-1 (changed) + docs/intro
        final withChanged = discoverRoutes(
          tempDir,
          config: config,
          changedHtmlRoutes: {'/blog/post-1'},
        );
        expect(
          withChanged,
          equals(['/blog/post-1', '/blog/post-3', '/docs/intro']),
        );
      },
    );
  });

  group('snapshotFileName', () {
    test('formats root route safely', () {
      expect(snapshotFileName('/', 'desktop'), equals('__root__@desktop.png'));
    });

    test('formats nested routes safely', () {
      expect(
        snapshotFileName('/cookbook/effects/drag', 'mobile'),
        equals('cookbook__effects__drag@mobile.png'),
      );
      expect(
        snapshotFileName('ui/design/', 'desktop'),
        equals('ui__design@desktop.png'),
      );
    });
  });
}
