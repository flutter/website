// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'icon.dart';

class FeatureGridItem extends StatelessComponent {
  const FeatureGridItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.url,
  });

  final String title;
  final String description;
  final String icon;
  final String url;

  @override
  Component build(BuildContext context) {
    return div([
      a(href: url, [
        img(src: icon, alt: title),
        h3([
          .text(title),
          const RawText('&nbsp;'),
          const Icon.linkArrow(large: true),
        ]),
        p([.text(description)]),
      ]),
    ]);
  }
}

class FeatureGrid extends StatelessComponent {
  const FeatureGrid({
    required this.eyebrow,
    required this.title,
    required this.items,
    super.key,
  });

  final String eyebrow;
  final String title;
  final List<FeatureGridItem> items;

  @override
  Component build(BuildContext context) {
    return div(classes: 'feature-grid container', [
      div(classes: 'feature-header full', [
        Component.element(
          tag: 'hgroup',
          children: [
            h4(classes: 'eyebrow', [.text(eyebrow)]),
            h2([.text(title)]),
          ],
        ),
      ]),
      div(classes: 'feature-grid-features col-2', [...items]),
    ]);
  }
}
