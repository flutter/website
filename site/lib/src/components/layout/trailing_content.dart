// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../common/client/feedback.dart';

/// The trailing content of a content documentation page, such as
/// its last updated information, report an issue links, and similar.
class TrailingContent extends StatelessComponent {
  const TrailingContent({super.key, this.repo});

  final String? repo;

  @override
  Component build(BuildContext context) {
    final page = context.page;
    final pageUrl = page.url;
    final pageData = page.data.page;
    final siteData = page.data.site;
    final branch = siteData['branch'] as String? ?? 'main';
    final repoLinks = siteData['repo'] as Map<String, Object?>? ?? {};
    final repoUrl =
        repo ??
        repoLinks['this'] as String? ??
        'https://github.com/dart-lang/site-www';
    final inputPath = pageData['inputPath'] as String?;
    final pageDate = pageData['date'] as String?;

    final currentFlutterVersion =
        siteData['currentFlutterVersion'] as String? ?? '';
    final siteUrl = siteData['url'] as String? ?? 'https://docs.flutter.dev';

    final fullPageUrl = '$siteUrl$pageUrl';
    final String issueUrl;
    final String? pageSource;

    if (inputPath != null) {
      pageSource = '$repoUrl/blob/$branch/${inputPath.replaceAll('./', '')}';
      issueUrl =
          '$repoUrl/issues/new?template=1_page_issue.yml&page-url=$fullPageUrl&page-source=$pageSource';
    } else {
      pageSource = null;
      issueUrl =
          '$repoUrl/issues/new?template=1_page_issue.yml&page-url=$fullPageUrl';
    }

    return div(
      id: 'trailing-content',
      attributes: {'data-nosnippet': 'true'},
      [
        FeedbackComponent(issueUrl: issueUrl),

        p(id: 'page-github-links', [
          span([
            text(
              'Unless stated otherwise, the documentation on '
              'this site reflects Flutter $currentFlutterVersion. ',
            ),
            if (pageDate != null)
              text(
                'Page last updated on $pageDate. ',
              ),
          ]),
          if (pageSource != null) ...[
            a(
              href: pageSource,
              attributes: {'target': '_blank', 'rel': 'noopener'},
              [text('View source')],
            ),
            span([text(' or ')]),
          ],
          a(
            href: issueUrl,
            attributes: {
              'title': 'Report an issue with this page',
              'target': '_blank',
              'rel': 'noopener',
            },
            [text(pageSource == null ? 'Report an issue' : 'report an issue')],
          ),
          text('.'),
        ]),
      ],
    );
  }
}
