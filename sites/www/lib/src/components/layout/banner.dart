// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/content/banner_content.dart';
import '../common/icon.dart';

class Banner extends StatelessComponent {
  const Banner({super.key, required this.banner});

  final BannerContent banner;

  @override
  Component build(BuildContext context) {
    final mobileText = switch (banner.mobileText) {
      final mobileText? when mobileText != banner.text => mobileText,
      _ => null,
    };

    return a(
      classes: 'event-bar',
      href: banner.link,
      target: Target.blank,
      id: 'event-bar',
      [
        span(
          classes: [
            'event-bar__content',
            if (mobileText != null) 'desktop',
          ].join(' '),
          [
            .text(banner.text),
            const .text('\u00A0'),
            const Icon.linkArrow(large: true),
          ],
        ),
        if (mobileText != null)
          span(classes: 'event-bar__content mobile', [
            .text(mobileText),
            const .text('\u00A0'),
            const Icon.linkArrow(),
          ]),
      ],
    );
  }
}
