// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'diff_entry.dart';
import 'diff_route.dart';

/// Represents a hierarchical tree node for routes, inspired by VS Code test
/// trees.
final class RouteTreeNode {
  final String segment;
  final String path;
  DiffRoute? route;
  final Map<String, RouteTreeNode> children = {};
  bool isExpanded;

  RouteTreeNode({
    required this.segment,
    required this.path,
    this.route,
    this.isExpanded = false,
  });

  bool get isFolder => children.isNotEmpty;

  /// Aggregate status of this node and all of its descendants.
  DiffStatus get status {
    if (children.isEmpty) {
      return route?.status ?? DiffStatus.unchanged;
    }
    if (route?.status == DiffStatus.changed ||
        children.values.any((c) => c.status == DiffStatus.changed)) {
      return DiffStatus.changed;
    }
    if (route?.status == DiffStatus.added ||
        children.values.any((c) => c.status == DiffStatus.added)) {
      return DiffStatus.added;
    }
    if (route?.status == DiffStatus.removed ||
        children.values.any((c) => c.status == DiffStatus.removed)) {
      return DiffStatus.removed;
    }
    return DiffStatus.unchanged;
  }

  /// Number of changed routes in this subtree.
  int get changedCount {
    var count = (route != null && route!.status == DiffStatus.changed) ? 1 : 0;
    for (final child in children.values) {
      count += child.changedCount;
    }
    return count;
  }

  /// Total number of distinct routes represented in this subtree.
  int get totalRouteCount {
    var count = route != null ? 1 : 0;
    for (final child in children.values) {
      count += child.totalRouteCount;
    }
    return count;
  }

  /// Expands all descendant nodes.
  void expandAll() {
    isExpanded = true;
    for (final child in children.values) {
      child.expandAll();
    }
  }

  /// Collapses all descendant nodes.
  void collapseAll() {
    isExpanded = false;
    for (final child in children.values) {
      child.collapseAll();
    }
  }

  /// Builds a tree of [RouteTreeNode]s from a list of [DiffRoute]s.
  static RouteTreeNode buildTree(List<DiffRoute> routes) {
    final root = RouteTreeNode(
      segment: '',
      path: '/',
      isExpanded: true,
    );

    for (final diffRoute in routes) {
      final rawPath = diffRoute.route;
      if (rawPath == '/' || rawPath.isEmpty) {
        root.route = diffRoute;
        continue;
      }

      final segments = rawPath.split('/').where((s) => s.isNotEmpty).toList();

      var current = root;
      var accumulatedPath = '';

      for (var i = 0; i < segments.length; i++) {
        final seg = segments[i];
        accumulatedPath += '/$seg';
        final isLast = (i == segments.length - 1);

        current = current.children.putIfAbsent(seg, () {
          return RouteTreeNode(
            segment: seg,
            path: accumulatedPath,
          );
        });

        if (isLast) {
          current.route = diffRoute;
        }
      }
    }

    // Automatically expand all ancestor nodes that contain changed routes
    // so they are immediately visible to the reviewer.
    void autoExpandChanges(RouteTreeNode node) {
      if (node.changedCount > 0) {
        node.isExpanded = true;
      }
      for (final child in node.children.values) {
        autoExpandChanges(child);
      }
    }

    autoExpandChanges(root);

    return root;
  }
}
