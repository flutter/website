// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part 'games_content.mapper.dart';

/// Game integration card loaded from `games.data.integrations`.
///
/// Expected data format:
/// - `title`: non-empty integration title.
/// - `description`: non-empty integration description.
/// - `url`: absolute HTTP(S) URL or root-relative path.
/// - `image`: image asset path under `images/`.
@MappableClass()
class GameIntegration with GameIntegrationMappable {
  GameIntegration({
    required this.title,
    required this.description,
    required this.url,
    required this.image,
  }) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(
      isNotBlank(description),
      'description must be a non-empty string.',
    );
    checkFormat(isNotBlank(url), 'url must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(url),
      'url must be an absolute http(s) URL or a root-relative path.',
    );
    checkFormat(isNotBlank(image), 'image must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(image),
      'image must be an image asset path under images/.',
    );
  }

  /// Integration title shown on the card.
  final String title;

  /// Integration description body text.
  final String description;

  /// Destination URL/path for the integration.
  final String url;

  /// Image asset path shown on the card.
  final String image;

  /// Parses a game integration model from YAML/JSON data.
  static GameIntegration fromJson(Map<String, Object?> json) =>
      GameIntegrationMapper.fromMap(json);
}

/// Featured game entry loaded from `games.data.featured`.
///
/// Expected data format:
/// - `title`: non-empty game title.
/// - `url`: absolute HTTP(S) URL or root-relative path.
/// - `image`: image asset path under `images/`.
@MappableClass()
class FeaturedGame with FeaturedGameMappable {
  FeaturedGame({required this.title, required this.url, required this.image}) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(isNotBlank(url), 'url must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(url),
      'url must be an absolute http(s) URL or a root-relative path.',
    );
    checkFormat(isNotBlank(image), 'image must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(image),
      'image must be an image asset path under images/.',
    );
  }

  /// Game title shown in the featured carousel.
  final String title;

  /// Destination URL/path for the game story.
  final String url;

  /// Image asset path used by the carousel card.
  final String image;

  /// Parses a featured game model from YAML/JSON data.
  static FeaturedGame fromJson(Map<String, Object?> json) =>
      FeaturedGameMapper.fromMap(json);
}
