// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part 'showcase_content.mapper.dart';

/// Google app showcase card loaded from `showcase.data.google_apps`.
///
/// Expected data format:
/// - `title`: non-empty app title.
/// - `image`: image asset path under `images/`.
/// - `url`: optional absolute HTTP(S) URL or root-relative path.
@MappableClass()
class ShowcaseGoogleApp with ShowcaseGoogleAppMappable {
  ShowcaseGoogleApp({required this.title, required this.image, this.url}) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(isNotBlank(image), 'image must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(image),
      'image must be an image asset path under images/.',
    );
    if (url case final url?) {
      checkFormat(isNotBlank(url), 'url must be a non-empty string.');
      checkFormat(
        isAbsoluteHttpUrlOrBaseHrefRelativePath(url),
        'url must be an absolute http(s) URL or a root-relative path.',
      );
    }
  }

  /// App title shown on the card.
  final String title;

  /// Card image path.
  final String image;

  /// Optional destination URL/path.
  final String? url;

  /// Parses a showcase Google app model from YAML/JSON data.
  static ShowcaseGoogleApp fromJson(Map<String, Object?> json) =>
      ShowcaseGoogleAppMapper.fromMap(json);
}

/// Demo card loaded from `showcase.data.demos`.
///
/// Expected data format:
/// - `title`: non-empty demo title.
/// - `description`: non-empty demo description.
/// - `image`: image asset path under `images/`.
/// - `url`: absolute HTTP(S) URL or root-relative path.
@MappableClass()
class ShowcaseDemo with ShowcaseDemoMappable {
  ShowcaseDemo({
    required this.title,
    required this.description,
    required this.image,
    required this.url,
  }) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(
      isNotBlank(description),
      'description must be a non-empty string.',
    );
    checkFormat(isNotBlank(image), 'image must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(image),
      'image must be an image asset path under images/.',
    );
    checkFormat(isNotBlank(url), 'url must be a non-empty string.');
    checkFormat(
      isAbsoluteHttpUrlOrBaseHrefRelativePath(url),
      'url must be an absolute http(s) URL or a root-relative path.',
    );
  }

  /// Demo title shown on the card.
  final String title;

  /// Demo description text.
  final String description;

  /// Card image path.
  final String image;

  /// Destination URL/path.
  final String url;

  /// Parses a showcase demo model from YAML/JSON data.
  static ShowcaseDemo fromJson(Map<String, Object?> json) =>
      ShowcaseDemoMapper.fromMap(json);
}

/// Company logo entry loaded from `showcase.data.companies`.
///
/// Expected data format:
/// - `name`: non-empty company name.
/// - `logo`: root-relative image path.
@MappableClass()
class ShowcaseCompany with ShowcaseCompanyMappable {
  ShowcaseCompany({required this.name, required this.logo}) {
    checkFormat(isNotBlank(name), 'name must be a non-empty string.');
    checkFormat(isNotBlank(logo), 'logo must be a non-empty string.');
    checkFormat(
      looksLikeRootRelativeImagePath(logo),
      'logo must be a root-relative image path.',
    );
  }

  /// Company name associated with the logo.
  final String name;

  /// Logo image path.
  final String logo;

  /// Parses a showcase company model from YAML/JSON data.
  static ShowcaseCompany fromJson(Map<String, Object?> json) =>
      ShowcaseCompanyMapper.fromMap(json);
}
