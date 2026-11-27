// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/card.dart';
import 'package:site_shared/seo.dart';

import 'doc_layout.dart';

class TocLayout extends DocLayout {
  const TocLayout();

  @override
  String get name => 'toc';

  @override
  Component buildBody(Page page, Component child) {
    return super.buildBody(
      page,
      Builder(
        builder: (context) {
          final normalizedCurrentUrl = _normalizeUrl(page.url);

          // Find all direct child pages of the current page and sort them
          // deterministically: first by frontmatter 'order', then by path.
          final childPages = [
            for (final pageToCheck in context.pages)
              if (_isDirectChild(normalizedCurrentUrl, pageToCheck.url) &&
                  !isNoIndexFlag(pageToCheck.data.page['noindex']))
                pageToCheck,
          ]..sort(_compareChildPages);

          return .fragment([
            if (childPages.isNotEmpty)
              div(classes: 'card-grid very-wide', [
                for (final childPage in childPages)
                  Card(
                    link: childPage.url,
                    header: [
                      span(classes: 'card-title', [
                        .text(childPage.data.page['title'] as String),
                      ]),
                    ],
                    content: [
                      if (childPage.data.page['description']
                          case final String description)
                        p([.text(description)]),
                    ],
                    filled: true,
                  ),
              ]),
            child,
          ]);
        },
      ),
    );
  }

  static int _compareChildPages(Page pageA, Page pageB) {
    final aOrder = (pageA.data.page['order'] as num?)?.toInt();
    final bOrder = (pageB.data.page['order'] as num?)?.toInt();

    if (aOrder != null && bOrder != null && aOrder != bOrder) {
      return aOrder.compareTo(bOrder);
    } else if (aOrder != null && bOrder == null) {
      return -1;
    } else if (aOrder == null && bOrder != null) {
      return 1;
    }

    return pageA.path.compareTo(pageB.path);
  }

  static String _normalizeUrl(String url) {
    return url.endsWith('/') ? url : '$url/';
  }

  static bool _isDirectChild(String normalizedCurrentUrl, String otherUrl) {
    final normalizedOtherUrl = _normalizeUrl(otherUrl);

    // Skip if the page URL doesn't start with the current URL.
    if (!normalizedOtherUrl.startsWith(normalizedCurrentUrl)) return false;

    // Skip if it's the current page itself.
    if (normalizedOtherUrl == normalizedCurrentUrl) return false;

    // Extract the remaining path after the current URL.
    final remainingPath = normalizedOtherUrl.substring(
      normalizedCurrentUrl.length,
    );

    // Check if this is a direct child by ensuring there's only one
    // path segment (no additional slashes beyond a possible trailing slash).
    final segments = remainingPath
        .split('/')
        .where((segment) => segment.isNotEmpty);

    return segments.length == 1;
  }
}
