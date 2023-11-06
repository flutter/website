// Copyright 2023 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../utils.dart';

final class TestDartCommand extends Command<int> {
  @override
  String get description => 'Run tests on the site infra and examples.';

  @override
  String get name => 'test-dart';

  @override
  Future<int> run() async => testDart();
}

int testDart() {
  final directoriesToTest = [
    path.join('tool', 'flutter_site'),
    ...dartProjectExampleDirectories,
  ];

  for (final directory in directoriesToTest) {
    print('Testing code in $directory...');

    final flutterTestOutput = Process.runSync(
      'flutter',
      [
        'test',
        '--reporter',
        'expanded', // Non-animated expanded output looks better in CI and logs.
      ],
      workingDirectory: directory,
    );

    if (flutterTestOutput.exitCode != 0) {
      final normalOutput = flutterTestOutput.stdout.toString();
      final errorOutput = flutterTestOutput.stderr.toString();

      // It's ok if the test directory is not found.
      if (!errorOutput.contains(RegExp(r'Test directory.*not found'))) {
        stderr.write(normalOutput);
        stderr.writeln('ERROR: Tests in $directory failed:');
        stderr.write(errorOutput);
        return 1;
      }

      print('No tests found or ran in $directory.');
    } else {
      print('All tests passed in $directory.');
    }
  }

  return 0;
}
