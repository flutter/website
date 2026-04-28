// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/common/client/cookie_notice.dart';
import '../components/layout/banner.dart';
import '../util.dart';

/// The base Jaspr Content layout for all sites.
abstract class DashLayout implements PageLayout {
  const DashLayout();

  @override
  String get name;

  List<String> get defaultBodyClasses => [];

  String get defaultSidenav => 'default';

  String? get titleBase => null;
  String get siteHost;
  bool get cookieNoticeDarkMode => false;

  String get iconUrl;
  String get iconUrlApple;
  String? get iconUrlApple152 => null;
  String? get iconUrlApple167 => null;
  String? get iconUrlApple180 => null;
  String get twitterSiteTag;
  String get twitterDefaultImageUrl;

  String get tagManagerId;
  String get analyticsId;

  /// Returns page-specific URLs to eagerly speculate on, in addition to
  /// the document-level rules that match all internal links.
  ///
  /// Override in subclasses to provide page-specific URLs for
  /// eager prerendering and prefetching.
  ({Set<String> prerender, Set<String> prefetch}) speculationUrls(Page page) =>
      const (prerender: {}, prefetch: {});

  List<String> get fonts => [
    'https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap',
    'https://fonts.googleapis.com/css2?family=Google+Sans+Mono:wght@400;500;700&display=swap',
    'https://fonts.googleapis.com/css2?family=Google+Sans+Text:wght@400;500;700&display=swap',
    'https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0..1,0',
    'https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,100..900;1,100..900&display=swap',
  ];

  String get stylesHash;

  Iterable<Component> _buildHead(Page page) {
    final pageData = page.data.page;
    final siteData = page.data.site;

    final pageTitle = (pageData['title'] ?? siteData['title']) as String;
    final pageDescription = pageData['description'] as String?;
    final pageImage = pageData['image'] as String?;

    final windowTitle = titleBase != null
        ? '$pageTitle | $titleBase'
        : pageTitle;

    final canonicalUrl = pageData['canonical'] as String?;

    return [
      Component.element(tag: 'title', children: [Component.text(windowTitle)]),
      meta(name: 'description', content: pageDescription),

      // URL
      if (pageData['noindex'] case final noIndex?
          when noIndex == true || noIndex == 'true')
        const meta(name: 'robots', content: 'noindex'),
      if (canonicalUrl case final canonicalUrl? when canonicalUrl.isNotEmpty)
        link(rel: 'canonical', href: canonicalUrl),
      if (pageData['redirectTo'] case final String redirectTo
          when redirectTo.isNotEmpty)
        RawText('<script>window.location.replace("$redirectTo");</script>'),

      // Icons
      link(rel: 'icon', href: iconUrl, attributes: {'sizes': '64x64'}),
      link(rel: 'apple-touch-icon', href: iconUrlApple),
      if (iconUrlApple152 case final url?)
        link(
          rel: 'apple-touch-icon',
          href: url,
          attributes: {'sizes': '152x152'},
        ),
      if (iconUrlApple180 case final url?)
        link(
          rel: 'apple-touch-icon',
          href: url,
          attributes: {'sizes': '180x180'},
        ),
      if (iconUrlApple167 case final url?)
        link(
          rel: 'apple-touch-icon',
          href: url,
          attributes: {'sizes': '167x167'},
        ),

      // Social
      meta(
        name: 'twitter:card',
        content: pageImage != null ? 'summary_large_image' : 'summary',
      ),
      meta(name: 'twitter:site', content: twitterSiteTag),
      meta(name: 'twitter:title', content: pageTitle),
      if (pageDescription case final String desc)
        meta(name: 'twitter:description', content: desc),
      if (pageImage case final String img)
        meta(name: 'twitter:image', content: img),

      meta(attributes: {'property': 'og:title', 'content': pageTitle}),
      if (pageDescription case final String desc)
        meta(attributes: {'property': 'og:description', 'content': desc}),
      meta(
        attributes: {
          'property': 'og:url',
          'content': canonicalUrl ?? page.path,
        },
      ),
      meta(
        attributes: {
          'property': 'og:image',
          'content': pageImage ?? twitterDefaultImageUrl,
        },
      ),

      // Fonts
      const link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
      const link(
        rel: 'preconnect',
        href: 'https://fonts.gstatic.com',
        attributes: {'crossorigin': ''},
      ),
      for (final font in fonts) link(rel: 'stylesheet', href: font),

      // Styles
      link(
        rel: 'stylesheet',
        href: '/assets/css/main.css?hash=${htmlEscape.convert(stylesHash)}',
      ),

      const script(
        src:
            'https://cdn.jsdelivr.net/npm/@justinribeiro/lite-youtube@1.8.2/lite-youtube.js',
        attributes: {
          'type': 'module',
          'integrity': 'sha256-Jy0j0fUMJ2T3WxSEs2WjHLrS+3DlO7S9DItQtP55FII=',
          'crossorigin': 'anonymous',
          'referrerpolicy': 'no-referrer',
        },
      ),

      // Tag Manager and Analytics
      if (productionBuild) ...[
        const script(content: 'window.dataLayer = window.dataLayer || [];'),
        script(
          content:
              '''
(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','$tagManagerId');
''',
        ),
        script(
          content:
              '''
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', '$analyticsId', 'auto');
ga('send', 'pageview');
''',
        ),
      ],

      // Add speculation rules and prefetch fallback links for
      // URLs provided by subclass overrides of speculationUrls.
      ..._buildSpeculationRulesHead(page),
    ];
  }

  Component buildBody(Page page, Component child);

  @override
  Component buildLayout(Page page, Component child) {
    final pageData = page.data.page;
    final bodyClass = pageData['bodyClass'] as String?;

    return Component.element(
      tag: 'html',
      attributes: {'lang': 'en', 'dir': 'ltr'},
      children: [
        Component.element(
          tag: 'head',
          children: [
            const meta(charset: 'utf-8'),
            const meta(
              name: 'viewport',
              content: 'width=device-width, initial-scale=1',
            ),
            ..._buildHead(page),
          ],
        ),
        Component.element(
          tag: 'body',
          classes: [?bodyClass, ...defaultBodyClasses].toClasses,
          children: [
            // The theme setting logic should remain before other scripts to
            // avoid a flash of the initial theme on load.
            const script(
              content: '''
try {
  const storedTheme = window.localStorage.getItem('theme') ?? 'light-mode';
  if (storedTheme === 'auto-mode') {
    const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)');
    document.body.classList.add(
        'auto-mode',
        prefersDarkMode.matches ? 'dark-mode' : 'light-mode',
    );
  } else {
    document.body.classList.add(storedTheme);
  }
} catch (e) {
  // localStorage is not available, do nothing and fall back to default.
}
      ''',
            ),
            if (productionBuild)
              RawText(
                '<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=$tagManagerId" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>',
              ),
            const a(
              id: 'skip-to-main',
              classes: 'filled-button',
              href: '#site-content-title',
              attributes: {'tabindex': '1'},
              [.text('Skip to main content')],
            ),
            CookieNotice(host: siteHost, alwaysDarkMode: cookieNoticeDarkMode),
            buildBody(page, child),
          ],
        ),
      ],
    );
  }

  /// Builds the banner component for the given [page].
  Component? buildBanner(Page page) {
    final showBanner =
        (page.data.page['showBanner'] as bool?) ??
        (page.data.site['showBanner'] as bool?) ??
        false;
    if (showBanner) {
      if (page.data['banner'] case final Map<String, Object?> bannerData) {
        return DashBanner(BannerContent.fromMap(bannerData));
      }
    }

    return null;
  }

  /// Builds the speculation rules `<script>` and `<link rel="prefetch">`
  /// fallback tags for the given [page].
  ///
  /// Includes page-specific list rules from [speculationUrls] and
  /// document rules that prefetch internal links on hover (`moderate`)
  /// and prerender them on click (`conservative`).
  ///
  /// Add the `no-prerender` class to a link to
  /// exclude it from document-level prerendering.
  List<Component> _buildSpeculationRulesHead(Page page) {
    final (:prerender, :prefetch) = speculationUrls(page);

    // Exclude prerendered URLs from the prefetch list since
    // prerendering is a superset of prefetching.
    final prefetchOnly = prefetch.difference(prerender);

    // Document rules to match same-origin links across the page.
    const internalLink = {'href_matches': '/*'};
    const notNoPrerender = {
      'not': {'selector_matches': '.no-prerender'},
    };

    final rules = jsonEncode({
      'prefetch': [
        // Prefetch internal links on hover.
        {
          'where': internalLink,
          'eagerness': 'moderate',
        },
        // Prefetch specific URLs from the page eagerly.
        if (prefetchOnly.isNotEmpty)
          {
            'urls': [...prefetchOnly],
          },
      ],
      'prerender': [
        // Prerender internal links on click,
        // unless the link has the 'no-prerender' class.
        {
          'where': {
            'and': [internalLink, notNoPrerender],
          },
          'eagerness': 'conservative',
        },
        // Prerender specific URLs from the page eagerly.
        if (prerender.isNotEmpty)
          {
            'urls': [...prerender],
            'eagerness': 'eager',
          },
      ],
    });

    return [
      RawText('<script type="speculationrules">$rules</script>'),
      // Fall back to prefetch link tags for browsers without
      // Speculation Rules API support.
      for (final url in {...prerender, ...prefetch})
        link(rel: 'prefetch', href: url),
    ];
  }
}
