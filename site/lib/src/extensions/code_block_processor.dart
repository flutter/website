// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert' show LineSplitter;

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart' as jaspr;
import 'package:jaspr_content/jaspr_content.dart';
import 'package:meta/meta.dart';
import 'package:opal/opal.dart' as opal;

import '../components/common/wrapped_code_block.dart';
import '../components/dartpad/dartpad_injector.dart';
import '../highlight/theme/dark.dart';
import '../highlight/theme/light.dart';
import '../highlight/token_renderer.dart' as highlighter;

final class CodeBlockProcessor implements PageExtension {
  static final opal.LanguageRegistry _languageRegistry =
      opal.LanguageRegistry.withDefaults();

  const CodeBlockProcessor();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    return _processNodes(nodes);
  }

  List<Node> _processNodes(List<Node> nodes) {
    return [for (final node in nodes) _processNode(node)];
  }

  Node _processNode(Node node) {
    if (node is! ElementNode) return node;

    if (node.tag.toLowerCase() == 'pre') {
      final children = node.children;
      if (children != null && children.isNotEmpty) {
        final firstChild = children.first;
        if (firstChild is ElementNode && firstChild.tag == 'code') {
          final lines = _extractContent(firstChild);
          final language = _extractLanguage(
            firstChild.attributes['class'] ?? '',
          );

          final rawMetadata = firstChild.attributes.remove('data-meta');
          final metadata = rawMetadata != null
              ? _parseAttributes(rawMetadata)
              : const <String, String?>{};
          final title = metadata['title'];

          if (language == 'dartpad') {
            return ComponentNode(
              DartPadWrapper(
                content: lines.join('\n'),
                title: title ?? 'Runnable Flutter example',
                theme: metadata['theme'],
                height: metadata['height'],
                runAutomatically: metadata['run'] == 'true',
              ),
            );
          }

          final tag = metadata['tag'];

          final rawHighlightLines = metadata['highlightLines'];
          final skipHighlighting = metadata.containsKey('noHighlight');

          var showLineNumbers = false;
          int? initialLineNumber;
          if (metadata.containsKey('showLineNumbers')) {
            showLineNumbers = true;

            final rawShowLineNumbers = metadata['showLineNumbers'];
            if (rawShowLineNumbers != null) {
              initialLineNumber = int.tryParse(rawShowLineNumbers);
            } else {
              initialLineNumber = 1;
            }
          }

          final isDiff = metadata.containsKey('diff');
          if (isDiff && showLineNumbers) {
            throw ArgumentError(
              'showLineNumbers and diff are not supported on the same '
              'code block yet.',
            );
          }

          final diffResult = isDiff ? _processDiffLines(lines) : null;
          final linesWithDiffRemoved = diffResult?.lines ?? lines;
          final addedLines = diffResult?.addedLines ?? const <int>{};
          final removedLines = diffResult?.removedLines ?? const <int>{};

          final codeLines = _removeHighlights(
            linesWithDiffRemoved,
            skipHighlighting,
          );
          final processedContent = _highlightCode(
            codeLines,
            language: language,
            skipSyntaxHighlighting: skipHighlighting,
          );

          return ComponentNode(
            WrappedCodeBlock(
              content: processedContent,
              textToCopy: codeLines.copyContent,
              language: language,
              languagesToHide: const {
                'plaintext',
                'text',
                'console',
                'ps',
                'diff',
              },
              title: title,
              highlightLines: _parseNumbersAndRanges(rawHighlightLines),
              addedLines: addedLines,
              removedLines: removedLines,
              tag: tag != null ? CodeBlockTag.parse(tag) : null,
              initialLineNumber: initialLineNumber ?? 1,
              showLineNumbers: showLineNumbers,
            ),
          );
        }
      }
    }

    final nodeChildren = node.children;
    return ElementNode(
      node.tag,
      node.attributes,
      nodeChildren != null ? _processNodes(nodeChildren) : null,
    );
  }

  List<List<jaspr.Component>> _highlightCode(
    List<_CodeLine> codeLines, {
    required String language,
    bool skipSyntaxHighlighting = false,
  }) {
    final content = codeLines.map((line) => line.content).toList();
    final languageHighlighter = switch (_languageRegistry[language]) {
      final highlighter? when !skipSyntaxHighlighting => highlighter,
      _ => opal.BuiltInLanguages.text,
    };
    final highlightedSpans = languageHighlighter.tokenize(content);
    final renderedSpans = highlighter.ThemedSpanRenderer(
      themeByName: {
        'light': highlighter.SyntaxHighlightingTheme(dashLightTheme),
        'dark': highlighter.SyntaxHighlightingTheme(dashDarkTheme),
      },
    ).render(highlightedSpans);

    return [
      for (var i = 0; i < renderedSpans.length; i++)
        _processLine(renderedSpans[i], codeLines[i].highlights),
    ];
  }

  List<jaspr.Component> _processLine(
    List<highlighter.ThemedSpan> spans,
    List<({int startColumn, int length})> highlights,
  ) {
    if (highlights.isEmpty) {
      return spans.map(_createSpan).toList(growable: false);
    }

    final processedSpans = <jaspr.Component>[];
    var currentColumn = 0;

    for (final span in spans) {
      final spanEnd = currentColumn + span.content.length;
      final intersecting = _findIntersectingHighlights(
        highlights,
        currentColumn,
        spanEnd,
      );

      if (intersecting.isEmpty) {
        processedSpans.add(_createSpan(span));
      } else {
        processedSpans.addAll(
          _splitSpanByHighlights(span, intersecting, currentColumn),
        );
      }
      currentColumn = spanEnd;
    }

    return processedSpans;
  }

  List<({int startColumn, int length})> _findIntersectingHighlights(
    List<({int startColumn, int length})> highlights,
    int spanStart,
    int spanEnd,
  ) => highlights
      .where((h) {
        final highlightEnd = h.startColumn + h.length;
        return !(spanStart >= highlightEnd || spanEnd <= h.startColumn);
      })
      .sorted((a, b) => a.startColumn.compareTo(b.startColumn));

  List<jaspr.Component> _splitSpanByHighlights(
    highlighter.ThemedSpan span,
    List<({int startColumn, int length})> highlights,
    int spanStart,
  ) {
    final result = <jaspr.Component>[];
    final spanLength = span.content.length;
    var processedStart = 0;

    for (final highlight in highlights) {
      final highlightEnd = highlight.startColumn + highlight.length;
      final startInSpan = (highlight.startColumn - spanStart).clamp(
        0,
        spanLength,
      );
      final endInSpan = (highlightEnd - spanStart).clamp(0, spanLength);

      // Add non-highlighted portion before the highlight.
      if (processedStart < startInSpan) {
        result.add(
          _createSpan(
            span,
            content: span.content.substring(processedStart, startInSpan),
          ),
        );
      }

      // Add highlighted portion.
      if (startInSpan < endInSpan) {
        result.add(
          jaspr.Component.element(
            tag: 'mark',
            attributes: const {'class': 'highlight'},
            children: [
              _createSpan(
                span,
                content: span.content.substring(startInSpan, endInSpan),
              ),
            ],
          ),
        );
        processedStart = endInSpan;
      }
    }

    // Add remaining non-highlighted portion.
    if (processedStart < spanLength) {
      result.add(
        _createSpan(
          span,
          content: span.content.substring(processedStart),
        ),
      );
    }

    return result;
  }

  jaspr.Component _createSpan(
    highlighter.ThemedSpan span, {
    String? content,
  }) {
    return jaspr.span(
      [jaspr.text(content ?? span.content)],
      attributes: {
        'style': ?span.toInlineStyle(defaultTheme: 'light'),
      },
    );
  }

  String _extractLanguage(String className) {
    final match = RegExp(r'language-(\w+)').firstMatch(className);
    return match?.group(1)?.toLowerCase() ?? 'plaintext';
  }

  List<String> _extractContent(Node node) {
    // Remove trailing empty spaces and new lines.
    final text = node.innerText.trimRight();

    return const LineSplitter()
        .convert(text)
        .map((l) => l.trimRight())
        .toList(growable: false);
  }

  List<_CodeLine> _removeHighlights(
    List<String> lines, [
    bool skipHighlighting = false,
  ]) {
    if (skipHighlighting) {
      return lines
          .map((line) => _CodeLine(content: line, highlights: const []))
          .toList(growable: false);
    }

    final lineHighlights = <int, List<({int startColumn, int length})>>{};
    ({int startLine, int startColumn})? currentHighlight;

    final processedLines = <String>[];

    for (var lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      final line = lines[lineIndex];
      if (line.trim().isEmpty) {
        // Empty lines should still be a part of the output.
        processedLines.add('');
        continue;
      }

      final processedLine = StringBuffer();
      var i = 0;

      while (i < line.length) {
        // Check for the opening marker [!.
        if (i + 1 < line.length && line[i] == '[' && line[i + 1] == '!') {
          if (currentHighlight != null) {
            throw ArgumentError(
              'Opening highlight marker "[!" found at '
              'line ${lineIndex + 1}, column ${i + 1} while '
              'previous highlight at line ${currentHighlight.startLine + 1}, '
              'column ${currentHighlight.startColumn + 1} is not closed',
            );
          }
          currentHighlight = (
            startLine: lineIndex,
            startColumn: processedLine.length,
          );

          // Skip past the [! marker in the line.
          i += 2;
          continue;
        }

        // If there's an open highlight span, check for the closing marker !].
        if (currentHighlight != null &&
            i + 1 < line.length &&
            line[i] == '!' &&
            line[i + 1] == ']') {
          if (currentHighlight.startLine == lineIndex) {
            // If the highlight span is opened and closed in the same line.
            lineHighlights.putIfAbsent(lineIndex, () => []).add((
              startColumn: currentHighlight.startColumn,
              length: processedLine.length - currentHighlight.startColumn,
            ));
          } else {
            // If the highlight span is opened then closed in separate lines.

            // Add the highlight range for the line the span is opened in.
            lineHighlights
                .putIfAbsent(currentHighlight.startLine, () => [])
                .add((
                  startColumn: currentHighlight.startColumn,
                  length:
                      processedLines[currentHighlight.startLine].length -
                      currentHighlight.startColumn,
                ));

            // Add the highlight range for the lines completely included.
            for (var j = currentHighlight.startLine + 1; j < lineIndex; j++) {
              lineHighlights.putIfAbsent(j, () => []).add((
                startColumn: 0,
                length: processedLines[j].length,
              ));
            }

            // Add the highlight range for the line the span is closed in.
            lineHighlights.putIfAbsent(lineIndex, () => []).add((
              startColumn: 0,
              length: processedLine.length,
            ));
          }

          currentHighlight = null;

          // Skip past the !] marker in the line.
          i += 2;
          continue;
        }

        processedLine.write(line[i]);
        i++;
      }

      processedLines.add(processedLine.toString());
    }

    // Check if a highlight span was never closed.
    if (currentHighlight != null) {
      throw ArgumentError(
        'Unclosed highlight marker starting at '
        'line ${currentHighlight.startLine + 1}, '
        'column ${currentHighlight.startColumn + 1}',
      );
    }

    return [
      for (var i = 0; i < processedLines.length; i++)
        _CodeLine(
          content: processedLines[i],
          highlights: lineHighlights[i] ?? [],
        ),
    ];
  }

  /// Processes lines for diff mode, extracting added/removed line markers.
  ///
  /// Lines starting with '+' are marked as added lines.
  /// Lines starting with '-' are marked as removed lines.
  /// The first two characters (marker and space) are removed from each line.
  ({
    List<String> lines,
    Set<int> addedLines,
    Set<int> removedLines,
  })
  _processDiffLines(List<String> lines) {
    final addedLines = <int>{};
    final removedLines = <int>{};
    final processedLines = <String>[];

    for (var lineIndex = 0; lineIndex < lines.length; lineIndex += 1) {
      final line = lines[lineIndex];

      switch (line.isNotEmpty ? line[0] : '') {
        case '+':
          addedLines.add(lineIndex + 1);
        case '-':
          removedLines.add(lineIndex + 1);
      }

      // Remove the first 2 characters (marker and space).
      processedLines.add(line.length >= 2 ? line.substring(2) : '');
    }

    return (
      lines: processedLines,
      addedLines: addedLines,
      removedLines: removedLines,
    );
  }
}

@immutable
final class _CodeLine {
  final String content;
  final List<({int startColumn, int length})> highlights;

  const _CodeLine({required this.content, required this.highlights});
}

extension on List<_CodeLine> {
  static final RegExp _terminalReplacementPattern = RegExp(
    r'^(\s*\$\s*)|(PS\s+)?(C:\\(.*)>\s*)',
    multiLine: true,
  );
  static final RegExp _zeroWidthSpaceReplacementPattern = RegExp(r'\u200B');

  String get copyContent => map((line) => line.content)
      .join('\n')
      .replaceAll(_terminalReplacementPattern, '')
      .replaceAll(_zeroWidthSpaceReplacementPattern, '');
}

/// Parses a comma-separated list of numbers and ranges into a set of numbers.
///
/// Returns all unique numbers specified in the input.
Set<int> _parseNumbersAndRanges(String? input) {
  if (input == null) return const {};
  final elements = input.trim().split(',');
  if (elements.isEmpty) return const {};

  final combinedNumbers = <int>{};

  for (final element in elements) {
    final rangeParts = element.split('-');

    // If it includes a dash, it is (hopefully) a range between two numbers.
    if (rangeParts.length > 1) {
      // Split by the dash, and turn each string into a number.
      // Assume the user only included one dash.
      final start = int.tryParse(rangeParts[0].trim());
      final end = int.tryParse(rangeParts[1].trim());

      if (start != null && end != null) {
        for (var i = start; i <= end; i++) {
          combinedNumbers.add(i);
        }
      }
    } else {
      // It's (hopefully) just a single number.
      final number = int.tryParse(element.trim());
      if (number != null) {
        combinedNumbers.add(number);
      }
    }
  }

  return combinedNumbers;
}

/// Matches a key-value attribute pair, similar to HTML elements.
///
/// Group 1: The attribute key.
/// Group 2: The value if quoted and present.
/// Group 3: The value if unquoted and present.
final RegExp _attributeRegex = RegExp(r'(\w+)(?:=(?:"([^"]*)"|(\S+)))?');

Map<String, String?> _parseAttributes(String input) {
  final matches = _attributeRegex.allMatches(input);

  return {
    for (final match in matches)
      match.group(1)!: match.group(2) ?? match.group(3),
  };
}

extension ThemedSpanToHtml on highlighter.ThemedSpan {
  String? toInlineStyle({String? defaultTheme}) {
    final buffer = StringBuffer();

    for (final MapEntry(key: themeName, value: style) in styleByTheme.entries) {
      final isDefault = themeName == defaultTheme;

      if (style.foregroundColor case final fgColor?) {
        if (isDefault) {
          buffer.write('color: rgba(');
          buffer.write((fgColor.red * 255).round());
          buffer.write(', ');
          buffer.write((fgColor.green * 255).round());
          buffer.write(', ');
          buffer.write((fgColor.blue * 255).round());
          buffer.write(', ');
          buffer.write(fgColor.alpha);
          buffer.write('); ');
        } else {
          buffer.write('--opal-$themeName-color: rgba(');
          buffer.write((fgColor.red * 255).round());
          buffer.write(', ');
          buffer.write((fgColor.green * 255).round());
          buffer.write(', ');
          buffer.write((fgColor.blue * 255).round());
          buffer.write(', ');
          buffer.write(fgColor.alpha);
          buffer.write('); ');
        }
      }

      if (style.fontStyle case final fontStyle?) {
        final fontStyleValue = switch (fontStyle) {
          highlighter.FontStyle.italic => 'italic',
          highlighter.FontStyle.normal => 'normal',
        };

        if (isDefault) {
          buffer.write('font-style: $fontStyleValue; ');
        } else {
          buffer.write('--opal-$themeName-font-style: $fontStyleValue; ');
        }
      }

      if (style.fontWeight case final fontWeight?) {
        if (isDefault) {
          buffer.write('font-weight: ${fontWeight.weight}; ');
        } else {
          buffer.write('--opal-$themeName-font-weight: ${fontWeight.weight}; ');
        }
      }
    }

    final resultingStyle = buffer.toString().trimRight();
    if (resultingStyle.isEmpty) {
      return null;
    }

    return resultingStyle;
  }
}
