// Copyright (c) 2026, the Dart project authors. All rights reserved.
// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../common/material_icon.dart';

/// The minimum number of top-level entries an article needs to have
/// before a table of contents is worth showing.
const _minEntriesForToc = 2;

/// Displays an automatically generated table of contents for the current
/// page, derived from the `h2` and `h3` headings found in its rendered
/// content.
///
/// Requires [TableOfContentsExtension] to be applied to the page so that
/// its headings are available as a [TableOfContents] under the page's `toc`
/// data.
///
/// Renders nothing if the page doesn't contain enough headings to warrant
/// a table of contents.
final class BlogTableOfContents extends StatelessComponent {
  const BlogTableOfContents({super.key});

  @override
  Component build(BuildContext context) {
    final toc = context.page.data['toc'] as TableOfContents?;
    if (toc == null || toc.entries.length < _minEntriesForToc) {
      return const Component.empty();
    }

    return nav(
      classes: 'toc',
      attributes: {'aria-label': 'Table of contents'},
      [
        Component.element(
          tag: 'details',
          children: [
            const Component.element(
              tag: 'summary',
              children: [
                MaterialIcon('chevron_right'),
                .text('On this page'),
              ],
            ),
            div(classes: 'toc-list', [toc.build()]),
          ],
        ),
      ],
    );
  }
}
