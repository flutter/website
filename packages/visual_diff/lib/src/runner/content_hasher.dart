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
        routeMap[route] = computeFileHash(htmlFile);
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
    for (final entity in buildDir.listSync(recursive: true)) {
      if (entity is File) {
        final ext = path.extension(entity.path).toLowerCase();
        if (ext == '.css') {
          final relPath = path.relative(entity.path, from: buildDir.path);
          assetFiles[relPath] = entity;
        }
      }
    }

    if (assetFiles.isEmpty) return '';

    final sortedKeys = assetFiles.keys.toList()..sort();
    final builder = BytesBuilder();

    for (final key in sortedKeys) {
      builder.add(utf8.encode('$key:'));
      final bytes = assetFiles[key]!.readAsBytesSync();
      builder.add(bytes);
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
}
