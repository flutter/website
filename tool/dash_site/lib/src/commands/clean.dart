// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';

import '../utils.dart';

final class CleanSiteCommand extends Command<int> {
  CleanSiteCommand();

  @override
  String get description => 'Clean the site output folder and tooling.';

  @override
  String get name => 'clean';

  @override
  Future<int> run() async {
    print('Cleaning the Jaspr setup...');

    installJasprCliIfNecessary();

    final process = await Process.start(
      Platform.resolvedExecutable,
      ['pub', 'global', 'run', 'jaspr_cli:jaspr', 'clean', '--kill'],
      workingDirectory: 'site',
      mode: ProcessStartMode.inheritStdio,
    );

    final processExitCode = await process.exitCode;

    print('Cleaning the site output directory...');
    final outputDirectory = Directory(siteOutputDirectoryPath);
    if (outputDirectory.existsSync()) {
      outputDirectory.deleteSync(recursive: true);
    }

    return processExitCode;
  }
}
