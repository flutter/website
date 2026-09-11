// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/flutterbench/trial_detail_view.dart';
import '../../models/content/flutterbench_content.dart';
import '../../utils/data_utils.dart';

/// Single trial detail page showing verifier scoring, trajectory, artifacts, and logs.
///
/// Mounted by `/ai/flutterbench/trials/<trial_name>.md`.
class FlutterBenchTrialDetailPage extends StatelessComponent {
  const FlutterBenchTrialDetailPage({required this.trialName, super.key});

  factory FlutterBenchTrialDetailPage.fromAttrs(Map<String, Object?> attrs) {
    return FlutterBenchTrialDetailPage(trialName: attrs['trial'] as String);
  }

  final String trialName;

  @override
  Component build(BuildContext context) {
    final trialsData = context.decodeJsonObject(
      'data.flutterbench.trials',
      FlutterBenchTrialsData.fromJson,
    );

    final trial = trialsData.trials.firstWhere(
      (t) => t.trialName == trialName,
      orElse: () => trialsData.trials.first,
    );

    return main_(classes: 'bench-page trial-detail-page', [
      div(classes: 'bench-container content-area', [
        TrialDetailView(trial: trial),
        div(classes: 'bench-bottom-nav', [
          a(
            href: '/ai/flutterbench/tasks/${trial.taskSlug}',
            classes: 'btn quiet',
            [
              .text('← Back to ${trial.taskSlug} Task'),
            ],
          ),
          const a(href: '/ai/flutterbench/tasks', classes: 'btn quiet', [
            .text('← Back to Tasks Matrix'),
          ]),
          const a(href: '/ai/flutterbench', classes: 'btn quiet', [
            .text('← Back to Leaderboard'),
          ]),
        ]),
      ]),
    ]);
  }
}
