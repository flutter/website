// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/flutterbench/leaderboard_table.dart';
import '../../models/content/flutterbench_content.dart';
import '../../utils/data_utils.dart';

/// FlutterBench Overview & Leaderboard page component.
///
/// Mounted by `/ai/flutterbench/index.md`.
class FlutterBenchLeaderboardPage extends StatelessComponent {
  const FlutterBenchLeaderboardPage({super.key});

  @override
  Component build(BuildContext context) {
    final job = context.decodeJsonObject(
      'data.flutterbench.job',
      FlutterBenchJobData.fromJson,
    );

    // Convert evals to serializable maps for the client-hydrated LeaderboardTable
    final evalsMaps = job.evals.map((e) => e.toMap()).toList();

    return main_(classes: 'bench-page leaderboard-page', [
      // Hero Header
      section(classes: 'bench-hero-header', [
        div(classes: 'bench-container', [
          div(classes: 'hero-badge-row', [
            const span(classes: 'hero-category-tag', [.text('AI BENCHMARK')]),
            span(classes: 'job-id-tag', [
              .text('Job: ${job.id.substring(0, 8)}'),
            ]),
          ]),
          const h1(classes: 'bench-hero-title', [
            .text('FlutterBench Leaderboard'),
          ]),
          const p(classes: 'bench-hero-subtitle', [
            .text(
              'Evaluating how autonomous AI coding agents perform on real-world Dart and Flutter tasks. '
              'Scores reflect composite functional correctness, code quality, and developer experience.',
            ),
          ]),

          // Sub-nav tabs
          const nav(classes: 'bench-tab-nav', [
            a(href: '/ai/flutterbench', classes: 'bench-nav-link active', [
              .text('Leaderboard'),
            ]),
            a(href: '/ai/flutterbench/tasks', classes: 'bench-nav-link', [
              .text('Tasks & CUJs'),
            ]),
            a(href: '/ai/flutterbench/methodology', classes: 'bench-nav-link', [
              .text('Methodology'),
            ]),
            a(href: '/ai/flutterbench/cujs', classes: 'bench-nav-link', [
              .text('CUJs'),
            ]),
          ]),
        ]),
      ]),

      div(classes: 'bench-container content-area', [
        // Leaderboard Table with interactive filter bar
        section(classes: 'bench-section', [
          const div(classes: 'section-title-row', [
            h2(classes: 'section-h2', [.text('Model Rankings')]),
            span(classes: 'section-note', [
              .text(
                'Sorted by mean reward descending. Click any column header to reorder.',
              ),
            ]),
          ]),
          LeaderboardTable(evals: evalsMaps),
        ]),

        // Methodology highlight card
        const section(classes: 'bench-section methodology-callout', [
          div(classes: 'callout-card', [
            div(classes: 'callout-text', [
              h3([.text('How are agents evaluated?')]),
              p([
                .text(
                  'Every FlutterBench trial runs in an isolated Docker container testing real Flutter features. '
                  'Scoring measures 60% Outcome (passing tests & builds), 30% Quality (idiomatic patterns & analyzer diagnostics), '
                  'and 10% Developer Experience (tool accuracy & minimal friction). Diagnostic metrics like token efficiency are captured separately.',
                ),
              ]),
            ]),
            div(classes: 'callout-action', [
              a(href: '/ai/flutterbench/methodology', classes: 'btn', [
                .text('Read Methodology →'),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}
