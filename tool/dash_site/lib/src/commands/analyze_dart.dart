// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

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
  Future<int> run() async =>
      analyzeDart(verboseLogging: argResults.get<bool>(_verboseFlag, false));
}

int analyzeDart({bool verboseLogging = false}) {
  final directoriesToAnalyze = [
    path.join('site'),
    path.join('tool', 'dash_site'),
    path.join('examples'),
  ];

  if (!verboseLogging) {
    print('Analyzing code...');
  }

  for (final directory in directoriesToAnalyze) {
    if (verboseLogging) {
      print("Analyzing code in '$directory' directory...");
    }

    if (runPubGetIfNecessary(directory) case final pubGetResult
        when pubGetResult != 0) {
      return pubGetResult;
    }

    final flutterAnalyzeOutput = Process.runSync('flutter', const [
      'analyze',
      '.',
    ], workingDirectory: directory);

    if (flutterAnalyzeOutput.exitCode != 0) {
      final normalOutput = flutterAnalyzeOutput.stdout.toString();
      final errorOutput = flutterAnalyzeOutput.stderr.toString();

      stderr.write(normalOutput);
      stderr.write(errorOutput);
      stderr.writeln("Error: Analysis on '$directory' directory failed.");
      return 1;
    } else {
      if (verboseLogging) {
        print("Successfully analyzed code in '$directory' directory!");
      }
    }
  }

  print('No issues found while analyzing!');

  return 0;
}
