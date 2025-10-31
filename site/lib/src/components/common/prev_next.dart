// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import 'material_icon.dart';

/// Previous and next page buttons to display at the end of a page
/// in a connected series of pages, such as the language docs.
class PrevNext extends StatelessComponent {
  const PrevNext({super.key, this.previousPage, this.nextPage});

  final ({String url, String title})? previousPage;
  final ({String url, String title})? nextPage;

  @override
  Component build(BuildContext context) {
    if (previousPage == null && nextPage == null) {
      return const Component.empty();
    }

    return nav(id: 'site-prev-next', [
      if (previousPage case final previousPage?)
        _PrevNextCard(page: previousPage, isPrevious: true),
      if (nextPage case final nextPage?)
        _PrevNextCard(page: nextPage, isPrevious: false),
    ]);
  }
}

class _PrevNextCard extends StatelessComponent {
  const _PrevNextCard({required this.page, required this.isPrevious});

  final ({String url, String title}) page;
  final bool isPrevious;

  @override
  Component build(BuildContext context) {
    final classes = isPrevious ? 'prev' : 'next';
    final subtitle = isPrevious ? 'Previous' : 'Next';
    final ariaLabel = isPrevious ? 'Previous page: ' : 'Next page: ';

    return a(classes: classes, href: page.url, [
      if (isPrevious) const MaterialIcon('chevron_left'),
      div([
        span(
          classes: 'prev-next-subtitle',
          attributes: {'aria-label': ariaLabel},
          [text(subtitle)],
        ),
        span(classes: 'prev-next-title', [text(page.title)]),
      ]),
      if (!isPrevious) const MaterialIcon('chevron_right'),
    ]);
  }
}
