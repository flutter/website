// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../../../client/global_scripts.dart';
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
          if (component.breadcrumbs.isEmpty)
            span(classes: 'toc-intro', [
              const MaterialIcon('list'),
              span(
                attributes: {'aria-label': 'On this page'},
                [text('On this page')],
              ),
            ])
          else ...[
            for (final (index, crumb) in component.breadcrumbs.indexed) ...[
              span(classes: 'toc-breadcrumb', [
                if (index == 0)
                  const MaterialIcon('list')
                else
                  const MaterialIcon('chevron_right'),
                if (index == component.breadcrumbs.length - 1 &&
                    component.pageNumber != null)
                  span(classes: 'page-number', [
                    text('${component.pageNumber}'),
                  ]),
                span([
                  text(crumb),
                ]),
              ]),
            ],
          ],

          span(classes: 'toc-current', [
            const MaterialIcon('chevron_right'),
            ValueListenableBuilder(
              listenable: currentPageHeading,
              builder: (context, value) {
                return span([text(value ?? component.initialHeading)]);
              },
            ),
          ]),
        ],
      ),
      content: component.content.component,
    );
  }
}
