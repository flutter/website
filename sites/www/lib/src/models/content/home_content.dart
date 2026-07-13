// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part 'home_content.mapper.dart';

/// News card entry loaded from `home.latest_news`.
///
/// Expected data format:
/// - `title`: non-empty news headline.
/// - `url`: absolute HTTP(S) URL or root-relative path.
/// - `image`: root-relative image path.
/// - `alt`: optional non-empty alt text.
@MappableClass()
class HomeNewsItem with HomeNewsItemMappable {
  HomeNewsItem({
    required this.title,
    required this.url,
    required this.image,
    this.alt,
  }) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(isNotBlank(url), 'url must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(url),
      'url must be an absolute http(s) URL or a root-relative path.',
    );
    checkFormat(isNotBlank(image), 'image must be a non-empty string.');
    checkFormat(
      looksLikeRootRelativeImagePath(image),
      'image must be a root-relative image path.',
    );
    if (alt case final alt?) {
      checkFormat(isNotBlank(alt), 'alt must be a non-empty string.');
    }
  }

  /// News headline shown in the card.
  final String title;

  /// Destination URL/path for the story.
  final String url;

  /// Card image path.
  final String image;

  /// Optional alt text for the image.
  final String? alt;

  /// Parses a home news model from YAML/JSON data.
  static HomeNewsItem fromJson(Map<String, Object?> json) =>
      HomeNewsItemMapper.fromMap(json);
}
