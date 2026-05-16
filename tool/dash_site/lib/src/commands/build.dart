// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:io/io.dart' as io;
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
  Future<int> run() async => buildSite(
    selectedSite,
    productionRelease: argResults.get<bool>(_releaseFlag, false),
  );
}

Future<int> buildSite(Site site, {required bool productionRelease}) async {
  if (installJasprCliIfNecessary() case final jasprInstallResult
      when jasprInstallResult != 0) {
    return jasprInstallResult;
  }

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
      '--sitemap-domain=${site.baseUrl}',
      // Exclude secondary Markdown output files from sitemap.
      r'--sitemap-exclude=\.html\.md$',
      '--dart-define=PRODUCTION=$productionRelease',
    ],
    workingDirectory: site.directory,
    mode: ProcessStartMode.inheritStdio,
  );

  if (await process.exitCode case final processExitCode
      when processExitCode != 0) {
    return processExitCode;
  }

  final originalOutputDirectoryPath = path.join(
    repositoryRoot,
    site.jasprBuildOutputDirectory,
  );
  if (!Directory(originalOutputDirectoryPath).existsSync()) {
    stderr.writeln(
      'Error: Jaspr output directory not found at: '
      '$originalOutputDirectoryPath',
    );
    return 1;
  }

  final siteOutputDirectoryPath = path.join(
    repositoryRoot,
    site.buildOutputDirectory,
  );
  if (path.normalize(originalOutputDirectoryPath) !=
      path.normalize(siteOutputDirectoryPath)) {
    final outputDirectory = Directory(siteOutputDirectoryPath);
    if (outputDirectory.existsSync()) {
      outputDirectory.deleteSync(recursive: true);
    }

    // Copy the entire site output to the configured output directory.
    io.copyPathSync(originalOutputDirectoryPath, siteOutputDirectoryPath);
  }

  _move404File(siteOutputDirectoryPath);

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
