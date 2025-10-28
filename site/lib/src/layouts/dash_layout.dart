// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert' show htmlEscape;

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../client/global_scripts.dart';
import '../components/common/client/cookie_notice.dart';
import '../components/layout/footer.dart';
import '../components/layout/header.dart';
import '../components/layout/sidenav.dart';
import '../models/sidenav_model.dart';
import '../style_hash.dart';
import '../util.dart';

/// The base Jaspr Content layout for wrapping site content.
abstract class FlutterDocsLayout extends PageLayoutBase {
  const FlutterDocsLayout();

  @override
  String get name;

  @override
  @mustCallSuper
  Iterable<Component> buildHead(Page page) {
    final pageData = page.data.page;
    final siteData = page.data.site;
    final pageTitle = (pageData['title'] ?? siteData['title']) as String;
    final pageDescription = pageData['description'] as String? ?? '';

    return [
      ...super.buildHead(page),
      if (pageData['noindex'] case final noIndex?
          when noIndex == true || noIndex == 'true')
        meta(name: 'robots', content: 'noindex'),
      if (pageData['canonical'] case final String canonicalUrl
          when canonicalUrl.isNotEmpty)
        link(rel: 'canonical', href: canonicalUrl),
      if (pageData['redirectTo'] case final String redirectTo
          when redirectTo.isNotEmpty)
        raw('<script>window.location.replace("$redirectTo");</script>'),
      link(
        rel: 'icon',
        href: '/assets/images/branding/flutter/icon/64.png',
        attributes: {'sizes': '64x64'},
      ),
      link(
        rel: 'apple-touch-icon',
        href: '/assets/images/branding/flutter/logo/flutter-logomark-320px.png',
      ),
      meta(name: 'twitter:card', content: 'summary'),
      meta(name: 'twitter:site', content: '@flutterdev'),
      meta(name: 'twitter:title', content: pageTitle),
      meta(
        name: 'twitter:description',
        content: pageDescription,
      ),

      meta(attributes: {'property': 'og:title', 'content': pageTitle}),
      meta(
        attributes: {
          'property': 'og:description',
          'content': pageDescription,
        },
      ),
      meta(attributes: {'property': 'og:url', 'content': page.path}),
      meta(
        attributes: {
          'property': 'og:image',
          'content': '/assets/images/flutter-logo-sharing.png',
        },
      ),

      link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
      link(
        rel: 'preconnect',
        href: 'https://fonts.gstatic.com',
        attributes: {'crossorigin': ''},
      ),
      link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap',
      ),
      link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.com/css2?family=Google+Sans+Mono:wght@400;500;700&display=swap',
      ),
      link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.com/css2?family=Google+Sans+Text:wght@400;500;700&display=swap',
      ),
      link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0..1,0',
      ),
      link(
        rel: 'stylesheet',
        href:
            '/assets/css/main.css?'
            'hash=${htmlEscape.convert(generatedStylesHash)}',
      ),

      if (pageData['js'] case final List<Object?> jsList)
        for (final js in jsList)
          if (js case {'url': final String jsUrl, 'defer': final Object? defer})
            script(
              src: jsUrl,
              attributes: {if (defer == 'true' || defer == true) 'defer': ''},
            ),
      script(
        src:
            'https://cdn.jsdelivr.net/npm/@justinribeiro/lite-youtube@1.8.2/lite-youtube.js',
        attributes: {
          'type': 'module',
          'integrity': 'sha256-Jy0j0fUMJ2T3WxSEs2WjHLrS+3DlO7S9DItQtP55FII=',
          'crossorigin': 'anonymous',
          'referrerpolicy': 'no-referrer',
        },
      ),

      // Set up tag manager and analytics.
      if (productionBuild)
        raw('''
<meta name="google-site-verification" content="HFqxhSbf9YA_0rBglNLzDiWnrHiK_w4cqDh2YD2GEY4">
<script>
  window.dataLayer = window.dataLayer || [];
</script>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-ND4LWWZ');</script>

<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-67589403-1', 'auto');
ga('send', 'pageview');
</script>
'''),
    ];
  }

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final bodyClass = pageData['bodyClass'] as String?;
    final pageUrl = page.url.startsWith('/') ? page.url : '/${page.url}';
    final sideNavEntries = switch (page.data['sidenav']) {
      final List<Object?> sidenavData => navEntriesFromData(sidenavData),
      _ => null,
    };
    final obsolete = pageData['obsolete'] == true;

    return Component.fragment(
      [
        const Document.html(
          attributes: {
            'lang': 'en',
            'dir': 'ltr',
          },
        ),
        if (bodyClass != null) Document.body(attributes: {'class': bodyClass}),
        if (productionBuild)
          raw(
            '<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-ND4LWWZ" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>',
          ),
        a(
          id: 'skip-to-main',
          classes: 'filled-button',
          href: '#site-content-title',
          [text('Skip to main content')],
        ),
        const CookieNotice(),
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
              div(id: 'obsolete-banner', [
                div(classes: 'text-center', [
                  text('Some content on this page might be out of date.'),
                ]),
              ]),
          ]),
          const DashFooter(),
        ]),
        // The theme setting logic should remain before other scripts to
        // avoid a flash of the initial theme on load.
        raw('''
<script>
const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)');

const storedTheme = window.localStorage.getItem('theme') ?? 'light-mode';
if (storedTheme === 'auto-mode') {
  document.body.classList.add(
      'auto-mode',
      prefersDarkMode.matches ? 'dark-mode' : 'light-mode',
  );
} else {
  document.body.classList.add(storedTheme);
}
</script>
      '''),
        // Scroll the sidenav to the active item before other logic
        // to avoid it jumping after page load.
        raw('''
<script>
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
</script>
      '''),
        GlobalScripts(),
      ],
    );
  }
}
