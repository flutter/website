// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../util.dart';

/// A Material Symbols icon rendered as a span element.
class MaterialIcon extends StatelessComponent {
  const MaterialIcon(
    this.id, {
    this.title,
    this.label,
    this.size,
    this.filled = false,
    this.classes = const [],
  });

  /// Creates a [MaterialIcon] from a set of attributes parsed from Markdown.
  factory MaterialIcon.fromAttributes(
    Map<String, String> attributes,
  ) {
    final id =
        attributes['id'] ??
        (throw ArgumentError(
          'The "id" attribute is required for the Icon component.',
        ));
    final title = attributes['title'];
    final label = attributes['label'];
    final size = attributes['size'];
    final filled = attributes['filled'] == 'true';
    final classes = attributes['class']?.split(' ') ?? const [];

    return MaterialIcon(
      id,
      title: title,
      label: label,
      size: size,
      filled: filled,
      classes: classes,
    );
  }

  final String id;
  final String? title;
  final String? label;

  /// Optional custom size for the icon in a CSS unit, such as '1.25rem';
  final String? size;
  final bool filled;
  final List<String> classes;

  @override
  Component build(BuildContext _) => span(
    classes: [
      'material-symbols',
      if (filled) 'ms-filled',
      ...classes,
    ].toClasses,
    attributes: {
      'title': ?title,
      if (label ?? title case final labelToUse?)
        'aria-label': labelToUse
      else
        'aria-hidden': 'true',
      'translate': 'no',
      if (size case final sizeToUse?) 'style': 'font-size: $sizeToUse;',
    },
    [.text(id)],
  );
}
