// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../../components/common/code_block_copy_button.dart';

bool _copyDelegationInitialized = false;
final _pendingResets = <web.Element, _PendingCopyReset>{};

/// Extracts copyable source text from the `.code-block-wrapper` enclosing
/// [button], stripping `[aria-hidden="true"]` prompt/fold elements and
/// zero-width spaces.
String? extractCodeBlockText(web.Element button) {
  final wrapper = button.closest('.code-block-wrapper');
  final codeElement = wrapper?.querySelector('pre code');
  if (wrapper == null || codeElement == null) {
    return null;
  }

  final clone = codeElement.cloneNode(true) as web.Element;
  final hiddenNodes = clone.querySelectorAll('[aria-hidden="true"]');
  for (var i = 0; i < hiddenNodes.length; i += 1) {
    (hiddenNodes.item(i) as web.Element).remove();
  }

  final text = clone.textContent;
  if (text == null) return null;
  return cleanCopiedCodeText(
    text,
    isShell: wrapper.matches(
      '.language-console, .language-bash, .language-sh, .language-shell, '
      '.language-ps, .language-powershell, .language-bat',
    ),
  );
}

/// Registers a single delegated document click listener for all buttons marked
/// with [codeBlockCopyAttribute].
void setUpCodeBlockCopyButtons() {
  if (_copyDelegationInitialized) {
    return;
  }
  _copyDelegationInitialized = true;

  web.document.addEventListener(
    'click',
    ((web.Event event) {
      final target = event.target;
      if (!target.isA<web.Element>()) {
        return;
      }

      final button = (target as web.Element).closest(
        'button[$codeBlockCopyAttribute]',
      );
      if (button == null) {
        return;
      }

      final toCopy = extractCodeBlockText(button);
      if (toCopy == null) {
        return;
      }

      // Clipboard write and transient feedback reset run asynchronously.
      unawaited(_handleCopy(button, toCopy));
    }).toJS,
  );
}

Future<void> _handleCopy(web.Element button, String toCopy) async {
  var feedbackLabel = 'Copied!';
  try {
    await web.window.navigator.clipboard.writeText(toCopy).toDart;
  } on Object {
    feedbackLabel = 'Failed to copy';
  }

  final existing = _pendingResets.remove(button);
  existing?.timer.cancel();

  final originalTitle = existing?.title ?? button.getAttribute('title');
  final originalAriaLabel =
      existing?.ariaLabel ?? button.getAttribute('aria-label');
  final wasIconButton =
      existing?.wasIconButton ?? button.classList.contains('icon-button');
  final originalButtonText =
      existing?.buttonText ?? (wasIconButton ? null : button.textContent);

  existing?.feedbackNode?.remove();
  web.Element? feedbackNode;
  if (wasIconButton) {
    feedbackNode = web.document.createElement('span')
      ..className = 'copy-feedback'
      ..textContent = feedbackLabel;
    button
      ..classList.remove('icon-button')
      ..appendChild(feedbackNode);
  } else {
    button.textContent = feedbackLabel;
  }

  button
    ..setAttribute('title', feedbackLabel)
    ..setAttribute('aria-label', feedbackLabel);

  _pendingResets[button] = _PendingCopyReset(
    title: originalTitle,
    ariaLabel: originalAriaLabel,
    buttonText: originalButtonText,
    wasIconButton: wasIconButton,
    feedbackNode: feedbackNode,
    timer: Timer(const Duration(seconds: 2), () {
      _pendingResets.remove(button);
      if (wasIconButton) {
        feedbackNode?.remove();
        button.classList.add('icon-button');
      } else {
        button.textContent = originalButtonText;
      }
      _restoreAttribute(button, 'title', originalTitle);
      _restoreAttribute(button, 'aria-label', originalAriaLabel);
    }),
  );
}

void _restoreAttribute(web.Element element, String name, String? value) {
  if (value == null) {
    element.removeAttribute(name);
  } else {
    element.setAttribute(name, value);
  }
}

final class _PendingCopyReset {
  const _PendingCopyReset({
    required this.title,
    required this.ariaLabel,
    required this.buttonText,
    required this.wasIconButton,
    required this.feedbackNode,
    required this.timer,
  });

  final String? title;
  final String? ariaLabel;
  final String? buttonText;
  final bool wasIconButton;
  final web.Element? feedbackNode;
  final Timer timer;
}
