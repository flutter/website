// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/content/flutterbench_content.dart';
import 'error_state_badge.dart';
import 'model_name_formatter.dart';

/// Comprehensive detail view for a single FlutterBench trial.
class TrialDetailView extends StatelessComponent {
  const TrialDetailView({required this.trial, super.key});

  final FlutterBenchTrialDetail trial;

  @override
  Component build(BuildContext context) {
    return div(classes: 'bench-trial-detail-container', [
      // Navigation breadcrumbs
      div(classes: 'bench-breadcrumbs', [
        const a(href: '/ai', [.text('AI')]),
        const span(classes: 'breadcrumb-sep', [.text(' / ')]),
        const a(href: '/ai/flutterbench', [.text('FlutterBench')]),
        const span(classes: 'breadcrumb-sep', [.text(' / ')]),
        const a(href: '/ai/flutterbench/tasks', [.text('Tasks')]),
        const span(classes: 'breadcrumb-sep', [.text(' / ')]),
        a(href: '/ai/flutterbench/tasks/${trial.taskSlug}', [
          .text(trial.taskSlug),
        ]),
        const span(classes: 'breadcrumb-sep', [.text(' / ')]),
        span(classes: 'current-page', [.text(trial.trialName)]),
      ]),

      // 1. Summary Hero Section
      _buildSummarySection(),

      // 2. Reward Breakdown Tree
      _buildRewardBreakdownSection(),

      // 3. Trajectory Section (if present)
      if (trial.trajectory != null && trial.trajectory!.isNotEmpty)
        _buildTrajectorySection(),

      // 4. Artifacts Code Viewer (if present)
      if (trial.artifacts.isNotEmpty) _buildArtifactsSection(),

      // 5. Raw Logs Section
      _buildLogsSection(),
    ]);
  }

  Component _buildSummarySection() {
    final isError = trial.status == 'error';
    final reward = trial.reward;

    return section(classes: 'bench-card trial-summary-card', [
      div(classes: 'summary-top-row', [
        div(classes: 'task-title-group', [
          const span(classes: 'sub-tag', [.text('Trial Evaluation')]),
          h1(classes: 'trial-title', [.text(trial.trialName)]),
          div(classes: 'task-link-row', [
            const span(classes: 'task-label', [.text('Task: ')]),
            a(
              href: '/ai/flutterbench/tasks/${trial.taskSlug}',
              classes: 'task-anchor',
              [.text(trial.taskName)],
            ),
          ]),
        ]),
        div(classes: 'status-badge-container', [
          if (isError)
            ErrorStateBadge(
              exceptionType: trial.exceptionType ?? 'Trial Error',
              message: trial.exceptionMessage,
            )
          else ...[
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
            if (reward != null)
              div(classes: 'hero-score-badge', [
                span(classes: 'score-num', [
                  .text((reward * 100).toStringAsFixed(0)),
                ]),
                const span(classes: 'score-pct', [.text('%')]),
                const span(classes: 'score-caption', [
                  .text('Composite Reward'),
                ]),
              ]),
          ],
        ]),
      ]),

      const div(classes: 'meta-divider', []),

      // Metadata grid
      div(classes: 'trial-meta-grid', [
        div(classes: 'meta-col', [
          const span(classes: 'meta-label', [.text('Model')]),
          span(
            classes: 'meta-val bold',
            [.text(formatModelName(trial.modelShortName))],
          ),
          span(classes: 'meta-sub', [.text(trial.provider)]),
        ]),
        div(classes: 'meta-col', [
          const span(classes: 'meta-label', [.text('Agent Harness')]),
          span(classes: 'meta-val', [.text(trial.agentName)]),
          if (trial.hasDartTooling)
            const span(classes: 'tooling-pill', [.text('Dart MCP + Skills')])
          else
            const span(classes: 'tooling-pill uninstrumented', [
              .text('Standard Baseline'),
            ]),
        ]),
        div(classes: 'meta-col', [
          const span(classes: 'meta-label', [.text('Tokens')]),
          span(classes: 'meta-val', [
            .text(_formatTokens(trial.inputTokens + trial.outputTokens)),
          ]),
          span(classes: 'meta-sub', [
            .text(
              '${_formatTokens(trial.inputTokens)} in / ${_formatTokens(trial.outputTokens)} out',
            ),
          ]),
        ]),
        div(classes: 'meta-col', [
          const span(classes: 'meta-label', [.text('Cost')]),
          span(classes: 'meta-val', [
            .text(
              trial.costUsd > 0 ? '\$${trial.costUsd.toStringAsFixed(4)}' : '—',
            ),
          ]),
          const span(classes: 'meta-sub', [.text('USD estimated')]),
        ]),
      ]),

      // Phase durations timeline
      if (trial.durations.isNotEmpty) ...[
        const div(classes: 'meta-divider', []),
        div(classes: 'phase-durations-section', [
          const span(classes: 'phase-title', [
            .text('Execution Phase Durations'),
          ]),
          div(classes: 'phase-bars-row', [
            _buildPhaseBar(
              'Environment Setup',
              trial.durations['environment_setup'],
            ),
            _buildPhaseBar('Agent Setup', trial.durations['agent_setup']),
            _buildPhaseBar(
              'Agent Execution',
              trial.durations['agent_execution'],
            ),
            _buildPhaseBar('Verifier', trial.durations['verifier']),
          ]),
        ]),
      ],
    ]);
  }

  Component _buildPhaseBar(String label, double? seconds) {
    if (seconds == null) return const div([]);
    final formattedSec = seconds >= 60
        ? '${(seconds / 60).toStringAsFixed(1)}m'
        : '${seconds.toStringAsFixed(1)}s';

    return div(classes: 'phase-pill', [
      span(classes: 'phase-label', [.text(label)]),
      span(classes: 'phase-time', [.text(formattedSec)]),
    ]);
  }

  Component _buildRewardBreakdownSection() {
    final rewardTree = trial.rewardTree;
    if (rewardTree == null) {
      if (trial.status == 'error') {
        return section(classes: 'bench-card error-card-section', [
          const h2(classes: 'section-heading', [.text('Execution Failure')]),
          div(classes: 'error-callout', [
            const span(classes: 'callout-icon', [.text('⚠')]),
            div(classes: 'callout-body', [
              h3([.text(trial.exceptionType ?? 'Trial Error')]),
              p([
                .text(
                  trial.exceptionMessage ??
                      'The agent execution failed before verifier completion.',
                ),
              ]),
              if (trial.exceptionTraceback != null)
                pre(classes: 'traceback-pre', [
                  code([.text(trial.exceptionTraceback!)]),
                ]),
            ]),
          ]),
        ]);
      }
      return const div([]);
    }

    // Top-level reward aggregator
    final rewardNode = rewardTree['reward'] as Map<String, Object?>?;
    final criteria =
        (rewardNode?['criteria'] as List<Object?>?)
            ?.whereType<Map<String, Object?>>()
            .toList() ??
        [];

    return section(classes: 'bench-card reward-breakdown-section', [
      const div(classes: 'section-header-row', [
        h2(classes: 'section-heading', [.text('Scoring Rubric Breakdown')]),
        span(classes: 'rubric-formula-badge', [
          .text('Composite Reward = 0.60×Outcome + 0.30×Quality + 0.10×DX'),
        ]),
      ]),
      const p(classes: 'section-intro-text', [
        .text(
          'Detailed criteria evaluation produced by automated test graders and LLM rubrics:',
        ),
      ]),

      // Criteria Trees
      div(classes: 'criteria-tree', [
        for (final criterion in criteria)
          _buildScoredCriterionCard(criterion, rewardTree),
      ]),

      // Diagnostic Section (Process & Efficiency)
      if (trial.diagnosticTree.isNotEmpty)
        div(classes: 'diagnostic-breakdown-panel', [
          const div(classes: 'diagnostic-banner', [
            span(classes: 'diag-icon', [.text('ℹ')]),
            div(classes: 'diag-banner-text', [
              h3([
                .text('Diagnostic Telemetry (Not Scored in Primary Reward)'),
              ]),
              p([
                .text(
                  'These metrics measure execution velocity, plan adherence, and token efficiency. '
                  'They provide operational observability and are strictly separated from composite reward scores.',
                ),
              ]),
            ]),
          ]),
          div(classes: 'diagnostic-grids', [
            for (final entry in trial.diagnosticTree.entries)
              _buildDiagnosticCard(
                entry.key,
                entry.value as Map<String, Object?>,
              ),
          ]),
        ]),
    ]);
  }

  Component _buildScoredCriterionCard(
    Map<String, Object?> criterion,
    Map<String, Object?> fullTree,
  ) {
    final name = criterion['name'] as String? ?? 'criterion';
    final value = (criterion['value'] as num?)?.toDouble() ?? 0.0;
    final weight = (criterion['weight'] as num?)?.toDouble() ?? 0.0;
    final description = criterion['description'] as String? ?? '';

    // Check for expanded node in fullTree
    final subNode = fullTree[name] as Map<String, Object?>?;
    final subCriteria =
        (subNode?['criteria'] as List<Object?>?)
            ?.whereType<Map<String, Object?>>()
            .toList() ??
        [];
    final kind = subNode?['kind'] as String?;

    return details(
      classes: 'criterion-accordion',
      attributes: const {'open': 'true'},
      [
        summary(classes: 'criterion-summary', [
          div(classes: 'summary-left', [
            span(classes: 'criterion-name', [.text(name.toUpperCase())]),
            span(classes: 'weight-pill', [
              .text('Weight ${(weight * 100).toStringAsFixed(0)}%'),
            ]),
          ]),
          div(classes: 'summary-right', [
            span(
              classes: [
                'score-pill',
                if (value >= 0.8)
                  'score-high'
                else if (value >= 0.5)
                  'score-mid'
                else
                  'score-low',
              ].join(' '),
              [.text('${(value * 100).toStringAsFixed(0)}%')],
            ),
          ]),
        ]),
        div(classes: 'criterion-body', [
          if (description.isNotEmpty && subCriteria.isEmpty)
            pre(classes: 'description-box', [.text(description)]),
          if (subCriteria.isNotEmpty)
            div(classes: 'sub-criteria-list', [
              for (final sub in subCriteria)
                _buildSubCriterionItem(sub, isLlmJudge: kind == 'llm'),
            ]),
        ]),
      ],
    );
  }

  Component _buildSubCriterionItem(
    Map<String, Object?> item, {
    required bool isLlmJudge,
  }) {
    final name = item['name'] as String? ?? '';
    final value = (item['value'] as num?)?.toDouble() ?? 0.0;
    final weight = (item['weight'] as num?)?.toDouble();
    final description = item['description'] as String? ?? '';
    final reasoning = item['reasoning'] as String?;

    return div(classes: 'sub-criterion-row', [
      div(classes: 'sub-header-line', [
        span(classes: 'sub-name', [.text(name)]),
        if (weight != null)
          span(classes: 'sub-weight', [
            .text('wt: ${(weight * 100).toStringAsFixed(0)}%'),
          ]),
        span(
          classes: [
            'sub-score-badge',
            if (value >= 0.8)
              'score-high'
            else if (value >= 0.5)
              'score-mid'
            else
              'score-low',
          ].join(' '),
          [.text(value.toStringAsFixed(2))],
        ),
      ]),
      if (description.isNotEmpty)
        p(classes: 'sub-description', [.text(description)]),
      if (reasoning != null && reasoning.isNotEmpty)
        div(classes: 'llm-reasoning-card', [
          const div(classes: 'reasoning-header', [
            span(classes: 'reasoning-badge', [.text('LLM Judge Evaluation')]),
          ]),
          p(classes: 'reasoning-text', [.text(reasoning)]),
        ]),
    ]);
  }

  Component _buildDiagnosticCard(String title, Map<String, Object?> node) {
    final score = (node['score'] as num?)?.toDouble() ?? 0.0;
    final criteria =
        (node['criteria'] as List<Object?>?)
            ?.whereType<Map<String, Object?>>()
            .toList() ??
        [];

    return div(classes: 'diagnostic-card', [
      div(classes: 'diag-card-header', [
        h4(classes: 'diag-title', [.text(title.toUpperCase())]),
        span(classes: 'diag-score', [
          .text('${(score * 100).toStringAsFixed(0)}%'),
        ]),
      ]),
      ul(classes: 'diag-criteria-list', [
        for (final item in criteria)
          li([
            div(classes: 'diag-item-row', [
              span(classes: 'diag-item-name', [
                .text(item['name'] as String? ?? ''),
              ]),
              span(classes: 'diag-item-val', [
                .text(
                  ((item['value'] as num?)?.toDouble() ?? 0.0).toStringAsFixed(
                    2,
                  ),
                ),
              ]),
            ]),
            if (item['description'] != null)
              p(classes: 'diag-item-desc', [
                .text(item['description'] as String),
              ]),
          ]),
      ]),
    ]);
  }

  Component _buildTrajectorySection() {
    final steps = trial.trajectory!;

    return section(classes: 'bench-card trajectory-section', [
      const h2(classes: 'section-heading', [
        .text('Agent Execution Trajectory'),
      ]),
      const p(classes: 'section-intro-text', [
        .text(
          'Sequential step timeline captured during autonomous agent execution:',
        ),
      ]),
      ol(classes: 'trajectory-timeline', [
        for (var i = 0; i < steps.length; i++)
          _buildTrajectoryStep(steps[i], stepIndex: i + 1),
      ]),
    ]);
  }

  Component _buildTrajectoryStep(
    Map<String, Object?> step, {
    required int stepIndex,
  }) {
    final action = step['action'] as String? ?? 'step';
    final input = step['input'] as String? ?? '';
    final durationMs = (step['duration_ms'] as num?)?.toInt() ?? 0;

    return li(classes: 'trajectory-step-item', [
      div(classes: 'step-marker', [.text('$stepIndex')]),
      div(classes: 'step-content', [
        div(classes: 'step-top-line', [
          span(classes: 'action-badge action-$action', [.text(action)]),
          span(classes: 'duration-pill', [.text('${durationMs}ms')]),
        ]),
        if (input.isNotEmpty) code(classes: 'step-input-code', [.text(input)]),
      ]),
    ]);
  }

  Component _buildArtifactsSection() {
    return section(classes: 'bench-card artifacts-section', [
      const h2(classes: 'section-heading', [.text('Generated Code Artifacts')]),
      const p(classes: 'section-intro-text', [
        .text('Files modified or generated by the agent during this trial:'),
      ]),
      div(classes: 'artifacts-list', [
        for (final artifact in trial.artifacts) _buildArtifactCard(artifact),
      ]),
    ]);
  }

  Component _buildArtifactCard(Map<String, Object?> artifact) {
    final dest =
        artifact['destination'] as String? ??
        artifact['source'] as String? ??
        'file';
    final content = artifact['content'] as String?;

    return details(
      classes: 'artifact-card',
      attributes: const {'open': 'true'},
      [
        summary(classes: 'artifact-header', [
          const span(classes: 'file-path-icon', [.text('📄')]),
          span(classes: 'artifact-path', [.text(dest)]),
          const span(classes: 'artifact-status-pill', [.text('Generated')]),
        ]),
        div(classes: 'artifact-content', [
          if (content != null && content.isNotEmpty)
            pre(classes: 'code-viewer', [
              code([.text(content)]),
            ])
          else
            const p(classes: 'text-muted p-3', [
              .text('(Empty or binary file)'),
            ]),
        ]),
      ],
    );
  }

  Component _buildLogsSection() {
    final stdout = trial.testStdout;
    final excLog = trial.exceptionLog;

    if (stdout == null && excLog == null) {
      return const div([]);
    }

    return section(classes: 'bench-card logs-section', [
      const h2(classes: 'section-heading', [
        .text('Execution & Verifier Logs'),
      ]),
      if (excLog != null && excLog.isNotEmpty)
        details(
          classes: 'log-details error-log',
          attributes: const {'open': 'true'},
          [
            const summary(classes: 'log-summary', [
              span(classes: 'text-danger bold', [
                .text('Exception Traceback (exception.txt)'),
              ]),
            ]),
            pre(classes: 'raw-log-pre', [
              code([.text(excLog)]),
            ]),
          ],
        ),
      if (stdout != null && stdout.isNotEmpty)
        details(classes: 'log-details', [
          const summary(classes: 'log-summary', [
            .text('Verifier Standard Output (test-stdout.txt)'),
          ]),
          pre(classes: 'raw-log-pre', [
            code([.text(stdout)]),
          ]),
        ]),
    ]);
  }

  String _formatTokens(int count) {
    if (count <= 0) return '0';
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
    return count.toString();
  }
}
