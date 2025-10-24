// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:pub_semver/pub_semver.dart';

class DevToolsReleaseNotesIndex extends StatelessComponent {
  const DevToolsReleaseNotesIndex({super.key});

  static List<({Version version, Page page})> findDevToolsReleases(
    BuildContext context,
  ) {
    const releaseNotesPrefix = 'tools/devtools/release-notes/release-notes-';
    return context.pages
        .where((p) => p.path.startsWith(releaseNotesPrefix))
        .map(
          (p) => (
            version: Version.parse(p.data.page['breadcrumb'] as String),
            page: p,
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
            text(release.page.data.page['shortTitle'] as String),
          ]),
        ]),
    ]);
  }
}
