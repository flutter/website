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

class EmbeddedPage extends StatelessComponent {
  const EmbeddedPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      HeroSection(
        title: 'Flutter on Embedded Devices',
        text:
            'Flutter\'s support for custom embedders means '
            'you can create new ways to put Flutter to '
            'work on the platforms that matter to you.',
        media: img(
          src: context.asset('images/flutter-on-embedded-devices.png'),
          alt: 'Flutter on Embedded Devices',
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        FeatureColumnsSection([
          FeatureColumn(
            title: 'Layered architecture',
            description:
                'Flutter provides a clean interface for custom embedders that '
                'can power Flutter apps on new hardware and operating systems.',
            image: context.asset('images/iterate-locally.png'),
          ),
          FeatureColumn(
            title: 'Portable code',
            description:
                'Since Dart is portable, Flutter can '
                'use the same rendering stack no matter '
                'which embedder spins it up, maximizing code reuse.',
            image: context.asset('images/portable-code.png'),
          ),
          FeatureColumn(
            title: 'Work with native code',
            description:
                'Flutter\'s platform channels can '
                'put a single Dart interface on native code for '
                'mobile, web, desktop, or your embedded platform.',
            image: context.asset('images/growing-ecosystem.png'),
          ),
        ]),
        section(id: 'feature-grid', classes: 'module', [
          FeatureGrid(
            eyebrow: 'Resources',
            title: 'Start learning about Flutter on embedded devices',
            items: [
              FeatureGridItem(
                title: 'See the samples',
                description:
                    'Reference code examples and sample applications for '
                    'building Flutter embedded apps while you learn.',
                icon: context.asset('../images/icons/see-the-samples.svg'),
                url:
                    'https://github.com/flutter/engine/tree/main/examples/glfw#flutter-embedder-engine-glfw-example',
              ),
              FeatureGridItem(
                title: 'Watch the video',
                description:
                    'Hear how Toyota is building with Flutter for '
                    'their in-dash infotainment systems and the '
                    'impact it’s had on productivity.',
                icon: context.asset('../images/icons/watch-the-video.svg'),
                url: 'https://www.youtube.com/watch?v=zSbsIiluixw&t=1946s',
              ),
              FeatureGridItem(
                title: 'Follow the roadmap',
                description:
                    'Learn more about building '
                    'custom Flutter engine embedders for '
                    'target devices not supported out of the box.',
                icon: context.asset('../images/icons/follow-the-roadmap.svg'),
                url:
                    'https://github.com/flutter/engine/blob/main/docs/Custom-Flutter-Engine-Embedders.md',
              ),
            ],
          ),
        ]),
        const section(id: 'case-studies', classes: 'module carousel-section', [
          CaseStudies(tag: 'embedded'),
        ]),
        const CTASection(),
      ]),
    ]);
  }
}
