// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../firebase.dart';
import '../sites.dart';
import '../utils.dart';
import 'build.dart';

/// Builds and deploys the selected site to Firebase Hosting.
final class DeployCommand extends Command<int> {
  static const String _projectOption = 'project';
  static const String _onlyOption = 'only';

  DeployCommand() {
    argParser
      ..addOption(
        _projectOption,
        help:
            'The Firebase project ID or alias to deploy to. '
            'Defaults to the selected site production project. '
            'Use this to test deploys against a personal Firebase project.',
        valueHelp: 'project-id',
      )
      ..addOption(
        _onlyOption,
        defaultsTo: 'hosting',
        help:
            'The Firebase deploy target. '
            'Use "hosting:target" for projects with multiple Hosting targets.',
        valueHelp: 'hosting[:target]',
      );
  }

  @override
  String get description =>
      'Build a production release of the site and '
      'deploy it to Firebase Hosting.';

  @override
  String get name => 'deploy';

  @override
  Future<int> run() async {
    final selectedSite = this.selectedSite;
    final argResults = this.argResults!;
    final project =
        argResults.option(_projectOption) ??
        selectedSite.defaultFirebaseProjectId;
    final only = argResults.option(_onlyOption)!;

    final firebaseToolsVersion = await validateFirebaseCli();
    if (firebaseToolsVersion == null) {
      return 1;
    }

    if (await buildSite(selectedSite, productionRelease: true)
        case final buildResult when buildResult != 0) {
      return buildResult;
    }

    print('Using firebase-tools $firebaseToolsVersion.');
    print(
      'Deploying ${selectedSite.host} to Firebase project $project '
      'with target $only...',
    );
    final deploy = await Process.start(
      firebaseCliExecutable,
      ['deploy', '--project=$project', '--only=$only'],
      workingDirectory: path.join(
        repositoryRoot,
        selectedSite.firebaseConfigDirectory,
      ),
      mode: ProcessStartMode.inheritStdio,
    );
    return deploy.exitCode;
  }
}
