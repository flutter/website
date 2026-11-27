// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

/// Holds cryptographic content hashes for global assets (CSS/JS) and
/// prerendered route HTML files to allow smart skipping of unchanged pages.
final class SiteContentHashes {
  /// Combined hash of all global CSS and JS stylesheets/scripts.
  final String globalAssetsHash;

  /// Map of route path (e.g. `/cookbook`) to HTML content hash.
  final Map<String, String> routeHashes;

  const SiteContentHashes({
    required this.globalAssetsHash,
    required this.routeHashes,
  });

  Map<String, dynamic> toJson() => {
    'globalAssetsHash': globalAssetsHash,
    'routes': routeHashes,
  };

  factory SiteContentHashes.fromJson(Map<String, dynamic> json) {
    final routesMap = json['routes'] as Map<String, dynamic>? ?? {};
    return SiteContentHashes(
      globalAssetsHash: json['globalAssetsHash'] as String? ?? '',
      routeHashes: routesMap.map((k, v) => MapEntry(k, v.toString())),
    );
  }

  /// Loads hashes from a JSON file, or returns null if the file does not exist
  /// or cannot be parsed.
  static SiteContentHashes? loadFromFile(File file) {
    if (!file.existsSync()) return null;
    try {
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      return SiteContentHashes.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  /// Saves content hashes to [file] with indentation.
  void saveToFile(File file) {
    if (!file.parent.existsSync()) {
      file.parent.createSync(recursive: true);
    }
    const encoder = JsonEncoder.withIndent('  ');
    file.writeAsStringSync(encoder.convert(toJson()));
  }

  /// Compares [routes] in [buildDir] against this baseline instance and returns
  /// all route paths whose HTML file hash differs from the baseline, or which
  /// are newly added routes.
  Set<String> findChangedRoutes({
    required Directory buildDir,
    required Iterable<String> routes,
  }) {
    final changed = <String>{};
    for (final route in routes) {
      final htmlFile = resolveRouteHtmlFile(buildDir, route);
      if (htmlFile != null && htmlFile.existsSync()) {
        final currentHash = tryComputeFileHash(htmlFile);
        final baselineHash = routeHashes[route];
        if (currentHash != null && currentHash != baselineHash) {
          changed.add(route);
        }
      } else if (routeHashes.containsKey(route)) {
        changed.add(route);
      }
    }
    return changed;
  }

  /// Computes content hashes for [routes] built into [buildDir].
  static SiteContentHashes compute({
    required Directory buildDir,
    required Iterable<String> routes,
  }) {
    final globalHash = computeGlobalAssetsHash(buildDir);
    final routeMap = <String, String>{};

    for (final route in routes) {
      final htmlFile = resolveRouteHtmlFile(buildDir, route);
      if (htmlFile != null && htmlFile.existsSync()) {
        final hash = tryComputeFileHash(htmlFile);
        if (hash != null) {
          routeMap[route] = hash;
        }
      }
    }

    return SiteContentHashes(
      globalAssetsHash: globalHash,
      routeHashes: routeMap,
    );
  }

  /// Finds all `.css` stylesheet files in [buildDir] and computes an aggregate
  /// MD5 hash based on their paths and contents.
  ///
  /// We purposefully restrict global asset hashing to CSS files. JavaScript
  /// bundle compilation (e.g. Dart2JS deferred parts) embeds compilation
  /// timestamps and symbol hashes that change on every build even when no
  /// visual or code changes occurred.
  static String computeGlobalAssetsHash(Directory buildDir) {
    if (!buildDir.existsSync()) return '';

    final assetFiles = <String, File>{};
    void scanCss(Directory dir) {
      List<FileSystemEntity> entities;
      try {
        if (!dir.existsSync()) return;
        entities = dir.listSync(followLinks: false);
      } on FileSystemException catch (_) {
        return;
      }
      for (final entity in entities) {
        if (entity is File) {
          final ext = path.extension(entity.path).toLowerCase();
          if (ext == '.css') {
            final relPath = path.relative(entity.path, from: buildDir.path);
            final normalizedPath = path.split(relPath).join('/');
            assetFiles[normalizedPath] = entity;
          }
        } else if (entity is Directory) {
          final base = path.basename(entity.path);
          if (!base.startsWith('.')) {
            scanCss(entity);
          }
        }
      }
    }

    scanCss(buildDir);

    if (assetFiles.isEmpty) return '';

    final sortedKeys = assetFiles.keys.toList()..sort();
    final builder = BytesBuilder();

    for (final key in sortedKeys) {
      builder.add(utf8.encode('$key:'));
      try {
        final bytes = assetFiles[key]!.readAsBytesSync();
        builder.add(bytes);
      } on FileSystemException catch (_) {}
      builder.add(utf8.encode(';'));
    }

    return md5.convert(builder.toBytes()).toString();
  }

  /// Locates the HTML file in [buildDir] corresponding to [route].
  static File? resolveRouteHtmlFile(Directory buildDir, String route) {
    var rel = route.trim();
    if (rel.startsWith('/')) {
      rel = rel.substring(1);
    }
    if (rel.endsWith('/')) {
      rel = rel.substring(0, rel.length - 1);
    }

    if (rel.isEmpty) {
      final rootFile = File(path.join(buildDir.path, 'index.html'));
      return rootFile.existsSync() ? rootFile : null;
    }

    final dirCandidate = File(path.join(buildDir.path, rel, 'index.html'));
    if (dirCandidate.existsSync()) {
      return dirCandidate;
    }

    final fileCandidate = File(path.join(buildDir.path, '$rel.html'));
    if (fileCandidate.existsSync()) {
      return fileCandidate;
    }

    return null;
  }

  /// Computes the MD5 hex string of [file]'s contents.
  static String computeFileHash(File file) {
    final bytes = file.readAsBytesSync();
    return md5.convert(bytes).toString();
  }

  /// Safely computes the MD5 hex string of [file]'s contents, retrying on
  /// transient file lock or concurrent write exceptions.
  static String? tryComputeFileHash(File file) {
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        if (!file.existsSync()) return null;
        final bytes = file.readAsBytesSync();
        return md5.convert(bytes).toString();
      } on FileSystemException catch (_) {
        sleep(const Duration(milliseconds: 15));
      }
    }
    return null;
  }
}
