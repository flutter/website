// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../utils.dart';

final class TestDartCommand extends Command<int> {
  static const String _verboseFlag = 'verbose';

  TestDartCommand() {
    argParser.addFlag(
      _verboseFlag,
      defaultsTo: false,
      help: 'Show verbose logging.',
    );
  }

  @override
  String get description => 'Run tests on the site infra and examples.';

  @override
  String get name => 'test-dart';

  @override
  Future<int> run() async =>
      _testDart(verboseLogging: argResults.get<bool>(_verboseFlag, false));
}

Future<int> _testDart({bool verboseLogging = false}) async {
  final directoriesToTest = [
    path.join('tool', 'dash_site'),
    ...exampleProjectDirectories,
  ];

  print('Testing code...');

  final failedTests = <String>[
    for (final directory in directoriesToTest)
      if (!(await testsPassInDirectory(directory, verboseLogging))) directory,
  ];

  if (failedTests.isNotEmpty) {
    stderr.writeln('\nError: ${failedTests.length} tests failed!');
    return 1;
  }

  print('All tests passed successfully!');

  return 0;
}

Future<bool> testsPassInDirectory(String directory, bool verboseLogging) async {
  if (verboseLogging) {
    print('Testing code in $directory...');
  }

  final flutterTestOutput = await Process.run('flutter', [
    'test',
    '--reporter',
    'expanded', // Non-animated expanded output looks better in CI and logs.
  ], workingDirectory: directory);

  if (flutterTestOutput.exitCode != 0) {
    final normalOutput = flutterTestOutput.stdout.toString();
    final errorOutput = flutterTestOutput.stderr.toString();

    // It's ok if the test directory is not found.
    if (!errorOutput.contains('No test') &&
        !normalOutput.contains('Could not find package `test`') &&
        !normalOutput.contains('No tests were') &&
        !errorOutput.contains(RegExp(r'Test directory.*not found'))) {
      stderr.write(normalOutput);
      stderr.writeln('Tests in $directory failed:');
      stderr.write(errorOutput);
      return false;
    }

    if (verboseLogging) {
      print('No tests found or ran in $directory.');
    }
  } else {
    if (verboseLogging) {
      print('All tests passed in $directory.');
    }
  }

  return true;
}
