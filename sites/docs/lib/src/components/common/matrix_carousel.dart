// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';

import '../../utils/inline_code.dart';

/// Data model for a filter tab in [MatrixCarousel].
final class MatrixFilterItem {
  const MatrixFilterItem({
    required this.id,
    required this.label,
  });

  final String id;
  final String label;
}

/// Data model for an individual card in [MatrixCarousel].
final class MatrixCardItem {
  const MatrixCardItem({
    required this.title,
    required this.description,
    this.category,
    this.categoryLabel,
    this.type,
    this.typeLabel,
  });

  final String title;
  final String description;
  final String? category;
  final String? categoryLabel;
  final String? type;
  final String? typeLabel;
}

/// An interactive, filterable carousel displaying a matrix of cards with
/// categorizations and badges.
final class MatrixCarousel extends StatelessComponent {
  const MatrixCarousel({
    required this.title,
    required this.description,
    this.filters = const [],
    required this.cards,
    this.classes = 'grader-matrix',
    this.previousAriaLabel = 'Previous card',
    this.nextAriaLabel = 'Next card',
    super.key,
  });

  final String title;
  final String description;
  final List<MatrixFilterItem> filters;
  final List<MatrixCardItem> cards;
  final String classes;
  final String previousAriaLabel;
  final String nextAriaLabel;

  @override
  Component build(BuildContext context) {
    return div(classes: classes, [
      div(classes: 'matrix-header', [
        div(classes: 'matrix-title-area', [
          h3([.text(title)]),
          p([renderDescriptionWithCode(description)]),
        ]),
        if (filters.isNotEmpty)
          div(classes: 'matrix-filters', [
            for (var i = 0; i < filters.length; i++)
              button(
                classes: i == 0 ? 'filter-btn active' : 'filter-btn',
                attributes: {'data-filter': filters[i].id},
                [.text(filters[i].label)],
              ),
          ]),
      ]),
      div(classes: 'grader-carousel-wrapper', [
        button(
          classes: 'carousel-nav-btn prev',
          attributes: {
            'aria-label': previousAriaLabel,
            'title': previousAriaLabel,
          },
          const [MaterialIcon('chevron_left')],
        ),
        div(classes: 'grader-cards-track', [
          for (final card in cards)
            div(
              classes: [
                'grader-card',
                if (card.category case final category?) 'cat-$category',
                if (card.type case final type?) 'cat-$type',
              ].toClasses,
              [
                if (card.categoryLabel != null || card.typeLabel != null)
                  div(classes: 'grader-header', [
                    if (card.categoryLabel case final categoryLabel?)
                      span(
                        classes: [
                          'grader-cat',
                          ?card.category,
                        ].toClasses,
                        [.text(categoryLabel)],
                      ),
                    if (card.typeLabel case final typeLabel?)
                      span(
                        classes: [
                          'grader-badge',
                          if (card.type case final type?) 'badge-$type',
                        ].toClasses,
                        [.text(typeLabel)],
                      ),
                  ]),
                h4([.text(card.title)]),
                p([renderDescriptionWithCode(card.description)]),
              ],
            ),
        ]),
        button(
          classes: 'carousel-nav-btn next',
          attributes: {
            'aria-label': nextAriaLabel,
            'title': nextAriaLabel,
          },
          const [MaterialIcon('chevron_right')],
        ),
      ]),
    ]);
  }
}
