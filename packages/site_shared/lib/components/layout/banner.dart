// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// The information to display in the site banner,
/// as configured in the `src/data/banner.yml` file.
@immutable
final class BannerContent {
  final String text;
  final String linkText;
  final String linkUri;
  final bool newTab;

  const BannerContent({
    required this.text,
    required this.linkText,
    required this.linkUri,
    this.newTab = false,
  });

  factory BannerContent.fromMap(Map<String, Object?> bannerData) {
    final text = bannerData['text'] as String;
    final link = bannerData['link'] as Map<Object?, Object?>;
    final linkText = link['text'] as String;
    final linkUri = link['url'] as String;
    final newTab = link['newTab'] as bool? ?? false;

    return BannerContent(
      text: text,
      linkText: linkText,
      linkUri: linkUri,
      newTab: newTab,
    );
  }
}

/// The site-wide banner.
class DashBanner extends StatelessComponent {
  const DashBanner(this.content, {super.key}) : inlineHtmlContent = null;

  /// Creates a banner from raw, inline HTML content.
  ///
  /// This should only be sourced from managed content,
  /// such as checked-in data files.
  const DashBanner.inlineHtml(this.inlineHtmlContent, {super.key})
    : content = null;

  final BannerContent? content;
  final String? inlineHtmlContent;

  @override
  Component build(BuildContext context) {
    final inlineHtmlContent = this.inlineHtmlContent;
    final content = this.content;

    return div(
      id: 'site-banner',
      attributes: {'role': 'alert'},
      [
        p([
          if (inlineHtmlContent != null)
            RawText(inlineHtmlContent)
          else if (content != null) ...[
            .text(content.text),
            const .text(' '),
            a(
              href: content.linkUri,
              target: content.newTab ? Target.blank : null,
              [.text(content.linkText)],
            ),
          ],
        ]),
      ],
    );
  }
}
