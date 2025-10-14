// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../data/devtools_releases.dart';

/// All pages that should be loaded from memory rather than
/// from content loaded from the file system.
List<MemoryPage> get allMemoryPages => [
  _devtoolsReleasesIndex,
];

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

    final releaseData = {
      'latest': devToolsReleases.first,
      'releases': {
        for (final release in devToolsReleases)
          release:
              '/tools/devtools/release-notes/release-notes-$release-src.md',
      },
    };

    const jsonEncoder = JsonEncoder.withIndent('  ');
    context.setStatusCode(200, responseBody: jsonEncoder.convert(releaseData));

    return const Component.empty();
  },
);
