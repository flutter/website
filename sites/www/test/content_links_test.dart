// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';

final RegExp _fencePattern = RegExp(r'^\s*(`{3,}|~{3,})');
final RegExp _inlineCodePattern = RegExp(r'`+[^`]+`+');
final RegExp _flutterBlogLinkPattern = RegExp(
  r'\{\{\s*site\.flutter-blog\s*\}\}([^\s\)\]\">\'
  r"'"
  r'`]*)',
);
final RegExp _unrenderedSiteVarPattern = RegExp(r'\{\{\s*site\.');
final RegExp _skipTemplatePattern = RegExp(
  r'^skipTemplateRendering:\s*true\s*$',
  multiLine: true,
);

String _resolveRepoRoot() {
  for (final candidate in ['../..', '.']) {
    if (File(path.join(candidate, 'sites/docs/src/data/site.yml'))
        .existsSync()) {
      return candidate;
    }
  }
  throw StateError(
    'Unable to locate repository root from ${Directory.current.path}',
  );
}

Iterable<File> _sourceFilesUnder(String rootDir, Set<String> extensions) sync* {
  for (final entity in Directory(
    rootDir,
  ).listSync(recursive: true, followLinks: false)) {
    if (entity is File && extensions.contains(path.extension(entity.path))) {
      yield entity;
    }
  }
}

List<(int, String)> _nonCodeLines(List<String> lines) {
  final result = <(int, String)>[];
  String? activeFenceChar;
  var activeFenceLength = 0;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final match = _fencePattern.firstMatch(line);
    if (activeFenceChar == null && match != null) {
      final marker = match.group(1)!;
      activeFenceChar = marker[0];
      activeFenceLength = marker.length;
      continue;
    }
    if (activeFenceChar != null) {
      final trimmed = line.trimLeft();
      if (trimmed.startsWith(activeFenceChar * activeFenceLength) &&
          trimmed.replaceAll(activeFenceChar, '').trim().isEmpty) {
        activeFenceChar = null;
        activeFenceLength = 0;
      }
      continue;
    }
    result.add((i + 1, line.replaceAll(_inlineCodePattern, '')));
  }
  return result;
}

bool _hasSkipTemplateRendering(String content) {
  if (!content.startsWith('---\n')) return false;
  final endIndex = content.indexOf('\n---', 4);
  if (endIndex == -1) return false;
  final frontMatter = content.substring(4, endIndex);
  return _skipTemplatePattern.hasMatch(frontMatter);
}

String? _validateFlutterBlogSuffix(String suffix, String blogContentRoot) {
  final withoutFragment = suffix.split('#').first;
  if (withoutFragment.isEmpty || withoutFragment == '/') return null;
  if (withoutFragment.contains('?')) {
    return 'unsupported query "$suffix"';
  }
  final slug = withoutFragment.replaceAll(RegExp(r'^/+|/+$'), '');
  final postIndex = File(path.join(blogContentRoot, slug, 'index.md'));
  final postFile = File(path.join(blogContentRoot, '$slug.md'));
  if (!postIndex.existsSync() && !postFile.existsSync()) {
    return 'missing blog slug "$slug"';
  }
  return null;
}

List<String> _findBrokenFlutterBlogLinks(String repoRoot) {
  final docsSrc = path.join(repoRoot, 'sites/docs/src');
  final blogContentRoot = path.join(repoRoot, 'sites/www/content/blog');
  final failures = <String>[];

  for (final file in _sourceFilesUnder(docsSrc, const {
    '.md',
    '.html',
    '.yml',
  })) {
    final relPath = path.relative(file.path, from: repoRoot);
    final lines = file.readAsLinesSync();
    for (final (lineNumber, cleanLine) in _nonCodeLines(lines)) {
      for (final match in _flutterBlogLinkPattern.allMatches(cleanLine)) {
        final error = _validateFlutterBlogSuffix(
          match.group(1)!,
          blogContentRoot,
        );
        if (error != null) {
          failures.add('$relPath:$lineNumber -> $error');
        }
      }
    }
  }
  return failures;
}

List<String> _findUnrenderedSiteVariables(String repoRoot) {
  final docsContent = path.join(repoRoot, 'sites/docs/src/content');
  final failures = <String>[];

  for (final file in _sourceFilesUnder(docsContent, const {'.md'})) {
    final content = file.readAsStringSync();
    if (!_hasSkipTemplateRendering(content)) continue;
    final relPath = path.relative(file.path, from: repoRoot);
    for (final (lineNumber, cleanLine) in _nonCodeLines(content.split('\n'))) {
      if (_unrenderedSiteVarPattern.hasMatch(cleanLine)) {
        failures.add('$relPath:${_linePreview(lineNumber, cleanLine)}');
      }
    }
  }
  return failures;
}

String _linePreview(int lineNumber, String line) =>
    '$lineNumber -> ${line.trim()}';

void main() {
  group('Cross-site content links', () {
    late final repoRoot = _resolveRepoRoot();

    test(
      'every {{site.flutter-blog}} path in docs resolves to a blog post',
      () {
        final siteYaml = File(
          path.join(repoRoot, 'sites/docs/src/data/site.yml'),
        ).readAsStringSync();
        expect(
          siteYaml,
          contains('flutter-blog: https://flutter.dev/blog'),
        );

        final brokenLinks = _findBrokenFlutterBlogLinks(repoRoot);
        expect(brokenLinks, isEmpty, reason: brokenLinks.join('\n'));
      },
    );

    test(
      'skipTemplateRendering pages contain no unexpanded {{site.*}} tokens',
      () {
        final leaks = _findUnrenderedSiteVariables(repoRoot);
        expect(leaks, isEmpty, reason: leaks.join('\n'));
      },
    );
  });
}
