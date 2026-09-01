// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'doc_layout.dart';

/// The Jaspr Content layout for storytelling pages.
///
/// Provides a generous spatial rhythm, subtle chapter indicators,
/// wide-canvas breakout styling, and a scroll-driven reading progress line.
class StoryLayout extends DocLayout {
  const StoryLayout();

  @override
  String get name => 'story';

  @override
  List<String> get defaultBodyClasses => const ['layout-story'];

  @override
  Component? buildLeadingContent(Page page) {
    return const div(classes: 'story-reading-progress', [
      div(classes: 'story-reading-progress-bar', []),
    ]);
  }

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final showToc = pageData['showToc'] as bool? ?? false;

    return super.buildBody(
      page..apply(
        data: {
          'page': {
            'showToc': showToc,
            'showPageHeader': false,
          },
        },
      ),
      child,
    );
  }
}
