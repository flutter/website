// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/util.dart';
import 'package:site_shared/web_util.dart';
import 'package:universal_web/web.dart' as web;

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
      final currentOs = browserOperatingSystem ?? OperatingSystem.windows;
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
    for (final supportedOS in OperatingSystem.values) {
      bodyClasses.remove('show-${supportedOS.id}');
    }
    bodyClasses.add('show-${os.id}');
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'card-grid narrow os-selector', [
      for (final supportedOS in OperatingSystem.values)
        button(
          id: 'install-${supportedOS.id}',
          classes: [
            'card outlined-card install-card',
            if (selectedOs == supportedOS) 'selected-card',
          ].toClasses,
          attributes: {
            'data-os': supportedOS.id,
            'aria-label': 'Update docs to cover ${supportedOS.label}',
          },
          events: {
            'click': (event) {
              setOS(supportedOS);
            },
          },
          [
            div(classes: 'card-leading', [
              img(
                src: '/assets/images/docs/brand-svg/${supportedOS.id}.svg',
                alt: '${supportedOS.label} logo',
                attributes: {
                  'width': '72',
                  'height': '72',
                  'aria-hidden': 'true',
                },
              ),
            ]),
            div(classes: 'card-header text-center', [
              span(classes: 'card-title', [
                .text(supportedOS.label),
              ]),
            ]),
          ],
        ),
    ]);
  }
}
