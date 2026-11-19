// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('DiffRoute & RouteTreeNode', () {
    test('DiffRoute deduplicates viewports and detects changes '
        'if any target differs', () {
      final entries = [
        const DiffEntry(
          id: '404@desktop',
          route: '/404',
          viewport: 'desktop',
          filename: '404@desktop.png',
          status: DiffStatus.unchanged,
          diffPercentage: 0.0,
          diffPixels: 0,
          totalPixels: 100000,
          width: 1280,
          height: 800,
        ),
        const DiffEntry(
          id: '404@mobile',
          route: '/404',
          viewport: 'mobile',
          filename: '404@mobile.png',
          status: DiffStatus.changed,
          diffPercentage: 4.9,
          diffPixels: 4900,
          totalPixels: 100000,
          width: 375,
          height: 667,
        ),
        const DiffEntry(
          id: '__root__@desktop',
          route: '/',
          viewport: 'desktop',
          filename: '__root__@desktop.png',
          status: DiffStatus.unchanged,
          diffPercentage: 0.0,
          diffPixels: 0,
          totalPixels: 100000,
          width: 1280,
          height: 800,
        ),
      ];

      final routes = DiffRoute.groupEntries(entries);

      expect(routes.length, equals(2));
      expect(routes.containsKey('/404'), isTrue);
      expect(routes.containsKey('/'), isTrue);

      final route404 = routes['/404']!;
      // Even though desktop is unchanged, because mobile changed,
      // the route itself is detected as CHANGED!
      expect(route404.status, equals(DiffStatus.changed));
      expect(route404.hasDiff, isTrue);
      expect(route404.maxDiffPercentage, equals(4.9));
      expect(route404.entryForViewport('desktop')?.viewport, equals('desktop'));
      expect(route404.entryForViewport('mobile')?.viewport, equals('mobile'));

      final rootRoute = routes['/']!;
      expect(rootRoute.status, equals(DiffStatus.unchanged));
      expect(rootRoute.hasDiff, isFalse);
    });

    test('RouteTreeNode builds concise hierarchical tree from routes', () {
      final routes = [
        DiffRoute(
          route: '/',
          viewports: {},
        ),
        DiffRoute(
          route: '/cookbook',
          viewports: {},
        ),
        DiffRoute(
          route: '/cookbook/effects/drag-a-widget',
          viewports: {
            'desktop': const DiffEntry(
              id: 'drag@desktop',
              route: '/cookbook/effects/drag-a-widget',
              viewport: 'desktop',
              filename: 'drag@desktop.png',
              status: DiffStatus.changed,
              diffPercentage: 2.5,
              diffPixels: 250,
              totalPixels: 10000,
              width: 1280,
              height: 800,
            ),
          },
        ),
        DiffRoute(
          route: '/cookbook/design/snackbars',
          viewports: {
            'desktop': const DiffEntry(
              id: 'snackbars@desktop',
              route: '/cookbook/design/snackbars',
              viewport: 'desktop',
              filename: 'snackbars@desktop.png',
              status: DiffStatus.unchanged,
              diffPercentage: 0.0,
              diffPixels: 0,
              totalPixels: 10000,
              width: 1280,
              height: 800,
            ),
          },
        ),
      ];

      final tree = RouteTreeNode.buildTree(routes);

      // Root has children: 'cookbook'
      expect(tree.children.containsKey('cookbook'), isTrue);
      final cookbook = tree.children['cookbook']!;
      expect(cookbook.segment, equals('cookbook'));
      expect(cookbook.path, equals('/cookbook'));
      expect(cookbook.route?.route, equals('/cookbook'));

      // Cookbook has children 'effects' and 'design'
      expect(cookbook.children.containsKey('effects'), isTrue);
      expect(cookbook.children.containsKey('design'), isTrue);

      final effects = cookbook.children['effects']!;
      expect(effects.children.containsKey('drag-a-widget'), isTrue);
      final dragLeaf = effects.children['drag-a-widget']!;
      expect(dragLeaf.route?.route, equals('/cookbook/effects/drag-a-widget'));
      expect(dragLeaf.status, equals(DiffStatus.changed));

      // Ancestors inherit changed status and count
      expect(effects.status, equals(DiffStatus.changed));
      expect(effects.changedCount, equals(1));
      expect(cookbook.status, equals(DiffStatus.changed));
      expect(cookbook.changedCount, equals(1));

      // Changed nodes are automatically expanded
      expect(cookbook.isExpanded, isTrue);
      expect(effects.isExpanded, isTrue);

      // Design node has no changes
      final design = cookbook.children['design']!;
      expect(design.status, equals(DiffStatus.unchanged));
      expect(design.changedCount, equals(0));
    });
  });
}
