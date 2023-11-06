// Copyright 2023 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../utils.dart';

final class AnalyzeDartCommand extends Command<int> {
  @override
  String get description => 'Run analysis on the site infra and examples.';

  @override
  String get name => 'analyze-dart';

  @override
  Future<int> run() async => analyzeDart();
}

int analyzeDart() {
  final directoriesToAnalyze = [
    path.join('tool', 'flutter_site'),
    ...dartProjectExampleDirectories,
  ];

  for (final directory in directoriesToAnalyze) {
    print('Analyzing code in $directory...');

    final flutterAnalyzeOutput = Process.runSync(
      'flutter',
      [
        'analyze',
        '--no-suggestions',
      ],
      workingDirectory: directory,
      includeParentEnvironment: false,
    );

    if (flutterAnalyzeOutput.exitCode != 0) {
      final normalOutput = flutterAnalyzeOutput.stdout.toString();
      final errorOutput = flutterAnalyzeOutput.stderr.toString();

      stderr.write(normalOutput);
      stderr.write(errorOutput);
      stderr.writeln('ERROR: Analysis on $directory failed.');
      return 1;
    } else {
      print('Successfully analyzed code in $directory!');
    }
  }

  return 0;
}
