// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../review_server.dart';
import '../sites.dart';
import '../utils.dart';

final class ServeSiteCommand extends Command<int> {
  static const String _releaseFlag = 'release';
  static const String _reviewFlag = 'review';

  @override
  String get description => 'Serve the site locally.';

  @override
  String get name => 'serve';

  ServeSiteCommand() {
    argParser
      ..addFlag(
        _releaseFlag,
        defaultsTo: false,
        help:
            'Build with compilers used for release builds instead of dartdevc.',
      )
      ..addFlag(
        _reviewFlag,
        defaultsTo: true,
        help:
            'Enable the visual review toolbar and sync comments to '
            '.dash_review/feedback.md.',
      );
  }

  @override
  Future<int> run() async {
    if (installJasprCliIfNecessary() case final jasprInstallResult
        when jasprInstallResult != 0) {
      return jasprInstallResult;
    }

    final release = argResults!.flag(_releaseFlag);
    final enableReview = argResults!.flag(_reviewFlag);
    final selectedSite = this.selectedSite;

    ReviewLocalServer? reviewServer;
    StreamSubscription<ProcessSignal>? sigintSubscription;
    StreamSubscription<ProcessSignal>? sigtermSubscription;

    try {
      if (enableReview) {
        reviewServer = await ReviewLocalServer.start(
          repoRoot: repositoryRoot,
          site: selectedSite.name,
        );
        print(
          'Visual review toolbar active -> syncing to '
          '.dash_review/feedback.md '
          '(API: http://127.0.0.1:${reviewServer.port})',
        );
      }

      final process = await Process.start(
        Platform.resolvedExecutable,
        buildJasprServeArgs(
          selectedSite,
          release: release,
          reviewServerPort: reviewServer?.port,
        ),
        workingDirectory: selectedSite.directory,
        environment: jasprProcessEnvironment(),
        runInShell: true,
        mode: ProcessStartMode.inheritStdio,
      );

      Future<void> handleSignal(ProcessSignal signal) async {
        await reviewServer?.close();
        process.kill(signal);
      }

      sigintSubscription = ProcessSignal.sigint.watch().listen(
        (signal) => unawaited(handleSignal(signal)),
      );
      if (!Platform.isWindows) {
        sigtermSubscription = ProcessSignal.sigterm.watch().listen(
          (signal) => unawaited(handleSignal(signal)),
        );
      }

      return await process.exitCode;
    } finally {
      await sigintSubscription?.cancel();
      await sigtermSubscription?.cancel();
      await reviewServer?.close();
    }
  }
}

/// Constructs the `jaspr serve` CLI arguments for [site].
List<String> buildJasprServeArgs(
  Site site, {
  required bool release,
  int? reviewServerPort,
}) {
  final jasprPorts = site.jasprPorts;
  return [
    'pub',
    'global',
    'run',
    'jaspr_cli:jaspr',
    'serve',
    '--port=${jasprPorts.serve}',
    '--web-port=${jasprPorts.webDev}',
    '--proxy-port=${jasprPorts.proxy}',
    '--dart-define=PRODUCTION=false',
    ...nonProductionDartDefines(),
    if (reviewServerPort != null) ...[
      '--dart-define=DASH_REVIEW_MODE=local',
      '--dart-define=DASH_REVIEW_SITE=${site.name}',
      '--dart-define=DASH_REVIEW_SERVER_PORT=$reviewServerPort',
    ],
    if (release) '--release',
  ];
}
