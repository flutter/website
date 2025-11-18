// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../models/page_navigation_model.dart';
import '../../util.dart';
import '../common/client/on_this_page_button.dart';
import '../common/material_icon.dart';
import '../util/component_ref.dart';
import 'client/pagenav.dart';

final class DashTableOfContents extends StatelessComponent {
  const DashTableOfContents(this.data);

  final TocNavigationData data;

  @override
  Component build(BuildContext _) {
    return nav(id: 'toc-side', [
      const OnThisPageButton(),
      _TocContents(data),
    ]);
  }
}

final class PageNavBar extends StatelessComponent {
  const PageNavBar(this.data);

  final PageNavigationData data;

  @override
  Component build(BuildContext context) {
    final currentLinkedPage = data.pageEntries
        .where((page) => page.url == context.page.url)
        .firstOrNull;

    final linkedPageTitle = currentLinkedPage?.title;
    final currentTitle = context.page.data.page['title'] as String;

    var pageEntryNumber = 1;

    return PageNav(
      label: linkedPageTitle,
      title: currentTitle,
      content: context.ref(
        div([
          if (data.pageEntries.isEmpty) ...[
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
            if (data.toc != null)
              nav(
                attributes: {'role': 'menu'},
                [_TocContents(data.toc!)],
              ),
          ] else ...[
            for (final page in data.pageEntries) ...[
              if (!page.isDivider) ...[
                a(
                  classes: [
                    'page-link',
                    if (page == currentLinkedPage) 'active',
                  ].toClasses,
                  href: page.url,
                  attributes: {'role': 'menuitem'},
                  [
                    span(classes: 'page-number', [
                      text('${pageEntryNumber++}'),
                    ]),
                    text(page.title),
                  ],
                ),
                if (currentLinkedPage == page && data.toc != null)
                  nav(
                    attributes: {'role': 'menu'},
                    [_TocContents(data.toc!)],
                  ),
              ] else ...[
                if (page != data.pageEntries.first)
                  div(
                    classes: 'dropdown-divider',
                    attributes: {'aria-hidden': 'true', 'role': 'separator'},
                    [],
                  ),
                div(
                  classes: 'page-divider',
                  [text(page.title)],
                ),
              ],
            ],
          ],
        ]),
      ),
    );
  }
}

final class _TocContents extends StatelessComponent {
  const _TocContents(this.data);

  final TocNavigationData data;

  @override
  Component build(BuildContext _) => ul(
    classes: 'toc-list',
    _buildEntries(data.topLevelEntries, 0),
  );

  List<Component> _buildEntries(List<TocNavigationEntry> entries, int depth) {
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
