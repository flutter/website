// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../../../client/global_scripts.dart';
import '../../../util.dart';
import '../../common/dropdown.dart';
import '../../common/material_icon.dart';
import '../../util/component_ref.dart';

@client
class PageNav extends StatefulComponent {
  const PageNav({
    this.breadcrumbs = const [],
    this.pageNumber,
    required this.initialHeading,
    required this.content,
    super.key,
  });

  final List<String> breadcrumbs;
  final int? pageNumber;
  final String initialHeading;
  final ComponentRef content;

  @override
  State<PageNav> createState() => _PageNavState();
}

class _PageNavState extends State<PageNav> {
  final dropdownKey = GlobalStateKey<DropdownState>();

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      context.binding.addPostFrameCallback(() {
        // Close the dropdown if any link in the TOC is navigated to.
        final inlineTocLinks = web.document.querySelectorAll(
          '#pagenav-content a',
        );
        for (var i = 0; i < inlineTocLinks.length; i++) {
          final tocLink = inlineTocLinks.item(i) as web.Element;
          tocLink.addEventListener(
            'click',
            ((web.Event _) {
              dropdownKey.currentState?.toggle(to: false);
            }).toJS,
          );
        }
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return Dropdown(
      key: dropdownKey,
      id: 'pagenav',
      toggle: button(
        attributes: {
          'title': 'Toggle the table of contents dropdown',
          'aria-label': 'Toggle the table of contents dropdown',
        },
        [
          const MaterialIcon('list'),
          if (component.breadcrumbs.isEmpty)
            const span(classes: 'toc-breadcrumb', [
              span(
                attributes: {'aria-label': 'On this page'},
                [.text('On this page')],
              ),
              MaterialIcon('chevron_right'),
            ])
          else ...[
            for (final (index, crumb) in component.breadcrumbs.indexed) ...[
              span(
                classes: [
                  'toc-breadcrumb',
                  if (index < component.breadcrumbs.length - 2)
                    'toc-hide-medium',
                  if (index < component.breadcrumbs.length - 1)
                    'toc-hide-small',
                ].toClasses,
                [
                  if (index == component.breadcrumbs.length - 1 &&
                      component.pageNumber != null)
                    span(classes: 'page-number', [
                      .text('${component.pageNumber}'),
                    ]),
                  span([
                    _simpleInlineMarkdown(crumb),
                  ]),
                  const MaterialIcon('chevron_right'),
                ],
              ),
            ],
          ],

          span(classes: 'toc-current', [
            ValueListenableBuilder(
              listenable: currentPageHeading,
              builder: (context, value) {
                return span([.text(value ?? component.initialHeading)]);
              },
            ),
          ]),
        ],
      ),
      content: component.content.component,
    );
  }

  /// Simple (and incomplete) implementation of inline markdown parsing
  /// for use on the client.
  Component _simpleInlineMarkdown(String content) {
    final syntaxRegex = RegExp(r'`([^`]+)`|\*([^*]+)\*|\*\*([^*]+)\*\*');

    final components = <Component>[];

    var current = 0;
    final matches = syntaxRegex.allMatches(content);

    for (final match in matches) {
      if (match.start > current) {
        components.add(.text(content.substring(current, match.start)));
      }
      if (match.group(1) != null) {
        components.add(code([.text(match.group(1)!)]));
      } else if (match.group(2) != null) {
        components.add(em([.text(match.group(2)!)]));
      } else if (match.group(3) != null) {
        components.add(strong([.text(match.group(3)!)]));
      }
      current = match.end;
    }
    if (current < content.length) {
      components.add(.text(content.substring(current)));
    }
    return components.length > 1 ? .fragment(components) : components.first;
  }
}
