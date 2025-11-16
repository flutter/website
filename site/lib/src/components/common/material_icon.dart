// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../util.dart';

/// A Material Symbols icon rendered as a span element.
class MaterialIcon extends StatelessComponent {
  const MaterialIcon(
    this.id, {
    this.title,
    this.label,
    this.classes = const [],
  });

  final String id;
  final List<String> classes;
  final String? title;
  final String? label;

  @override
  Component build(BuildContext _) {
    return span(
      classes: ['material-symbols', ...classes].toClasses,
      attributes: {
        'title': ?title,
        if (label ?? title case final labelToUse?)
          'aria-label': labelToUse
        else
          'aria-hidden': 'true',
        'translate': 'no',
      },
      [text(id)],
    );
  }
}
