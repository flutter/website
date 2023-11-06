// Copyright 2023 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import '../utils.dart';

final class RefreshExcerptsCommand extends Command<int> {
  static const _verboseFlag = 'verbose';
  static const _deleteCacheFlag = 'delete-cache';
  static const _failOnUpdateFlag = 'fail-on-update';
  static const _diffFlag = 'diff';

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
    argParser.addFlag(
      _diffFlag,
      defaultsTo: false,
      help: 'Output the files changed when refreshing.',
    );
  }

  @override
  String get description => 'Updates all code excerpts on the site.';

  @override
  String get name => 'refresh-excerpts';

  @override
  Future<int> run() async => refreshExcerpts(
        verboseLogging: argResults.get(_verboseFlag, false),
        deleteCache: argResults.get(_deleteCacheFlag, false),
        failOnUpdate: argResults.get(_failOnUpdateFlag, false),
        outputDiff: argResults.get(_diffFlag, false),
      );
}

Future<int> refreshExcerpts({
  bool verboseLogging = false,
  bool deleteCache = false,
  bool failOnUpdate = false,
  bool outputDiff = false,
}) async {
  // TODO: Replace diffutils with cross-platform solution.
  final diffVersionOutput =
      Process.runSync('diff', ['--version']).stdout.toString();
  final diffVersionLine = RegExp(r'^diff.*(3\.\d+)$', multiLine: true)
      .firstMatch(diffVersionOutput);
  if (diffVersionLine == null) {
    stderr.writeln(
      'ERROR: diffutils must be installed to refresh code excerpts!',
    );
    return 1;
  } else {
    final diffVersion = double.tryParse(diffVersionLine[1] ?? '');
    if (diffVersion == null || diffVersion < 3.6) {
      stderr.writeln(
        'ERROR: diffutils version >=3.6 required - your version: $diffVersion!',
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
    stderr.writeln('ERROR: Excerpt generation failed:');
    stderr.writeln(excerptsGenerated.stderr);
    return 1;
  }

  print('Code excerpt fragments generated successfully.');

  // Verify the fragments directory for the /examples was generated properly.
  if (!Directory(path.join(fragments, 'examples')).existsSync()) {
    stderr.writeln(
      'ERROR: The examples fragments folder was not generated!',
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

  Directory? srcCopy;

  // Open a try block so we can guarantee
  // the temporary files are deleted.
  try {
    if (outputDiff) {
      if (verboseLogging) {
        print('Creating copy of source directory for diffing...');
      }

      srcCopy = Directory.systemTemp.createTempSync('excerpter-copy-');

      _copyDirectorySync(Directory(srcDirectoryPath), srcCopy, shouldSkip: (e) {
        // Don't descend into directories that start with `_` or `.`.
        final name = path.basename(e.path);
        return name.startsWith('_') || name.startsWith('.');
      });

      if (verboseLogging) {
        print('Copy of source directory created at: ${srcCopy.path}');
      }
    }

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
      stderr.writeln('ERROR: Excerpt generation failed:');
      stderr.write(updateErrors);
      success = false;
    } else if (updateOutput.contains('0 out of')) {
      if (verboseLogging) {
        print(updateOutput);
      }
      print('All code excerpts are already up to date!');
      success = true;
    } else {
      // If it was specified to output the diff,
      // run the diff command between the /src copy and the original version
      // to see what's changed.
      if (srcCopy != null) {
        print('Diffing code excerpt changes...');

        // Use Process.start to allow for colored ANSI to be sent to stdout.
        final diffProcess = await Process.start(
            'diff',
            [
              '--no-dereference', // Skip symlinks.
              '--exclude',
              '_*', // Don't diff files starting with _.
              '--exclude',
              '.*', // Don't diff files starting with ..
              '--color',
              '-U2', // Show two lines before and after diff.
              '-r',
              srcCopy.path,
              srcDirectoryPath,
            ],
            mode: ProcessStartMode.inheritStdio);

        await diffProcess.exitCode;
      }

      stdout.write(updateOutput);

      if (failOnUpdate) {
        stderr.writeln('ERROR: Some code excerpts needed to be updated!');
        success = false;
      } else {
        print('Code excerpts successfully refreshed!');
        success = true;
      }
    }
    return success ? 0 : 1;
  } finally {
    // If the diff was output, delete the temporary copy of the /src directory.
    srcCopy?.deleteSync(recursive: true);

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

/// Copy the contents of the specified [source] directory
/// to the [destination] directory.
///
/// To skip copying file entities or descending into directories
/// that meet certain criteria, you can pass in a [shouldSkip] function.
void _copyDirectorySync(
  Directory source,
  Directory destination, {
  bool Function(FileSystemEntity entity)? shouldSkip,
}) {
  for (final entity in source.listSync(recursive: false, followLinks: false)) {
    if (shouldSkip != null && shouldSkip(entity)) continue;

    final targetPath = path.join(
      destination.absolute.path,
      path.relative(entity.path, from: source.path),
    );

    if (entity is Directory) {
      final newDirectory = Directory(targetPath)..createSync(recursive: true);
      _copyDirectorySync(entity, newDirectory, shouldSkip: shouldSkip);
    } else if (entity is File) {
      File(targetPath).createSync(recursive: true);
      entity.copySync(targetPath);
    } else if (entity is Link) {
      Link(targetPath).createSync(entity.targetSync());
    }
  }
}
