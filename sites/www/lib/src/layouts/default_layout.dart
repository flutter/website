// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/layout/footer.dart';
import '../components/layout/header.dart';
import '../components/pages/consultants_cookie_snack.dart';
import '../models/content/banner_content.dart';
import '../style_hash.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';

class DefaultLayout extends PageLayout {
  @override
  Pattern get name => 'default';

  List<String> get defaultBodyTags => const [];

  @override
  Component buildLayout(Page page, Component child) {
    final pageData = page.data.page;
    final siteData = page.data.site;
    final siteUrl = siteData['url'];
    if (siteUrl is! String) {
      throw Exception('Site URL not configured in site data.');
    }
    final siteBaseUrl = Uri.parse(siteUrl);

    final title = (pageData['title'] as String).trim();
    final description = (pageData['description'] as String).trim();
    final pageImage = pageData['image'] as String?;

    if (title.isEmpty) {
      throw Exception('Page at ${page.path} can\'t have an empty title.');
    }
    if (description.isEmpty) {
      throw Exception('Page at ${page.path} can\'t have an empty description.');
    }

    final canonicalUrl = switch (page.data.page['canonical']) {
      final String url when url.trim().isNotEmpty => url.trim(),
      _ => siteBaseUrl.resolve(page.url).toString(),
    };
    final socialPageUrl = _absoluteUrl(siteBaseUrl, canonicalUrl);

    return AsyncBuilder(
      builder: (context) async {
        final socialImageUrl = _absoluteUrl(
          siteBaseUrl,
          pageImage ?? context.asset('/images/flutter-logo-sharing.png'),
        );
        final banner = context.decodeJsonObject(
          'banner',
          BannerContent.fromJson,
        );

        return Document(
          title: title,
          head: [
            link(rel: 'icon', href: context.asset('/images/favicon.png')),
            link(
              rel: 'apple-touch-icon',
              href: context.asset('/images/favicon.png'),
            ),

            meta(name: 'description', content: description),
            link(rel: 'canonical', href: canonicalUrl),
            meta(
              name: 'twitter:card',
              content: pageImage != null ? 'summary_large_image' : 'summary',
            ),
            const meta(name: 'twitter:site', content: '@flutterdev'),
            meta(name: 'twitter:title', content: title),
            meta(name: 'twitter:description', content: description),
            if (pageImage != null)
              meta(name: 'twitter:image', content: socialImageUrl),

            meta(attributes: const {'property': 'og:title'}, content: title),
            meta(
              attributes: const {'property': 'og:description'},
              content: description,
            ),
            meta(
              attributes: const {'property': 'og:url'},
              content: socialPageUrl,
            ),
            meta(
              attributes: const {'property': 'og:image'},
              content: socialImageUrl,
            ),

            // Google Analytics
            if (kGenerateMode) ...[
              const meta(
                name: 'google-site-verification',
                content: 'HFqxhSbf9YA_0rBglNLzDiWnrHiK_w4cqDh2YD2GEY4',
              ),
              const script(
                content: '''
                  (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                  new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                  j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                  'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
                  })(window,document,'script','dataLayer','GTM-ND4LWWZ');
                ''',
              ),
              const script(
                content: '''
                  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                  ga('create', 'UA-67589403-1', 'auto');
                  ga('send', 'pageview');
                ''',
              ),
            ],

            // Preload font and other script sources.
            const link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
            const link(
              rel: 'preconnect',
              href: 'https://fonts.gstatic.com',
              attributes: {'crossorigin': ''},
            ),

            // Set up site fonts and icons.
            const link(
              href:
                  'https://fonts.googleapis.com/css2?family=Google+Sans+Flex:opsz,wght@6..120,400..700&family=Google+Sans+Code:ital,wght@0,400..700;1,400..700&display=swap',
              rel: 'stylesheet',
            ),
            const link(
              rel: 'stylesheet',
              href:
                  'https://fonts.googleapis.com/css2?'
                  'family=Roboto+Serif:ital,opsz,wght@'
                  '0,8..72,400..700;1,8..72,400..700'
                  '&display=swap',
            ),
            const link(
              href:
                  'https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,400,0..1,0&display=block',
              rel: 'stylesheet',
            ),

            const link(
              rel: 'stylesheet',
              href:
                  'https://fonts.googleapis.com/css2?'
                  'family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@'
                  '24,400,0..1,0',
            ),

            const script(
              src:
                  'https://cdn.jsdelivr.net/npm/@justinribeiro/lite-youtube@1.8.2/lite-youtube.js',
              attributes: {
                'type': 'module',
                'integrity':
                    'sha256-Jy0j0fUMJ2T3WxSEs2WjHLrS+3DlO7S9DItQtP55FII=',
                'crossorigin': 'anonymous',
                'referrerpolicy': 'no-referrer',
              },
            ),

            // Set up standard cookie notification bar.
            const link(
              href:
                  'https://www.gstatic.com/glue/cookienotificationbar/cookienotificationbar.min.css',
              rel: 'stylesheet',
            ),

            // Project Styles
            const link(
              href: '/main.css?hash=$generatedStylesHash',
              rel: 'stylesheet',
            ),
          ],
          lang: 'en',
          body: .fragment([
            if ([
                  ...defaultBodyTags,
                  if (page.data.page['bodyTags'] case final String pageBodyTags)
                    ...pageBodyTags.split(' '),
                ]
                case final bodyTags when bodyTags.isNotEmpty)
              Document.body(
                attributes: {'class': bodyTags.join(' ')},
              ),
            Header(
              pageUrl: page.url,
              contrastLogoSrc: context.asset('/images/flutter-logo-white.svg'),
              defaultLogoSrc: context.asset('/images/flutter-logo.svg'),
              banner: banner,
            ),
            child,
            const Footer(),
            const script(
              src:
                  'https://www.gstatic.com/glue/cookienotificationbar/cookienotificationbar.min.js',
              attributes: {
                'data-glue-cookie-notification-bar-category': '2A',
                'data-glue-cookie-notification-bar-site-id': 'flutter.dev',
              },
            ),
            if (page.url.contains('consultants'))
              const ConsultantsCookieSnack(),
          ]),
        );
      },
    );
  }
}

/// Resolves [url] against [siteBaseUrl] to produce an absolute URL.
///
/// If [url] already has a scheme, it's returned unchanged.
String _absoluteUrl(Uri siteBaseUrl, String url) =>
    Uri.parse(url).hasScheme ? url : siteBaseUrl.resolve(url).toString();
