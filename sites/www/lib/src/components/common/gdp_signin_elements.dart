// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// The multicolor Google "G" logo rendered as an inline SVG.
class GoogleLogo extends StatelessComponent {
  /// Creates a Google logo with the specified CSS [classes].
  const GoogleLogo({this.classes = 'gdp-google-logo', super.key});

  /// CSS classes applied to the root `<svg>` element.
  final String classes;

  @override
  Component build(BuildContext context) {
    return RawText(
      '<svg class="$classes" viewBox="0 0 48 48" aria-hidden="true">'
      '<path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85'
      'C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19'
      'C12.43 13.72 17.74 9.5 24 9.5z"/>'
      '<path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02'
      'h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 '
      '7.09-17.65z"/>'
      '<path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59'
      's.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 '
      '2.56 10.78l7.97-6.19z"/>'
      '<path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6'
      'c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19'
      'C6.51 42.62 14.62 48 24 48z"/>'
      '</svg>',
    );
  }
}

/// The Google Developer Program terms and privacy disclosure shown next to
/// Flutter GDP sign-in buttons.
class GdpSignInDisclosure extends StatelessComponent {
  /// Creates a disclosure paragraph with the specified CSS [classes].
  const GdpSignInDisclosure({required this.classes, super.key});

  /// CSS classes applied to the disclosure `<p>` element.
  final String classes;

  @override
  Component build(BuildContext context) {
    return p(classes: classes, const [
      .text(
        'Signing up creates or updates your Google Developer Program '
        'profile, joins the Flutter Developer Community, adds Flutter '
        'and Dart to your interests, and opts you in to emails. ',
      ),
      a(
        href: 'https://developers.google.com/profile/terms',
        target: Target.blank,
        attributes: {'rel': 'noopener'},
        [.text('Program terms')],
      ),
      .text(' · '),
      a(
        href: 'https://policies.google.com/privacy',
        target: Target.blank,
        attributes: {'rel': 'noopener'},
        [.text('Privacy policy')],
      ),
    ]);
  }
}
