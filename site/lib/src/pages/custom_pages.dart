// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/pages/devtools_release_notes_index.dart';
import 'glossary.dart';

/// All pages that should be loaded from memory rather than
/// from content loaded from the file system.
List<MemoryPage> get allMemoryPages => [
  _glossaryPage,
  _devtoolsReleasesIndex,
];

/// The `/resources/glossary` page which hosts the [GlossaryIndex].
MemoryPage get _glossaryPage => MemoryPage.builder(
  path: 'resources/glossary.md',
  initialData: {
    'page': <String, Object?>{
      'title': 'Glossary',
      'showBreadcrumbs': false,
      'description':
          'A glossary reference for terminology '
          'used across docs.flutter.dev.',
      'showToc': false,
      'bodyClass': 'glossary-page',
    },
  },
  builder: (_) {
    return const GlossaryIndex();
  },
);

/// The `/f/devtools-releases.json` file that DevTools consumes.
MemoryPage get _devtoolsReleasesIndex => MemoryPage.builder(
  path: 'f/devtools-releases.json',
  applyLayout: false,
  keepSuffix: true,
  initialData: {
    'page': <String, Object?>{
      'title': 'DevTools release notes index',
      'description': 'An index of DevTools release note Markdown files.',
      'sitemap': false,
    },
  },
  builder: (context) {
    context.setHeader('Content-Type', 'application/json; charset=utf-8');

    final releases = DevToolsReleaseNotesIndex.findDevToolsReleases(context);
    final releaseData = {
      'latest': releases.first.version.toString(),
      'releases': {
        for (final release in releases)
          release.version.toString(): '/${release.page.path}',
      },
    };

    const jsonEncoder = JsonEncoder.withIndent('  ');
    context.setStatusCode(200, responseBody: jsonEncoder.convert(releaseData));

    return const Component.empty();
  },
);
