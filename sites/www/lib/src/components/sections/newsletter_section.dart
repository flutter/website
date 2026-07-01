// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../common/newsletter_form.dart';

class NewsletterSection extends StatelessComponent {
  const NewsletterSection();

  @override
  Component build(BuildContext context) {
    return const section(id: 'newsletter', [
      div(classes: 'newsletter container', [
        div(classes: 'text', [
          h2([.text('Join our '), br(), .text('newsletter')]),
        ]),
        div(classes: 'form', [NewsletterForm()]),
      ]),
      // reCAPTCHA script
      script(src: 'https://www.google.com/recaptcha/api.js'),
    ]);
  }
}
