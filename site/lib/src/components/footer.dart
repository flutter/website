// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

/// The site-wide footer.
final class DashFooter extends StatelessComponent {
  const DashFooter({super.key});

  @override
  Component build(BuildContext context) {
    return footer(
      id: 'site-footer',
      attributes: {'data-nosnippet': 'true'},
      [
        div(classes: 'footer-section footer-main', [
          a(
            href: '/',
            classes: 'brand',
            attributes: {'title': 'Flutter'},
            [
              img(
                src:
                    '/assets/images/branding/flutter/logo+text/horizontal/white.svg',
                alt: 'Flutter logo',
                width: 164,
              ),
            ],
          ),
          div(classes: 'footer-social-links', [
            a(
              href: 'https://blog.flutter.dev',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Flutter\'s blog',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/images/social/medium.svg#medium',
                    },
                  ),
                ]),
              ],
            ),
            a(
              href: 'https://youtube.com/@flutterdev',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Flutter\'s YouTube channel',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/images/social/youtube.svg#youtube',
                    },
                  ),
                ]),
              ],
            ),
            a(
              href: 'https://github.com/flutter',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Flutter\'s GitHub organization',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/images/social/github.svg#github',
                    },
                  ),
                ]),
              ],
            ),
            a(
              href: 'https://bsky.app/profile/flutter.dev',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Flutter\'s Bluesky profile',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/images/social/bluesky.svg#bluesky',
                    },
                  ),
                ]),
              ],
            ),
            a(
              href: 'https://twitter.com/FlutterDev',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Flutter\'s X (Twitter) profile',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {'href': '/assets/images/social/x.svg#x'},
                  ),
                ]),
              ],
            ),
          ]),
        ]),
        div(classes: 'footer-section footer-tray', [
          div(classes: 'footer-licenses', [
            text('Except as otherwise noted, this site is licensed under a '),
            a(href: 'https://creativecommons.org/licenses/by/4.0/', [
              text('Creative Commons Attribution 4.0 International License,'),
            ]),
            text(' and code samples are licensed under the '),
            a(href: 'https://opensource.org/licenses/BSD-3-Clause', [
              text('3-Clause BSD License.'),
            ]),
          ]),
          div(classes: 'footer-utility-links', [
            ul([
              li([
                a(
                  href: '/tos',
                  attributes: {'title': 'Terms of use'},
                  [text('Terms')],
                ),
              ]),
              li([
                a(
                  href: '/brand',
                  attributes: {'title': 'Brand usage guidelines'},
                  [text('Brand')],
                ),
              ]),
              li([
                a(
                  href: 'https://policies.google.com/privacy',
                  target: Target.blank,
                  attributes: {'rel': 'noopener', 'title': 'Privacy policy'},
                  [text('Privacy')],
                ),
              ]),
              li([
                a(
                  href: '/security',
                  attributes: {'title': 'Security philosophy and practices'},
                  [text('Security')],
                ),
              ]),
            ]),
            div(classes: 'footer-technology', [
              a(
                classes: 'jaspr-badge-link',
                href: 'https://jaspr.site',
                target: Target.blank,
                attributes: {
                  'rel': 'noopener',
                  'title':
                      'This site is built with the '
                      'Jaspr web framework for Dart.',
                },
                [
                  span([const JasprBadge.light()]),
                  span([const JasprBadge.lightTwoTone()]),
                ],
              ),
            ]),
          ]),
        ]),
      ],
    );
  }
}
