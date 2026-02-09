// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../markdown/markdown_parser.dart';
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
  Component build(BuildContext _) => nav(id: 'toc-side', [
    const OnThisPageButton(),
    _TocContents(data),
  ]);
}

final class PageNavBar extends StatelessComponent {
  const PageNavBar(this.data);

  final PageNavigationData data;

  @override
  Component build(BuildContext context) {
    PageNavigationEntry? currentLinkedPage;
    var currentLinkedPageNumber = 1;
    String? currentDivider;

    final normalizedPageUrl = context.page.url.endsWith('/')
        ? context.page.url
        : '${context.page.url}/';

    for (final page in data.pageEntries) {
      final normalizedEntryUrl = page.url.endsWith('/')
          ? page.url
          : '${page.url}/';
      if (normalizedEntryUrl == normalizedPageUrl) {
        currentLinkedPage = page;
        break;
      }
      if (page.isDivider) {
        currentDivider = page.title;
      } else {
        currentLinkedPageNumber += 1;
      }
    }

    final linkedPageTitle = currentLinkedPage?.title;
    final currentTitle = context.page.data.page['title'] as String;

    var pageEntryNumber = 1;

    return PageNav(
      breadcrumbs: [
        ?data.parentTitle,
        if (linkedPageTitle != null) ...[?currentDivider, linkedPageTitle],
      ],
      pageNumber: linkedPageTitle != null ? currentLinkedPageNumber : null,
      initialHeading: currentTitle,
      content: context.ref(
        div([
          if (data.pageEntries.isEmpty) ...[
            a(
              href: '#site-content-title',
              classes: 'pagenav-title',
              [
                const MaterialIcon('vertical_align_top'),
                span([.text(currentTitle)]),
              ],
            ),
            const _DropdownDivider(),
            if (data.toc case final tocData?)
              nav(
                attributes: {'role': 'menu'},
                [_TocContents(tocData)],
              ),
          ] else ...[
            if (data case PageNavigationData(
              :final parentTitle?,
              :final parentUrl?,
            )) ...[
              a(
                href: parentUrl,
                classes: 'pagenav-title',
                [
                  const MaterialIcon('school'),
                  span([.text(parentTitle)]),
                ],
              ),
              const _DropdownDivider(),
            ],
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
                      .text('${pageEntryNumber++}'),
                    ]),
                    DashMarkdown(inline: true, content: page.title),
                  ],
                ),
                if (data.toc case final tocData? when currentLinkedPage == page)
                  nav(
                    attributes: {'role': 'menu'},
                    [_TocContents(tocData)],
                  ),
              ] else ...[
                if (page != data.pageEntries.first) const _DropdownDivider(),
                div(
                  classes: 'page-divider',
                  [.text(page.title)],
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
              [.text(entry.text)],
            ),
          ]),
          if (entry.children.isNotEmpty)
            ul(_buildEntries(entry.children, nextDepth)),
        ]),
    ];
  }
}

class _DropdownDivider extends StatelessComponent {
  const _DropdownDivider();

  @override
  Component build(BuildContext _) => const div(
    classes: 'dropdown-divider',
    attributes: {'aria-hidden': 'true', 'role': 'separator'},
    [],
  );
}
