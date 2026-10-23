// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../common/material_icon.dart';

/// The minimum number of top-level entries an article needs to have
/// before a table of contents is worth showing.
const int _minEntriesForToc = 2;

/// A collapsible table of contents for a blog post,
/// listing the post's `h2` and `h3` headings.
///
/// Requires [TableOfContentsExtension] to be registered,
/// which stores the headings in the page's `toc` data.
/// Renders nothing if the post sets `showToc: false` in its front matter or
/// has fewer than two `h2` headings.
final class BlogTableOfContents extends StatelessComponent {
  const BlogTableOfContents({super.key});

  @override
  Component build(BuildContext context) {
    final page = context.page;
    final pageData = page.data;
    final toc = pageData['toc'];
    if (pageData.page['showToc'] == false ||
        toc is! TableOfContents ||
        toc.entries.length < _minEntriesForToc) {
      return const .empty();
    }

    return nav(
      classes: 'blog-toc',
      attributes: {'aria-label': 'In this article'},
      [
        details(
          [
            const summary(
              [
                MaterialIcon('chevron_right'),
                .text('In this article'),
              ],
            ),
            _buildList(toc.entries, page.url),
          ],
        ),
      ],
    );
  }

  static Component _buildList(List<TocEntry> entries, String pageUrl) => ul([
    for (final entry in entries)
      li([
        a(href: '$pageUrl#${entry.id}', [.text(entry.text)]),
        if (entry.children.isNotEmpty) _buildList(entry.children, pageUrl),
      ]),
  ]);
}
