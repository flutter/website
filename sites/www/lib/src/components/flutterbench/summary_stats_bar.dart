// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/content/flutterbench_content.dart';
import 'error_state_badge.dart';
import 'model_name_formatter.dart';

/// Row of summary metric cards displayed above the fold on the leaderboard.
class SummaryStatsBar extends StatelessComponent {
  const SummaryStatsBar({required this.job, super.key});

  final FlutterBenchJobData job;

  @override
  Component build(BuildContext context) {
    final topModelRewardFormatted = (job.topModelReward * 100).toStringAsFixed(
      0,
    );
    final overallAvgFormatted = (job.overallAverageReward * 100)
        .toStringAsFixed(0);

    return div(classes: 'bench-stats-bar-container', [
      div(classes: 'bench-stats-grid', [
        // Card 1: Top Model
        div(classes: 'bench-stat-card card-primary', [
          const div(classes: 'stat-header', [
            span(classes: 'stat-label', [.text('Top Model')]),
            span(classes: 'stat-badge badge-blue', [.text('Leader')]),
          ]),
          div(classes: 'stat-value', [
            .text(formatModelName(job.topModelName)),
          ]),
          div(classes: 'stat-meta', [
            span(classes: 'meta-highlight', [
              .text('$topModelRewardFormatted%'),
            ]),
            const span(classes: 'meta-description', [
              .text(' mean reward across benchmark'),
            ]),
          ]),
        ]),

        // Card 2: Overall Average Reward
        div(classes: 'bench-stat-card', [
          const div(classes: 'stat-header', [
            span(classes: 'stat-label', [.text('Benchmark Average')]),
            span(classes: 'stat-badge badge-neutral', [.text('All Models')]),
          ]),
          div(classes: 'stat-value', [
            .text('$overallAvgFormatted%'),
          ]),
          const div(classes: 'stat-meta', [
            span(classes: 'meta-description', [
              .text('Mean composite reward across completed trials'),
            ]),
          ]),
        ]),

        // Card 3: Trials Completed
        div(classes: 'bench-stat-card', [
          const div(classes: 'stat-header', [
            span(classes: 'stat-label', [.text('Trials Run')]),
            span(classes: 'stat-badge badge-green', [.text('Active Matrix')]),
          ]),
          div(classes: 'stat-value', [
            .text('${job.nTotalTrials}'),
          ]),
          div(classes: 'stat-meta', [
            span(classes: 'meta-description', [
              .text('${job.nCompletedTrials} evaluated in latest run'),
            ]),
          ]),
        ]),

        // Card 4: Trials Errored
        div(classes: 'bench-stat-card card-warning', [
          const div(classes: 'stat-header', [
            span(classes: 'stat-label', [.text('Execution Errors')]),
          ]),
          div(classes: 'stat-value error-value', [
            if (job.nErroredTrials > 0)
              ErrorStateBadge(
                exceptionType: '${job.nErroredTrials} Errored',
                message: 'Errors are tracked separately and excluded from mean reward calculations',
              )
            else
              const span(classes: 'text-success', [.text('0')]),
          ]),
          const div(classes: 'stat-meta', [
            span(classes: 'meta-description', [
              .text('Excluded from average scores (not treated as 0)'),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}
