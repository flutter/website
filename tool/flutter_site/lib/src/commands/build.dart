// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';

import '../utils.dart';

final class BuildSiteCommand extends Command<int> {
  static const String _releaseFlag = 'release';

  BuildSiteCommand() {
    argParser.addFlag(
      _releaseFlag,
      defaultsTo: false,
      help: 'Build a release build for docs.flutter.dev. '
          'Optimizes site resources.',
    );
  }

  @override
  String get description => 'Build the site.';

  @override
  String get name => 'build';

  @override
  Future<int> run() async {
    final productionRelease = argResults.get<bool>(_releaseFlag, false);

    final process = await Process.start(
      'npx',
      const ['eleventy'],
      environment: {
        'PRODUCTION': '$productionRelease',
        'OPTIMIZE': '$productionRelease',
      },
    );

    await stdout.addStream(process.stdout);
    await stderr.addStream(process.stderr);

    final processExitCode = await process.exitCode;
    return processExitCode;
  }
}
