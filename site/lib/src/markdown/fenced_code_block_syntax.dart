// Copied from https://github.com/dart-lang/tools/blob/main/pkgs/markdown/lib/src/block_syntaxes/fenced_code_block_syntax.dart
//
// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:markdown/markdown.dart';
// Used as this is file is copied from the Markdown package and updated.
// ignore: implementation_imports
import 'package:markdown/src/util.dart' as unsafe_md_util;

/// Parses preformatted code blocks between two ``` sequences.
class CustomFencedCodeBlockSyntax extends BlockSyntax {
  const CustomFencedCodeBlockSyntax();

  @override
  RegExp get pattern => _codeFencePattern;

  @override
  Node parse(BlockParser parser) {
    final openingFence = _FenceMatch.fromMatch(
      pattern.firstMatch(
        unsafe_md_util.escapePunctuation(parser.current.content),
      )!,
    );

    var text = parseChildLines(
      parser,
      openingFence.marker,
      openingFence.indent,
    ).map((e) => e.content).join('\n');

    if (parser.document.encodeHtml) {
      text = unsafe_md_util.escapeHtml(text, escapeApos: false);
    }
    if (text.isNotEmpty) {
      text = '$text\n';
    }

    final code = Element.text('code', text);
    if (openingFence.hasLanguage) {
      var language = unsafe_md_util.decodeHtmlCharacters(openingFence.language);
      if (parser.document.encodeHtml) {
        language = unsafe_md_util.escapeHtmlAttribute(language);
      }
      code.attributes['class'] = 'language-$language';
    }
    if (openingFence.hasMetadata) {
      final metadata = unsafe_md_util.decodeHtmlCharacters(
        openingFence.metadata.join(' '),
      );
      code.attributes['data-meta'] = metadata;
    }

    return Element('pre', [code]);
  }

  String _removeIndentation(String content, int length) {
    final text = content.replaceFirst(RegExp('^\\s{0,$length}'), '');
    return content.substring(content.length - text.length);
  }

  @override
  List<Line> parseChildLines(
    BlockParser parser, [
    String openingMarker = '',
    int indent = 0,
  ]) {
    final childLines = <Line>[];

    parser.advance();

    _FenceMatch? closingFence;
    while (!parser.isDone) {
      final match = pattern.firstMatch(parser.current.content);
      closingFence = match == null ? null : _FenceMatch.fromMatch(match);

      // Closing code fences can't have info strings:
      // https://spec.commonmark.org/0.30/#example-147
      if (closingFence == null ||
          !closingFence.marker.startsWith(openingMarker) ||
          closingFence.hasInfo) {
        childLines.add(
          Line(_removeIndentation(parser.current.content, indent)),
        );
        parser.advance();
      } else {
        parser.advance();
        break;
      }
    }

    // https://spec.commonmark.org/0.30/#example-127
    // https://spec.commonmark.org/0.30/#example-128
    if (closingFence == null &&
        childLines.isNotEmpty &&
        childLines.last.isBlankLine) {
      childLines.removeLast();
    }

    return childLines;
  }
}

class _FenceMatch {
  _FenceMatch._({
    required this.indent,
    required this.marker,
    required this.info,
  });

  factory _FenceMatch.fromMatch(RegExpMatch match) {
    final marker = match.namedGroup('backtick')!;
    final info = match.namedGroup('backtickInfo')!;

    return _FenceMatch._(
      indent: match[1]!.length,
      marker: marker,
      info: info.trim(),
    );
  }

  final int indent;
  final String marker;

  final String info;

  late final List<String> _splitInfo = info.split(' ');

  String get language => _splitInfo.first;

  bool get hasMetadata => _splitInfo.length > 1;

  List<String> get metadata => hasMetadata ? _splitInfo.sublist(1) : [];

  bool get hasInfo => info.isNotEmpty;

  bool get hasLanguage => language.isNotEmpty;
}

final _codeFencePattern = RegExp(
  r'^(\s{0,3})(?<backtick>`{3,})(?<backtickInfo>[^`]*)$',
);
