// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A Material Symbols icon as a `span`.
class Icon extends StatelessComponent {
  const Icon({
    required this.symbol,
    this.label,
    this.size = IconSize.md,
    this.filled = false,
    this.classes,
    super.key,
  });

  const Icon.linkArrow({bool large = false})
    : this(
        symbol: 'arrow_forward',
        size: large ? .sm : .xs,
        classes: const ['link-arrow-icon'],
      );

  /// The ID of the Material Symbol to use.
  final String symbol;

  /// The label to use for accessibility.
  ///
  /// If not specified, the icon is marked as hidden from screen readers.
  final String? label;

  /// The size of the icon.
  final IconSize size;

  /// Whether the icon is filled.
  final bool filled;

  /// Extra classes to apply to the icon's span.
  final List<String>? classes;

  @override
  Component build(BuildContext context) {
    return span(
      classes: [
        'icon',
        'material-symbols-rounded',
        'notranslate',
        'icon-${size.name}',
        if (filled) 'icon-filled',
        ...?classes,
      ].join(' '),
      attributes: {
        if (label case final label?)
          'aria-label': label
        else
          'aria-hidden': 'true',
        'translate': 'no',
      },
      [.text(symbol)],
    );
  }
}

enum IconSize {
  xs,
  sm,
  md,
  lg,
}
