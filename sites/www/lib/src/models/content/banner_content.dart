// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';
import 'package:jaspr/jaspr.dart';

import 'content_validation.dart';

part 'banner_content.mapper.dart';

/// Global site banner content loaded from `banner`.
///
/// Expected data format:
/// - `text`: non-empty banner text.
/// - `link`: absolute HTTP(S) URL or root-relative path the banner points to.
@MappableClass()
class BannerContent with BannerContentMappable {
  BannerContent({required this.text, required this.link}) {
    checkFormat(isNotBlank(text), 'text must be a non-empty string.');
    checkFormat(isNotBlank(link), 'link must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(link),
      'link must be an absolute http(s) URL or a root-relative path.',
    );
  }

  /// Banner copy displayed in the site header.
  final String text;

  /// Destination URL/path opened from the banner.
  final String link;

  /// Parses banner content from YAML/JSON data.
  @decoder
  static BannerContent fromJson(Map<String, Object?> json) =>
      BannerContentMapper.fromMap(json);

  /// Encodes banner content for client-component serialization.
  @encoder
  @override
  Map<String, Object?> toMap() => super.toMap();
}
