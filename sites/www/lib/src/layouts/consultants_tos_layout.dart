// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../utils/scroll_spy.dart';
import 'default_layout.dart';

class ConsultantsTosLayout extends DefaultLayout {
  @override
  Pattern get name => 'consultants-tos';

  @override
  Component buildLayout(Page page, Component child) {
    return super.buildLayout(
      page,
      main_([
        const section(classes: 'hero', [
          div(classes: 'hero-content', [
            h2([
              .text('Flutter'),
              br(),
              .text('Consultant'),
              br(),
              .text('Directory Pilot'),
              br(),
              .text('Terms of Service'),
            ]),
            p([.text('Last modified: July 13, 2023')]),
          ]),
        ]),
        section(classes: 'content-container', attributes: scroll.spyContent, [
          div(classes: 'text-container terms-of-service-text-container', [
            child,
          ]),
        ]),
      ]),
    );
  }
}
