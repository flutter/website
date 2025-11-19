// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../models/on_this_page_model.dart';
import '../common/client/on_this_page_button.dart';
import '../common/material_icon.dart';
import '../util/component_ref.dart';
import 'client/pagenav.dart';

final class DashTableOfContents extends StatelessComponent {
  const DashTableOfContents(this.data);

  final OnThisPageData data;

  @override
  Component build(BuildContext _) {
    return nav(id: 'toc-side', [
      const OnThisPageButton(),
      _TocContents(data),
    ]);
  }

  static Component asDropdown(
    OnThisPageData data, {
    required String currentTitle,
  }) {
    return Builder(
      builder: (context) {
        return PageNav(
          title: currentTitle,
          content: context.ref(
            div([
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
          ),
        );
      },
    );
  }
}

final class _TocContents extends StatelessComponent {
  const _TocContents(this.data);

  final OnThisPageData data;

  @override
  Component build(BuildContext _) => ul(
    classes: 'toc-list',
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
