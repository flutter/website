// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part 'community_content.mapper.dart';

/// Community listing entry loaded from `community.communities`.
///
/// Expected data format:
/// - `href`: absolute HTTP(S) destination URL.
/// - `imgSrc`: image asset path under `images/`.
/// - `imgAlt`: non-empty alt text.
/// - `title`: non-empty title.
/// - `description`: non-empty description.
/// - `isFramed`: optional boolean, defaults to `false`.
/// - `hasSubscribeButton`: optional boolean, defaults to `false`.
@MappableClass()
class CommunityGroup with CommunityGroupMappable {
  CommunityGroup({
    required this.href,
    required this.imgSrc,
    required this.imgAlt,
    required this.title,
    required this.description,
    this.isFramed = false,
    this.hasSubscribeButton = false,
  }) {
    checkFormat(isNotBlank(href), 'href must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrl(href),
      'href must be an absolute http(s) URL.',
    );
    checkFormat(isNotBlank(imgSrc), 'imgSrc must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(imgSrc),
      'imgSrc must be an image asset path under images/.',
    );
    checkFormat(isNotBlank(imgAlt), 'imgAlt must be a non-empty string.');
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(
      isNotBlank(description),
      'description must be a non-empty string.',
    );
  }

  /// Link opened when selecting this community item.
  final String href;

  /// Source path for the community logo/image.
  final String imgSrc;

  /// Alt text for the community image.
  final String imgAlt;

  /// Heading text displayed for the community.
  final String title;

  /// Supporting body text shown below the title.
  final String description;

  /// Whether the image is rendered with a frame treatment.
  final bool isFramed;

  /// Whether a subscribe button is shown for this item.
  final bool hasSubscribeButton;

  /// Parses a community group model from YAML/JSON data.
  static CommunityGroup fromJson(Map<String, Object?> json) =>
      CommunityGroupMapper.fromMap(json);
}
