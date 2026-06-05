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
    return a(
      classes: 'event-bar',
      href: banner.link,
      target: Target.blank,
      id: 'event-bar',
      [
        span(classes: 'event-bar__content', [
          .text(banner.text),
          const .text('\u00A0'),
          const Icon.linkArrow(large: true),
        ]),
        span(classes: 'event-bar__content mobile', [
          .text(banner.text),
          const .text('\u00A0'),
          const Icon.linkArrow(),
        ]),
      ],
    );
  }
}
