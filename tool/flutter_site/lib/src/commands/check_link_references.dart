// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

final class CheckLinkReferencesCommand extends Command<int> {
  @override
  String get description => 'Verify there are no unlinked/broken '
      'Markdown link references in the generated site output.';

  @override
  String get name => 'check-link-references';

  @override
  Future<int> run() async => _checkLinkReferences();
}

int _checkLinkReferences() {
  print('Checking for broken Markdown link references...');

  const generatedSiteDirectory = '_site';

  final directory = Directory(generatedSiteDirectory);

  if (!directory.existsSync()) {
    stderr.writeln(
      'Error: Generated site not found at $generatedSiteDirectory. '
      'Make sure the site is generated first!',
    );
    return 1;
  }

  final filesToInvalidReferences = _findInvalidLinkReferences(directory);

  if (filesToInvalidReferences.isNotEmpty) {
    stderr.writeln('Error: Invalid link references found!');

    filesToInvalidReferences.forEach((sourceFile, invalidReferences) {
      stderr.writeln('\n$sourceFile:');
      for (final invalidReference in invalidReferences) {
        stderr.writeln(invalidReference);
      }
    });

    return 1;
  }

  print('No invalid link references found.');

  return 0;
}

/// Find all invalid link references within generated HTML files
/// in the specified [directory].
Map<String, List<String>> _findInvalidLinkReferences(Directory directory) {
  final invalidReferences = <String, List<String>>{};

  for (final filePath in directory
      .listSync(recursive: true)
      .map((f) => f.path)
      .where((p) => path.extension(p) == '.html')) {
    final content = File(filePath).readAsStringSync();
    final results = _findInContent(content);
    if (results.isNotEmpty) {
      invalidReferences[path.relative(filePath, from: directory.path)] =
          results;
    }
  }

  return invalidReferences;
}

List<String> _findInContent(String content) {
  for (final replacement in _allReplacements) {
    content = content.replaceAll(replacement, '');
  }

  // Use regex to find all links that displayed abnormally,
  // since a valid reference link should be an `<a>` tag after rendered:
  //
  // - `[flutter.dev][]`
  // - `[GitHub repo][repo]`
  // See also:
  // - https://github.github.com/gfm/#reference-link
  final invalidFound = _invalidLinkReferencePattern.allMatches(content);

  if (invalidFound.isEmpty) {
    return const [];
  }

  return invalidFound
      .map((e) => e[0])
      .whereType<String>()
      .toList(growable: false);
}

/// Ignore blocks with TODOs:
///
/// ```html
/// <!-- TODO(somebody): [Links here][are not rendered]. -->
/// ```
final _htmlCommentPattern = RegExp(r'<!--.*?-->', dotAll: true);

/// Ignore blocks with code:
///
/// ```dart
/// [[highlight]]flutter[[/highlight]]
/// ```
final _codeBlockPattern = RegExp(r'<pre.*?</pre>', dotAll: true);

/// Ignore PR titles that look like a link
/// directly embedded in a paragraph
/// and often found in release notes:
///
/// ```html
/// <p><a href="https://github.com/flutter/engine/pull/27070">27070</a>
/// [web][felt] Fix stdout inheritance for sub-processes
/// (cla: yes, waiting for tree to go green, platform-web, needs tests)
/// </p>
/// ```
final _pullRequestTitlePattern = RegExp(
  r'<p><a href="https://github.com/.*?/pull/\d+">\d+</a>.*?</p>',
  dotAll: true,
);

/// Ignore PR titles that look like a link,
/// directly embedded in a `<li>`
/// and often found in release notes:
///
/// ```html
/// <li>[docs][FWW] DropdownButton, ScaffoldMessenger, and StatefulBuilder links
/// by @craiglabenz in https://github.com/flutter/flutter/pull/100316</li>
/// ```
final _pullRequestTitleInListItemPattern = RegExp(
  r'<li>(?:(?!<li>).)*?in\s+(?:<a[^>]*?href="https://github\.com/[^/]+/[^/]+/pull/\d+">[\d]+</a>|https://github\.com/[^/]+/[^/]+/pull/\d+)(?:(?!<li>).)*?</li>',
  dotAll: true,
);

/// All replacements to run on a file content before finding invalid references.
final _allReplacements = [
  _htmlCommentPattern,
  _codeBlockPattern,
  _pullRequestTitlePattern,
  _pullRequestTitleInListItemPattern,
];

final _invalidLinkReferencePattern = RegExp(r'\[[^\[\]]+]\[[^\[\]]*]');
