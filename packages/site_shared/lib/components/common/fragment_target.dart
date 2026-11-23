// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

/// An empty block element that acts as a target for URL fragment links.
///
/// Useful when a section's fragment ID needs to be updated or
/// when targeting a spot mid-section without adding a visible heading.
final class FragmentTarget extends StatelessComponent {
  /// Creates a fragment target with the specified HTML [id].
  const FragmentTarget(this.id)
    : assert(id != '', 'FragmentTarget id must not be empty.');

  /// Creates a [FragmentTarget] from parsed component [attributes].
  ///
  /// Throws an [ArgumentError] if [attributes] contains keys other than `id`
  /// or if its `id` value is missing, empty, starts with `#`,
  /// or contains whitespace.
  factory FragmentTarget.fromAttributes(Map<String, String> attributes) {
    final unexpectedKeys = [
      for (final key in attributes.keys)
        if (key != 'id') key,
    ];
    if (unexpectedKeys.isNotEmpty) {
      throw ArgumentError(
        'FragmentTarget only supports the "id" attribute, '
        'found unexpected attribute(s): ${unexpectedKeys.join(', ')}.',
      );
    }

    final id = attributes['id'];
    if (id == null || id.isEmpty) {
      throw ArgumentError(
        'FragmentTarget requires a non-empty "id" attribute.',
      );
    }
    if (id.startsWith('#')) {
      throw ArgumentError(
        'FragmentTarget "id" attribute must not start with "#": "$id".',
      );
    }
    if (_whitespacePattern.hasMatch(id)) {
      throw ArgumentError(
        'FragmentTarget "id" attribute must not contain whitespace: "$id".',
      );
    }

    return FragmentTarget(id);
  }

  /// A pattern matching any whitespace character disallowed in HTML IDs.
  static final RegExp _whitespacePattern = RegExp(r'\s');

  /// The HTML `id` attribute applied to this fragment target element.
  final String id;

  @override
  Component build(BuildContext context) => div(
    id: id,
    classes: 'fragment-target',
    const [],
  );
}

/// A custom Markdown component that renders `<FragmentTarget id="..." />`
/// tags as [FragmentTarget] elements.
///
/// Throws an [ArgumentError] if a tag has attributes that
/// [FragmentTarget.fromAttributes] rejects or has non-whitespace children.
final class FragmentTargetMarkdownComponent extends CustomComponent {
  /// Creates a [FragmentTargetMarkdownComponent].
  const FragmentTargetMarkdownComponent() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode || node.tag.toLowerCase() != 'fragmenttarget') {
      return null;
    }

    final target = FragmentTarget.fromAttributes(node.attributes);
    final hasChildContent =
        node.children?.any(
          (child) => child is! TextNode || child.text.trim().isNotEmpty,
        ) ??
        false;
    if (hasChildContent) {
      throw ArgumentError(
        '<FragmentTarget id="${target.id}"> must not contain child content '
        '(use <FragmentTarget id="${target.id}" />).',
      );
    }

    return target;
  }
}
