// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../util.dart';
import '../button.dart';
import '../dropdown.dart';

@client
final class SiteSwitcher extends StatelessComponent {
  const SiteSwitcher();

  @override
  Component build(BuildContext _) => Dropdown(
    id: 'site-switcher',
    children: [
      const DropdownToggle(Button(icon: 'apps', title: 'Visit related sites.')),
      DropdownContent(
        nav(
          classes: 'dropdown-menu',
          attributes: {
            'role': 'menu',
          },
          [
            ul(
              [
                const _SiteWordMarkListEntry(
                  name: 'Flutter',
                  href: 'https://flutter.dev',
                ),
                const _SiteWordMarkListEntry(
                  name: 'Flutter',
                  subtype: 'Docs',
                  href: '/',
                  current: true,
                ),
                const _SiteWordMarkListEntry(
                  name: 'Flutter',
                  subtype: 'API',
                  href: 'https://api.flutter.dev',
                ),
                li(
                  classes: 'dropdown-divider',
                  attributes: {'aria-hidden': 'true', 'role': 'separator'},
                  [],
                ),
                const _SiteWordMarkListEntry(
                  name: 'Dart',
                  href: 'https://dart.dev',
                  dart: true,
                ),
                const _SiteWordMarkListEntry(
                  name: 'DartPad',
                  href: 'https://dartpad.dev',
                  dart: true,
                ),
                const _SiteWordMarkListEntry(
                  name: 'pub.dev',
                  href: 'https://pub.dev',
                  dart: true,
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class _SiteWordMarkListEntry extends StatelessComponent {
  const _SiteWordMarkListEntry({
    required this.href,
    required this.name,
    this.subtype,
    this.current = false,
    this.dart = false,
  });

  final bool dart;
  final String href;
  final String name;
  final String? subtype;
  final bool current;

  String get _combinedName => '$name${subtype != null ? ' $subtype' : ''}';

  @override
  Component build(BuildContext _) {
    return li(
      attributes: {'role': 'presentation'},
      [
        a(
          href: href,
          classes: ['site-wordmark', if (current) 'current-site'].toClasses,
          attributes: {
            'role': 'menuitem',
            'title': 'Navigate to the $_combinedName website.',
            'aria-label': 'Navigate to the $_combinedName website.',
          },
          [
            if (dart)
              img(
                src: '/assets/images/branding/dart/logo.svg',
                alt: 'Dart logo',
                width: 28,
                height: 28,
              )
            else
              img(
                src: '/assets/images/branding/flutter/logo/default.svg',
                alt: 'Flutter logo',
                width: 28,
              ),
            span(
              classes: 'name',
              attributes: {
                'translate': 'no',
              },
              [text(name)],
            ),
            if (subtype case final subtype?)
              span(
                classes: 'subtype',
                [text(subtype)],
              ),
          ],
        ),
      ],
    );
  }
}
