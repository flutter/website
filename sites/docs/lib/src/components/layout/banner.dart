// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// The site-wide banner.
class DashBanner extends StatelessComponent {
  const DashBanner(this.inlineHtmlContent, {super.key});

  /// The raw, inline HTML content to render in the banner.
  ///
  /// This should only be sourced from managed content,
  /// such as our checked-in data files.
  final String inlineHtmlContent;

  @override
  Component build(BuildContext context) => div(
    id: 'site-banner',
    attributes: {'role': 'alert'},
    [
      p([
        RawText(inlineHtmlContent),
      ]),
    ],
  );
}
