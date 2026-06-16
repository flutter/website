// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';

import '../components/common/carousel.dart';
import '../components/common/feature_grid.dart';
import '../components/common/icon.dart';
import '../components/common/tabs.dart';
import '../components/common/video_carousel.dart';
import '../components/pages/games_adaptive_media.dart';
import '../components/sections/hero_section.dart';
import '../models/content/games_content.dart';
import '../models/video.dart';
import '../utils/asset_utils.dart';
import '../utils/data_utils.dart';
import '../utils/scroll_spy.dart';

class GamesPage extends StatelessComponent {
  const GamesPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      HeroSection(
        title: 'Flutter Casual Games Toolkit',
        subtitle:
            'Free & open source multiplatform 2D game development in Flutter',
        media: GamesAdaptiveMedia(
          mobileAssets: {
            'Games Header Debertz': context.asset(
              'images/games-header-debertz.png',
            ),
            'Games Header Trivia Crack': context.asset(
              'images/games-header-trivia-crack.png',
            ),
            'Games Header Landover': context.asset(
              'images/games-header-landover.png',
            ),
          },
          desktopAssets: {
            'Games Header Gif': context.asset('images/games-header.gif'),
          },
        ),
      ),
      section(classes: 'content-container', attributes: scroll.spyContent, [
        section(id: 'feature-columns', classes: 'module', [
          div(classes: 'feature-columns container', [
            div(classes: 'feature-wrapper', [
              const div(classes: 'text', [
                h3([.text('Free & open source')]),
                p(classes: 'body', [
                  .text(
                    'No seat charges or usage fees; use under BSD license for access to every line of code - no black boxes',
                  ),
                ]),
              ]),
              img(
                src: context.asset('images/free-open-source.png'),
                alt: 'Free & open source',
              ),
            ]),
            div(classes: 'feature-wrapper', [
              const div(classes: 'text', [
                h3([.text('Multi-platform games')]),
                p(classes: 'body', [
                  .text(
                    'Write your game once and deploy on Android, iOS, Web, and Desktop devices to reach more users from day one',
                  ),
                ]),
              ]),
              img(
                src: context.asset('images/multiplatform-games.png'),
                alt: 'Multi-platform games',
              ),
            ]),
            div(classes: 'feature-wrapper', [
              const div(classes: 'text', [
                h3([.text('Packages & integrations')]),
                p(classes: 'body', [
                  .text(
                    'Speed up development with pre-built integrations for '
                    'services like Ads, IAP, Firebase, Google Play, and Game Center',
                  ),
                ]),
              ]),
              img(
                src: context.asset('images/packages-integrations.png'),
                alt: 'Packages & integrations',
              ),
            ]),
          ]),
        ]),
        section(id: 'tabs', classes: 'games-tabs', [
          Tabs(
            title: ref(
              const h2(classes: 'tabs-title', [
                .text('''
            From card games to platformers and casual 2D games. Start building your first game in minutes with templates to get started fast.
          '''),
              ]),
            ),
            tabs: [
              Tab(
                label: 'Endless Runner',
                content: ref(
                  .fragment([
                    div(classes: 'media', [
                      img(
                        src: context.asset(
                          'images/template-endless-runner.gif',
                        ),
                        alt: 'Endless Runner',
                      ),
                    ]),
                    const div(classes: 'text', [
                      h2(classes: 'title first-tab', [.text('Endless Runner')]),
                      p(classes: 'body', [
                        .text('''
                  A side-scrolling infinite loop game that uses the Flame Game Engine to animate a character that avoids obstacles while running through the map.
                '''),
                      ]),
                      div(classes: 'a-wrapper', [
                        a(
                          classes: 'btn white-btn',
                          href:
                              'https://github.com/flutter/games/tree/main/templates/endless_runner',
                          [.text('Get started')],
                        ),
                      ]),
                    ]),
                  ]),
                ),
              ),
              Tab(
                label: 'Basic Template',
                content: ref(
                  .fragment([
                    div(classes: 'media', [
                      img(
                        src: context.asset('images/template-basic.gif'),
                        alt: 'Basic Template',
                      ),
                    ]),
                    const div(classes: 'text', [
                      h2(classes: 'title second-tab', [
                        .text('Basic Template'),
                      ]),
                      p(classes: 'body', [
                        .text('''
                  A simple template to get started with your first Flutter game including start and end screens, audio integrations and game settings pages.
                '''),
                      ]),
                      div(classes: 'a-wrapper', [
                        a(
                          classes: 'btn white-btn',
                          href:
                              'https://github.com/flutter/games/tree/main/templates/basic',
                          [.text('Get started')],
                        ),
                      ]),
                    ]),
                  ]),
                ),
              ),
              Tab(
                label: 'Card Game',
                content: ref(
                  .fragment([
                    div(classes: 'media', [
                      img(
                        src: context.asset('images/template-card-game.gif'),
                        alt: 'Card Game',
                      ),
                    ]),
                    const div(classes: 'text', [
                      h2(classes: 'title third-tab', [.text('Card Game')]),
                      p(classes: 'body', [
                        .text('''
                  Drag and drop cards in a simple UI for a card game built from the Basic Template, ready for multiplayer integration and more
                '''),
                      ]),
                      div(classes: 'a-wrapper', [
                        a(
                          classes: 'btn white-btn',
                          href:
                              'https://github.com/flutter/games/tree/main/templates/card',
                          [.text('Get started')],
                        ),
                      ]),
                    ]),
                  ]),
                ),
              ),
            ],
          ),
          const div(classes: 'divider', []),
        ]),
        section(id: 'dash-demo', [
          div(classes: 'features container', [
            div(classes: 'feature nospy', [
              const div(classes: 'text', [
                Component.element(
                  tag: 'hgroup',
                  children: [
                    h4(classes: 'eyebrow', [.text('Play now')]),
                    h3([.text('Super Dash Demo Game')]),
                  ],
                ),
                p(classes: 'body', [
                  .text(
                    'Try the new open source Super Dash demo on your desktop to '
                    'experience a Flutter browser game built with the Flame Game Engine or download on mobile for iOS and Android. '
                    'Avoid the bugs, collect points, and see how far you can go!',
                  ),
                ]),
                div(classes: 'btn-wrapper', [
                  a(classes: 'btn', href: 'https://superdash.flutter.dev/', [
                    .text('Play now'),
                  ]),
                  a(
                    classes: 'btn quiet',
                    href: 'https://github.com/flutter/super_dash',
                    [
                      .text('Get the code '),
                      RawText('&nbsp;'),
                      Icon.linkArrow(),
                    ],
                  ),
                ]),
              ]),
              div(classes: 'media', [
                img(
                  src: context.asset('images/super-dash-demo.gif'),
                  alt: 'Dash Demo Game',
                ),
              ]),
            ]),
          ]),
        ]),
        section(id: 'flame', [
          div(classes: 'features container', [
            div(classes: 'feature nospy', [
              const div(classes: 'text', [
                Component.element(
                  tag: 'hgroup',
                  children: [
                    h4(classes: 'eyebrow', [.text('Flame')]),
                    h3([.text('2D Flutter Game Engine')]),
                  ],
                ),
                p(classes: 'body', [
                  .text(
                    'Flame is a community built open source game engine built in Flutter that extends Flutter’s game development capabilities for games that require a game loop, collision, and maps. '
                    'It takes advantage of the powerful infrastructure provided by Flutter, but simplifies the code you need to build your game.',
                  ),
                ]),
                a(classes: 'btn', href: 'https://flame-engine.org/', [
                  .text('Learn more'),
                ]),
              ]),
              div(classes: 'media', [
                img(
                  src: context.asset('images/flame.png'),
                  alt: 'Flame Flutter Game',
                ),
              ]),
            ]),
          ]),
        ]),
        _buildStoriesSection(context),
        section(id: 'resources', [
          FeatureGrid(
            eyebrow: 'Get started',
            title: 'Learn more about building games in Flutter',
            items: [
              FeatureGridItem(
                title: 'Watch the video',
                description:
                    'Learn why Flutter is a great choice for game developers '
                    'with an introduction to the Flutter Casual Games Toolkit.',
                icon: context.asset('images/watch-video.png'),
                url: 'https://youtu.be/oi6zk7cVHUw?si=z1i7xAxRRbs3tQUI',
              ),
              FeatureGridItem(
                title: 'Get started in docs',
                description:
                    'Documentation and tutorials for getting started with '
                    'the Flutter Casual Games Toolkit.',
                icon: context.asset('images/get-started-docs.png'),
                url: 'https://docs.flutter.dev/resources/games-toolkit',
              ),
              FeatureGridItem(
                title: 'Join the community',
                description:
                    'Meet other game developers building in Flutter in the Flame Community Discord Server',
                icon: context.asset('images/join-community.png'),
                url: 'https://discord.com/invite/pxrBmy4',
              ),
            ],
          ),
        ]),
        _buildFeaturedGamesSection(context),
        const section(id: 'playlist', classes: 'module carousel-section', [
          div(classes: 'stacked-header container flutter-resources', [
            div([
              p([.text('YouTube learning')]),
              h2([.text('Flutter games resources')]),
            ]),
            a(
              classes: 'btn white-btn',
              href:
                  'https://www.youtube.com/playlist?list=PLjxrf2q8roU20X0-JrLJ_zODME0sjnelZ',
              [.text('View all')],
            ),
          ]),
          VideoCarousel(videos: _gameVideos),
        ]),
        section(id: 'developer-stories', [
          div(classes: 'insert container', [
            const div(classes: 'text', [
              h4(classes: 'eyebrow', [.text('Developer story')]),
              h3([
                .text(
                  'Learn how PUBG launched 80% faster '
                  'adding Flutter to their existing game.',
                ),
              ]),
              a(
                classes: 'btn quiet',
                href: 'https://flutter.dev/showcase/pubg-mobile',
                [
                  .text('Read story '),
                  RawText('&nbsp;'),
                  Icon.linkArrow(),
                ],
              ),
            ]),
            div(classes: 'media', [
              img(
                src: context.asset('images/developer-story.gif'),
                alt: 'Google Play',
              ),
            ]),
          ]),
        ]),
        section(id: 'level-up', classes: 'module', [
          div(classes: 'container', [
            const div(classes: 'stacked-header', [
              Component.element(
                tag: 'hgroup',
                children: [
                  h4(classes: 'eyebrow', [.text('Google services')]),
                  h2([.text('Level up your Flutter game')]),
                  p([
                    .text(
                      'Enhance your game with up to \$900 in '
                      'offers from Google (terms and conditions apply)',
                    ),
                  ]),
                ],
              ),
            ]),
            div(classes: 'feature-compare', [
              div([
                div(classes: 'media', [
                  img(
                    src: context.asset('images/google-ads-icon.png'),
                    alt: 'Google Ads',
                  ),
                ]),
                const div(classes: 'text', [
                  h3([.text('Google Ads')]),
                  p([
                    .text(
                      'Receive \$500 in ad credit when you spend \$500 with Google Ads.',
                    ),
                  ]),
                  p(classes: 'subtitle', [
                    .text('Terms and conditions apply. '),
                    a(
                      href:
                          'https://www.google.com/intl/en/ads/coupons/terms/flutter/',
                      [.text('Click here')],
                    ),
                    .text(''' to check your region's elibility.
                '''),
                  ]),
                  a(
                    classes: 'btn white',
                    href: 'https://ads.google.com/intl/en_us/home/',
                    target: Target.blank,
                    [.text('Get started')],
                  ),
                ]),
              ]),
              div([
                div(classes: 'media', [
                  img(
                    src: context.asset('images/cloud-plus-firebase.png'),
                    alt: 'Cloud + Firebase',
                  ),
                ]),
                const div(classes: 'text', [
                  h3([.text('Cloud Platform + Firebase')]),
                  p([
                    .text(
                      'Receive up to \$400 across your choice of back-end services.',
                    ),
                  ]),
                  p(classes: 'subtitle', [
                    .text(
                      '*You must connect your Firebase and GCP accounts to '
                      'use credits for Firebase services',
                    ),
                  ]),
                  a(
                    classes: 'btn white',
                    href:
                        'https://cloud.google.com/free?utm_source=flutter&utm_medium=display&utm_campaign=FY22-Q2-flutter-games_get-started&utm_content=-&utm_term=-',
                    target: Target.blank,
                    [.text('Get started')],
                  ),
                ]),
              ]),
            ]),
          ]),
        ]),
        section(id: 'cta', classes: 'module', [
          div(classes: 'insert cta-insert container', [
            const div(classes: 'text', [
              h3([.text('Start building')]),
              p([.text('Get started with your first Flutter Game')]),
              div([
                a(
                  classes: 'btn',
                  href: 'https://docs.flutter.dev/resources/games-toolkit',
                  [.text('View docs')],
                ),
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

  Component _buildStoriesSection(BuildContext context) {
    final integrations = context.decodeJsonList(
      'games.data.integrations',
      GameIntegration.fromJson,
    );

    return section(id: 'stories', classes: 'module', [
      div(classes: 'story-grid container', [
        const div(classes: 'story-grid-header', [
          h4(classes: 'eyebrow', [.text('Enhancements')]),
          h3([.text('Flutter game integrations')]),
        ]),
        div(classes: 'story-grid-items', [
          for (final integration in integrations)
            _buildStoryItem(context, integration),
        ]),
      ]),
    ]);
  }

  Component _buildStoryItem(BuildContext context, GameIntegration item) {
    return div(classes: 'story-item', [
      a(href: item.url, target: Target.blank, [
        div(classes: 'event_image_container', [
          img(
            alt: item.image,
            src: context.asset(item.image, width: 635),
            attributes: const {'height': '281', 'width': '377'},
          ),
        ]),
        div(classes: 'text', [
          h3([.text(item.title)]),
          p([.text(item.description)]),
        ]),
      ]),
    ]);
  }

  Component _buildFeaturedGamesSection(BuildContext context) {
    final featuredGames = context.decodeJsonList(
      'games.data.featured',
      FeaturedGame.fromJson,
    );

    return section(id: 'featured-games', classes: 'module carousel-section', [
      const div(classes: 'stacked-header container', [
        Component.element(
          tag: 'hgroup',
          children: [
            h4(classes: 'eyebrow', [.text('Flutter games')]),
            h2([.text('Case studies')]),
          ],
        ),
      ]),
      Carousel(
        ref(
          .fragment([
            for (final game in featuredGames)
              _buildFeaturedGameItem(context, game),
          ]),
        ),
      ),
    ]);
  }

  Component _buildFeaturedGameItem(BuildContext context, FeaturedGame item) {
    return div(classes: 'story-item', [
      a(href: item.url, target: Target.blank, [
        img(
          alt: item.image,
          src: context.asset(item.image, width: 635),
          width: 222,
          height: 222,
        ),
        div(classes: 'text', [
          h3([.text(item.title)]),
        ]),
      ]),
    ]);
  }
}

const List<YouTubeVideo> _gameVideos = [
  YouTubeVideo(
    id: 'oi6zk7cVHUw',
    title: 'Introducing the Flutter Casual Games Toolkit',
    description:
        'Learn why Flutter is a great choice for game developers '
        'and what is included in the Flutter Casual Games Toolkit.',
  ),
  YouTubeVideo(
    id: 'zGgeBNiRy-8',
    title: 'Quick start to building a game in Flutter',
    description:
        'Get up and running fast with the Flutter Casual Games Toolkit '
        'templates and ship your first game in minutes.',
  ),
  YouTubeVideo(
    id: 'ILTx1Wa33Z0',
    title: 'Building Doodle Dash with Flutter & Flame',
    description:
        'Kick off the Learning to Fly series and build the foundations '
        'of Doodle Dash, a 2D platformer powered by Flutter and Flame.',
  ),
  YouTubeVideo(
    id: 'qSrWikiptEE',
    title: 'Doodle Dash & Flame: Collision detection, menus, and more!',
    description:
        'Continue the Learning to Fly series by adding '
        'collision detection, in-game menus, and other gameplay polish.',
  ),
  YouTubeVideo(
    id: 'hz9t8ODkDmM',
    title: 'Adding enemies, power ups, and custom config to Doodle Dash',
    description:
        'Round out Doodle Dash with enemies, power ups, and '
        'custom configuration to make the game your own.',
  ),
  YouTubeVideo(
    id: 'EFBjCwQ1OgM',
    title: 'Building a Dash Game with Flame',
    description:
        'See how the Flame game engine works alongside Flutter to '
        'bring the Dash mascot into a complete 2D game.',
  ),
  YouTubeVideo(
    id: 'tEqVyJNOroI',
    title: 'Flame (Package of the Week)',
    description:
        'A quick tour of the Flame package: a community-built '
        '2D game engine that extends Flutter for game development.',
  ),
  YouTubeVideo(
    id: 'sz-DpxuGz_U',
    title: 'Observable Flutter: Slow-coding Pong',
    description:
        'Watch a live-coded build of Pong in Flutter, '
        'walking through the gameplay loop, rendering, and input handling.',
  ),
  YouTubeVideo(
    id: '0CCVB31feO0',
    title: 'Flutter, Dart, and Raspberry Pi',
    description:
        'Explore how Flutter and Dart can power experiences beyond '
        'the phone, including playful projects on a Raspberry Pi.',
  ),
];
