// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import '../../models/content/flutterbench_content.dart';

/// How a benchmark metric is ordered when ranking models against each other.
enum BenchmarkMetric {
  /// Reward on a 0–1 scale, where a higher score is better.
  accuracy(label: 'Accuracy', lowerIsBetter: false),

  /// US dollars spent on a single trial, where a lower cost is better.
  cost(label: 'Cost', lowerIsBetter: true),

  /// Wall-clock seconds for a single trial, where a lower time is better.
  latency(label: 'Latency', lowerIsBetter: true);

  const BenchmarkMetric({required this.label, required this.lowerIsBetter});

  /// The tab label shown for this metric.
  final String label;

  /// Whether smaller values rank ahead of larger ones.
  final bool lowerIsBetter;
}

/// One model configuration's result on a single benchmark task.
class BenchmarkScore {
  const BenchmarkScore({
    required this.status,
    this.reward,
    this.costUsd,
    this.latencySeconds,
  });

  /// Reads a score from the map produced by [toMap].
  factory BenchmarkScore.fromMap(Map<String, Object?> map) => BenchmarkScore(
    status: map['status'] as String? ?? 'unknown',
    reward: (map['reward'] as num?)?.toDouble(),
    costUsd: (map['cost'] as num?)?.toDouble(),
    latencySeconds: (map['latency'] as num?)?.toDouble(),
  );

  /// The trial outcome: `pass`, `partial`, `fail`, or `error`.
  final String status;

  final double? reward;
  final double? costUsd;
  final double? latencySeconds;

  /// Whether the trial failed before producing a score.
  bool get isErrored => status == 'error';

  /// The value for [metric], or `null` when it wasn't recorded.
  double? valueFor(BenchmarkMetric metric) => switch (metric) {
    BenchmarkMetric.accuracy => reward,
    BenchmarkMetric.cost => costUsd,
    BenchmarkMetric.latency => latencySeconds,
  };

  /// Serializes the score for transport across a `@client` boundary.
  Map<String, Object?> toMap() => {
    'status': status,
    'reward': ?reward,
    'cost': ?costUsd,
    'latency': ?latencySeconds,
  };
}

/// A benchmark task alongside every model configuration's result on it.
class BenchmarkRow {
  const BenchmarkRow({
    required this.slug,
    required this.name,
    required this.category,
    required this.scores,
  });

  /// Reads a row from the map produced by [toMap].
  factory BenchmarkRow.fromMap(Map<String, Object?> map) => BenchmarkRow(
    slug: map['slug'] as String,
    name: map['name'] as String,
    category: map['category'] as String? ?? '',
    scores: {
      for (final entry
          in (map['scores'] as Map<Object?, Object?>? ?? {}).entries)
        entry.key as String: BenchmarkScore.fromMap(
          (entry.value as Map).cast<String, Object?>(),
        ),
    },
  );

  final String slug;
  final String name;
  final String category;

  /// Results keyed by eval key.
  final Map<String, BenchmarkScore> scores;

  /// The recorded values of [metric] across every model, unsorted.
  Iterable<double> valuesFor(BenchmarkMetric metric) =>
      scores.values.map((score) => score.valueFor(metric)).nonNulls;

  /// The 1-based rank of [evalKey] for [metric], with the number of models
  /// that have a recorded value.
  ///
  /// Returns `null` when this model has no value to rank.
  ({int rank, int total})? rankOf(String evalKey, BenchmarkMetric metric) {
    final value = scores[evalKey]?.valueFor(metric);
    if (value == null) return null;

    final values = valuesFor(metric).toList()..sort();
    if (metric.lowerIsBetter) {
      return (rank: values.indexOf(value) + 1, total: values.length);
    }
    return (
      rank: values.length - values.lastIndexOf(value),
      total: values.length,
    );
  }

  /// Serializes the row for transport across a `@client` boundary.
  Map<String, Object?> toMap() => {
    'slug': slug,
    'name': name,
    'category': category,
    'scores': {
      for (final entry in scores.entries) entry.key: entry.value.toMap(),
    },
  };
}

/// Joins task scores with their trials to build one [BenchmarkRow] per task.
///
/// Tasks record which trial produced each model's score, and the trials carry
/// the cost and duration measurements, so the two have to be stitched together
/// before the model detail view can rank models on all three metrics.
List<BenchmarkRow> buildBenchmarkRows({
  required FlutterBenchTasksData tasks,
  required FlutterBenchTrialsData trials,
}) {
  final trialsByName = {
    for (final trial in trials.trials) trial.trialName: trial,
  };

  return [
    for (final task in tasks.tasks)
      BenchmarkRow(
        slug: task.slug,
        name: task.displayName,
        category: task.category,
        scores: {
          for (final entry in task.scoresByEval.entries)
            if (entry.value case final Map<Object?, Object?> score)
              entry.key: _buildScore(
                score.cast<String, Object?>(),
                trialsByName,
              ),
        },
      ),
  ];
}

BenchmarkScore _buildScore(
  Map<String, Object?> score,
  Map<String, FlutterBenchTrialDetail> trialsByName,
) {
  final trial = trialsByName[score['trial_name'] as String?];
  final durations = trial?.durations.values;

  return BenchmarkScore(
    status: score['status'] as String? ?? 'unknown',
    reward: (score['reward'] as num?)?.toDouble(),
    costUsd: trial?.costUsd,
    latencySeconds: durations == null || durations.isEmpty
        ? null
        : durations.reduce((a, b) => a + b),
  );
}

/// Serializes [rows] for transport across a `@client` boundary.
List<Map<String, Object?>> benchmarkRowsToMaps(List<BenchmarkRow> rows) => [
  for (final row in rows) row.toMap(),
];

/// Reads the rows produced by [benchmarkRowsToMaps].
List<BenchmarkRow> benchmarkRowsFromMaps(List<Map<String, Object?>> maps) => [
  for (final map in maps) BenchmarkRow.fromMap(map),
];
