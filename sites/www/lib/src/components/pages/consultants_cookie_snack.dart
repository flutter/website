// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

@client
class ConsultantsCookieSnack extends StatefulComponent {
  const ConsultantsCookieSnack({super.key});

  @override
  State<ConsultantsCookieSnack> createState() => _ConsultantsCookieSnackState();
}

class _ConsultantsCookieSnackState extends State<ConsultantsCookieSnack> {
  bool _agreed = false;

  @override
  Component build(BuildContext context) {
    if (_agreed) return const .empty();

    return section(classes: 'cookie-snack show', [
      div(classes: 'container', [
        const p([
          .text(
            'NOTICE: Flutter hopes this directory is useful for customers seeking consultants with Flutter experience; however, Flutter makes no representation to you or anyone else that the listed consultants are Flutter or Google partners, and Flutter does not represent or warrant their qualifications or the quality of services you may receive.  Your relationship is strictly between you and the consultants.',
          ),
        ]),
        button(
          classes: 'solid',
          onClick: () {
            setState(() {
              _agreed = true;
            });
          },
          const [.text('Okay')],
        ),
      ]),
    ]);
  }
}
