// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/common/feature.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/feature_columns_section.dart';
import '../components/sections/hero_section.dart';
import '../utils/asset_utils.dart';
import '../utils/scroll_spy.dart';

class EcosystemPage extends StatelessComponent {
  const EcosystemPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      HeroSection(
        title: 'A strong ecosystem, powered by open source',

        text:
            'From packages and plugins to friendly developers, '
            'find all of the resources you need to be successful with Flutter.',
        media: img(
          src: context.asset('images/strong-ecosystem-open-source.png'),
          alt: 'Strong Ecosystem',
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        FeatureColumnsSection([
          FeatureColumn(
            title: 'Community',
            description:
                'Join developers around the world who are building with Flutter.',
            image: context.asset('images/community.jpg'),
          ),
          FeatureColumn(
            title: 'Events',
            description:
                'Learn about the latest Flutter developments at our global events.',
            image: context.asset('images/events.jpg'),
          ),
          FeatureColumn(
            title: 'Packages',
            description:
                'Find open source packages to help you build powerful Flutter apps.',
            image: context.asset('images/packages.png'),
          ),
        ]),
        section(id: 'community-feature', [
          div(classes: 'features container', [
            Feature(
              eyebrow: 'Community',
              title: 'Get involved',
              description:
                  'Connect with Flutter developers around the world, find answers, and contribute to the framework in our welcoming community spaces.',
              actions: const [
                FeatureAction(label: 'Join the community', url: '/community'),
                FeatureAction.link(
                  label: 'More about Flutter culture',
                  url:
                      'https://blog.flutter.dev/flutter-culture-and-how-to-preserve-it-436b4ed1031d',
                  collapsed: false,
                ),
              ],
              media: img(
                src: context.asset('images/community-get-involved.png'),
                alt: 'Community get involved',
              ),
              noSpy: true,
            ),
          ]),
        ]),
        section(id: 'consultants-feature', [
          div(classes: 'features container', [
            Feature(
              eyebrow: 'Consultants',
              title: 'Find a Flutter consultant',
              description:
                  'Find trusted Flutter partners. '
                  'We vet the partners listed in the directory to '
                  'verify their record of successful Flutter projects, '
                  'a sufficient number of skilled developers on staff, and '
                  'their commitment to growing the Flutter community.',
              actions: const [
                FeatureAction(
                  label: 'Find Consultants',
                  solid: true,
                  url: '/consultants',
                ),
              ],
              media: img(
                src: context.asset('images/consultants.png'),
                alt: 'Ecosystem Consultants',
              ),
              reverse: true,
              noSpy: true,
            ),
          ]),
        ]),
        section(id: 'consultants-everyone', [
          div(classes: 'features container', [
            Feature(
              eyebrow: 'Events',
              title: 'Everyone is invited',
              description:
                  'View upcoming events and see all of the latest '
                  'talks and announcements from previous events.',
              actions: const [
                FeatureAction(label: 'See events', url: '/events'),
              ],
              media: img(
                src: context.asset('images/everyone-is-invited.png'),
                alt: 'Everyone is invited',
              ),
              noSpy: true,
            ),
          ]),
        ]),
        section(id: 'consultants-packages', [
          div(classes: 'features container', [
            Feature(
              eyebrow: 'Packages & integrations',
              title: 'Find what you need on pub.dev',
              description:
                  'Browse over 20,000 packages, plugins, and integrations for '
                  'custom UI components, authentication solutions, '
                  'state management libraries, and more.',
              actions: const [
                FeatureAction(
                  label: 'Explore packages',
                  url: 'https://pub.dev/',
                ),
              ],
              media: img(
                src: context.asset('images/packages-integrations.png'),
                alt: 'Packages and integrations',
              ),
              reverse: true,
              noSpy: true,
            ),
          ]),
        ]),
        const CTASection(),
      ]),
    ]);
  }
}
