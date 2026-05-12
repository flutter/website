// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

/// The sites maintained in this repository.
enum Site {
  /// The Flutter documentation site.
  docs(
    baseUrl: 'https://docs.flutter.dev',
    buildOutputPathSegments: ['_site'],
    contentPathSegments: ['src', 'content'],
    firebaseConfigPathSegments: ['firebase.json'],
    supportsCodeExcerpts: true,
  ),

  /// The Flutter marketing site.
  www(
    baseUrl: 'https://flutter.dev',
    buildOutputPathSegments: ['sites', 'www', 'build', 'jaspr'],
    contentPathSegments: ['content'],
    firebaseConfigPathSegments: ['sites', 'www', 'firebase.json'],
  );

  const Site({
    required this.baseUrl,
    required this.buildOutputPathSegments,
    required this.contentPathSegments,
    required this.firebaseConfigPathSegments,
    this.supportsCodeExcerpts = false,
  });

  /// The canonical base URL where this site is hosted in production.
  final String baseUrl;

  /// The path segments for this site's production build output directory.
  final List<String> buildOutputPathSegments;

  /// The path segments for this site's content directory.
  final List<String> contentPathSegments;

  /// The path segments for this site's Firebase config file.
  final List<String> firebaseConfigPathSegments;

  /// Whether this site supports code excerpts managed by `refresh-excerpts`.
  final bool supportsCodeExcerpts;

  /// The directory where this site's content and implementation is located.
  String get directory => path.join('sites', name);

  /// The directory where this site's content is located.
  String get contentDirectory =>
      path.joinAll([directory, ...contentPathSegments]);

  /// The directory where this site's production build output should end up.
  String get buildOutputDirectory => path.joinAll(buildOutputPathSegments);

  /// The location of this site's Firebase config file.
  String get firebaseConfigPath => path.joinAll(firebaseConfigPathSegments);

  /// The directory where Jaspr writes this site's production build.
  String get jasprBuildOutputDirectory =>
      path.join(directory, 'build', 'jaspr');
}

/// The name of the global `--site` option.
const String siteOptionName = 'site';

extension CommandSiteResolution<T> on Command<T> {
  /// The [Site] selected with the global `--site` option,
  /// defaulting to [Site.docs].
  Site get selectedSite {
    if (globalResults?.option(siteOptionName) case final siteName?) {
      return Site.values.byName(siteName);
    }

    return Site.docs;
  }
}
