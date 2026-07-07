// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// The information to display in the site banner,
/// as configured in `src/data/banner.yml`.
@immutable
final class BannerContent {
  /// The ordered content parts to render in the banner.
  final List<BannerPart> parts;

  /// Creates banner content from the specified [parts].
  const BannerContent({required this.parts});

  /// Creates banner content from the parsed [bannerData].
  ///
  /// The [bannerData] list is expected to contain
  /// `text`, `link`, or `newLine` entries from `src/data/banner.yml`.
  ///
  /// Throws if any entry has an unsupported structure.
  factory BannerContent.fromList(List<Object?> bannerData) => BannerContent(
    parts: [
      for (final item in bannerData)
        switch (item) {
          {'text': final String text} => .text(text),
          {'link': final Map<Object?, Object?> link} => .link(
            text: link['text'] as String,
            url: link['url'] as String,
            newTab: link['newTab'] as bool? ?? false,
          ),
          {'newLine': _} => const .newLine(),
          _ => throw FormatException('Invalid banner item: $item'),
        },
    ],
  );
}

/// A single renderable piece of banner content.
@immutable
sealed class BannerPart {
  /// Creates a banner content part.
  const BannerPart();

  /// Creates a text part with the specified [text].
  const factory BannerPart.text(String text) = _BannerText;

  /// Creates a link part with the specified [text] and [url].
  ///
  /// Unless [newTab] is `true`, the link opens in the same tab.
  const factory BannerPart.link({
    required String text,
    required String url,
    bool newTab,
  }) = _BannerLink;

  /// Creates a new line part that renders a line break.
  const factory BannerPart.newLine() = _BannerNewLine;
}

/// Plain text within a site banner.
final class _BannerText extends BannerPart {
  /// Creates a text banner part with the specified [text].
  const _BannerText(this.text);

  /// The text to render in the banner.
  final String text;
}

/// A link within a site banner.
final class _BannerLink extends BannerPart {
  /// Creates a link banner part with the specified [text] and [url].
  ///
  /// Unless [newTab] is `true`, the link opens in the same tab.
  const _BannerLink({
    required this.text,
    required this.url,
    this.newTab = false,
  });

  /// The link label to render in the banner.
  final String text;

  /// The destination URL for this link.
  final String url;

  /// Whether this link opens in a new browser tab.
  final bool newTab;
}

/// A line break within a site banner.
final class _BannerNewLine extends BannerPart {
  /// Creates a line break banner part.
  const _BannerNewLine();
}

/// A site-wide banner rendered from structured content.
class DashBanner extends StatelessComponent {
  /// Creates a site banner that displays the specified [content].
  const DashBanner(this.content, {super.key});

  /// The structured content to render in this banner.
  final BannerContent content;

  @override
  Component build(BuildContext context) => div(
    id: 'site-banner',
    attributes: {'role': 'alert'},
    [
      p([
        for (final part in content.parts)
          switch (part) {
            _BannerText(:final text) => .text(text),
            _BannerLink(:final text, :final url, :final newTab) => a(
              href: url,
              target: newTab ? Target.blank : null,
              attributes: newTab ? const {'rel': 'noopener'} : null,
              [.text(text)],
            ),
            _BannerNewLine() => const br(),
          },
      ]),
    ],
  );
}
