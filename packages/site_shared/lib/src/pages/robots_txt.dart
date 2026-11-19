// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:meta/meta.dart';

import '../../util.dart';

/// Generates `/robots.txt` at the root of a Jaspr site.
///
/// Production builds allow crawling and advertise `<site.url>/sitemap.xml`;
/// non-production staging builds disallow all crawlers except `linkcheck`.
final class RobotsTxtOutput implements SecondaryOutput {
  static final RegExp _indexPattern = RegExp(r'^/?index\.(md|html)$');

  const RobotsTxtOutput({@visibleForTesting this.isProductionBuild});

  /// Overrides [productionBuild] in tests.
  final bool? isProductionBuild;

  @override
  Pattern get pattern => _indexPattern;

  @override
  String createRoute(String _) => '/robots.txt';

  @override
  Component build(Page page) => Builder(
    builder: (context) {
      context.setHeader('Content-Type', 'text/plain; charset=utf-8');
      context.setHeader('jaspr-sitemap-data', 'false');
      context.setStatusCode(200, responseBody: renderRobotsTxt(page));
      return const Component.empty();
    },
  );

  /// Renders the `robots.txt` body for [page]'s configured site.
  @visibleForTesting
  String renderRobotsTxt(Page page) {
    if (!(isProductionBuild ?? productionBuild)) {
      return '''
User-agent: linkcheck
Disallow:

User-agent: *
Disallow: /
''';
    }

    final siteUrl = page.data.site['url'];
    if (siteUrl is! String || siteUrl.trim().isEmpty) {
      throw StateError('Site URL not configured in site data.');
    }
    final sitemapUrl = Uri.parse(
      siteUrl.trim(),
    ).resolve('/sitemap.xml').toString();

    return '''
User-agent: *
Disallow:

Sitemap: $sitemapUrl
''';
  }
}
