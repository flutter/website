// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/analytics.dart';

import '../../utils/visibility_observer.dart';
import '../common/icon.dart';

/// The "Why Flutter" hero, combined with the "Faster time-to-market" productivity
/// chart that shares its gradient background.
///
/// The chart's bar and its 3X counter animate once the chart scrolls into
/// view, so the section hydrates on the client. Asset URLs are resolved by the
/// page and passed in, because the asset helpers are server-only.
@client
class WhyFlutterHeroSection extends StatefulComponent {
  const WhyFlutterHeroSection({
    required this.typingSprite,
    required this.screens,
    required this.whitepaperUrl,
    required this.flutterLogo,
    super.key,
  });

  /// Resolved URL of the typing Dash sprite sheet.
  final String typingSprite;

  /// Resolved URLs of the twelve app screenshots, in column-major order.
  final List<String> screens;

  /// Resolved URL of the downloadable business whitepaper.
  final String whitepaperUrl;

  /// Resolved URL of the Flutter logo mark for the chart bar.
  final String flutterLogo;

  @override
  State<WhyFlutterHeroSection> createState() => _WhyFlutterHeroSectionState();
}

class _WhyFlutterHeroSectionState extends State<WhyFlutterHeroSection> {
  static const _productivityMultiple = 3;

  bool _isBarGrown = false;
  int _multiple = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    observeOnce('#why-flutter-chart', threshold: 0.35, () {
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
    return section(id: 'why-flutter-hero', classes: 'why-flutter-hero', [
      const div(classes: 'why-flutter-hero-glow', []),
      div(classes: 'why-flutter-hero-stage', [
        _HeroCopy(whitepaperUrl: component.whitepaperUrl),
        div(classes: 'why-flutter-hero-visual', [
          _ScreenCarousel(screens: component.screens),
          div(
            classes: 'why-flutter-hero-dash',
            styles: Styles(
              raw: {'--why-flutter-sprite': 'url(${component.typingSprite})'},
            ),
            const [],
          ),
        ]),
        _ProductivityChart(
          isBarGrown: _isBarGrown,
          multiple: _multiple,
          flutterLogo: component.flutterLogo,
        ),
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
    return div(classes: 'why-flutter-hero-copy', [
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
        classes: 'btn why-flutter-hero-btn',
        attributes: const {'download': ''},
        events: events(
          onClick: () {
            analytics.sendEvent('whitepaper_download', {
              'file': 'flutter-whitepaper-2026.pdf',
            });
          },
        ),
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
    return div(classes: 'why-flutter-screens', [
      div(classes: 'why-flutter-screens-track', [
        for (var column = 0; column < _columnCount; column++)
          div(classes: 'why-flutter-screen-column column-${column + 1}', [
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
  const _ProductivityChart({
    required this.isBarGrown,
    required this.multiple,
    required this.flutterLogo,
  });

  final bool isBarGrown;
  final int multiple;
  final String flutterLogo;

  @override
  Component build(BuildContext context) {
    return div(classes: 'why-flutter-productivity', [
      const h2([.text('Faster time-to-market')]),
      const p(classes: 'why-flutter-sub', [
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
      div(id: 'why-flutter-chart', classes: 'why-flutter-chart', [
        div(classes: 'why-flutter-chart-plot', [
          div(classes: 'why-flutter-chart-grid', [
            for (var line = 0; line < 8; line++) const div([]),
          ]),
          const div(classes: 'why-flutter-bar why-flutter-bar-baseline', []),
          div(
            classes: [
              'why-flutter-bar',
              'why-flutter-bar-flutter',
              if (isBarGrown) 'is-grown',
            ].join(' '),
            [
              img(
                src: flutterLogo,
                alt: 'Flutter',
                classes: 'why-flutter-bar-logo',
              ),
            ],
          ),
          const div(classes: 'why-flutter-chart-axis', []),
          span(classes: 'why-flutter-chart-multiple', [.text('${multiple}X')]),
          const p(classes: 'why-flutter-bar-label label-baseline', [
            .text('Traditional baseline'),
          ]),
          const p(classes: 'why-flutter-bar-label label-flutter', [
            .text('Teams with Flutter'),
          ]),
          const p(classes: 'why-flutter-chart-axis-label', [
            .text('Productivity'),
          ]),
          const div(classes: 'why-flutter-chart-badge', [
            Icon(symbol: 'arrow_upward'),
          ]),
        ]),
      ]),
    ]);
  }
}
