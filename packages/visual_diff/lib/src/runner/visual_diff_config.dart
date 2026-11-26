// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

/// Specifies sorting order for matched routes before a limit is applied.
enum RouteSortOrder {
  ascending,
  descending,
  none;

  static RouteSortOrder fromString(String? value) {
    return switch (value?.toLowerCase().trim()) {
      'asc' || 'ascending' => RouteSortOrder.ascending,
      'desc' || 'descending' => RouteSortOrder.descending,
      _ => RouteSortOrder.none,
    };
  }
}

/// A rule that applies to a set of routes matching a glob pattern.
final class RouteRule {
  /// The glob pattern (e.g. `/blog/*` or `/tools/diagnostics/**`).
  final String pattern;

  /// Compiled glob for matching routes.
  final Glob glob;

  /// Maximum number of routes to retain from this group when sampling.
  final int? limit;

  /// How to sort the matched routes before selecting the top [limit].
  final RouteSortOrder sort;

  RouteRule({
    required this.pattern,
    this.limit,
    this.sort = RouteSortOrder.none,
  }) : glob = Glob(pattern);

  factory RouteRule.fromYaml(YamlMap map) {
    final pattern = map['pattern']?.toString() ?? '';
    final limit = map['limit'] is int
        ? map['limit'] as int
        : int.tryParse(map['limit']?.toString() ?? '');
    final sort = RouteSortOrder.fromString(map['sort']?.toString());

    return RouteRule(
      pattern: pattern,
      limit: limit,
      sort: sort,
    );
  }
}

/// Configuration specifying route pruning and sampling rules
/// for visual diffing.
final class VisualDiffConfig {
  /// The list of pattern-based route sampling rules.
  final List<RouteRule> routeRules;

  /// Glob patterns for routes to exclude.
  final List<Glob> excludeGlobs;

  /// Routes to unconditionally include.
  final Set<String> includeRoutes;

  const VisualDiffConfig({
    this.routeRules = const [],
    this.excludeGlobs = const [],
    this.includeRoutes = const {},
  });

  /// Finds and loads `visual_diff.yaml` in [searchDirectory] or its parent
  /// directories.
  static VisualDiffConfig? findConfig(Directory searchDirectory) {
    var current = searchDirectory.absolute;
    while (true) {
      final file = File(path.join(current.path, 'visual_diff.yaml'));
      if (file.existsSync()) {
        return loadFromFile(file);
      }
      final dotFile = File(path.join(current.path, '.visual_diff.yaml'));
      if (dotFile.existsSync()) {
        return loadFromFile(dotFile);
      }
      final parent = current.parent;
      if (parent.path == current.path) break;
      current = parent;
    }
    return null;
  }

  /// Loads configuration from a YAML file.
  static VisualDiffConfig? loadFromFile(File file) {
    if (!file.existsSync()) return null;
    try {
      final yaml = loadYaml(file.readAsStringSync());
      if (yaml is! YamlMap) return null;
      return VisualDiffConfig.fromYaml(yaml);
    } catch (_) {
      return null;
    }
  }

  /// Parses configuration from a YAML map.
  factory VisualDiffConfig.fromYaml(YamlMap yaml) {
    final rules = <RouteRule>[];
    if (yaml['routes'] case final YamlList list) {
      for (final item in list) {
        if (item is YamlMap) {
          rules.add(RouteRule.fromYaml(item));
        }
      }
    }

    final excludeGlobs = <Glob>[];
    if (yaml['exclude'] case final YamlList list) {
      for (final item in list) {
        if (item != null) {
          excludeGlobs.add(Glob(item.toString()));
        }
      }
    }

    final includeRoutes = <String>{};
    if (yaml['include'] case final YamlList list) {
      for (final item in list) {
        if (item != null) {
          includeRoutes.add(_normalizeRoute(item.toString()));
        }
      }
    }

    return VisualDiffConfig(
      routeRules: rules,
      excludeGlobs: excludeGlobs,
      includeRoutes: includeRoutes,
    );
  }

  /// Filters and samples [allRoutes] based on rules.
  ///
  /// CRITICAL GUARANTEE: Any route present in [changedHtmlRoutes] is ALWAYS
  /// preserved and snapshotted, bypassing any route rule limits or exclusions.
  List<String> filterRoutes({
    required Iterable<String> allRoutes,
    Set<String> changedHtmlRoutes = const {},
    bool disableLimits = false,
  }) {
    final normalizedAll = allRoutes.map(_normalizeRoute).toSet();
    final normalizedChanged = changedHtmlRoutes.map(_normalizeRoute).toSet();
    final normalizedInclude = includeRoutes.map(_normalizeRoute).toSet();

    // 1. Exclude routes matching exclude globs, UNLESS their HTML changed.
    final candidateRoutes = <String>{};
    for (final r in normalizedAll) {
      if (normalizedChanged.contains(r) || normalizedInclude.contains(r)) {
        candidateRoutes.add(r);
        continue;
      }
      var isExcluded = false;
      for (final glob in excludeGlobs) {
        if (glob.matches(r)) {
          isExcluded = true;
          break;
        }
      }
      if (!isExcluded) {
        candidateRoutes.add(r);
      }
    }

    if (disableLimits) {
      return candidateRoutes.toList()..sort();
    }

    // 2. Apply route sampling rules.
    final remainingRoutes = Set<String>.from(candidateRoutes);
    final retainedRoutes = <String>{};

    for (final rule in routeRules) {
      // Find all routes matching this rule's pattern.
      final matches = candidateRoutes.where(rule.glob.matches).toList();
      if (matches.isEmpty) continue;

      // Remove from unassigned remaining pool so rules don't collide.
      remainingRoutes.removeAll(matches);

      if (rule.limit == null ||
          rule.limit! <= 0 ||
          matches.length <= rule.limit!) {
        retainedRoutes.addAll(matches);
        continue;
      }

      // Sort matched routes according to rule specification.
      switch (rule.sort) {
        case RouteSortOrder.ascending:
          matches.sort();
        case RouteSortOrder.descending:
          matches.sort((a, b) => b.compareTo(a));
        case RouteSortOrder.none:
          break;
      }

      // Pick top N routes.
      final sampled = matches.sublist(0, rule.limit!);
      retainedRoutes.addAll(sampled);

      // CRITICAL: Any matched route outside the sampled top N that has changed
      // HTML (or is explicitly included) MUST STILL BE KEPT!
      for (final r in matches.sublist(rule.limit!)) {
        if (normalizedChanged.contains(r) || normalizedInclude.contains(r)) {
          retainedRoutes.add(r);
        }
      }
    }

    // All routes that did not match any specific sampling rule are kept as-is.
    retainedRoutes.addAll(remainingRoutes);

    // Unconditionally ensure all changed and included routes are present.
    for (final r in normalizedChanged) {
      if (normalizedAll.contains(r)) {
        retainedRoutes.add(r);
      }
    }
    for (final r in normalizedInclude) {
      if (normalizedAll.contains(r)) {
        retainedRoutes.add(r);
      }
    }

    return retainedRoutes.toList()..sort();
  }

  static String _normalizeRoute(String rawRoute) {
    var route = rawRoute.trim();
    if (!route.startsWith('/')) {
      route = '/$route';
    }
    if (route.length > 1 && route.endsWith('/')) {
      route = route.substring(0, route.length - 1);
    }
    return route;
  }
}
