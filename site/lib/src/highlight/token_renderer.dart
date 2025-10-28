// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:opal/opal.dart' show Tag, TaggedToken;

/// Renderer for converting spans of tagged tokens from `package:opal`
/// to themed spans according to the configured themes.
final class ThemedSpanRenderer {
  /// Themes to be used for rendering.
  final Map<String, SyntaxHighlightingTheme> themeByName;
  const ThemedSpanRenderer({required this.themeByName});

  /// Renders the specified [tokenLines] into a themed list of spans by line.
  /// Each top-level list represents a single line of text.
  @useResult
  List<List<ThemedSpan>> render(List<List<TaggedToken>> tokenLines) {
    final result = <List<ThemedSpan>>[];

    for (final line in tokenLines) {
      final currentLine = <ThemedSpan>[];
      for (final token in line) {
        final styleByTheme = <String, TextStyle>{};
        for (final MapEntry(key: themeName, value: theme)
            in themeByName.entries) {
          final style = theme.styleForSpan(token);
          if (style != null) {
            styleByTheme[themeName] = style;
          }
        }
        currentLine.add(
          ThemedSpan(
            content: token.content,
            styleByTheme: styleByTheme,
            tag: token.tags.join(','),
          ),
        );
      }

      result.add(currentLine);
    }

    return result;
  }
}

/// A theme to be used for syntax highlighting of [TaggedToken].
final class SyntaxHighlightingTheme {
  /// What [TextStyle] should be give for a specific [Tag].
  final Map<Tag, TextStyle> _textStyleByTag;

  SyntaxHighlightingTheme(Map<Tag, TextStyle> textStyleByTag)
    : _textStyleByTag = {...textStyleByTag};

  @useResult
  TextStyle? styleForSpan(TaggedToken token) => token.tags.reversed
      .expand((t) => t.expand())
      .map((t) => _textStyleByTag[t])
      .nonNulls
      .firstOrNull;
}

final class ThemedSpan {
  final String content;
  final Map<String, TextStyle> styleByTheme;
  final String tag;

  ThemedSpan({
    required this.content,
    required this.styleByTheme,
    required this.tag,
  });
}

final class TextStyle {
  static const none = TextStyle();

  final Color? foregroundColor;
  final Color? backgroundColor;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;

  const TextStyle({
    this.foregroundColor,
    this.backgroundColor,
    this.fontStyle,
    this.fontWeight,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextStyle &&
          foregroundColor == other.foregroundColor &&
          backgroundColor == other.backgroundColor &&
          fontStyle == other.fontStyle &&
          fontWeight == other.fontWeight;

  @override
  int get hashCode =>
      Object.hash(foregroundColor, backgroundColor, fontStyle, fontWeight);
}

final class Color {
  final double alpha;
  final double red;
  final double green;
  final double blue;

  const Color({
    this.alpha = 1,
    required this.red,
    required this.green,
    required this.blue,
  });

  const Color.fromArgb({
    int alpha = 0xFF,
    required int red,
    required int green,
    required int blue,
  }) : alpha = (alpha & 0xFF) / 255,
       red = (red & 0xFF) / 255,
       green = (green & 0xFF) / 255,
       blue = (blue & 0xFF) / 255;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Color &&
          alpha == other.alpha &&
          red == other.red &&
          green == other.green &&
          blue == other.blue;

  @override
  int get hashCode => Object.hash(alpha, red, green, blue);
}

enum FontStyle {
  normal,
  italic,
}

enum FontWeight {
  w100(100),
  w200(200),
  w300(300),
  w400(400),
  w500(500),
  w600(600),
  w700(700),
  w800(800),
  w900(900);

  final int weight;

  const FontWeight(this.weight);
}
