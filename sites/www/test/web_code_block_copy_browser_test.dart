// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('browser')
library;

import 'dart:async';

import 'package:site_shared/components/common/code_block_copy_button.dart';
import 'package:site_shared/web_util.dart';
import 'package:test/test.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

void main() {
  test(
    'extractCodeBlockText strips aria-hidden elements and zero-width spaces',
    () {
      final wrapper = web.document.createElement('div')
        ..className = 'code-block-wrapper'
        ..innerHTML =
            '''
<div class="code-block-body">
  <pre><code><span class="line"><span aria-hidden="true">\$ </span><span>flutter test</span>
</span><span class="line"><span>\u200B</span>
</span><details><summary class="fold-summary"><span class="material-symbols" aria-hidden="true">keyboard_arrow_right</span><span class="line"><span>void main() {}</span>
</span></summary></details></code></pre>
  <button type="button" $codeBlockCopyAttribute=""></button>
</div>
'''
                .toJS;
      _appendToBodyForTest(wrapper);

      final button = wrapper.querySelector('button[$codeBlockCopyAttribute]')!;
      expect(extractCodeBlockText(button), 'flutter test\n\nvoid main() {}\n');
    },
  );

  test(
    'setUpCodeBlockCopyButtons updates icon and text copy buttons cleanly on click',
    () async {
      setUpCodeBlockCopyButtons();

      final wrapper = web.document.createElement('div')
        ..className = 'code-block-wrapper'
        ..innerHTML =
            '''
<div class="code-block-body">
  <pre><code><span>void main() {}</span></code></pre>
  <button type="button" class="text-button icon-button copy-button" title="Copy code to clipboard" aria-label="Copy code to clipboard" $codeBlockCopyAttribute=""><span class="material-symbols" aria-hidden="true">content_copy</span></button>
  <button type="button" class="filled-button copy-button" title="Copy snippet" aria-label="Copy snippet" $codeBlockCopyAttribute="">Copy code</button>
</div>
'''
                .toJS;
      _appendToBodyForTest(wrapper);

      final buttons = wrapper.querySelectorAll(
        'button[$codeBlockCopyAttribute]',
      );
      final iconButton = buttons.item(0) as web.HTMLButtonElement;
      final textButton = buttons.item(1) as web.HTMLButtonElement;

      await _clickAndWaitForAttributeMutation(iconButton);
      expect(iconButton.classList.contains('icon-button'), isFalse);
      expect(
        iconButton.querySelector('.copy-feedback')?.textContent,
        anyOf('Copied!', 'Failed to copy'),
      );

      await _clickAndWaitForAttributeMutation(textButton);
      expect(textButton.textContent, anyOf('Copied!', 'Failed to copy'));
      expect(
        textButton.getAttribute('aria-label'),
        anyOf('Copied!', 'Failed to copy'),
      );

      // Rapid repeat click preserves replacement feedback without concatenation.
      await _clickAndWaitForAttributeMutation(textButton);
      expect(textButton.textContent, anyOf('Copied!', 'Failed to copy'));
    },
  );
}

Future<void> _clickAndWaitForAttributeMutation(
  web.HTMLButtonElement button,
) async {
  final completer = Completer<void>();
  final observer = web.MutationObserver(
    ((JSArray<web.MutationRecord> _, web.MutationObserver obs) {
      obs.disconnect();
      if (!completer.isCompleted) {
        completer.complete();
      }
    }).toJS,
  )..observe(button, web.MutationObserverInit(attributes: true));

  try {
    button.click();
    await completer.future;
  } finally {
    observer.disconnect();
  }
}

void _appendToBodyForTest(web.Element element) {
  web.document.body!.appendChild(element);
  // External JS interop extension-type members cannot be torn off on web/wasm,
  // even though universal_web's VM analyzer stub triggers unnecessary_lambdas.
  // ignore: unnecessary_lambdas
  addTearDown(() => element.remove());
}
