// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../models/on_this_page_model.dart';
import '../common/client/on_this_page_button.dart';
import '../common/material_icon.dart';

final class WideTableOfContents extends StatelessComponent {
  const WideTableOfContents(this.data);

  final OnThisPageData data;

  @override
  Component build(BuildContext _) {
    return nav(id: 'toc-side', classes: 'site-toc', [
      const OnThisPageButton(),
      _TocContents(data),
    ]);
  }
}

final class NarrowTableOfContents extends StatelessComponent {
  const NarrowTableOfContents(
    this.data, {
    required this.currentTitle,
  });

  final OnThisPageData data;
  final String currentTitle;

  @override
  Component build(BuildContext _) {
    return div(id: 'toc-top', classes: 'site-toc dropdown', [
      button(
        classes: 'dropdown-button',
        attributes: {
          'title': 'Toggle the table of contents dropdown',
          'aria-expanded': 'false',
          'aria-controls': 'toc-dropdown',
          'aria-label': 'Toggle the table of contents dropdown',
        },
        [
          span(classes: 'toc-intro', [
            const MaterialIcon('list'),
            span(
              attributes: {'aria-label': 'On this page'},
              [
                text('On this page'),
              ],
            ),
          ]),
          span(classes: 'toc-current', [
            const MaterialIcon('chevron_right'),
            span(id: 'current-header', [text(currentTitle)]),
          ]),
        ],
      ),
      div(id: 'toc-dropdown', classes: 'dropdown-content', [
        a(
          href: '#site-content-title',
          id: 'return-to-top',
          [
            const MaterialIcon('vertical_align_top'),
            span([text(currentTitle)]),
          ],
        ),
        div(
          classes: 'dropdown-divider',
          attributes: {'aria-hidden': 'true', 'role': 'separator'},
          [],
        ),
        nav(
          attributes: {'role': 'menu'},
          [_TocContents(data)],
        ),
      ]),
    ]);
  }
}

final class _TocContents extends StatelessComponent {
  const _TocContents(this.data);

  final OnThisPageData data;

  @override
  Component build(BuildContext _) => ul(
    classes: 'styled-toc-list',
    _buildEntries(data.topLevelEntries, 0),
  );

  List<Component> _buildEntries(List<OnThisPageEntry> entries, int depth) {
    final nextDepth = depth + 1;

    return [
      for (final entry in entries)
        li([
          span(classes: 'sidenav-item', [
            a(
              href: '#${entry.id}',
              [text(entry.text)],
            ),
          ]),
          if (entry.children.isNotEmpty)
            ul(_buildEntries(entry.children, nextDepth)),
        ]),
    ];
  }
}
