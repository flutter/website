// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../util.dart';

/// The secondary output to configure to create
/// a `robots.txt` file in the root directory.
final class RobotsTxtOutput implements SecondaryOutput {
  static final _indexPattern = RegExp(r'/?index\..*');

  const RobotsTxtOutput();

  @override
  Pattern get pattern => _indexPattern;

  @override
  String createRoute(String _) => '/robots.txt';

  @override
  Component build(Page _) {
    return Builder(
      builder: (context) {
        context.setHeader('Content-Type', 'text/plain; charset=utf-8');
        final String textContent;
        if (productionBuild) {
          // If this is a production build, allow all bots to crawl the site.
          textContent = '''
User-agent: *
Disallow:

Sitemap: https://docs.flutter.dev/sitemap.xml
''';
        } else {
          // If this isn't a production build, such as for staging on Firebase,
          // don't allow bots to crawl or index the site.
          // This helps prevent staged sites from showing up on search engines.
          textContent = '''
User-agent: linkcheck
Disallow:

User-agent: *
Disallow: /
''';
        }
        context.setStatusCode(200, responseBody: textContent);
        return const Component.empty();
      },
    );
  }
}
