// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../common/button.dart';
import '../common/material_icon.dart';
import 'menu_toggle.dart';
import 'site_switcher.dart';
import 'theme_switcher.dart';

/// The site-wide top navigation bar.
class DashHeader extends StatelessComponent {
  const DashHeader({super.key});

  @override
  Component build(BuildContext context) =>
      header(id: 'site-header', classes: 'always-dark-mode', [
        nav(classes: 'navbar', [
          a(
            id: 'site-primary-logo',
            classes: 'site-wordmark',
            href: '/',
            attributes: {
              'aria-label': 'Go to the Flutter docs homepage.',
              'title': 'Go to the Flutter docs homepage.',
            },
            [
              img(
                src: '/assets/images/branding/flutter/logo/default.svg',
                alt: 'Flutter logo',
                attributes: {'width': '28'},
              ),
              span(
                classes: 'name',
                attributes: {'translate': 'no'},
                [text('Flutter')],
              ),
              span(
                classes: 'subtype',
                [text('Docs')],
              ),
            ],
          ),

          div(
            classes: 'navbar-contents',
            [
              form(
                action: '/search/',
                id: 'header-search',
                [
                  input(
                    classes: 'search-field',
                    type: InputType.search,
                    name: 'q',
                    id: 'q',
                    attributes: {
                      'autocomplete': 'off',
                      'placeholder': 'Search',
                      'aria-label': 'Search',
                    },
                  ),
                ],
              ),
              a(
                id: 'fallback-search-button',
                classes: 'icon-button',
                href: '/search',
                attributes: {
                  'aria-label': 'Navigate to the docs.flutter.dev search page.',
                  'title': 'Navigate to the docs.flutter.dev search page.',
                },
                const [
                  MaterialIcon('search'),
                ],
              ),
              const ThemeSwitcher(),
              const SiteSwitcher(),
              const Button(
                id: 'call-to-action',
                style: ButtonStyle.filled,
                content: 'Get started',
                href: '/get-started/quick',
              ),
              const MenuToggle(),
            ],
          ),
        ]),
      ]);
}
