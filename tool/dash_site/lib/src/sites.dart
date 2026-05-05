// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

/// The sites maintained in this repository.
enum Site {
  /// The Flutter documentation site.
  docs(baseUrl: 'https://docs.flutter.dev');

  const Site({required this.baseUrl});

  /// The canonical base URL where this site is hosted in production.
  final String baseUrl;

  /// The directory where this site's content and implementation is located.
  String get directory => path.join('sites', name);
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
