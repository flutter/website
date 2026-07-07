// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

export 'src/utils/slugify.dart';

/// Whether this build of the site will be deployed to production.
const bool productionBuild = .fromEnvironment('PRODUCTION');

/// Parses attribute tokens from [attributeString] into HTML attributes.
///
/// Supports IDs (`#id`), classes (`.class`), and `key="value"` pairs,
/// joining multiple classes into a single space-separated `class` value.
Map<String, String> parseAttributes(String attributeString) {
  final attributes = <String, String>{};
  final classes = <String>[];

  // Extract all key="value" pairs.
  final keyValueMatches = _attributePattern.allMatches(attributeString);
  for (final match in keyValueMatches) {
    final key = match.group(1)!;
    final value = match.group(2)!;
    attributes[key] = value;
  }

  // Remove all key="value" pairs to process remaining tokens.
  final remaining = attributeString.replaceAll(_attributePattern, '').trim();

  // Split remaining content by whitespace to find IDs and classes.
  final parts = remaining.split(_whitespacePattern);

  for (final part in parts) {
    if (part.isEmpty) continue;

    if (part.startsWith('#')) {
      attributes['id'] = part.substring(1);
    } else if (part.startsWith('.')) {
      classes.add(part.substring(1));
    }
  }

  if (classes.isNotEmpty) {
    attributes['class'] = classes.join(' ');
  }

  return attributes;
}

final RegExp _attributePattern = RegExp(r'(\w+)="([^"]*)"');
final RegExp _whitespacePattern = RegExp(r'\s+');
final RegExp _wordPattern = RegExp(r'\S+(?:\s*|$)');
final RegExp _trailingMarkdownLinkPattern = RegExp(r'(\[.+\]:\s*\S+\s*)+$');

/// Truncates the specified [text] to the specified number of words [maxWords].
///
/// Leaves already-short text unchanged and
/// appends `...` after normalizing retained word spacing.
///
/// Returns an empty string when [maxWords] is non-positive.
String truncateWords(String text, int maxWords) {
  if (maxWords <= 0) {
    return '';
  }

  final words = text.trim().split(_whitespacePattern);
  if (words.length <= maxWords) {
    return text;
  }

  final truncated = words.take(maxWords).join(' ');
  return '$truncated...';
}

/// Truncates the given [text] to the specified number of words [maxWords],
/// preserving all whitespace and line breaks, as well as any trailing Markdown
/// link definitions at the end of the text.
String truncateWordsMarkdown(String text, int maxWords) {
  if (maxWords <= 0) {
    return '';
  }

  final trailingLinks = _trailingMarkdownLinkPattern.firstMatch(text);
  final String endContent;

  if (trailingLinks != null) {
    text = text.substring(0, trailingLinks.start);
    endContent = '\n${trailingLinks.group(0)!}';
  } else {
    endContent = '';
  }

  final matches = _wordPattern.allMatches(text);
  if (matches.length <= maxWords) {
    return text + endContent;
  }

  final truncated = matches.map((m) => m.group(0)!).take(maxWords).join('');
  return '$truncated...\n$endContent';
}

extension StringUnCapitalize on String {
  /// Returns a new string with the first character converted to lowercase.
  String unCapitalize() =>
      isEmpty ? this : substring(0, 1).toLowerCase() + substring(1);
}

extension ListToClasses on List<String> {
  /// Convert a list of classes into a single class string
  /// that can be added to an HTML element.
  String get toClasses => join(' ');
}
