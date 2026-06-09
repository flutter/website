// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/common/feature_grid.dart';
import '../components/sections/case_studies.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/feature_columns_section.dart';
import '../components/sections/hero_section.dart';
import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class WebPage extends StatelessComponent {
  const WebPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      HeroSection(
        title: 'Flutter on the Web',
        text:
            'Easily reach more users in browsers with the same experience as '
            'on mobile devices through the power of Flutter on the web.',
        media: img(
          src: context.asset('images/flutter-on-web.png'),
          alt: 'Flutter on Web',
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        FeatureColumnsSection([
          FeatureColumn(
            title: 'Shared codebase',
            description:
                'Share your Dart code between mobile and web applications; '
                'web is just another device target for your app.',
            image: context.asset('images/all-one-codebase.png'),
          ),
          FeatureColumn(
            title: 'Reach more users',
            description:
                'Acquire users beyond app stores without limitations from '
                'just a click of a URL in a web browser.',
            image: context.asset('images/reach-more-users.png'),
          ),
          FeatureColumn(
            title: 'Powered by WebAssembly',
            description:
                'Ship your app using WebAssembly for '
                'an efficient and fast experience on the web.',
            image: context.asset('images/build-wasm.png'),
            imageAlt: 'Ship with WebAssembly',
          ),
        ]),
        section([
          div(classes: 'features container', [
            div(classes: 'feature nospy', [
              const div(classes: 'text', [
                Component.element(
                  tag: 'hgroup',
                  children: [
                    h4(classes: 'eyebrow', [.text('Flutter on the Web')]),
                    h3([.text('Build better web apps')]),
                  ],
                ),
                p([
                  .text(
                    'The web itself is a flexible platform, but Flutter is '
                    'ideal for building web applications like PWAs or SPAs '
                    'and bringing your existing mobile app to the web. ',
                  ),
                ]),
                a(
                  classes: 'btn',
                  href: 'https://docs.flutter.dev/get-started/web',
                  [.text('Learn more')],
                ),
              ]),
              div(classes: 'media', [
                img(
                  src: context.asset('images/build-better-web-apps.png'),
                  alt: 'Build better web apps',
                ),
              ]),
            ]),
          ]),
        ]),
        section(id: 'feature-grid', classes: 'module', [
          FeatureGrid(
            eyebrow: 'Resources',
            title: 'Start learning about Flutter on the web',
            items: [
              FeatureGridItem(
                title: 'See the samples',
                description:
                    'Reference code examples and sample applications for '
                    'building Flutter web apps while you learn.',
                icon: context.asset('../images/icons/see-the-samples.svg'),
                url: 'https://flutter.github.io/samples/#?platform=web',
              ),
              FeatureGridItem(
                title: 'Watch the video',
                description:
                    'What\'s new in Flutter. Learn how WebAssembly works and '
                    'how it makes Flutter web apps faster.',
                icon: context.asset('../images/icons/watch-the-video.svg'),
                url: 'https://www.youtube.com/watch?v=lpnKWK-KEYs',
              ),
              FeatureGridItem(
                title: 'Get started in docs',
                description:
                    'Dig in and start building with more '
                    'detailed resources for Flutter on the web in docs.',
                icon: context.asset('../images/icons/get-started-in-docs.svg'),
                url: 'https://docs.flutter.dev/platform-integration/web',
              ),
              FeatureGridItem(
                title: 'Learn about Wasm support',
                description:
                    'See how to deploy your app using WebAssembly and '
                    'learn more about how it works.',
                icon: context.asset('../images/icons/follow-the-roadmap.svg'),
                url: 'https://docs.flutter.dev/platform-integration/web/wasm',
              ),
            ],
          ),
        ]),
        const section(id: 'case-studies', classes: 'module carousel-section', [
          CaseStudies(tag: 'web'),
        ]),
        const CTASection(),
      ]),
    ]);
  }
}
