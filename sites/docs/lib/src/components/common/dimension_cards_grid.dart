// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';

import '../../utils/inline_code.dart';

/// Data model for an individual card in [DimensionCardsGrid].
final class DimensionCardItem {
  const DimensionCardItem({
    required this.title,
    required this.icon,
    required this.description,
    this.category,
    this.footerItems,
    this.badge,
  });

  final String title;
  final String icon;
  final String description;
  final String? category;
  final String? footerItems;
  final String? badge;
}

/// A grid of cards displaying key dimensions, categories, or metrics.
final class DimensionCardsGrid extends StatelessComponent {
  const DimensionCardsGrid({
    required this.cards,
    this.classes = 'dimension-cards-grid',
    super.key,
  });

  final List<DimensionCardItem> cards;
  final String classes;

  @override
  Component build(BuildContext context) {
    return div(classes: classes, [
      for (final card in cards)
        div(classes: 'dimension-card', [
          div(classes: 'card-header-row', [
            div(
              classes: [
                'card-icon-wrap',
                ?card.category,
              ].toClasses,
              [MaterialIcon(card.icon)],
            ),
            h4([.text(card.title)]),
          ]),
          p([renderDescriptionWithCode(card.description)]),
          if (card.footerItems != null || card.badge != null)
            div(classes: 'card-footer-info', [
              if (card.footerItems case final footer?) span([.text(footer)]),
              if (card.badge case final badge?)
                span(
                  classes: [
                    'badge',
                    ?card.category,
                  ].toClasses,
                  [.text(badge)],
                ),
            ]),
        ]),
    ]);
  }
}
