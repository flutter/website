// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../sites.dart';
import '../utils.dart';
import 'build.dart';

final class DeployCommand extends Command<int> {
  @override
  String get description =>
      'Build a production release of the site and '
      'deploy it to Firebase hosting.';

  @override
  String get name => 'deploy';

  @override
  Future<int> run() async {
    final selectedSite = this.selectedSite;

    if (await buildSite(selectedSite, productionRelease: true)
        case final buildResult when buildResult != 0) {
      return buildResult;
    }

    print('Deploying ${selectedSite.host} to production...');
    final deploy = await Process.start(
      'firebase',
      ['deploy', '--only=hosting'],
      workingDirectory: path.join(
        repositoryRoot,
        selectedSite.firebaseConfigDirectory,
      ),
      mode: ProcessStartMode.inheritStdio,
    );
    return deploy.exitCode;
  }
}
