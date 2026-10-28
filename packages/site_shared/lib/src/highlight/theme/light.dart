// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:opal/opal.dart' show MarkupTags, Tag, Tags;

import '../token_renderer.dart';

/// The syntax highlighting for code blocks in light mode.
final Map<Tag, TextStyle> dashLightTheme = {
  Tags.comment: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x59,
      green: 0x61,
      blue: 0x6E,
    ),
  ),
  Tags.lineComment: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x59,
      green: 0x61,
      blue: 0x6E,
    ),
  ),
  Tags.blockComment: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x59,
      green: 0x61,
      blue: 0x6E,
    ),
  ),
  Tags.docComment: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x59,
      green: 0x61,
      blue: 0x6E,
    ),
  ),

  Tags.keyword: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xBD,
      green: 0x23,
      blue: 0x14,
    ),
  ),
  Tags.declarationKeyword: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xBD,
      green: 0x23,
      blue: 0x14,
    ),
  ),
  Tags.modifierKeyword: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xBD,
      green: 0x23,
      blue: 0x14,
    ),
  ),
  Tags.controlKeyword: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xBD,
      green: 0x23,
      blue: 0x14,
    ),
  ),
  const Tag('name', parent: Tags.preprocessorDirective): const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xBD,
      green: 0x23,
      blue: 0x14,
    ),
  ),

  Tags.operator: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x19,
      green: 0x1C,
      blue: 0x22,
    ),
  ),

  Tags.stringLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.stringContent: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.quotedString: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.singleQuoteString: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.doubleQuoteString: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.tripleQuoteString: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.characterLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),

  Tags.numberLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.integerLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.floatLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),

  Tags.booleanLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.trueLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.falseLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  Tags.nullLiteral: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),

  Tags.function: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x62,
      green: 0x00,
      blue: 0xEE,
    ),
  ),
  Tags.constructor: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x62,
      green: 0x00,
      blue: 0xEE,
    ),
  ),
  Tags.property: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x62,
      green: 0x00,
      blue: 0xEE,
    ),
  ),

  Tags.type: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x14,
      green: 0x6B,
      blue: 0xCD,
    ),
  ),
  Tags.builtInType: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x14,
      green: 0x6B,
      blue: 0xCD,
    ),
  ),
  Tags.tag: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x14,
      green: 0x6B,
      blue: 0xCD,
    ),
  ),

  Tags.variable: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x19,
      green: 0x1C,
      blue: 0x22,
    ),
  ),
  Tags.parameter: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x19,
      green: 0x1C,
      blue: 0x22,
    ),
  ),

  Tags.punctuation: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x19,
      green: 0x1C,
      blue: 0x22,
    ),
  ),
  Tags.separator: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x19,
      green: 0x1C,
      blue: 0x22,
    ),
  ),
  Tags.accessor: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x19,
      green: 0x1C,
      blue: 0x22,
    ),
  ),

  Tags.annotation: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x62,
      green: 0x00,
      blue: 0xEE,
    ),
  ),

  Tags.specialIdentifier: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xBD,
      green: 0x23,
      blue: 0x14,
    ),
  ),

  Tags.stringEscape: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0A,
      green: 0x5A,
      blue: 0x50,
    ),
    fontWeight: FontWeight.w600,
  ),

  Tags.stringInterpolation: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x62,
      green: 0x00,
      blue: 0xEE,
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
      red: 0x19,
      green: 0x1C,
      blue: 0x22,
    ),
  ),
  MarkupTags.strikethrough: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x59,
      green: 0x61,
      blue: 0x6E,
    ),
  ),
  MarkupTags.heading: const TextStyle(
    fontWeight: FontWeight.w700,
  ),
  MarkupTags.code: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  MarkupTags.codeBlock: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x19,
      green: 0x1C,
      blue: 0x22,
    ),
  ),
  MarkupTags.link: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x14,
      green: 0x6B,
      blue: 0xCD,
    ),
  ),
  MarkupTags.linkReference: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x14,
      green: 0x6B,
      blue: 0xCD,
    ),
  ),
  MarkupTags.linkDefinition: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x14,
      green: 0x6B,
      blue: 0xCD,
    ),
  ),

  MarkupTags.inserted: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0x0C,
      green: 0x70,
      blue: 0x64,
    ),
  ),
  MarkupTags.removed: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xBD,
      green: 0x23,
      blue: 0x14,
    ),
  ),

  Tags.invalid: const TextStyle(
    foregroundColor: Color.fromArgb(
      red: 0xBD,
      green: 0x23,
      blue: 0x14,
    ),
    fontWeight: FontWeight.w600,
  ),
};
