// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/material_icon.dart';

/// Renders text with optional inline code segments delimited by backticks.
Component _renderDescription(String text) {
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

/// Renders structured rich text parts for reliability metric descriptions.
Component _renderReliabilityDescription(ReliabilityCardData card) {
  return p([
    for (final part in card.descriptionParts) ...[
      if (part['text'] case final String text) .text(text),
      if (part['em'] case final String emText) em([.text(emText)]),
      if (part['strong'] case final String strongText)
        strong([.text(strongText)]),
    ],
  ]);
}

/// Cards displaying the Three Core Dimensions of FlutterBench evaluation.
final class ThreeDimensionsCards extends StatelessComponent {
  const ThreeDimensionsCards({super.key});

  @override
  Component build(BuildContext context) {
    final data = FlutterBenchData.fromContext(context);
    final dimensions = data.dimensions;

    return div(classes: 'dimension-cards-grid', [
      for (final dim in dimensions)
        div(classes: 'dimension-card', [
          div(classes: 'card-icon-wrap ${dim.category}', [
            MaterialIcon(dim.icon),
          ]),
          h4([.text(dim.title)]),
          p([.text(dim.description)]),
          div(classes: 'card-footer-info', [
            span([.text(dim.footerItems)]),
            span(classes: 'badge ${dim.category}', [.text(dim.badge)]),
          ]),
        ]),
    ]);
  }
}

/// Interactive filterable Grader Matrix showing evaluation graders in a
/// carousel.
final class GraderMatrix extends StatelessComponent {
  const GraderMatrix({super.key});

  @override
  Component build(BuildContext context) {
    final data = FlutterBenchData.fromContext(context);
    final matrixData = data.graderMatrix;

    return div(classes: 'grader-matrix', [
      div(classes: 'matrix-header', [
        div(classes: 'matrix-title-area', [
          h3([.text(matrixData.title)]),
          p([.text(matrixData.description)]),
        ]),
        div(classes: 'matrix-filters', [
          for (var i = 0; i < matrixData.filters.length; i++)
            button(
              classes: i == 0 ? 'filter-btn active' : 'filter-btn',
              attributes: {'data-filter': matrixData.filters[i].id},
              [.text(matrixData.filters[i].label)],
            ),
        ]),
      ]),
      div(classes: 'grader-carousel-wrapper', [
        const button(
          classes: 'carousel-nav-btn prev',
          attributes: {
            'aria-label': 'Previous grader card',
            'title': 'Previous card',
          },
          [MaterialIcon('chevron_left')],
        ),
        div(classes: 'grader-cards-track', [
          for (final grader in matrixData.graders)
            div(
              classes: 'grader-card cat-${grader.category} cat-${grader.type}',
              [
                div(classes: 'grader-header', [
                  span(
                    classes: 'grader-cat ${grader.category}',
                    [.text(grader.categoryLabel)],
                  ),
                  span(
                    classes: 'grader-badge badge-${grader.type}',
                    [.text(grader.typeLabel)],
                  ),
                ]),
                h4([.text(grader.name)]),
                p([_renderDescription(grader.description)]),
              ],
            ),
        ]),
        const button(
          classes: 'carousel-nav-btn next',
          attributes: {
            'aria-label': 'Next grader card',
            'title': 'Next card',
          },
          [MaterialIcon('chevron_right')],
        ),
      ]),
    ]);
  }
}

/// Comparison cards for Capability (pass@k) vs Consistency (pass^k).
final class ReliabilityCards extends StatelessComponent {
  const ReliabilityCards({super.key});

  @override
  Component build(BuildContext context) {
    final data = FlutterBenchData.fromContext(context);
    final cards = data.reliability.cards;

    return div(classes: 'reliability-comparison-grid', [
      for (final card in cards)
        div(
          classes: card.isNorthStar
              ? 'reliability-card north-star'
              : 'reliability-card',
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
            _renderReliabilityDescription(card),
          ],
        ),
    ]);
  }
}

/// Interactive score interpretation and engineering triage matrix.
final class ScoreTriage extends StatelessComponent {
  const ScoreTriage({super.key});

  @override
  Component build(BuildContext context) {
    final data = FlutterBenchData.fromContext(context);
    final triage = data.scoreTriage;

    return div(classes: 'score-triage', [
      div(classes: 'triage-header', [
        h3([.text(triage.title)]),
        p([.text(triage.description)]),
      ]),
      div(classes: 'triage-tiers-grid', [
        for (var i = 0; i < triage.tiers.length; i++)
          button(
            classes: i == 0
                ? 'triage-tier-btn tier-${triage.tiers[i].id} active'
                : 'triage-tier-btn tier-${triage.tiers[i].id}',
            attributes: {'data-tier': triage.tiers[i].id},
            [
              div(classes: 'tier-score', [.text(triage.tiers[i].score)]),
              div(classes: 'tier-name', [.text(triage.tiers[i].name)]),
            ],
          ),
      ]),
      div(classes: 'triage-detail-card', [
        for (var i = 0; i < triage.tiers.length; i++)
          div(
            classes: i == 0 ? 'triage-panel active' : 'triage-panel',
            attributes: {'data-tier': triage.tiers[i].id},
            [
              div(classes: 'panel-heading', [
                h4([.text(triage.tiers[i].heading)]),
                span(classes: 'panel-badge', [.text(triage.tiers[i].badge)]),
              ]),
              p(classes: 'criteria-text', [.text(triage.tiers[i].criteria)]),
              div(classes: 'actions-section', [
                div(classes: 'actions-label', [
                  .text(triage.tiers[i].actionsLabel),
                ]),
                ul([
                  for (final action in triage.tiers[i].actions)
                    li([
                      strong([.text('${action.label}: ')]),
                      .text(action.detail),
                    ]),
                ]),
              ]),
            ],
          ),
      ]),
    ]);
  }
}

/// A structured, reusable diagram component visualizing a user journey flow
/// across configurable sections and nested elements.
final class CujDiagram extends StatelessComponent {
  const CujDiagram({
    super.key,
    this.sections,
  });

  final List<CujDiagramSection>? sections;

  @override
  Component build(BuildContext context) {
    final effectiveSections = sections ??
        FlutterBenchData.fromContext(context).cujExampleSections;

    return div(classes: 'cuj-diagram-card', [
      for (final section in effectiveSections)
        div(classes: 'cuj-diagram-section', [
          div(classes: 'section-sidebar', [
            div(classes: 'section-icon variant-${section.variant}', [
              MaterialIcon(section.icon),
            ]),
            span(classes: 'section-label', [.text(section.label)]),
          ]),
          div(classes: 'section-items', [
            for (final item in section.items)
              div(classes: 'cuj-pill pill-${section.variant}', [
                .text(item),
              ]),
          ]),
        ]),
    ]);
  }
}

/// Reusable section model for [CujDiagram].
final class CujDiagramSection {
  const CujDiagramSection({
    required this.label,
    required this.icon,
    this.variant = 'blue',
    required this.items,
  });

  factory CujDiagramSection.fromMap(Map<String, Object?> map) {
    return CujDiagramSection(
      label: map['label'] as String? ?? '',
      icon: map['icon'] as String? ?? 'info',
      variant: map['variant'] as String? ?? 'blue',
      items: (map['items'] as List<Object?>? ?? const [])
          .map((item) => item.toString())
          .toList(),
    );
  }

  final String label;
  final String icon;
  final String variant;
  final List<String> items;
}

// -----------------------------------------------------------------------------
// Data Model & Extension Types
// -----------------------------------------------------------------------------

/// Root data model for FlutterBench content loaded from `src/data/flutterbench.yml`.
extension type FlutterBenchData._(Map<String, Object?> _data) {
  static FlutterBenchData fromContext(BuildContext context) {
    final raw =
        context.page.data['flutterbench'] as Map<String, Object?>? ?? const {};
    return FlutterBenchData._(raw);
  }

  List<CujDiagramSection> get cujExampleSections =>
      (_data['cuj_example'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(CujDiagramSection.fromMap)
          .toList();

  List<DimensionData> get dimensions =>
      (_data['dimensions'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(DimensionData._)
          .toList();

  GraderMatrixData get graderMatrix => GraderMatrixData._(
    _data['grader_matrix'] as Map<String, Object?>? ?? const {},
  );

  ReliabilityData get reliability => ReliabilityData._(
    _data['reliability'] as Map<String, Object?>? ?? const {},
  );

  ScoreTriageData get scoreTriage => ScoreTriageData._(
    _data['score_triage'] as Map<String, Object?>? ?? const {},
  );
}

extension type DimensionData._(Map<String, Object?> _data) {
  String get title => _data['title'] as String? ?? '';
  String get icon => _data['icon'] as String? ?? '';
  String get category => _data['category'] as String? ?? '';
  String get description => _data['description'] as String? ?? '';
  String get footerItems => _data['footer_items'] as String? ?? '';
  String get badge => _data['badge'] as String? ?? '';
}

extension type GraderMatrixData._(Map<String, Object?> _data) {
  String get title => _data['title'] as String? ?? '';
  String get description => _data['description'] as String? ?? '';
  List<GraderFilterData> get filters =>
      (_data['filters'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(GraderFilterData._)
          .toList();
  List<GraderCardData> get graders =>
      (_data['graders'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(GraderCardData._)
          .toList();
}

extension type GraderFilterData._(Map<String, Object?> _data) {
  String get id => _data['id'] as String? ?? '';
  String get label => _data['label'] as String? ?? '';
}

extension type GraderCardData._(Map<String, Object?> _data) {
  String get name => _data['name'] as String? ?? '';
  String get category => _data['category'] as String? ?? '';
  String get categoryLabel => _data['category_label'] as String? ?? '';
  String get type => _data['type'] as String? ?? '';
  String get typeLabel => _data['type_label'] as String? ?? '';
  String get description => _data['description'] as String? ?? '';
}

extension type ReliabilityData._(Map<String, Object?> _data) {
  List<ReliabilityCardData> get cards =>
      (_data['cards'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(ReliabilityCardData._)
          .toList();
}

extension type ReliabilityCardData._(Map<String, Object?> _data) {
  String get tag => _data['tag'] as String? ?? '';
  String? get tagIcon => _data['tag_icon'] as String?;
  String get mathPill => _data['math_pill'] as String? ?? '';
  String get title => _data['title'] as String? ?? '';
  bool get isNorthStar => _data['is_north_star'] as bool? ?? false;
  List<Map<String, Object?>> get descriptionParts =>
      (_data['description_parts'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .toList();
}

extension type ScoreTriageData._(Map<String, Object?> _data) {
  String get title => _data['title'] as String? ?? '';
  String get description => _data['description'] as String? ?? '';
  List<ScoreTierData> get tiers =>
      (_data['tiers'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(ScoreTierData._)
          .toList();
}

extension type ScoreTierData._(Map<String, Object?> _data) {
  String get id => _data['id'] as String? ?? '';
  String get score => _data['score'] as String? ?? '';
  String get name => _data['name'] as String? ?? '';
  String get heading => _data['heading'] as String? ?? '';
  String get badge => _data['badge'] as String? ?? 'Criteria & Triage';
  String get criteria => _data['criteria'] as String? ?? '';
  String get actionsLabel =>
      _data['actions_label'] as String? ?? 'Engineering Triage Actions:';
  List<ScoreTierActionData> get actions =>
      (_data['actions'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(ScoreTierActionData._)
          .toList();
}

extension type ScoreTierActionData._(Map<String, Object?> _data) {
  String get label => _data['label'] as String? ?? '';
  String get detail => _data['detail'] as String? ?? '';
}
