// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/common/page_header.dart';
import '../components/common/prev_next.dart';
import '../components/layout/banner.dart';
import '../components/layout/toc.dart';
import '../components/layout/trailing_content.dart';
import '../models/page_navigation_model.dart';
import 'dash_layout.dart';

/// The Jaspr Content layout to use for normal docs pages,
/// adding elements such as breadcrumbs, TOC, and prev/next cards.
class DocLayout extends FlutterDocsLayout {
  const DocLayout();

  @override
  String get name => 'docs';

  bool get allowBreadcrumbs => true;

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final siteData = page.data.site;

    final pageTitle = pageData['title'] as String;
    final pageDescription = (pageData['description'] as String?)?.trim();
    final showBanner =
        (pageData['showBanner'] as bool?) ??
        (siteData['showBanner'] as bool?) ??
        false;
    final navigationData = page.navigationData;

    return super.buildBody(
      page,
      .fragment(
        [
          if (navigationData
              case null || PageNavigationData(toc: null, pageEntries: []))
            const Document.body(attributes: {'data-toc': 'false'})
          else
            div(
              id: 'site-subheader',
              classes: navigationData.pageEntries.isNotEmpty
                  ? 'show-always'
                  : null,
              [
                PageNavBar(navigationData),
              ],
            ),
          if (showBanner)
            if (siteData['bannerHtml'] case final String bannerHtml
                when bannerHtml.trim().isNotEmpty)
              DashBanner(bannerHtml),
          div(classes: 'after-leading-content', [
            if (navigationData case PageNavigationData(
              toc: final toc?,
              pageEntries: [],
            ))
              aside(id: 'side-menu', [
                DashTableOfContents(toc),
              ]),
            article([
              PageHeader(
                title: pageTitle,
                description: pageDescription,
                showBreadcrumbs:
                    allowBreadcrumbs &&
                    (pageData['showBreadcrumbs'] as bool? ?? true),
              ),

              child,

              PrevNext(
                previousPage: PageNavigationEntry.fromData(pageData['prev']),
                nextPage: PageNavigationEntry.fromData(pageData['next']),
              ),
              const TrailingContent(),
            ]),
          ]),
        ],
      ),
    );
  }
}
