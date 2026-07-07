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

class DesktopPage extends StatelessComponent {
  const DesktopPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      HeroSection(
        title: 'Flutter on Desktop',
        text:
            'Build high-quality desktop apps without compromising compatibility or performance.',
        media: img(
          src: context.asset('images/flutter-on-desktop.png'),
          alt: 'Flutter on Desktop',
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        FeatureColumnsSection([
          FeatureColumn(
            title: 'Build performantly',
            description:
                'Get native-compiled performance without large browser engine dependencies.',
            image: context.asset('images/build-performant.png'),
          ),
          FeatureColumn(
            title: 'Target more users',
            description:
                'Reach more users across the Windows, Mac App, and Linux Snap stores.',
            image: context.asset('images/target-more-users.svg'),
          ),
          FeatureColumn(
            title: 'Native functionality',
            description:
                'Get full access to the underlying Win32, Cocoa, or UNIX platform APIs.',
            image: context.asset('images/native-functionality.png'),
          ),
        ]),
        section([
          div(classes: 'features container', [
            div(classes: 'feature nospy', [
              const div(classes: 'text', [
                Component.element(
                  tag: 'hgroup',
                  children: [
                    h4(classes: 'eyebrow', [.text('Flutter on Desktop')]),
                    h3([.text('Scale desktop support')]),
                  ],
                ),
                p([
                  .text(
                    'Bring your mobile or web experience to desktop devices from the same codebase to reach more users with a natively performant Flutter desktop application.',
                  ),
                ]),
                a(
                  classes: 'btn',
                  href: 'https://docs.flutter.dev/platform-integration/desktop',
                  [.text('Learn more')],
                ),
              ]),
              div(classes: 'media', [
                img(
                  src: context.asset('images/scale-desktop-support.png'),
                  alt: 'Scale desktop support',
                ),
              ]),
            ]),
          ]),
        ]),
        section(id: 'feature-grid', classes: 'module', [
          FeatureGrid(
            eyebrow: 'Resources',
            title: 'Start learning about Flutter on desktop devices',
            items: [
              FeatureGridItem(
                title: 'See it in action',
                description:
                    'Flutter Folio is a multi-platform Flutter app that looks and feels great on mobile, web, and desktop devices.',
                icon: context.asset('../images/icons/see-the-samples.svg'),
                url: 'https://flutter.gskinner.com/folio/',
              ),
              FeatureGridItem(
                title: 'Watch the video',
                description:
                    'Learn how to build a desktop design language with Flutter through a custom widget set for desktop applications.',
                icon: context.asset('../images/icons/watch-the-video.svg'),
                url: 'https://www.youtube.com/watch?v=z6PpxO7R0gM',
              ),
              FeatureGridItem(
                title: 'Get started in docs',
                description:
                    'Dig in and start building with more detailed resources for Flutter on desktop devices in docs.',
                icon: context.asset('../images/icons/get-started-in-docs.svg'),
                url: 'https://docs.flutter.dev/platform-integration/desktop',
              ),
              FeatureGridItem(
                title: 'Follow the roadmap',
                description:
                    'See where we’re going and how you can be involved. Flutter support for desktop is continually growing and evolving.',
                icon: context.asset('../images/icons/follow-the-roadmap.svg'),
                url:
                    'https://github.com/flutter/flutter/blob/main/docs/roadmap/Roadmap.md',
              ),
            ],
          ),
        ]),
        const section(id: 'case-studies', classes: 'module carousel-section', [
          CaseStudies(tag: 'desktop'),
        ]),
        const CTASection(),
      ]),
    ]);
  }
}
