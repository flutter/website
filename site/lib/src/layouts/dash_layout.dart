// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/layouts/dash_layout.dart';

import '../components/layout/footer.dart';
import '../components/layout/header.dart';
import '../components/layout/sidenav.dart';
import '../models/sidenav_model.dart';
import '../style_hash.dart';
import '../util.dart';

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

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final pageUrl = page.url.startsWith('/') ? page.url : '/${page.url}';

    final sideNavEntries = switch (page.data['sidenav']) {
      final List<Object?> sidenavData => navEntriesFromData(sidenavData),
      _ => null,
    };
    final obsolete = pageData['obsolete'] == true;

    return .fragment([
      const DashHeader(),
      div(id: 'site-below-header', [
        div(id: 'site-main-row', [
          if (sideNavEntries != null)
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
