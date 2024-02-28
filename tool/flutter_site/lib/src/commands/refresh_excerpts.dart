// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import '../utils.dart';

final class RefreshExcerptsCommand extends Command<int> {
  static const String _verboseFlag = 'verbose';
  static const String _deleteCacheFlag = 'delete-cache';
  static const String _failOnUpdateFlag = 'fail-on-update';

  RefreshExcerptsCommand() {
    argParser.addFlag(
      _verboseFlag,
      defaultsTo: false,
      help: 'Show verbose logging.',
    );
    argParser.addFlag(
      _deleteCacheFlag,
      defaultsTo: false,
      help: 'Delete dart build tooling and cache files after running.',
    );
    argParser.addFlag(
      _failOnUpdateFlag,
      defaultsTo: false,
      help: 'Fails if updates were needed.',
    );
  }

  @override
  String get description => 'Updates all code excerpts on the site.';

  @override
  String get name => 'refresh-excerpts';

  @override
  Future<int> run() async => _refreshExcerpts(
      verboseLogging: argResults.get<bool>(_verboseFlag, false),
      deleteCache: argResults.get<bool>(_deleteCacheFlag, false),
      failOnUpdate: argResults.get<bool>(_failOnUpdateFlag, false));
}

Future<int> _refreshExcerpts({
  bool verboseLogging = false,
  bool deleteCache = false,
  bool failOnUpdate = false,
}) async {
  // TODO: Replace diffutils with cross-platform solution.
  final diffVersionOutput =
      Process.runSync('diff', ['--version']).stdout.toString();
  final diffVersionLine = RegExp(r'^diff.*(3\.\d+)$', multiLine: true)
      .firstMatch(diffVersionOutput);
  if (diffVersionLine == null) {
    stderr.writeln(
      'Error: diffutils must be installed to refresh code excerpts!',
    );
    return 1;
  } else {
    final diffVersion = double.tryParse(diffVersionLine[1] ?? '');
    if (diffVersion == null || diffVersion < 3.6) {
      stderr.writeln(
        'Error: diffutils version >=3.6 required - your version: $diffVersion!',
      );
      return 1;
    }
  }

  final repositoryRoot = Directory.current.path;
  final temporaryRoot = Directory.systemTemp.path;
  final fragments = path.join(temporaryRoot, '_excerpter_fragments');

  // Delete any existing fragments.
  final fragmentsDirectory = Directory(fragments);
  if (fragmentsDirectory.existsSync()) {
    if (verboseLogging) {
      print('Deleting previously generated $fragments.');
    }
    fragmentsDirectory.deleteSync(recursive: true);
  }

  print('Running the code excerpt fragment generator...');

  // Run the code excerpter tool to generate the fragments used for updates.
  final excerptsGenerated = Process.runSync(Platform.resolvedExecutable, [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
    '--config',
    'excerpt',
    '--output',
    fragments,
  ]);

  if (verboseLogging) {
    print(excerptsGenerated.stdout);
  }

  // If the excerpt fragments were not generated successfully,
  // then output the error log and return 1 to indicate failure.
  if (excerptsGenerated.exitCode != 0) {
    stderr.writeln('Error: Excerpt generation failed:');
    stderr.writeln(excerptsGenerated.stderr);
    return 1;
  }

  print('Code excerpt fragments generated successfully.');

  // Verify the fragments directory for the /examples was generated properly.
  if (!Directory(path.join(fragments, 'examples')).existsSync()) {
    stderr.writeln(
      'Error: The examples fragments folder was not generated!',
    );
    return 1;
  }

  // A collection of replacements for the code excerpt updater tool
  // to run by default.
  // They must not contain (unencoded/unescaped) spaces.
  const replacements = [
    // Allows use of //!<br> to force a line break (against dart format)
    r'/\/\/!<br>//g;',
    // Replace commented out ellipses: /*...*/ --> ...
    r'/\/\*(\s*\.\.\.\s*)\*\//$1/g;',
    // Replace brackets with commented out ellipses: {/*-...-*/} --> ...
    r'/\{\/\*-(\s*\.\.\.\s*)-\*\/\}/$1/g;',
    // Remove markers declaring an analysis issue or runtime error.
    r'/\/\/!(analysis-issue|runtime-error)[^\n]*//g;',
    // Remove analyzer ignore for file markers.
    r'/\x20*\/\/\s+ignore_for_file:[^\n]+\n//g;',
    // Remove analyzer inline ignores.
    r'/\x20*\/\/\s+ignore:[^\n]+//g;',
  ];

  final srcDirectoryPath = path.join(repositoryRoot, 'src');
  final updaterArguments = <String>[
    '--fragment-dir-path',
    path.join(fragments, 'examples'),
    '--src-dir-path',
    'examples',
    if (verboseLogging) '--log-fine',
    '--yaml',
    '--no-escape-ng-interpolation',
    '--replace=${replacements.join('')}',
    '--write-in-place',
    srcDirectoryPath,
  ];

  print('Running the code excerpt updater...');

  // Open a try block so we can guarantee
  // any temporary files are deleted.
  try {
    // Run the code excerpt updater tool to update the code excerpts
    // in the /src directory.
    final excerptsUpdated = Process.runSync(Platform.resolvedExecutable, [
      'run',
      'code_excerpt_updater',
      ...updaterArguments,
    ]);

    final updateOutput = excerptsUpdated.stdout.toString();
    final updateErrors = excerptsUpdated.stderr.toString();

    final bool success;

    // Inform the user if the updater failed, didn't need to make any updates,
    // or successfully refreshed each excerpt.
    if (excerptsUpdated.exitCode != 0 || updateErrors.contains('Error')) {
      stderr.writeln('Error: Excerpt generation failed:');
      stderr.write(updateErrors);
      success = false;
    } else if (updateOutput.contains('0 out of')) {
      if (verboseLogging) {
        print(updateOutput);
      }
      print('All code excerpts are already up to date!');
      success = true;
    } else {
      stdout.write(updateOutput);

      if (failOnUpdate) {
        stderr.writeln('Error: Some code excerpts needed to be updated!');
        success = false;
      } else {
        print('Code excerpts successfully refreshed!');
        success = true;
      }
    }
    return success ? 0 : 1;
  } finally {
    // Clean up Dart build cache files if desired.
    if (deleteCache) {
      if (verboseLogging) {
        print('Removing cached build files.');
      }
      final dartBuildCache = Directory(path.join('.dart_tool', 'build'));
      if (dartBuildCache.existsSync()) {
        dartBuildCache.deleteSync(recursive: true);
      }
    }
  }
}
