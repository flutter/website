// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

part 'flutterbench_content.mapper.dart';

/// Top-level FlutterBench job summary data loaded from `data.flutterbench.job`.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchJobData with FlutterBenchJobDataMappable {
  const FlutterBenchJobData({
    required this.id,
    required this.startedAt,
    required this.finishedAt,
    required this.nTotalTrials,
    required this.nCompletedTrials,
    required this.nErroredTrials,
    required this.costUsd,
    required this.nInputTokens,
    required this.nCacheTokens,
    required this.nOutputTokens,
    required this.topModelName,
    required this.topModelReward,
    required this.overallAverageReward,
    required this.evals,
  });

  final String id;
  final String startedAt;
  final String finishedAt;
  final int nTotalTrials;
  final int nCompletedTrials;
  final int nErroredTrials;
  final double costUsd;
  final int nInputTokens;
  final int nCacheTokens;
  final int nOutputTokens;
  final String topModelName;
  final double topModelReward;
  final double overallAverageReward;
  final List<FlutterBenchEvalItem> evals;

  /// Parses FlutterBench job data from JSON/YAML map.
  static FlutterBenchJobData fromJson(Map<String, Object?> json) =>
      FlutterBenchJobDataMapper.fromMap(json);
}

/// A single evaluation configuration row on the leaderboard.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchEvalItem with FlutterBenchEvalItemMappable {
  const FlutterBenchEvalItem({
    required this.evalKey,
    required this.agentName,
    required this.modelName,
    required this.modelShortName,
    required this.provider,
    required this.variant,
    required this.nTrials,
    required this.nErrors,
    required this.meanReward,
    required this.minReward,
    required this.maxReward,
    required this.medianReward,
    required this.passAt1,
    required this.costUsd,
    required this.inputTokens,
    required this.outputTokens,
    required this.hasDartTooling,
    this.outcomeScore,
    this.qualityScore,
    this.dxScore,
    this.bestCujs = const [],
    this.worstCujs = const [],
  });

  final String evalKey;
  final String agentName;
  final String modelName;
  final String modelShortName;
  final String provider;
  final String variant;
  final int nTrials;
  final int nErrors;
  final double meanReward;
  final double minReward;
  final double maxReward;
  final double medianReward;
  @MappableField(key: 'pass_at_1')
  final double passAt1;
  final double costUsd;
  final int inputTokens;
  final int outputTokens;
  final bool hasDartTooling;
  final double? outcomeScore;
  final double? qualityScore;
  final double? dxScore;
  final List<FlutterBenchCujSummary> bestCujs;
  final List<FlutterBenchCujSummary> worstCujs;

  /// Parses an evaluation item from JSON/YAML map.
  static FlutterBenchEvalItem fromJson(Map<String, Object?> json) =>
      FlutterBenchEvalItemMapper.fromMap(json);
}

/// Summary of a CUJ performance for a model.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchCujSummary with FlutterBenchCujSummaryMappable {
  const FlutterBenchCujSummary({
    required this.taskSlug,
    required this.taskName,
    this.reward,
    required this.status,
  });

  final String taskSlug;
  final String taskName;
  final double? reward;
  final String status;

  /// Parses a CUJ summary item from JSON/YAML map.
  static FlutterBenchCujSummary fromJson(Map<String, Object?> json) =>
      FlutterBenchCujSummaryMapper.fromMap(json);
}

/// Tasks collection data loaded from `data.flutterbench.tasks`.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTasksData with FlutterBenchTasksDataMappable {
  const FlutterBenchTasksData({required this.tasks});

  final List<FlutterBenchTaskItem> tasks;

  /// Parses tasks data from JSON/YAML map.
  static FlutterBenchTasksData fromJson(Map<String, Object?> json) =>
      FlutterBenchTasksDataMapper.fromMap(json);
}

/// An individual task / Critical User Journey (CUJ).
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTaskItem with FlutterBenchTaskItemMappable {
  const FlutterBenchTaskItem({
    required this.slug,
    required this.taskName,
    required this.displayName,
    required this.category,
    required this.description,
    this.trials = const [],
    this.scoresByEval = const {},
  });

  final String slug;
  final String taskName;
  final String displayName;
  final String category;
  final String description;
  final List<FlutterBenchTrialSummary> trials;
  final Map<String, Object?> scoresByEval;

  /// Parses a task item from JSON/YAML map.
  static FlutterBenchTaskItem fromJson(Map<String, Object?> json) =>
      FlutterBenchTaskItemMapper.fromMap(json);
}

/// Summary of a trial inside a task.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTrialSummary with FlutterBenchTrialSummaryMappable {
  const FlutterBenchTrialSummary({
    required this.trialName,
    required this.status,
    this.reward,
    required this.modelName,
    required this.modelShortName,
    required this.agentName,
    required this.hasDartTooling,
    this.exceptionType,
  });

  final String trialName;
  final String status;
  final double? reward;
  final String modelName;
  final String modelShortName;
  final String agentName;
  final bool hasDartTooling;
  final String? exceptionType;

  /// Parses a trial summary item from JSON/YAML map.
  static FlutterBenchTrialSummary fromJson(Map<String, Object?> json) =>
      FlutterBenchTrialSummaryMapper.fromMap(json);
}

/// Trials collection loaded from `data.flutterbench.trials`.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTrialsData with FlutterBenchTrialsDataMappable {
  const FlutterBenchTrialsData({required this.trials});

  final List<FlutterBenchTrialDetail> trials;

  /// Parses trials collection from JSON/YAML map.
  static FlutterBenchTrialsData fromJson(Map<String, Object?> json) =>
      FlutterBenchTrialsDataMapper.fromMap(json);
}

/// Detailed single trial information.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTrialDetail with FlutterBenchTrialDetailMappable {
  const FlutterBenchTrialDetail({
    required this.trialName,
    required this.taskName,
    required this.taskSlug,
    required this.agentName,
    required this.modelName,
    required this.modelShortName,
    required this.provider,
    this.skills = const [],
    this.mcpServers = const [],
    required this.hasDartTooling,
    required this.status,
    this.reward,
    this.exceptionType,
    this.exceptionMessage,
    this.exceptionTraceback,
    this.durations = const {},
    required this.inputTokens,
    required this.cacheTokens,
    required this.outputTokens,
    required this.costUsd,
    this.rewardTree,
    this.diagnosticTree = const {},
    this.trajectory,
    this.artifacts = const [],
    this.testStdout,
    this.exceptionLog,
  });

  final String trialName;
  final String taskName;
  final String taskSlug;
  final String agentName;
  final String modelName;
  final String modelShortName;
  final String provider;
  final List<String> skills;
  final List<String> mcpServers;
  final bool hasDartTooling;
  final String status; // 'pass', 'partial', 'fail', 'error'
  final double? reward;
  final String? exceptionType;
  final String? exceptionMessage;
  final String? exceptionTraceback;
  final Map<String, double> durations;
  final int inputTokens;
  final int cacheTokens;
  final int outputTokens;
  final double costUsd;
  final Map<String, Object?>? rewardTree;
  final Map<String, Object?> diagnosticTree;
  final List<Map<String, Object?>>? trajectory;
  final List<Map<String, Object?>> artifacts;
  final String? testStdout;
  final String? exceptionLog;

  /// Parses a trial detail from JSON/YAML map.
  static FlutterBenchTrialDetail fromJson(Map<String, Object?> json) =>
      FlutterBenchTrialDetailMapper.fromMap(json);
}
