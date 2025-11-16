// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';

import '../utils.dart';

final class ServeSiteCommand extends Command<int> {
  @override
  String get description => 'Serve the site locally.';

  @override
  String get name => 'serve';

  ServeSiteCommand() {
    argParser.addFlag(
      'release',
      defaultsTo: false,
      help: 'Build with compilers used for release builds instead of dartdevc.',
    );
  }

  @override
  Future<int> run() async {
    final release = argResults!.flag('release');

    installJasprCliIfNecessary();

    final process = await Process.start(
      Platform.resolvedExecutable,
      [
        'pub',
        'global',
        'run',
        'jaspr_cli:jaspr',
        'serve',
        // Use build_web_compiler options specified in build.yaml instead of
        // those specified by jaspr_cli.
        '--no-managed-build-options',
        '--dart-define=PRODUCTION=false',
        if (release) '--release',
      ],
      workingDirectory: 'site',
      runInShell: true,
      mode: ProcessStartMode.inheritStdio,
    );

    final processExitCode = await process.exitCode;
    return processExitCode;
  }
}
