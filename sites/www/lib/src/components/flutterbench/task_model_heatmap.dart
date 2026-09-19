// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/content/flutterbench_content.dart';
import 'error_state_badge.dart';
import 'model_name_formatter.dart';

/// Heatmap matrix component mapping Tasks (rows) vs Models/Configurations (columns).
///
/// Cells are color-coded based on normalized reward (0.0 to 1.0).
/// Errored trials are displayed with a distinct hatched/gray treatment and never as 0.
class TaskModelHeatmap extends StatelessComponent {
  const TaskModelHeatmap({
    required this.tasks,
    required this.evals,
    super.key,
  });

  final List<FlutterBenchTaskItem> tasks;
  final List<FlutterBenchEvalItem> evals;

  @override
  Component build(BuildContext context) {
    return div(classes: 'bench-heatmap-container', [
      div(classes: 'bench-table-wrapper heatmap-scroll', [
        table(classes: 'bench-heatmap-table', [
          thead([
            tr([
              const th(classes: 'col-task-header', [
                .text('Critical User Journey (CUJ)'),
              ]),
              const th(classes: 'col-category-header', [.text('Category')]),
              for (final eval in evals)
                th(classes: 'col-model-header', [
                  div(classes: 'model-header-content', [
                    span(classes: 'model-name-title', [
                      .text(formatModelName(eval.modelShortName)),
                    ]),
                    span(classes: 'agent-tag', [.text(eval.agentName)]),
                    if (eval.hasDartTooling)
                      const span(classes: 'tooling-icon-badge', [
                        span(classes: 'tooling-dot', []),
                        .text('Tools'),
                      ]),
                  ]),
                ]),
            ]),
          ]),
          tbody([
            for (final task in tasks)
              tr(classes: 'heatmap-task-row', [
                td(classes: 'col-task-name', [
                  a(
                    href: '/ai/flutterbench/tasks/${task.slug}',
                    classes: 'task-title-link',
                    [.text(task.displayName)],
                  ),
                ]),
                td(classes: 'col-task-category', [
                  span(classes: 'category-pill', [.text(task.category)]),
                ]),
                for (final eval in evals) _buildCell(task, eval),
              ]),
          ]),
        ]),
      ]),

      // Below the grid: Best & Worst CUJs summary per model
      div(classes: 'bench-cuj-model-summaries', [
        const h3(classes: 'summaries-title', [
          .text('Model Strengths & Weaknesses Across CUJs'),
        ]),
        div(classes: 'summaries-grid', [
          for (final eval in evals)
            div(classes: 'model-summary-card', [
              div(classes: 'card-header', [
                h4(
                  classes: 'model-title',
                  [.text(formatModelName(eval.modelShortName))],
                ),
                span(classes: 'agent-subtitle', [.text(eval.agentName)]),
              ]),
              div(classes: 'card-body', [
                div(classes: 'cuj-list-group', [
                  const span(classes: 'group-label text-success', [
                    .text('Strongest CUJs:'),
                  ]),
                  if (eval.bestCujs.isEmpty)
                    const p(classes: 'text-muted sm', [
                      .text('No high-scoring tasks.'),
                    ])
                  else
                    ul(classes: 'cuj-bullet-list', [
                      for (final cuj in eval.bestCujs)
                        li([
                          a(href: '/ai/flutterbench/tasks/${cuj.taskSlug}', [
                            .text(cuj.taskName),
                          ]),
                          span(classes: 'cuj-score score-high', [
                            .text(' (${(cuj.reward ?? 0).toStringAsFixed(2)})'),
                          ]),
                        ]),
                    ]),
                ]),
                div(classes: 'cuj-list-group', [
                  const span(classes: 'group-label text-danger', [
                    .text('Growth Areas / Weaknesses:'),
                  ]),
                  if (eval.worstCujs.isEmpty)
                    const p(classes: 'text-muted sm', [.text('None recorded.')])
                  else
                    ul(classes: 'cuj-bullet-list', [
                      for (final cuj in eval.worstCujs)
                        li([
                          a(href: '/ai/flutterbench/tasks/${cuj.taskSlug}', [
                            .text(cuj.taskName),
                          ]),
                          if (cuj.status == 'error')
                            const span(classes: 'cuj-score score-error', [
                              .text(' (Error)'),
                            ])
                          else
                            span(classes: 'cuj-score score-low', [
                              .text(
                                ' (${(cuj.reward ?? 0).toStringAsFixed(2)})',
                              ),
                            ]),
                        ]),
                    ]),
                ]),
              ]),
            ]),
        ]),
      ]),
    ]);
  }

  Component _buildCell(FlutterBenchTaskItem task, FlutterBenchEvalItem eval) {
    final scoreEntry = task.scoresByEval[eval.evalKey] as Map<String, Object?>?;

    if (scoreEntry == null) {
      return const td(classes: 'heatmap-cell cell-empty', [
        span(classes: 'text-muted', [.text('—')]),
      ]);
    }

    final trialName = scoreEntry['trial_name'] as String? ?? '';
    final status = scoreEntry['status'] as String? ?? '';
    final reward = (scoreEntry['reward'] as num?)?.toDouble();
    final exceptionType = scoreEntry['exception_type'] as String?;

    if (status == 'error' || exceptionType != null) {
      return td(
        classes: 'heatmap-cell cell-error',
        attributes: {
          'title':
              'Error during trial: ${exceptionType ?? 'Exception'} (Excluded from averages)',
        },
        [
          a(
            href: '/ai/flutterbench/trials/$trialName',
            classes: 'cell-link error-link',
            [
              ErrorStateBadge(
                exceptionType: exceptionType ?? 'Error',
                compact: true,
              ),
            ],
          ),
        ],
      );
    }

    final score = reward ?? 0.0;
    final colorClass = score >= 0.80
        ? 'score-high'
        : score >= 0.50
        ? 'score-mid'
        : 'score-low';

    return td(
      classes: 'heatmap-cell cell-scored $colorClass',
      attributes: {
        'title':
            'Reward: ${score.toStringAsFixed(2)} for ${task.displayName} (${formatModelName(eval.modelShortName)})',
      },
      [
        a(
          href: '/ai/flutterbench/trials/$trialName',
          classes: 'cell-link',
          [
            span(classes: 'cell-score-value', [
              .text(score.toStringAsFixed(2)),
            ]),
          ],
        ),
      ],
    );
  }
}
