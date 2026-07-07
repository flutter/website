// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class QuoteSection extends StatelessComponent {
  const QuoteSection({
    required this.background,
    required this.logo,
    required this.logoAlt,
    required this.quote,
    required this.author,
    required this.company,
    super.key,
  });

  final String background;
  final String logo;
  final String logoAlt;
  final String quote;
  final String author;
  final String company;

  @override
  Component build(BuildContext context) {
    return section(id: 'quote', classes: 'module', [
      div(classes: 'container testimonial', [
        img(src: background, attributes: const {'role': 'presentation'}),
        div(classes: 'testimonial-wrapper', [
          div(classes: 'testimonial-logo', [img(src: logo, alt: logoAlt)]),
          div(classes: 'testimonial-quote', [
            blockquote([
              p([.text(quote)]),
            ]),
            const div(classes: 'sep', []),
            span(attributes: const {'rel': 'author'}, [.text(author)]),
            const br(),
            span(attributes: const {'rel': 'company'}, [.text(company)]),
          ]),
        ]),
      ]),
    ]);
  }
}
