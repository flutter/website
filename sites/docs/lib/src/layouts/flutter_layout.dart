// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/breadcrumbs.dart';
import 'package:site_shared/layouts.dart';
import 'package:site_shared/structured_data.dart';
import 'package:site_shared/util.dart';

import '../components/layout/footer.dart';
import '../components/layout/header.dart';
import '../components/layout/sidenav.dart';
import '../models/sidenav_model.dart';
import '../pages/markdown.dart';
import '../style_hash.dart';

/// The base Jaspr Content layout for wrapping site content.
abstract class FlutterDocsLayout extends DashLayout {
  const FlutterDocsLayout();

  @override
  String get name;

  @override
  String get siteHost => 'docs.flutter.dev';
  @override
  String get iconUrl => '/assets/images/branding/flutter/icon/64.png';
  @override
  String get iconUrlApple =>
      '/assets/images/branding/flutter/logo/flutter-logomark-320px.png';
  @override
  String get twitterSiteTag => '@flutterdev';
  @override
  String get twitterDefaultImageUrl =>
      '/assets/images/flutter-logo-sharing.png';

  @override
  String get tagManagerId => 'GTM-ND4LWWZ';
  @override
  String get analyticsId => 'UA-67589403-1';

  @override
  String get stylesHash => generatedStylesHash;

  String get defaultSidenav => 'default';

  bool get allowBreadcrumbs => true;

  /// Whether breadcrumbs should be shown for [page],
  /// honoring both the layout's [allowBreadcrumbs] and
  /// the page's `showBreadcrumbs` metadata.
  bool showBreadcrumbsFor(Page page) =>
      allowBreadcrumbs && (page.data.page['showBreadcrumbs'] as bool? ?? true);

  @override
  Iterable<Component> buildExtraHead(Page page) {
    return [
      if (canonicalMarkdownOutput.routeForPage(page) case final markdownRoute?)
        link(
          rel: 'alternate',
          type: 'text/markdown',
          href: markdownRoute,
          attributes: const {'title': 'Markdown'},
        ),
      Builder(
        builder: (context) {
          final pageData = page.data.page;
          final breadcrumbs = showBreadcrumbsFor(page)
              ? breadcrumbsForPage(context.pages, page)
              : null;
          final structuredData = buildPageStructuredData(
            siteUrl: page.data.site['url'] as String,
            siteName: page.data.site['name'] as String,
            siteDescription: page.data.site['description'] as String,
            pageUrl: page.url,
            title: pageData['title'] as String,
            pageDescription: pageData['description'] as String?,
            dateModified: pageData['dateModified'] as DateTime?,
            breadcrumbs: breadcrumbs,
          );

          return script(
            attributes: const {'type': 'application/ld+json'},
            content: encodeJsonLdForHtml(structuredData),
          );
        },
      ),
      if (productionBuild)
        const meta(
          name: 'google-site-verification',
          content: 'HFqxhSbf9YA_0rBglNLzDiWnrHiK_w4cqDh2YD2GEY4',
        ),
    ];
  }

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final pageUrl = page.url.startsWith('/') ? page.url : '/${page.url}';

    final sidenavs = page.data['sidenav'] as Map<String, Object?>;
    final pageSidenavKey = pageData['sidenav'] as String? ?? defaultSidenav;
    final sideNavEntries = navEntriesFromData(
      sidenavs[pageSidenavKey] as List<Object?>,
    );

    final obsolete = pageData['obsolete'] == true;

    return .fragment([
      const DashHeader(),
      div(id: 'site-below-header', [
        div(id: 'site-main-row', [
          DashSideNav(
            navEntries: sideNavEntries,
            currentPageUrl: pageUrl,
          ),
          main_(
            id: 'page-content',
            classes: [
              if (pageData['focusedLayout'] == true) 'focused',
            ].toClasses,
            [child],
          ),
          if (obsolete)
            const div(id: 'obsolete-banner', [
              div(classes: 'text-center', [
                .text('Some content on this page might be out of date.'),
              ]),
            ]),
        ]),
        const DashFooter(),
      ]),
      // Scroll the sidenav to the active item before other logic
      // to avoid it jumping after page load.
      const script(
        content: '''
const sidenav = document.getElementById('sidenav');
if (sidenav) {
  const activeEntries = sidenav.querySelectorAll('.nav-link.active');
  if (activeEntries.length > 0) {
    const activeEntry = activeEntries[activeEntries.length - 1];

    sidenav.scrollTo({
      top: activeEntry.offsetTop - window.innerHeight / 3,
    });
  }
}
      ''',
      ),
    ]);
  }
}
