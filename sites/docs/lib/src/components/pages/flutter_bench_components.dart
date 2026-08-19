// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../common/comparison_cards_grid.dart';
import '../common/dimension_cards_grid.dart';
import '../common/interactive_detail_card.dart';
import '../common/journey_diagram.dart';
import '../common/matrix_carousel.dart';
import '../common/specification_panels.dart';

export '../common/comparison_cards_grid.dart';
export '../common/dimension_cards_grid.dart';
export '../common/interactive_detail_card.dart';
export '../common/journey_diagram.dart';
export '../common/matrix_carousel.dart';
export '../common/specification_panels.dart';

/// Cards displaying the Three Core Dimensions of FlutterBench evaluation.
final class ThreeDimensionsCards extends StatelessComponent {
  const ThreeDimensionsCards({super.key});

  @override
  Component build(BuildContext context) {
    final data = FlutterBenchData.fromContext(context);
    return DimensionCardsGrid(
      cards: [
        for (final dim in data.dimensions)
          DimensionCardItem(
            title: dim.title,
            icon: dim.icon,
            category: dim.category,
            description: dim.description,
            footerItems: dim.footerItems,
            badge: dim.badge,
          ),
      ],
    );
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

    return MatrixCarousel(
      title: matrixData.title,
      description: matrixData.description,
      previousAriaLabel: 'Previous grader card',
      nextAriaLabel: 'Next grader card',
      filters: [
        for (final filter in matrixData.filters)
          MatrixFilterItem(
            id: filter.id,
            label: filter.label,
          ),
      ],
      cards: [
        for (final grader in matrixData.graders)
          MatrixCardItem(
            title: grader.name,
            description: grader.description,
            category: grader.category,
            categoryLabel: grader.categoryLabel,
            type: grader.type,
            typeLabel: grader.typeLabel,
          ),
      ],
    );
  }
}

/// Comparison cards for Capability (pass@k) vs Consistency (pass^k).
final class ReliabilityCards extends StatelessComponent {
  const ReliabilityCards({super.key});

  @override
  Component build(BuildContext context) {
    final data = FlutterBenchData.fromContext(context);
    return ComparisonCardsGrid(
      cards: [
        for (final card in data.reliability.cards)
          ComparisonCardItem(
            tag: card.tag,
            tagIcon: card.tagIcon,
            mathPill: card.mathPill,
            title: card.title,
            isFeatured: card.isNorthStar,
            descriptionParts: card.descriptionParts,
          ),
      ],
    );
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

    return SpecificationPanels(
      panels: [
        for (final spec in specs)
          SpecPanelItem(
            id: spec.id,
            title: spec.title,
            badge: spec.badge,
            badgeVariant: spec.badgeVariant,
            icon: spec.icon,
            expanded: spec.expanded,
            description: spec.description,
            leadText: spec.leadText,
            footerText: spec.footerText,
            tables: [
              for (final table in spec.tables)
                SpecTableItem(
                  title: table.title,
                  headers: table.headers,
                  rows: [
                    for (final row in table.rows)
                      SpecTableRowItem(
                        label: row.label,
                        description: row.description,
                      ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}

/// A structured diagram component visualizing a user journey flow
/// across configurable sections and nested elements.
final class CujDiagram extends StatelessComponent {
  const CujDiagram({
    super.key,
    this.sections,
  });

  final List<JourneySection>? sections;

  @override
  Component build(BuildContext context) {
    final effectiveSections =
        sections ?? FlutterBenchData.fromContext(context).cujExampleSections;

    return JourneyDiagram(sections: effectiveSections);
  }
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

  List<JourneySection> get cujExampleSections =>
      (_data['cuj_example'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(JourneySection.fromMap)
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
