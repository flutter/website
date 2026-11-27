// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import '../models/header_metadata.dart';

/// Decodes common HTML entities into plain text.
String _unescapeHtml(String input) {
  return input
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&apos;', "'")
      .replaceAll('&nbsp;', ' ');
}

/// Extracts [HeaderMetadata] from raw HTML content.
HeaderMetadata extractHeaderMetadataFromHtml(String html) {
  // 1. Extract <title>...</title>
  final titleRegex = RegExp(
    r'<title[^>]*>(.*?)</title>',
    caseSensitive: false,
    dotAll: true,
  );
  final titleMatch = titleRegex.firstMatch(html);
  final rawTitle = titleMatch?.group(1)?.trim() ?? '';
  final title = _unescapeHtml(rawTitle);

  // 2. Extract <link rel="canonical" href="...">
  String? canonical;
  final linkTagRegex = RegExp(
    r'<link\b([^>]+)>',
    caseSensitive: false,
    dotAll: true,
  );
  final relCanonicalRegex = RegExp(
    r'''\brel=\s*(?:"canonical"|'canonical')''',
    caseSensitive: false,
    dotAll: true,
  );
  final hrefRegex = RegExp(
    r'''\bhref=\s*(?:"([^"]*)"|'([^']*)')''',
    caseSensitive: false,
    dotAll: true,
  );

  for (final match in linkTagRegex.allMatches(html)) {
    final attributes = match.group(1) ?? '';
    if (relCanonicalRegex.hasMatch(attributes)) {
      final hrefMatch = hrefRegex.firstMatch(attributes);
      if (hrefMatch != null) {
        final href = hrefMatch.group(1) ?? hrefMatch.group(2) ?? '';
        canonical = href.trim();
        break;
      }
    }
  }

  // 3. Extract all <meta> tags
  final meta = <String, String>{};
  final metaTagRegex = RegExp(
    r'<meta\b([^>]+)>',
    caseSensitive: false,
    dotAll: true,
  );
  final nameAttrRegex = RegExp(
    r'''\b(name|property|http-equiv)=\s*(?:"([^"]*)"|'([^']*)')''',
    caseSensitive: false,
    dotAll: true,
  );
  final contentAttrRegex = RegExp(
    r'''\bcontent=\s*(?:"([^"]*)"|'([^']*)')''',
    caseSensitive: false,
    dotAll: true,
  );

  for (final match in metaTagRegex.allMatches(html)) {
    final attributes = match.group(1) ?? '';
    final nameMatch = nameAttrRegex.firstMatch(attributes);
    final contentMatch = contentAttrRegex.firstMatch(attributes);

    if (nameMatch != null && contentMatch != null) {
      final name = (nameMatch.group(2) ?? nameMatch.group(3) ?? '').trim();
      final rawContent = contentMatch.group(1) ?? contentMatch.group(2) ?? '';
      final content = _unescapeHtml(rawContent.trim());
      meta[name] = content;
    }
  }

  return HeaderMetadata(
    title: title,
    canonical: canonical,
    meta: meta,
  );
}

/// Reads [file] and extracts [HeaderMetadata].
Future<HeaderMetadata> extractHeaderMetadataFromFile(File file) async {
  if (!file.existsSync()) {
    return const HeaderMetadata();
  }
  final content = await file.readAsString();
  return extractHeaderMetadataFromHtml(content);
}

/// JavaScript snippet for extracting header metadata directly from the live
/// browser DOM via Puppeteer.
const String puppeteerHeaderExtractionScript = r'''() => {
  const meta = {};
  for (const el of document.querySelectorAll('meta')) {
    const key = el.getAttribute('name') || el.getAttribute('property') || el.getAttribute('http-equiv');
    const content = el.getAttribute('content');
    if (key && content !== null) {
      meta[key] = content;
    }
  }
  const canonicalEl = document.querySelector('link[rel="canonical"]');
  const canonical = canonicalEl ? canonicalEl.getAttribute('href') : null;
  return {
    'title': document.title || '',
    'canonical': canonical,
    'meta': meta,
  };
}''';
