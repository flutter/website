// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import 'button.dart';

/// HTML data attribute marking server-rendered code-block copy buttons.
const String codeBlockCopyAttribute = 'data-code-copy-button';

final RegExp _terminalReplacementPattern = RegExp(
  r'^[ \t]*(?:\$[ \t]+|(?:PS[ \t]+)?C:\\[^>\r\n]*>[ \t]*)',
  multiLine: true,
);

/// Removes formatting placeholders and, for shell blocks, command prompts.
String cleanCopiedCodeText(String rawText, {bool isShell = false}) {
  final text = isShell
      ? rawText.replaceAll(_terminalReplacementPattern, '')
      : rawText;
  return text.replaceAll('\u200B', '');
}

/// A server-rendered button that copies the contents of its enclosing
/// `.code-block-wrapper` to the user's clipboard.
///
/// Click handling is delegated to a single document-level listener registered
/// by `setUpCodeBlockCopyButtons`, avoiding per-code-block client hydration.
final class CodeBlockCopyButton extends StatelessComponent {
  const CodeBlockCopyButton({
    super.key,
    this.title = 'Copy code to clipboard',
    this.buttonText,
    this.classes = const [],
  });

  /// The tooltip and accessible label of the button.
  final String title;

  /// Optional visible label text; when `null`, renders as an icon button.
  final String? buttonText;

  /// Additional CSS classes applied to the button element.
  final List<String> classes;

  @override
  Component build(BuildContext context) {
    final isIconButton = buttonText == null;

    return Button(
      style: isIconButton ? ButtonStyle.text : ButtonStyle.filled,
      classes: ['copy-button', ...classes],
      title: title,
      content: buttonText,
      icon: isIconButton ? 'content_copy' : null,
      attributes: {
        'type': 'button',
        'aria-label': title,
        codeBlockCopyAttribute: '',
      },
    );
  }
}
