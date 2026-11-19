// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:path/path.dart' as p;
import 'package:site_shared/image_dimensions.dart';

/// Looks up intrinsic (or post-resize) pixel dimensions for a resolved
/// `/assets/...` URL produced by `AssetManager`.
ImageDimensions? dimensionsForResolvedAsset(String src) {
  if (!src.startsWith('/assets/')) return null;
  final cleanPath = src.split('#').first.split('?').first;
  final relativeAssetPath = p.fromUri(cleanPath.substring('/assets/'.length));
  if (relativeAssetPath.isEmpty) return null;

  for (final root in _candidateAssetRoots()) {
    final candidate = p.normalize(p.join(root, relativeAssetPath));
    final dims = readImageDimensions(candidate);
    if (dims != null) return dims;
  }
  return null;
}

/// Renders an `<img>` element with `width` and `height` populated from the
/// resolved [src] asset when available.
Component sizedImg({
  required String src,
  String? alt,
  String? classes,
  MediaLoading? loading,
  Map<String, String>? attributes,
}) {
  final dims = dimensionsForResolvedAsset(src);
  return img(
    src: src,
    alt: alt,
    classes: classes,
    width: dims?.width,
    height: dims?.height,
    loading: loading,
    attributes: attributes,
  );
}

Iterable<String> _candidateAssetRoots() sync* {
  if (Directory('content').existsSync()) {
    yield p.join('build', 'jaspr', 'assets');
    yield 'content';
    return;
  }
  yield p.join('sites', 'www', 'build', 'jaspr', 'assets');
  yield p.join('sites', 'www', 'content');
}
