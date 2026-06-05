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
    defaultFirebaseProjectId: 'flutter-docs-prod',
    supportsCodeExcerpts: true,
  ),

  /// The Flutter marketing site.
  www(
    host: 'flutter.dev',
    buildOutputPathSegments: ['sites', 'www', 'build', 'jaspr'],
    contentPathSegments: ['content'],
    firebaseConfigPathSegments: ['sites', 'www', 'firebase.json'],
    firebaseEmulatorPort: 5503,
    defaultFirebaseProjectId: 'flutter-dev-230821',
  );

  const Site({
    required this.host,
    required this.buildOutputPathSegments,
    required this.contentPathSegments,
    required this.firebaseConfigPathSegments,
    required this.firebaseEmulatorPort,
    required this.defaultFirebaseProjectId,
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

  /// The default Firebase project ID for production and staging deploys.
  ///
  /// Commands expose this as an overrideable default so contributors can
  /// deploy the site to their own Firebase projects for testing.
  final String defaultFirebaseProjectId;

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

  /// The ports Jaspr uses when serving this site locally.
  ///
  /// Each port is derived from this site's declaration order in [Site] so
  /// that multiple sites can be served concurrently without port conflicts.
  /// Each is offset by one past Jaspr's default to avoid colliding with a
  /// separate Jaspr project running with default port configuration.
  ({int serve, int webDev, int proxy}) get jasprPorts => (
    serve: _jasprDefaultSitePort + index + 1,
    webDev: _jasprDefaultWebDevPort + index + 1,
    proxy: _jasprDefaultProxyPort + index + 1,
  );
}

/// The name of the global `--site` option.
const String siteOptionName = 'site';

const int _jasprDefaultSitePort = 8080;
const int _jasprDefaultWebDevPort = 5467;
const int _jasprDefaultProxyPort = 5567;

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
