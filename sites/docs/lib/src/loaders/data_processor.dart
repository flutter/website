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
    if (pageLoader is! FilesystemLoader) return;

    final sourcePath = path.canonicalize(
      path.absolute(path.join(pageLoader.directory, page.path)),
    );

    final repositoryRoot = _repositoryRoot;
    // Use native separators for filesystem paths,
    // then POSIX separators for Git paths and source URLs.
    final inputPath = repositoryRoot != null
        ? path.posix.joinAll(
            path.split(path.relative(sourcePath, from: repositoryRoot)),
          )
        : null;
    final lastModifiedDate = inputPath != null
        ? _lastModifiedDateForPath(inputPath)
        : null;
    page.apply(
      data: {
        'page': {
          'date': ?lastModifiedDate,
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

/// Determines the last modified date for a given path
/// in the form `yyyy-mm-dd`.
///
/// Uses `git log` to get the last modified date from the git history.
/// Returns `null` if no date can be determined.
String? _lastModifiedDateForPath(String inputPath) =>
    _lastModifiedPerPath[inputPath]?.formatted;

/// The most recent Git commit date for each content file path.
///
/// The paths are relative to the repository root.
/// If Git metadata isn't available, the map is empty.
final Map<String, DateTime> _lastModifiedPerPath = () {
  final fileLastModified = <String, DateTime>{};
  final repositoryRoot = _repositoryRoot;
  if (repositoryRoot == null) return fileLastModified;

  final ProcessResult result;
  try {
    result = Process.runSync(
      'git',
      [
        'log',
        '--name-only',
        '--format=commit-date:%cI',
        '--',
        path.posix.join('sites', 'docs', 'src', 'content'),
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
        // Only set the last modified time for this path
        // if we haven't already stored a later modified time.
        fileLastModified.putIfAbsent(
          line,
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
