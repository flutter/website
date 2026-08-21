// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io'
    show FileSystemException, Process, ProcessException, ProcessResult;

import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;

/// A shared data loader to add data to each loaded page.
final class DataProcessor implements DataLoader {
  @override
  Future<void> loadData(Page page) async {
    _loadLastModified(page);
  }

  /// Adds data about the last modified date of the page.
  static void _loadLastModified(Page page) {
    final pageLoader = page.loader;
    final repositoryRoot = _repositoryRoot;
    String? inputPath;
    String? projectInputPath;
    if (repositoryRoot != null && pageLoader is FilesystemLoader) {
      final sourcePath = path.canonicalize(
        path.absolute(path.join(pageLoader.directory, page.path)),
      );

      // Use native separators for filesystem paths,
      // then POSIX separators for Git paths and source URLs.
      String toPosixRelative(String from) =>
          path.posix.joinAll(path.split(path.relative(sourcePath, from: from)));
      inputPath = toPosixRelative(repositoryRoot);
      projectInputPath = toPosixRelative(_projectRoot);
    }

    final modifiedSources = <String>{
      ?projectInputPath,
      if (page.data.page['dateModifiedSources']
          case final List<Object?> sources)
        ...sources.whereType<String>(),
    };
    if (modifiedSources.isEmpty) return;

    final lastModified = latestModifiedDateForPaths(modifiedSources);
    final lastModifiedDate = lastModified?.formatted;
    page.apply(
      data: {
        'page': {
          'date': ?lastModifiedDate,
          'dateModified': ?lastModified,
          'inputPath': ?inputPath,
          if (page.data.page['sitemap'] == null)
            'sitemap': {
              'lastmod': lastModifiedDate,
            },
        },
      },
    );
  }
}

/// The root directory of this repository, if available from Git.
final String? _repositoryRoot = () {
  final ProcessResult result;
  try {
    result = Process.runSync('git', const [
      'rev-parse',
      '--show-toplevel',
    ]);
  } on ProcessException {
    return null;
  }

  if (result.exitCode != 0) {
    return null;
  }

  return path.canonicalize((result.stdout as String).trim());
}();

/// The project directory from which the docs site is built.
final String _projectRoot = path.canonicalize(path.current);

/// Determines the newest Git modification time for [inputPaths].
///
/// Input paths are relative to the docs project root.
/// Uses dates collected from Git history.
/// Returns `null` if no date can be determined for any input path.
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

/// The most recent Git commit date for each docs project file path.
///
/// The paths are relative to the docs project root.
/// If Git metadata isn't available, the map is empty.
final Map<String, DateTime> _lastModifiedPerPath = () {
  final fileLastModified = <String, DateTime>{};
  final repositoryRoot = _repositoryRoot;
  if (repositoryRoot == null) return fileLastModified;
  final projectPath = path.posix.joinAll(
    path.split(path.relative(_projectRoot, from: repositoryRoot)),
  );

  final ProcessResult result;
  try {
    result = Process.runSync(
      'git',
      [
        'log',
        '--name-only',
        '--format=commit-date:%cI',
        '--',
        projectPath,
      ],
      workingDirectory: repositoryRoot,
    );
  } on FileSystemException catch (_) {
    // Ignore and return an empty map.
    // We just won't render the last updated time.
    return fileLastModified;
  } on ProcessException catch (_) {
    // Ignore and return an empty map.
    // We just won't render the last updated time.
    return fileLastModified;
  }

  if (result.exitCode != 0) return fileLastModified;

  final output = result.stdout as String;
  final lines = const LineSplitter().convert(output);
  DateTime? currentCommitDate;
  for (final line in lines) {
    // Check if the line is a commit date line.
    if (line.split('commit-date:') case [_, final dateString]) {
      // Extract the date string and try to parse it.
      currentCommitDate = DateTime.tryParse(dateString);
    } else if (line.isNotEmpty) {
      // If it's a non-empty line and a date is set, it's a file path.
      if (currentCommitDate case final lastModifiedTime?) {
        final projectRelativePath = path.posix.relative(
          line,
          from: projectPath,
        );
        // Only set the last modified time for this path
        // if we haven't already stored a later modified time.
        fileLastModified.putIfAbsent(
          projectRelativePath,
          () => lastModifiedTime,
        );
      }
    }
  }

  return fileLastModified;
}();

extension on DateTime {
  String get formatted => toIso8601String().substring(0, 10);
}
