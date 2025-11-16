// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:markdown/markdown.dart' as md;

import '../util.dart';

/// A custom header syntax that extends the default header syntax to support:
///
/// 1. Inline attribute syntax at the end of headers,
///    such as `# Title {: #custom-id .class}`)`.
/// 2. Auto-generated IDs using slugify when no ID is provided.
final class HeaderWithAttributesSyntax extends md.HeaderSyntax {
  const HeaderWithAttributesSyntax();

  static final RegExp _attributeEndPattern = RegExp(r'\s*\{:\s*([^}]+)\}\s*$');

  @override
  md.Node parse(md.BlockParser parser) {
    final element = super.parse(parser) as md.Element;

    // Check if the header text ends with attribute syntax.
    final children = element.children;
    if (children != null && children.isNotEmpty) {
      final lastChild = children.last;
      var childText = lastChild.textContent;
      final match = _attributeEndPattern.firstMatch(childText);

      if (match != null) {
        // Extract and parse the attributes.
        final attributeString = match.group(1)!.trim();
        final attributes = parseAttributes(attributeString);

        // Remove the attribute syntax from the text.
        final cleanText = childText.substring(0, match.start).trim();
        childText = cleanText;
        children[children.length - 1] = md.UnparsedContent(cleanText);

        // Apply the parsed attributes to the header element.
        element.attributes.addAll(attributes);
      }

      // If no ID was specified otherwise, generate an ID from the content.
      if (!element.attributes.containsKey('id')) {
        if (childText.isNotEmpty) {
          element.attributes['id'] = slugify(childText);
        }
      }
    }

    return element;
  }
}
