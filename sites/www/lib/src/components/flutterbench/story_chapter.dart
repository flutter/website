// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Renders one numbered "story chapter" section for the FlutterBench
/// methodology page, matching the chapter treatment used on the original
/// docs version of this page (numbered sticky headers with per-chapter
/// accent colors).
///
/// When [children] is empty, no `.chapter-content` wrapper is rendered,
/// producing a heading-only chapter.
class StoryChapter extends StatelessComponent {
  const StoryChapter({
    required this.number,
    required this.title,
    required this.anchorId,
    this.children = const [],
    super.key,
  });

  /// The two-digit chapter number, e.g. `'01'`.
  final String number;
  final String title;
  final String anchorId;
  final List<Component> children;

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'story-chapter',
      attributes: {'data-chapter': number},
      [
        div(classes: 'chapter-header-group', [
          div(classes: 'chapter-kicker', [
            span(classes: 'chapter-number', [.text(number)]),
            const span(classes: 'chapter-rule', []),
          ]),
          div(classes: 'header-wrapper', [
            h2(id: anchorId, [.text(title)]),
            a(href: '#$anchorId', classes: 'heading-link', const [.text('#')]),
          ]),
        ]),
        if (children.isNotEmpty) div(classes: 'chapter-content', children),
      ],
    );
  }
}

/// Renders an `h3` with the same anchor-link treatment [StoryChapter] gives
/// its chapter headings, for sub-headings inside a chapter's content.
Component storyH3(String text, {String? id}) {
  final headingId = id ?? _slugify(text);
  return div(classes: 'header-wrapper', [
    h3(id: headingId, [.text(text)]),
    a(href: '#$headingId', classes: 'heading-link', const [.text('#')]),
  ]);
}

/// Renders an `h4` with the same anchor-link treatment [StoryChapter] gives
/// its chapter headings, for sub-sub-headings inside a chapter's content.
Component storyH4(String text, {String? id}) {
  final headingId = id ?? _slugify(text);
  return div(classes: 'header-wrapper', [
    h4(id: headingId, [.text(text)]),
    a(href: '#$headingId', classes: 'heading-link', const [.text('#')]),
  ]);
}

String _slugify(String text) => text
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
    .trim()
    .replaceAll(RegExp(r'\s+'), '-');
