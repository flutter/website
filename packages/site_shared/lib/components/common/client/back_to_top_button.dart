// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../material_icon.dart';

/// A floating button that scrolls the page back to the top when clicked.
///
/// Stays hidden until the page has been scrolled, via CSS rules that key
/// off of the `in-content` class already toggled on `<body>` by the site's
/// scroll-spy logic.
@client
final class BackToTopButton extends StatelessComponent {
  const BackToTopButton({super.key});

  @override
  Component build(BuildContext _) => button(
    type: ButtonType.button,
    classes: 'back-to-top',
    attributes: {'aria-label': 'Back to top'},
    events: {
      'click': (_) {
        final prefersReducedMotion = web.window
            .matchMedia('(prefers-reduced-motion: reduce)')
            .matches;
        web.window.scrollTo(
          web.ScrollToOptions(
            behavior: prefersReducedMotion ? 'auto' : 'smooth',
            top: 0,
          ),
        );
      },
    },
    [const MaterialIcon('arrow_upward')],
  );
}
