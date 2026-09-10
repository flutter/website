// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../common/icon.dart';

/// Describes a single "Every pixel, on brand" feature card.
typedef _Feature = ({String symbol, String tint, String title, String body});

/// The "Every pixel, on brand" section.
///
/// A 2x2 grid on wide viewports that becomes a horizontal snap-scroll carousel
/// on small ones. Supports mouse click-and-drag scrolling on the mobile carousel.
@client
class WhyFlutterFeaturesSection extends StatefulComponent {
  const WhyFlutterFeaturesSection({super.key});

  static const List<_Feature> _features = [
    (
      symbol: 'design_services',
      tint: 'pixel',
      title: 'Pixel-Perfect Design',
      body:
          'Flutter renders every pixel itself, giving you complete creative '
          'freedom without being limited by native UI components.',
    ),
    (
      symbol: 'speed',
      tint: 'performance',
      title: 'Consistent Performance',
      body:
          "Flutter's rendering engine delivers the same polished UI at 60 or "
          '120 FPS across phones, tablets, desktops, and embedded devices.',
    ),
    (
      symbol: 'insights',
      tint: 'smooth',
      title: 'Smooth experiences',
      body:
          "Flutter's Impeller renderer eliminates jank, delivering fluid "
          'animations and interactions on every platform.',
    ),
    (
      symbol: 'hub',
      tint: 'system',
      title: 'Tools included',
      body:
          'Integrated IDE, debugging, DevTools, and platform-specific tools, '
          'with an AI-powered development workflow.',
    ),
  ];

  @override
  State<WhyFlutterFeaturesSection> createState() =>
      _WhyFlutterFeaturesSectionState();
}

class _WhyFlutterFeaturesSectionState extends State<WhyFlutterFeaturesSection> {
  final GlobalNodeKey<web.HTMLElement> _gridKey = GlobalNodeKey();

  bool _isDragging = false;
  double _startX = 0;
  double _scrollLeft = 0;

  void _onPointerDown(web.Event event) {
    if (!kIsWeb) return;
    final e = event as web.PointerEvent;
    if (e.pointerType != 'mouse' || e.button != 0) return;

    final grid =
        (event.currentTarget ?? _gridKey.currentNode) as web.HTMLElement?;
    if (grid == null) return;
    if (grid.scrollWidth <= grid.clientWidth) return;

    _isDragging = true;
    _startX = e.clientX.toDouble();
    _scrollLeft = grid.scrollLeft.toDouble();

    try {
      grid.setPointerCapture(e.pointerId);
    } catch (_) {}
    grid.classList.add('is-dragging');
    e.preventDefault();
  }

  void _onPointerMove(web.Event event) {
    if (!_isDragging) return;
    final e = event as web.PointerEvent;
    final grid =
        (event.currentTarget ?? _gridKey.currentNode) as web.HTMLElement?;
    if (grid == null) return;

    e.preventDefault();
    final dx = e.clientX.toDouble() - _startX;
    grid.scrollLeft = (_scrollLeft - dx).round();
  }

  void _onPointerUp(web.Event event) {
    if (!_isDragging) return;
    final e = event as web.PointerEvent;
    final grid =
        (event.currentTarget ?? _gridKey.currentNode) as web.HTMLElement?;
    _isDragging = false;

    if (grid != null) {
      try {
        grid.releasePointerCapture(e.pointerId);
      } catch (_) {}
      grid.classList.remove('is-dragging');
    }
  }

  @override
  Component build(BuildContext context) {
    return section(
      id: 'design-fidelity',
      classes: 'module why-flutter-features',
      [
        const div(classes: 'stacked-header container', [
          p(classes: 'why-flutter-kicker', [.text('Design fidelity')]),
          h2([.text('Every pixel, on brand')]),
          p(classes: 'why-flutter-sub', [
            .text(
              "Don't compromise your brand. Control every pixel with a single "
              'rendering engine.',
            ),
          ]),
        ]),
        div(
          key: _gridKey,
          classes: 'why-flutter-feature-grid',
          events: {
            'pointerdown': _onPointerDown,
            'pointermove': _onPointerMove,
            'pointerup': _onPointerUp,
            'pointercancel': _onPointerUp,
            'lostpointercapture': _onPointerUp,
          },
          [
            for (final feature in WhyFlutterFeaturesSection._features)
              _FeatureCard(feature: feature),
          ],
        ),
      ],
    );
  }
}

/// A single feature card, including the two blurred blobs that orbit its
/// corners while hovered.
class _FeatureCard extends StatelessComponent {
  const _FeatureCard({required this.feature});

  final _Feature feature;

  @override
  Component build(BuildContext context) {
    return div(classes: 'why-flutter-feature-card tint-${feature.tint}', [
      const div(classes: 'why-flutter-blob why-flutter-blob-top', []),
      div(classes: 'why-flutter-feature-icon', [Icon(symbol: feature.symbol)]),
      div(classes: 'why-flutter-feature-body', [
        h3([.text(feature.title)]),
        p([.text(feature.body)]),
      ]),
      const div(classes: 'why-flutter-blob why-flutter-blob-bottom', []),
    ]);
  }
}
