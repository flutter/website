// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/common/icon.dart';
import '../components/pages/flutter_create_countdown.dart';
import '../components/pages/flutter_create_signup.dart';
import '../utils/asset_utils.dart';

/// The landing page for Flutter Create,
/// Flutter's Q4 2026 flagship livestream event.
class FlutterCreatePage extends StatelessComponent {
  const FlutterCreatePage({super.key});

  @override
  Component build(BuildContext context) {
    return const main_([
      // Runs before the forms are painted to avoid
      // briefly showing sign-in to visitors who already signed up.
      script(content: flutterCreateSignupStateScript),
      _Hero(),
      _About(),
      _Topics(),
      _Signup(),
    ]);
  }
}

class _Hero extends StatelessComponent {
  const _Hero();

  @override
  Component build(BuildContext context) {
    return section(classes: 'fc-hero', [
      const div(classes: 'fc-hero-backdrop', [
        div(classes: 'fc-blob fc-blob-sky', []),
        div(classes: 'fc-blob fc-blob-pink', []),
        div(classes: 'fc-doodle-spiral', []),
      ]),
      div(classes: 'fc-container fc-hero-stage', [
        div(classes: 'fc-hero-copy', [
          const p(classes: 'fc-tape-badge fc-tape-yellow', [
            span(classes: 'fc-live-dot', []),
            .text('Ready. Set. · November 11, 2026 · Livestream'),
          ]),
          h1(classes: 'fc-hero-title', [
            img(
              src: context.asset('/images/create/flutter-create-logo.webp'),
              alt: 'Flutter Create',
              classes: 'fc-hero-brand-logo',
              width: 580,
              height: 200,
            ),
          ]),
          const p(classes: 'fc-hero-tagline', [
            .text('Crafted for every screen, everyday.'),
          ]),
          const p(classes: 'fc-hero-lede', [
            .text(
              'Join the Flutter team, partners, and community for a day '
              'celebrating the craft of building beautiful apps everywhere you go.',
            ),
          ]),
          const FlutterCreateSignup(compact: true),
        ]),
        div(classes: 'fc-hero-visual', [
          _HeroCard(
            heroCompUrl: context.asset('/images/create/hero-comp.webp'),
          ),
        ]),
      ]),
    ]);
  }
}

/// A tactile Polaroid-style studio card showcasing the Flutter Create artwork
/// and the live countdown badge.
class _HeroCard extends StatelessComponent {
  const _HeroCard({required this.heroCompUrl});

  final String heroCompUrl;

  @override
  Component build(BuildContext context) {
    return div(classes: 'fc-hero-card', [
      const div(classes: 'fc-tape fc-tape-top-center fc-tape-teal', []),
      div(classes: 'fc-card-inner', [
        img(
          src: heroCompUrl,
          alt: 'Flutter Create illustration with sketching hand and Dash',
          classes: 'fc-hero-card-img',
          width: 700,
          height: 450,
        ),
        const div(classes: 'fc-card-footer', [
          div(classes: 'fc-card-status', [
            span(classes: 'fc-live-dot', []),
            .text('Wednesday, Nov 11 · Online'),
          ]),
          FlutterCreateCountdown(),
          script(content: flutterCreateCountdownScript),
        ]),
      ]),
    ]);
  }
}

class _About extends StatelessComponent {
  const _About();

  static const List<({String icon, String label, String tapeColor})>
  _highlights = [
    (
      icon: 'live_tv',
      label: 'Single-day global livestream',
      tapeColor: 'yellow',
    ),
    (
      icon: 'rocket_launch',
      label: 'Launches alongside the next release',
      tapeColor: 'coral',
    ),
    (
      icon: 'diversity_3',
      label: 'Co-hosted with partners and community',
      tapeColor: 'teal',
    ),
  ];

  @override
  Component build(BuildContext context) {
    return section(classes: 'fc-section fc-about', [
      div(classes: 'fc-container fc-about-grid', [
        const div(classes: 'fc-about-copy', [
          p(classes: 'fc-kicker', [.text('About the event')]),
          h2([.text('The newest Flutter and Dart features')]),
          p(classes: 'fc-body', [
            .text(
              'Flutter Create is a virtual event streamed live alongside '
              'the latest Flutter release. Each session pairs practical, '
              'how-to technical content with real stories from teams '
              'shipping Flutter apps across platforms and industries.',
            ),
          ]),
        ]),
        div(classes: 'fc-about-side', [
          ul(classes: 'fc-chips', [
            for (final highlight in _highlights)
              li(classes: 'fc-chip fc-tape-${highlight.tapeColor}', [
                span(classes: 'fc-chip-icon', [Icon(symbol: highlight.icon)]),
                span(classes: 'fc-chip-text', [.text(highlight.label)]),
              ]),
          ]),
        ]),
      ]),
    ]);
  }
}

/// Topics rendered as sticky notes inspired by Slide 7 ("Pop Ups")
/// of the Flutter Create Brand Playbook.
class _Topics extends StatelessComponent {
  const _Topics();

  static const List<
    ({
      String tint,
      String tapeColor,
      String title,
      String description,
      String mascotImage,
      String mascotAlt,
      String rotationClass,
    })
  >
  _topics = [
    (
      tint: 'yellow',
      tapeColor: 'teal',
      title: "What's new in Flutter",
      description:
          'A tour of the latest Flutter and Dart release, '
          'launching the same day.',
      mascotImage: '/images/create/dashes/collage.webp',
      mascotAlt: 'Collage Dash',
      rotationClass: 'rot-neg-1',
    ),
    (
      tint: 'blue',
      tapeColor: 'yellow',
      title: 'AI on every screen',
      description:
          'Generative UI, on-device models, and AI developer tools '
          'that keep your agents reliable.',
      mascotImage: '/images/create/dashes/wire.webp',
      mascotAlt: 'Wire Dash',
      rotationClass: 'rot-pos-1',
    ),
    (
      tint: 'purple',
      tapeColor: 'mint',
      title: 'Desktop and embedded',
      description:
          'Multi-window desktop apps and '
          'Flutter on new kinds of devices.',
      mascotImage: '/images/create/dashes/woody.webp',
      mascotAlt: 'Woody Dash',
      rotationClass: 'rot-neg-2',
    ),
    (
      tint: 'pink',
      tapeColor: 'purple',
      title: 'Native interop',
      description:
          'Call platform APIs directly from Dart with generated '
          'bindings for Swift, Objective-C, Kotlin, and Java.',
      mascotImage: '/images/create/dashes/sewn.webp',
      mascotAlt: 'Sewn Dash',
      rotationClass: 'rot-pos-2',
    ),
    (
      tint: 'mint',
      tapeColor: 'coral',
      title: 'Design systems',
      description:
          'New ways to build and maintain '
          'custom design libraries with Flutter.',
      mascotImage: '/images/create/dashes/knitted.webp',
      mascotAlt: 'Knitted Dash',
      rotationClass: 'rot-neg-1',
    ),
    (
      tint: 'butter',
      tapeColor: 'blue',
      title: 'Dart and WebAssembly',
      description:
          'What Dart and Wasm unlock for fast, '
          'portable apps on the web and beyond.',
      mascotImage: '/images/create/dashes/patchwork.webp',
      mascotAlt: 'Patchwork Dash',
      rotationClass: 'rot-pos-1',
    ),
  ];

  @override
  Component build(BuildContext context) {
    return section(classes: 'fc-section fc-topics', [
      div(classes: 'fc-container', [
        const div(classes: 'fc-section-header', [
          p(classes: 'fc-kicker', [.text('What to expect')]),
          h2([.text('Sessions for every kind of builder')]),
          p(classes: 'fc-sub', [
            .text(
              'Deep dives from the Flutter team, paired with '
              'stories from the teams who ship with it.',
            ),
          ]),
        ]),
        div(classes: 'fc-topic-grid', [
          for (final topic in _topics)
            div(
              classes:
                  'fc-sticky-note tint-${topic.tint} ${topic.rotationClass}',
              [
                div(classes: 'fc-tape fc-tape-${topic.tapeColor}', const []),
                div(classes: 'fc-sticky-content', [
                  div(classes: 'fc-topic-header', [
                    img(
                      src: context.asset(topic.mascotImage),
                      alt: topic.mascotAlt,
                      classes: 'fc-topic-mascot-img',
                      loading: MediaLoading.lazy,
                      width: 56,
                      height: 56,
                    ),
                    h3([.text(topic.title)]),
                  ]),
                  p([.text(topic.description)]),
                ]),
              ],
            ),
        ]),
      ]),
    ]);
  }
}

class _Signup extends StatelessComponent {
  const _Signup();

  @override
  Component build(BuildContext context) {
    return section(id: 'signup', classes: 'fc-section fc-signup', [
      div(classes: 'fc-container', [
        div(classes: 'fc-signup-board', [
          const div(classes: 'fc-tape fc-tape-top-left fc-tape-yellow', []),
          const div(classes: 'fc-tape fc-tape-top-right fc-tape-teal', []),
          div(classes: 'fc-signup-grid', [
            div(classes: 'fc-signup-copy', [
              const p(classes: 'fc-kicker', [.text('Save the date')]),
              const h2([.text('Be part of Flutter Create')]),
              const p(classes: 'fc-body', [
                .text(
                  'Reserve your front-row seat for the livestream on '
                  'Wednesday, November 11, 2026. Free, online, and open to all builders.',
                ),
              ]),
              div(classes: 'fc-signup-pass-frame', [
                img(
                  src: context.asset('/images/create/attending-card.webp'),
                  alt: 'Flutter Create official attendee pass',
                  classes: 'fc-signup-pass-img',
                  loading: MediaLoading.lazy,
                  width: 540,
                  height: 304,
                ),
              ]),
            ]),
            const div(classes: 'fc-signup-panel', [FlutterCreateSignup()]),
          ]),
        ]),
      ]),
    ]);
  }
}
