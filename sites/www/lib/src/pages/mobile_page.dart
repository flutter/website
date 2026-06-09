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

class MobilePage extends StatelessComponent {
  const MobilePage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      _buildHero(context),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        _buildFeatureColumns(context),
        _buildFeatureAsOneTeam(context),
        _buildResources(context),
        const section(id: 'case-studies', classes: 'module carousel-section', [
          CaseStudies(tag: 'mobile'),
        ]),
        const CTASection(),
      ]),
    ]);
  }

  Component _buildHero(BuildContext context) {
    return HeroSection(
      title: 'Flutter on Mobile',
      text:
          'Bring your app idea to more users from day one by building with Flutter on iOS and Android simultaneously, without sacrificing features, quality, or performance.',
      media: img(
        src: context.asset('images/flutter-on-mobile.png'),
        alt: 'Flutter on Mobile',
      ),
    );
  }

  Component _buildFeatureColumns(BuildContext context) {
    return FeatureColumnsSection([
      FeatureColumn(
        title: 'All mobile on day one',
        description:
            'Reach your full addressable market from day one by targeting users in both ecosystems from a single codebase.',
        image: context.asset('images/all-mobile-day-one.png'),
      ),
      FeatureColumn(
        title: 'Do more with less',
        description:
            'Unite your mobile development team resources towards building one seamless customer experience.',
        image: context.asset('images/do-more-with-less.png'),
      ),
      FeatureColumn(
        title: 'One experience',
        description:
            'Release simultaneously on iOS and Android with feature parity for the best experience for all users.',
        image: context.asset('images/one-experience.png'),
      ),
    ]);
  }

  Component _buildFeatureAsOneTeam(BuildContext context) {
    return section([
      div(classes: 'features container', [
        div(classes: 'feature nospy', [
          const div(classes: 'text', [
            Component.element(
              tag: 'hgroup',
              children: [
                h4(classes: 'eyebrow', [.text('Flutter on Mobile')]),
                h3([.text('Build for all as one team')]),
              ],
            ),
            p([
              .text(
                'Flutter empowers you to create tailored experiences for iOS and Android users without compromise and with fewer resources.',
              ),
            ]),
            a(classes: 'btn', href: 'https://docs.flutter.dev/#docs', [
              .text('Learn more'),
            ]),
          ]),
          div(classes: 'media', [
            img(
              src: context.asset('images/build-for-all-as-one-team.png'),
              alt: 'Build for all as one team',
            ),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildResources(BuildContext context) {
    return section(id: 'feature-grid', classes: 'module', [
      FeatureGrid(
        eyebrow: 'Resources',
        title: 'Start learning about Flutter on mobile devices',
        items: [
          FeatureGridItem(
            title: 'See the samples',
            description:
                'Reference code examples and sample applications for building Flutter mobile apps while you learn.',
            icon: context.asset('../images/icons/see-the-samples.svg'),
            url: 'https://flutter.github.io/samples/#',
          ),
          FeatureGridItem(
            title: 'Watch the video',
            description:
                'Learn how to build platform adaptive apps that look and feel natural on any mobile device with the same code.',
            icon: context.asset('../images/icons/watch-the-video.svg'),
            url: 'https://www.youtube.com/watch?v=RCdeSKVt7LI',
          ),
          FeatureGridItem(
            title: 'Get started in docs',
            description:
                'Dig in and start building with more detailed resources for Flutter on mobile in docs.',
            icon: context.asset('../images/icons/get-started-in-docs.svg'),
            url: 'https://docs.flutter.dev/get-started/codelab',
          ),
          FeatureGridItem(
            title: 'Follow the roadmap',
            description:
                'See where we’re going and how to be involved. Flutter support for mobile is continually growing and evolving.',
            icon: context.asset('../images/icons/follow-the-roadmap.svg'),
            url:
                'https://github.com/flutter/flutter/blob/main/docs/roadmap/Roadmap.md',
          ),
        ],
      ),
    ]);
  }
}
