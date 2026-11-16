// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/common/icon.dart';
import '../components/pages/flutter_create_countdown.dart';
import '../components/pages/flutter_create_signup.dart';
import '../utils/asset_utils.dart';

const String _livestreamUrl =
    'https://www.youtube.com/live/Qd-SY_16amU?si=kkLPeuDNGu4UUsHw';
const String _livestreamEmbedUrl =
    'https://www.youtube.com/embed/Qd-SY_16amU?si=kkLPeuDNGu4UUsHw';

/// The landing page for Flutter Create,
/// Flutter's Q4 2026 flagship livestream event.
class FlutterCreatePage extends StatelessComponent {
  const FlutterCreatePage({super.key});

  @override
  Component build(BuildContext context) {
    final matUrl = context.asset('/images/create/goodies/cutting-mat.webp');
    final spatterUrl = context.asset('/images/create/goodies/ink-spatter.webp');
    final underlineUrl = context.asset(
      '/images/create/goodies/scribble-underline.webp',
    );
    final circleUrl = context.asset(
      '/images/create/goodies/scribble-circle.webp',
    );

    return main_(
      classes: 'fc-canvas',
      styles: Styles(
        raw: {
          '--fc-cutting-mat': "url('$matUrl')",
          '--fc-ink-spatter': "url('$spatterUrl')",
          '--fc-underline-img': "url('$underlineUrl')",
          '--fc-circle-img': "url('$circleUrl')",
        },
      ),
      const [
        // Runs before the forms are painted to avoid
        // briefly showing sign-in to visitors who already signed up.
        script(content: flutterCreateSignupStateScript),
        _Hero(),
        _About(),
        _Topics(),
        _Signup(),
      ],
    );
  }
}

/// Decorative studio/brainstorm prop (tape, pin, arrow, scribble)
/// hidden from assistive technologies.
class _Prop extends StatelessComponent {
  const _Prop(
    this.assetPath, {
    required this.classes,
    this.width,
    this.height,
    this.eager = false,
  });

  final String assetPath;
  final String classes;
  final int? width;
  final int? height;
  final bool eager;

  @override
  Component build(BuildContext context) {
    return img(
      src: context.asset(assetPath),
      alt: '',
      classes: 'fc-prop $classes',
      loading: eager ? null : MediaLoading.lazy,
      width: width,
      height: height,
      attributes: const {'aria-hidden': 'true'},
    );
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
      ]),
      div(classes: 'fc-container fc-hero-stage', [
        div(classes: 'fc-hero-copy', [
          const div(classes: 'fc-hero-badge-wrap', [
            p(classes: 'fc-tape-badge fc-tape-yellow', [
              span(classes: 'fc-live-dot', []),
              span([
                .text('Ready. Set.'),
                span(
                  classes: 'fc-tape-divider',
                  attributes: {'aria-hidden': 'true'},
                  [],
                ),
                .text('November 11, 2026 · 10AM to 12PM PST'),
              ]),
            ]),
            _Prop(
              '/images/create/goodies/scribble-burst.webp',
              classes: 'fc-hero-burst',
              width: 56,
              height: 54,
              eager: true,
            ),
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
            .text('Crafted for '),
            span(classes: 'fc-scribble-underline', [
              .text('every screen, everyday.'),
            ]),
          ]),
          const p(classes: 'fc-hero-lede', [
            .text(
              'Join the Flutter team, partners, and community for a day '
              'celebrating the craft of building apps people use everywhere.',
            ),
          ]),
          const div(classes: 'fc-hero-cta-wrap', [
            FlutterCreateSignup(compact: true),
            _Prop(
              '/images/create/goodies/arrow-loop.webp',
              classes: 'fc-hero-loop-arrow',
              width: 120,
              height: 67,
              eager: true,
            ),
          ]),
        ]),
        const div(classes: 'fc-hero-visual', [
          _HeroCard(),
        ]),
      ]),
    ]);
  }
}

/// A tactile Polaroid-style studio card showcasing the Flutter Create
/// livestream player, real masking tape strips, pencil shavings, a direct link
/// to the YouTube stream, and the live countdown badge.
class _HeroCard extends StatelessComponent {
  const _HeroCard();

  @override
  Component build(BuildContext context) {
    return const div(classes: 'fc-hero-card', [
      _Prop(
        '/images/create/goodies/tape-yellow-masking.webp',
        classes: 'fc-real-tape fc-hero-tape-top',
        width: 132,
        height: 52,
        eager: true,
      ),
      _Prop(
        '/images/create/goodies/tape-pink-masking.webp',
        classes: 'fc-real-tape fc-hero-tape-corner',
        width: 112,
        height: 48,
        eager: true,
      ),
      div(classes: 'fc-card-inner', [
        div(classes: 'fc-video-frame', [
          iframe(
            src: _livestreamEmbedUrl,
            classes: 'fc-hero-video',
            attributes: {
              'title': 'Flutter Create livestream',
              'allowfullscreen': '',
              'allow':
                  'accelerometer; autoplay; clipboard-write; encrypted-media; '
                  'gyroscope; picture-in-picture; web-share',
              'referrerpolicy': 'strict-origin-when-cross-origin',
            },
            [],
          ),
        ]),
        div(classes: 'fc-card-footer', [
          a(
            href: _livestreamUrl,
            target: Target.blank,
            attributes: {'rel': 'noopener'},
            classes: 'fc-stream-link',
            [
              span(classes: 'fc-live-dot', []),
              span([.text('Flutter Create livestream')]),
              Icon(symbol: 'open_in_new', size: .xs),
            ],
          ),
          div(classes: 'fc-countdown-circled', [
            FlutterCreateCountdown(),
            script(content: flutterCreateCountdownScript),
          ]),
        ]),
      ]),
      _Prop(
        '/images/create/goodies/pencil-shavings.webp',
        classes: 'fc-hero-shavings',
        width: 84,
        height: 76,
      ),
    ]);
  }
}

class _About extends StatelessComponent {
  const _About();

  static const List<({String icon, String label, String tone})> _highlights = [
    (
      icon: 'live_tv',
      label: 'Single-day global livestream',
      tone: 'yellow',
    ),
    (
      icon: 'rocket_launch',
      label: 'Launches alongside the next release',
      tone: 'coral',
    ),
    (
      icon: 'diversity_3',
      label: 'Co-hosted with partners and community',
      tone: 'teal',
    ),
  ];

  @override
  Component build(BuildContext context) {
    return section(classes: 'fc-section fc-about', [
      div(classes: 'fc-container', [
        div(classes: 'fc-about-grid', [
          const _Prop(
            '/images/create/goodies/push-pin.webp',
            classes: 'fc-pin fc-about-pin',
            width: 58,
            height: 36,
          ),
          const _Prop(
            '/images/create/goodies/tape-mint.webp',
            classes: 'fc-real-tape fc-about-tape',
            width: 124,
            height: 38,
          ),
          const div(classes: 'fc-about-copy', [
            p(classes: 'fc-kicker', [.text('About the event')]),
            h2([.text('Flutter everywhere, everyday')]),
            p(classes: 'fc-body', [
              .text(
                'Flutter Create streams live alongside the Q4 Dart and Flutter '
                'release. Each session pairs practical, hands-on technical '
                'walkthroughs with stories from partners and teams shipping '
                'Flutter apps across platforms and industries.',
              ),
            ]),
          ]),
          div(classes: 'fc-about-side', [
            ul(classes: 'fc-chips', [
              for (final highlight in _highlights)
                li(classes: 'fc-chip fc-chip-${highlight.tone}', [
                  span(classes: 'fc-chip-icon', [Icon(symbol: highlight.icon)]),
                  span(classes: 'fc-chip-text', [.text(highlight.label)]),
                ]),
            ]),
          ]),
          const _Prop(
            '/images/create/goodies/crumpled-paper.webp',
            classes: 'fc-about-crumpled',
            width: 78,
            height: 91,
          ),
        ]),
      ]),
    ]);
  }
}

enum _FastenerKind { tape, pin, tack }

/// Brainstorm pinboard showcasing all 10 sessions and customer stories
/// from the Flutter Create 2026 lineup.
class _Topics extends StatelessComponent {
  const _Topics();

  static const List<
    ({
      String track,
      String title,
      String description,
      String tint,
      String rotationClass,
      _FastenerKind fastenerKind,
      String fastenerAsset,
      String? mascotAsset,
      String? mascotAlt,
    })
  >
  _sessions = [
    (
      track: 'Release keynote',
      title: "What's new in Dart and Flutter",
      description:
          'Catch up on the latest Dart and Flutter release launching the '
          'same day, with updates across the framework and language.',
      tint: 'yellow',
      rotationClass: 'rot-neg-1',
      fastenerKind: _FastenerKind.tape,
      fastenerAsset: '/images/create/goodies/tape-yellow-masking.webp',
      mascotAsset: '/images/create/dashes/collage.webp',
      mascotAlt: 'Collage Dash',
    ),
    (
      track: 'Desktop · with Canonical',
      title: 'Multi-window on desktop',
      description:
          'Create desktop apps that pop with multi-window support in '
          'Flutter, co-hosted with Canonical.',
      tint: 'blue',
      rotationClass: 'rot-pos-1',
      fastenerKind: _FastenerKind.pin,
      fastenerAsset: '/images/create/goodies/push-pin.webp',
      mascotAsset: null,
      mascotAlt: null,
    ),
    (
      track: 'Embedded · with LG',
      title: 'Build a webOS app with Flutter',
      description:
          'Bring Flutter and hot reload to the living room by building TV '
          'apps with the webOS SDK alongside LG.',
      tint: 'mint',
      rotationClass: 'rot-neg-2',
      fastenerKind: _FastenerKind.tape,
      fastenerAsset: '/images/create/goodies/tape-mint.webp',
      mascotAsset: '/images/create/dashes/woody.webp',
      mascotAlt: 'Woody Dash',
    ),
    (
      track: 'On-device AI · with Google DeepMind',
      title: 'On-device LLMs with Gemma',
      description:
          'Run fast, private on-device language models in your Flutter apps '
          'using LiteRT-LM and Gemma.',
      tint: 'purple',
      rotationClass: 'rot-pos-2',
      fastenerKind: _FastenerKind.tape,
      fastenerAsset: '/images/create/goodies/tape-sky.webp',
      mascotAsset: '/images/create/dashes/wire.webp',
      mascotAlt: 'Wire Dash',
    ),
    (
      track: 'Agentic UI · Partner spotlight',
      title: 'GenUI and A2UI',
      description:
          'Build adaptive, agentic user interfaces dynamically with '
          'server-driven Generative UI and A2UI alongside ecosystem partners.',
      tint: 'pink',
      rotationClass: 'rot-neg-1',
      fastenerKind: _FastenerKind.tack,
      fastenerAsset: '/images/create/goodies/brass-tack.webp',
      mascotAsset: null,
      mascotAlt: null,
    ),
    (
      track: 'Roundtable · with Antigravity',
      title: 'AI dev tools and agent evals',
      description:
          'Join a candid discussion on the future of Dart and Flutter '
          'developer experience, AI tooling, and evals for reliable agents.',
      tint: 'butter',
      rotationClass: 'rot-pos-1',
      fastenerKind: _FastenerKind.tape,
      fastenerAsset: '/images/create/goodies/tape-pink-masking.webp',
      mascotAsset: '/images/create/dashes/sewn.webp',
      mascotAlt: 'Sewn Dash',
    ),
    (
      track: 'Design systems · Widgetbook and Mix',
      title: 'Custom design libraries',
      description:
          'Explore the new way to architect decoupled, custom design systems '
          'and component libraries in Flutter.',
      tint: 'aqua',
      rotationClass: 'rot-pos-1',
      fastenerKind: _FastenerKind.tape,
      fastenerAsset: '/images/create/goodies/tape-coral.webp',
      mascotAsset: '/images/create/dashes/knitted.webp',
      mascotAlt: 'Knitted Dash',
    ),
    (
      track: 'Plugins · ffigen and jnigen',
      title: 'Direct native interop',
      description:
          'Build type-safe Flutter plugins from day one with direct bindings '
          'to Swift, Objective-C, Kotlin, and Java.',
      tint: 'peach',
      rotationClass: 'rot-neg-2',
      fastenerKind: _FastenerKind.pin,
      fastenerAsset: '/images/create/goodies/push-pin.webp',
      mascotAsset: null,
      mascotAlt: null,
    ),
    (
      track: 'Web · Community spotlight',
      title: 'The power of Dart and Wasm',
      description:
          'Discover what Dart and WebAssembly unlock for fast, portable apps '
          'on the web and beyond.',
      tint: 'lilac',
      rotationClass: 'rot-pos-2',
      fastenerKind: _FastenerKind.tape,
      fastenerAsset: '/images/create/goodies/tape-butter.webp',
      mascotAsset: null,
      mascotAlt: null,
    ),
  ];

  @override
  Component build(BuildContext context) {
    return section(classes: 'fc-section fc-topics', [
      div(classes: 'fc-container', [
        const div(classes: 'fc-section-header fc-brainstorm-header', [
          div(classes: 'fc-brainstorm-kicker-row', [
            _Prop(
              '/images/create/goodies/bulb.webp',
              classes: 'fc-brainstorm-bulb',
              width: 48,
              height: 74,
            ),
            p(classes: 'fc-kicker', [.text('On the brainstorm board')]),
          ]),
          h2([
            .text('Sessions for '),
            span(classes: 'fc-scribble-underline', [
              .text('every kind of builder'),
            ]),
          ]),
          p(classes: 'fc-sub', [
            .text(
              'Practical technical deep dives co-hosted with ecosystem '
              'partners and community contributors, paired with real-world '
              'customer stories.',
            ),
          ]),
          _Prop(
            '/images/create/goodies/arrow-arch.webp',
            classes: 'fc-topics-arrow',
            width: 88,
            height: 40,
          ),
        ]),
        div(classes: 'fc-topic-grid', [
          for (final session in _sessions)
            div(
              classes:
                  'fc-sticky-note tint-${session.tint} ${session.rotationClass}',
              [
                _Prop(
                  session.fastenerAsset,
                  classes: switch (session.fastenerKind) {
                    _FastenerKind.tape => 'fc-real-tape fc-note-tape',
                    _FastenerKind.pin => 'fc-pin fc-note-pin',
                    _FastenerKind.tack => 'fc-tack fc-note-tack',
                  },
                  width: switch (session.fastenerKind) {
                    _FastenerKind.tape => 108,
                    _FastenerKind.pin => 52,
                    _FastenerKind.tack => 42,
                  },
                  height: switch (session.fastenerKind) {
                    _FastenerKind.tape => 40,
                    _FastenerKind.pin => 32,
                    _FastenerKind.tack => 35,
                  },
                ),
                div(classes: 'fc-sticky-content', [
                  span(classes: 'fc-topic-track', [.text(session.track)]),
                  h3([.text(session.title)]),
                  p([.text(session.description)]),
                ]),
                if (session.mascotAsset case final mascotAsset?)
                  img(
                    src: context.asset(mascotAsset),
                    alt: session.mascotAlt ?? '',
                    classes: 'fc-note-mascot',
                    loading: MediaLoading.lazy,
                    width: 58,
                    height: 58,
                    attributes: const {'aria-hidden': 'true'},
                  ),
              ],
            ),
        ]),
        // 10th topic: Featured Customer Showcase & Everyday Stories note
        div(classes: 'fc-showcase-note', [
          const _Prop(
            '/images/create/goodies/paperclip.webp',
            classes: 'fc-paperclip fc-showcase-clip',
            width: 54,
            height: 54,
          ),
          const _Prop(
            '/images/create/goodies/tape-sky.webp',
            classes: 'fc-real-tape fc-showcase-tape',
            width: 118,
            height: 44,
          ),
          const div(classes: 'fc-showcase-body', [
            span(classes: 'fc-showcase-pill', [
              .text('Customer spotlight'),
            ]),
            h3([
              .text('Showcase: Eloquent and Flutter in everyday life'),
            ]),
            p([
              .text(
                "Go behind the scenes with Google's Eloquent team and look "
                'back at a year of customer stories showing how teams around '
                'the world build everyday apps with Flutter.',
              ),
            ]),
          ]),
          div(classes: 'fc-showcase-mascot-wrap', [
            img(
              src: context.asset('/images/create/dashes/patchwork.webp'),
              alt: 'Patchwork Dash',
              classes: 'fc-showcase-mascot',
              loading: MediaLoading.lazy,
              width: 96,
              height: 96,
            ),
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
    return section(id: 'signup', classes: 'fc-section fc-signup', [
      div(classes: 'fc-container', [
        div(classes: 'fc-signup-board', [
          const _Prop(
            '/images/create/goodies/tape-yellow-masking.webp',
            classes: 'fc-real-tape fc-signup-tape-left',
            width: 128,
            height: 50,
          ),
          const _Prop(
            '/images/create/goodies/tape-coral.webp',
            classes: 'fc-real-tape fc-signup-tape-right',
            width: 122,
            height: 58,
          ),
          div(classes: 'fc-signup-grid', [
            div(classes: 'fc-signup-copy', [
              const p(classes: 'fc-kicker', [.text('Save the date')]),
              const h2([.text('Be part of Flutter Create')]),
              const p(classes: 'fc-body', [
                .text(
                  'Reserve your spot for the livestream on Wednesday, '
                  'November 11, 2026, from 10AM to 12PM PST. Free, online, '
                  'and open to every builder.',
                ),
              ]),
              div(classes: 'fc-signup-pass-wrap', [
                const _Prop(
                  '/images/create/goodies/paperclip.webp',
                  classes: 'fc-paperclip fc-pass-clip',
                  width: 48,
                  height: 48,
                ),
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
                const _Prop(
                  '/images/create/goodies/arrow-curve-down.webp',
                  classes: 'fc-signup-arrow',
                  width: 72,
                  height: 82,
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
