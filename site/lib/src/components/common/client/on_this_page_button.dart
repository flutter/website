// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../material_icon.dart';

/// Used in the table of contents to scroll to the top of the page.
@client
final class OnThisPageButton extends StatelessComponent {
  const OnThisPageButton();

  @override
  Component build(BuildContext _) => header(
    events: {
      'click': (_) {
        final distanceBetweenTop =
            web.document.documentElement?.scrollTop ??
            web.document.body?.scrollTop;

        if (distanceBetweenTop != null && distanceBetweenTop > 0) {
          web.window.scrollTo(web.ScrollToOptions(behavior: 'smooth', top: 0));
        }
      },
    },
    [
      const MaterialIcon('list'),
      span([text('On this page')]),
    ],
  );
}
