// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io' show FileSystemException, Process;

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
      path.join(pageLoader.directory, page.path),
    );

    final inputPath = path.relative(sourcePath, from: '..');
    page.apply(
      data: {
        'page': {
          'date': ?_lastModifiedDateForPath(inputPath),
          'inputPath': inputPath,
          if (page.data.page['sitemap'] == null)
            'sitemap': {
              'lastmod': _lastModifiedDateForPath(inputPath),
            },
        },
      },
    );
  }
}

/// Determines the last modified date for a given path
/// in the form `yyyy-mm-dd`.
///
/// Uses `git log` to get the last modified date from the git history.
/// Returns `null` if no date can be determined.
String? _lastModifiedDateForPath(String inputPath) =>
    _lastModifiedPerPath[inputPath]?.formatted;

final Map<String, DateTime> _lastModifiedPerPath = () {
  final fileLastModified = <String, DateTime>{};

  try {
    final output =
        Process.runSync('git', [
              'log',
              '--name-only',
              '--format=commit-date:%cI',
              '--',
              '../src/content',
            ]).stdout
            as String;

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
  } on FileSystemException catch (_) {
    // Ignore and fall through to return an empty list.
    // We just won't render the last updated time.
  }

  return fileLastModified;
}();

extension on DateTime {
  String get formatted => '$year-$month-$day';
}
