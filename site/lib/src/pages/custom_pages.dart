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
  // TODO(schultek): Remove this test page when FWE lands.
  if (kDebugMode) _fweTestingPage,
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

MemoryPage get _fweTestingPage => const MemoryPage(
  path: 'fwe.md',
  content: '''
---
title: FWE Testing Page
description: This is a test page for experimenting with First Week Experience (FWE) features.
sitemap: false
---

<Quiz title="Flutter and Dart Basics Quiz">
- question: What is the Effective Dart guideline for the first sentence of a documentation comment?
  options:
    - text: It should be a complete paragraph with at least two sentences to provide sufficient context.
      correct: false
      explanation: The guideline recommends a short summary sentence, not a full paragraph.
    - text: It must include the names of all parameters using square brackets.
      correct: false
      explanation: Parameter names can be included elsewhere, but the first sentence is a summary.
    - text: It should be a single-sentence summary, separated from the rest of the comment by a blank line.
      correct: true
      explanation: Effective Dart recommends starting with a single-sentence summary, followed by a blank line before details.
    - text: It should always begin with the name of the member being documented.
      correct: false
      explanation: Starting with the member name is not required; a concise summary is preferred.
- question: In Flutter, which widget is typically used to create a scrollable list of items?
  options:
    - text: Column
      correct: false
      explanation: A Column is not scrollable by default; use ListView for scrollable lists.
    - text: ListView
      correct: true
      explanation: ListView is the standard widget for creating scrollable lists in Flutter.
    - text: Row
      correct: false
      explanation: A Row arranges items horizontally and is not scrollable by default.
    - text: Stack
      correct: false
      explanation: Stack is used for overlapping widgets, not for scrollable lists.
</Quiz>
''',
);
