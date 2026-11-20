// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'diff_entry.dart';
import 'header_metadata.dart';

/// Represents a single deduplicated route across multiple viewport snapshots
/// (e.g. desktop and mobile).
final class DiffRoute {
  final String route;
  final Map<String, DiffEntry> viewports;

  DiffRoute({
    required this.route,
    required this.viewports,
  });

  /// Retrieves the [DiffEntry] for [viewport], or the first available viewport
  /// if not present.
  DiffEntry? entryForViewport(String viewport) {
    if (viewports.containsKey(viewport)) {
      return viewports[viewport];
    }
    return viewports.isNotEmpty ? viewports.values.first : null;
  }

  /// The aggregate diff status across all viewports for this route.
  ///
  /// If ANY viewport has differences, the route is detected as
  /// [DiffStatus.changed].
  DiffStatus get status {
    if (viewports.values.any((e) => e.status == DiffStatus.changed)) {
      return DiffStatus.changed;
    }
    if (viewports.values.any((e) => e.status == DiffStatus.added)) {
      return DiffStatus.added;
    }
    if (viewports.values.any((e) => e.status == DiffStatus.removed)) {
      return DiffStatus.removed;
    }
    return DiffStatus.unchanged;
  }

  /// Whether any viewport has visual differences or metadata changes.
  bool get hasDiff => status != DiffStatus.unchanged || hasHeaderDiff;

  /// Whether HTML header metadata (title, canonical, or meta tags) changed.
  bool get hasHeaderDiff => headerDiff?.hasDiff ?? false;

  /// Captured current header metadata for this route.
  HeaderMetadata? get currentMetadata {
    for (final e in viewports.values) {
      if (e.currentMetadata != null) return e.currentMetadata;
    }
    return null;
  }

  /// Captured baseline header metadata for this route.
  HeaderMetadata? get baselineMetadata {
    for (final e in viewports.values) {
      if (e.baselineMetadata != null) return e.baselineMetadata;
    }
    return null;
  }

  /// Header diff between baseline and current for this route.
  HeaderDiff? get headerDiff {
    for (final e in viewports.values) {
      if (e.headerDiff != null) return e.headerDiff;
    }
    return null;
  }

  /// The maximum diff percentage among all viewports.
  double get maxDiffPercentage {
    var max = 0.0;
    for (final e in viewports.values) {
      if (e.diffPercentage > max) max = e.diffPercentage;
    }
    return max;
  }

  /// Total diff pixels across all viewports.
  int get totalDiffPixels {
    var sum = 0;
    for (final e in viewports.values) {
      sum += e.diffPixels;
    }
    return sum;
  }

  /// Groups a flat list of [DiffEntry] items by route into [DiffRoute] objects.
  static Map<String, DiffRoute> groupEntries(List<DiffEntry> entries) {
    final map = <String, Map<String, DiffEntry>>{};

    for (final entry in entries) {
      map.putIfAbsent(entry.route, () => {})[entry.viewport] = entry;
    }

    final routes = <String, DiffRoute>{};
    for (final entry in map.entries) {
      routes[entry.key] = DiffRoute(
        route: entry.key,
        viewports: entry.value,
      );
    }

    return routes;
  }
}
