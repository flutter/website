// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';

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
          div(classes: 'card-header-row', [
            div(classes: 'card-icon-wrap ${dim.category}', [
              MaterialIcon(dim.icon),
            ]),
            h4([.text(dim.title)]),
          ]),
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

/// Model for a single tab/panel within [InteractiveDetailCard].
final class InteractiveDetailTab {
  const InteractiveDetailTab({
    required this.id,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.heading,
    this.badge,
    this.variant = 'blue',
    required this.overview,
    this.itemsLabel,
    this.items = const [],
    this.footerText,
  });

  final String id;
  final String primaryLabel;
  final String secondaryLabel;
  final String heading;
  final String? badge;
  final String variant;
  final String overview;
  final String? itemsLabel;
  final List<InteractiveDetailItem> items;
  final String? footerText;
}

/// Key-value item within [InteractiveDetailTab].
final class InteractiveDetailItem {
  const InteractiveDetailItem({
    required this.label,
    required this.detail,
  });

  final String label;
  final String detail;
}

/// A reusable interactive card featuring selectable tabs and responsive detail
/// panels.
final class InteractiveDetailCard extends StatelessComponent {
  const InteractiveDetailCard({
    required this.title,
    required this.description,
    required this.tabs,
    this.classes = 'interactive-detail-card',
    super.key,
  });

  final String title;
  final String description;
  final List<InteractiveDetailTab> tabs;
  final String classes;

  @override
  Component build(BuildContext context) {
    return div(classes: classes, [
      div(classes: 'card-header-area triage-header', [
        h3([.text(title)]),
        p([.text(description)]),
      ]),
      div(classes: 'card-tabs-grid triage-tiers-grid', [
        for (var i = 0; i < tabs.length; i++)
          button(
            classes: [
              'card-tab-btn',
              'triage-tier-btn',
              'variant-${tabs[i].variant}',
              'tier-${tabs[i].variant}',
              if (i == 0) 'active',
            ].toClasses,
            attributes: {'data-tab': tabs[i].id, 'data-tier': tabs[i].id},
            [
              div(
                classes: 'tab-primary-label tier-score',
                [.text(tabs[i].primaryLabel)],
              ),
              div(
                classes: 'tab-secondary-label tier-name',
                [.text(tabs[i].secondaryLabel)],
              ),
            ],
          ),
      ]),
      div(classes: 'card-panels-container triage-detail-card', [
        for (var i = 0; i < tabs.length; i++)
          div(
            classes: [
              'card-panel',
              'triage-panel',
              if (i == 0) 'active',
            ].toClasses,
            attributes: {'data-tab': tabs[i].id, 'data-tier': tabs[i].id},
            [
              div(classes: 'panel-heading', [
                h4([.text(tabs[i].heading)]),
                if (tabs[i].badge case final badge?)
                  span(
                    classes: 'panel-badge badge-${tabs[i].variant}',
                    [.text(badge)],
                  ),
              ]),
              p(
                classes: 'panel-overview criteria-text',
                [_renderDescription(tabs[i].overview)],
              ),
              if (tabs[i].items.isNotEmpty)
                div(classes: 'panel-items-section actions-section', [
                  if (tabs[i].itemsLabel case final label?)
                    div(classes: 'items-label actions-label', [.text(label)]),
                  ul([
                    for (final item in tabs[i].items)
                      li([
                        strong([.text('${item.label}: ')]),
                        _renderDescription(item.detail),
                      ]),
                  ]),
                ]),
              if (tabs[i].footerText case final footer?)
                p(
                  classes: 'panel-footer-text',
                  [_renderDescription(footer)],
                ),
            ],
          ),
      ]),
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

    return InteractiveDetailCard(
      title: triage.title,
      description: triage.description,
      classes: 'interactive-detail-card score-triage',
      tabs: [
        for (final tier in triage.tiers)
          InteractiveDetailTab(
            id: tier.id,
            primaryLabel: tier.score,
            secondaryLabel: tier.name,
            heading: tier.heading,
            badge: tier.badge,
            variant: tier.id,
            overview: tier.criteria,
            itemsLabel: tier.actionsLabel,
            items: [
              for (final action in tier.actions)
                InteractiveDetailItem(
                  label: action.label,
                  detail: action.detail,
                ),
            ],
          ),
      ],
    );
  }
}

/// Interactive 4-axis evaluation test matrix tabs component.
final class EvaluationMatrixTabs extends StatelessComponent {
  const EvaluationMatrixTabs({super.key});

  @override
  Component build(BuildContext context) {
    final data = FlutterBenchData.fromContext(context);
    final matrix = data.evaluationMatrix;

    return InteractiveDetailCard(
      title: matrix.title,
      description: matrix.description,
      classes: 'interactive-detail-card evaluation-matrix-card',
      tabs: [
        for (final axis in matrix.axes)
          InteractiveDetailTab(
            id: axis.id,
            primaryLabel: axis.tabLabel,
            secondaryLabel: axis.tabSublabel,
            heading: axis.heading,
            badge: axis.badge,
            variant: axis.variant,
            overview: axis.overview,
            itemsLabel: axis.itemsLabel,
            items: [
              for (final item in axis.items)
                InteractiveDetailItem(
                  label: item.label,
                  detail: item.detail,
                ),
            ],
            footerText: axis.footerText,
          ),
      ],
    );
  }
}

/// Expansion panels displaying Task Structure, Categories, Tiers, and Quality
/// Assurance.
final class TaskSpecifications extends StatelessComponent {
  const TaskSpecifications({super.key});

  @override
  Component build(BuildContext context) {
    final data = FlutterBenchData.fromContext(context);
    final specs = data.taskSpecifications;

    return div(classes: 'task-specs-list', [
      for (final spec in specs)
        div(classes: 'task-spec-panel', [
          a(
            classes: [
              'collapsible',
              if (!spec.expanded) 'collapsed',
            ].toClasses,
            href: '#task-spec-${spec.id}',
            attributes: {
              'data-toggle': 'collapse',
              'data-target': '#task-spec-${spec.id}',
              'role': 'button',
              'aria-expanded': spec.expanded ? 'true' : 'false',
              'aria-controls': '#task-spec-${spec.id}',
            },
            [
              div(classes: 'panel-header-left', [
                div(classes: 'panel-icon-wrap variant-${spec.badgeVariant}', [
                  MaterialIcon(spec.icon),
                ]),
                div(classes: 'panel-header-content', [
                  div(classes: 'panel-title-row', [
                    h4([.text(spec.title)]),
                    if (spec.badge.isNotEmpty)
                      span(
                      classes: 'badge badge-${spec.badgeVariant}',
                      [.text(spec.badge)],
                    ),
                  ]),
                  if (spec.description.isNotEmpty)
                    p(classes: 'panel-description', [
                      .text(spec.description),
                    ]),
                ]),
              ]),
            ],
          ),
          div(
            id: 'task-spec-${spec.id}',
            classes: [
              'task-spec-body collapse',
              if (spec.expanded) 'show',
            ].toClasses,
            [
              if (spec.leadText.isNotEmpty)
                p(classes: 'lead-text', [_renderDescription(spec.leadText)]),
              for (final tableData in spec.tables) ...[
                if (tableData.title.isNotEmpty)
                  h5(classes: 'table-subheading', [.text(tableData.title)]),
                div(classes: 'table-wrapper', [
                  table(classes: 'spec-table', [
                    tbody([
                      for (final row in tableData.rows)
                        tr([
                          td([
                            strong([.text(row.label)]),
                          ]),
                          td([_renderDescription(row.description)]),
                        ]),
                    ]),
                  ]),
                ]),
              ],
              if (spec.footerText.isNotEmpty)
                p(
                  classes: 'footer-text',
                  [_renderDescription(spec.footerText)],
                ),
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
    final effectiveSections =
        sections ?? FlutterBenchData.fromContext(context).cujExampleSections;

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

  List<TaskSpecificationData> get taskSpecifications =>
      (_data['task_specifications'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(TaskSpecificationData._)
          .toList();

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

  EvaluationMatrixData get evaluationMatrix => EvaluationMatrixData._(
    _data['evaluation_matrix'] as Map<String, Object?>? ?? const {},
  );
}

extension type EvaluationMatrixData._(Map<String, Object?> _data) {
  String get title => _data['title'] as String? ?? '';
  String get description => _data['description'] as String? ?? '';
  List<EvaluationMatrixAxisData> get axes =>
      (_data['axes'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(EvaluationMatrixAxisData._)
          .toList();
}

extension type EvaluationMatrixAxisData._(Map<String, Object?> _data) {
  String get id => _data['id'] as String? ?? '';
  String get tabLabel => _data['tab_label'] as String? ?? '';
  String get tabSublabel => _data['tab_sublabel'] as String? ?? '';
  String get heading => _data['heading'] as String? ?? '';
  String get badge => _data['badge'] as String? ?? '';
  String get variant => _data['variant'] as String? ?? 'blue';
  String get overview => _data['overview'] as String? ?? '';
  String get itemsLabel => _data['items_label'] as String? ?? '';
  String get footerText => _data['footer_text'] as String? ?? '';
  List<EvaluationMatrixItemData> get items =>
      (_data['items'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(EvaluationMatrixItemData._)
          .toList();
}

extension type EvaluationMatrixItemData._(Map<String, Object?> _data) {
  String get label => _data['label'] as String? ?? '';
  String get detail => _data['detail'] as String? ?? '';
}

extension type TaskSpecificationData._(Map<String, Object?> _data) {
  String get id => _data['id'] as String? ?? '';
  String get title => _data['title'] as String? ?? '';
  String get badge => _data['badge'] as String? ?? '';
  String get badgeVariant => _data['badge_variant'] as String? ?? 'blue';
  String get icon => _data['icon'] as String? ?? 'info';
  bool get expanded => _data['expanded'] as bool? ?? false;
  String get description => _data['description'] as String? ?? '';
  String get leadText => _data['lead_text'] as String? ?? '';
  String get footerText => _data['footer_text'] as String? ?? '';
  List<TaskSpecTableData> get tables =>
      (_data['tables'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(TaskSpecTableData._)
          .toList();
}

extension type TaskSpecTableData._(Map<String, Object?> _data) {
  String get title => _data['title'] as String? ?? '';
  List<String> get headers => (_data['headers'] as List<Object?>? ?? const [])
      .map((h) => h.toString())
      .toList();
  List<TaskSpecTableRowData> get rows =>
      (_data['rows'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(TaskSpecTableRowData._)
          .toList();
}

extension type TaskSpecTableRowData._(Map<String, Object?> _data) {
  String get label => _data['label'] as String? ?? '';
  String get description => _data['description'] as String? ?? '';
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
