// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../components/common/carousel.dart';
import '../components/common/feature.dart';
import '../components/common/icon.dart';
import '../components/common/tabs.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/newsletter_section.dart';
import '../models/content/home_content.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';
import '../utils/scroll_spy.dart';

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      _buildHero(context),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        _buildTabs(context),
        _buildFeatured(context),
        const br(),
        _buildDeveloperStory(context),
        _buildCommunity(context),
        _buildDart(context),
        _buildNews(context),
        const NewsletterSection(),
        const CTASection(),
      ]),
    ]);
  }

  Component _buildHero(BuildContext context) {
    return section(
      classes: 'hero',
      attributes: scroll.spy(-scroll.headerOffset, .inHero),
      [
        div(classes: 'container', [
          const h1([.text('Build for any screen')]),
          div(classes: 'gallery', [
            div(classes: 'inner-fixed', [
              div(classes: 'col col-outer col-left', [
                div(
                  classes: 'card card-a',
                  styles: Styles(
                    backgroundImage: .url(
                      context.asset('home/images/hero/hero-the-debertz.png'),
                    ),
                  ),
                  const [],
                ),
                div(
                  classes: 'card card-b',
                  styles: Styles(
                    backgroundImage: .url(
                      context.asset('home/images/hero/movement-app.png'),
                    ),
                  ),
                  const [],
                ),
                div(
                  classes: 'card card-c',
                  styles: Styles(
                    backgroundImage: .url(
                      context.asset('home/images/hero/sua-musica-app.png'),
                    ),
                  ),
                  const [],
                ),
              ]),
              div(classes: 'col col-center', [
                div(
                  classes: 'card card-a',
                  styles: Styles(
                    backgroundImage: .url(
                      context.asset('home/images/hero/hero-bmw-mobile.png'),
                    ),
                  ),
                  const [],
                ),
              ]),
              div(classes: 'col col-outer col-right', [
                div(
                  classes: 'card card-a',
                  styles: Styles(
                    backgroundImage: .url(
                      context.asset('home/images/hero/hero-trivia-crack.png'),
                    ),
                  ),
                  const [],
                ),
                div(
                  classes: 'card card-b',
                  styles: Styles(
                    backgroundImage: .url(
                      context.asset(
                        'home/images/hero/google-assistant-tablet.png',
                      ),
                    ),
                  ),
                  const [],
                ),
                div(
                  classes: 'card card-c',
                  styles: Styles(
                    backgroundImage: .url(
                      context.asset('home/images/hero/nu-app.png'),
                    ),
                  ),
                  const [],
                ),
                div(
                  classes: 'card card-d',
                  styles: Styles(
                    backgroundImage: .url(
                      context.asset('home/images/hero/mgm-app.jpg'),
                    ),
                  ),
                  const [],
                ),
              ]),
            ]),
          ]),
          const h2([
            .text(
              'Flutter transforms the development process. '
              'Build, test, and deploy beautiful mobile, web, desktop, and embedded experiences from a single codebase.',
            ),
          ]),
          const a(
            id: 'get-started__home-hero-bottom',
            href: 'https://docs.flutter.dev/get-started/quick',
            classes: 'btn white',
            [.text('Get started')],
          ),
        ]),
      ],
    );
  }

  Component _buildTabs(BuildContext context) {
    return section(id: 'tabs', classes: 'module', attributes: scroll.spy(-300), [
      Tabs(
        header: ref(
          const h2([
            .text(
              'Flutter is an open-source framework for building beautiful, natively compiled, multi-platform applications from a single codebase.',
            ),
          ]),
        ),
        tabs: [
          Tab(
            label: 'Fast',
            content: ref(
              .fragment([
                div(classes: 'media', [
                  video(
                    attributes: {
                      'muted': '',
                      'autoplay': '',
                      'loop': '',
                      'playsinline': '',
                      'src': context.asset('home/images/feature-fast.mp4'),
                      'type': 'video/mp4',
                    },
                    [
                      img(
                        src: context.asset('home/images/fast.png'),
                        alt: 'Fast',
                      ),
                    ],
                  ),
                ]),
                const div(classes: 'text', [
                  h3(classes: 'text-green', [.text('Fast')]),
                  p([
                    .text(
                      'Flutter code compiles to ARM or Intel machine code as well as JavaScript, for fast performance on any device.',
                    ),
                  ]),
                  a(
                    classes: 'btn',
                    href:
                        'https://dartpad.dev/?id=e66e420f2f0201c772f73819711bf290',
                    attributes: {'target': '_blank'},
                    [.text('Try it in DartPad')],
                  ),
                ]),
              ]),
            ),
          ),
          Tab(
            label: 'Productive',
            content: ref(
              .fragment([
                div(classes: 'media', [
                  video(
                    attributes: {
                      'muted': '',
                      'autoplay': '',
                      'loop': '',
                      'playsinline': '',
                      'src': context.asset(
                        'home/images/feature-productive.mp4',
                      ),
                      'type': 'video/mp4',
                    },
                    [
                      img(
                        src: context.asset('home/images/productive.png'),
                        alt: 'Productive',
                      ),
                    ],
                  ),
                ]),
                const div(classes: 'text', [
                  h3(classes: 'text-violet', [.text('Productive')]),
                  p([
                    .text(
                      'Build and iterate quickly with Hot Reload. '
                      'Update code and see changes almost instantly, without losing state.',
                    ),
                  ]),
                  a(
                    classes: 'btn',
                    href:
                        'https://dartpad.dev/?id=bbd3f10c2593f0add04dd770318b33f7',
                    attributes: {'target': '_blank'},
                    [.text('Try it in DartPad')],
                  ),
                ]),
              ]),
            ),
          ),
          Tab(
            label: 'Flexible',
            content: ref(
              .fragment([
                div(classes: 'media', [
                  video(
                    attributes: {
                      'muted': '',
                      'autoplay': '',
                      'loop': '',
                      'playsinline': '',
                      'src': context.asset('home/images/feature-flexible.mp4'),
                      'type': 'video/mp4',
                    },
                    [
                      img(
                        src: context.asset('home/images/flexible.png'),
                        alt: 'Flexible',
                      ),
                    ],
                  ),
                ]),
                const div(classes: 'text', [
                  h3(classes: 'text-coral', [.text('Flexible')]),
                  p([
                    .text(
                      'Control every pixel to create customized, adaptive designs that look and feel great on any screen.',
                    ),
                  ]),
                  a(
                    classes: 'btn',
                    href:
                        'https://dartpad.dev/?id=1ab1b78a18039bbbd5cfbb4b835b5b8d',
                    attributes: {'target': '_blank'},
                    [.text('Try it in DartPad')],
                  ),
                ]),
              ]),
            ),
          ),
        ],
      ),
    ]);
  }

  Component _buildFeatured(BuildContext context) {
    return section(id: 'featured', [
      div(classes: 'features container', [
        Feature(
          eyebrow: 'Development',
          eyebrowClass: 'text-blue',
          title: 'Reach users on every screen',
          description:
              'Deploy to multiple devices from a single codebase: mobile, web, desktop, and embedded devices.',
          actions: const [
            FeatureAction(
              label: 'See the target platforms',
              url: '/development',
            ),
          ],
          media: img(
            src: context.asset('home/images/development.jpg', width: 600),
            alt: 'Development',
          ),
          noSpy: true,
        ),
        Feature(
          eyebrow: 'Developer experience',
          eyebrowClass: 'text-green',
          title: 'Transform your workflow',
          description:
              'Take control of your codebase with automated testing, developer tooling, and everything else you need to build production-quality apps.',
          actions: const [
            FeatureAction(label: 'Flutter for developers', url: '/development'),
          ],
          media: img(
            src: context.asset(
              'home/images/developer-experience.jpg',
              width: 600,
            ),
            alt: 'Developer experience',
          ),
          reverse: true,
          noSpy: true,
        ),
        Feature(
          eyebrow: 'Stable & reliable',
          eyebrowClass: 'text-coral',
          title: 'Trusted by many',
          description:
              'Flutter is supported and used by Google, trusted by well-known brands around the world, and maintained by a community of global developers.',
          actions: const [
            FeatureAction(label: 'Explore the ecosystem', url: '/ecosystem'),
          ],
          media: img(
            alt: 'Ecosystem',
            src: context.asset(
              'home/images/stable-and-reliable.jpg',
              width: 600,
            ),
          ),
          noSpy: true,
        ),
        Feature(
          eyebrow: 'Flutter and Google',
          eyebrowClass: 'text-violet',
          title: 'Seamless integration with Google services',
          description:
              'Connect to Google\'s app development ecosystem, allowing you to streamline development and reach a wider audience through seamless integration with Firebase, Google Ads, Google Play, Google Pay, Google Wallet, Google Maps, and more.',
          actions: const [
            FeatureAction(
              label: 'Explore Google integrations',
              url: '/google-integrations',
            ),
          ],
          media: img(
            alt: 'Seamless Integrations',
            src: context.asset(
              'home/images/seamless-integrations-home.png',
              width: 600,
            ),
          ),
          reverse: true,
          noSpy: true,
        ),
      ]),
    ]);
  }

  Component _buildDeveloperStory(BuildContext context) {
    return section(id: 'developer-story', classes: 'module', [
      div(classes: 'insert developer-story-insert container', [
        const div(classes: 'text', [
          h4(classes: 'eyebrow', [.text('Developer story')]),
          h3([
            .text(
              'See how Google Pay uses Flutter to change the world of mobile payments',
            ),
          ]),
          a(href: '/showcase/google-pay', classes: 'btn quiet collapsed', [
            .text('Read story '),
            RawText('&nbsp;'),
            Icon.linkArrow(),
          ]),
        ]),
        div(classes: 'media', [
          img(
            src: context.asset(
              'home/images/gpay-developer-story.png',
              width: 385,
            ),
            alt: 'Google Pay Developer Story',
          ),
        ]),
      ]),
    ]);
  }

  Component _buildCommunity(BuildContext context) {
    return section(id: 'community', classes: 'module', [
      div(classes: 'container', [
        div(classes: 'logo-garden', [
          div(classes: 'inner-fixed', [
            div(classes: 'logo-col', [
              div([
                img(
                  src: context.asset('images/third_party/logos/abbeyroad.svg'),
                  alt: 'Abbey Road',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/alibaba.svg'),
                  alt: 'Alibaba',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/bmw.svg'),
                  alt: 'BMW',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/bytedance.svg'),
                  alt: 'Byte Dance',
                ),
              ]),
            ]),
            div(classes: 'logo-col', [
              div([
                img(
                  src: context.asset('images/third_party/logos/capitalone.svg'),
                  alt: 'Capitalone',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/dream11.svg'),
                  alt: 'Dream11',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/ebay.svg'),
                  alt: 'Ebay',
                ),
              ]),
            ]),
            div(classes: 'logo-col', [
              div([
                img(
                  src: context.asset('images/third_party/logos/emaar.svg'),
                  alt: 'Emaar',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/grab.svg'),
                  alt: 'Grab',
                ),
              ]),
            ]),
            div(classes: 'logo-col logo-centerpiece', [
              div([
                img(
                  src: context.asset('images/third_party/logos/google.svg'),
                  alt: 'Google',
                ),
              ]),
            ]),
            div(classes: 'logo-col', [
              div([
                img(
                  src: context.asset('images/third_party/logos/groupon.svg'),
                  alt: 'Groupon',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/toyota.svg'),
                  alt: 'Toyota',
                ),
              ]),
            ]),
            div(classes: 'logo-col', [
              div([
                img(
                  src: context.asset('images/third_party/logos/mgm.svg'),
                  alt: 'MGM',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/nubank.svg'),
                  alt: 'Nubank',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/nytimes.svg'),
                  alt: 'NY Times',
                ),
              ]),
            ]),
            div(classes: 'logo-col', [
              div([
                img(
                  src: context.asset(
                    'images/third_party/logos/philips-hue.png',
                  ),
                  alt: 'Philips Hue',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/sonos.svg'),
                  alt: 'Sonos',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/square.svg'),
                  alt: 'Square',
                ),
              ]),
              div([
                img(
                  src: context.asset('images/third_party/logos/tencent.svg'),
                  alt: 'Tencent',
                ),
              ]),
            ]),
          ]),
        ]),
        const div(classes: 'text', [
          Component.element(
            tag: 'hgroup',
            children: [
              h4(classes: 'eyebrow', [
                .text('A global, open-source community'),
              ]),
              h2([.text('Supported by Google, open to everyone')]),
            ],
          ),
          p([
            .text(
              'Collaborate on the open-source framework, contribute to the package ecosystem on pub.dev, and find help when you need it.',
            ),
          ]),
          div([
            a(classes: 'btn', href: '/showcase', [.text('Learn more')]),
            a(classes: 'btn quiet', href: '/community', [
              .text('Join the community '),
              RawText('&nbsp;'),
              Icon.linkArrow(),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildDart(BuildContext context) {
    return section(id: 'dart', classes: 'module', [
      div(classes: 'insert dart-insert container', [
        const div(classes: 'text', [
          h4(classes: 'eyebrow', [.text('Dart')]),
          h3([
            .text(
              'Flutter is powered by Dart, a language optimized for fast apps on any platform',
            ),
          ]),
          div([
            a(
              href: 'https://dart.dev',
              classes: 'btn',
              attributes: {'target': '_blank'},
              [.text('Visit dart.dev')],
            ),
            a(
              href: 'https://pub.dev',
              classes: 'btn quiet',
              attributes: {'target': '_blank'},
              [
                .text('Get packages '),
                RawText('&nbsp;'),
                Icon.linkArrow(),
              ],
            ),
          ]),
        ]),
        div(classes: 'media', [
          img(
            src: context.asset('images/common/powered-by-dart.svg'),
            alt: 'Powered by Dart',
          ),
        ]),
      ]),
    ]);
  }

  Component _buildNews(BuildContext context) {
    final newsItems = context.decodeJsonList(
      'home.latest_news',
      HomeNewsItem.fromJson,
    );

    return section(id: 'news', classes: 'module carousel-section', [
      const div(classes: 'container', [
        h2([.text('Latest news')]),
      ]),
      Carousel(
        ref(
          .fragment([
            for (final item in newsItems) _buildNewsItem(context, item),
          ]),
        ),
      ),
    ]);
  }

  Component _buildNewsItem(BuildContext context, HomeNewsItem item) {
    return div(classes: 'carousel-card', [
      a(
        href: item.url,
        attributes: const {'target': '_blank'},
        [
          img(
            alt: item.alt ?? item.title,
            src: context.asset(item.image, width: 635),
            width: 635,
            height: 357,
          ),
          h4([.text(item.title)]),
          a(
            href: item.url,
            attributes: const {'target': '_blank'},
            const [
              .text('Read more'),
              RawText('&nbsp;'),
              Icon.linkArrow(),
            ],
          ),
          const div(classes: 'carousel-card-bg', []),
        ],
      ),
    ]);
  }
}
