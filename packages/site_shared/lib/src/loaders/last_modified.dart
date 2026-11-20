// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io'
    show FileSystemException, Process, ProcessException, ProcessResult;

import 'package:jaspr_content/jaspr_content.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

import '../../util.dart';

/// Signature for running a `git` command in tests or production.
typedef GitRunner = String? Function(
  List<String> args, {
  String? workingDirectory,
});

/// Whether [value] represents an enabled `noindex` frontmatter flag.
bool isNoIndexFlag(Object? value) => value == true || value == 'true';

/// Loads Git commit timestamps for a site directory and populates page
/// metadata.
///
/// Also ensures any page marked `noindex` is excluded from `sitemap.xml`.
final class LastModifiedLoader implements DataLoader {
  LastModifiedLoader({GitLastModifiedIndex? index})
    : _index = index ?? GitLastModifiedIndex.forCurrentProject();

  final GitLastModifiedIndex _index;

  @override
  Future<void> loadData(Page page) async {
    _index.applyToPage(page);
  }
}

/// Cached Git modification timestamps for files within a site directory.
final class GitLastModifiedIndex {
  GitLastModifiedIndex({
    required String? repositoryRoot,
    required String projectRoot,
    required this._lastModifiedPerPath,
    @visibleForTesting path.Context? pathContext,
  }) : _pathContext = pathContext ?? path.context,
       repositoryRoot = repositoryRoot == null
           ? null
           : _normalizeAbsolute(pathContext ?? path.context, repositoryRoot),
       projectRoot = _normalizeAbsolute(
         pathContext ?? path.context,
         projectRoot,
       );

  /// Builds an index for [projectRoot] (defaulting to [path.current]).
  ///
  /// Throws a [StateError] when [isProductionBuild] (or [productionBuild]) is
  /// `true` and full Git history is unavailable (for example, a shallow clone).
  factory GitLastModifiedIndex.forCurrentProject({
    String? projectRoot,
    bool? isProductionBuild,
    GitRunner runGit = _defaultRunGit,
  }) {
    final resolvedProjectRoot = _normalizeAbsolute(
      path.context,
      projectRoot ?? path.current,
    );
    final DatesAndRoot(:repositoryRoot, :dates) = loadProjectLastModifiedDates(
      projectRoot: resolvedProjectRoot,
      isProductionBuild: isProductionBuild ?? productionBuild,
      runGit: runGit,
    );
    return GitLastModifiedIndex(
      repositoryRoot: repositoryRoot,
      projectRoot: resolvedProjectRoot,
      lastModifiedPerPath: dates,
    );
  }

  final String? repositoryRoot;
  final String projectRoot;
  final Map<String, DateTime> _lastModifiedPerPath;
  final path.Context _pathContext;

  /// Returns the newest Git modification timestamp across [inputPaths].
  DateTime? latestModifiedDateForPaths(Iterable<String> inputPaths) {
    DateTime? latestDate;
    for (final inputPath in inputPaths) {
      final modifiedDate = _lastModifiedPerPath[inputPath];
      if (modifiedDate != null &&
          (latestDate == null || modifiedDate.isAfter(latestDate))) {
        latestDate = modifiedDate;
      }
    }
    return latestDate;
  }

  /// Applies `inputPath`, `date`, `dateModified`, and `sitemap` data to [page].
  void applyToPage(Page page) {
    final pageData = page.data.page;
    final excludeFromSitemap = isNoIndexFlag(pageData['noindex']);
    final (:inputPath, :projectInputPath) = _resolvePagePaths(page);

    final modifiedSources = <String>{
      ?projectInputPath,
      if (pageData['dateModifiedSources'] case final List<Object?> sources)
        ...sources.whereType<String>(),
    };

    final lastModified = modifiedSources.isEmpty
        ? null
        : latestModifiedDateForPaths(modifiedSources);
    final lastModifiedDate = lastModified?.formattedUtcDate;

    if (lastModified == null && inputPath == null && !excludeFromSitemap) {
      return;
    }

    page.apply(
      data: {
        'page': {
          'date': ?lastModifiedDate,
          'dateModified': ?lastModified,
          'inputPath': ?inputPath,
          if (excludeFromSitemap)
            'sitemap': false
          else if (pageData['sitemap'] == null && lastModifiedDate != null)
            'sitemap': {'lastmod': lastModifiedDate},
        },
      },
    );
  }

  ({String? inputPath, String? projectInputPath}) _resolvePagePaths(Page page) {
    final repoRoot = repositoryRoot;
    final pageLoader = page.loader;
    if (repoRoot == null || pageLoader is! FilesystemLoader) {
      return (inputPath: null, projectInputPath: null);
    }

    final loaderDirectory = _pathContext.isAbsolute(pageLoader.directory)
        ? pageLoader.directory
        : _pathContext.join(projectRoot, pageLoader.directory);
    final sourcePath = _normalizeAbsolute(
      _pathContext,
      _pathContext.join(loaderDirectory, page.path),
    );
    String toPosixRelative(String from) => path.posix.joinAll(
      _pathContext.split(_pathContext.relative(sourcePath, from: from)),
    );

    return (
      inputPath: toPosixRelative(repoRoot),
      projectInputPath: toPosixRelative(projectRoot),
    );
  }
}

/// Result of loading Git modification dates for a project directory.
typedef DatesAndRoot = ({String? repositoryRoot, Map<String, DateTime> dates});

/// Loads the latest Git commit date for each file under [projectRoot].
///
/// Throws a [StateError] when [isProductionBuild] is `true` and full Git
/// history isn't available.
@visibleForTesting
DatesAndRoot loadProjectLastModifiedDates({
  required String projectRoot,
  required bool isProductionBuild,
  GitRunner runGit = _defaultRunGit,
}) {
  final normalizedProjectRoot = _normalizeAbsolute(path.context, projectRoot);
  final rawRepoRoot = runGit(
    const ['rev-parse', '--show-toplevel'],
    workingDirectory: normalizedProjectRoot,
  )?.trim();
  if (rawRepoRoot == null || rawRepoRoot.isEmpty) {
    if (isProductionBuild) _throwMissingFullHistory();
    return (repositoryRoot: null, dates: const {});
  }
  final repoRoot = _normalizeAbsolute(path.context, rawRepoRoot);

  final isShallow =
      runGit(
        const ['rev-parse', '--is-shallow-repository'],
        workingDirectory: repoRoot,
      )?.trim() !=
      'false';

  final projectPath = path.posix.joinAll(
    path.split(path.relative(normalizedProjectRoot, from: repoRoot)),
  );
  final logOutput = runGit([
    'log',
    '--name-only',
    '--format=commit-date:%cI',
    '--',
    projectPath,
  ], workingDirectory: repoRoot);

  if (isProductionBuild && (logOutput == null || isShallow)) {
    _throwMissingFullHistory();
  }
  if (logOutput == null) {
    return (repositoryRoot: repoRoot, dates: const {});
  }

  return (
    repositoryRoot: repoRoot,
    dates: _parseGitLogDates(logOutput, projectPath),
  );
}

String _normalizeAbsolute(path.Context pathContext, String targetPath) =>
    pathContext.normalize(pathContext.absolute(targetPath));

Never _throwMissingFullHistory() {
  throw StateError(
    'Production builds need the full git history to determine '
    'last-modified dates. Run `git fetch --unshallow` first.',
  );
}

Map<String, DateTime> _parseGitLogDates(String output, String projectPath) {
  final fileLastModified = <String, DateTime>{};
  DateTime? currentCommitDate;
  for (final line in const LineSplitter().convert(output)) {
    if (line.split('commit-date:') case [_, final dateString]) {
      currentCommitDate = DateTime.tryParse(dateString)?.toUtc();
    } else if (line.isNotEmpty && currentCommitDate != null) {
      final projectRelativePath = projectPath == '.'
          ? line
          : path.posix.relative(line, from: projectPath);
      fileLastModified.putIfAbsent(
        projectRelativePath,
        () => currentCommitDate!,
      );
    }
  }
  return fileLastModified;
}

String? _defaultRunGit(List<String> args, {String? workingDirectory}) {
  final ProcessResult result;
  try {
    result = Process.runSync('git', args, workingDirectory: workingDirectory);
  } on FileSystemException {
    return null;
  } on ProcessException {
    return null;
  }
  return result.exitCode == 0 ? result.stdout as String : null;
}

extension on DateTime {
  String get formattedUtcDate {
    final utc = toUtc();
    final year = utc.year.toString().padLeft(4, '0');
    final month = utc.month.toString().padLeft(2, '0');
    final day = utc.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
