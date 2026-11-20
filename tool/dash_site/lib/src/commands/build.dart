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

  BuildSiteCommand() {
    argParser.addFlag(
      _releaseFlag,
      defaultsTo: false,
      help:
          'Build a production release of the site. '
          'Optimizes site resources.',
    );
  }

  @override
  String get description => 'Build the site.';

  @override
  String get name => 'build';

  @override
  Future<int> run() => buildSite(
    selectedSite,
    productionRelease: argResults.get<bool>(_releaseFlag, false),
  );
}

/// Starts the Jaspr site build process.
Future<Process> startSiteBuildProcess(
  Site site, {
  required bool productionRelease,
  String? rootDirectory,
}) async {
  if (installJasprCliIfNecessary() case final jasprInstallResult
      when jasprInstallResult != 0) {
    throw ProcessException(
      'jaspr',
      [],
      'Failed to install Jaspr CLI',
      jasprInstallResult,
    );
  }

  final baseDirectory = rootDirectory ?? repositoryRoot;
  final siteDirectory = path.join(baseDirectory, site.directory);

  return await Process.start(
    Platform.resolvedExecutable,
    [
      'pub',
      'global',
      'run',
      'jaspr_cli:jaspr',
      'build',
      '-O4',
      '--extra-js-compiler-option=--no-source-maps',
      '--sitemap-domain=${site.baseUrl}',
      // Exclude secondary Markdown, plain-text, XML, and JSON outputs.
      r'--sitemap-exclude=\.(md|txt|xml|json)$',
      '--dart-define=PRODUCTION=$productionRelease',
      if (!productionRelease) ...nonProductionDartDefines(),
    ],
    workingDirectory: siteDirectory,
    mode: ProcessStartMode.inheritStdio,
  );
}

Future<int> buildSite(
  Site site, {
  required bool productionRelease,
  String? rootDirectory,
}) async {
  final Process process;
  try {
    process = await startSiteBuildProcess(
      site,
      productionRelease: productionRelease,
      rootDirectory: rootDirectory,
    );
  } on ProcessException catch (e) {
    return e.errorCode;
  }

  final baseDirectory = rootDirectory ?? repositoryRoot;

  if (await process.exitCode case final processExitCode
      when processExitCode != 0) {
    return processExitCode;
  }

  final buildOutputDirectoryPath = path.join(
    baseDirectory,
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
