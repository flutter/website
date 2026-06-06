// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class HeroSection extends StatelessComponent {
  const HeroSection({
    required this.title,
    this.subtitle,
    this.text,
    required this.media,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? text;
  final Component media;

  @override
  Component build(BuildContext context) {
    return section(classes: 'hero', [
      div(classes: 'container', [
        div(classes: 'mantle', [
          div(classes: 'text', [
            h1([.text(title)]),
            if (subtitle case final subtitle?) h2([.text(subtitle)]),
          ]),
          div(classes: 'media', [media]),
        ]),
        if (text case final subtitle?) h2([.text(subtitle)]),
      ]),
    ]);
  }
}
