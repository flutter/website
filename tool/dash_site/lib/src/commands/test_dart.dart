// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../sites.dart';
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
  String get description => 'Run tests on the sites, site infra, and examples.';

  @override
  String get name => 'test-dart';

  @override
  Future<int> run() async =>
      _testDart(verboseLogging: argResults.get<bool>(_verboseFlag, false));
}

Future<int> _testDart({bool verboseLogging = false}) async {
  final directoriesToTest = <(String directory, String executable)>[
    (path.join('tool', 'dash_site'), 'dart'),
    for (final site in Site.values)
      if (Directory(path.join(site.directory, 'test')).existsSync())
        (site.directory, 'dart'),
    for (final directory in exampleProjectDirectories) (directory, 'flutter'),
  ];

  print('Testing code...');

  final failedTests = <String>[
    for (final (directory, executable) in directoriesToTest)
      if (!(await testsPassInDirectory(
        directory,
        verboseLogging,
        executable: executable,
      )))
        directory,
  ];

  if (failedTests.isNotEmpty) {
    stderr.writeln('\nError: ${failedTests.length} tests failed!');
    return 1;
  }

  print('All tests passed successfully!');

  return 0;
}

Future<bool> testsPassInDirectory(
  String directory,
  bool verboseLogging, {
  String executable = 'flutter',
}) async {
  if (verboseLogging) {
    print('Testing code in $directory with $executable test...');
  }

  final testOutput = await Process.run(executable, [
    'test',
    '--reporter',
    'expanded', // Non-animated expanded output looks better in CI and logs.
  ], workingDirectory: directory);

  if (testOutput.exitCode != 0) {
    final normalOutput = testOutput.stdout.toString();
    final errorOutput = testOutput.stderr.toString();

    // It's ok if the test directory is not found.
    if (!errorOutput.contains('No test') &&
        !normalOutput.contains('No test files were passed') &&
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
