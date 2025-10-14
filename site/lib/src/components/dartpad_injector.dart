// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

/// Prepares an element with the structure expected by
/// the `inject_dartpad` tool from site-shared.
final class DartPadInjector extends StatelessComponent {
  const DartPadInjector({
    super.key,
    required this.content,
    String? theme,
    String? title,
    this.height,
    bool? runAutomatically,
  }) : theme = theme ?? 'light',
       title = title ?? 'Runnable Dart sample',
       runAutomatically = runAutomatically ?? false;

  final List<String> content;
  final String theme;
  final String title;
  final String? height;
  final bool runAutomatically;

  @override
  Component build(BuildContext context) => pre([
    code(
      attributes: {
        'title': title,
        'data-dartpad': 'true',
        'data-embed': 'true',
        'data-theme': theme,
        'data-run': runAutomatically.toString(),
        'data-height': ?height,
      },
      [
        text(content.join('\n')),
      ],
    ),
  ]);
}
