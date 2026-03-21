// Copyright (c) 2023. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

import 'inject.dart';
import 'transform.dart';

/// An excerpt updater that can run over the files with [validTargetExtensions]
/// in the specified paths with [update], and updates their code excerpts
/// according to their injection instructions.
final class Updater {
  /// A pattern to check for paths to ignore or not descend in to.
  static final RegExp _ignoreHiddenPathsPattern = RegExp(r'(^|/)\..*($|/)');

  /// The transforms to run on each retrieved region.
  final Iterable<Transform> defaultTransforms;

  /// Patterns of paths to avoid updating.
  final Iterable<RegExp> excludePaths;

  /// Extensions of files to consider for injection updating.
  final Set<String> validTargetExtensions;

  /// The path to the directory of the source files to pull regions from.
  final String baseSourcePath;

  /// The content to include in plaster replacements by default.
  final String defaultPlasterContent;

  /// Whether to continue updating or checking for updates if
  /// an error is experienced.
  final bool continueOnError;

  /// Create an [Updater] that can be used to [update] a collection of files
  /// with the specified [validTargetExtensions] but
  /// not matching [excludePaths].
  ///
  /// Regions in injection instructions are pulled from files
  /// within the [baseSourcePath].
  ///
  /// If [withDefaultExclusions] is `true`, files and directories
  /// hidden by starting with a `.` are excluded as well.
  ///
  /// The [defaultTransforms] specified are run on each region
  /// before transforms provided by instructions on the page.
  Updater({
    required this.baseSourcePath,
    required this.validTargetExtensions,
    this.continueOnError = false,
    this.defaultPlasterContent = '...',
    this.defaultTransforms = const [],
    Iterable<RegExp> excludePaths = const [],
    bool withDefaultExclusions = true,
  }) : excludePaths = [
         if (withDefaultExclusions) _ignoreHiddenPathsPattern,
         ...excludePaths,
       ];

  /// Use the configuration of this [Updater] to process the
  /// file at the [pathToUpdate], optionally making updates
  /// if [makeUpdates] is `true`.
  @useResult
  Future<ExcerptUpdateResult> update(
    String pathToUpdate, {
    bool makeUpdates = true,
  }) async {
    final pathsToUpdate = await _findTargetFiles(pathToUpdate);
    final warnings = <String>[];
    var excerptsVisited = 0;
    var excerptsNeedingUpdates = 0;
    var filesVisited = 0;
    var madeUpdates = false;
    final errors = <String>[];

    for (final currentPath in pathsToUpdate) {
      final fileUpdater = FileUpdater(
        currentPath,
        baseSourcePath: baseSourcePath,
        defaultPlasterContent: defaultPlasterContent,
        defaultTransforms: defaultTransforms,
      );

      try {
        final results = await fileUpdater.process();
        warnings.addAll(results.warnings);
        excerptsVisited += results.excerptsVisited;
        excerptsNeedingUpdates += results.excerptsUpdated.length;

        if (makeUpdates && results.needsUpdates) {
          madeUpdates = true;
          await results.writeUpdates();
        }

        filesVisited += 1;
      } on InjectionException catch (e) {
        errors.add(e.toString());
        if (!continueOnError) {
          break;
        }
      }
    }

    return ExcerptUpdateResult._(
      excerptsVisited: excerptsVisited,
      excerptsNeedingUpdates: excerptsNeedingUpdates,
      madeUpdates: madeUpdates,
      filesVisited: filesVisited,
      totalFilesToVisit: pathsToUpdate.length,
      warnings: warnings,
      errors: errors,
    );
  }

  @useResult
  Future<Iterable<String>> _findTargetFiles(String pathToEntity) async {
    if (_shouldExclude(pathToEntity)) return const [];

    final entityType = await FileSystemEntity.type(pathToEntity);
    if (entityType == FileSystemEntityType.directory) {
      return [
        await for (final entity in Directory(
          pathToEntity,
        ).list(followLinks: false))
          ...await _findTargetFiles(entity.path),
      ];
    } else if (entityType == FileSystemEntityType.file &&
        validTargetExtensions.contains(path.extension(pathToEntity))) {
      return [pathToEntity];
    }

    return const [];
  }

  bool _shouldExclude(String path) =>
      excludePaths.any((excludePattern) => path.contains(excludePattern));
}

/// The result of running a [Updater] on a collection of files.
@immutable
final class ExcerptUpdateResult {
  /// The non-fatal warnings experienced when
  /// processing the specified collection of files.
  final Iterable<String> warnings;

  /// The fatal errors experienced when
  /// processing the specified collection of files.
  final Iterable<String> errors;

  /// The amount of code excerpt injections visited when
  /// processing the specified collection of files.
  ///
  /// Note this may not be all excerpts in the collection
  /// as a fatal error may have been experienced.
  final int excerptsVisited;

  /// The amount of code excerpt injections that needed updates when
  /// processing the specified collection of files.
  ///
  /// Note this may not be all excerpts needing updates in the collection
  /// as a fatal error may have been experienced.
  final int excerptsNeedingUpdates;

  /// The amount of files visited successfully without errors when
  /// processing the specified collection of files.
  ///
  /// If this differs from [totalFilesToVisit], that means
  /// there was a fatal error during processing.
  final int filesVisited;

  /// The total amount of files in the specified collection of files
  /// that were meant to be visited.
  final int totalFilesToVisit;

  /// If the [Updater] wrote updates to the files needing them.
  final bool madeUpdates;

  ExcerptUpdateResult._({
    required this.excerptsVisited,
    required this.excerptsNeedingUpdates,
    required this.filesVisited,
    required this.totalFilesToVisit,
    required this.madeUpdates,
    this.warnings = const [],
    this.errors = const [],
  });
}
