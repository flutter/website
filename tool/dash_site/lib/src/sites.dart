// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

/// The sites maintained in this repository.
enum Site {
  /// The Flutter documentation site.
  docs(
    host: 'docs.flutter.dev',
    buildOutputPathSegments: ['_site'],
    contentPathSegments: ['src', 'content'],
    firebaseConfigPathSegments: ['firebase.json'],
    firebaseEmulatorPort: 5502,
    supportsCodeExcerpts: true,
  );

  const Site({
    required this.host,
    required this.buildOutputPathSegments,
    required this.contentPathSegments,
    required this.firebaseConfigPathSegments,
    required this.firebaseEmulatorPort,
    this.supportsCodeExcerpts = false,
  });

  /// The host name where this site is served in production.
  final String host;

  /// The canonical base URL where this site is hosted in production.
  String get baseUrl => 'https://$host';

  /// The path segments for this site's production build output directory,
  /// relative to the repository root.
  final List<String> buildOutputPathSegments;

  /// The path segments for this site's content directory,
  /// relative to the site's [directory].
  final List<String> contentPathSegments;

  /// The path segments for this site's Firebase config file.
  final List<String> firebaseConfigPathSegments;

  /// The hosting emulator port declared in this site's Firebase config.
  ///
  /// The value must match the `emulators.hosting.port` value in
  /// the site's Firebase config (`firebase.json`) file.
  /// Each site needs a unique port so the emulators can run concurrently,
  /// and `5000` must be avoided since AirPlay can use it on macOS.
  final int firebaseEmulatorPort;

  /// Whether this site supports code excerpts managed by `refresh-excerpts`.
  final bool supportsCodeExcerpts;

  /// The directory where this site's content and implementation is located.
  String get directory => path.join('sites', name);

  /// The directory where this site's content is located.
  String get contentDirectory =>
      path.joinAll([directory, ...contentPathSegments]);

  /// The directory where this site's production build output should end up.
  String get buildOutputDirectory => path.joinAll(buildOutputPathSegments);

  /// The directory where Jaspr writes this site's production build,
  /// before it is copied to [buildOutputDirectory] if different.
  String get jasprBuildOutputDirectory =>
      path.join(directory, 'build', 'jaspr');

  /// The location of this site's Firebase config file.
  String get firebaseConfigPath => path.joinAll(firebaseConfigPathSegments);

  /// The directory containing this site's Firebase config file.
  String get firebaseConfigDirectory => path.dirname(firebaseConfigPath);
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
