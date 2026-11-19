// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../../components/common/code_block_copy_button.dart';

bool _copyDelegationInitialized = false;

/// Extracts copyable source text from the `.code-block-wrapper` enclosing
/// [button], stripping `[aria-hidden="true"]` prompt/fold elements and
/// zero-width spaces.
String? extractCodeBlockText(web.Element button) {
  final codeElement = button
      .closest('.code-block-wrapper')
      ?.querySelector('pre code');
  if (codeElement == null) {
    return null;
  }

  final clone = codeElement.cloneNode(true) as web.Element;
  final hiddenNodes = clone.querySelectorAll('[aria-hidden="true"]');
  for (var i = 0; i < hiddenNodes.length; i += 1) {
    (hiddenNodes.item(i) as web.Element).remove();
  }

  final text = clone.textContent;
  return text == null ? null : cleanCopiedCodeText(text);
}

/// Registers a single delegated document click listener for all buttons marked
/// with [codeBlockCopyAttribute].
void setUpCodeBlockCopyButtons() {
  if (_copyDelegationInitialized) {
    return;
  }
  _copyDelegationInitialized = true;

  final pendingResets = <web.Element, _PendingCopyReset>{};

  @awaitNotRequired
  Future<void> handleCopy(web.Element button, String toCopy) async {
    var feedbackLabel = 'Copied!';
    try {
      await web.window.navigator.clipboard.writeText(toCopy).toDart;
    } on Object {
      feedbackLabel = 'Failed to copy';
    }

    final existing = pendingResets.remove(button);
    existing?.timer.cancel();

    final originalTitle = existing?.title ?? button.getAttribute('title');
    final originalAriaLabel =
        existing?.ariaLabel ?? button.getAttribute('aria-label');
    final wasIconButton =
        existing?.wasIconButton ?? button.classList.contains('icon-button');

    existing?.feedbackNode.remove();
    final feedbackNode = web.document.createElement('span')
      ..className = 'copy-feedback'
      ..textContent = feedbackLabel;

    if (wasIconButton) {
      button.classList.remove('icon-button');
    }
    button
      ..appendChild(feedbackNode)
      ..setAttribute('title', feedbackLabel)
      ..setAttribute('aria-label', feedbackLabel);

    pendingResets[button] = _PendingCopyReset(
      title: originalTitle,
      ariaLabel: originalAriaLabel,
      wasIconButton: wasIconButton,
      feedbackNode: feedbackNode,
      timer: Timer(const Duration(seconds: 2), () {
        pendingResets.remove(button);
        feedbackNode.remove();
        if (wasIconButton) {
          button.classList.add('icon-button');
        }
        _restoreAttribute(button, 'title', originalTitle);
        _restoreAttribute(button, 'aria-label', originalAriaLabel);
      }),
    );
  }

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

      handleCopy(button, toCopy);
    }).toJS,
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
    required this.wasIconButton,
    required this.feedbackNode,
    required this.timer,
  });

  final String? title;
  final String? ariaLabel;
  final bool wasIconButton;
  final web.Element feedbackNode;
  final Timer timer;
}
