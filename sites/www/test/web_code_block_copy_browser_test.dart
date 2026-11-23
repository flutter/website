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

@JS('navigator.clipboard.writeText')
external JSFunction get _writeText;

@JS('navigator.clipboard.writeText')
external set _writeText(JSFunction value);

void main() {
  test(
    'copies clean code and replaces the button label',
    () async {
      setUpCodeBlockCopyButtons();
      const markup =
          '''
<pre><code><span aria-hidden="true">\$ </span>flutter test
\u200B
done</code></pre>
<button $codeBlockCopyAttribute><span>Copy</span></button>
''';
      final wrapper = web.document.createElement('div')
        ..className = 'code-block-wrapper'
        ..innerHTML = markup.toJS;
      web.document.body!.appendChild(wrapper);

      final button = wrapper.querySelector('button')!;
      final feedback = Completer<void>();
      final observer = web.MutationObserver(
        ((JSArray<web.MutationRecord> _, web.MutationObserver observer) {
          observer.disconnect();
          feedback.complete();
        }).toJS,
      );
      observer.observe(
        button,
        web.MutationObserverInit(
          childList: true,
          characterData: true,
          subtree: true,
        ),
      );

      final originalWriteText = _writeText;
      String? copied;
      addTearDown(() {
        observer.disconnect();
        _writeText = originalWriteText;
        wrapper.remove();
      });
      _writeText = ((String text) {
        copied = text;
        return Future<void>.value().toJS;
      }).toJS;

      (button.firstElementChild! as web.HTMLElement).click();
      await feedback.future;

      expect(copied, 'flutter test\n\ndone');
      expect(button.textContent, button.getAttribute('aria-label'));
    },
  );
}
