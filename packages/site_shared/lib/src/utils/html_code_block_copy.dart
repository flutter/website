// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:html/parser.dart' as html_parser;

import '../../components/common/code_block_copy_button.dart';

/// Parses rendered code-block HTML, validates its static copy button attributes
/// and classes, and returns the extracted copyable code text after stripping
/// `[aria-hidden="true"]` nodes and zero-width spaces.
({
  String? type,
  String? title,
  String? ariaLabel,
  Set<String> classes,
  String? copiedText,
})?
inspectRenderedCodeBlockCopyButton(String renderedHtml) {
  final fragment = html_parser.parseFragment(renderedHtml);
  final button = fragment.querySelector('button[$codeBlockCopyAttribute]');
  if (button == null) {
    return null;
  }

  final codeElement = fragment.querySelector('.code-block-wrapper pre code');
  String? copiedText;
  if (codeElement != null) {
    for (final hidden in codeElement.querySelectorAll('[aria-hidden="true"]')) {
      hidden.remove();
    }
    copiedText = cleanCopiedCodeText(codeElement.text);
  }

  return (
    type: button.attributes['type'],
    title: button.attributes['title'],
    ariaLabel: button.attributes['aria-label'],
    classes: button.classes.toSet(),
    copiedText: copiedText,
  );
}
