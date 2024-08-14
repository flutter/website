// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../utils.dart';

final class FormatDartCommand extends Command<int> {
  static const String _checkFlag = 'check';

  FormatDartCommand() {
    argParser.addFlag(
      _checkFlag,
      defaultsTo: false,
      help: 'Just check the formatting, do not update.',
    );
  }

  @override
  String get description => 'Format or check formatting of the site '
      'examples and tools.';

  @override
  String get name => 'format-dart';

  @override
  Future<int> run() async => formatDart(
        justCheck: argResults.get<bool>(_checkFlag, false),
      );
}

int formatDart({bool justCheck = false}) {
  // Currently format all Dart files in the /tool directory
  // and everything in /examples.
  final directoriesToFormat = [
    'tool',
    ...Directory('examples')
        .listSync()
        .whereType<Directory>()
        .map((e) => e.path)
        .where((e) =>
            path.basename(e) != 'codelabs' &&
            !path.basename(e).startsWith('.')),
  ];

  final dartFormatOutput = Process.runSync(Platform.resolvedExecutable, [
    'format',
    if (justCheck) ...['-o', 'none'], // Don't make changes if just checking.
    ...directoriesToFormat,
  ]);

  final normalOutput = dartFormatOutput.stdout.toString();
  final errorOutput = dartFormatOutput.stderr.toString();

  stdout.write(normalOutput);

  if (dartFormatOutput.exitCode != 0) {
    stderr.writeln('Error: Failed to run dart format:');
    stderr.write(errorOutput);
    return 1;
  }

  // If just checking formatting, exit with error code if any files changed.
  if (justCheck && !normalOutput.contains('(0 changed)')) {
    stderr.writeln('Error: Some files needed to be formatted!');
    return 1;
  }

  return 0;
}
