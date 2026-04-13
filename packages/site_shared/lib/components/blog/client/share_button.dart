// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../common/button.dart';
import '../../common/dropdown.dart';
import '../../common/material_icon.dart';

@client
class ShareButton extends StatelessComponent {
  const ShareButton({
    required this.url,
    required this.title,
    super.key,
  });

  final String url;
  final String title;

  @override
  Component build(BuildContext context) {
    return Dropdown(
      id: 'share-menu-${url.hashCode}',
      toggle: const Button(
        icon: 'share',
        title: 'Share this post',
      ),
      content: div(classes: 'dropdown-menu', [
        ul([
          li([
            Builder(
              builder: (context) {
                return button(
                  onClick: () {
                    web.window.navigator.clipboard.writeText(url);
                    context.findAncestorStateOfType<DropdownState>()?.toggle(
                      to: false,
                    );
                  },
                  [
                    const MaterialIcon('content_copy'),
                    const .text('Copy link'),
                  ],
                );
              },
            ),
          ]),
        ]),
        const div(classes: 'dropdown-divider', []),
        ul([
          li([
            a(
              href:
                  'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}',
              target: Target.blank,
              [
                const svg([
                  Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/img/social/x.svg#x',
                    },
                  ),
                ]),
                const .text('Share on X'),
              ],
            ),
          ]),
          li([
            a(
              href:
                  'https://bsky.app/intent/compose?text=${Uri.encodeComponent("$title $url")}',
              target: Target.blank,
              [
                const svg([
                  Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/img/social/bluesky.svg#bluesky',
                    },
                  ),
                ]),
                const .text('Share on Bluesky'),
              ],
            ),
          ]),
          li([
            a(
              href:
                  'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent(url)}',
              target: Target.blank,
              [
                const svg([
                  Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/img/social/linkedin.svg#linkedin',
                    },
                  ),
                ]),
                const .text('Share on LinkedIn'),
              ],
            ),
          ]),
        ]),
      ]),
    );
  }
}
