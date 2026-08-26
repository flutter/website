// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:markdown/markdown.dart' as md;

/// A custom Markdown block syntax for diagrams authored
/// between ```mermaid code fences.
///
/// Example:
///
/// ````markdown
/// ```mermaid
/// flowchart TD
///     A --> B
/// ```
/// ````
///
/// This renders as a `<div class="mermaid-container">` containing
/// a `<pre class="mermaid">` element that hydrates on the client
/// via [MermaidViewer].
final class MermaidBlockSyntax extends md.BlockSyntax {
  const MermaidBlockSyntax();

  // Matches opening fence: ```mermaid (with optional trailing whitespace/config)
  @override
  RegExp get pattern => RegExp(r'^\s{0,3}`{3,}mermaid(?:\s.*)?$');

  static final _closingFencePattern = RegExp(r'^\s{0,3}`{3,}\s*$');

  @override
  bool canParse(md.BlockParser parser) {
    return pattern.hasMatch(parser.current.content);
  }

  @override
  md.Node? parse(md.BlockParser parser) {
    // Advance past the opening ```mermaid line
    parser.advance();

    final lines = <String>[];

    // Collect diagram definition until the closing ```
    while (!parser.isDone) {
      final line = parser.current.content;
      if (_closingFencePattern.hasMatch(line)) {
        parser.advance(); // Consume closing fence
        break;
      }
      lines.add(line);
      parser.advance();
    }

    final rawContent = lines.join('\n');

    // Return HTML AST node for the diagram container
    final pre = md.Element.text('pre', rawContent)
      ..attributes['class'] = 'mermaid'
      ..attributes['data-source'] = rawContent;

    return md.Element('div', [pre])..attributes['class'] = 'mermaid-container';
  }
}
