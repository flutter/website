// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/ide_explorer/ide_explorer.dart';
import 'package:site_shared/components/common/ide_explorer/models.dart';

import '../../components/flutterbench/methodology_components.dart';
import '../../components/flutterbench/story_chapter.dart';
import '../../components/flutterbench/task_anatomy.dart';
import '../../models/content/flutterbench_content.dart';
import '../../utils/data_utils.dart';

/// Full FlutterBench Methodology page mounted at `/ai/flutterbench/methodology`.
class FlutterBenchMethodologyPage extends StatelessComponent {
  const FlutterBenchMethodologyPage({super.key});

  @override
  Component build(BuildContext context) {
    final data = context.decodeJsonObject(
      'data.flutterbench.methodology',
      FlutterBenchMethodologyData.fromJson,
    );

    final graderMatrixMap = data.graderMatrix;
    final graderMatrixTitle =
        graderMatrixMap['title'] as String? ?? 'Grader Matrix';
    final graderMatrixDesc = graderMatrixMap['description'] as String? ?? '';
    final graderFilters =
        (graderMatrixMap['filters'] as List<Object?>? ?? const [])
            .whereType<Map<String, Object?>>()
            .toList();
    final graders = (graderMatrixMap['graders'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .toList();

    final reliabilityMap = data.reliability;
    final reliabilityCards =
        (reliabilityMap['cards'] as List<Object?>? ?? const [])
            .whereType<Map<String, Object?>>()
            .toList();

    final scoreTriageMap = data.scoreTriage;
    final scoreTriageTitle =
        scoreTriageMap['title'] as String? ?? 'Score Triage & Action Matrix';
    final scoreTriageDesc = scoreTriageMap['description'] as String? ?? '';
    final scoreTriageTiers =
        (scoreTriageMap['tiers'] as List<Object?>? ?? const [])
            .whereType<Map<String, Object?>>()
            .map(
              (tier) => <String, Object?>{
                'id': tier['id'],
                'primary_label': tier['score'],
                'secondary_label': tier['name'],
                'heading': tier['heading'],
                'badge': tier['badge'],
                'variant': tier['id'],
                'overview': tier['criteria'],
                'items_label': tier['actions_label'],
                'items': tier['actions'],
              },
            )
            .toList();

    final evalMatrixMap = data.evaluationMatrix;
    final evalMatrixTitle =
        evalMatrixMap['title'] as String? ?? '4-Axis Evaluation Matrix';
    final evalMatrixDesc = evalMatrixMap['description'] as String? ?? '';
    final evalMatrixAxes = (evalMatrixMap['axes'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .map(
          (axis) => <String, Object?>{
            'id': axis['id'],
            'primary_label': axis['tab_label'],
            'secondary_label': axis['tab_sublabel'],
            'heading': axis['heading'],
            'badge': axis['badge'],
            'variant': axis['variant'] ?? 'blue',
            'overview': axis['overview'],
            'items_label': axis['items_label'],
            'items': axis['items'],
            'footer_text': axis['footer_text'],
          },
        )
        .toList();

    final harbor = data.transparency.harborExample;

    return main_(classes: 'bench-page methodology-page', [
      // Hero Header with Navigation Tabs
      const section(classes: 'bench-hero-header', [
        div(classes: 'bench-container', [
          div(classes: 'hero-badge-row', [
            span(classes: 'hero-category-tag', [.text('AI BENCHMARK')]),
            span(classes: 'job-id-tag', [.text('METHODOLOGY & EVALUATION')]),
          ]),
          h1(classes: 'bench-hero-title', [
            .text('FlutterBench Methodology'),
          ]),
          p(classes: 'bench-hero-subtitle', [
            .text(
              'Learn about Dart and Flutter\'s evaluation frameworks for measuring AI tooling reliability.',
            ),
          ]),

          // Sub-nav tabs
          nav(classes: 'bench-tab-nav', [
            a(href: '/ai/flutterbench', classes: 'bench-nav-link', [
              .text('Leaderboard'),
            ]),
            a(href: '/ai/flutterbench/tasks', classes: 'bench-nav-link', [
              .text('Tasks & CUJs'),
            ]),
            a(
              href: '/ai/flutterbench/methodology',
              classes: 'bench-nav-link active',
              [
                .text('Methodology'),
              ],
            ),
            a(href: '/ai/flutterbench/cujs', classes: 'bench-nav-link', [
              .text('CUJs'),
            ]),
          ]),
        ]),
      ]),

      div(classes: 'bench-container content-area methodology-content', [
        const div(classes: 'story-reading-progress', [
          div(classes: 'story-reading-progress-bar', []),
        ]),
        div(classes: 'story-canvas', [
          _buildOverviewChapter(data),
          _buildDatasetTasksChapter(data),
          StoryChapter(
            number: '03',
            title: 'Evaluation test matrix',
            anchorId: 'evaluation-test-matrix',
            children: [
              if (evalMatrixAxes.isNotEmpty)
                InteractiveDetailCard(
                  title: evalMatrixTitle,
                  description: evalMatrixDesc,
                  classes: 'interactive-detail-card evaluation-matrix-card',
                  tabs: evalMatrixAxes,
                ),
            ],
          ),
          _buildScoringArchitectureChapter(
            data,
            graderMatrixTitle: graderMatrixTitle,
            graderMatrixDesc: graderMatrixDesc,
            graderFilters: graderFilters,
            graders: graders,
          ),
          const StoryChapter(
            number: '05',
            title: 'Evaluation harness',
            anchorId: 'evaluation-harness',
          ),
          _buildReliabilityTriageChapter(
            data,
            reliabilityCards: reliabilityCards,
            scoreTriageTitle: scoreTriageTitle,
            scoreTriageDesc: scoreTriageDesc,
            scoreTriageTiers: scoreTriageTiers,
          ),
          _buildTransparencyChapter(harbor),
        ]),
      ]),
    ]);
  }

  Component _buildOverviewChapter(FlutterBenchMethodologyData data) {
    return StoryChapter(
      number: '01',
      title: 'Overview',
      anchorId: 'overview',
      children: [
        p(classes: 'methodology-lead', [.text(data.overview.leadText)]),
        div(classes: 'table-wrapper', [
          table(classes: 'bench-table methodology-table', [
            const thead([
              tr([
                th([.text('Component')]),
                th([.text('Description')]),
              ]),
            ]),
            tbody([
              for (final row in data.overview.rows)
                tr([
                  td([
                    a(href: '#${row.anchor}', [
                      strong([.text(row.label)]),
                    ]),
                  ]),
                  td([.text(row.description)]),
                ]),
            ]),
          ]),
        ]),
      ],
    );
  }

  Component _buildDatasetTasksChapter(FlutterBenchMethodologyData data) {
    return StoryChapter(
      number: '02',
      title: 'Dataset & tasks',
      anchorId: 'dataset-tasks',
      children: [
        storyH3('Task derivation'),
        const p([
          .text('Evaluation tasks derive directly from Flutter\'s canonical '),
          a(href: '/ai/flutterbench/tasks', [
            .text('Critical User Journeys (CUJs)'),
          ]),
          .text(
            ', which are the core workflows that developers perform '
            'regularly. This approach ensures evaluations reflect '
            'real-world developer needs rather than synthetic puzzles.',
          ),
        ]),
        const p([.text('Each CUJ represents a combination of:')]),
        const ul([
          li([
            .text(
              'A Flutter developer persona (e.g., app developer, plugin developer, full-stack developer)',
            ),
          ]),
          li([.text('A high-level goal')]),
          li([
            .text(
              'The specific sequential steps required to achieve that goal',
            ),
          ]),
        ]),

        if (data.cujExample.isNotEmpty) CujDiagram(sections: data.cujExample),

        const div(classes: 'methodology-note-box', [
          p([
            strong([.text('Note: ')]),
            .text(
              'We can\'t open-source the full evaluation tasks without '
              'contaminating the benchmark dataset, but we publish our '
              'canonical list of CUJs. With this list, along with the '
              'example task below, you can understand our evaluation '
              'philosophy for FlutterBench.',
            ),
          ]),
        ]),

        const p([
          .text('These CUJs are converted into '),
          a(
            href: 'https://harborframework.com/',
            target: Target.blank,
            [.text('Harbor')],
          ),
          .text(
            ' tasks. Harbor is the framework used to run containerized '
            'evaluation tasks.',
          ),
        ]),
        const p([
          .text(
            'CUJs and Harbor tasks don\'t map cleanly one-to-one. Instead, '
            'the CUJ list serves as a guide to verify that core developer '
            'workflows are evaluated. In some cases, several CUJs combine '
            'into a single task, and vice-versa. Our most ambitious '
            'evaluations combine multiple Harbor tasks, and thus cover '
            'many CUJs.',
          ),
        ]),

        storyH3('Task specifications'),
        if (data.taskSpecifications.isNotEmpty)
          TaskSpecifications(specs: data.taskSpecifications),

        storyH3('Interactive task anatomy'),
        p([.text(data.taskAnatomy.introText)]),
        if (data.taskAnatomy.tree.isNotEmpty)
          IdeExplorer(
            roots: [
              IdeExplorerProjectRoot(
                id: data.taskAnatomy.rootId,
                label: data.taskAnatomy.rootLabel,
                children: buildIdeTreeNodes(data.taskAnatomy.tree),
              ),
            ],
            customContents: buildIdeCustomContents(data.taskAnatomy.tree),
          ),
      ],
    );
  }

  Component _buildScoringArchitectureChapter(
    FlutterBenchMethodologyData data, {
    required String graderMatrixTitle,
    required String graderMatrixDesc,
    required List<Map<String, Object?>> graderFilters,
    required List<Map<String, Object?>> graders,
  }) {
    return StoryChapter(
      number: '04',
      title: 'Scoring architecture',
      anchorId: 'scoring-architecture',
      children: [
        storyH3('Scoring philosophy'),
        const p([
          .text(
            'When evaluating AI coding agents, execution friction—such as tool failures, endless retries, and '
            'hallucinations—is often attributed entirely to model capability. However, AI coding systems follow a core equation:',
          ),
        ]),
        const div(classes: 'scoring-formula-card', [
          div(classes: 'formula-math', [
            .text('Agent = Model + Harness'),
          ]),
          div(classes: 'formula-explainer', [
            .text(
              'While the Dart and Flutter teams do not train the underlying LLMs, we build and maintain the '
              'Dart and Flutter AI Harness (skills, MCP tools, compiler diagnostics, and sandboxes). '
              'Therefore, Developer Experience (DX) is directly within our engineering control and belongs in '
              'our primary benchmark score alongside functional outcomes and code quality.',
            ),
          ]),
        ]),
        const ul([
          li([
            strong([.text('Primary focus: ')]),
            .text('The quality and correctness of the final code artifact.'),
          ]),
          li([
            strong([.text('First-class signal: ')]),
            .text(
              'Developer experience friction, tool accuracy, and recovery efficiency.',
            ),
          ]),
        ]),

        storyH3('Three core evaluation dimensions'),
        const p([
          .text(
            'Each evaluation produces three independent dimensions that compute the composite Result Score in Harbor\'s reward:',
          ),
        ]),
        const div(classes: 'composite-reward-bar', [
          div(classes: 'reward-weight outcome-weight', [
            span(classes: 'weight-val', [.text('60%')]),
            span(classes: 'weight-name', [.text('Outcome')]),
          ]),
          div(classes: 'reward-weight quality-weight', [
            span(classes: 'weight-val', [.text('30%')]),
            span(classes: 'weight-name', [.text('Code Quality')]),
          ]),
          div(classes: 'reward-weight dx-weight', [
            span(classes: 'weight-val', [.text('10%')]),
            span(classes: 'weight-name', [.text('Developer Experience')]),
          ]),
        ]),

        if (data.dimensions.isNotEmpty)
          ThreeDimensionsCards(dimensions: data.dimensions),

        storyH3('Grader matrix'),
        const p([
          .text(
            'FlutterBench deploys a mix of deterministic, LLM-as-a-judge, and heuristic graders across all three dimensions:',
          ),
        ]),
        if (graders.isNotEmpty)
          GraderMatrix(
            title: graderMatrixTitle,
            description: graderMatrixDesc,
            filters: graderFilters,
            graders: graders,
          ),

        storyH3('Grader implementation tiers'),
        div(classes: 'table-wrapper', [
          table(classes: 'bench-table methodology-table', [
            const thead([
              tr([
                th([.text('Tier')]),
                th([.text('Grader Type')]),
                th([.text('Evaluation Role')]),
              ]),
            ]),
            tbody([
              for (final row in data.graderTiers.rows)
                tr([
                  td([
                    strong([.text(row.label)]),
                  ]),
                  td([.text(row.detail ?? '')]),
                  td([.text(row.description)]),
                ]),
            ]),
          ]),
        ]),

        storyH3('Diagnostic telemetry (excluded from Result Score)'),
        const p([
          .text(
            'To avoid penalizing capability scores on complex tasks that naturally require more reasoning steps or tokens, '
            'FlutterBench tracks diagnostic telemetry separately from the Result Score:',
          ),
        ]),
        div(classes: 'table-wrapper', [
          table(classes: 'bench-table methodology-table', [
            const thead([
              tr([
                th([.text('Metric')]),
                th([.text('Measurement Target')]),
              ]),
            ]),
            tbody([
              for (final row in data.diagnosticTelemetry.rows)
                tr([
                  td([
                    strong([.text(row.label)]),
                  ]),
                  td([.text(row.description)]),
                ]),
            ]),
          ]),
        ]),
      ],
    );
  }

  Component _buildReliabilityTriageChapter(
    FlutterBenchMethodologyData data, {
    required List<Map<String, Object?>> reliabilityCards,
    required String scoreTriageTitle,
    required String scoreTriageDesc,
    required List<Map<String, Object?>> scoreTriageTiers,
  }) {
    return StoryChapter(
      number: '06',
      title: 'Reliability & triage',
      anchorId: 'reliability-triage',
      children: [
        storyH3('Multi-run reliability metrics'),
        const p([
          .text(
            'Single-run trials only sample luck. True agent trust requires measuring multi-trial stability across repeated runs:',
          ),
        ]),
        if (reliabilityCards.isNotEmpty)
          ReliabilityCards(cards: reliabilityCards),

        storyH3('Score interpretation & triage'),
        const p([
          .text(
            'Click a score tier to view its grading criteria and actionable engineering triage steps:',
          ),
        ]),
        if (scoreTriageTiers.isNotEmpty)
          InteractiveDetailCard(
            title: scoreTriageTitle,
            description: scoreTriageDesc,
            classes: 'interactive-detail-card score-triage',
            tabs: scoreTriageTiers,
          ),

        storyH4('Human root-cause audits'),
        const p([
          .text(
            'When an evaluation task receives a low Result Score, human expert reviewers inspect the diagnostic process data:',
          ),
        ]),
        ul([
          for (final item in data.rootCauseAudits.items)
            li([
              strong([.text('${item.label}: ')]),
              .text(item.detail),
            ]),
        ]),
      ],
    );
  }

  Component _buildTransparencyChapter(FlutterBenchHarborExample harbor) {
    return StoryChapter(
      number: '07',
      title: 'Transparency & dataset integrity',
      anchorId: 'transparency-dataset-integrity',
      children: [
        const p([
          .text(
            'To prevent model training contamination, raw datasets and reference solutions cannot be open-sourced. '
            'However, the Flutter team maintains transparency by:',
          ),
        ]),
        const ul([
          li([
            .text(
              'Publishing the comprehensive evaluation methodology on this page.',
            ),
          ]),
          li([
            .text('Sharing task prompts and Critical User Journey (CUJ) lists.'),
          ]),
          li([
            .text('Publishing regular blog posts with analysis and insights.'),
          ]),
          li([
            .text(
              'Open-sourcing verification tooling that does not risk dataset compromise.',
            ),
          ]),
        ]),
        const p([
          .text(
            'To run benchmark tasks locally using the Harbor evaluation runner:',
          ),
        ]),
        div(classes: 'code-block-wrapper', [
          pre([
            code([
              .text(
                '# Run an individual trial with Harbor\n'
                'harbor run \\\n'
                '  --task ${harbor.task} \\\n'
                '  --agent ${harbor.agent} \\\n'
                '  --model ${harbor.model} \\\n'
                '  --mcp ${harbor.mcp}',
              ),
            ]),
          ]),
        ]),
        const p([
          .text(
            'This methodology will evolve as more data is gathered and analyzed. '
            'Expect updates and refinements in future blog posts and documentation.',
          ),
        ]),
        p([
          .text(
            'For questions or to contribute new CUJ evaluation tasks, visit the ',
          ),
          a(
            href: 'https://github.com/flutter/flutter',
            target: Target.blank,
            [.text('Flutter repository on GitHub')],
          ),
          .text('.'),
        ]),
      ],
    );
  }
}
