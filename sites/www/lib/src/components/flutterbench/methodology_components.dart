// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';

export 'grader_matrix.dart';
export 'interactive_detail_card.dart';
export 'task_specifications.dart';

/// Renders text with optional inline code segments delimited by backticks.
Component renderDescriptionWithCode(String text) {
  if (!text.contains('`')) {
    return .text(text);
  }
  final parts = text.split('`');
  final children = <Component>[];
  for (var i = 0; i < parts.length; i++) {
    if (i.isOdd) {
      children.add(code([.text(parts[i])]));
    } else if (parts[i].isNotEmpty) {
      children.add(.text(parts[i]));
    }
  }
  return .fragment(children);
}

// -----------------------------------------------------------------------------
// 1. Three Dimensions Cards
// -----------------------------------------------------------------------------

/// Cards displaying the Three Core Dimensions of FlutterBench evaluation.
class ThreeDimensionsCards extends StatelessComponent {
  const ThreeDimensionsCards({required this.dimensions, super.key});

  final List<Map<String, Object?>> dimensions;

  @override
  Component build(BuildContext context) {
    return div(classes: 'dimension-cards-grid', [
      for (final dim in dimensions)
        div(classes: 'dimension-card', [
          div(classes: 'card-header-row', [
            div(
              classes: [
                'card-icon-wrap',
                dim['category'] as String? ?? '',
              ].toClasses,
              [MaterialIcon(dim['icon'] as String? ?? 'info')],
            ),
            h4([.text(dim['title'] as String? ?? '')]),
          ]),
          p([renderDescriptionWithCode(dim['description'] as String? ?? '')]),
          if (dim['footer_items'] != null || dim['badge'] != null)
            div(classes: 'card-footer-info', [
              if (dim['footer_items'] case final String footer)
                span([.text(footer)]),
              if (dim['badge'] case final String badge)
                span(
                  classes: [
                    'badge',
                    dim['category'] as String? ?? '',
                  ].toClasses,
                  [.text(badge)],
                ),
            ]),
        ]),
    ]);
  }
}

// -----------------------------------------------------------------------------
// 2. Reliability Comparison Cards
// -----------------------------------------------------------------------------

/// Comparison cards for Capability (pass@k) vs Consistency (pass^k).
class ReliabilityCards extends StatelessComponent {
  const ReliabilityCards({required this.cards, super.key});

  final List<Map<String, Object?>> cards;

  @override
  Component build(BuildContext context) {
    return div(classes: 'reliability-comparison-grid', [
      for (final card in cards)
        div(
          classes: [
            'reliability-card',
            if (card['is_north_star'] == true) 'north-star',
          ].toClasses,
          [
            div(classes: 'reliability-header', [
              span(classes: 'tag', [
                if (card['tag_icon'] case final String icon) ...[
                  MaterialIcon(icon),
                  const .text(' '),
                ],
                .text(card['tag'] as String? ?? ''),
              ]),
              span(classes: 'math-pill', [.text(card['math_pill'] as String? ?? '')]),
            ]),
            h4([.text(card['title'] as String? ?? '')]),
            if (card['description_parts'] case final List<Object?> parts)
              p([
                for (final part in parts.whereType<Map<String, Object?>>()) ...[
                  if (part['text'] case final String text) .text(text),
                  if (part['em'] case final String emText) em([.text(emText)]),
                  if (part['strong'] case final String strongText)
                    strong([.text(strongText)]),
                ],
              ])
            else if (card['description'] case final String desc)
              p([renderDescriptionWithCode(desc)]),
          ],
        ),
    ]);
  }
}

// -----------------------------------------------------------------------------
// 3. CUJ Journey Diagram
// -----------------------------------------------------------------------------

/// Diagram visualizing developer persona -> goal -> task steps.
class CujDiagram extends StatelessComponent {
  const CujDiagram({required this.sections, super.key});

  final List<Map<String, Object?>> sections;

  @override
  Component build(BuildContext context) {
    return div(classes: 'cuj-diagram-card', [
      for (final section in sections)
        div(classes: 'cuj-diagram-section', [
          div(classes: 'section-sidebar', [
            div(
              classes: 'section-icon variant-${section['variant'] as String? ?? 'blue'}',
              [MaterialIcon(section['icon'] as String? ?? 'info')],
            ),
            span(
              classes: 'section-label',
              [.text(section['label'] as String? ?? '')],
            ),
          ]),
          div(classes: 'section-items', [
            for (final item in (section['items'] as List<Object?>? ?? const []))
              div(
                classes: 'cuj-pill pill-${section['variant'] as String? ?? 'blue'}',
                [.text(item.toString())],
              ),
          ]),
        ]),
    ]);
  }
}
