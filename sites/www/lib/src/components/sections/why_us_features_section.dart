// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../common/icon.dart';

/// Describes a single "Every pixel, on brand" feature card.
typedef _Feature = ({String symbol, String tint, String title, String body});

/// The "Every pixel, on brand" section.
///
/// A 2x2 grid on wide viewports that becomes a horizontal snap-scroll carousel
/// on small ones. The decorative blobs animate purely in CSS on hover, so this
/// section needs no client-side code.
class WhyUsFeaturesSection extends StatelessComponent {
  const WhyUsFeaturesSection({super.key});

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
      symbol: 'hub',
      tint: 'system',
      title: 'One Design System',
      body:
          'Maintain a single design system across iOS, Android, web, and '
          'desktop for a consistent brand experience everywhere.',
    ),
    (
      symbol: 'insights',
      tint: 'smooth',
      title: 'Smooth by Default',
      body:
          "Impeller's precompiled shaders eliminate first-run jank, "
          'delivering fluid interactions from the very first launch.',
    ),
  ];

  @override
  Component build(BuildContext context) {
    return section(id: 'design-fidelity', classes: 'module why-us-features', [
      const div(classes: 'stacked-header container', [
        p(classes: 'why-us-kicker', [.text('Design fidelity')]),
        h2([.text('Every pixel, on brand')]),
        p(classes: 'why-us-sub', [
          .text(
            "Don't compromise your brand. Control every pixel with a single "
            'rendering engine.',
          ),
        ]),
      ]),
      div(classes: 'why-us-feature-grid', [
        for (final feature in _features) _FeatureCard(feature: feature),
      ]),
    ]);
  }
}

/// A single feature card, including the two blurred blobs that orbit its
/// corners while hovered.
class _FeatureCard extends StatelessComponent {
  const _FeatureCard({required this.feature});

  final _Feature feature;

  @override
  Component build(BuildContext context) {
    return div(classes: 'why-us-feature-card tint-${feature.tint}', [
      const div(classes: 'why-us-blob why-us-blob-top', []),
      div(classes: 'why-us-feature-icon', [Icon(symbol: feature.symbol)]),
      div(classes: 'why-us-feature-body', [
        h3([.text(feature.title)]),
        p([.text(feature.body)]),
      ]),
      const div(classes: 'why-us-blob why-us-blob-bottom', []),
    ]);
  }
}
