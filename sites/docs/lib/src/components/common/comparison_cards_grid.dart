// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';

import '../../utils/inline_code.dart';

/// Data model for an individual card in [ComparisonCardsGrid].
final class ComparisonCardItem {
  const ComparisonCardItem({
    required this.tag,
    this.tagIcon,
    required this.mathPill,
    required this.title,
    this.isFeatured = false,
    this.descriptionParts = const [],
    this.description,
  });

  final String tag;
  final String? tagIcon;
  final String mathPill;
  final String title;
  final bool isFeatured;
  final List<Map<String, Object?>> descriptionParts;
  final String? description;
}

/// A responsive comparison grid for metrics, benchmarks, or feature
/// evaluations.
final class ComparisonCardsGrid extends StatelessComponent {
  const ComparisonCardsGrid({
    required this.cards,
    this.classes = 'reliability-comparison-grid',
    super.key,
  });

  final List<ComparisonCardItem> cards;
  final String classes;

  @override
  Component build(BuildContext context) {
    return div(classes: classes, [
      for (final card in cards)
        div(
          classes: [
            'reliability-card',
            if (card.isFeatured) 'north-star',
          ].toClasses,
          [
            div(classes: 'reliability-header', [
              span(classes: 'tag', [
                if (card.tagIcon case final icon?) ...[
                  MaterialIcon(icon),
                  const .text(' '),
                ],
                .text(card.tag),
              ]),
              span(classes: 'math-pill', [.text(card.mathPill)]),
            ]),
            h4([.text(card.title)]),
            if (card.descriptionParts.isNotEmpty)
              p([
                for (final part in card.descriptionParts) ...[
                  if (part['text'] case final String text) .text(text),
                  if (part['em'] case final String emText) em([.text(emText)]),
                  if (part['strong'] case final String strongText)
                    strong([.text(strongText)]),
                ],
              ])
            else if (card.description case final description?)
              p([renderDescriptionWithCode(description)]),
          ],
        ),
    ]);
  }
}
