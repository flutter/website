// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('VisualDiffConfig', () {
    test('filters and limits routes matching rules', () {
      final yaml = loadYaml('''
routes:
  - pattern: "/tools/diagnostics/*"
    limit: 2
    sort: ascending
  - pattern: "/blog/*"
    limit: 2
    sort: descending
exclude:
  - "/archive/*"
include:
  - "/important"
''') as YamlMap;

      final config = VisualDiffConfig.fromYaml(yaml);

      final allRoutes = [
        '/',
        '/important',
        '/archive/old-post',
        '/tools/diagnostics/b_rule',
        '/tools/diagnostics/a_rule',
        '/tools/diagnostics/c_rule',
        '/blog/post-1',
        '/blog/post-2',
        '/blog/post-3',
        '/docs/get-started',
      ];

      final filtered = config.filterRoutes(allRoutes: allRoutes);

      expect(filtered, contains('/'));
      expect(filtered, contains('/important'));
      expect(filtered, contains('/docs/get-started'));
      // Excluded:
      expect(filtered, isNot(contains('/archive/old-post')));
      // Diagnostics: sorted ascending -> a_rule, b_rule
      expect(filtered, contains('/tools/diagnostics/a_rule'));
      expect(filtered, contains('/tools/diagnostics/b_rule'));
      expect(filtered, isNot(contains('/tools/diagnostics/c_rule')));
      // Blog: sorted descending -> post-3, post-2
      expect(filtered, contains('/blog/post-3'));
      expect(filtered, contains('/blog/post-2'));
      expect(filtered, isNot(contains('/blog/post-1')));
    });

    test('always includes routes whose HTML changed, bypassing limits', () {
      final yaml = loadYaml('''
routes:
  - pattern: "/tools/diagnostics/*"
    limit: 2
    sort: ascending
''') as YamlMap;

      final config = VisualDiffConfig.fromYaml(yaml);

      final allRoutes = [
        '/tools/diagnostics/a_rule',
        '/tools/diagnostics/b_rule',
        '/tools/diagnostics/c_rule',
        '/tools/diagnostics/d_rule',
      ];

      // Even though limit is 2 and c_rule is 3rd, it changed
      // so it must be included!
      final filtered = config.filterRoutes(
        allRoutes: allRoutes,
        changedHtmlRoutes: {'/tools/diagnostics/c_rule'},
      );

      expect(filtered, [
        '/tools/diagnostics/a_rule',
        '/tools/diagnostics/b_rule',
        '/tools/diagnostics/c_rule',
      ]);
    });

    test(
      'always includes changed HTML routes even if matching exclude pattern',
      () {
        final yaml = loadYaml('''
exclude:
  - "/archive/*"
''') as YamlMap;

        final config = VisualDiffConfig.fromYaml(yaml);

        final allRoutes = [
          '/archive/post-1',
          '/archive/post-2',
        ];

        final filtered = config.filterRoutes(
          allRoutes: allRoutes,
          changedHtmlRoutes: {'/archive/post-1'},
        );

        expect(filtered, ['/archive/post-1']);
      },
    );

    test('disableLimits preserves all matching routes', () {
      final yaml = loadYaml('''
routes:
  - pattern: "/blog/*"
    limit: 1
''') as YamlMap;

      final config = VisualDiffConfig.fromYaml(yaml);

      final allRoutes = [
        '/blog/post-1',
        '/blog/post-2',
      ];

      final filtered = config.filterRoutes(
        allRoutes: allRoutes,
        disableLimits: true,
      );

      expect(filtered, ['/blog/post-1', '/blog/post-2']);
    });

    test('loads from file', () {
      final tempDir = Directory.systemTemp.createTempSync('config_test_');
      addTearDown(() => tempDir.deleteSync(recursive: true));

      final file = File(path.join(tempDir.path, 'visual_diff.yaml'));
      file.writeAsStringSync('''
routes:
  - pattern: "/blog/*"
    limit: 5
    sort: descending
''');

      final loaded = VisualDiffConfig.loadFromFile(file);
      expect(loaded, isNotNull);
      expect(loaded!.routeRules.length, 1);
      expect(loaded.routeRules.first.pattern, '/blog/*');
      expect(loaded.routeRules.first.limit, 5);
      expect(loaded.routeRules.first.sort, RouteSortOrder.descending);
    });
  });
}
