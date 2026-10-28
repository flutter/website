// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:jaspr/server.dart';
import 'package:path/path.dart' as path;

final Map<String, String> _cacheBustedBuildAssetUrls = {};

/// The [assetUrl] with a content hash appended.
///
/// Jaspr writes web assets to `build/jaspr` before it
/// starts the static site renderer.
/// This function reads the built asset and appends a
/// truncated SHA-256 hash as a query parameter.
/// Outside static generation, it returns [assetUrl] unchanged.
///
/// If the built asset doesn't exist, throws a [FileSystemException].
/// If the built asset is empty, throws a [StateError].
String cacheBustedBuildAssetUrl(String assetUrl) {
  if (!kGenerateMode) {
    return assetUrl;
  }

  return _cacheBustedBuildAssetUrls.putIfAbsent(assetUrl, () {
    final assetUri = Uri.parse(assetUrl);
    final assetPath = path.joinAll([
      'build',
      'jaspr',
      ...assetUri.pathSegments,
    ]);
    final assetFile = File(assetPath);
    if (!assetFile.existsSync()) {
      throw FileSystemException(
        'Built asset not found. Ensure web assets are built before rendering.',
        assetFile.path,
      );
    }

    final bytes = assetFile.readAsBytesSync();
    if (bytes.isEmpty) {
      throw StateError('Built asset is empty: ${assetFile.path}');
    }

    final digest = sha256.convert(bytes);
    final hash = base64Url.encode(digest.bytes).substring(0, 12);
    return assetUri
        .replace(
          queryParameters: {
            ...assetUri.queryParameters,
            'hash': hash,
          },
        )
        .toString();
  });
}
