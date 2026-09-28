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

/// Methodology page content loaded from `data.flutterbench.methodology`.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchMethodologyData with FlutterBenchMethodologyDataMappable {
  const FlutterBenchMethodologyData({
    required this.overview,
    this.cujExample = const [],
    this.taskSpecifications = const [],
    required this.taskAnatomy,
    this.evaluationMatrix = const {},
    this.dimensions = const [],
    this.graderMatrix = const {},
    required this.graderTiers,
    required this.diagnosticTelemetry,
    this.reliability = const {},
    this.scoreTriage = const {},
    required this.rootCauseAudits,
    required this.transparency,
  });

  final FlutterBenchMethodologyOverview overview;
  final List<Map<String, Object?>> cujExample;
  final List<Map<String, Object?>> taskSpecifications;
  final FlutterBenchTaskAnatomy taskAnatomy;
  final Map<String, Object?> evaluationMatrix;
  final List<Map<String, Object?>> dimensions;
  final Map<String, Object?> graderMatrix;
  final FlutterBenchTableSection graderTiers;
  final FlutterBenchTableSection diagnosticTelemetry;
  final Map<String, Object?> reliability;
  final Map<String, Object?> scoreTriage;
  final FlutterBenchItemList rootCauseAudits;
  final FlutterBenchTransparency transparency;

  /// Parses methodology page data from JSON/YAML map.
  static FlutterBenchMethodologyData fromJson(Map<String, Object?> json) =>
      FlutterBenchMethodologyDataMapper.fromMap(json);
}

/// The "Overview" chapter's lead paragraph and 4-row component table.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchMethodologyOverview
    with FlutterBenchMethodologyOverviewMappable {
  const FlutterBenchMethodologyOverview({
    required this.leadText,
    required this.rows,
  });

  final String leadText;
  final List<FlutterBenchTableRow> rows;

  /// Parses overview data from JSON/YAML map.
  static FlutterBenchMethodologyOverview fromJson(
    Map<String, Object?> json,
  ) => FlutterBenchMethodologyOverviewMapper.fromMap(json);
}

/// A generic labeled table row used by the Overview, Grader Tiers, and
/// Diagnostic Telemetry tables.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTableRow with FlutterBenchTableRowMappable {
  const FlutterBenchTableRow({
    required this.label,
    this.detail,
    required this.description,
    this.anchor,
  });

  final String label;
  final String? detail;
  final String description;
  final String? anchor;

  /// Parses a table row from JSON/YAML map.
  static FlutterBenchTableRow fromJson(Map<String, Object?> json) =>
      FlutterBenchTableRowMapper.fromMap(json);
}

/// A simple table section made up of [FlutterBenchTableRow]s, reused for the
/// Grader Implementation Tiers and Diagnostic Telemetry tables.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTableSection with FlutterBenchTableSectionMappable {
  const FlutterBenchTableSection({required this.rows});

  final List<FlutterBenchTableRow> rows;

  /// Parses a table section from JSON/YAML map.
  static FlutterBenchTableSection fromJson(Map<String, Object?> json) =>
      FlutterBenchTableSectionMapper.fromMap(json);
}

/// A label/detail pair, reused for the Human Root-Cause Audits list.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchLabeledDetail with FlutterBenchLabeledDetailMappable {
  const FlutterBenchLabeledDetail({required this.label, required this.detail});

  final String label;
  final String detail;

  /// Parses a labeled detail item from JSON/YAML map.
  static FlutterBenchLabeledDetail fromJson(Map<String, Object?> json) =>
      FlutterBenchLabeledDetailMapper.fromMap(json);
}

/// A list of [FlutterBenchLabeledDetail] items, used for the Human
/// Root-Cause Audits section.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchItemList with FlutterBenchItemListMappable {
  const FlutterBenchItemList({required this.items});

  final List<FlutterBenchLabeledDetail> items;

  /// Parses an item list from JSON/YAML map.
  static FlutterBenchItemList fromJson(Map<String, Object?> json) =>
      FlutterBenchItemListMapper.fromMap(json);
}

/// The Transparency & Reproducibility chapter's Harbor CLI example values.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTransparency with FlutterBenchTransparencyMappable {
  const FlutterBenchTransparency({required this.harborExample});

  final FlutterBenchHarborExample harborExample;

  /// Parses transparency data from JSON/YAML map.
  static FlutterBenchTransparency fromJson(Map<String, Object?> json) =>
      FlutterBenchTransparencyMapper.fromMap(json);
}

/// Values interpolated into the Harbor CLI reproduction example.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchHarborExample with FlutterBenchHarborExampleMappable {
  const FlutterBenchHarborExample({
    required this.task,
    required this.agent,
    required this.model,
    required this.mcp,
  });

  final String task;
  final String agent;
  final String model;
  final String mcp;

  /// Parses a Harbor example from JSON/YAML map.
  static FlutterBenchHarborExample fromJson(Map<String, Object?> json) =>
      FlutterBenchHarborExampleMapper.fromMap(json);
}

/// The "Interactive task anatomy" file-tree section.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTaskAnatomy with FlutterBenchTaskAnatomyMappable {
  const FlutterBenchTaskAnatomy({
    required this.introText,
    required this.rootId,
    required this.rootLabel,
    required this.tree,
  });

  final String introText;
  final String rootId;
  final String rootLabel;
  final List<FlutterBenchTaskTreeNode> tree;

  /// Parses task anatomy data from JSON/YAML map.
  static FlutterBenchTaskAnatomy fromJson(Map<String, Object?> json) =>
      FlutterBenchTaskAnatomyMapper.fromMap(json);
}

/// A single file or folder node in the task anatomy file tree.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchTaskTreeNode with FlutterBenchTaskTreeNodeMappable {
  const FlutterBenchTaskTreeNode({
    required this.type,
    required this.id,
    required this.label,
    this.subtitle,
    this.badge,
    this.badgeColor,
    this.isDefaultPage = false,
    this.startsClosed = true,
    this.body,
    this.code,
    this.children = const [],
  });

  final String type; // 'folder' | 'file'
  final String id;
  final String label;
  final String? subtitle;
  final String? badge;
  final String? badgeColor;
  final bool isDefaultPage;
  final bool startsClosed;
  final String? body;
  final FlutterBenchCodeSample? code;
  final List<FlutterBenchTaskTreeNode> children;

  /// Parses a task tree node from JSON/YAML map.
  static FlutterBenchTaskTreeNode fromJson(Map<String, Object?> json) =>
      FlutterBenchTaskTreeNodeMapper.fromMap(json);
}

/// A fenced code sample attached to a task tree node's detail body.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchCodeSample with FlutterBenchCodeSampleMappable {
  const FlutterBenchCodeSample({required this.lang, required this.text});

  final String lang;
  final String text;

  /// Parses a code sample from JSON/YAML map.
  static FlutterBenchCodeSample fromJson(Map<String, Object?> json) =>
      FlutterBenchCodeSampleMapper.fromMap(json);
}

/// The critical user journey (CUJ) catalog loaded from `data.flutterbench.cujs`.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchCujsData with FlutterBenchCujsDataMappable {
  const FlutterBenchCujsData({required this.cujs});

  final List<FlutterBenchCujItem> cujs;

  /// Parses the CUJ catalog from JSON/YAML map.
  static FlutterBenchCujsData fromJson(Map<String, Object?> json) =>
      FlutterBenchCujsDataMapper.fromMap(json);
}

/// A single critical user journey and the tasks that make it up.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchCujItem with FlutterBenchCujItemMappable {
  const FlutterBenchCujItem({
    required this.id,
    required this.goal,
    required this.persona,
    this.tasks = const [],
  });

  final int id;
  final String goal;
  final String persona;
  final List<FlutterBenchCujTaskItem> tasks;

  /// Parses a CUJ item from JSON/YAML map.
  static FlutterBenchCujItem fromJson(Map<String, Object?> json) =>
      FlutterBenchCujItemMapper.fromMap(json);
}

/// A concrete task contributing to a [FlutterBenchCujItem]'s goal.
@MappableClass(caseStyle: CaseStyle.snakeCase)
class FlutterBenchCujTaskItem with FlutterBenchCujTaskItemMappable {
  const FlutterBenchCujTaskItem({
    required this.id,
    required this.name,
    required this.task,
  });

  final int id;
  final String name;
  final String task;

  /// Parses a CUJ task item from JSON/YAML map.
  static FlutterBenchCujTaskItem fromJson(Map<String, Object?> json) =>
      FlutterBenchCujTaskItemMapper.fromMap(json);
}
