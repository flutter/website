// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';

import '../utils.dart';

final class AnalyzeDartCommand extends Command<int> {
  static const String _verboseFlag = 'verbose';

  AnalyzeDartCommand() {
    argParser.addFlag(
      _verboseFlag,
      defaultsTo: false,
      help: 'Show verbose logging.',
    );
  }

  @override
  String get description => 'Run analysis on the site infra and examples.';

  @override
  String get name => 'analyze-dart';

  @override
  Future<int> run() async => analyzeDart(
        verboseLogging: argResults.get<bool>(_verboseFlag, false),
      );
}

int analyzeDart({
  bool verboseLogging = false,
}) {
  if (!verboseLogging) {
    print('Analyzing code...');
  }

  final flutterAnalyzeOutput = Process.runSync(
    'flutter',
    const ['analyze', '.'],
  );

  if (flutterAnalyzeOutput.exitCode != 0) {
    final normalOutput = flutterAnalyzeOutput.stdout.toString();
    final errorOutput = flutterAnalyzeOutput.stderr.toString();

    stderr.write(normalOutput);
    stderr.write(errorOutput);
    stderr.writeln('Error: Analysis failed.');
    return 1;
  } else {
    if (verboseLogging) {
      print('Successfully analyzed Dart code!');
    }
  }

  print('No issues found while analyzing!');

  return 0;
}
