// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/common/feature_grid.dart';
import '../components/common/icon.dart';
import '../components/sections/case_studies.dart';
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
        title: 'Pixel-Perfect Web Applications',
        text:
            'Bring your native app experience to the browser. '
            'Powered by WebAssembly for stable, 60fps performance. '
            'Best for SPAs, PWAs, and complex web tools.',
        media: img(
          src: context.asset('images/flutter-on-web.png'),
          alt: 'Flutter on Web',
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        FeatureColumnsSection([
          FeatureColumn(
            title: 'Same code',
            description:
                'Your code — your Dart business logic and your Flutter widgets — '
                'works identically across mobile, desktop, and the web, eliminating duplicate work.',
            image: context.asset('images/all-one-codebase.png'),
          ),
          FeatureColumn(
            title: 'Same experience',
            description:
                'Flutter uses the same rendering engine on the web and mobile, '
                'ensuring your application looks and feels exactly the same without fighting browser and platform differences.',
            image: context.asset('images/reach-more-users.png'),
          ),
          FeatureColumn(
            title: 'Great performance',
            description:
                'Deploy your web application with WebAssembly (Wasm) for a blazing-fast, '
                'jank-free experience across modern browsers.',
            image: context.asset('images/build-wasm.png'),
            imageAlt: 'Ship with WebAssembly',
          ),
        ]),
        const section(classes: 'module', [
          div(classes: 'use-cases-header stacked-header container', [
            h2([.text('When to use Flutter on the web')]),
          ]),
          div(classes: 'container', [
            div(classes: 'use-cases-grid', [
              div(classes: 'use-case-col ideal', [
                h4([.text('Ideal use cases ✅')]),
                ul([
                  li([
                    .text(
                      'Progressive Web Apps (PWAs) and single-page apps (SPAs).',
                    ),
                  ]),
                  li([
                    .text(
                      'Code sharing: Reusing UI and logic between mobile, desktop, and web apps.',
                    ),
                  ]),
                  li([
                    .text(
                      'Rich application UIs: Productivity, creative, or specialized business tools (for example, ',
                    ),
                    a(
                      href: 'https://docs.flutter.dev/tools/devtools',
                      [.text('Dart & Flutter DevTools')],
                    ),
                    .text(').'),
                  ]),
                  li([
                    .text(
                      'Highly interactive canvas apps: Complex dashboards, games, or visualization tools.',
                    ),
                  ]),
                ]),
              ]),
              div(classes: 'use-case-col less-ideal', [
                h4([.text('Less ideal use cases ⚠️')]),
                ul([
                  li([
                    .text(
                      'SEO-heavy sites: Static blogs, documentation, or public marketing pages.',
                    ),
                  ]),
                  li([
                    .text(
                      'Simple static web pages: Simple landing pages or sites with minimal interaction.',
                    ),
                  ]),
                  li([
                    .text(
                      'Heavy text selection: Pages where standard DOM-based text-selection and reader mode are critical.',
                    ),
                  ]),
                ]),
              ]),
            ]),
            div(classes: 'use-cases-note', [
              p([
                .text(
                  'Building content-centric or SEO-heavy sites? Consider ',
                ),
                a(href: 'https://jaspr.site/', [.text('Jaspr')]),
                .text(' (which powers '),
                a(href: 'https://dart.dev', [.text('dart.dev')]),
                .text(', '),
                a(href: 'https://flutter.dev', [.text('flutter.dev')]),
                .text(', and '),
                a(href: 'https://pub.dev', [.text('pub.dev')]),
                .text(
                  ') or combining Jaspr with Flutter Web for a hybrid experience.',
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
        section(id: 'cta', classes: 'module', [
          div(classes: 'insert cta-insert container', [
            const div(classes: 'text', [
              h3([.text('Get started')]),
              p([.text('Choose the pathway that matches your experience:')]),
              div(classes: 'cta-buttons', [
                div(classes: 'cta-pathway', [
                  h4([.text('Existing Flutter Developer')]),
                  a(
                    href: 'https://docs.flutter.dev/get-started/web',
                    classes: 'btn',
                    [
                      .text('Add web support'),
                    ],
                  ),
                ]),
                div(classes: 'cta-pathway', [
                  h4([.text('New to Flutter (Web Developer)')]),
                  a(
                    href:
                        'https://docs.flutter.dev/get-started/flutter-for/web-devs',
                    classes: 'btn quiet',
                    [
                      .text('Get started'),
                      RawText('&nbsp;'),
                      Icon.linkArrow(),
                    ],
                  ),
                ]),
              ]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('/images/common/get-started-background.png'),
                alt: 'Powered by Dart',
              ),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}
