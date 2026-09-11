// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/flutterbench/task_model_heatmap.dart';
import '../../models/content/flutterbench_content.dart';
import '../../utils/data_utils.dart';
import 'flutterbench_nav.dart';

/// FlutterBench Tasks & CUJ Matrix explorer page.
///
/// Mounted by `/ai/flutterbench/tasks/index.md`.
class FlutterBenchTasksPage extends StatelessComponent {
  const FlutterBenchTasksPage({super.key});

  @override
  Component build(BuildContext context) {
    final job = context.decodeJsonObject(
      'data.flutterbench.job',
      FlutterBenchJobData.fromJson,
    );
    final tasksData = context.decodeJsonObject(
      'data.flutterbench.tasks',
      FlutterBenchTasksData.fromJson,
    );

    return main_(classes: 'bench-page tasks-page', [
      // Hero Header
      section(classes: 'bench-hero-header', [
        div(classes: 'bench-container', [
          div(classes: 'hero-badge-row', [
            const span(classes: 'hero-category-tag', [.text('TASK MATRIX')]),
            span(classes: 'job-id-tag', [
              .text('${tasksData.tasks.length} CUJs Evaluated'),
            ]),
          ]),
          const h1(classes: 'bench-hero-title', [.text('Task & CUJ Explorer')]),
          const p(classes: 'bench-hero-subtitle', [
            .text(
              'Explore cross-model performance across authentic Flutter and Dart developer workflows. '
              'Click any cell in the matrix to inspect the full trial execution, rubric, trajectory, and logs.',
            ),
          ]),

          // Sub-nav tabs
          const FlutterBenchNav(current: FlutterBenchNavItem.tasks),
        ]),
      ]),

      div(classes: 'bench-container content-area', [
        // Heatmap Matrix
        section(classes: 'bench-section', [
          const div(classes: 'section-title-row', [
            h2(classes: 'section-h2', [
              .text('Cross-Model Performance Heatmap'),
            ]),
            span(classes: 'section-note', [
              .text(
                'Color scaled by reward (Green ≥ 0.80, Yellow 0.50–0.79, Red < 0.50). Errored trials hatched in gray.',
              ),
            ]),
          ]),
          TaskModelHeatmap(
            tasks: tasksData.tasks,
            evals: job.evals,
          ),
        ]),

        // Task Cards Directory
        section(classes: 'bench-section', [
          const h2(classes: 'section-h2', [
            .text('Evaluated Critical User Journeys'),
          ]),
          const p(classes: 'section-intro-text', [
            .text(
              'Each task is grounded in realistic development workflows and includes automated grading suites:',
            ),
          ]),
          div(classes: 'tasks-cards-grid', [
            for (final task in tasksData.tasks)
              div(classes: 'task-card', [
                div(classes: 'task-card-header', [
                  span(classes: 'category-pill', [.text(task.category)]),
                  h3(classes: 'task-card-title', [
                    a(href: '/ai/flutterbench/tasks/${task.slug}', [
                      .text(task.displayName),
                    ]),
                  ]),
                ]),
                p(classes: 'task-card-description', [.text(task.description)]),
                div(classes: 'task-card-footer', [
                  span(classes: 'trial-count-sub', [
                    .text('${task.trials.length} trials recorded'),
                  ]),
                  a(
                    href: '/ai/flutterbench/tasks/${task.slug}',
                    classes: 'bench-btn-sm',
                    const [.text('View Task Details →')],
                  ),
                ]),
              ]),
          ]),
        ]),
      ]),
    ]);
  }
}
