// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import '../../components/common/breadcrumbs.dart';
import '../markdown/markdown_parser.dart';

/// Builds a Schema.org data graph for a site page.
Map<String, Object?> buildPageStructuredData({
  required String siteUrl,
  required String siteName,
  required String siteDescription,
  required String pageUrl,
  required String title,
  String? pageDescription,
  DateTime? dateModified,
  List<BreadcrumbItem>? breadcrumbs,
}) {
  final siteUri = Uri.parse(siteUrl.endsWith('/') ? siteUrl : '$siteUrl/');
  final siteId = siteUri.replace(fragment: 'website').toString();
  final absolutePageUrl = siteUri.resolve(pageUrl);
  final pageId = absolutePageUrl.replace(fragment: 'webpage').toString();
  final normalizedTitle = parseInlineMarkdownToText(title).trim();
  final normalizedDescription = pageDescription?.trim();
  final validBreadcrumbs = breadcrumbs != null && breadcrumbs.length >= 2
      ? breadcrumbs
      : null;
  final breadcrumbId = absolutePageUrl
      .replace(fragment: 'breadcrumb')
      .toString();

  return {
    '@context': 'https://schema.org',
    '@graph': [
      {
        '@type': 'WebSite',
        '@id': siteId,
        'url': siteUri.toString(),
        'name': siteName.trim(),
        'description': siteDescription.trim(),
        'inLanguage': 'en',
      },
      {
        '@type': 'WebPage',
        '@id': pageId,
        'url': absolutePageUrl.toString(),
        'name': normalizedTitle,
        if (normalizedDescription != null && normalizedDescription.isNotEmpty)
          'description': normalizedDescription,
        'inLanguage': 'en',
        if (dateModified != null)
          'dateModified': dateModified.toIso8601String(),
        'isPartOf': {'@id': siteId},
        if (validBreadcrumbs != null) 'breadcrumb': {'@id': breadcrumbId},
      },
      if (validBreadcrumbs != null)
        {
          '@type': 'BreadcrumbList',
          '@id': breadcrumbId,
          'itemListElement': [
            for (final (index, breadcrumb) in validBreadcrumbs.indexed)
              {
                '@type': 'ListItem',
                'position': index + 1,
                'name': parseInlineMarkdownToText(breadcrumb.title).trim(),
                'item': siteUri.resolve(breadcrumb.url).toString(),
              },
          ],
        },
    ],
  };
}

/// Encodes a JSON-LD graph so it can be safely embedded in a script element.
String encodeJsonLdForHtml(Map<String, Object?> data) =>
    jsonEncode(data).replaceAll('<', r'\u003c');
