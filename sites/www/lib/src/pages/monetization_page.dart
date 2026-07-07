// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../components/common/feature_grid.dart';
import '../components/common/icon.dart';
import '../components/common/tabs.dart';
import '../components/sections/case_studies.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/feature_columns_section.dart';
import '../components/sections/hero_section.dart';
import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class MonetizationPage extends StatelessComponent {
  const MonetizationPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      HeroSection(
        title: 'Building a Flutter business',
        text:
            'Building with Flutter is just the start. '
            'Explore our suite of integrations with '
            'monetization features to grow your Flutter business.',
        media: img(
          src: context.asset('images/building-flutter-business.png'),
          alt: 'Building a Flutter business',
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        FeatureColumnsSection([
          FeatureColumn(
            title: 'Ads',
            description:
                'Easily integrate Google AdMob and Ad Manager ads '
                'directly in your Flutter App',
            image: context.asset('images/ads.png'),
          ),
          FeatureColumn(
            title: 'In-app purchases',
            description:
                'Build in-app revenue with '
                'Google Play and App Store support for Flutter',
            image: context.asset('images/in-app-purchases.png'),
          ),
          FeatureColumn(
            title: 'Payments',
            description:
                'Seamlessly accept payments with '
                'multiple providers in your Flutter app',
            image: context.asset('images/payments.png'),
          ),
        ]),
        section(id: 'tabs', classes: 'games-tabs', [
          Tabs(
            title: ref(
              const h2(classes: 'tabs-title', [
                .text(
                  'Reach a wider audience and maximize revenue with '
                  'support for various ad formats across '
                  'iOS, Android, and the web.',
                ),
              ]),
            ),
            tabs: [
              Tab(
                label: 'GMA SDK',
                content: ref(
                  .fragment([
                    div(classes: 'media', [
                      img(
                        src: context.asset(
                          'images/ads-in-your-flutter-app.svg',
                        ),
                        alt: 'Endless Runner',
                      ),
                    ]),
                    const div(classes: 'text', [
                      h2(classes: 'title first-tab', [
                        .text('The Google Mobile Ads SDK for Flutter'),
                      ]),
                      p(classes: 'body', [
                        .text('''
                  The Google Mobile Ads SDK for Flutter works with both AdMob and Ad Manager. It supports a variety of ads formats such as app open, banner, interstitial, native, rewarded, and rewarded interstitial formats, and features like mediation.
                '''),
                      ]),
                      div(classes: 'a-wrapper', [
                        a(
                          classes: 'btn',
                          href:
                              'https://docs.flutter.dev/cookbook/plugins/google-mobile-ads',
                          [.text('Get started')],
                        ),
                      ]),
                    ]),
                  ]),
                ),
              ),
              Tab(
                label: 'IMA SDK',
                content: ref(
                  .fragment([
                    div(classes: 'media', [
                      img(
                        src: context.asset('images/ima-sdk.png'),
                        alt: 'Basic Template',
                      ),
                    ]),
                    const div(classes: 'text', [
                      h2(classes: 'title second-tab', [
                        .text('The Integrated Media Ads SDK for Flutter'),
                      ]),
                      p(classes: 'body', [
                        .text('''
                  The Interactive Media Ads SDK for Flutter empowers both app developers and publishers to seamlessly integrate video ads into their video content. With support for pre-roll, mid-roll, and post-roll ad placements on both iOS and Android, the plugin offers a comprehensive solution for instream video ad monetization.
                '''),
                      ]),
                      div(classes: 'a-wrapper', [
                        a(
                          classes: 'btn',
                          href:
                              'https://pub.dev/packages/interactive_media_ads',
                          [.text('Get started')],
                        ),
                      ]),
                    ]),
                  ]),
                ),
              ),
              Tab(
                label: 'Adsense for H5 games',
                content: ref(
                  .fragment([
                    div(classes: 'media', [
                      img(
                        src: context.asset('images/adsense-h5.png'),
                        alt: 'Card Game',
                      ),
                    ]),
                    const div(classes: 'text', [
                      h2(classes: 'title third-tab', [
                        .text('Adsense for H5 games'),
                      ]),
                      p(classes: 'body', [
                        .text('''
                  Flutter’s AdSense for H5 games plugin allows you to easily add AdSense interstitial and rewarded ads to your web-based (H5) games built in Flutter. If you are a Flutter web game developer and are interested in monetizing your game, start experimenting today!
                '''),
                      ]),
                      div(classes: 'a-wrapper', [
                        a(
                          classes: 'btn',
                          href:
                              'https://adsense.google.com/start/h5-beta/?src=flutter',
                          [.text('Apply for beta')],
                        ),
                      ]),
                    ]),
                  ]),
                ),
              ),
            ],
            noSpy: true,
          ),

          const div(classes: 'divider', []),
        ]),
        section(id: 'resources-1', classes: 'module', [
          FeatureGrid(
            eyebrow: 'Learn more about Google Mobile Ads',
            title: 'Get started with Google Mobile Ads in Flutter',
            items: [
              FeatureGridItem(
                title: 'Watch the video',
                description:
                    'Learn about monetization strategies for apps built with Flutter to turn a successful app into a successful business.',
                icon: context.asset('images/icons/watch-the-video.svg'),
                url: 'https://www.youtube.com/watch?v=m0d_pbgeeG8',
              ),
              FeatureGridItem(
                title: 'Get started in docs',
                description:
                    'Documentation and tutorials for getting started with Google Mobile Ads in Flutter.',
                icon: context.asset('images/icons/get-started-in-docs.svg'),
                url: 'https://developers.google.com/admob/flutter/quick-start',
              ),
              FeatureGridItem(
                title: 'Flutter ads codelab 1',
                description:
                    'Learn how to implement inline banner and native ads in this codelab.',
                icon: context.asset('images/icons/flutter-ads-codelab-2.svg'),
                url:
                    'https://codelabs.developers.google.com/codelabs/admob-inline-ads-in-flutter#0',
              ),
              FeatureGridItem(
                title: 'Flutter ads codelab 2',
                description:
                    'Learn how to implement banner, interstitial, and rewarded video ads in this codelab.',
                icon: context.asset('images/icons/flutter-ads-codelab-2.svg'),
                url:
                    'https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter#0',
              ),
            ],
          ),
        ]),
        const section(id: 'case-studies', classes: 'module carousel-section', [
          CaseStudies(tag: 'monetization'),
        ]),
        section(id: 'monetize-users', [
          div(classes: 'features container', [
            div(
              classes: 'feature reverse active',
              attributes: const {'x-data': 'initSpy'},
              [
                const div(classes: 'text', [
                  Component.element(
                    tag: 'hgroup',
                    children: [
                      h4(classes: 'eyebrow', [.text('Monetize users')]),
                      h3([.text('In-app purchases in Flutter')]),
                    ],
                  ),
                  p([
                    .text(
                      'Integrate with a unified surface for offering additional content in your app like premium services, digital goods, and subscriptions.',
                    ),
                  ]),
                  a(
                    classes: 'btn',
                    href: 'https://pub.dev/packages/in_app_purchase',
                    [.text('Get started')],
                  ),
                ]),
                div(classes: 'media', [
                  img(
                    src: context.asset('images/in-app-purchases-1.png'),
                    alt: 'In-App Purchases',
                  ),
                ]),
              ],
            ),
          ]),
        ]),
        section(id: 'resources-2', classes: 'module', [
          FeatureGrid(
            eyebrow: 'Resources for in-app purchases',
            title: 'Learn how to collect in-app purchases in Flutter',
            items: [
              FeatureGridItem(
                title: 'See the sample',
                description:
                    'Start with an example for integrating in-app purchases in your Flutter App.',
                icon: context.asset('images/icons/see-the-sample.svg'),
                url:
                    'https://github.com/flutter/packages/blob/main/packages/in_app_purchase/in_app_purchase/example/README.md',
              ),
              FeatureGridItem(
                title: 'Codelab',
                description:
                    'Learn how to add in-app purchases to your Flutter app.',
                icon: context.asset('images/icons/codelab.svg'),
                url:
                    'https://codelabs.developers.google.com/codelabs/flutter-in-app-purchases#0',
              ),
              FeatureGridItem(
                title: 'Get started in docs',
                description:
                    'Documentation and tutorials for getting started with in-app purchases in Flutter.',
                icon: context.asset('images/icons/get-started-in-docs.svg'),
                url: 'https://pub.dev/documentation/in_app_purchase/latest/',
              ),
              FeatureGridItem(
                title: 'See the code',
                description: 'Dive into the open source plugin on GitHub.',
                icon: context.asset('images/icons/see-the-code.svg'),
                url:
                    'https://github.com/flutter/packages/blob/main/packages/in_app_purchase/in_app_purchase',
              ),
            ],
          ),
        ]),
        section(id: 'payments', [
          div(classes: 'features container', [
            div(classes: 'feature reverse nospy', [
              const div(classes: 'text', [
                Component.element(
                  tag: 'hgroup',
                  children: [
                    h4(classes: 'eyebrow', [.text('Payments in Flutter apps')]),
                    h3([.text('Accepting payments')]),
                  ],
                ),
                p([
                  .text(
                    'Make it easier to integrate with multiple payment providers like Google and Apple Pay with the Pay plugin for Flutter.',
                  ),
                ]),
                a(classes: 'btn', href: 'https://pub.dev/packages/pay', [
                  .text('Get started'),
                ]),
              ]),
              div(classes: 'media', [
                img(
                  src: context.asset('images/accepting-payments.png'),
                  alt: 'Payments in Flutter Apps',
                ),
              ]),
            ]),
          ]),
        ]),
        const section(id: 'start-learning', classes: 'module', [
          div(classes: 'features container', [
            div(classes: 'stacked-feature', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [
                    .text('Integrate payments in Flutter apps'),
                  ]),
                  h2([.text('Learn more about payments in Flutter apps')]),
                ],
              ),
              div(classes: 'feature full nospy', [
                div(classes: 'text', [
                  div([
                    h3([.text('Get started in docs')]),
                    a(
                      classes: 'btn quiet collapsed',
                      href: 'https://pub.dev/documentation/pay/latest/',
                      [
                        .text('Read more '),
                        RawText('&nbsp;'),
                        Icon.linkArrow(),
                      ],
                    ),
                  ]),
                  div([
                    h3([.text('Start using the Pay plugin')]),
                    a(
                      classes: 'btn quiet collapsed',
                      href: 'https://github.com/google-pay/flutter-plugin',
                      [
                        .text('View docs '),
                        RawText('&nbsp;'),
                        Icon.linkArrow(),
                      ],
                    ),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        const CTASection(),
      ]),
    ]);
  }
}
