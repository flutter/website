// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:io/io.dart' as io;
import 'package:path/path.dart' as path;

import '../utils.dart';

final class BuildSiteCommand extends Command<int> {
  static const String _releaseFlag = 'release';

  BuildSiteCommand() {
    argParser.addFlag(
      _releaseFlag,
      defaultsTo: false,
      help:
          'Build a release build for docs.flutter.dev. '
          'Optimizes site resources.',
    );
  }

  @override
  String get description => 'Build the site.';

  @override
  String get name => 'build';

  @override
  Future<int> run() async {
    installJasprCliIfNecessary();

    final productionRelease = argResults.get<bool>(_releaseFlag, false);

    final process = await Process.start(
      Platform.resolvedExecutable,
      [
        'pub',
        'global',
        'run',
        'jaspr_cli:jaspr',
        'build',
        // Use build_web_compiler options specified in build.yaml instead of
        // those specified by jaspr_cli.
        '--no-managed-build-options',
        '--sitemap-domain=https://docs.flutter.dev',
        '--dart-define=PRODUCTION=$productionRelease',
      ],
      workingDirectory: 'site',
      mode: ProcessStartMode.inheritStdio,
    );

    final processExitCode = await process.exitCode;

    final originalOutputDirectoryPath = path.join(
      repositoryRoot,
      'site',
      'build',
      'jaspr',
    );
    if (!Directory(originalOutputDirectoryPath).existsSync()) {
      stderr.writeln(
        'Error: Jaspr output directory not found at: '
        '$originalOutputDirectoryPath',
      );
      return 1;
    }

    // Copy the entire site output to the _site directory.
    io.copyPathSync(originalOutputDirectoryPath, siteOutputDirectoryPath);

    _move404File();

    return processExitCode;
  }
}

/// Moves the 404 file to the location expected by Firebase hosting.
void _move404File() {
  final initial404Directory = path.join(siteOutputDirectoryPath, '404');
  final original404File = File(path.join(initial404Directory, 'index.html'));
  if (original404File.existsSync()) {
    // If the 404 is in its own directory,
    // copy the 404.html file to the root of the output directory.
    original404File.copySync(path.join(siteOutputDirectoryPath, '404.html'));
    Directory(initial404Directory).deleteSync(recursive: true);
  }
}
