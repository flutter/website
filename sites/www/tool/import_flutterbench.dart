// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

void main(List<String> args) async {
  final repoRoot = _findRepoRoot();
  final wwwDir = p.join(repoRoot, 'sites', 'www');

  // Determine source directory
  String? sourceDir;
  for (final arg in args) {
    if (arg.startsWith('--data=')) {
      sourceDir = arg.substring('--data='.length);
    }
  }

  if (sourceDir == null) {
    final candidate1 = p.join(
      wwwDir,
      'lib',
      'src',
      'data',
      'raw_flutterbench_data',
    );
    final candidate2 = p.join(repoRoot, 'eaw_flutter_bench');
    final candidate3 = p.join(repoRoot, '..', 'flutter-bench', 'mock_data');
    if (Directory(candidate1).existsSync()) {
      sourceDir = candidate1;
    } else if (Directory(candidate2).existsSync()) {
      sourceDir = candidate2;
    } else if (Directory(candidate3).existsSync()) {
      sourceDir = candidate3;
    } else {
      stderr.writeln('Error: Could not find raw flutterbench data directory.');
      exit(1);
    }
  }

  stdout.writeln('Importing FlutterBench data from: $sourceDir');

  final rawDir = Directory(sourceDir);
  if (!rawDir.existsSync()) {
    stderr.writeln('Directory does not exist: $sourceDir');
    exit(1);
  }

  // 1. Read job result.json
  final jobResultFile = File(p.join(sourceDir, 'result.json'));
  if (!jobResultFile.existsSync()) {
    stderr.writeln('Missing job result.json in $sourceDir');
    exit(1);
  }

  final jobJson =
      jsonDecode(jobResultFile.readAsStringSync()) as Map<String, Object?>;
  final jobId = jobJson['id'] as String? ?? 'unknown-job';
  final startedAt = jobJson['started_at'] as String? ?? '';
  final finishedAt = jobJson['finished_at'] as String? ?? '';
  final nTotalTrials = (jobJson['n_total_trials'] as num?)?.toInt() ?? 0;
  final stats = (jobJson['stats'] as Map<String, Object?>?) ?? {};
  final nCompletedTrials = (stats['n_completed_trials'] as num?)?.toInt() ?? 0;
  final nErroredTrials = (stats['n_errored_trials'] as num?)?.toInt() ?? 0;
  final jobCostUsd = (stats['cost_usd'] as num?)?.toDouble() ?? 0.0;
  final jobInputTokens = (stats['n_input_tokens'] as num?)?.toInt() ?? 0;
  final jobCacheTokens = (stats['n_cache_tokens'] as num?)?.toInt() ?? 0;
  final jobOutputTokens = (stats['n_output_tokens'] as num?)?.toInt() ?? 0;

  final rawEvals = (stats['evals'] as Map<String, Object?>?) ?? {};

  // 2. Discover and parse all trials
  final trials = <Map<String, Object?>>[];
  final entities = rawDir.listSync();

  for (final entity in entities) {
    if (entity is Directory) {
      final dirName = p.basename(entity.path);
      final trialResultFile = File(p.join(entity.path, 'result.json'));
      if (!trialResultFile.existsSync()) continue;

      final trialJson = jsonDecode(
        trialResultFile.readAsStringSync(),
      ) as Map<String, Object?>;
      final trialName = trialJson['trial_name'] as String? ?? dirName;
      final taskName = trialJson['task_name'] as String? ?? '';
      final taskSlug = _slugFromTrial(trialName, taskName);

      final config = (trialJson['config'] as Map<String, Object?>?) ?? {};
      final agentConfig = (config['agent'] as Map<String, Object?>?) ?? {};
      final agentName = agentConfig['name'] as String? ?? 'unknown-agent';
      final modelName = agentConfig['model_name'] as String? ?? 'unknown-model';
      final skills =
          (agentConfig['skills'] as List<Object?>?)?.cast<String>() ??
          <String>[];
      final mcpServersRaw =
          (agentConfig['mcp_servers'] as List<Object?>?) ?? [];
      final mcpServers = <String>[];
      for (final mcp in mcpServersRaw) {
        if (mcp is Map && mcp['name'] != null) {
          mcpServers.add(mcp['name'] as String);
        } else if (mcp is String) {
          mcpServers.add(mcp);
        }
      }

      final hasDartTooling = skills.isNotEmpty || mcpServers.isNotEmpty;

      // Agent tokens and cost
      final agentResult = trialJson['agent_result'] as Map<String, Object?>?;
      final inputTokens =
          (agentResult?['n_input_tokens'] as num?)?.toInt() ?? 0;
      final cacheTokens =
          (agentResult?['n_cache_tokens'] as num?)?.toInt() ?? 0;
      final outputTokens =
          (agentResult?['n_output_tokens'] as num?)?.toInt() ?? 0;
      final costUsd = (agentResult?['cost_usd'] as num?)?.toDouble() ?? 0.0;

      // Verifier result
      final verifierResult =
          trialJson['verifier_result'] as Map<String, Object?>?;
      final rewardsMap = verifierResult?['rewards'] as Map<String, Object?>?;
      final reward = (rewardsMap?['reward'] as num?)?.toDouble();

      // Exception info
      final exceptionInfo =
          trialJson['exception_info'] as Map<String, Object?>?;
      final exceptionType = exceptionInfo?['exception_type'] as String?;
      final exceptionMessage = exceptionInfo?['exception_message'] as String?;
      final exceptionTraceback =
          exceptionInfo?['exception_traceback'] as String?;

      // Determine status
      final String status;
      if (exceptionInfo != null || exceptionType != null || reward == null) {
        status = 'error';
      } else if (reward >= 0.80) {
        status = 'pass';
      } else if (reward >= 0.25) {
        status = 'partial';
      } else {
        status = 'fail';
      }

      // Phase durations
      final durations = <String, double>{};
      for (final phase in [
        'environment_setup',
        'agent_setup',
        'agent_execution',
        'verifier',
      ]) {
        final phaseData = trialJson[phase] as Map<String, Object?>?;
        if (phaseData != null &&
            phaseData['started_at'] != null &&
            phaseData['finished_at'] != null) {
          final start = DateTime.tryParse(phaseData['started_at'] as String);
          final end = DateTime.tryParse(phaseData['finished_at'] as String);
          if (start != null && end != null) {
            durations[phase] = end.difference(start).inMilliseconds / 1000.0;
          }
        }
      }

      // Reward details
      Map<String, Object?>? rewardTree;
      final diagnosticTree = <String, Object?>{};
      final rewardDetailsFile = File(
        p.join(entity.path, 'verifier', 'reward-details.json'),
      );
      if (rewardDetailsFile.existsSync()) {
        try {
          final rewardDetails = jsonDecode(
            rewardDetailsFile.readAsStringSync(),
          ) as Map<String, Object?>;
          rewardTree = rewardDetails;
          for (final entry in rewardDetails.entries) {
            final val = entry.value;
            if (val is Map && val['diagnostic'] == true) {
              diagnosticTree[entry.key] = val;
            }
          }
        } catch (e) {
          stdout.writeln(
            'Warning: Failed to parse reward-details.json for $trialName: $e',
          );
        }
      }

      // Trajectory
      List<Map<String, Object?>>? trajectory;
      final trajectoryFile = File(
        p.join(entity.path, 'agent', 'trajectory.json'),
      );
      if (trajectoryFile.existsSync()) {
        try {
          final trajJson = jsonDecode(
            trajectoryFile.readAsStringSync(),
          ) as Map<String, Object?>;
          final steps = trajJson['steps'] as List<Object?>?;
          if (steps != null) {
            trajectory = steps.whereType<Map<String, Object?>>().toList();
          }
        } catch (e) {
          stdout.writeln(
            'Warning: Failed to parse trajectory.json for $trialName: $e',
          );
        }
      }

      // Artifacts
      final artifacts = <Map<String, Object?>>[];
      final manifestFile = File(
        p.join(entity.path, 'artifacts', 'manifest.json'),
      );
      if (manifestFile.existsSync()) {
        try {
          final manifestList =
              jsonDecode(manifestFile.readAsStringSync()) as List<Object?>;
          for (final item in manifestList) {
            if (item is Map<String, Object?>) {
              final dest = item['destination'] as String? ?? '';
              final src = item['source'] as String? ?? '';
              final type = item['type'] as String? ?? 'file';
              final fileOnDisk = File(p.join(entity.path, dest));
              String? content;
              if (fileOnDisk.existsSync()) {
                try {
                  content = fileOnDisk.readAsStringSync();
                } catch (_) {}
              }
              artifacts.add({
                'source': src,
                'destination': dest,
                'type': type,
                'status': item['status'] ?? 'ok',
                'content': content,
              });
            }
          }
        } catch (e) {
          stdout.writeln(
            'Warning: Failed to parse manifest.json for $trialName: $e',
          );
        }
      }

      // Raw logs
      String? testStdout;
      final testStdoutFile = File(
        p.join(entity.path, 'verifier', 'test-stdout.txt'),
      );
      if (testStdoutFile.existsSync()) {
        testStdout = testStdoutFile.readAsStringSync();
      }

      String? exceptionLog;
      final exceptionFile = File(p.join(entity.path, 'exception.txt'));
      if (exceptionFile.existsSync()) {
        exceptionLog = exceptionFile.readAsStringSync();
      }

      final outcomeScore = _extractDimensionScore(rewardTree, 'outcome');
      final qualityScore = _extractDimensionScore(rewardTree, 'quality');
      final dxScore = _extractDimensionScore(rewardTree, 'dx');

      final evalKey = (config['eval_key'] as String?) ??
          (trialJson['eval_key'] as String?);

      trials.add({
        'trial_name': trialName,
        'task_name': taskName,
        'task_slug': taskSlug,
        'eval_key': evalKey,
        'agent_name': agentName,
        'model_name': modelName,
        'model_short_name': _shortModelName(modelName),
        'provider': _providerFromModel(modelName),
        'skills': skills,
        'mcp_servers': mcpServers,
        'has_dart_tooling': hasDartTooling,
        'status': status,
        'reward': reward,
        'outcome_score': outcomeScore,
        'quality_score': qualityScore,
        'dx_score': dxScore,
        'exception_type': exceptionType,
        'exception_message': exceptionMessage,
        'exception_traceback': exceptionTraceback,
        'durations': durations,
        'input_tokens': inputTokens,
        'cache_tokens': cacheTokens,
        'output_tokens': outputTokens,
        'cost_usd': costUsd,
        'reward_tree': rewardTree,
        'diagnostic_tree': diagnosticTree,
        'trajectory': trajectory,
        'artifacts': artifacts,
        'test_stdout': testStdout,
        'exception_log': exceptionLog,
      });
    }
  }

  // 3. Aggregate evals data
  final evalsList = <Map<String, Object?>>[];
  for (final entry in rawEvals.entries) {
    final evalKey = entry.key;
    final evalData = entry.value as Map<String, Object?>;
    final nTrials = (evalData['n_trials'] as num?)?.toInt() ?? 0;
    final nErrors = (evalData['n_errors'] as num?)?.toInt() ?? 0;

    final metricsList = (evalData['metrics'] as List<Object?>?) ?? [];
    var meanReward = 0.0;
    var minReward = 0.0;
    var maxReward = 0.0;
    var medianReward = 0.0;

    if (metricsList.isNotEmpty && metricsList.first is Map) {
      final m = metricsList.first as Map<String, Object?>;
      meanReward =
          (m['mean'] as num?)?.toDouble() ??
          (m['reward'] as num?)?.toDouble() ??
          0.0;
      minReward = (m['min'] as num?)?.toDouble() ?? meanReward;
      maxReward = (m['max'] as num?)?.toDouble() ?? meanReward;
      medianReward = (m['median'] as num?)?.toDouble() ?? meanReward;
    }

    final passAtK = (evalData['pass_at_k'] as Map<String, Object?>?) ?? {};
    final passAt1 = (passAtK['1'] as num?)?.toDouble() ?? 0.0;

    // Split evalKey: {agent}__{model}__{variant}
    final parts = evalKey.split('__');
    final agentName = parts.isNotEmpty ? parts[0] : 'unknown-agent';
    final modelName = parts.length > 1 ? parts[1] : 'unknown-model';
    final variant = parts.length > 2 ? parts[2] : '';

    // Find trials for this eval
    final evalTrials = trials
        .where(
          (t) =>
              (t['eval_key'] != null && t['eval_key'] == evalKey) ||
              ((t['model_short_name'] == modelName ||
                      t['model_name'] == modelName ||
                      (t['model_name'] as String).endsWith('/$modelName')) &&
                  ((t['agent_name'] as String).contains(agentName) ||
                      agentName.contains(t['agent_name'] as String))),
        )
        .toList();

    var cost = 0.0;
    var inTokens = 0;
    var outTokens = 0;
    var hasTooling = false;
    var outcomeScoreSum = 0.0;
    var qualityScoreSum = 0.0;
    var dxScoreSum = 0.0;
    var scoredTrialCount = 0;

    for (final t in evalTrials) {
      cost += (t['cost_usd'] as num?)?.toDouble() ?? 0.0;
      inTokens += (t['input_tokens'] as num?)?.toInt() ?? 0;
      outTokens += (t['output_tokens'] as num?)?.toInt() ?? 0;
      if (t['has_dart_tooling'] == true) hasTooling = true;

      if (t['status'] != 'error') {
        final o = t['outcome_score'] as num?;
        final q = t['quality_score'] as num?;
        final d = t['dx_score'] as num?;
        if (o != null || q != null || d != null) {
          if (o != null) outcomeScoreSum += o.toDouble();
          if (q != null) qualityScoreSum += q.toDouble();
          if (d != null) dxScoreSum += d.toDouble();
          scoredTrialCount++;
        }
      }
    }

    final meanOutcome =
        scoredTrialCount > 0 ? (outcomeScoreSum / scoredTrialCount) : null;
    final meanQuality =
        scoredTrialCount > 0 ? (qualityScoreSum / scoredTrialCount) : null;
    final meanDx =
        scoredTrialCount > 0 ? (dxScoreSum / scoredTrialCount) : null;

    evalsList.add({
      'eval_key': evalKey,
      'agent_name': agentName,
      'model_name': modelName,
      'model_short_name': _shortModelName(modelName),
      'provider': _providerFromModel(modelName),
      'variant': variant,
      'n_trials': nTrials,
      'n_errors': nErrors,
      'mean_reward': meanReward,
      'outcome_score': meanOutcome != null
          ? double.parse(meanOutcome.toStringAsFixed(2))
          : null,
      'quality_score': meanQuality != null
          ? double.parse(meanQuality.toStringAsFixed(2))
          : null,
      'dx_score': meanDx != null
          ? double.parse(meanDx.toStringAsFixed(2))
          : null,
      'min_reward': minReward,
      'max_reward': maxReward,
      'median_reward': medianReward,
      'pass_at_1': passAt1,
      'cost_usd': cost > 0 ? cost : (nTrials > 0 ? jobCostUsd : 0.0),
      'input_tokens': inTokens > 0
          ? inTokens
          : (nTrials > 0 ? jobInputTokens : 0),
      'output_tokens': outTokens > 0
          ? outTokens
          : (nTrials > 0 ? jobOutputTokens : 0),
      'has_dart_tooling': hasTooling,
    });
  }

  // Sort evals by mean_reward descending
  evalsList.sort(
    (a, b) => (b['mean_reward'] as num).toDouble().compareTo(
      (a['mean_reward'] as num).toDouble(),
    ),
  );

  // Compute top model and overall average reward
  final topModel = evalsList.isNotEmpty ? evalsList.first : null;
  final topModelName = topModel != null
      ? (topModel['model_short_name'] as String)
      : 'None';
  final topModelReward = topModel != null
      ? (topModel['mean_reward'] as num).toDouble()
      : 0.0;

  var totalScoreSum = 0.0;
  var completedCount = 0;
  for (final t in trials) {
    final r = t['reward'] as num?;
    if (r != null && t['status'] != 'error') {
      totalScoreSum += r.toDouble();
      completedCount++;
    }
  }
  final overallAverageReward = completedCount > 0
      ? totalScoreSum / completedCount
      : 0.0;

  // 4. Organize tasks (CUJs)
  final tasksMap = <String, Map<String, Object?>>{};
  for (final t in trials) {
    final slug = t['task_slug'] as String;
    final taskName = t['task_name'] as String;
    if (!tasksMap.containsKey(slug)) {
      tasksMap[slug] = {
        'slug': slug,
        'task_name': taskName,
        'display_name': _displayNameForTask(slug),
        'category': _categoryForTask(slug),
        'description': _descriptionForTask(slug),
        'trials': <Map<String, Object?>>[],
        'scores_by_eval': <String, Object?>{},
      };
    }
    final taskEntry = tasksMap[slug]!;
    (taskEntry['trials'] as List<Map<String, Object?>>).add({
      'trial_name': t['trial_name'],
      'status': t['status'],
      'reward': t['reward'],
      'model_name': t['model_name'],
      'model_short_name': t['model_short_name'],
      'agent_name': t['agent_name'],
      'has_dart_tooling': t['has_dart_tooling'],
      'exception_type': t['exception_type'],
    });

    // Score for eval
    final tEvalKey = t['eval_key'] as String?;
    final evalKey = (tEvalKey != null &&
            evalsList.any((e) => e['eval_key'] == tEvalKey))
        ? tEvalKey
        : evalsList.firstWhere(
            (e) {
              final em = e['model_name'] as String;
              final ea = e['agent_name'] as String;
              final tm = t['model_name'] as String;
              final tsm = t['model_short_name'] as String;
              final ta = t['agent_name'] as String;
              final modelMatch = tm == em || tsm == em || tm.endsWith('/$em');
              final agentMatch = ta.contains(ea) || ea.contains(ta);
              return modelMatch && agentMatch;
            },
            orElse: () => evalsList.firstWhere(
              (e) {
                final em = e['model_name'] as String;
                final tm = t['model_name'] as String;
                final tsm = t['model_short_name'] as String;
                return tm == em || tsm == em || tm.endsWith('/$em');
              },
              orElse: () => evalsList.first,
            ),
          )['eval_key'] as String;

    (taskEntry['scores_by_eval'] as Map<String, Object?>)[evalKey] = {
      'trial_name': t['trial_name'],
      'status': t['status'],
      'reward': t['reward'],
      'exception_type': t['exception_type'],
    };
  }

  final tasksList = tasksMap.values.toList();

  // 5. Best CUJs / Worst CUJs per eval
  for (final eval in evalsList) {
    final evalKey = eval['eval_key'] as String;
    final scoredTasks = <Map<String, Object?>>[];
    for (final task in tasksList) {
      final scores = task['scores_by_eval'] as Map<String, Object?>;
      if (scores.containsKey(evalKey)) {
        final sc = scores[evalKey] as Map<String, Object?>;
        scoredTasks.add({
          'task_slug': task['slug'],
          'task_name': task['display_name'],
          'reward': sc['reward'],
          'status': sc['status'],
        });
      }
    }
    scoredTasks.sort((a, b) {
      final ra = (a['reward'] as num?)?.toDouble() ?? -1.0;
      final rb = (b['reward'] as num?)?.toDouble() ?? -1.0;
      return rb.compareTo(ra);
    });

    eval['best_cujs'] = scoredTasks
        .where(
          (t) => (t['reward'] as num?) != null && (t['reward'] as num) > 0.5,
        )
        .take(3)
        .toList();
    eval['worst_cujs'] = scoredTasks.reversed
        .where(
          (t) =>
              t['status'] == 'error' ||
              ((t['reward'] as num?) != null && (t['reward'] as num) < 0.5),
        )
        .take(3)
        .toList();
  }

  // 6. Output structured data
  final dataDir = Directory(p.join(wwwDir, 'content', 'data', 'flutterbench'));
  dataDir.createSync(recursive: true);

  final jobData = {
    'id': jobId,
    'started_at': startedAt,
    'finished_at': finishedAt,
    'n_total_trials': nTotalTrials,
    'n_completed_trials': nCompletedTrials,
    'n_errored_trials': nErroredTrials,
    'cost_usd': jobCostUsd,
    'n_input_tokens': jobInputTokens,
    'n_cache_tokens': jobCacheTokens,
    'n_output_tokens': jobOutputTokens,
    'top_model_name': topModelName,
    'top_model_reward': topModelReward,
    'overall_average_reward': overallAverageReward,
    'evals': evalsList,
  };

  File(p.join(dataDir.path, 'job.json')).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(jobData),
  );

  File(p.join(dataDir.path, 'tasks.json')).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({'tasks': tasksList}),
  );

  File(p.join(dataDir.path, 'trials.json')).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({'trials': trials}),
  );

  stdout.writeln('Wrote structured JSON data to: ${dataDir.path}');

  // 7. Generate static Markdown pages
  final fbPagesDir = Directory(p.join(wwwDir, 'content', 'ai', 'flutterbench'));
  fbPagesDir.createSync(recursive: true);

  // /ai/flutterbench/index.md
  File(p.join(fbPagesDir.path, 'index.md')).writeAsStringSync('''---
title: FlutterBench Leaderboard
bodyTags: interior flutterbench
description: Benchmark results for AI coding agents on Dart and Flutter developer tasks.
publishDate: "2026-09-10"
---

<FlutterBenchLeaderboardPage />
''');

  // /ai/flutterbench/tasks/index.md
  final tasksDir = Directory(p.join(fbPagesDir.path, 'tasks'));
  tasksDir.createSync(recursive: true);
  File(p.join(tasksDir.path, 'index.md')).writeAsStringSync('''---
title: FlutterBench Tasks & CUJs
bodyTags: interior flutterbench
description: Explore Critical User Journeys (CUJs) and task performance across AI coding models in FlutterBench.
publishDate: "2026-09-10"
---

<FlutterBenchTasksPage />
''');

  // One page per task: /ai/flutterbench/tasks/<task-slug>.md
  for (final task in tasksList) {
    final slug = task['slug'] as String;
    final displayName = task['display_name'] as String;
    File(p.join(tasksDir.path, '$slug.md')).writeAsStringSync('''---
title: "FlutterBench Task: $displayName"
bodyTags: interior flutterbench
description: "Cross-model benchmark results and details for the $displayName task."
publishDate: "2026-09-10"
---

<FlutterBenchTaskDetailPage task="$slug" />
''');
  }

  // One page per trial: /ai/flutterbench/trials/<trial_name>.md
  final trialsDir = Directory(p.join(fbPagesDir.path, 'trials'));
  trialsDir.createSync(recursive: true);
  for (final trial in trials) {
    final trialName = trial['trial_name'] as String;
    final taskSlug = trial['task_slug'] as String;
    final displayName = _displayNameForTask(taskSlug);
    File(p.join(trialsDir.path, '$trialName.md')).writeAsStringSync('''---
title: "FlutterBench Trial: $trialName"
bodyTags: interior flutterbench
description: "Full scoring rubric, trajectory, artifacts, and logs for $displayName trial $trialName."
publishDate: "2026-09-10"
---

<FlutterBenchTrialDetailPage trial="$trialName" />
''');
  }

  // /ai/flutterbench/methodology.md
  File(p.join(fbPagesDir.path, 'methodology.md')).writeAsStringSync('''---
title: FlutterBench Methodology
bodyTags: interior flutterbench methodology
description: Detailed explanation of the FlutterBench harness, three-dimensional scoring rubric, and reproduction steps.
publishDate: "2026-09-10"
---

# FlutterBench Methodology

FlutterBench is Flutter's dedicated evaluation harness for measuring how autonomous AI coding agents perform on real-world Dart and Flutter development tasks.

Unlike general code benchmarks that rely on isolated algorithm puzzles or synthetic docstring completions, FlutterBench tests agents against authentic developer workflows grounded in Flutter's canonical **Critical User Journeys (CUJs)**.

---

## Core Principles

1. **Realistic Tasks over Synthetic Puzzles**: Every task tests a real feature implementation, bug fix, or refactoring in a realistic Flutter or Dart codebase.
2. **Developer Experience (DX) is a First-Class Signal**: We measure not just whether the final code compiles, but tool accuracy, trajectory efficiency, and recovery from errors.
3. **Containerized Sandboxing**: All trials run inside isolated Docker containers with pre-installed Flutter SDKs and the official Dart MCP server.
4. **Weighted Multi-Dimensional Scoring**: A composite reward evaluates outcome, quality, and developer experience, while capturing diagnostic telemetry separately.

---

## Three-Dimensional Scoring Rubric

Each trial produces a normalized composite reward between `0.0` and `1.0`:

\$\$\\text{Reward} = 0.60 \\times \\text{Outcome} + 0.30 \\times \\text{Quality} + 0.10 \\times \\text{DX}\$\$

| Dimension | Weight | Description | Evaluation Mechanism |
| :--- | :--- | :--- | :--- |
| **Outcome** | 60% | Functional correctness and feature completion | `flutter test`, `flutter build bundle`, heuristic event assertion |
| **Quality** | 30% | Architectural conventions, idiomatic code, maintainability | `dart analyze`, DCM, LLM judge rubrics |
| **DX (Developer Experience)** | 10% | Tool interaction accuracy, minimal thrash, clean trajectory | Dart MCP telemetry, plan adherence, error loops |

### Diagnostic Telemetry (Unscored)

Separate telemetry blocks track **Process** and **Efficiency**:
- **Process**: Number of prompt turns, reasoning quality, and recovery velocity.
- **Efficiency**: Token usage (input, cache, and output tokens) and wall-clock execution time.

These diagnostic metrics are reported alongside trials for observability, but are strictly excluded from the composite reward.

---

## Task Anatomy

Each FlutterBench task directory contains:
- **Instruction**: Natural developer prompt describing the target user journey.
- **Codebase**: Seed workspace repository containing initial project structure and dependencies.
- **Graders**: Verification scripts (`tests/graders.dart`, unit test suites, static analysis checks).
- **Environment**: Docker container specification defining SDK constraints and tool permissions.

---

## Trial Execution Phases

Each trial proceeds through four distinct, timed phases:

1. **Environment Setup**: Container initialization, caching, and volume mounts.
2. **Agent Setup**: Workspace cloning, dependency resolution, and MCP tool initialization.
3. **Agent Execution**: Autonomous problem-solving, code generation, and iterative refinement.
4. **Verifier**: Automated test execution, static analysis grading, and LLM rubric evaluation.

---

## Reproducing Results

To reproduce benchmark trials locally using the Harbor evaluation runner:

```bash
# Clone the evaluation task repository
git clone https://github.com/flutter/evals.git
cd evals

# Run an individual trial
harbor run \\
  --task dataset/flutter/manage-state-with-bloc \\
  --agent antigravity-sdk \\
  --model google/gemini-3.5-flash \\
  --mcp dart
```

For questions or to contribute new CUJ evaluation tasks, visit the [Flutter repository on GitHub](https://github.com/flutter/flutter).
''');

  stdout.writeln('Successfully generated FlutterBench content and data pages.');
}

String _slugFromTrial(String trialName, String taskName) {
  if (trialName.contains('__')) {
    return trialName.split('__').first;
  }
  if (taskName.contains('/')) {
    return taskName.split('/').last;
  }
  return taskName.replaceAll(' ', '-').toLowerCase();
}

String _displayNameForTask(String slug) {
  switch (slug) {
    case 'flutter-manage-state-with-bloc':
      return 'Manage State with BLoC';
    case 'flutter-adaptive-material-cupertino':
      return 'Adaptive Material & Cupertino UI';
    case 'dart-build-cli-app':
      return 'Build Command-Line CLI App';
    case 'flutter-custom-render-object':
      return 'Custom RenderObject & Canvas';
    case 'flutter-offline-sync-sqlite':
      return 'Offline SQLite Sync Repository';
    default:
      return slug
          .split('-')
          .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
          .join(' ');
  }
}

String _categoryForTask(String slug) {
  switch (slug) {
    case 'flutter-manage-state-with-bloc':
      return 'State Management';
    case 'flutter-adaptive-material-cupertino':
      return 'Multi-Platform UI';
    case 'dart-build-cli-app':
      return 'Dart Utilities';
    case 'flutter-custom-render-object':
      return 'Advanced Rendering';
    case 'flutter-offline-sync-sqlite':
      return 'Data & Storage';
    default:
      return 'General';
  }
}

String _descriptionForTask(String slug) {
  switch (slug) {
    case 'flutter-manage-state-with-bloc':
      return 'Implement an immutable state management layer using package:flutter_bloc, connecting UI events to business logic with unit tests.';
    case 'flutter-adaptive-material-cupertino':
      return 'Build adaptive Flutter widgets that render Material 3 on Android/Web and native Cupertino patterns on iOS/macOS.';
    case 'dart-build-cli-app':
      return 'Create a robust Dart command-line interface application with argument parsing, formatted output, and exit code handling.';
    case 'flutter-custom-render-object':
      return 'Implement a custom RenderBox with layout constraints, custom painting, intrinsic dimensions, and pointer hit-testing.';
    case 'flutter-offline-sync-sqlite':
      return 'Build an offline-first repository using SQLite with background synchronization, retry queues, and conflict resolution.';
    default:
      return 'Benchmark evaluation task for Flutter and Dart AI agent capabilities.';
  }
}

String _shortModelName(String modelName) {
  var name = modelName;
  if (name.contains('/')) {
    name = name.split('/').last;
  }
  return name
      .replaceAll('google/', '')
      .replaceAll('anthropic/', '')
      .replaceAll('openai/', '')
      .replaceAll('deepseek/', '');
}

String _providerFromModel(String modelName) {
  final lower = modelName.toLowerCase();
  if (lower.contains('gemini') || lower.contains('google')) {
    return 'Google';
  }
  if (lower.contains('claude') || lower.contains('anthropic')) {
    return 'Anthropic';
  }
  if (lower.contains('deepseek')) {
    return 'DeepSeek';
  }
  if (lower.contains('gpt') ||
      lower.contains('openai') ||
      lower.startsWith('o1') ||
      lower.startsWith('o3') ||
      lower.contains('/o1') ||
      lower.contains('/o3')) {
    return 'OpenAI';
  }
  return 'Community';
}

String _findRepoRoot() {
  var dir = Directory.current;
  while (true) {
    if (File(p.join(dir.path, 'AGENTS.md')).existsSync() &&
        Directory(p.join(dir.path, 'sites', 'www')).existsSync()) {
      return dir.path;
    }
    if (dir.path == dir.parent.path) break;
    dir = dir.parent;
  }
  return '/Users/ewindmill/development/website';
}

double? _extractDimensionScore(
  Map<String, Object?>? rewardTree,
  String dimName,
) {
  if (rewardTree == null) return null;
  if (rewardTree[dimName] is Map) {
    final dimNode = rewardTree[dimName] as Map<String, Object?>;
    if (dimNode['score'] is num) {
      return (dimNode['score'] as num).toDouble();
    }
  }
  if (rewardTree['reward'] is Map) {
    final rewardNode = rewardTree['reward'] as Map<String, Object?>;
    if (rewardNode['criteria'] is List) {
      for (final crit in rewardNode['criteria'] as List) {
        if (crit is Map && crit['name'] == dimName) {
          if (crit['value'] is num) {
            return (crit['value'] as num).toDouble();
          }
          if (crit['score'] is num) {
            return (crit['score'] as num).toDouble();
          }
        }
      }
    }
  }
  return null;
}
