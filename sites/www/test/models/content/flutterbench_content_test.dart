// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_website/src/models/content/flutterbench_content.dart';
import 'package:test/test.dart';

void main() {
  group('FlutterBenchJobData.fromJson', () {
    test('decodes production job.json file successfully', () {
      final file = File('content/data/flutterbench/job.json');
      expect(file.existsSync(), isTrue);

      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final job = FlutterBenchJobData.fromJson(json);

      expect(job.id, isNotEmpty);
      expect(job.startedAt, isNotEmpty);
      expect(job.nTotalTrials, greaterThan(0));
      expect(job.evals, isNotEmpty);

      final firstEval = job.evals.first;
      expect(firstEval.evalKey, isNotEmpty);
      expect(firstEval.modelName, isNotEmpty);
      expect(firstEval.passAt1, greaterThanOrEqualTo(0.0));
      expect(firstEval.meanReward, greaterThanOrEqualTo(0.0));
      expect(firstEval.outcomeScore, isNotNull);
      expect(firstEval.qualityScore, isNotNull);
      expect(firstEval.dxScore, isNotNull);
    });
  });

  group('FlutterBenchTasksData.fromJson', () {
    test('decodes production tasks.json file successfully', () {
      final file = File('content/data/flutterbench/tasks.json');
      expect(file.existsSync(), isTrue);

      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final tasksData = FlutterBenchTasksData.fromJson(json);

      expect(tasksData.tasks, isNotEmpty);
      final task = tasksData.tasks.first;
      expect(task.slug, isNotEmpty);
      expect(task.displayName, isNotEmpty);
      expect(task.category, isNotEmpty);
      expect(task.trials, isNotEmpty);
    });
  });

  group('FlutterBenchTrialsData.fromJson', () {
    test('decodes production trials.json file successfully', () {
      final file = File('content/data/flutterbench/trials.json');
      expect(file.existsSync(), isTrue);

      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final trialsData = FlutterBenchTrialsData.fromJson(json);

      expect(trialsData.trials, isNotEmpty);

      // Verify that errored trial has distinct exception properties
      final errorTrial = trialsData.trials.firstWhere(
        (t) => t.status == 'error',
        orElse: () => throw StateError('Expected an error trial in test data'),
      );
      expect(errorTrial.exceptionType, isNotNull);
      expect(errorTrial.reward, isNull);

      // Verify passing / partial trial has valid scores and durations
      final passedTrial = trialsData.trials.firstWhere(
        (t) => t.status != 'error',
      );
      expect(passedTrial.reward, isNotNull);
      expect(passedTrial.durations, isNotEmpty);
    });
  });
}
