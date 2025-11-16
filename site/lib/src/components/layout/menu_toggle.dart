// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../common/material_icon.dart';

@client
final class MenuToggle extends StatefulComponent {
  const MenuToggle();

  @override
  State<MenuToggle> createState() => _MenuToggleState();
}

final class _MenuToggleState extends State<MenuToggle> {
  @override
  void initState() {
    if (kIsWeb) {
      // Set up an event listener to close the wide sidenav if
      // switching to a wider site layout.
      web.window.addEventListener('resize', _handleResize.toJS);

      // Set up an event listener to close the sidenav
      // if it is open and somewhere else is clicked on.
      web.window.addEventListener('click', _handleClickOutsideSidenav.toJS);
    }

    super.initState();
  }

  @override
  Component build(BuildContext context) => button(
    id: 'menu-toggle',
    classes: 'icon-button',
    type: ButtonType.button,
    attributes: {
      'aria-controls': 'sidenav',
      'aria-label': 'Toggle navigation menu.',
      'title': 'Toggle navigation menu.',
    },
    events: {
      'click': (_) {
        web.document.body?.classList.toggle('open_menu');
      },
    },
    const [
      MaterialIcon('menu'),
      MaterialIcon('close'),
    ],
  );
}

void _handleResize(web.Event _) {
  if (web.window.innerWidth > 1025) {
    web.document.body?.classList.remove('open_menu');
  }
}

void _handleClickOutsideSidenav(web.MouseEvent clickEvent) {
  if (clickEvent.target case final web.HTMLElement clickedElement) {
    if (clickedElement.closest('#sidenav') == null &&
        clickedElement.closest('#menu-toggle') == null) {
      final bodyClasses = web.document.body!.classList;
      if (bodyClasses.contains('open_menu')) {
        clickEvent.preventDefault();
        bodyClasses.remove('open_menu');
      }
    }
  }
}
