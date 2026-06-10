// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// The information to display in the site banner,
/// as configured in `src/data/banner.yml`.
@immutable
final class BannerContent {
  final List<BannerPart> parts;

  const BannerContent({required this.parts});

  factory BannerContent.fromList(List<Object?> bannerData) => BannerContent(
    parts: [
      for (final item in bannerData)
        switch (item) {
          {'text': final String text} => BannerText(text),
          {'link': final Map<Object?, Object?> link} => BannerLink(
            text: link['text'] as String,
            url: link['url'] as String,
            newTab: link['newTab'] as bool? ?? false,
          ),
          _ => throw FormatException('Invalid banner item: $item'),
        },
    ],
  );
}

@immutable
sealed class BannerPart {
  const BannerPart();
}

final class BannerText extends BannerPart {
  const BannerText(this.text);

  final String text;
}

final class BannerLink extends BannerPart {
  const BannerLink({
    required this.text,
    required this.url,
    this.newTab = false,
  });

  final String text;
  final String url;
  final bool newTab;
}

/// The site-wide banner.
class DashBanner extends StatelessComponent {
  const DashBanner(this.content, {super.key});

  final BannerContent content;

  @override
  Component build(BuildContext context) => div(
    id: 'site-banner',
    attributes: {'role': 'alert'},
    [
      p([
        for (final part in content.parts)
          switch (part) {
            BannerText(:final text) => .text(text),
            BannerLink(:final text, :final url, :final newTab) => a(
              href: url,
              target: newTab ? Target.blank : null,
              attributes: newTab ? const {'rel': 'noopener'} : null,
              [.text(text)],
            ),
          },
      ]),
    ],
  );
}
