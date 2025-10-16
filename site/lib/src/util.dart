// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:path/path.dart' as path;

/// Whether this build of the site will be deployed to production.
const productionBuild = bool.fromEnvironment('PRODUCTION');

/// Path to the `/src` directory where site content is located.
final siteSrcDirectoryPath = path.join('..', 'src');

/// Split the specific [sourceString] into a list of Jaspr [Component]
/// by adding a `<wbr>`  element after each underscore.
///
/// This is useful for long IDs separated with underscores, such as lint names,
/// that might otherwise break across lines in an undesirable way.
List<Component> splitByUnderscore(String sourceString) {
  final parts = sourceString.split('_');
  final result = <Component>[];

  for (var i = 0; i < parts.length; i++) {
    result.add(text(parts[i]));

    // Add a word break opportunity after each underscore,
    // except for the final one.
    if (i < parts.length - 1) {
      result.add(const Component.text('_'));
      result.add(const Component.element(tag: 'wbr'));
    }
  }

  return result;
}

/// Converts the specified [text] into a standardized URL slug
/// that can be used as the ID for headers and other anchors in HTML.
String slugify(String text) => text
    .toLowerCase()
    .trim()
    .replaceAll(_slugifyPunctuationToReplace, '-')
    .replaceAll(_slugifyUnsupportedToRemove, '')
    .replaceAll(_slugifyCharsToCombine, '-')
    .replaceAll(_slugifyHyphenTrim, '');

final RegExp _slugifyPunctuationToReplace = RegExp(r'[:.]');
final RegExp _slugifyUnsupportedToRemove = RegExp(
  r'[^\p{L}\p{N}\s:._-]',
  unicode: true,
);
final RegExp _slugifyCharsToCombine = RegExp(r'[\s-]+');
final RegExp _slugifyHyphenTrim = RegExp(r'^-+|-+$');

final RegExp _attributePattern = RegExp(r'(\w+)="([^"]*)"');
final RegExp _whitespacePattern = RegExp(r'\s+');

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

extension ListToClasses on List<String> {
  /// Convert a list of classes into a single class string
  /// that can be added to an HTML element.
  String get toClasses => join(' ');
}
