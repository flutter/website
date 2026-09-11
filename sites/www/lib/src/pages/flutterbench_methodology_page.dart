// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/flutterbench/methodology_components.dart';

/// Full FlutterBench Methodology page mounted at `/ai/flutterbench/methodology`.
class FlutterBenchMethodologyPage extends StatelessComponent {
  const FlutterBenchMethodologyPage({super.key});

  @override
  Component build(BuildContext context) {
    // Load methodology data from content/data/flutterbench/methodology.json
    final data = context.page.data['data'] as Map<String, Object?>? ?? const {};
    final fbData = (data['flutterbench'] as Map<String, Object?>? ?? const {})['methodology']
            as Map<String, Object?>? ??
        const {};

    final cujExample = (fbData['cuj_example'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .toList();
    final taskSpecs = (fbData['task_specifications'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .toList();
    final dimensions = (fbData['dimensions'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .toList();
    final graderMatrixMap = fbData['grader_matrix'] as Map<String, Object?>? ?? const {};
    final graderMatrixTitle = graderMatrixMap['title'] as String? ?? 'Grader Matrix';
    final graderMatrixDesc = graderMatrixMap['description'] as String? ?? '';
    final graderFilters = (graderMatrixMap['filters'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .toList();
    final graders = (graderMatrixMap['graders'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .toList();

    final reliabilityMap = fbData['reliability'] as Map<String, Object?>? ?? const {};
    final reliabilityCards = (reliabilityMap['cards'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .toList();

    final scoreTriageMap = fbData['score_triage'] as Map<String, Object?>? ?? const {};
    final scoreTriageTitle = scoreTriageMap['title'] as String? ?? 'Score Triage & Action Matrix';
    final scoreTriageDesc = scoreTriageMap['description'] as String? ?? '';
    final scoreTriageTiers = (scoreTriageMap['tiers'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .map((tier) => <String, Object?>{
              'id': tier['id'],
              'primary_label': tier['score'],
              'secondary_label': tier['name'],
              'heading': tier['heading'],
              'badge': tier['badge'],
              'variant': tier['id'],
              'overview': tier['criteria'],
              'items_label': tier['actions_label'],
              'items': tier['actions'],
            })
        .toList();

    final evalMatrixMap = fbData['evaluation_matrix'] as Map<String, Object?>? ?? const {};
    final evalMatrixTitle = evalMatrixMap['title'] as String? ?? '4-Axis Evaluation Matrix';
    final evalMatrixDesc = evalMatrixMap['description'] as String? ?? '';
    final evalMatrixAxes = (evalMatrixMap['axes'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .map((axis) => <String, Object?>{
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
            })
        .toList();

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
          ]),
        ]),
      ]),

      div(classes: 'bench-container content-area methodology-content', [
        // Overview Section
        const section(classes: 'bench-section', [
          div(classes: 'section-title-row', [
            h2(classes: 'section-h2', [.text('Overview')]),
          ]),
          p(classes: 'methodology-lead', [
            .text(
              'FlutterBench is our evaluation framework designed to measure how AI coding '
              'agents perform within the Dart and Flutter ecosystem. The evaluation system consists of four core components:',
            ),
          ]),
          div(classes: 'table-wrapper', [
            table(classes: 'bench-table methodology-table', [
              thead([
                tr([
                  th([.text('Component')]),
                  th([.text('Description')]),
                ]),
              ]),
              tbody([
                tr([
                  td([strong([.text('Dataset')])]),
                  td([.text('Real-world development tasks derived from critical user journeys (CUJs).')]),
                ]),
                tr([
                  td([strong([.text('Test matrix')])]),
                  td([.text('Multidimensional testing framework across models, agents, tooling configurations, and SDK versions.')]),
                ]),
                tr([
                  td([strong([.text('Scoring system')])]),
                  td([.text('Unified grading approach evaluating functional outcomes, code quality, and developer experience, paired with diagnostic telemetry.')]),
                ]),
                tr([
                  td([strong([.text('Harness')])]),
                  td([.text('Containerized automation infrastructure that executes evaluations at scale.')]),
                ]),
              ]),
            ]),
          ]),
        ]),

        // Dataset & Tasks Section
        section(classes: 'bench-section', [
          const div(classes: 'section-title-row', [
            h2(classes: 'section-h2', [.text('Dataset & Tasks')]),
          ]),
          const h3([.text('Task Derivation')]),
          const p([
            .text(
              'Evaluation tasks derive directly from Flutter\'s canonical Critical User Journeys (CUJs), '
              'which are the core workflows that developers perform regularly. This approach ensures evaluations '
              'reflect real-world developer needs rather than synthetic algorithm puzzles.',
            ),
          ]),
          const p([
            .text('Each CUJ represents a combination of:'),
          ]),
          const ul([
            li([.text('A Flutter developer persona (e.g., app developer, plugin developer, full-stack developer)')]),
            li([.text('A high-level goal')]),
            li([.text('The specific sequential steps required to achieve that goal')]),
          ]),

          if (cujExample.isNotEmpty) CujDiagram(sections: cujExample),

          const div(classes: 'methodology-note-box', [
            p([
              strong([.text('Dataset Integrity Note: ')]),
              .text(
                'To prevent dataset contamination in frontier model pre-training corpora, raw evaluation tasks and '
                'reference solutions remain private. However, canonical CUJ definitions and representative example '
                'structures are shared openly.',
              ),
            ]),
          ]),

          const p([
            .text(
              'These CUJs are converted into Harbor tasks. Harbor is the containerized automation framework '
              'used to run sandboxed evaluations. Our most ambitious evaluations combine multiple Harbor tasks, '
              'covering multiple CUJs end-to-end.',
            ),
          ]),

          const h3([.text('Task Specifications')]),
          if (taskSpecs.isNotEmpty) TaskSpecifications(specs: taskSpecs),
        ]),

        // Evaluation Test Matrix Section
        section(classes: 'bench-section', [
          const div(classes: 'section-title-row', [
            h2(classes: 'section-h2', [.text('Evaluation Test Matrix')]),
          ]),
          if (evalMatrixAxes.isNotEmpty)
            InteractiveDetailCard(
              title: evalMatrixTitle,
              description: evalMatrixDesc,
              classes: 'interactive-detail-card evaluation-matrix-card',
              tabs: evalMatrixAxes,
            ),
        ]),

        // Scoring Architecture Section
        section(classes: 'bench-section', [
          const div(classes: 'section-title-row', [
            h2(classes: 'section-h2', [.text('Scoring Architecture')]),
          ]),
          const h3([.text('Scoring Philosophy')]),
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

          const h3([.text('Three Core Evaluation Dimensions')]),
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

          if (dimensions.isNotEmpty) ThreeDimensionsCards(dimensions: dimensions),

          const h3([.text('Grader Matrix')]),
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

          const h3([.text('Grader Implementation Tiers')]),
          const div(classes: 'table-wrapper', [
            table(classes: 'bench-table methodology-table', [
              thead([
                tr([
                  th([.text('Tier')]),
                  th([.text('Grader Type')]),
                  th([.text('Evaluation Role')]),
                ]),
              ]),
              tbody([
                tr([
                  td([strong([.text('Code-based')])]),
                  td([.text('Compilers, test runners, dart analyze, DCM, structural checkers')]),
                  td([.text('Deterministic, unambiguous source of truth for syntax, compilation, and functional test assertions.')]),
                ]),
                tr([
                  td([strong([.text('LLM judge (BINEVAL)')])]),
                  td([.text('Frontier model rubric evaluation')]),
                  td([.text('Evaluates qualitative dimensions (visual UI, idiomatic review, trajectory, recovery) using binary yes/no questions.')]),
                ]),
                tr([
                  td([strong([.text('Human audit')])]),
                  td([.text('Flutter engineer manual review')]),
                  td([.text('Ground truth calibration, failure root-cause analysis, and conflict resolution.')]),
                ]),
              ]),
            ]),
          ]),

          const h3([.text('Diagnostic Telemetry (Excluded from Result Score)')]),
          const p([
            .text(
              'To avoid penalizing capability scores on complex tasks that naturally require more reasoning steps or tokens, '
              'FlutterBench tracks diagnostic telemetry separately from the Result Score:',
            ),
          ]),
          const div(classes: 'table-wrapper', [
            table(classes: 'bench-table methodology-table', [
              thead([
                tr([
                  th([.text('Metric')]),
                  th([.text('Measurement Target')]),
                ]),
              ]),
              tbody([
                tr([
                  td([strong([.text('Token usage')])]),
                  td([.text('Tracks total input, cache, and output tokens consumed to measure efficiency deltas and verify token reductions from skill optimizations.')]),
                ]),
                tr([
                  td([strong([.text('Expected tool calls')])]),
                  td([.text('Compares actual tool invocations against expected tools. If an agent succeeds without using an expected tool, it is not penalized; this telemetry helps evaluate whether the tool is necessary for that user journey.')]),
                ]),
              ]),
            ]),
          ]),
        ]),

        // Reliability & Triage Section
        section(classes: 'bench-section', [
          const div(classes: 'section-title-row', [
            h2(classes: 'section-h2', [.text('Reliability & Triage')]),
          ]),
          const h3([.text('Multi-Run Reliability Metrics')]),
          const p([
            .text(
              'Single-run trials only sample luck. True agent trust requires measuring multi-trial stability across repeated runs:',
            ),
          ]),
          if (reliabilityCards.isNotEmpty) ReliabilityCards(cards: reliabilityCards),

          const h3([.text('Score Interpretation & Triage')]),
          const p([
            .text('Click a score tier to view its grading criteria and actionable engineering triage steps:'),
          ]),
          if (scoreTriageTiers.isNotEmpty)
            InteractiveDetailCard(
              title: scoreTriageTitle,
              description: scoreTriageDesc,
              classes: 'interactive-detail-card score-triage',
              tabs: scoreTriageTiers,
            ),

          const h3([.text('Human Root-Cause Audits')]),
          const p([
            .text('When an evaluation task receives a low Result Score, human expert reviewers inspect the diagnostic process data:'),
          ]),
          const ul([
            li([
              strong([.text('Reasoning trace review: ')]),
              .text('Inspect the agent\'s internal thoughts to identify where misunderstandings of Dart/Flutter APIs occurred.'),
            ]),
            li([
              strong([.text('Plan adherence audit: ')]),
              .text('Check whether the agent derailed due to ambiguous task prompts or missing context.'),
            ]),
            li([
              strong([.text('Harness diagnostics: ')]),
              .text('Audit error messages returned to the agent during failed compile/test steps to see why recovery failed.'),
            ]),
          ]),
        ]),

        // Transparency & Reproducibility Section
        const section(classes: 'bench-section', [
          div(classes: 'section-title-row', [
            h2(classes: 'section-h2', [.text('Transparency & Reproducibility')]),
          ]),
          p([
            .text(
              'To prevent model training contamination, raw datasets and reference solutions cannot be open-sourced. '
              'However, the Flutter team maintains transparency by:',
            ),
          ]),
          ul([
            li([.text('Publishing the comprehensive evaluation methodology on this page.')]),
            li([.text('Sharing task prompts and Critical User Journey (CUJ) lists.')]),
            li([.text('Publishing regular benchmark updates, analyses, and engineering insights.')]),
            li([.text('Open-sourcing verification tooling that does not risk dataset compromise.')]),
          ]),
          p([
            .text('To run benchmark tasks locally using the Harbor evaluation runner:'),
          ]),
          div(classes: 'code-block-wrapper', [
            pre([
              code([
                .text(
                  '# Run an individual trial with Harbor\n'
                  'harbor run \\\n'
                  '  --task dataset/flutter/manage-state-with-bloc \\\n'
                  '  --agent antigravity-sdk \\\n'
                  '  --model google/gemini-3.5-flash \\\n'
                  '  --mcp dart',
                ),
              ]),
            ]),
          ]),
          p([
            .text('For questions or to contribute new CUJ evaluation tasks, visit the '),
            a(
              href: 'https://github.com/flutter/flutter',
              target: Target.blank,
              [.text('Flutter repository on GitHub')],
            ),
            .text('.'),
          ]),
        ]),
      ]),
    ]);
  }
}
