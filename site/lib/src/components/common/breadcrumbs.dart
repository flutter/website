// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../util.dart';
import 'material_icon.dart';

/// Breadcrumbs navigation component that
/// follows ARIA guidelines and includes RDFa markup.
///
/// References:
/// - https://developers.google.com/search/docs/data-types/breadcrumb
/// - https://schema.org/BreadcrumbList
/// - https://www.w3.org/TR/wai-aria-practices/examples/breadcrumb/index.html
class PageBreadcrumbs extends StatelessComponent {
  const PageBreadcrumbs({super.key});

  @override
  Component build(BuildContext context) {
    final crumbs = _breadcrumbsForPage(context.pages, context.page);
    if (crumbs == null || crumbs.isEmpty) {
      return const Component.empty();
    }

    return nav(
      classes: 'breadcrumbs',
      attributes: {'aria-label': 'breadcrumb'},
      [
        ol(
          classes: 'breadcrumb-list',
          attributes: {
            'vocab': 'https://schema.org/',
            'typeof': 'BreadcrumbList',
          },
          [
            for (var i = 0; i < crumbs.length; i++)
              _BreadcrumbItemComponent(
                crumb: crumbs[i],
                index: i,
                isLast: i == crumbs.length - 1,
              ),
          ],
        ),
      ],
    );
  }

  /// Extract breadcrumbs from page data.
  ///
  /// Uses page metadata to generate breadcrumb titles with fallbacks:
  /// `breadcrumb` > `shortTitle` > `title`.
  List<_BreadcrumbItem>? _breadcrumbsForPage(List<Page> pages, Page page) {
    final pageUrl = page.url;

    // Only show breadcrumbs if the URL isn't empty.
    if (pageUrl.isEmpty || pageUrl == '/') return null;

    final pageBreadcrumb = page.breadcrumb;
    if (pageBreadcrumb == null) {
      return null;
    }

    final segments = pageUrl
        .split('/')
        .where((s) => s.isNotEmpty)
        .toList(growable: false);
    if (segments.isEmpty) return null;

    final breadcrumbs = <_BreadcrumbItem>[];
    var currentPath = '';

    // Build breadcrumbs for each segment except the current page.
    for (var i = 0; i < segments.length - 1; i++) {
      currentPath += '/${segments[i]}';

      // Try to find the index page for this directory.
      final indexPage = pages.firstWhereOrNull(
        (p) => p.url == currentPath,
      );

      // Skip if no index page found.
      if (indexPage == null) continue;

      if (indexPage.breadcrumb case final indexBreadcrumb?) {
        breadcrumbs.add(
          _BreadcrumbItem(
            title: indexBreadcrumb,
            url: indexPage.url,
          ),
        );
      }
    }

    // If there are no parent breadcrumbs and this isn't a top-level doc,
    // don't render the single one.
    if (breadcrumbs.isEmpty && segments.length > 1) {
      return null;
    }

    // Add the current page as the final breadcrumb.
    breadcrumbs.add(
      _BreadcrumbItem(
        title: pageBreadcrumb,
        url: pageUrl,
      ),
    );

    return breadcrumbs;
  }
}

extension on Page {
  String? get breadcrumb {
    final pageData = data.page;

    final breadcrumbString =
        pageData['breadcrumb'] ?? pageData['shortTitle'] ?? pageData['title'];
    if (breadcrumbString is! String || breadcrumbString.isEmpty) {
      return null;
    }
    return breadcrumbString;
  }
}

final class _BreadcrumbItem {
  const _BreadcrumbItem({required this.title, required this.url});

  final String title;
  final String url;
}

/// An individual breadcrumb item that corresponds to one link.
final class _BreadcrumbItemComponent extends StatelessComponent {
  const _BreadcrumbItemComponent({
    required this.crumb,
    required this.index,
    required this.isLast,
  });

  final _BreadcrumbItem crumb;
  final int index;
  final bool isLast;

  @override
  Component build(BuildContext context) => li(
    classes: [
      'breadcrumb-item',
      if (isLast) 'active',
    ].toClasses,
    attributes: {
      'property': 'itemListElement',
      'typeof': 'ListItem',
      if (isLast) 'aria-current': 'page',
    },
    [
      a(
        href: crumb.url,
        attributes: {'property': 'item', 'typeof': 'WebPage'},
        [
          span(attributes: {'property': 'name'}, [text(crumb.title)]),
        ],
      ),
      meta(attributes: {'property': 'position', 'content': index.toString()}),
      if (!isLast) const MaterialIcon('chevron_right'),
    ],
  );
}
