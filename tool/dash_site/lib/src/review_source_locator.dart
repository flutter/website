// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:math' as math;

import 'package:path/path.dart' as path;

/// Resolved repository file path, 1-based line range, and surrounding snippet
/// for a highlighted selection or element on a rendered site page.
typedef SourceLocationResult = ({
  String resolvedFile,
  int? startLine,
  int? endLine,
  String? codeSnippet,
});

const Set<String> _searchableExtensions = {
  '.md',
  '.markdown',
  '.html',
  '.liquid',
  '.yaml',
  '.yml',
  '.json',
  '.dart',
};

const Set<String> _dataExtensions = {'.yaml', '.yml', '.json'};

const Set<String> _skippedDirectoryNames = {
  '.dart_tool',
  '.dash_review',
  '.firebase',
  '.git',
  '.idea',
  '.vscode',
  '_site',
  'build',
  'node_modules',
};

const int _maxSearchableFileBytes = 2 * 1024 * 1024;

/// Resolves a highlighted text quote, element text, or heading anchor back to
/// its repository-relative source file and 1-based line range.
///
/// All candidate paths are canonicalized and verified to stay strictly within
/// [repoRoot] so untrusted inputs cannot traverse outside the repository.
SourceLocationResult locateHighlightInRepo({
  required String repoRoot,
  required String site,
  String? sourceFile,
  String? selectedText,
  String? elementText,
  String? headingAnchor,
  String? pageUrl,
}) {
  final canonicalRoot = _canonicalizeRepoRoot(repoRoot);
  final safeSourceFile =
      sanitizeRepoRelativePath(
        repoRoot,
        sourceFile,
        canonicalRoot: canonicalRoot,
      ) ??
      '';

  final primaryCandidates = _collectPrimaryCandidates(
    canonicalRoot: canonicalRoot,
    site: site,
    rawSourceFile: sourceFile,
    safeSourceFile: safeSourceFile,
    pageUrl: pageUrl,
  );

  final queries = <String>[
    if (selectedText != null && selectedText.trim().isNotEmpty)
      selectedText.trim(),
    if (elementText != null &&
        elementText.trim().isNotEmpty &&
        elementText.trim() != selectedText?.trim())
      elementText.trim(),
  ];

  // 1. Search primary candidate file(s) with exact then tolerant matching.
  for (final candidate in primaryCandidates) {
    final content = _readTextFileSafely(candidate.absPath);
    if (content == null) continue;
    final isDart = candidate.relPath.endsWith('.dart');

    for (final query in queries) {
      final exact = _findExactMatch(content, query);
      if (exact != null) {
        return (
          resolvedFile: candidate.relPath,
          startLine: exact.startLine,
          endLine: exact.endLine,
          codeSnippet: exact.codeSnippet,
        );
      }

      final tolerant = _findTolerantMatch(content, query, isDartSource: isDart);
      if (tolerant != null) {
        return (
          resolvedFile: candidate.relPath,
          startLine: tolerant.startLine,
          endLine: tolerant.endLine,
          codeSnippet: tolerant.codeSnippet,
        );
      }
    }
  }

  // 2. Search secondary site sources (delegated components, includes, data).
  if (queries.isNotEmpty) {
    final secondaryCandidates = _collectSecondaryCandidates(
      canonicalRoot: canonicalRoot,
      site: site,
      primaryCandidates: primaryCandidates,
    );

    // Pass A: Exact substring match across secondary sources.
    final cachedContents = <String, String>{};
    for (final candidate in secondaryCandidates) {
      final content = _readTextFileSafely(candidate.absPath);
      if (content == null) continue;
      cachedContents[candidate.relPath] = content;

      for (final query in queries) {
        final exact = _findExactMatch(content, query);
        if (exact != null) {
          return (
            resolvedFile: candidate.relPath,
            startLine: exact.startLine,
            endLine: exact.endLine,
            codeSnippet: exact.codeSnippet,
          );
        }
      }
    }

    // Pass B: Markdown / Dart-string / whitespace-tolerant match across
    // secondary sources.
    for (final candidate in secondaryCandidates) {
      final content = cachedContents[candidate.relPath];
      if (content == null) continue;
      final isDart = candidate.relPath.endsWith('.dart');

      for (final query in queries) {
        final tolerant = _findTolerantMatch(
          content,
          query,
          isDartSource: isDart,
        );
        if (tolerant != null) {
          return (
            resolvedFile: candidate.relPath,
            startLine: tolerant.startLine,
            endLine: tolerant.endLine,
            codeSnippet: tolerant.codeSnippet,
          );
        }
      }
    }
  }

  // 3. Fallback to heading anchor (#slug -> matching heading or {#slug}).
  final cleanAnchor = _normalizeHeadingSlug(headingAnchor);
  if (cleanAnchor != null) {
    final anchorCandidates = <_CandidateFile>[
      ...primaryCandidates,
      ..._collectDelegatedPrimaryHints(
        canonicalRoot: canonicalRoot,
        site: site,
        primaryCandidates: primaryCandidates,
      ),
    ];
    final seenPaths = <String>{};
    for (final candidate in anchorCandidates) {
      if (!seenPaths.add(candidate.relPath)) continue;
      final content = _readTextFileSafely(candidate.absPath);
      if (content == null) continue;
      final headingMatch = _findHeadingAnchorMatch(content, cleanAnchor);
      if (headingMatch != null) {
        return (
          resolvedFile: candidate.relPath,
          startLine: headingMatch.startLine,
          endLine: headingMatch.endLine,
          codeSnippet: headingMatch.codeSnippet,
        );
      }
    }
  }

  final fallbackResolved = primaryCandidates.isNotEmpty
      ? primaryCandidates.first.relPath
      : safeSourceFile;

  return (
    resolvedFile: fallbackResolved,
    startLine: null,
    endLine: null,
    codeSnippet: null,
  );
}

/// Canonicalizes [rawPath] relative to [repoRoot] and verifies it stays
/// strictly inside [repoRoot] (including resolving symlinks along its path).
///
/// Returns a normalized POSIX repository-relative path, or `null` if [rawPath]
/// is empty or attempts to escape [repoRoot].
String? sanitizeRepoRelativePath(
  String repoRoot,
  String? rawPath, {
  String? canonicalRoot,
}) {
  if (rawPath == null) return null;
  if (rawPath.contains('\x00')) return null;

  var cleaned = rawPath.trim().replaceAll(r'\', '/');
  final queryIdx = cleaned.indexOf('?');
  if (queryIdx >= 0) cleaned = cleaned.substring(0, queryIdx);
  final hashIdx = cleaned.indexOf('#');
  if (hashIdx >= 0) cleaned = cleaned.substring(0, hashIdx);

  while (cleaned.startsWith('/')) {
    cleaned = cleaned.substring(1);
  }
  if (cleaned.isEmpty || cleaned == '.') return null;

  final root = canonicalRoot ?? _canonicalizeRepoRoot(repoRoot);
  final joined = path.join(root, path.fromUri(Uri(path: cleaned)));
  final canonicalCandidate = path.canonicalize(joined);

  if (!path.isWithin(root, canonicalCandidate)) {
    return null;
  }

  if (!_verifySymlinksStayWithinRoot(root, canonicalCandidate)) {
    return null;
  }

  final relative = path.relative(canonicalCandidate, from: root);
  if (relative.isEmpty || relative == '.' || relative.startsWith('..')) {
    return null;
  }
  return path.posix.joinAll(path.split(relative));
}

String _canonicalizeRepoRoot(String repoRoot) {
  final dir = Directory(repoRoot);
  if (dir.existsSync()) {
    try {
      return path.canonicalize(dir.resolveSymbolicLinksSync());
    } on FileSystemException {
      return path.canonicalize(repoRoot);
    }
  }
  return path.canonicalize(repoRoot);
}

bool _verifySymlinksStayWithinRoot(String canonicalRoot, String targetPath) {
  var current = targetPath;
  while (true) {
    final entityType = FileSystemEntity.typeSync(current, followLinks: false);
    if (entityType != FileSystemEntityType.notFound) {
      try {
        final String resolved;
        if (File(current).existsSync()) {
          resolved = path.canonicalize(
            File(current).resolveSymbolicLinksSync(),
          );
        } else if (Directory(current).existsSync()) {
          resolved = path.canonicalize(
            Directory(current).resolveSymbolicLinksSync(),
          );
        } else {
          // Broken symlink or special file; reject if it is a link.
          if (entityType == FileSystemEntityType.link) return false;
          resolved = path.canonicalize(current);
        }
        if (resolved != canonicalRoot &&
            !path.isWithin(canonicalRoot, resolved)) {
          return false;
        }
      } on FileSystemException {
        return false;
      }
      break;
    }

    final parent = path.dirname(current);
    if (parent == current || parent == canonicalRoot) {
      break;
    }
    current = parent;
  }
  return true;
}

typedef _CandidateFile = ({String relPath, String absPath});

typedef _LineMatch = ({int startLine, int endLine, String codeSnippet});

_CandidateFile? _resolveExistingRepoFile(
  String canonicalRoot,
  String candidateRelativePath,
) {
  final safeRel = sanitizeRepoRelativePath(
    canonicalRoot,
    candidateRelativePath,
    canonicalRoot: canonicalRoot,
  );
  if (safeRel == null) return null;

  final absPath = path.joinAll([canonicalRoot, ...path.posix.split(safeRel)]);
  final file = File(absPath);
  if (!file.existsSync()) return null;

  try {
    final resolvedReal = path.canonicalize(file.resolveSymbolicLinksSync());
    if (!path.isWithin(canonicalRoot, resolvedReal)) {
      return null;
    }
    return (relPath: safeRel, absPath: resolvedReal);
  } on FileSystemException {
    return null;
  }
}

List<_CandidateFile> _collectPrimaryCandidates({
  required String canonicalRoot,
  required String site,
  required String? rawSourceFile,
  required String safeSourceFile,
  required String? pageUrl,
}) {
  final rawVariants = <String>[];

  void addVariantsForPath(String basePath, {required bool endedWithSlash}) {
    if (basePath.isEmpty) return;
    rawVariants.add(basePath);

    if (endedWithSlash) {
      rawVariants.add('$basePath/index.md');
      rawVariants.add('$basePath.md');
    } else if (basePath.endsWith('/index.html')) {
      final stem = basePath.substring(
        0,
        basePath.length - '/index.html'.length,
      );
      rawVariants.add('$stem/index.md');
      if (stem.isNotEmpty) rawVariants.add('$stem.md');
    } else if (basePath.endsWith('.html')) {
      final stem = basePath.substring(0, basePath.length - '.html'.length);
      rawVariants.add('$stem.md');
      rawVariants.add('$stem/index.md');
    } else if (basePath.endsWith('/index.md')) {
      final stem = basePath.substring(0, basePath.length - '/index.md'.length);
      if (stem.isNotEmpty) rawVariants.add('$stem.md');
    } else if (basePath.endsWith('.md')) {
      final stem = basePath.substring(0, basePath.length - '.md'.length);
      rawVariants.add('$stem/index.md');
    } else if (path.posix.extension(basePath).isEmpty) {
      rawVariants.add('$basePath/index.md');
      rawVariants.add('$basePath.md');
    }
  }

  final rawTrimmed = rawSourceFile?.trim() ?? '';
  final endedWithSlash = rawTrimmed.endsWith('/');
  if (safeSourceFile.isNotEmpty) {
    addVariantsForPath(safeSourceFile, endedWithSlash: endedWithSlash);
  }

  if (pageUrl != null && pageUrl.trim().isNotEmpty) {
    final contentPrefix = site == 'www'
        ? 'sites/www/content'
        : 'sites/docs/src/content';
    var cleanUrl = pageUrl.trim();
    final qIdx = cleanUrl.indexOf('?');
    if (qIdx >= 0) cleanUrl = cleanUrl.substring(0, qIdx);
    final hIdx = cleanUrl.indexOf('#');
    if (hIdx >= 0) cleanUrl = cleanUrl.substring(0, hIdx);
    final urlEndedWithSlash = cleanUrl.endsWith('/');
    while (cleanUrl.startsWith('/')) {
      cleanUrl = cleanUrl.substring(1);
    }
    while (cleanUrl.endsWith('/')) {
      cleanUrl = cleanUrl.substring(0, cleanUrl.length - 1);
    }
    if (cleanUrl.isEmpty) {
      rawVariants.add('$contentPrefix/index.md');
    } else {
      addVariantsForPath(
        '$contentPrefix/$cleanUrl',
        endedWithSlash: urlEndedWithSlash,
      );
    }
  }

  final results = <_CandidateFile>[];
  final seen = <String>{};
  for (final variant in rawVariants) {
    final resolved = _resolveExistingRepoFile(canonicalRoot, variant);
    if (resolved != null && seen.add(resolved.relPath)) {
      results.add(resolved);
    }
  }
  return results;
}

List<_CandidateFile> _collectDelegatedPrimaryHints({
  required String canonicalRoot,
  required String site,
  required List<_CandidateFile> primaryCandidates,
}) {
  final hints = <_CandidateFile>[];
  final seen = <String>{
    for (final primary in primaryCandidates) primary.relPath,
  };

  void addHint(String relCandidate) {
    final resolved = _resolveExistingRepoFile(canonicalRoot, relCandidate);
    if (resolved != null && seen.add(resolved.relPath)) {
      hints.add(resolved);
    }
  }

  for (final primary in primaryCandidates) {
    final content = _readTextFileSafely(primary.absPath);
    if (content == null) continue;

    if (site == 'docs') {
      // Liquid {% include 'path/to/partial.md' %} references.
      final includePattern = RegExp(
        r'''\{%-?\s*include\s+['"]?([^'"\s%}]+)['"]?''',
      );
      for (final match in includePattern.allMatches(content)) {
        final includePath = match.group(1);
        if (includePath == null || includePath.isEmpty) continue;
        addHint('sites/docs/src/_includes/$includePath');
        if (path.posix.extension(includePath).isEmpty) {
          addHint('sites/docs/src/_includes/$includePath.md');
          addHint('sites/docs/src/_includes/$includePath.html');
        }
      }
    } else if (site == 'www') {
      // Jaspr custom components like <HomePage /> or <WhyFlutterPage />.
      final componentPattern = RegExp(r'<([A-Z][A-Za-z0-9_]*)\b');
      for (final match in componentPattern.allMatches(content)) {
        final componentName = match.group(1);
        if (componentName == null) continue;
        final snakeName = _camelToSnakeCase(componentName);
        addHint('sites/www/lib/src/pages/$snakeName.dart');
        addHint('sites/www/lib/src/components/pages/$snakeName.dart');
        addHint('sites/www/lib/src/components/sections/$snakeName.dart');
        addHint('sites/www/lib/src/components/common/$snakeName.dart');
      }

      // Data files adjacent to the primary content file (or home/ for root index).
      final primaryDir = path.posix.dirname(primary.relPath);
      if (primary.relPath == 'sites/www/content/index.md') {
        _collectDirectoryFiles(
          canonicalRoot: canonicalRoot,
          relativeDir: 'sites/www/content/home',
          allowedExtensions: _dataExtensions,
          seen: seen,
          out: hints,
        );
      } else if (primaryDir.startsWith('sites/www/content')) {
        _collectDirectoryFiles(
          canonicalRoot: canonicalRoot,
          relativeDir: primaryDir,
          allowedExtensions: _dataExtensions,
          seen: seen,
          out: hints,
        );
      }
    }
  }

  return hints;
}

List<_CandidateFile> _collectSecondaryCandidates({
  required String canonicalRoot,
  required String site,
  required List<_CandidateFile> primaryCandidates,
}) {
  final results = <_CandidateFile>[];
  final seen = <String>{
    for (final primary in primaryCandidates) primary.relPath,
  };

  // First add files explicitly referenced by the primary file.
  for (final hint in _collectDelegatedPrimaryHints(
    canonicalRoot: canonicalRoot,
    site: site,
    primaryCandidates: primaryCandidates,
  )) {
    if (seen.add(hint.relPath)) {
      results.add(hint);
    }
  }

  if (site == 'www') {
    _collectDirectoryFiles(
      canonicalRoot: canonicalRoot,
      relativeDir: 'sites/www/content/_data',
      allowedExtensions: _searchableExtensions,
      seen: seen,
      out: results,
    );
    _collectDirectoryFiles(
      canonicalRoot: canonicalRoot,
      relativeDir: 'sites/www/content',
      allowedExtensions: _dataExtensions,
      seen: seen,
      out: results,
    );

    final dartFiles = <_CandidateFile>[];
    _collectDirectoryFiles(
      canonicalRoot: canonicalRoot,
      relativeDir: 'sites/www/lib/src',
      allowedExtensions: const {'.dart'},
      seen: seen,
      out: dartFiles,
    );
    // Prefer hand-authored Dart files over generated *.mapper.dart files.
    results.addAll(
      dartFiles.where((file) => !file.relPath.endsWith('.mapper.dart')),
    );
    results.addAll(
      dartFiles.where((file) => file.relPath.endsWith('.mapper.dart')),
    );
  } else {
    _collectDirectoryFiles(
      canonicalRoot: canonicalRoot,
      relativeDir: 'sites/docs/src/_includes',
      allowedExtensions: _searchableExtensions,
      seen: seen,
      out: results,
    );
    _collectDirectoryFiles(
      canonicalRoot: canonicalRoot,
      relativeDir: 'sites/docs/src/data',
      allowedExtensions: _searchableExtensions,
      seen: seen,
      out: results,
    );
    _collectDirectoryFiles(
      canonicalRoot: canonicalRoot,
      relativeDir: 'sites/docs/lib/src',
      allowedExtensions: const {'.dart'},
      seen: seen,
      out: results,
    );
    _collectDirectoryFiles(
      canonicalRoot: canonicalRoot,
      relativeDir: 'examples',
      allowedExtensions: const {'.dart', '.yaml', '.yml', '.md'},
      seen: seen,
      out: results,
    );
  }

  return results;
}

void _collectDirectoryFiles({
  required String canonicalRoot,
  required String relativeDir,
  required Set<String> allowedExtensions,
  required Set<String> seen,
  required List<_CandidateFile> out,
}) {
  final safeDirRel = sanitizeRepoRelativePath(
    canonicalRoot,
    relativeDir,
    canonicalRoot: canonicalRoot,
  );
  if (safeDirRel == null) return;

  final rootDir = Directory(
    path.joinAll([canonicalRoot, ...path.posix.split(safeDirRel)]),
  );
  if (!rootDir.existsSync()) return;

  void walk(Directory directory) {
    final List<FileSystemEntity> entries;
    try {
      entries = directory.listSync(followLinks: false)
        ..sort((a, b) => a.path.compareTo(b.path));
    } on FileSystemException {
      return;
    }

    for (final entry in entries) {
      final baseName = path.basename(entry.path);
      if (_skippedDirectoryNames.contains(baseName)) continue;
      if (baseName.startsWith('.') && baseName != '_data') continue;

      if (entry is Directory) {
        walk(entry);
      } else if (entry is File) {
        final ext = path.extension(baseName).toLowerCase();
        if (!allowedExtensions.contains(ext)) continue;

        try {
          final realAbs = path.canonicalize(entry.resolveSymbolicLinksSync());
          if (!path.isWithin(canonicalRoot, realAbs)) continue;
          final rel = path.posix.joinAll(
            path.split(path.relative(realAbs, from: canonicalRoot)),
          );
          if (seen.add(rel)) {
            out.add((relPath: rel, absPath: realAbs));
          }
        } on FileSystemException {
          continue;
        }
      }
    }
  }

  walk(rootDir);
}

String? _readTextFileSafely(String absPath) {
  final file = File(absPath);
  try {
    final stat = file.statSync();
    if (stat.type != FileSystemEntityType.file ||
        stat.size > _maxSearchableFileBytes) {
      return null;
    }
    return file.readAsStringSync();
  } on FileSystemException {
    return null;
  }
}

String _camelToSnakeCase(String input) {
  final buffer = StringBuffer();
  for (var i = 0; i < input.length; i++) {
    final char = input[i];
    final isUpper = char.toUpperCase() == char && char.toLowerCase() != char;
    if (isUpper && i > 0) {
      final prev = input[i - 1];
      final prevIsUpper =
          prev.toUpperCase() == prev && prev.toLowerCase() != prev;
      final nextIsLower =
          i + 1 < input.length &&
          input[i + 1].toLowerCase() == input[i + 1] &&
          input[i + 1].toUpperCase() != input[i + 1];
      if (!prevIsUpper || nextIsLower) {
        buffer.write('_');
      }
    }
    buffer.write(char.toLowerCase());
  }
  return buffer.toString();
}

_LineMatch? _findExactMatch(String content, String rawQuery) {
  final query = rawQuery.trim();
  if (query.isEmpty) return null;

  final directIndex = content.indexOf(query);
  if (directIndex >= 0) {
    return _buildLineMatchFromRawSpan(
      content,
      directIndex,
      directIndex + query.length - 1,
    );
  }

  // Handle CRLF source files when query uses LF.
  if (content.contains('\r\n') &&
      query.contains('\n') &&
      !query.contains('\r\n')) {
    final crlfQuery = query.replaceAll('\n', '\r\n');
    final crlfIndex = content.indexOf(crlfQuery);
    if (crlfIndex >= 0) {
      return _buildLineMatchFromRawSpan(
        content,
        crlfIndex,
        crlfIndex + crlfQuery.length - 1,
      );
    }
  }

  return null;
}

_LineMatch? _findTolerantMatch(
  String content,
  String rawQuery, {
  required bool isDartSource,
}) {
  final collapsedQuery = _collapseQueryWhitespace(rawQuery);
  if (collapsedQuery.isEmpty) return null;

  final projection = _buildNormalizedProjection(
    content,
    isDartSource: isDartSource,
  );
  if (projection.text.isEmpty) return null;

  final candidateQueries = <String>[
    collapsedQuery,
    if (!isDartSource)
      _buildNormalizedProjection(rawQuery, isDartSource: false).text,
  ];

  for (final normalizedQuery in candidateQueries) {
    if (normalizedQuery.isEmpty) continue;
    final matchIdx = projection.text.indexOf(normalizedQuery);
    if (matchIdx >= 0) {
      final rawStart = projection.offsets[matchIdx];
      final rawEnd = projection.offsets[matchIdx + normalizedQuery.length - 1];
      return _buildLineMatchFromRawSpan(content, rawStart, rawEnd);
    }
  }

  // Case-insensitive fallback for CSS-transformed headings (e.g. uppercase).
  if (collapsedQuery.length >= 4) {
    final lowerText = projection.text.toLowerCase();
    final lowerQuery = collapsedQuery.toLowerCase();
    if (lowerText.length == projection.offsets.length) {
      final lowerIdx = lowerText.indexOf(lowerQuery);
      if (lowerIdx >= 0) {
        final rawStart = projection.offsets[lowerIdx];
        final rawEnd = projection.offsets[lowerIdx + lowerQuery.length - 1];
        return _buildLineMatchFromRawSpan(content, rawStart, rawEnd);
      }
    }
  }

  return null;
}

String _collapseQueryWhitespace(String query) {
  final buffer = StringBuffer();
  var previousWasSpace = true;
  for (var i = 0; i < query.length; i++) {
    final ch = _normalizeVisibleChar(query[i]);
    if (_isWhitespaceChar(ch)) {
      if (!previousWasSpace) {
        buffer.write(' ');
        previousWasSpace = true;
      }
    } else {
      buffer.write(ch);
      previousWasSpace = false;
    }
  }
  final result = buffer.toString();
  return result.endsWith(' ') ? result.substring(0, result.length - 1) : result;
}

String _normalizeVisibleChar(String ch) => switch (ch) {
  '\u2018' || '\u2019' => "'",
  '\u201C' || '\u201D' => '"',
  '\u00A0' => ' ',
  _ => ch,
};

bool _isWhitespaceChar(String ch) =>
    ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r' || ch == '\u00A0';

bool _isWordChar(String ch) {
  if (ch.isEmpty) return false;
  final code = ch.codeUnitAt(0);
  return (code >= 0x30 && code <= 0x39) ||
      (code >= 0x41 && code <= 0x5A) ||
      (code >= 0x61 && code <= 0x7A);
}

({String text, List<int> offsets}) _buildNormalizedProjection(
  String content, {
  required bool isDartSource,
}) {
  final buffer = StringBuffer();
  final offsets = <int>[];
  var lastWasSpace = true;

  void emitSpace(int rawIndex) {
    if (!lastWasSpace && offsets.isNotEmpty) {
      buffer.write(' ');
      offsets.add(rawIndex);
      lastWasSpace = true;
    }
  }

  void emitVisible(String ch, int rawIndex) {
    final normalized = _normalizeVisibleChar(ch);
    if (_isWhitespaceChar(normalized)) {
      emitSpace(rawIndex);
      return;
    }
    buffer.write(normalized);
    offsets.add(rawIndex);
    lastWasSpace = false;
  }

  final length = content.length;
  // Map of closing `]` index -> resume index after `](url)` or `][ref]`.
  final linkCloseSkips = <int, int>{};

  var i = 0;
  while (i < length) {
    if (linkCloseSkips.remove(i) case final resumeAfterLink?) {
      i = resumeAfterLink;
      continue;
    }

    final ch = content[i];

    if (isDartSource) {
      // Handle escaped quotes and newline escapes inside Dart strings.
      if (ch == r'\' && i + 1 < length) {
        final next = content[i + 1];
        if (next == "'" || next == '"' || next == r'\' || next == r'$') {
          emitVisible(next, i + 1);
          i += 2;
          continue;
        }
        if (next == 'n' || next == 't' || next == 'r') {
          emitSpace(i);
          i += 2;
          continue;
        }
      }

      // Join adjacent Dart string literals across lines:
      // `'First sentence. '\n  'Second sentence.'`
      if (ch == "'" || ch == '"') {
        final adjacentResume = _matchAdjacentDartStringQuote(content, i, ch);
        if (adjacentResume != null) {
          i = adjacentResume;
          continue;
        }
      }

      if (_isWhitespaceChar(ch)) {
        emitSpace(i);
      } else {
        emitVisible(ch, i);
      }
      i++;
      continue;
    }

    // Markdown / Liquid / HTML / YAML projection.
    final atLineStart = i == 0 || content[i - 1] == '\n';
    if (atLineStart) {
      // Fenced code block delimiter line (```lang or ~~~).
      final fenceMatch = RegExp(r'^[ \t]*(?:```+|~~~+)[^\n]*')
          .matchAsPrefix(content, i);
      if (fenceMatch != null) {
        emitSpace(i);
        i = fenceMatch.end;
        continue;
      }

      // Alert container fence (`:::note Optional title` or `:::`).
      final alertMatch = RegExp(r'^[ \t]*:::[a-zA-Z0-9_-]*[ \t]*')
          .matchAsPrefix(content, i);
      if (alertMatch != null) {
        emitSpace(i);
        i = alertMatch.end;
        continue;
      }

      // ATX heading (`## `), blockquote (`> `), or list bullet (`- `, `1. `).
      final linePrefixMatch = RegExp(
        r'^[ \t]*(?:#{1,6}[ \t]+|>[ \t]?|[-*+][ \t]+|\d+\.[ \t]+)',
      ).matchAsPrefix(content, i);
      if (linePrefixMatch != null) {
        emitSpace(i);
        i = linePrefixMatch.end;
        continue;
      }
    }

    // HTML comments `<!-- ... -->`.
    if (content.startsWith('<!--', i)) {
      final closeIdx = content.indexOf('-->', i + 4);
      i = closeIdx >= 0 ? closeIdx + 3 : length;
      continue;
    }

    // Processing instructions `<?code-excerpt ...?>`.
    if (content.startsWith('<?', i)) {
      final closeIdx = content.indexOf('?>', i + 2);
      i = closeIdx >= 0 ? closeIdx + 2 : length;
      continue;
    }

    // Liquid tags `{% ... %}`.
    if (content.startsWith('{%', i)) {
      final closeIdx = content.indexOf('%}', i + 2);
      i = closeIdx >= 0 ? closeIdx + 2 : length;
      continue;
    }

    // Attribute blocks `{#heading-id}` or `{: .class}`.
    if (ch == '{' &&
        i + 1 < length &&
        (content[i + 1] == '#' || content[i + 1] == ':')) {
      final closeBrace = content.indexOf('}', i + 2);
      if (closeBrace >= 0 && !content.substring(i, closeBrace).contains('\n')) {
        i = closeBrace + 1;
        continue;
      }
    }

    // Markdown backslash escape.
    if (ch == r'\' && i + 1 < length && !_isWhitespaceChar(content[i + 1])) {
      emitVisible(content[i + 1], i + 1);
      i += 2;
      continue;
    }

    // Markdown image `![alt](url)` -> keep `alt`.
    if (ch == '!' && i + 1 < length && content[i + 1] == '[') {
      final linkTarget = _matchMarkdownLinkBrackets(content, i + 1);
      if (linkTarget != null) {
        linkCloseSkips[linkTarget.closeBracket] = linkTarget.afterTarget;
        i += 2;
        continue;
      }
    }

    // Markdown link `[text](url)` or `[text][ref]` -> keep `text` offsets.
    if (ch == '[') {
      final linkTarget = _matchMarkdownLinkBrackets(content, i);
      if (linkTarget != null) {
        linkCloseSkips[linkTarget.closeBracket] = linkTarget.afterTarget;
        i++;
        continue;
      }
    }

    // Inline code backticks `` `code` ``.
    if (ch == '`') {
      while (i < length && content[i] == '`') {
        i++;
      }
      continue;
    }

    // Bold / italic / strikethrough markers (`**`, `*`, `~~`, `_`).
    if (ch == '*' || ch == '~') {
      final prevSpace = i == 0 || _isWhitespaceChar(content[i - 1]);
      final nextSpace = i + 1 >= length || _isWhitespaceChar(content[i + 1]);
      if (!(prevSpace && nextSpace)) {
        while (i < length && content[i] == ch) {
          i++;
        }
        continue;
      }
    }

    if (ch == '_') {
      final prevWord = i > 0 && _isWordChar(content[i - 1]);
      var runEnd = i;
      while (runEnd < length && content[runEnd] == '_') {
        runEnd++;
      }
      final nextWord = runEnd < length && _isWordChar(content[runEnd]);
      // Preserve snake_case identifiers (`prevWord && nextWord`), strip `_`.
      if (!(prevWord && nextWord)) {
        i = runEnd;
        continue;
      }
    }

    // Angle-bracket autolinks `<https://...>` vs inline HTML tags `<code>`.
    if (ch == '<') {
      final autolinkMatch = RegExp(r'^<(https?://[^>\s]+)>')
          .matchAsPrefix(content, i);
      if (autolinkMatch != null) {
        final urlText = autolinkMatch.group(1)!;
        for (var k = 0; k < urlText.length; k++) {
          emitVisible(urlText[k], i + 1 + k);
        }
        i = autolinkMatch.end;
        continue;
      }

      final htmlTagMatch = RegExp(r'^</?[a-zA-Z][a-zA-Z0-9-]*(?:\s+[^>\n]*)?>')
          .matchAsPrefix(content, i);
      if (htmlTagMatch != null) {
        final tagLower = htmlTagMatch.group(0)!.toLowerCase();
        if (tagLower.startsWith('<br')) {
          emitSpace(i);
        }
        i = htmlTagMatch.end;
        continue;
      }
    }

    if (_isWhitespaceChar(ch)) {
      emitSpace(i);
    } else {
      emitVisible(ch, i);
    }
    i++;
  }

  var text = buffer.toString();
  if (text.endsWith(' ') && offsets.isNotEmpty) {
    text = text.substring(0, text.length - 1);
    offsets.removeLast();
  }

  return (text: text, offsets: offsets);
}

int? _matchAdjacentDartStringQuote(
  String content,
  int quoteIndex,
  String quote,
) {
  var j = quoteIndex + 1;
  var sawNewlineOrSpace = false;
  while (j < content.length) {
    final c = content[j];
    if (c == ' ' || c == '\t' || c == '\r' || c == '\n') {
      sawNewlineOrSpace = true;
      j++;
      continue;
    }
    // Skip single-line comment between adjacent string literals.
    if (c == '/' && j + 1 < content.length && content[j + 1] == '/') {
      final nextNewline = content.indexOf('\n', j + 2);
      if (nextNewline < 0) return null;
      sawNewlineOrSpace = true;
      j = nextNewline + 1;
      continue;
    }
    break;
  }

  if (!sawNewlineOrSpace || j >= content.length) return null;
  if (content[j] == 'r' && j + 1 < content.length && content[j + 1] == quote) {
    return j + 2;
  }
  if (content[j] == quote) {
    return j + 1;
  }
  return null;
}

({int closeBracket, int afterTarget})? _matchMarkdownLinkBrackets(
  String content,
  int openBracketIndex,
) {
  var depth = 0;
  var j = openBracketIndex;
  while (j < content.length) {
    final c = content[j];
    if (c == r'\') {
      j += 2;
      continue;
    }
    if (c == '\n' && j + 1 < content.length && content[j + 1] == '\n') {
      // Markdown inline link text does not span blank lines.
      return null;
    }
    if (c == '[') {
      depth++;
    } else if (c == ']') {
      depth--;
      if (depth == 0) {
        if (j + 1 >= content.length) return null;
        final next = content[j + 1];
        if (next == '(') {
          var parenDepth = 1;
          var k = j + 2;
          while (k < content.length && parenDepth > 0) {
            if (content[k] == r'\') {
              k += 2;
              continue;
            }
            if (content[k] == '(') parenDepth++;
            if (content[k] == ')') parenDepth--;
            k++;
          }
          if (parenDepth == 0) {
            return (closeBracket: j, afterTarget: k);
          }
        } else if (next == '[') {
          final closeRef = content.indexOf(']', j + 2);
          if (closeRef >= 0 &&
              !content.substring(j + 2, closeRef).contains('\n')) {
            return (closeBracket: j, afterTarget: closeRef + 1);
          }
        }
        return null;
      }
    }
    j++;
  }
  return null;
}

String? _normalizeHeadingSlug(String? headingAnchor) {
  if (headingAnchor == null) return null;
  var slug = headingAnchor.trim();
  while (slug.startsWith('#')) {
    slug = slug.substring(1);
  }
  slug = slug.trim().toLowerCase();
  return slug.isEmpty ? null : slug;
}

_LineMatch? _findHeadingAnchorMatch(String content, String targetSlug) {
  final lines = content.split('\n');
  final explicitIdPatterns = [
    RegExp(r'\{#\s*' + RegExp.escape(targetSlug) + r'\b', caseSensitive: false),
    RegExp(
      r'''\bid\s*[:=]\s*['"]''' + RegExp.escape(targetSlug) + r'''['"]''',
      caseSensitive: false,
    ),
  ];
  final atxHeadingPattern = RegExp(
    r'^\s*#{1,6}\s+(.+?)(?:\s*\{#([a-zA-Z0-9_-]+)[^}]*\})?\s*$',
  );

  for (var idx = 0; idx < lines.length; idx++) {
    final line = lines[idx].replaceAll('\r', '');

    for (final pattern in explicitIdPatterns) {
      if (pattern.hasMatch(line)) {
        final lineNumber = idx + 1;
        return (
          startLine: lineNumber,
          endLine: lineNumber,
          codeSnippet: _extractSnippet(lines, lineNumber, lineNumber),
        );
      }
    }

    final headingMatch = atxHeadingPattern.firstMatch(line);
    if (headingMatch != null) {
      final rawHeadingText = headingMatch.group(1) ?? '';
      final explicitSlug = headingMatch.group(2)?.toLowerCase();
      if (explicitSlug == targetSlug ||
          _headingSlugsForText(rawHeadingText).contains(targetSlug)) {
        final lineNumber = idx + 1;
        return (
          startLine: lineNumber,
          endLine: lineNumber,
          codeSnippet: _extractSnippet(lines, lineNumber, lineNumber),
        );
      }
    }
  }

  return null;
}

Set<String> _headingSlugsForText(String rawHeading) {
  final plain = _buildNormalizedProjection(
    rawHeading,
    isDartSource: false,
  ).text.toLowerCase();
  if (plain.isEmpty) return const {};

  // Variant 1: GitHub / Jaspr style (strip punctuation, convert spaces to `-`).
  final gfmSlug = plain
      .replaceAll(RegExp(r'[^\w\s-]'), '')
      .trim()
      .replaceAll(RegExp(r'[\s]+'), '-')
      .replaceAll(RegExp(r'-+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');

  // Variant 2: Simple non-alphanumeric runs to `-`.
  final dashedSlug = plain
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');

  return {
    if (gfmSlug.isNotEmpty) gfmSlug,
    if (dashedSlug.isNotEmpty) dashedSlug,
  };
}

_LineMatch _buildLineMatchFromRawSpan(
  String content,
  int rawStart,
  int rawEnd,
) {
  final maxIndex = math.max(0, content.length - 1);
  final clampedStart = math.min(math.max(0, rawStart), maxIndex);
  final clampedEnd = math.min(math.max(clampedStart, rawEnd), maxIndex);

  var startLine = 1;
  for (var i = 0; i < clampedStart; i++) {
    if (content.codeUnitAt(i) == 0x0A) startLine++;
  }

  var endLine = startLine;
  for (var i = clampedStart; i < clampedEnd; i++) {
    if (content.codeUnitAt(i) == 0x0A) endLine++;
  }

  final lines = content.split('\n');
  return (
    startLine: startLine,
    endLine: endLine,
    codeSnippet: _extractSnippet(lines, startLine, endLine),
  );
}

String _extractSnippet(List<String> rawLines, int startLine, int endLine) {
  if (rawLines.isEmpty) return '';
  final firstIdx = math.max(0, startLine - 2);
  var lastIdx = math.min(rawLines.length - 1, endLine);
  // Ensure up to 3 lines when matching at the very first or last line.
  if (lastIdx - firstIdx + 1 < 3) {
    if (firstIdx == 0) {
      lastIdx = math.min(rawLines.length - 1, 2);
    } else if (lastIdx == rawLines.length - 1) {
      final adjustedFirst = math.max(0, rawLines.length - 3);
      return rawLines
          .sublist(adjustedFirst, lastIdx + 1)
          .map((line) => line.replaceAll('\r', ''))
          .join('\n');
    }
  }
  // Cap large multi-line snippets so feedback files stay concise.
  final cappedLast = math.min(lastIdx, firstIdx + 14);
  return rawLines
      .sublist(firstIdx, cappedLast + 1)
      .map((line) => line.replaceAll('\r', ''))
      .join('\n');
}
