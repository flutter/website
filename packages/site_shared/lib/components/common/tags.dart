// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../util.dart';
import 'material_icon.dart';

/// A display of multiple categorical or descriptive tags.
class Tags extends StatelessComponent {
  /// Creates a collection containing [tags].
  const Tags(this.tags, {this.classes});

  /// The tags displayed in this collection.
  final List<Tag> tags;

  /// Additional CSS classes to apply to this tag container.
  final List<String>? classes;

  @override
  Component build(BuildContext context) => div(
    classes: ['tags', ...?classes].toClasses,
    [for (final tag in tags) tag],
  );
}

/// An individual tag to categorize an item,
/// such as the type of an individual lint.
///
/// Generally displayed within a [Tags] component.
class Tag extends StatelessComponent {
  /// Creates a tag displaying [content].
  const Tag(
    this.content, {
    this.icon,
    this.title,
    this.label,
    this.color = .grey,
    this.size = .regular,
    this.classes,
  });

  /// The text displayed in this tag.
  final String content;

  /// The ID of the optional Material Symbols icon displayed before [content].
  final String? icon;

  /// The optional tooltip text for this tag.
  final String? title;

  /// The accessible label for this tag.
  ///
  /// If omitted, [title] is used as the accessible label.
  final String? label;

  /// The color treatment for this tag.
  final TagColor color;

  /// The size of this tag's text and padding.
  final TagSize size;

  /// Additional CSS classes to apply to this tag.
  final List<String>? classes;

  @override
  Component build(BuildContext context) => div(
    classes: [
      'tag-label',
      color._className,
      size._className,
      ...?classes,
    ].toClasses,
    attributes: {
      'title': ?title,
      'aria-label': ?(label ?? title),
    },
    [
      if (icon case final iconId?) MaterialIcon(iconId),
      span([.text(content)]),
    ],
  );
}

/// A supported color for a [Tag].
enum TagColor {
  blue,
  green,
  teal,
  purple,
  magenta,
  red,
  orange,
  amber,
  grey,
  subtleGrey;

  /// The CSS class that applies this tag color.
  String get _className => switch (this) {
    TagColor.blue => 'tag-blue',
    TagColor.green => 'tag-green',
    TagColor.teal => 'tag-teal',
    TagColor.purple => 'tag-purple',
    TagColor.magenta => 'tag-magenta',
    TagColor.red => 'tag-red',
    TagColor.orange => 'tag-orange',
    TagColor.amber => 'tag-amber',
    TagColor.grey => 'tag-grey',
    TagColor.subtleGrey => 'tag-subtle-grey',
  };
}

/// A supported size for a [Tag].
enum TagSize {
  small,
  regular;

  /// The CSS class that applies this tag size.
  String get _className => switch (this) {
    TagSize.small => 'tag-small',
    TagSize.regular => 'tag-regular',
  };
}
