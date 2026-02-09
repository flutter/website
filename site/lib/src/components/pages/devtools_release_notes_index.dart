// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';

class DevToolsReleaseNotesIndex extends StatelessComponent {
  const DevToolsReleaseNotesIndex({super.key});

  static List<({Version version, Page page})> findDevToolsReleases(
    BuildContext context,
  ) {
    final releaseNotesPrefix = path.joinAll([
      'tools',
      'devtools',
      'release-notes',
      'release-notes-',
    ]);
    return context.pages
        .where((page) => page.path.startsWith(releaseNotesPrefix))
        .map(
          (page) => (
            version: Version.parse(page.data.page['breadcrumb'] as String),
            page: page,
          ),
        )
        .sortedBy((e) => e.version)
        .reversed
        .toList();
  }

  @override
  Component build(BuildContext context) {
    final releases = findDevToolsReleases(context);

    return ul([
      for (final release in releases)
        li([
          a(href: release.page.url, [
            .text(release.page.data.page['shortTitle'] as String),
          ]),
        ]),
    ]);
  }
}
