// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../utils/asset_utils.dart';
import '../common/icon.dart';

class CTASection extends StatelessComponent {
  const CTASection();

  @override
  Component build(BuildContext context) {
    return section(id: 'cta', classes: 'module', [
      div(classes: 'insert cta-insert container', [
        const div(classes: 'text', [
          h3([.text('Get started')]),
          p([.text('Instant access to the power of the Flutter framework')]),
          div([
            a(href: 'https://docs.flutter.dev/get-started', classes: 'btn', [
              .text('Install'),
            ]),
            a(href: 'https://docs.flutter.dev', classes: 'btn quiet', [
              .text('Read the docs '),
              RawText('&nbsp;'),
              Icon.linkArrow(),
            ]),
          ]),
        ]),
        div(classes: 'media', [
          img(
            src: context.asset('/images/common/get-started-background.png'),
            alt: 'Powered by Dart',
          ),
        ]),
      ]),
    ]);
  }
}
