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
      const div(classes: 'fc-hero-glow', []),
      div(classes: 'fc-hero-stage', [
        const div(classes: 'fc-hero-copy', [
          p(classes: 'fc-pill', [
            span(classes: 'fc-live-dot', []),
            .text('Livestream · November 11, 2026'),
          ]),
          h1([
            .text('Flutter '),
            span(classes: 'fc-gradient-text', [.text('Everywhere')]),
            .text(', Everyday'),
          ]),
          p(classes: 'fc-hero-lede', [
            .text(
              'Join the Flutter team, partners, and community for a day '
              'celebrating how Flutter shows up in everyday life, '
              'everywhere you go.',
            ),
          ]),
          FlutterCreateSignup(compact: true),
        ]),
        div(classes: 'fc-hero-visual', [
          _StreamCard(
            logoUrl: context.asset('/images/flutter-logo-mark-320x.png'),
          ),
        ]),
      ]),
    ]);
  }
}

/// A stylized livestream player with a `flutter create` terminal prompt.
class _StreamCard extends StatelessComponent {
  const _StreamCard({required this.logoUrl});

  final String logoUrl;

  @override
  Component build(BuildContext context) {
    return div(classes: 'fc-stream', [
      const div(classes: 'fc-stream-bar', [
        span(classes: 'fc-stream-badge', [
          span(classes: 'fc-live-dot', []),
          .text('Live soon'),
        ]),
        span(classes: 'fc-stream-dots', [span([]), span([]), span([])]),
      ]),
      div(classes: 'fc-stream-screen', [
        img(src: logoUrl, alt: '', width: 72, height: 72),
        const p(classes: 'fc-terminal', [
          span(classes: 'fc-terminal-prompt', [.text(r'$ ')]),
          .text('flutter create '),
          span(classes: 'fc-terminal-arg', [.text('everywhere')]),
          span(classes: 'fc-terminal-cursor', []),
        ]),
      ]),
      const FlutterCreateCountdown(),
    ]);
  }
}

class _About extends StatelessComponent {
  const _About();

  static const List<({String icon, String label})> _highlights = [
    (icon: 'live_tv', label: 'Single-day livestream'),
    (icon: 'rocket_launch', label: 'Launches with the latest release'),
    (icon: 'diversity_3', label: 'Co-hosted with partners and community'),
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
              li(classes: 'fc-chip', [
                span(classes: 'fc-chip-icon', [Icon(symbol: highlight.icon)]),
                span([.text(highlight.label)]),
              ]),
          ]),
        ]),
      ]),
    ]);
  }
}

class _Topics extends StatelessComponent {
  const _Topics();

  static const List<
    ({String icon, String tint, String title, String description})
  >
  _topics = [
    (
      icon: 'new_releases',
      tint: 'blue',
      title: "What's new in Flutter",
      description:
          'A tour of the latest Flutter and Dart release, '
          'launching the same day.',
    ),
    (
      icon: 'auto_awesome',
      tint: 'violet',
      title: 'AI on every screen',
      description:
          'Generative UI, on-device models, and AI developer tools '
          'that keep your agents reliable.',
    ),
    (
      icon: 'devices',
      tint: 'green',
      title: 'Desktop and embedded',
      description:
          'Multi-window desktop apps and '
          'Flutter on new kinds of devices.',
    ),
    (
      icon: 'integration_instructions',
      tint: 'yellow',
      title: 'Native interop',
      description:
          'Call platform APIs directly from Dart with generated '
          'bindings for Swift, Objective-C, Kotlin, and Java.',
    ),
    (
      icon: 'palette',
      tint: 'pink',
      title: 'Design systems',
      description:
          'New ways to build and maintain '
          'custom design libraries with Flutter.',
    ),
    (
      icon: 'bolt',
      tint: 'blue',
      title: 'Dart and WebAssembly',
      description:
          'What Dart and Wasm unlock for fast, '
          'portable apps on the web and beyond.',
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
            div(classes: 'fc-topic tint-${topic.tint}', [
              div(classes: 'fc-topic-icon', [Icon(symbol: topic.icon)]),
              h3([.text(topic.title)]),
              p([.text(topic.description)]),
            ]),
        ]),
      ]),
    ]);
  }
}

class _Signup extends StatelessComponent {
  const _Signup();

  @override
  Component build(BuildContext context) {
    return const section(id: 'signup', classes: 'fc-section fc-signup', [
      div(classes: 'fc-container', [
        div(classes: 'fc-signup-card', [
          div(classes: 'fc-signup-copy', [
            h2([.text('Get notified when we go live')]),
          ]),
          div(classes: 'fc-signup-panel', [FlutterCreateSignup()]),
        ]),
      ]),
    ]);
  }
}
