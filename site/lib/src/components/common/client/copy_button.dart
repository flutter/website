// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import 'package:universal_web/web.dart' as web;

import '../button.dart';

@client
class CopyButton extends StatefulComponent {
  const CopyButton({
    required this.toCopy,
    this.buttonText,
    this.classes = const [],
    this.title,
  });

  final String toCopy;
  final String? title;
  final String? buttonText;
  final List<String> classes;

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _hidden = true;
  bool _copied = false;

  @override
  void initState() {
    // Unhide the copy button if successfully initialized on the client.
    if (kIsWeb && component.toCopy.isNotEmpty) {
      _hidden = false;
    }

    super.initState();
  }

  void _copy() {
    web.window.navigator.clipboard.writeText(component.toCopy);

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
      style: iconButton ? ButtonStyle.text : ButtonStyle.filled,
      classes: [
        'copy-button',
        if (_hidden) 'hidden',
        ...component.classes,
      ],
      title: component.title ?? 'Copy ${component.toCopy} to your clipboard.',
      content: _copied ? 'Copied!' : component.buttonText,
      icon: iconButton ? 'content_copy' : null,
      onClick: _copy,
    );
  }
}
