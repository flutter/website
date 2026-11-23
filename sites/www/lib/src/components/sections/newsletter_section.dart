// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../common/newsletter_signup.dart';

/// A page section inviting visitors to sign in with Google to join the
/// Flutter Developer Community and receive Flutter updates.
class NewsletterSection extends StatelessComponent {
  /// Creates a newsletter sign-up section.
  const NewsletterSection({super.key});

  @override
  Component build(BuildContext context) {
    return const section(id: 'newsletter', [
      // Runs before the sign-up UI is painted to avoid
      // briefly showing sign-in to visitors who already signed up.
      script(content: newsletterSignupStateScript),
      div(classes: 'newsletter container', [
        div(classes: 'text', [
          h2([.text('Join our '), br(), .text('newsletter')]),
        ]),
        div(classes: 'form', [NewsletterSignup()]),
      ]),
    ]);
  }
}
