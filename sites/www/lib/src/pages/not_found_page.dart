// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../utils/asset_utils.dart';

class NotFoundPage extends StatelessComponent {
  const NotFoundPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      const section(classes: 'hero', []),
      section(
        classes: 'content-container',
        attributes: const {
          'x-data': 'initSpy(headerOffset, toggleContentActive)',
        },
        [
          section(id: 'content', classes: 'module', [
            div(classes: 'container', [
              const h1([.text('Sorry, we couldn\'t find that page…')]),
              img(
                src: context.asset('/images/notfound/404-dash.png'),
                alt: 'Not Found',
              ),
              const h2([
                .text(
                  'But Dash is here to help! '
                  'Maybe one of these will point you in the right direction?',
                ),
              ]),
              const div(classes: 'links', [
                ul([
                  li([
                    a(href: '/', [.text('Homepage')]),
                  ]),
                  li([
                    a(href: 'https://pub.dev/', target: Target.blank, [
                      .text('Package site'),
                    ]),
                  ]),
                  li([
                    a(href: 'https://api.flutter.dev/', target: Target.blank, [
                      .text('API reference'),
                    ]),
                  ]),
                ]),
                ul([
                  li([
                    a(href: 'https://docs.flutter.dev/', [
                      .text('Documentation'),
                    ]),
                  ]),
                  li([
                    a(
                      href:
                          'https://docs.flutter.dev/reference/learning-resources',
                      target: Target.blank,
                      [.text('Learning resources')],
                    ),
                  ]),
                  li([
                    a(href: '/community', [.text('Community')]),
                  ]),
                ]),
                ul([
                  li([
                    a(href: 'https://blog.flutter.dev', target: Target.blank, [
                      .text('Blog'),
                    ]),
                  ]),
                  li([
                    a(
                      href: 'https://twitter.com/flutterdev',
                      target: Target.blank,
                      [.text('Twitter')],
                    ),
                  ]),
                  li([
                    a(href: 'https://docs.flutter.dev/resources/faq', [
                      .text('FAQ'),
                    ]),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ],
      ),
    ]);
  }
}
