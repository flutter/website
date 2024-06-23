// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:excerpter/excerpter.dart';
import 'package:path/path.dart' as path;
import '../utils.dart';

final class RefreshExcerptsCommand extends Command<int> {
  static const String _verboseFlag = 'verbose';
  static const String _dryRunFlag = 'dry-run';
  static const String _failOnUpdateFlag = 'fail-on-update';

  RefreshExcerptsCommand() {
    argParser.addFlag(
      _verboseFlag,
      defaultsTo: false,
      help: 'Show verbose logging.',
    );
    argParser.addFlag(
      _dryRunFlag,
      defaultsTo: false,
      help: 'Don\'t refresh excerpts, just check if they are up to date.',
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
        dryRun: argResults.get<bool>(_dryRunFlag, false),
        failOnUpdate: argResults.get<bool>(_failOnUpdateFlag, false),
      );
}

Future<int> _refreshExcerpts({
  bool verboseLogging = false,
  bool dryRun = false,
  bool failOnUpdate = false,
}) async {
  final repositoryRoot = Directory.current.path;

  final updater = Updater(
    baseSourcePath: path.join(repositoryRoot, 'examples'),
    defaultPlasterContent: '···',
    validTargetExtensions: const {'.md'},
  );

  print('Running the code excerpt updater...');
  final updateResult = await updater.update(
    path.join(repositoryRoot, 'src', 'content'),
    makeUpdates: !dryRun,
  );

  print(
    '\nProcessed ${updateResult.filesVisited} out of '
    '${updateResult.totalFilesToVisit} files: '
    '${updateResult.excerptsNeedingUpdates} out of '
    '${updateResult.excerptsVisited} excerpts visited '
    '${updateResult.madeUpdates ? 'were updated' : 'need to be updated'}.\n',
  );

  final warnings = updateResult.warnings;
  final warningCount = warnings.length;
  final errors = updateResult.errors;
  final errorCount = errors.length;

  final hadErrors = errorCount > 0;

  if (verboseLogging || hadErrors) {
    if (hadErrors || warningCount > 0) {
      for (final error in errors) {
        print('  error - $error');
      }
      for (final warning in warnings) {
        print('warning - $warning');
      }
      print('\n$errorCount errors and $warningCount warnings found!\n');
    }
  }

  if (hadErrors) {
    stderr.writeln('\nError: There were errors when updating excerpts!');
    return 1;
  } else if (failOnUpdate && updateResult.excerptsNeedingUpdates > 0) {
    stderr.writeln('Error: Some code excerpts needed to be updated!');
    stderr.writeln('  Run `./dash_site refresh-excerpts` to update.');
    return 1;
  }

  print('Refresh excerpts script ran successfully!');
  return 0;
}
