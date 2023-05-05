import 'dart:io';

import 'package:path/path.dart' as path;

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
    dotAll: true);

/// Ignore PR titles that look like a link,
/// directly embedded in a `<li>`
/// and often found in release notes:
///
/// ```html
/// <li>[docs][FWW] DropdownButton, ScaffoldMessenger, and StatefulBuilder links
/// by @craiglabenz in https://github.com/flutter/flutter/pull/100316</li>
/// ```
final _pullRequestTitleInListItemPattern =
    RegExp(r'<li>.*? in.*?https://github.com/.*?/pull/.*?</li>', dotAll: true);

/// All replacements to run on file content before finding invalid references.
final _allReplacements = [
  _htmlCommentPattern,
  _codeBlockPattern,
  _pullRequestTitlePattern,
  _pullRequestTitleInListItemPattern,
];

final _invalidLinkReferencePattern = RegExp(r'\[[^\[\]]+]\[[^\[\]]*]');

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

/// Find all invalid link references
/// within generated HTML files
/// in the specified [directory].
Map<String, List<String>> findInvalidLinkReferences(String directory) {
  final invalidReferences = <String, List<String>>{};

  for (final filePath in Directory(directory)
      .listSync(recursive: true)
      .map((f) => f.path)
      .where((p) => path.extension(p) == '.html')) {
    final content = File(filePath).readAsStringSync();
    final results = _findInContent(content);
    if (results.isNotEmpty) {
      invalidReferences[path.relative(filePath, from: directory)] = results;
    }
  }

  return invalidReferences;
}

void main() {
  final filesToInvalidReferences = findInvalidLinkReferences('_site');

  if (filesToInvalidReferences.isNotEmpty) {
    print('check_link_references: Invalid link references found!');

    filesToInvalidReferences.forEach((sourceFile, invalidReferences) {
      print('\n$sourceFile:');
      for (final invalidReference in invalidReferences) {
        print(invalidReference);
      }
    });

    exit(1);
  }
}
