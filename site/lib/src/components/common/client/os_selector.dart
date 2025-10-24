// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../../util.dart';

@client
class OsSelector extends StatefulComponent {
  const OsSelector({super.key});

  @override
  State<OsSelector> createState() => _OsSelectorState();
}

class _OsSelectorState extends State<OsSelector> {
  // This value is currently not synced across potential multiple instances
  // of the OS selector on the page. In practice, this currently does not
  // happen, but would need to be addressed if changed.
  OperatingSystem selectedOs = OperatingSystem.windows;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      final currentOs = getOS() ?? OperatingSystem.windows;
      setOS(currentOs);
    }
  }

  void setOS(OperatingSystem os) {
    setState(() {
      selectedOs = os;
    });

    final selectedOsTextSpans = web.document.querySelectorAll(
      '.selected-os-text',
    );
    for (var i = 0; i < selectedOsTextSpans.length; i++) {
      final span = selectedOsTextSpans.item(i) as web.Element;
      span.textContent = os.label;
    }

    final bodyClasses = web.document.body!.classList;
    for (final os in OperatingSystem.values) {
      bodyClasses.remove('show-${os.name}');
    }
    bodyClasses.add('show-${os.name}');
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'card-grid narrow os-selector', [
      for (final os in OperatingSystem.values)
        button(
          id: 'install-${os.name}',
          classes: [
            'card outlined-card install-card',
            if (selectedOs == os) 'selected-card',
          ].toClasses,
          attributes: {
            'data-os': os.name,
            'aria-label': 'Update docs to cover ${os.label}',
          },
          events: {
            'click': (event) {
              setOS(os);
            },
          },
          [
            div(classes: 'card-leading', [
              img(
                src: '/assets/images/docs/brand-svg/${os.name}.svg',
                alt: '${os.label} logo',
                attributes: {
                  'width': '72',
                  'height': '72',
                  'aria-hidden': 'true',
                },
              ),
            ]),
            div(classes: 'card-header text-center', [
              span(classes: 'card-title', [
                text(os.label),
              ]),
            ]),
          ],
        ),
    ]);
  }
}
