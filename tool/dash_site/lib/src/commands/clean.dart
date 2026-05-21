// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../sites.dart';
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

    if (installJasprCliIfNecessary() case final jasprInstallResult
        when jasprInstallResult != 0) {
      return jasprInstallResult;
    }

    final selectedSite = this.selectedSite;

    final process = await Process.start(
      Platform.resolvedExecutable,
      ['pub', 'global', 'run', 'jaspr_cli:jaspr', 'clean', '--kill'],
      workingDirectory: selectedSite.directory,
      mode: ProcessStartMode.inheritStdio,
    );

    final processExitCode = await process.exitCode;

    print('Cleaning the site output directory...');
    final outputDirectory = Directory(
      path.join(repositoryRoot, selectedSite.buildOutputDirectory),
    );
    if (outputDirectory.existsSync()) {
      outputDirectory.deleteSync(recursive: true);
    }

    return processExitCode;
  }
}
