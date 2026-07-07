// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:opal/opal.dart' show MarkupTags, Tag, Tags;

import '../token_renderer.dart';

/// The syntax highlighting for code blocks in dark mode.
final Map<Tag, TextStyle> dashDarkTheme = {
  Tags.comment: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x8B,
      green: 0x95,
      blue: 0xA7,
    ),
  ),
  Tags.lineComment: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x8B,
      green: 0x95,
      blue: 0xA7,
    ),
  ),
  Tags.blockComment: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x8B,
      green: 0x95,
      blue: 0xA7,
    ),
  ),
  Tags.docComment: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x8B,
      green: 0x95,
      blue: 0xA7,
    ),
  ),

  Tags.keyword: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xFF,
      green: 0x89,
      blue: 0x7E,
    ),
  ),
  Tags.declarationKeyword: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xFF,
      green: 0x89,
      blue: 0x7E,
    ),
  ),
  Tags.modifierKeyword: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xFF,
      green: 0x89,
      blue: 0x7E,
    ),
  ),
  Tags.controlKeyword: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xFF,
      green: 0x89,
      blue: 0x7E,
    ),
  ),
  const Tag('name', parent: Tags.preprocessorDirective): const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xFF,
      green: 0x89,
      blue: 0x7E,
    ),
  ),

  Tags.operator: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xE1,
      green: 0xE2,
      blue: 0xEC,
    ),
  ),

  Tags.stringLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.stringContent: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.quotedString: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.singleQuoteString: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.doubleQuoteString: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.tripleQuoteString: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.characterLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),

  Tags.numberLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.integerLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.floatLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),

  Tags.booleanLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.trueLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.falseLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  Tags.nullLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),

  Tags.function: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xB5,
      green: 0x81,
      blue: 0xFF,
    ),
  ),
  Tags.constructor: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xB5,
      green: 0x81,
      blue: 0xFF,
    ),
  ),
  Tags.property: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xB5,
      green: 0x81,
      blue: 0xFF,
    ),
  ),

  Tags.type: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x6B,
      green: 0xB1,
      blue: 0xFF,
    ),
  ),
  Tags.builtInType: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x6B,
      green: 0xB1,
      blue: 0xFF,
    ),
  ),
  Tags.tag: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x6B,
      green: 0xB1,
      blue: 0xFF,
    ),
  ),

  Tags.variable: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xE1,
      green: 0xE2,
      blue: 0xEC,
    ),
  ),
  Tags.parameter: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xE1,
      green: 0xE2,
      blue: 0xEC,
    ),
  ),

  Tags.punctuation: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xDC,
      green: 0xDC,
      blue: 0xDC,
    ),
  ),
  Tags.separator: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xDC,
      green: 0xDC,
      blue: 0xDC,
    ),
  ),
  Tags.accessor: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xDC,
      green: 0xDC,
      blue: 0xDC,
    ),
  ),

  Tags.annotation: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xB5,
      green: 0x81,
      blue: 0xFF,
    ),
  ),

  Tags.specialIdentifier: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xFF,
      green: 0x89,
      blue: 0x7E,
    ),
  ),

  Tags.stringEscape: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x2A,
      green: 0xF5,
      blue: 0xDE,
    ),
    fontWeight: FontWeight.w600,
  ),

  Tags.stringInterpolation: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xE1,
      green: 0xE2,
      blue: 0xEC,
    ),
  ),

  MarkupTags.bold: const TextStyle(
    fontWeight: FontWeight.w700,
  ),
  MarkupTags.italic: const TextStyle(
    fontStyle: FontStyle.italic,
  ),
  MarkupTags.underline: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xDC,
      green: 0xDC,
      blue: 0xDC,
    ),
  ),
  MarkupTags.strikethrough: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x8B,
      green: 0x95,
      blue: 0xA7,
    ),
  ),
  MarkupTags.heading: const TextStyle(
    fontWeight: FontWeight.w700,
  ),
  MarkupTags.code: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  MarkupTags.codeBlock: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xDC,
      green: 0xDC,
      blue: 0xDC,
    ),
  ),
  MarkupTags.link: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x6B,
      green: 0xB1,
      blue: 0xFF,
    ),
  ),
  MarkupTags.linkReference: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x6B,
      green: 0xB1,
      blue: 0xFF,
    ),
  ),
  MarkupTags.linkDefinition: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x6B,
      green: 0xB1,
      blue: 0xFF,
    ),
  ),

  MarkupTags.inserted: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x1C,
      green: 0xDA,
      blue: 0xC5,
    ),
  ),
  MarkupTags.removed: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xFF,
      green: 0x89,
      blue: 0x7E,
    ),
  ),

  Tags.invalid: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xFF,
      green: 0x89,
      blue: 0x7E,
    ),
    fontWeight: FontWeight.w600,
  ),
};
