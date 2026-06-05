// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class FeatureColumn extends StatelessComponent {
  const FeatureColumn({
    required this.title,
    required this.description,
    required this.image,
    this.imageAlt,
    super.key,
  });

  final String title;
  final String description;
  final String image;
  final String? imageAlt;

  @override
  Component build(BuildContext context) {
    return div([
      h3([.text(title)]),
      p([.text(description)]),
      img(src: image, alt: imageAlt ?? title),
    ]);
  }
}

class FeatureColumnsSection extends StatelessComponent {
  const FeatureColumnsSection(this.columns, {super.key});

  final List<FeatureColumn> columns;

  @override
  Component build(BuildContext context) {
    return section(id: 'feature-columns', classes: 'module', [
      div(classes: 'feature-columns container', [...columns]),
    ]);
  }
}
