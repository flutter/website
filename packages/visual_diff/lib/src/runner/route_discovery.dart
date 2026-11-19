// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;

/// Discovers candidate routes from a site's build directory.
List<String> discoverRoutes(
  Directory buildDirectory, {
  List<String>? explicitRoutes,
  RegExp? filter,
  int? limit,
}) {
  if (explicitRoutes != null && explicitRoutes.isNotEmpty) {
    var routes = explicitRoutes.map(_normalizeRoute).toSet().toList()..sort();
    if (filter != null) {
      routes = routes.where(filter.hasMatch).toList();
    }
    if (limit != null && limit > 0 && routes.length > limit) {
      routes = routes.sublist(0, limit);
    }
    return routes;
  }

  if (!buildDirectory.existsSync()) {
    return const [];
  }

  final routes = <String>{};
  final normalizedBuildPath = path.normalize(buildDirectory.path);

  for (final entity in buildDirectory.listSync(
    recursive: true,
    followLinks: false,
  )) {
    if (entity is! File || !entity.path.endsWith('.html')) {
      continue;
    }

    final relativePath = path.relative(
      entity.path,
      from: normalizedBuildPath,
    );

    // Ignore hidden files or directories (e.g. .git, .hidden).
    if (relativePath.startsWith('.') || relativePath.contains('/.')) {
      continue;
    }

    final normalized = path.split(relativePath).join('/');

    if (normalized == 'index.html') {
      routes.add('/');
    } else if (normalized.endsWith('/index.html')) {
      final routePath = normalized.substring(
        0,
        normalized.length - '/index.html'.length,
      );
      routes.add('/$routePath');
    } else {
      final routePath = normalized.substring(
        0,
        normalized.length - '.html'.length,
      );
      routes.add('/$routePath');
    }
  }

  var sortedRoutes = routes.toList()..sort();

  if (filter != null) {
    sortedRoutes = sortedRoutes.where(filter.hasMatch).toList();
  }

  if (limit != null && limit > 0 && sortedRoutes.length > limit) {
    sortedRoutes = sortedRoutes.sublist(0, limit);
  }

  return sortedRoutes;
}

String _normalizeRoute(String rawRoute) {
  var route = rawRoute.trim();
  if (!route.startsWith('/')) {
    route = '/$route';
  }
  if (route.length > 1 && route.endsWith('/')) {
    route = route.substring(0, route.length - 1);
  }
  return route;
}

/// Generates a standardized snapshot filename for a route and viewport name.
String snapshotFileName(String route, String viewportName) {
  final cleanRoute = route == '/'
      ? '__root__'
      : route.replaceAll(RegExp(r'^/|/$'), '');
  final safeName = cleanRoute.replaceAll('/', '__');
  return '$safeName@$viewportName.png';
}
