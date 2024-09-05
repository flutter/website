// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';

import '../utils.dart';

final class ServeSiteCommand extends Command<int> {
  static const String _verboseFlag = 'verbose';

  ServeSiteCommand() {
    argParser.addFlag(
      _verboseFlag,
      defaultsTo: false,
      help: 'Show verbose logging.',
    );
  }

  @override
  String get description => 'Serve the site locally.';

  @override
  String get name => 'serve';

  @override
  Future<int> run() async {
    print('Building and serving site. This might take awhile...');

    final verbose = argResults.get<bool>(_verboseFlag, false);
    final process = await Process.start(
      'npx',
      const ['eleventy', '--serve', '--incremental'],
      environment: {
        'PRODUCTION': 'false',
        if (verbose) 'DEBUG': 'Eleventy*',
      },
      runInShell: true,
      mode: ProcessStartMode.inheritStdio,
    );

    final processExitCode = await process.exitCode;
    return processExitCode;
  }
}
