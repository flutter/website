// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/common/feature.dart';
import '../components/common/icon.dart';
import '../components/sections/cta_section.dart';
import '../components/sections/newsletter_section.dart';
import '../models/content/community_content.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';
import '../utils/scroll_spy.dart';

class CommunityPage extends StatelessComponent {
  const CommunityPage({super.key});

  @override
  Component build(BuildContext context) {
    final communities = context.decodeJsonList(
      'community.communities',
      CommunityGroup.fromJson,
    );

    return main_([
      // Hero Section
      section(classes: 'hero', [
        div(classes: 'container', [
          div(classes: 'mantle', [
            const div(classes: 'text', [
              h1([.text('Join the Flutter Community')]),
              h3(classes: 'body', [
                .text(
                  'Connect with Flutter enthusiasts worldwide! Find local meetups, ',
                ),
                .text(
                  'online forums, and leadership opportunities to grow with the community.',
                ),
              ]),
              a(classes: 'btn', href: '/community#community-grid', [
                .text('Find online community'),
              ]),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/community-banner.png'),
                alt: 'Community',
              ),
            ]),
          ]),
        ]),
      ]),

      // Content Container
      section(
        classes: 'content-container',
        attributes: scroll.spy(scroll.headerOffset, .inContent),
        [
          // Meetups
          section(id: 'groups', classes: 'module', [
            div(classes: 'features container', [
              Feature(
                title: 'Meetups',
                description:
                    'Find a meetup group near you and connect with other Flutter developers.',
                actions: const [
                  FeatureAction(
                    label: 'Attend a meetup',
                    url: 'https://www.meetup.com/pro/flutter',
                  ),
                ],
                media: img(
                  src: context.asset('images/community-events-meetups.png'),
                  alt: 'Meetup groups',
                ),
                reverse: true,
                noSpy: true,
              ),
            ]),
          ]),

          // Flutter GDEs
          section(id: 'gdes', [
            div(classes: 'features container', [
              Feature(
                title: 'Flutter GDEs',
                description:
                    'Become a leader, support the Flutter ecosystem, and get access to exclusive resources.',
                actions: const [
                  FeatureAction(
                    label: 'Learn more',
                    solid: true,
                    url:
                        'https://developers.google.com/community/experts/directory',
                  ),
                ],
                media: img(
                  src: context.asset('images/flutter-gdes.jpg'),
                  alt: 'Flutter GDEs',
                ),
                noSpy: true,
              ),
            ]),
          ]),

          // Flutteristas
          section(id: 'flutteristas', classes: 'module', [
            div(classes: 'features container', [
              Feature(
                title: 'Flutteristas',
                description:
                    'Join individuals who identify as women or non-binary and have an interest in Flutter.',
                actions: const [
                  FeatureAction(
                    label: 'Join the Flutteristas',
                    url: 'https://flutteristas.org/',
                  ),
                ],
                media: img(
                  src: context.asset('images/flutteristas.jpg'),
                  alt: 'Flutteristas',
                ),
                reverse: true,
                noSpy: true,
              ),
            ]),
          ]),

          // Events
          section(id: 'events', [
            div(classes: 'features container', [
              Feature(
                title: 'Community events',
                description:
                    'Attend events hosted by the global Flutter community and continue to learn more about Flutter.',
                actions: const [
                  FeatureAction(
                    label: 'View events',
                    url: '/events',
                  ),
                ],
                media: img(
                  src: context.asset('images/community-events.jpg'),
                  alt: 'Community Events',
                ),
                noSpy: true,
              ),
            ]),
          ]),

          // Guidelines
          section(id: 'guidelines', classes: 'module', [
            div(classes: 'insert culture-insert container', [
              const div(classes: 'text', [
                h4(classes: 'eyebrow', [.text('Flutter Culture')]),
                h3([
                  .text(
                    'We strive to keep all Flutter community spaces welcoming and respectful',
                  ),
                ]),
                div([
                  a(href: '/culture', classes: 'btn', [
                    .text('Learn about Flutter\'s culture'),
                  ]),
                ]),
              ]),
              const div(classes: 'media', []),
              img(
                src: context.asset('images/community-guidelines-bg.jpg'),
                alt: 'Powered by Dart',
              ),
            ]),
          ]),

          // Community Grid
          section(id: 'community-grid', classes: 'module', [
            div(classes: 'feature-grid container', [
              const div(classes: 'feature-header', [
                Component.element(
                  tag: 'hgroup',
                  children: [
                    h4(classes: 'eyebrow', [.text('Find Community Online')]),
                    h2([.text('Get involved and ask questions')]),
                  ],
                ),
              ]),
              div(classes: 'feature-grid-features col-3', [
                for (final item in communities) _buildGridItem(context, item),
              ]),
            ]),
          ]),

          // Contribute
          section(id: 'contribute', classes: 'module', [
            div(classes: 'features container', [
              Feature.stacked(
                eyebrow: 'Contribute',
                title: 'Contribute to\nFlutter on Github',
                features: const [
                  FeatureInfo(
                    title: 'Read the Contributing Guide',
                    description: '',
                    actions: [
                      FeatureAction.link(
                        label: 'Read more',
                        url:
                            'https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md',
                      ),
                    ],
                  ),
                  FeatureInfo(
                    title: 'Tell us what you want to see',
                    description: '',
                    actions: [
                      FeatureAction.link(
                        label: 'Issue tracker',
                        url: 'https://github.com/flutter/flutter/issues',
                      ),
                    ],
                  ),
                ],
                full: true,
                noSpy: true,
              ),
            ]),
          ]),
          const NewsletterSection(),
          const CTASection(),
        ],
      ),
    ]);
  }

  Component _buildGridItem(BuildContext context, CommunityGroup item) {
    final extra = item.hasSubscribeButton
        ? const div(classes: 'btn quiet collapsed', [
            .text('Subscribe to the newsletter '),
            RawText('&nbsp;'),
            Icon.linkArrow(),
          ])
        : null;
    return div([
      a(href: item.href, target: Target.blank, [
        div(classes: 'community-icon ${item.isFramed ? "framed-icon" : ""}', [
          img(src: context.asset(item.imgSrc), alt: item.imgAlt),
        ]),
        h3([
          .text(item.title),
          const Icon.linkArrow(large: true),
        ]),
        p([.text(item.description)]),
        ?extra,
      ]),
    ]);
  }
}
