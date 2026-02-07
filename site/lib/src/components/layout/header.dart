// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../util.dart';
import '../../utils/active_nav.dart';
import '../common/button.dart';
import '../common/material_icon.dart';
import 'menu_toggle.dart';
import 'site_switcher.dart';
import 'theme_switcher.dart';

/// The site-wide top navigation bar.
class DashHeader extends StatelessComponent {
  const DashHeader({super.key});

  @override
  Component build(BuildContext context) {
    final pageUrlPath = context.page.url;
    final activeEntry = activeNavEntry(pageUrlPath);

    return header(id: 'site-header', [
      nav(classes: 'navbar', [
        const a(
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
              [.text('Flutter')],
            ),
            span(
              classes: 'subtype',
              [.text('Docs')],
            ),
          ],
        ),

        ul(classes: 'nav-items', [
          _NavItem(
            href: '/',
            label: 'User Guides',
            isActive: activeEntry == ActiveNavEntry.home,
          ),
          _NavItem(
            href: '/learn',
            label: 'Learn',
            isActive: activeEntry == ActiveNavEntry.learn,
          ),
          const _NavItem(
            href: 'https://api.flutter.dev',
            label: 'Reference',
            openInNewTab: true,
          ),
        ]),

        div(
          classes: 'navbar-contents',
          [
            const form(
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
            const a(
              id: 'fallback-search-button',
              classes: 'icon-button',
              href: '/search',
              attributes: {
                'aria-label': 'Navigate to the docs.flutter.dev search page.',
                'title': 'Navigate to the docs.flutter.dev search page.',
              },
              [
                MaterialIcon('search'),
              ],
            ),
            const ThemeSwitcher(),
            const SiteSwitcher(),

            if (activeEntry != ActiveNavEntry.learn)
              const Button(
                id: 'call-to-action',
                style: ButtonStyle.filled,
                content: 'Get started',
                href: '/get-started/quick',
              ),
            if (context.page.data['sidenav'] != null) const MenuToggle(),
          ],
        ),
      ]),
    ]);
  }
}

class _NavItem extends StatelessComponent {
  const _NavItem({
    required this.href,
    required this.label,
    this.isActive = false,
    this.openInNewTab = false,
  });

  final String href;
  final String label;
  final bool isActive;
  final bool openInNewTab;

  @override
  Component build(BuildContext _) => li([
    a(
      href: href,
      classes: ['nav-link', 'text-button', if (isActive) 'active'].toClasses,
      attributes: openInNewTab ? {'target': '_blank', 'rel': 'noopener'} : null,
      [.text(label)],
    ),
  ]);
}
