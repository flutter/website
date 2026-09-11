// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/flutterbench/error_state_badge.dart';
import '../models/content/flutterbench_content.dart';
import '../utils/data_utils.dart';

/// Single task / CUJ detail page showing cross-model results.
///
/// Mounted by `/ai/flutterbench/tasks/<task-slug>.md`.
class FlutterBenchTaskDetailPage extends StatelessComponent {
  const FlutterBenchTaskDetailPage({required this.taskSlug, super.key});

  factory FlutterBenchTaskDetailPage.fromAttrs(Map<String, Object?> attrs) {
    return FlutterBenchTaskDetailPage(taskSlug: attrs['task'] as String);
  }

  final String taskSlug;

  @override
  Component build(BuildContext context) {
    final tasksData = context.decodeJsonObject(
      'data.flutterbench.tasks',
      FlutterBenchTasksData.fromJson,
    );

    final task = tasksData.tasks.firstWhere(
      (t) => t.slug == taskSlug,
      orElse: () => tasksData.tasks.first,
    );

    return main_(classes: 'bench-page task-detail-page', [
      div(classes: 'bench-container content-area', [
        // Breadcrumbs
        div(classes: 'bench-breadcrumbs', [
          const a(href: '/ai', [.text('AI')]),
          const span(classes: 'breadcrumb-sep', [.text(' / ')]),
          const a(href: '/ai/flutterbench', [.text('FlutterBench')]),
          const span(classes: 'breadcrumb-sep', [.text(' / ')]),
          const a(href: '/ai/flutterbench/tasks', [.text('Tasks')]),
          const span(classes: 'breadcrumb-sep', [.text(' / ')]),
          span(classes: 'current-page', [.text(task.displayName)]),
        ]),

        // Task Header Card
        section(classes: 'bench-card task-info-card', [
          div(classes: 'task-header-row', [
            div(classes: 'task-title-area', [
              span(classes: 'category-pill', [.text(task.category)]),
              h1(classes: 'task-page-title', [.text(task.displayName)]),
              span(classes: 'task-repo-identifier', [
                .text('ID: ${task.taskName}'),
              ]),
            ]),
          ]),
          p(classes: 'task-description-lead', [.text(task.description)]),
        ]),

        // Cross-model trials comparison table
        section(classes: 'bench-section', [
          const h2(classes: 'section-h2', [
            .text('Cross-Model Benchmark Trials'),
          ]),
          const p(classes: 'section-intro-text', [
            .text('Comparison of agent configurations evaluated on this task:'),
          ]),

          div(classes: 'bench-table-wrapper', [
            table(classes: 'bench-table', [
              const thead([
                tr([
                  th([.text('Model & Harness')]),
                  th([.text('Tooling')]),
                  th([.text('Status')]),
                  th([.text('Composite Reward')]),
                  th([.text('Actions')]),
                ]),
              ]),
              tbody([
                for (final trial in task.trials)
                  tr(classes: 'task-trial-row', [
                    td([
                      div(classes: 'trial-model-cell', [
                        span(classes: 'model-name-bold', [
                          .text(trial.modelShortName),
                        ]),
                        span(classes: 'agent-sub', [.text(trial.agentName)]),
                      ]),
                    ]),
                    td([
                      if (trial.hasDartTooling)
                        const span(classes: 'tooling-pill', [
                          .text('Dart MCP + Skills'),
                        ])
                      else
                        const span(classes: 'tooling-pill uninstrumented', [
                          .text('Baseline'),
                        ]),
                    ]),
                    td([
                      if (trial.status == 'error')
                        ErrorStateBadge(
                          exceptionType: trial.exceptionType ?? 'Error',
                          compact: true,
                        )
                      else
                        span(
                          classes: [
                            'trial-status-badge',
                            if (trial.status == 'pass')
                              'status-pass'
                            else if (trial.status == 'partial')
                              'status-partial'
                            else
                              'status-fail',
                          ].join(' '),
                          [.text(trial.status.toUpperCase())],
                        ),
                    ]),
                    td([
                      if (trial.reward != null)
                        span(
                          classes: [
                            'reward-main-score',
                            if (trial.reward! >= 0.8)
                              'score-high'
                            else if (trial.reward! >= 0.5)
                              'score-mid'
                            else
                              'score-low',
                          ].join(' '),
                          [.text(trial.reward!.toStringAsFixed(2))],
                        )
                      else
                        const span(classes: 'text-muted', [
                          .text('— (Errored)'),
                        ]),
                    ]),
                    td([
                      a(
                        href: '/ai/flutterbench/trials/${trial.trialName}',
                        classes: 'bench-btn-outline',
                        const [.text('Inspect Trial Details →')],
                      ),
                    ]),
                  ]),
              ]),
            ]),
          ]),
        ]),

        // Back link navigation
        const div(classes: 'bench-bottom-nav', [
          a(href: '/ai/flutterbench/tasks', classes: 'btn quiet', [
            .text('← Back to Task Matrix'),
          ]),
          a(href: '/ai/flutterbench', classes: 'btn quiet', [
            .text('← Back to Leaderboard'),
          ]),
        ]),
      ]),
    ]);
  }
}
