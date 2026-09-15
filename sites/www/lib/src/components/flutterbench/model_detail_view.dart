// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../common/icon.dart';
import 'bench_formatters.dart';
import 'benchmark_scores.dart';
import 'data_coming_soon.dart';
import 'error_state_badge.dart';
import 'model_name_formatter.dart';

/// The full result profile for one model configuration.
///
/// Rendered both in the leaderboard's details drawer and as the right-hand
/// pane of the models explorer, so the two surfaces stay in sync.
class ModelDetailView extends StatefulComponent {
  const ModelDetailView({
    required this.eval,
    required this.evals,
    required this.benchmarks,
    this.modelsPageLink,
    super.key,
  });

  /// The model configuration being described.
  final Map<String, Object?> eval;

  /// Every configuration on the leaderboard, used to place [eval] within the
  /// distribution of results.
  final List<Map<String, Object?>> evals;

  /// Per-task results for every configuration.
  final List<BenchmarkRow> benchmarks;

  /// Where the "View in models page" action points, or `null` to hide it.
  final String? modelsPageLink;

  @override
  State<ModelDetailView> createState() => _ModelDetailViewState();
}

class _ModelDetailViewState extends State<ModelDetailView> {
  BenchmarkMetric _metric = BenchmarkMetric.accuracy;

  String get _evalKey => component.eval['eval_key'] as String;

  @override
  Component build(BuildContext context) {
    return div(classes: 'model-detail', [
      if (component.modelsPageLink case final link?)
        div(classes: 'model-detail__actions', [
          a(href: link, classes: 'bench-btn-sm', const [
            .text('View in models page →'),
          ]),
        ]),
      _buildHeader(),
      _buildSpecGrid(),
      _buildHeadlineStats(),
      _buildHyperparameters(),
      _buildBenchmarks(),
    ]);
  }

  Component _buildHeader() {
    final eval = component.eval;
    final provider = eval['provider'] as String? ?? 'Community';

    return header(classes: 'model-detail__header', [
      p(classes: 'model-detail__eyebrow', [.text(provider.toUpperCase())]),
      h2(classes: 'model-detail__title', [
        .text(formatModelName(eval['model_short_name'] as String)),
      ]),
      p(classes: 'model-detail__release', [
        .text('EVAL KEY: ${eval['eval_key']}'),
      ]),
    ]);
  }

  Component _buildSpecGrid() {
    final eval = component.eval;
    final nTrials = (eval['n_trials'] as num?)?.toInt() ?? 0;
    final nErrors = (eval['n_errors'] as num?)?.toInt() ?? 0;
    final inputTokens = (eval['input_tokens'] as num?)?.toInt() ?? 0;
    final outputTokens = (eval['output_tokens'] as num?)?.toInt() ?? 0;
    final hasTooling = eval['has_dart_tooling'] == true;

    return div(classes: 'model-spec-block', [
      dl(classes: 'model-spec-grid', [
        ..._buildSpecRow(
          'Developer',
          eval['provider'] as String? ?? 'Community',
        ),
        ..._buildSpecRow('Agent', eval['agent_name'] as String),
        ..._buildSpecRow('Model ID', eval['model_name'] as String),
        ..._buildSpecRow('Variant', eval['variant'] as String? ?? '—'),
        ..._buildSpecRow(
          'Dart tooling',
          hasTooling ? 'Enabled' : 'Not enabled',
        ),
        ..._buildSpecRow(
          'Trials',
          nErrors > 0 ? '$nTrials ($nErrors errored)' : '$nTrials',
        ),
        ..._buildSpecRow(
          'Tokens (in/out)',
          '${formatTokens(inputTokens)} / ${formatTokens(outputTokens)}',
        ),
        ..._buildSpecRow(
          'Pass@1',
          formatScore((eval['pass_at_1'] as num?)?.toDouble()),
        ),
      ]),
      const DataComingSoon(
        note:
            'Release date, context window, max output tokens, published token '
            'pricing, weight availability, and input modalities.',
      ),
    ]);
  }

  List<Component> _buildSpecRow(String label, String value) => [
    dt(classes: 'model-spec-grid__label', [.text(label.toUpperCase())]),
    dd(classes: 'model-spec-grid__value', [.text(value)]),
  ];

  Component _buildHeadlineStats() {
    final isErrored = _isErrored(component.eval);

    return div(classes: 'model-stat-cards', [
      _buildStatCard(
        metric: BenchmarkMetric.accuracy,
        label: 'Overall score',
        value: isErrored ? '—' : formatScore(_accuracyOf(component.eval)),
        detail: _rewardRange(),
      ),
      _buildStatCard(
        metric: BenchmarkMetric.cost,
        label: 'Cost / trial',
        value: formatCost(_costOf(component.eval)),
        detail:
            'Total ${formatCost((component.eval['cost_usd'] as num?)?.toDouble())}',
      ),
      _buildStatCard(
        metric: BenchmarkMetric.latency,
        label: 'Latency / trial',
        value: formatDuration(_latencyOf(component.eval)),
        detail: 'Mean wall clock',
      ),
    ]);
  }

  Component _buildStatCard({
    required BenchmarkMetric metric,
    required String label,
    required String value,
    required String detail,
  }) {
    final values = component.evals.map(_valueOf(metric)).nonNulls;

    return div(classes: 'model-stat-card model-stat-card--${metric.name}', [
      span(classes: 'model-stat-card__label', [.text(label.toUpperCase())]),
      span(classes: 'model-stat-card__value', [.text(value)]),
      span(classes: 'model-stat-card__detail', [.text(detail)]),
      _buildDistribution(
        values: values,
        current: _valueOf(metric)(component.eval),
        logScale: metric.lowerIsBetter,
      ),
    ]);
  }

  Component _buildHyperparameters() {
    return const details(classes: 'model-hyperparams', [
      summary(classes: 'model-hyperparams__summary', [
        Icon(symbol: 'chevron_right', size: .sm),
        .text('View hyperparameter settings'),
      ]),
      div(classes: 'model-hyperparams__body', [
        DataComingSoon(
          note:
              'Temperature, top-p, reasoning effort, and tool configuration '
              'for each run.',
        ),
      ]),
    ]);
  }

  Component _buildBenchmarks() {
    return div(classes: 'model-benchmarks', [
      div(classes: 'bench-segmented-control', [
        for (final metric in BenchmarkMetric.values)
          button(
            classes: ['segment-btn', if (metric == _metric) 'active'].join(' '),
            attributes: {
              'type': 'button',
              'aria-pressed': '${metric == _metric}',
            },
            onClick: () => setState(() => _metric = metric),
            [.text(metric.label)],
          ),
      ]),
      p(classes: 'model-benchmarks__hint', [
        .text(switch (_metric) {
          BenchmarkMetric.accuracy =>
            'Reward on a 0–1 scale. Higher is better. '
                'Rankings compare this configuration against every other one '
                'scored on the same task.',
          BenchmarkMetric.cost =>
            'Cost of a single trial. Lower is better. '
                'Each tick is a scored configuration on a log scale, '
                'with this one marked.',
          BenchmarkMetric.latency =>
            'Wall-clock time for a single trial. Lower is better. '
                'Each tick is a scored configuration on a log scale, '
                'with this one marked.',
        }),
      ]),
      _buildBenchmarkTable(),
    ]);
  }

  Component _buildBenchmarkTable() {
    if (component.benchmarks.isEmpty) {
      return const DataComingSoon(note: 'Per-task results for this model.');
    }

    return div(classes: 'bench-table-wrapper', [
      table(classes: 'bench-table model-benchmarks__table', [
        thead([
          tr([
            const th(classes: 'col-benchmark', [.text('Benchmark')]),
            th(classes: 'col-distribution', [
              .text(switch (_metric) {
                BenchmarkMetric.accuracy => 'Score',
                BenchmarkMetric.cost => 'Cost distribution',
                BenchmarkMetric.latency => 'Latency distribution',
              }),
            ]),
            th(classes: 'col-value', [.text(_metric.label)]),
            const th(classes: 'col-ranking', [.text('Ranking')]),
          ]),
        ]),
        tbody([
          for (final row in component.benchmarks) _buildBenchmarkRow(row),
        ]),
      ]),
    ]);
  }

  Component _buildBenchmarkRow(BenchmarkRow row) {
    final score = row.scores[_evalKey];
    final value = score?.valueFor(_metric);
    final ranking = row.rankOf(_evalKey, _metric);

    return tr(classes: 'benchmark-row', [
      td(classes: 'col-benchmark', [
        a(
          href: '/ai/flutterbench/tasks/${row.slug}',
          classes: 'benchmark-row__link',
          [.text(row.name)],
        ),
      ]),
      td(classes: 'col-distribution', [
        if (score?.isErrored ?? false)
          const ErrorStateBadge(exceptionType: 'Errored', compact: true)
        else if (value == null)
          const span(classes: 'text-muted', [.text('No data for this task.')])
        else if (_metric == BenchmarkMetric.accuracy)
          _buildScoreBar(value)
        else
          _buildDistribution(
            values: row.valuesFor(_metric),
            current: value,
            logScale: true,
          ),
      ]),
      td(classes: 'col-value', [
        .text(switch (_metric) {
          BenchmarkMetric.accuracy => formatScore(value),
          BenchmarkMetric.cost => formatCost(value),
          BenchmarkMetric.latency => formatDuration(value),
        }),
      ]),
      td(classes: 'col-ranking', [
        if (ranking case final ranking?)
          span(classes: 'benchmark-row__rank', [
            span(classes: 'benchmark-row__rank-value', [
              .text('${ranking.rank}'),
            ]),
            .text(' / ${ranking.total}'),
          ])
        else
          const span(classes: 'text-muted', [.text('—')]),
      ]),
    ]);
  }

  Component _buildScoreBar(double reward) {
    final level = reward >= 0.8
        ? 'score-high'
        : reward >= 0.5
        ? 'score-mid'
        : 'score-low';

    return div(
      classes: 'score-bar',
      attributes: {
        'role': 'img',
        'aria-label': '${(reward * 100).round()} out of 100',
      },
      [
        div(
          classes: 'score-bar__fill $level',
          styles: Styles(raw: {'width': '${(reward * 100).clamp(0, 100)}%'}),
          const [],
        ),
      ],
    );
  }

  /// A strip of ticks, one per scored configuration, with [current] marked.
  Component _buildDistribution({
    required Iterable<double> values,
    required double? current,
    required bool logScale,
  }) {
    final sorted = values.toList()..sort();
    if (sorted.isEmpty) {
      return const span(classes: 'text-muted', [.text('—')]);
    }

    final min = sorted.first;
    final max = sorted.last;
    // A log scale needs strictly positive bounds, and a flat distribution has
    // no spread to map onto, so both fall back to centering every tick.
    final useLog = logScale && min > 0 && max > min;
    double position(double value) {
      if (max <= min) return 50;
      final fraction = useLog
          ? (math.log(value) - math.log(min)) / (math.log(max) - math.log(min))
          : (value - min) / (max - min);
      return (fraction * 100).clamp(0, 100);
    }

    return div(classes: 'distribution', [
      div(classes: 'distribution__track', [
        for (final value in sorted)
          span(
            classes: 'distribution__tick',
            styles: Styles(raw: {'left': '${position(value)}%'}),
            const [],
          ),
        if (current != null)
          span(
            classes: 'distribution__marker',
            styles: Styles(raw: {'left': '${position(current)}%'}),
            const [],
          ),
      ]),
    ]);
  }

  String _rewardRange() {
    final min = (component.eval['min_reward'] as num?)?.toDouble();
    final max = (component.eval['max_reward'] as num?)?.toDouble();
    if (min == null || max == null || min == max) return 'Mean reward';
    return 'Range ${formatScore(min)}–${formatScore(max)}';
  }

  double? Function(Map<String, Object?>) _valueOf(BenchmarkMetric metric) =>
      switch (metric) {
        BenchmarkMetric.accuracy => _accuracyOf,
        BenchmarkMetric.cost => _costOf,
        BenchmarkMetric.latency => _latencyOf,
      };

  double? _accuracyOf(Map<String, Object?> eval) =>
      _isErrored(eval) ? null : (eval['mean_reward'] as num?)?.toDouble();

  double? _costOf(Map<String, Object?> eval) {
    final cost = (eval['cost_usd'] as num?)?.toDouble();
    final trials = (eval['n_trials'] as num?)?.toInt() ?? 0;
    if (cost == null || trials <= 0) return null;
    return cost / trials;
  }

  double? _latencyOf(Map<String, Object?> eval) {
    final key = eval['eval_key'] as String;
    final latencies = [
      for (final row in component.benchmarks) ?row.scores[key]?.latencySeconds,
    ];
    if (latencies.isEmpty) return null;
    return latencies.reduce((sum, next) => sum + next) / latencies.length;
  }

  bool _isErrored(Map<String, Object?> eval) {
    final nErrors = (eval['n_errors'] as num?)?.toInt() ?? 0;
    final nTrials = (eval['n_trials'] as num?)?.toInt() ?? 0;
    return nErrors > 0 && nTrials == 0;
  }
}
