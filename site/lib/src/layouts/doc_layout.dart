// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/breadcrumbs.dart';
import '../components/prev_next.dart';
import '../components/toc.dart';
import '../components/trailing_content.dart';
import '../extensions/header_extractor.dart';
import '../models/on_this_page_model.dart';
import '../util.dart';
import 'dash_layout.dart';

/// The Jaspr Content layout to use for normal docs pages,
/// adding elements such as breadcrumbs, TOC, and prev/next cards.
class DocLayout extends FlutterDocsLayout {
  const DocLayout();

  @override
  String get name => 'docs';

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final pageTitle = pageData['title'] as String;
    final tocData = _tocForPage(page);

    return super.buildBody(
      page,
      Component.fragment(
        [
          if (tocData == null)
            const Document.body(attributes: {'data-toc': 'false'})
          else
            NarrowTableOfContents(
              tocData,
              currentTitle: pageTitle,
            ),
          div(classes: 'after-leading-content', [
            if (tocData != null)
              aside(id: 'side-menu', [
                WideTableOfContents(tocData),
              ]),
            article([
              div(classes: 'content', [
                div(id: 'site-content-title', [
                  h1(id: 'document-title', [
                    if (pageData['underscore_breaker_titles'] == true)
                      ...splitByUnderscore(pageTitle)
                    else
                      text(pageTitle),
                  ]),
                  if (pageData['showBreadcrumbs'] != false)
                    const PageBreadcrumbs(),
                ]),

                child,

                PrevNext(
                  previousPage: _pageInfoFromObject(pageData['prevpage']),
                  nextPage: _pageInfoFromObject(pageData['nextpage']),
                ),
                const TrailingContent(),
              ]),
            ]),
          ]),
        ],
      ),
    );
  }

  OnThisPageData? _tocForPage(Page page) {
    final pageData = page.data.page;
    final showToc = pageData['showToc'] as bool? ?? true;

    // If 'showToc' was explicitly set to false, hide the toc.
    if (!showToc) return null;

    final onThisPageData = OnThisPageData.fromContentHeaders(
      page.data['contentHeaders'] as List<ContentHeader>? ?? const [],
      minLevel: pageData['minTocDepth'] as int? ?? 2,
      maxLevel: pageData['maxTocDepth'] as int? ?? 3,
    );

    // If there are less than 2 top-level entries, hide the toc.
    if (onThisPageData.topLevelEntries.length < 2) return null;

    return onThisPageData;
  }
}

({String url, String title})? _pageInfoFromObject(Object? data) {
  if (data case {
    'url': final String pageUrl,
    'title': final String pageTitle,
  }) {
    return (url: pageUrl, title: pageTitle);
  }

  return null;
}
