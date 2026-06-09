// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part 'ios_content.mapper.dart';

/// Top-brand entry loaded from `development.ios.top_brands`.
///
/// Expected data format:
/// - `name`: non-empty brand name.
/// - `src`: image asset path under `images/`.
/// - `href`: absolute HTTP(S) URL or root-relative path.
@MappableClass()
class IosTopBrand with IosTopBrandMappable {
  IosTopBrand({required this.name, required this.src, required this.href}) {
    checkFormat(isNotBlank(name), 'name must be a non-empty string.');
    checkFormat(isNotBlank(src), 'src must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(src),
      'src must be an image asset path under images/.',
    );
    checkFormat(isNotBlank(href), 'href must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(href),
      'href must be an absolute http(s) URL or a root-relative path.',
    );
  }

  /// Brand name displayed in the section.
  final String name;

  /// Logo source path.
  final String src;

  /// Destination URL/path for the brand.
  final String href;

  /// Parses an iOS top-brand model from YAML/JSON data.
  static IosTopBrand fromJson(Map<String, Object?> json) =>
      IosTopBrandMapper.fromMap(json);
}
