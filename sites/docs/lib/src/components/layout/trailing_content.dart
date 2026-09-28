// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/client/feedback.dart';

import '../../utils/page_source_info.dart';

/// The trailing content of a content documentation page, such as
/// its last updated information, report an issue links, and similar.
class TrailingContent extends StatelessComponent {
  const TrailingContent({super.key});

  @override
  Component build(BuildContext context) {
    final page = context.page;
    final pageData = page.data.page;
    final siteData = page.data.site;
    final pageDate = pageData['date'] as String?;

    final documentedFlutterVersion = _parseDocumentedFlutterVersion(
      siteData['documentedFlutterVersion'],
    );

    final sourceInfo = page.sourceInfo;
    final issueUrl = sourceInfo.issueUrl;
    final pageSource = sourceInfo.sourceUrl;

    return div(
      id: 'trailing-content',
      attributes: {'data-nosnippet': 'true'},
      [
        FeedbackComponent(issueUrl: issueUrl),

        p(id: 'page-github-links', [
          span([
            .text(
              'Unless stated otherwise, the documentation on '
              'this site reflects Flutter $documentedFlutterVersion. ',
            ),
            if (pageDate != null)
              .text(
                'Page last updated on $pageDate. ',
              ),
          ]),
          if (pageSource != null) ...[
            a(
              href: pageSource,
              attributes: const {'target': '_blank', 'rel': 'noopener'},
              const [.text('View source')],
            ),
            const span([.text(' or ')]),
          ],
          a(
            href: issueUrl,
            attributes: {
              'title': 'Report an issue with this page',
              'target': '_blank',
              'rel': 'noopener',
            },
            [.text(pageSource == null ? 'Report an issue' : 'report an issue')],
          ),
          const .text('.'),
        ]),
      ],
    );
  }

  /// Returns the [rawVersionValue] as a version string in `major.minor` format.
  ///
  /// Throws a [FormatException] if [rawVersionValue]
  /// isn't in the expected version format.
  static String _parseDocumentedFlutterVersion(Object? rawVersionValue) {
    if (rawVersionValue is! String ||
        !_documentedFlutterVersionPattern.hasMatch(rawVersionValue)) {
      throw FormatException(
        'documentedFlutterVersion in sites/docs/src/data/site.yml must be a '
        'quoted string in "major.minor" format, such as "3.47". '
        'Received: $rawVersionValue (${rawVersionValue.runtimeType}).',
      );
    }
    return rawVersionValue;
  }

  static final RegExp _documentedFlutterVersionPattern = RegExp(
    r'^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$',
  );
}
