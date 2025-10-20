// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:path/path.dart' as path;
import 'package:universal_web/web.dart' as web;

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

final RegExp _slugifyPunctuationToReplace = RegExp(r'[:._]');
final RegExp _slugifyUnsupportedToRemove = RegExp(
  r'[^\p{L}\p{N}\s:.-]',
  unicode: true,
);
final RegExp _slugifyCharsToCombine = RegExp(r'[\s-]+');
final RegExp _slugifyHyphenTrim = RegExp(r'^-+|-+$');

final RegExp _attributePattern = RegExp(r'(\w+)="([^"]*)"');
final RegExp _whitespacePattern = RegExp(r'\s+');
final RegExp _wordPattern = RegExp(r'\S+(?:\s*|$)');
final RegExp _trailingMarkdownLinkPattern = RegExp(r'(\[.+\]:\s*\S+\s*)+$');

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

/// Truncates the given [text] to the specified number of words [maxWords],
/// preserving all whitespace and line breaks, as well as any trailing Markdown
/// link definitions at the end of the text.
String truncateWordsMarkdown(String text, int maxWords) {
  if (maxWords <= 0) {
    return '';
  }

  final trailingLinks = _trailingMarkdownLinkPattern.firstMatch(text);
  var endContent = '';

  if (trailingLinks != null) {
    text = text.substring(0, trailingLinks.start);
    endContent = '\n${trailingLinks.group(0)!}';
  }

  final matches = _wordPattern.allMatches(text);
  if (matches.length <= maxWords) {
    return text + endContent;
  }

  final truncated = matches.map((m) => m.group(0)!).take(maxWords).join('');
  return '$truncated...\n$endContent';
}

extension ListToClasses on List<String> {
  /// Convert a list of classes into a single class string
  /// that can be added to an HTML element.
  String get toClasses => join(' ');
}

enum OperatingSystem {
  windows('Windows'),
  macos('macOS'),
  linux('Linux'),
  chromeos('ChromeOS');

  const OperatingSystem(this.label);
  final String label;
}

/// Get the user's current operating system, or
/// `null` if not of one "macos", "windows", "linux", or "chromeos".
OperatingSystem? getOS() {
  final userAgent = web.window.navigator.userAgent;
  if (userAgent.contains('Mac')) {
    // macOS or iPhone
    return OperatingSystem.macos;
  }

  if (userAgent.contains('Win')) {
    // Windows
    return OperatingSystem.windows;
  }

  if ((userAgent.contains('Linux') || userAgent.contains('X11')) &&
      !userAgent.contains('Android')) {
    // Linux, but not Android
    return OperatingSystem.linux;
  }

  if (userAgent.contains('CrOS')) {
    // ChromeOS
    return OperatingSystem.chromeos;
  }

  // Anything else
  return null;
}
