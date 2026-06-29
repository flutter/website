// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../components/common/carousel.dart';
import '../components/common/icon.dart';
import '../models/content/ios_content.dart';
import '../models/content/showcase_content.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';
import '../utils/scroll_spy.dart';

class IosPage extends StatelessComponent {
  const IosPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      _buildHero(context),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        _buildMetrics(),
        _buildTopBrands(context),
        _buildReachCustomers(context),
        _buildRichEcosystem(context),
        _buildOpenSource(context),
        _buildProductiveTeam(context),
        _buildHowItWorks(),
        _buildCTA(context),
      ]),
    ]);
  }

  Component _buildHero(BuildContext context) {
    return section(classes: 'hero', [
      div(classes: 'container', [
        div(classes: 'mantle', [
          const div(classes: 'text', [
            h1([.text('Flutter on iOS')]),
            h3(classes: 'body', [
              .text(
                'Build beautiful, fast, feature-rich\napplications for iOS and more!',
              ),
            ]),
            a(classes: 'btn primary', href: 'https://docs.flutter.dev', [
              .text('Learn more'),
            ]),
          ]),
          div(id: 'header-img-container', classes: 'media img-container', [
            img(
              classes: 'background',
              src: context.asset('images/header-image-background.png'),
              alt: 'Header image background',
            ),
            img(
              classes: 'item',
              src: context.asset('images/header-image-1.png'),
              alt: 'Header image 1',
            ),
            img(
              classes: 'item',
              src: context.asset('images/header-image-2.png'),
              alt: 'Header image 2',
            ),
            img(
              classes: 'item',
              src: context.asset('images/header-image-3.png'),
              alt: 'Header image 3',
            ),
            img(
              classes: 'item',
              src: context.asset('images/header-image-4.png'),
              alt: 'Header image 4',
            ),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildMetrics() {
    return section(id: 'developer-metrics', classes: 'module', [
      div(classes: 'container', [
        const h2(classes: 'title', [
          .text(
            'Used and loved by millions of developers in the App Store and beyond',
          ),
        ]),
        div(classes: 'media', [
          div(classes: 'media-container', [
            const svg(
              classes: 'ios-developer-metrics-svg',
              attributes: {
                'viewBox': '0 0 931 418',
                'fill': 'none',
                'xmlns': 'http://www.w3.org/2000/svg',
              },
              [
                path(
                  attributes: {
                    'd':
                        'M929 353.252L929 64.7477C929 30.0931 896.276 2 855.908 2L75.0916 1.99997C34.7242 1.99997 2 30.093 2 64.7476L1.99998 353.252C1.99998 387.907 34.7242 416 75.0916 416L855.908 416C896.276 416 929 387.907 929 353.252Z',
                    'stroke': '#0081FC',
                    'stroke-width': '3',
                    'stroke-linecap': 'round',
                    'stroke-linejoin': 'round',
                    'stroke-dasharray': '15 15',
                  },
                  [],
                ),
              ],
            ),
            _buildStat(
              number: '28%',
              description:
                  '28% of new free apps on the iOS\napp store are built with Flutter',
              source: '(Apptopia 2024)',
            ),
            _buildStat(
              number: '#1',
              description:
                  '#1 multi-platform framework\non JetBrains and StackOverflow surveys',
              source: '(JetBrains and StackOverflow, 2024)',
            ),
            _buildStat(
              number: '1.2M',
              description: 'Apps on the iOS App Store\nbuilt with Flutter.',
              source: '(Free apps, Apptopia 2024)',
            ),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildStat({
    required String number,
    required String description,
    required String source,
  }) {
    return div(
      classes: 'flutter-stat-cta',
      attributes: const {
        'tabindex': '0',
        'aria-label': 'Flutter iOS App Store Stat',
      },
      [
        span(classes: 'flutter-stat-cta__number', [.text(number)]),
        p(classes: 'flutter-stat-cta__description', [.text(description)]),
        span(classes: 'flutter-stat-cta__source', [.text(source)]),
      ],
    );
  }

  Component _buildTopBrands(BuildContext context) {
    final brands = context.decodeJsonList(
      'development.ios.top_brands',
      IosTopBrand.fromJson,
    );
    final googleApps = context.decodeJsonList(
      'showcase.data.google_apps',
      ShowcaseGoogleApp.fromJson,
    );

    return section(id: 'top-brands', classes: 'module', [
      div(classes: 'container', [
        const h2(classes: 'title', [
          .text('Join other top brands and apps using Flutter.'),
        ]),
        div(classes: 'top-brands-grid', [
          for (final brand in brands)
            a(
              href: brand.href,
              attributes: {
                'target': '_blank',
                'rel': 'noopener noreferrer',
                'aria-label': "Visit ${brand.name}'s website",
              },
              [
                div(
                  classes: 'brand-wrapper',
                  attributes: {
                    'style':
                        'background-image: url("${context.asset('images/top-brands-background.svg')}")',
                  },
                  [img(src: context.asset(brand.src), alt: brand.name)],
                ),
              ],
            ),
        ]),
      ]),
      _buildGoogleApps(context, googleApps),
    ]);
  }

  Component _buildGoogleApps(
    BuildContext context,
    List<ShowcaseGoogleApp> googleApps,
  ) {
    return .fragment([
      const h2(classes: 'title', [
        .text('In addition, over 30 teams in Google use Flutter'),
      ]),
      Carousel(
        ref(
          .fragment([
            for (final app in googleApps) _buildGoogleAppItem(context, app),
          ]),
        ),
        prevBtn: ref(
          svg(
            width: 45.px,
            height: 45.px,
            viewBox: '0 0 45 45',
            attributes: const {'fill': 'none'},
            const [
              path(
                d: 'M19.9565 22.4584L27.3976 29.8996L25.1312 32.1661L15.4286 22.4636L25.1312 12.761L27.3976 15.0275L19.9565 22.4687V22.4584Z',
                fill: Color('#00BAFD'),
                [],
              ),
              path(
                d: 'M22.9629 42.7226C34.1545 42.7226 43.227 33.6501 43.227 22.4585C43.227 11.2669 34.1545 2.19434 22.9629 2.19434C11.7714 2.19434 2.69873 11.2669 2.69873 22.4585C2.69873 33.6501 11.7714 42.7226 22.9629 42.7226Z',
                stroke: Color('#00BAFD'),
                strokeWidth: '3.62229',
                attributes: {
                  'stroke-linecap': 'round',
                  'stroke-linejoin': 'round',
                },
                [],
              ),
            ],
          ),
        ),
        nextBtn: ref(
          svg(
            width: 45.px,
            height: 45.px,
            viewBox: '0 0 45 45',
            attributes: const {'fill': 'none'},
            const [
              path(
                d: 'M25.6738 22.4585L18.2327 15.0173L20.4991 12.7507L30.2017 22.4533L20.4991 32.1559L18.2327 29.8893L25.6738 22.4481V22.4585Z',
                fill: Color('#AA7DFB'),
                [],
              ),
              path(
                d: 'M22.6675 42.7226C33.8591 42.7226 42.9316 33.6501 42.9316 22.4585C42.9316 11.2669 33.8591 2.19434 22.6675 2.19434C11.476 2.19434 2.40332 11.2669 2.40332 22.4585C2.40332 33.6501 11.476 42.7226 22.6675 42.7226Z',
                stroke: Color('#AA7DFB'),
                strokeWidth: '3.62229',
                attributes: {
                  'stroke-linecap': 'round',
                  'stroke-linejoin': 'round',
                },
                [],
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Component _buildGoogleAppItem(BuildContext context, ShowcaseGoogleApp app) {
    final url = app.url;

    final child = div([
      img(
        alt: app.title,
        src: context.asset('/showcase/${app.image}', width: 635),
        width: 480,
        height: 480,
      ),
      div(classes: 'text', [
        h3([.text(app.title)]),
      ]),
    ]);

    return div(classes: 'story-item', [
      if (url != null) a(href: url, target: Target.blank, [child]) else child,
    ]);
  }

  Component _buildReachCustomers(BuildContext context) {
    return section(id: 'customers', classes: 'module partial-border', [
      const h2(classes: 'title', [.text('Reach more customers')]),
      div(classes: 'features container', [
        div(classes: 'feature nospy', [
          const div(classes: 'text', [
            p([
              .text(
                'Flutter offers a compelling solution for companies looking to expand beyond iOS to Android and Web. Flutter supports a wide range of iOS versions, Android versions, and all major browsers. Use Flutter to build from a single codebase to reach all your users.',
              ),
            ]),
          ]),
          div(classes: 'media', [
            img(
              alt: 'Flutter net artwork',
              src: context.asset('images/flutter-net.svg'),
            ),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildRichEcosystem(BuildContext context) {
    return section(id: 'rich-ecosystem', classes: 'module partial-border', [
      const h2(classes: 'title', [
        .text('Use a rich ecosystem to make high-quality apps for iOS'),
      ]),
      div(classes: 'features container', [
        div(classes: 'feature nospy', [
          const div(classes: 'text', [
            p([
              .text(
                'Flutter can be used to build performant, high-quality apps that scale to meet the demands of millions of users. Flutter apps run as optimized machine code right on the CPU and GPU, and deliver fast and beautiful user experiences.',
              ),
            ]),
          ]),
          div(classes: 'media', [
            img(
              alt: 'Rich Ecosystem Image',
              src: context.asset('images/rich-ecosystem-1.png'),
            ),
          ]),
        ]),
        div(classes: 'feature reverse nospy', [
          const div(classes: 'text', [
            p([
              .text(
                'Leverage a rich ecosystem of ready-made plugins for iOS and Apple integrations, such as Apple Pay, Apple Wallet, Apple Login, and much more. Can\'t find a plugin? Use the power of FFI to build any integration your app requires.',
              ),
            ]),
          ]),
          div(classes: 'media', [
            img(
              alt: 'Rich Ecosystem Image',
              src: context.asset('images/rich-ecosystem-2.png'),
            ),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildOpenSource(BuildContext context) {
    return section(id: 'flutter-opensource', classes: 'module', [
      const h2(classes: 'title', [
        .text("Leverage Flutter's open source advantage"),
      ]),
      div(classes: 'features container', [
        div(classes: 'feature nospy', [
          div(classes: 'text', [
            const p([
              .text(
                'Gain flexibility, reduce your dependency on a single vendor, and empower your team with access and transparency to the code and development process.',
              ),
            ]),
            div(classes: 'github-stats', [
              span(classes: 'stat', [
                img(
                  alt: 'Github Stars',
                  src: context.asset('images/github-stars.svg'),
                ),
                const .text(' > 170K GitHub Stars'),
              ]),
              span(classes: 'stat', [
                img(
                  alt: 'Github Contributors',
                  src: context.asset('images/github-contributors.svg'),
                ),
                const .text(' > 1.5K GitHub Contributors'),
              ]),
            ]),
          ]),
          div(classes: 'media', [
            img(
              alt: 'Flutter open Source',
              src: context.asset('images/flutter-open-source.svg'),
            ),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildProductiveTeam(BuildContext context) {
    return section(id: 'productive-team', classes: 'module', [
      const h2(classes: 'title', [.text('Make your team more productive')]),
      div(classes: 'container', [
        const p(classes: 'subtitle', [
          .text(
            "With its easy-to-grasp framework and the easy-to-use Dart language, Flutter simplifies app development. Flutter has excellent integration with VS Code and lets you 'paint your app to life' in real-time, using stateful hot reload.",
          ),
        ]),
        img(
          attributes: const {'alt': 'Productive Team Image'},
          src: context.asset('images/productive-team.png'),
        ),
      ]),
    ]);
  }

  Component _buildHowItWorks() {
    return const section(
      id: 'flutter-ios',
      classes: 'module',
      attributes: {'x-data': '{ subtitle: !!\'\' }'},
      [
        div(classes: 'background-shape', []),
        h2(classes: 'title', [.text('How Flutter works on iOS')]),
        div(
          classes: 'container',
          attributes: {':class': "{ 'has-subtitle': subtitle }"},
          [
            div(classes: 'embed-container', [
              iframe(
                src:
                    'https://www.youtube.com/embed/ceMsPBbcEGg?si=p06i4r5dP723J3nO',
                attributes: {
                  'title': '#FlutterInProduction',
                  'frameborder': '0',
                  'allow':
                      'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share',
                  'allowfullscreen': '',
                },
                [],
              ),
            ]),
          ],
        ),
      ],
    );
  }

  Component _buildCTA(BuildContext context) {
    return section(id: 'cta', classes: 'module', [
      div(classes: 'insert cta-insert try-flutter-insert container', [
        const div(classes: 'text', [
          h2([.text('Next Steps')]),
          p([.text('Start your journey with flutter')]),
          div([
            a(
              href: 'https://docs.flutter.dev/get-started/install',
              classes: 'btn primary',
              [.text('Try Flutter')],
            ),
            a(
              href: 'https://flutter.dev/consultants',
              classes: 'btn quiet follow-up',
              attributes: {'target': '_blank'},
              [
                .text('Connect with a consultancy\u00A0'),
                Icon.linkArrow(),
              ],
            ),
          ]),
        ]),
        div(classes: 'media', [
          img(
            src: context.asset('/images/common/try-flutter-background.png'),
            alt: 'Flutter next steps',
          ),
        ]),
      ]),
    ]);
  }
}
