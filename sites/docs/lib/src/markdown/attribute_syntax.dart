// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:markdown/markdown.dart' as md;

import '../util.dart';

/// A `package:markdown` extension that adds support for
/// attribute syntax as a standalone block.
///
/// Supports syntax like:
///
/// - `{: #new-id}` - Sets the element's HTML ID.
/// - `{: .custom-class}` - Adds a class to the element.
/// - `{: #custom-id .custom-class}` - Set the element's ID and adds a class.
/// - `{: .class1 .class2}` - Add multiple classes.
///
/// This works by detecting attribute blocks and
/// applying them to the preceding block element.
final class AttributeBlockSyntax extends md.BlockSyntax {
  const AttributeBlockSyntax();

  static final RegExp _pattern = RegExp(r'^\{:\s*([^}]+)\}\s*$');

  @override
  RegExp get pattern => _pattern;

  @override
  md.Node? parse(md.BlockParser parser) {
    final currentLine = parser.current;
    final match = pattern.firstMatch(currentLine.content);
    if (match == null) return null;

    final attributeString = match[1]!.trim();
    parser.advance();

    // Create a special marker element that will be processed later.
    // This allows us to apply attributes during post-processing in
    // the `extensions/attribute_processor.dart` extension.
    final attributes = parseAttributes(attributeString);
    return md.Element.empty('attribute-marker')..attributes.addAll(attributes);
  }
}

/// An inline syntax for parsing attributes in the form `{: #id .class}`.
///
/// This allows attributes to be added inline, such as:
///
/// - After links: `[text](url){: .external}`
/// - At the end of paragraphs: `Some text{: .highlight}`
/// - After other inline elements: `**bold**{: .important}`
final class AttributeInlineSyntax extends md.InlineSyntax {
  AttributeInlineSyntax() : super(r'\{:\s*([^}]+)\}');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final attributeString = match[1]!.trim();
    final attributes = parseAttributes(attributeString);

    // Create an inline attribute marker that can be processed later.
    final marker = md.Element.empty('attribute-marker');
    marker.attributes.addAll(attributes);

    parser.addNode(marker);
    return true;
  }
}
