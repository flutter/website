// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

/// The Markdown secondary output shared by routing and page layouts.
final canonicalMarkdownOutput = CanonicalMarkdownOutput(
  createHeader: _createHeader,
);

/// Outputs a secondary Markdown file at the canonical page URL with a `.md`
/// suffix.
final class CanonicalMarkdownOutput extends MarkdownOutput {
  CanonicalMarkdownOutput({super.createHeader});

  /// Returns the secondary Markdown route for [page], if one is generated.
  String? routeForPage(Page page) {
    if (pattern.matchAsPrefix(page.path) == null) return null;
    return createRoute(page.url);
  }

  @override
  String createRoute(String route) => route == '/' ? '/index.md' : '$route.md';
}

String _createHeader(Page page) {
  final header = StringBuffer();
  if (page.data.page['title'] case final String title when title.isNotEmpty) {
    header.writeln('# $title');

    if (page.data.page['description'] case final String description
        when description.isNotEmpty) {
      header.writeln();
      header.writeln('> $description');
    }
  }

  return header.toString();
}
