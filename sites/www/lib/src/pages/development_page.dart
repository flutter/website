// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/common/feature.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/feature_columns_section.dart';
import '../components/sections/hero_section.dart';
import '../components/sections/quote_section.dart';
import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class DevelopmentPage extends StatelessComponent {
  const DevelopmentPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      _buildHero(context),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        _buildFeatureColumns(context),
        _buildFeatured(context),
        QuoteSection(
          background: context.asset(
            'images/multi-platform-testimonials-bg.jpg',
          ),
          logo: context.asset('/images/third_party/logos/tencent.svg'),
          logoAlt: 'Tencent',
          quote:
              'When using Flutter, 90% of the code became multi-platform and only needed to be updated once.',
          author: 'Fei Song',
          company: 'Senior Software Engineer, Tencent',
        ),
        const CTASection(),
      ]),
    ]);
  }

  Component _buildHero(BuildContext context) {
    return HeroSection(
      title: 'Beautiful apps for every screen',
      text:
          'Flutter allows you to build apps for mobile, web, desktop, and embedded devices — all from a single codebase.',
      media: img(
        src: context.asset('images/beautiful-apps-for-every-screen.png'),
        alt: 'Beautiful apps for every screen',
      ),
    );
  }

  Component _buildFeatureColumns(BuildContext context) {
    return FeatureColumnsSection([
      FeatureColumn(
        title: 'Single codebase',
        description:
            'Maintain one codebase and deploy to multiple platforms, speeding up and simplifying workflows.',
        image: context.asset('images/single-codebase.png'),
      ),
      FeatureColumn(
        title: 'Performant by design',
        description:
            'Flutter gives you the power of hardware-accelerated graphics for performant apps on any platform.',
        image: context.asset('images/performant-by-design.png'),
      ),
      FeatureColumn(
        title: 'Customize every pixel',
        description:
            'The Flutter rendering engine lets you control every pixel, and its widget library automatically adapts to any screen.',
        image: context.asset('images/customize-every-pixel.svg'),
      ),
    ]);
  }

  Component _buildFeatured(BuildContext context) {
    return section(id: 'featured', [
      div(classes: 'features container', [
        Feature(
          eyebrow: 'Mobile',
          title: 'iOS and Android apps',
          description:
              'Build features once and deploy to both iOS and Android. '
              'Cupertino and Material designs are built into the Flutter framework, so your apps feel at home on both platforms.',
          actions: const [
            FeatureAction(
              label: 'Flutter on mobile',
              url: '/development/mobile',
            ),
          ],
          media: img(
            src: context.asset('images/mobile.jpg'),
            alt: 'iOS and Android apps',
          ),
          active: true,
        ),
        Feature(
          eyebrow: 'Web',
          title: 'Web apps',
          description:
              'Reach users everywhere by deploying Flutter apps on the web. '
              'Build fast prototypes and deploy your mobile app to the web from the same codebase.',
          actions: const [
            FeatureAction(
              label: 'Flutter on the web',
              url: '/development/web',
            ),
          ],
          media: img(
            src: context.asset('images/web-apps.jpg'),
            alt: 'Web apps',
          ),
          reverse: true,
          active: true,
        ),
        Feature(
          eyebrow: 'Desktop',
          title: 'Windows, macOS, and Linux apps',
          description:
              'Transform your apps into desktop experiences with a single codebase and familiar tooling. Target Windows, macOS, and Linux without rewriting.',
          actions: const [
            FeatureAction(
              label: 'Flutter on desktop',
              url: '/development/desktop',
            ),
          ],
          media: img(
            src: context.asset('images/desktop.jpg'),
            alt: 'Windows, macOS, and Linux apps',
          ),
          active: true,
        ),
        Feature(
          eyebrow: 'Embedded',
          title: 'Flutter apps — anywhere',
          description:
              'Create custom solutions with the power and flexibility of Flutter. '
              'Deploy anywhere, including smart devices, cars, and more.',
          actions: const [
            FeatureAction(
              label: 'Flutter on embedded devices',
              url: '/development/embedded',
            ),
          ],
          media: img(
            src: context.asset('images/embedded.jpg'),
            alt: 'Flutter apps - anywhere',
          ),
          reverse: true,
          active: true,
        ),
        section(classes: 'module', [
          div(classes: 'features container', [
            Feature.stacked(
              eyebrow: 'Open source ecosystem',
              title: 'Join a vast open source ecosystem',
              features: const [
                FeatureInfo(
                  title: 'Pub.dev',
                  description:
                      'Pub.dev is the official package manager for Flutter and Dart packages. '
                      'Browse thousands of open source packages and plugins and get insights into package quality and popularity.',
                  actions: [
                    FeatureAction.link(
                      label: 'Explore packages',
                      url: 'https://pub.dev/',
                    ),
                    FeatureAction.link(
                      label: 'Community favorites',
                      url:
                          'https://docs.flutter.dev/packages-and-plugins/favorites',
                    ),
                  ],
                ),
                FeatureInfo(
                  title: 'Flutter repo',
                  description:
                      'Dive into the Flutter source code and get up to speed with well-documented, declarative code. '
                      'There\'s never any mystery with open source — the source for Flutter is right there in front of you. '
                      'View the latest updates, ask questions, open issues, and vote on proposals.',
                  actions: [
                    FeatureAction.link(
                      label: 'View GitHub repository',
                      url: 'https://github.com/flutter',
                    ),
                  ],
                ),
              ],
              reverse: true,
              noSpy: true,
              media: img(
                src: context.asset('images/open-source-ecosystem.jpg'),
                alt: 'Open source ecosystem',
              ),
            ),
            Feature(
              eyebrow: 'DevTools',
              title: 'Build confidently',
              description:
                  'Build confidently with a full suite of performance and debugging tools, '
                  'including widget and layout inspectors, network and memory profilers, and more.',
              actions: const [
                FeatureAction(
                  label: 'Explore the DevTools',
                  url: 'https://docs.flutter.dev/tools/devtools',
                ),
              ],
              media: img(
                src: context.asset('images/dev-tools.jpg'),
                alt: 'Build confidently',
              ),
              noSpy: true,
            ),
            Feature(
              eyebrow: 'Documentation',
              title: 'Extensive Flutter docs',
              description:
                  'Find documentation for everything Flutter - '
                  'from interactive examples and tutorials, to '
                  'building and deploying your first Flutter app.',
              actions: const [
                FeatureAction(
                  label: 'Get started',
                  url: 'https://docs.flutter.dev/get-started',
                ),
                FeatureAction.link(
                  label: 'Switching to Flutter? View our guides ',
                  url:
                      'https://docs.flutter.dev/get-started/learn-flutter#apply-your-existing-knowledge',
                  collapsed: false,
                ),
              ],
              media: img(
                src: context.asset('images/documentation.jpg'),
                alt: 'Documentation',
              ),
              reverse: true,
              noSpy: true,
            ),
            Feature(
              eyebrow: 'AI',
              title: 'Build GenAI experiences',
              description:
                  'Build your own generative AI-based features into Dart and Flutter apps with leading AI models and APIs.',
              actions: const [FeatureAction(label: 'Learn more', url: '/ai')],
              media: img(
                src: context.asset('images/build-ai-experiences.png'),
                alt: 'Gemini',
              ),
              noSpy: true,
            ),
          ]),
        ]),
      ]),
    ]);
  }
}
