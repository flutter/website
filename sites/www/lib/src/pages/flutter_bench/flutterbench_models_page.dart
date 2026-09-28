// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/flutterbench/benchmark_scores.dart';
import '../../components/flutterbench/models_explorer.dart';
import '../../models/content/flutterbench_content.dart';
import '../../utils/data_utils.dart';
import 'flutterbench_nav.dart';

/// FlutterBench model directory page.
///
/// Mounted by `/ai/flutterbench/models/index.md`.
class FlutterBenchModelsPage extends StatelessComponent {
  const FlutterBenchModelsPage({super.key});

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
    final trialsData = context.decodeJsonObject(
      'data.flutterbench.trials',
      FlutterBenchTrialsData.fromJson,
    );

    final benchmarks = buildBenchmarkRows(
      tasks: tasksData,
      trials: trialsData,
    );

    return main_(classes: 'bench-page models-page', [
      section(classes: 'bench-hero-header', [
        div(classes: 'bench-container', [
          div(classes: 'hero-badge-row', [
            const span(classes: 'hero-category-tag', [.text('MODELS')]),
            span(classes: 'job-id-tag', [
              .text('${job.evals.length} configurations evaluated'),
            ]),
          ]),
          const h1(classes: 'bench-hero-title', [.text('Model Directory')]),
          const p(classes: 'bench-hero-subtitle', [
            .text(
              'Every agent and model configuration FlutterBench has evaluated, '
              'with its full accuracy, cost, and latency profile across each '
              'Critical User Journey.',
            ),
          ]),
          const FlutterBenchNav(current: FlutterBenchNavItem.models),
        ]),
      ]),

      div(classes: 'bench-container content-area', [
        ModelsExplorer(
          evals: [for (final eval in job.evals) eval.toMap()],
          benchmarks: benchmarkRowsToMaps(benchmarks),
        ),
      ]),
    ]);
  }
}
