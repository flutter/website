// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../utils/visibility_observer.dart';
import '../common/icon.dart';

/// The "Why us" hero, combined with the "Faster time-to-market" productivity
/// chart that shares its gradient background.
///
/// The chart's bar and its 3X counter animate once the chart scrolls into
/// view, so the section hydrates on the client. Asset URLs are resolved by the
/// page and passed in, because the asset helpers are server-only.
@client
class WhyUsHeroSection extends StatefulComponent {
  const WhyUsHeroSection({
    required this.typingSprite,
    required this.screens,
    required this.whitepaperUrl,
    super.key,
  });

  /// Resolved URL of the typing Dash sprite sheet.
  final String typingSprite;

  /// Resolved URLs of the twelve app screenshots, in column-major order.
  final List<String> screens;

  /// Resolved URL of the downloadable business whitepaper.
  final String whitepaperUrl;

  @override
  State<WhyUsHeroSection> createState() => _WhyUsHeroSectionState();
}

class _WhyUsHeroSectionState extends State<WhyUsHeroSection> {
  static const _productivityMultiple = 3;

  bool _isBarGrown = false;
  int _multiple = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    observeOnce('#why-us-chart', threshold: 0.35, () {
      setState(() => _isBarGrown = true);

      animateValue(
        duration: const Duration(milliseconds: 1600),
        onTick: (fraction) {
          setState(() {
            _multiple = (_productivityMultiple * fraction).round();
          });
        },
      );
    });
  }

  @override
  Component build(BuildContext context) {
    return section(id: 'why-us-hero', classes: 'why-us-hero', [
      const div(classes: 'why-us-hero-glow', []),
      div(classes: 'why-us-hero-stage', [
        _HeroCopy(whitepaperUrl: component.whitepaperUrl),
        _ScreenCarousel(screens: component.screens),
        div(
          classes: 'why-us-hero-dash',
          styles: Styles(
            raw: {'--why-us-sprite': 'url(${component.typingSprite})'},
          ),
          const [],
        ),
        _ProductivityChart(isBarGrown: _isBarGrown, multiple: _multiple),
      ]),
    ]);
  }
}

/// The hero headline, supporting copy, and whitepaper download button.
class _HeroCopy extends StatelessComponent {
  const _HeroCopy({required this.whitepaperUrl});

  final String whitepaperUrl;

  @override
  Component build(BuildContext context) {
    return div(classes: 'why-us-hero-copy', [
      const h1([.text('The business value of Flutter')]),
      const p([
        .text(
          'Discover how unifying your codebase empowers you to ship to iOS, '
          'Android, Web, and Desktop faster and more efficiently than ever '
          'before.',
        ),
      ]),
      a(
        href: whitepaperUrl,
        classes: 'btn why-us-hero-btn',
        attributes: const {'download': ''},
        const [Icon(symbol: 'download'), .text('Download 2026 Whitepaper')],
      ),
    ]);
  }
}

/// Three columns of app screenshots that loop vertically, forever.
///
/// Each column repeats its screens twice so the CSS translation restarts
/// seamlessly.
class _ScreenCarousel extends StatelessComponent {
  const _ScreenCarousel({required this.screens});

  static const _columnCount = 3;

  final List<String> screens;

  @override
  Component build(BuildContext context) {
    return div(classes: 'why-us-screens', [
      div(classes: 'why-us-screens-track', [
        for (var column = 0; column < _columnCount; column++)
          div(classes: 'why-us-screen-column column-${column + 1}', [
            for (var pass = 0; pass < 2; pass++)
              for (
                var index = column;
                index < screens.length;
                index += _columnCount
              )
                img(
                  src: screens[index],
                  alt: '',
                  attributes: const {'aria-hidden': 'true'},
                ),
          ]),
      ]),
    ]);
  }
}

/// The "Faster time-to-market" block and its productivity bar chart.
class _ProductivityChart extends StatelessComponent {
  const _ProductivityChart({required this.isBarGrown, required this.multiple});

  final bool isBarGrown;
  final int multiple;

  @override
  Component build(BuildContext context) {
    return div(classes: 'why-us-productivity', [
      const h2([.text('Faster time-to-market')]),
      const p(classes: 'why-us-sub', [
        .text(
          'Consolidation is the answer. Build once and launch seamlessly '
          'across ',
        ),
        span(classes: 'accent', [.text('iOS')]),
        .text(', '),
        span(classes: 'accent', [.text('Android')]),
        .text(', '),
        span(classes: 'accent', [.text('web')]),
        .text(', and '),
        span(classes: 'accent', [.text('desktop')]),
        .text('.'),
      ]),
      const p(classes: 'why-us-chart-label', [.text('Productivity')]),
      div(id: 'why-us-chart', classes: 'why-us-chart', [
        div(classes: 'why-us-chart-plot', [
          div(classes: 'why-us-chart-grid', [
            for (var line = 0; line < 8; line++) const div([]),
          ]),
          const div(classes: 'why-us-bar why-us-bar-baseline', []),
          div(
            classes: [
              'why-us-bar',
              'why-us-bar-flutter',
              if (isBarGrown) 'is-grown',
            ].join(' '),
            const [],
          ),
          const div(classes: 'why-us-chart-axis', []),
          span(classes: 'why-us-chart-multiple', [.text('${multiple}X')]),
          const p(classes: 'why-us-bar-label label-baseline', [
            .text('Traditional baseline'),
          ]),
          const p(classes: 'why-us-bar-label label-flutter', [
            .text('Teams with Flutter'),
          ]),
          const p(classes: 'why-us-chart-axis-label', [.text('Productivity')]),
          const div(classes: 'why-us-chart-badge', [
            Icon(symbol: 'arrow_upward'),
          ]),
        ]),
      ]),
    ]);
  }
}
