// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
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

  _safeScanHtmlFiles(buildDirectory, (file) {
    final relativePath = path.relative(
      file.path,
      from: normalizedBuildPath,
    );

    // Ignore hidden files or directories (e.g. .git, .hidden).
    if (relativePath.startsWith('.') || relativePath.contains('/.')) {
      return;
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
  });

  var sortedRoutes = routes.toList()..sort();

  if (filter != null) {
    sortedRoutes = sortedRoutes.where(filter.hasMatch).toList();
  }

  if (limit != null && limit > 0 && sortedRoutes.length > limit) {
    sortedRoutes = sortedRoutes.sublist(0, limit);
  }

  return sortedRoutes;
}

void _safeScanHtmlFiles(Directory dir, void Function(File file) onFile) {
  List<FileSystemEntity> entities;
  try {
    if (!dir.existsSync()) return;
    entities = dir.listSync(followLinks: false);
  } on FileSystemException catch (_) {
    return;
  }
  for (final entity in entities) {
    if (entity is File) {
      if (entity.path.endsWith('.html')) {
        onFile(entity);
      }
    } else if (entity is Directory) {
      final base = path.basename(entity.path);
      if (!base.startsWith('.')) {
        _safeScanHtmlFiles(entity, onFile);
      }
    }
  }
}

/// Watches [buildDirectory] while [buildFuture] is completing, emitting newly
/// rendered routes as soon as their HTML files are written.
Stream<String> watchBuildRoutes(
  Directory buildDirectory, {
  required Future<int> buildFuture,
  List<String>? explicitRoutes,
  RegExp? filter,
  int? limit,
}) async* {
  final yieldedRoutes = <String>{};
  var buildDone = false;
  unawaited(buildFuture.whenComplete(() => buildDone = true));

  // 1. Wait until index.html is built (indicating web assets are compiled
  // and page generation has begun).
  final indexFile = File(path.join(buildDirectory.path, 'index.html'));
  while (!buildDone && !indexFile.existsSync()) {
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  if (explicitRoutes != null && explicitRoutes.isNotEmpty) {
    var targets = explicitRoutes.map(_normalizeRoute).toSet().toList()..sort();
    if (filter != null) {
      targets = targets.where(filter.hasMatch).toList();
    }

    while (!buildDone && yieldedRoutes.length < targets.length) {
      for (final r in targets) {
        if (!yieldedRoutes.contains(r)) {
          final rel = r == '/' ? 'index.html' : '${r.substring(1)}/index.html';
          final alt = r == '/' ? 'index.html' : '${r.substring(1)}.html';
          final f1 = File(path.join(buildDirectory.path, rel));
          final f2 = File(path.join(buildDirectory.path, alt));
          if (f1.existsSync() || f2.existsSync()) {
            yieldedRoutes.add(r);
            yield r;
            if (limit != null && limit > 0 && yieldedRoutes.length >= limit) {
              return;
            }
          }
        }
      }
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }

    // Final scan for remaining explicit targets.
    for (final r in targets) {
      if (!yieldedRoutes.contains(r)) {
        yieldedRoutes.add(r);
        yield r;
        if (limit != null && limit > 0 && yieldedRoutes.length >= limit) {
          return;
        }
      }
    }
    return;
  }

  // 2. Repeatedly build snapshots for pages that are already built and watch
  // the build directory for new pages.
  while (!buildDone) {
    if (buildDirectory.existsSync()) {
      final currentRoutes = discoverRoutes(
        buildDirectory,
        filter: filter,
      );
      for (final r in currentRoutes) {
        if (yieldedRoutes.add(r)) {
          yield r;
          if (limit != null && limit > 0 && yieldedRoutes.length >= limit) {
            return;
          }
        }
      }
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  // 3. Once the build process completes, check for final pages and yield all
  // remaining routes.
  if (buildDirectory.existsSync()) {
    final finalRoutes = discoverRoutes(
      buildDirectory,
      filter: filter,
    );
    for (final r in finalRoutes) {
      if (yieldedRoutes.add(r)) {
        yield r;
        if (limit != null && limit > 0 && yieldedRoutes.length >= limit) {
          return;
        }
      }
    }
  }
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
