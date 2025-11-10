// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../util.dart';
import 'client/copy_button.dart';

/// A rendered code block with support for syntax highlighting,
/// line highlighting, filenames, language specifying,
/// line numbers, and more.
final class WrappedCodeBlock extends StatelessComponent {
  const WrappedCodeBlock({
    super.key,
    required this.content,
    required this.language,
    this.title,
    this.highlightLines = const {},
    this.addedLines = const {},
    this.removedLines = const {},
    this.languagesToHide = const {'plaintext', 'console'},
    this.tag,
    this.initialLineNumber = 1,
    this.showLineNumbers = false,
    this.textToCopy,
  });

  final List<List<Component>> content;
  final String? textToCopy;

  final String language;
  final String? title;

  final Set<int> highlightLines;
  final Set<int> addedLines;
  final Set<int> removedLines;
  final Set<String> languagesToHide;
  final CodeBlockTag? tag;
  final int initialLineNumber;

  final bool showLineNumbers;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'code-block-wrapper language-$language',
      [
        if (title case final title?)
          div(
            classes: 'code-block-header',
            [text(title)],
          ),
        div(
          classes: [
            'code-block-body',
            if (tag case final codeTag?) ...['has-tag', codeTag.parentClass],
          ].toClasses,
          [
            if (tag case final codeTag?)
              span(
                classes: 'code-block-tag',
                [text(codeTag.spanContent)],
              ),
            if (!languagesToHide.contains(language))
              span(
                classes: 'code-block-language',
                attributes: {'title': 'Language $language'},
                [text(language)],
              ),
            pre(
              classes: [
                if (showLineNumbers) 'show-line-numbers',
                'opal',
              ].toClasses,
              attributes: {'tabindex': '0'},
              [
                code(
                  [
                    for (
                      var lineIndex = 0;
                      lineIndex < content.length;
                      lineIndex += 1
                    )
                      span(
                        classes: [
                          'line',
                          if (highlightLines.contains(lineIndex + 1))
                            'highlighted-line',
                          if (removedLines.contains(lineIndex + 1))
                            'removed-line',
                          if (addedLines.contains(lineIndex + 1)) 'added-line',
                        ].toClasses,
                        attributes: {
                          if (showLineNumbers)
                            'data-line': '${initialLineNumber + lineIndex}',
                        },
                        [
                          switch (content[lineIndex]) {
                            // Add a zero-width space when empty
                            // so that the line isn't collapsed to 0 height.
                            final line when line.isEmpty => span(
                              styles: const Styles(
                                userSelect: UserSelect.none,
                              ),
                              [text('\u200b')],
                            ),
                            final lineSpans => span(lineSpans),
                          },
                          text('\n'),
                        ],
                      ),
                  ],
                ),
              ],
            ),
            if (textToCopy case final textToCopy?)
              CopyButton(
                toCopy: textToCopy,
                title: 'Copy code to clipboard',
              ),
          ],
        ),
      ],
    );
  }
}

/// A tag that can be applied to a code block.
enum CodeBlockTag {
  good('good', parentClass: 'tag-good'),
  bad('bad', parentClass: 'tag-bad'),
  passesStaticAnalysis('static analysis: success', parentClass: 'passes-sa'),
  failsStaticAnalysis('static analysis: failure', parentClass: 'fails-sa'),
  runtimeSuccess('runtime: success', parentClass: 'runtime-success'),
  runtimeFailure('runtime: failure', parentClass: 'runtime-fail');

  const CodeBlockTag(this.spanContent, {required this.parentClass});

  final String spanContent;
  final String parentClass;

  static CodeBlockTag parse(String tag) => switch (tag) {
    'good' => good,
    'bad' => bad,
    'passes-sa' => passesStaticAnalysis,
    'fails-sa' => failsStaticAnalysis,
    'runtime-success' => runtimeSuccess,
    'runtime-fail' => runtimeFailure,
    _ => throw ArgumentError('Unknown tag for code blocks: $tag'),
  };
}
