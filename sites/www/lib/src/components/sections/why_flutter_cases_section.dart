// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../common/icon.dart';

/// Describes a single success-case card.
typedef _Case = ({
  String company,
  String quote,
  String? storyUrl,
  String theme,
  bool isDark,
});

/// The "What switching actually returned" success-case carousel.
///
/// On wide viewports the track translates one card at a time; below the medium
/// breakpoint it becomes a native snap-scroll strip driven by the same arrows.
@client
class WhyFlutterCasesSection extends StatefulComponent {
  const WhyFlutterCasesSection({required this.media, super.key});

  /// Resolved URLs of the device imagery, keyed by card theme.
  ///
  /// Resolved by the page because the asset helpers are server-only, and this
  /// component hydrates on the client.
  final Map<String, String> media;

  @override
  State<WhyFlutterCasesSection> createState() => _WhyFlutterCasesSectionState();
}

class _WhyFlutterCasesSectionState extends State<WhyFlutterCasesSection> {
  /// Width of one card plus the gap between cards.
  static const _cardStride = 1220;

  static const List<_Case> _cases = [
    (
      company: 'Headspace',
      quote: '30-40% increase in developer productivity after adopting Flutter',
      storyUrl: '/showcase/headspace',
      theme: 'headspace',
      isDark: false,
    ),
    (
      company: 'Universal',
      quote:
          '45% reduction in codebase size and near-zero crashes with Flutter',
      storyUrl: '/showcase/universal-studios',
      theme: 'universal',
      isDark: false,
    ),
    (
      company: 'LG WebOS',
      quote: '2× faster launch times with lower runtime memory usage.',
      storyUrl: '/showcase/lg-electronics',
      theme: 'lg',
      isDark: false,
    ),
    (
      company: 'Google Earth',
      quote:
          '3x faster. Flutter has vastly increased our ability to deliver '
          'multi-platform',
      storyUrl: null,
      theme: 'earth',
      isDark: true,
    ),
  ];

  int _index = 0;

  void _step(int delta) {
    final strip = web.document.querySelector('#why-flutter-case-strip');
    if (strip != null && web.window.innerWidth < 768) {
      strip.scrollBy(
        web.ScrollToOptions(
          left: (delta * (web.window.innerWidth - 32)).toDouble(),
          behavior: 'smooth',
        ),
      );
      return;
    }

    setState(() {
      _index = (_index + delta).clamp(0, _cases.length - 1);
    });
  }

  @override
  Component build(BuildContext context) {
    return section(id: 'success-cases', classes: 'module why-flutter-cases', [
      const div(classes: 'stacked-header container', [
        p(classes: 'why-flutter-kicker', [.text('Success cases')]),
        h2([.text('What switching actually returned')]),
        p(classes: 'why-flutter-sub', [
          .text('The measurable ROI teams achieved after making the switch.'),
        ]),
      ]),
      div(classes: 'why-flutter-case-viewport', [
        div(
          classes: 'why-flutter-case-track',
          styles: Styles(
            raw: {'transform': 'translateX(${-_index * _cardStride}px)'},
          ),
          [
            for (final study in _cases)
              _CaseCard(study: study, media: component.media),
          ],
        ),
      ]),
      div(id: 'why-flutter-case-strip', classes: 'why-flutter-case-strip', [
        for (final study in _cases)
          _CaseCard(study: study, media: component.media, isCompact: true),
      ]),
      div(classes: 'why-flutter-case-arrows', [
        _ArrowButton(
          symbol: 'arrow_back',
          label: 'Previous success case',
          onPressed: () => _step(-1),
        ),
        _ArrowButton(
          symbol: 'arrow_forward',
          label: 'Next success case',
          onPressed: () => _step(1),
        ),
      ]),
    ]);
  }
}

/// A single success-case card.
///
/// The [isCompact] variant is the vertical card used in the small-viewport
/// snap-scroll strip.
class _CaseCard extends StatelessComponent {
  const _CaseCard({
    required this.study,
    required this.media,
    this.isCompact = false,
  });

  final _Case study;
  final Map<String, String> media;
  final bool isCompact;

  @override
  Component build(BuildContext context) {
    return div(
      classes: [
        if (isCompact) 'why-flutter-case-card-compact' else 'why-flutter-case-card',
        'theme-${study.theme}',
        if (study.isDark) 'is-dark',
      ].join(' '),
      [
        div(classes: 'why-flutter-case-copy', [
          p(classes: 'why-flutter-case-company', [.text(study.company)]),
          p(classes: 'why-flutter-case-quote', [.text(study.quote)]),
          if (study.storyUrl case final url?)
            a(href: url, classes: 'why-flutter-case-link', const [
              .text('Read story'),
              Icon.linkArrow(),
            ]),
        ]),
        div(classes: 'why-flutter-case-media', [
          _CaseMedia(study: study, media: media),
        ]),
      ],
    );
  }
}

/// The device imagery that overflows the top edge of each success-case card.
class _CaseMedia extends StatelessComponent {
  const _CaseMedia({required this.study, required this.media});

  final _Case study;
  final Map<String, String> media;

  @override
  Component build(BuildContext context) {
    return switch (study.theme) {
      'earth' => img(
        src: media['earth']!,
        alt: 'Google Earth running on desktop',
      ),
      'lg' => img(src: media['lg']!, alt: 'LG webOS television'),
      final theme => .fragment([
        img(
          src: media[theme]!,
          alt: '${study.company} app',
          classes: 'why-flutter-case-screenshot',
        ),
        img(
          src: media['phoneFrame']!,
          alt: '',
          classes: 'why-flutter-case-frame',
        ),
      ]),
    };
  }
}

/// A circular carousel arrow button.
class _ArrowButton extends StatelessComponent {
  const _ArrowButton({
    required this.symbol,
    required this.label,
    required this.onPressed,
  });

  final String symbol;
  final String label;
  final void Function() onPressed;

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'why-flutter-arrow',
      attributes: {'aria-label': label},
      onClick: onPressed,
      [Icon(symbol: symbol)],
    );
  }
}
