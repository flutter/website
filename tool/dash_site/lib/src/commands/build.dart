// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../sites.dart';
import '../utils.dart';

final class BuildSiteCommand extends Command<int> {
  static const String _releaseFlag = 'release';
  static const String _reviewModeOption = 'review-mode';
  static const String _reviewServerPortOption = 'review-server-port';
  static const String _dartDefineMultiOption = 'dart-define';

  BuildSiteCommand() {
    argParser
      ..addFlag(
        _releaseFlag,
        defaultsTo: false,
        help:
            'Build a production release of the site. '
            'Optimizes site resources.',
      )
      ..addOption(
        _reviewModeOption,
        allowed: const ['local', 'preview'],
        valueHelp: 'local|preview',
        help:
            'Embed the visual review toolbar in the built site '
            '(disabled by default).',
      )
      ..addOption(
        _reviewServerPortOption,
        valueHelp: 'port',
        help:
            'Loopback port of ReviewLocalServer when building with '
            '--review-mode=local.',
      )
      ..addMultiOption(
        _dartDefineMultiOption,
        valueHelp: 'KEY=VALUE',
        help: 'Additional compile-time --dart-define entries for Jaspr.',
      );
  }

  @override
  String get description => 'Build the site.';

  @override
  String get name => 'build';

  @override
  Future<int> run() {
    final productionRelease = argResults.get<bool>(_releaseFlag, false);
    final reviewMode = nonEmpty(argResults?.option(_reviewModeOption));
    final reviewPort = nonEmpty(argResults?.option(_reviewServerPortOption));

    if (productionRelease && reviewMode != null) {
      usageException(
        'Cannot combine --$_releaseFlag with --$_reviewModeOption.',
      );
    }

    final defines = <String, String>{};
    for (final entry
        in argResults?.multiOption(_dartDefineMultiOption) ??
            const <String>[]) {
      final eqIndex = entry.indexOf('=');
      if (eqIndex <= 0) {
        usageException(
          'Invalid --$_dartDefineMultiOption value "$entry". '
          'Expected KEY=VALUE.',
        );
      }
      defines[entry.substring(0, eqIndex)] = entry.substring(eqIndex + 1);
    }

    if (reviewMode != null) {
      defines['DASH_REVIEW_MODE'] = reviewMode;
      defines.putIfAbsent('DASH_REVIEW_SITE', () => selectedSite.name);
      if (reviewPort != null) {
        defines['DASH_REVIEW_SERVER_PORT'] = reviewPort;
      }
    }

    return buildSite(
      selectedSite,
      productionRelease: productionRelease,
      extraDartDefines: defines,
    );
  }
}

/// Constructs the `jaspr build` CLI arguments for [site].
///
/// When [productionRelease] is `true`, all `DASH_REVIEW_*` defines are stripped
/// so production deploys can never include review overlay code.
List<String> buildJasprBuildArgs(
  Site site, {
  required bool productionRelease,
  Map<String, String> extraDartDefines = const {},
}) => [
  'pub',
  'global',
  'run',
  'jaspr_cli:jaspr',
  'build',
  '-O4',
  '--extra-js-compiler-option=--no-source-maps',
  '--sitemap-domain=${site.baseUrl}',
  // Exclude secondary Markdown output files from sitemap.
  r'--sitemap-exclude=\.md$',
  '--dart-define=PRODUCTION=$productionRelease',
  if (!productionRelease) ...nonProductionDartDefines(),
  for (final MapEntry(:key, :value) in extraDartDefines.entries)
    if (!productionRelease || !key.startsWith('DASH_REVIEW_'))
      '--dart-define=$key=$value',
];

Future<int> buildSite(
  Site site, {
  required bool productionRelease,
  Map<String, String> extraDartDefines = const {},
}) async {
  if (installJasprCliIfNecessary() case final jasprInstallResult
      when jasprInstallResult != 0) {
    return jasprInstallResult;
  }

  final process = await Process.start(
    Platform.resolvedExecutable,
    buildJasprBuildArgs(
      site,
      productionRelease: productionRelease,
      extraDartDefines: extraDartDefines,
    ),
    workingDirectory: site.directory,
    environment: jasprProcessEnvironment(),
    mode: ProcessStartMode.inheritStdio,
  );

  if (await process.exitCode case final processExitCode
      when processExitCode != 0) {
    return processExitCode;
  }

  final buildOutputDirectoryPath = path.join(
    repositoryRoot,
    site.buildOutputDirectory,
  );
  if (!Directory(buildOutputDirectoryPath).existsSync()) {
    stderr.writeln(
      'Error: Jaspr output directory not found at: '
      '$buildOutputDirectoryPath',
    );
    return 1;
  }

  _move404File(buildOutputDirectoryPath);

  return 0;
}

/// Moves the 404 file to the location expected by Firebase hosting.
void _move404File(String siteOutputDirectoryPath) {
  final initial404Directory = path.join(siteOutputDirectoryPath, '404');
  final original404File = File(path.join(initial404Directory, 'index.html'));
  if (original404File.existsSync()) {
    // If the 404 is in its own directory,
    // copy the 404.html file to the root of the output directory.
    original404File.copySync(path.join(siteOutputDirectoryPath, '404.html'));
    Directory(initial404Directory).deleteSync(recursive: true);
  }
}
