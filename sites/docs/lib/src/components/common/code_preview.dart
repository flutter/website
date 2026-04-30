// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../util.dart';
import 'wrapped_code_block.dart';

/// A component that displays a preview area alongside a code block.
///
/// The `<CodePreview>` component takes in standard markdown content, but
/// expects at least two children, with the last child being a code block.
/// Any content before the last child is treated as the preview area.
class CodePreview extends CustomComponent {
  const CodePreview() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(
      tag: 'CodePreview',
      :final attributes,
      :final children?,
    )) {
      if (children.length < 2) {
        throw Exception('CodePreview requires at least two child elements.');
      }
      final lastChild = children.last;
      if (lastChild is! ComponentNode ||
          lastChild.component is! WrappedCodeBlock) {
        throw Exception(
          'The last child of CodePreview must be a code block.',
        );
      }

      final previewChildren = <Node>[];

      for (var i = 0; i < children.length - 1; i++) {
        if (children[i] case ElementNode(tag: 'p', :final children?)) {
          // Unwrap paragraph nodes to avoid extra spacing.
          previewChildren.addAll(children);
        } else {
          previewChildren.add(children[i]);
        }
      }

      final direction = attributes['direction'] ?? 'column';
      final previewColor = attributes['previewcolor'];

      return div(
        classes: 'code-preview',
        attributes: {'data-direction': direction},
        [
          div(
            classes: [
              'preview-area',
              if (previewColor != null) 'fixed-bg',
            ].toClasses,
            styles: previewColor != null
                ? Styles(backgroundColor: Color(previewColor))
                : null,
            [
              builder.build(previewChildren),
            ],
          ),
          lastChild.component,
        ],
      );
    }

    return null;
  }
}
