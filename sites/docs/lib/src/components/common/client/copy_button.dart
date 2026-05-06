// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../button.dart';

@client
class CopyButton extends StatefulComponent {
  const CopyButton({
    this.buttonText,
    this.classes = const [],
    this.title,
  });

  final String? title;
  final String? buttonText;
  final List<String> classes;

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  final buttonKey = GlobalNodeKey<web.HTMLButtonElement>();

  String? content;
  bool _copied = false;

  @override
  void initState() {
    if (kIsWeb) {
      // Extract the code content and unhide the copy button on the client.
      context.binding.addPostFrameCallback(() {
        setState(() {
          final codeElement = buttonKey.currentNode
              ?.closest('.code-block-wrapper')
              ?.querySelector('pre code')
              ?.cloneNode(true);
          if (codeElement == null) return;

          // Filter out hidden elements like the terminal sign or folding icons.
          final iterator = web.document.createNodeIterator(
            codeElement,
            /* NodeFilter.SHOW_ELEMENT */ 1,
          );
          web.Node? currentNode;
          while ((currentNode = iterator.nextNode()) != null) {
            final element = currentNode as web.Element;
            if (element.getAttribute('aria-hidden') == 'true') {
              element.remove();
            }
          }

          // Remove zero-width spaces
          content = codeElement.textContent?.replaceAll('\u200B', '');
        });

        assert(
          content != null,
          'CopyButton: Unable to find code content to copy. '
          'Is the CopyButton inside a code block?',
        );
      });
    }

    super.initState();
  }

  void _copy() {
    if (content == null) {
      return;
    }

    web.window.navigator.clipboard.writeText(content!);

    setState(() => _copied = true);

    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Component build(BuildContext _) {
    final iconButton = component.buttonText == null;

    return Button(
      key: buttonKey,
      style: iconButton ? ButtonStyle.text : ButtonStyle.filled,
      classes: [
        'copy-button',
        if (content == null) 'hidden',
        ...component.classes,
      ],
      title: component.title ?? 'Copy $content to your clipboard.',
      content: _copied ? 'Copied!' : component.buttonText,
      icon: iconButton ? 'content_copy' : null,
      onClick: _copy,
    );
  }
}
