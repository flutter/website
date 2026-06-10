// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part 'ai_content.mapper.dart';

/// AI sample item loaded from `ai.samples`.
///
/// Expected data format:
/// - `title`: non-empty sample title.
/// - `href`: absolute HTTP(S) URL or root-relative path.
/// - `image`: image asset path under `images/`.
@MappableClass()
class AiSample with AiSampleMappable {
  AiSample({required this.title, required this.href, required this.image}) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(isNotBlank(href), 'href must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(href),
      'href must be an absolute http(s) URL or a root-relative path.',
    );
    checkFormat(isNotBlank(image), 'image must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(image),
      'image must be an image asset path under images/.',
    );
  }

  /// Display title shown for the sample card.
  final String title;

  /// Destination URL/path opened from the card.
  final String href;

  /// Image asset path rendered on the card.
  final String image;

  /// Parses an AI sample model from YAML/JSON data.
  static AiSample fromJson(Map<String, Object?> json) =>
      AiSampleMapper.fromMap(json);
}
