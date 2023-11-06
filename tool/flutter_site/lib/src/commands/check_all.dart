// Copyright 2023 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:args/command_runner.dart';

import 'analyze_dart.dart';
import 'format_dart.dart';
import 'refresh_excerpts.dart';
import 'test_dart.dart';
import 'verify_firebase_json.dart';

final class CheckAllCommand extends Command<int> {
  @override
  String get description => 'Run all site tests and verification.';

  @override
  String get name => 'check-all';

  @override
  Future<int> run() async {
    // All verification tasks that can be ran without building the site.
    final tasks = <FutureOr<int> Function()>[
      verifyFirebaseJson,
      () => formatDart(justCheck: true),
      analyzeDart,
      testDart,
      () => refreshExcerpts(failOnUpdate: true, outputDiff: true),
    ];

    for (final task in tasks) {
      final taskResult = task.call();
      if (taskResult != 0) {
        return taskResult;
      }
    }

    return 0;
  }
}
