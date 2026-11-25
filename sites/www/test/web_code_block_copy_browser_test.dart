// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('browser')
library;

import 'package:site_shared/components/common/code_block_copy_button.dart';
import 'package:site_shared/web_util.dart';
import 'package:test/test.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

@JS('navigator.clipboard.writeText')
external set _writeText(JSFunction value);

void main() {
  test('copies clean code and replaces the button label', () async {
    String? copied;
    _writeText = ((String text) {
      copied = text;
      return Future<void>.value().toJS;
    }).toJS;
    setUpCodeBlockCopyButtons();

    const markup =
        '''
<pre><code><span aria-hidden="true">\$ </span>flutter test
​
done</code></pre>
<button $codeBlockCopyAttribute><span>Copy</span></button>
''';
    final wrapper = web.document.createElement('div')
      ..className = 'code-block-wrapper'
      ..innerHTML = markup.toJS;
    web.document.body!.appendChild(wrapper);

    final button = wrapper.querySelector('button')!;
    (button.firstElementChild! as web.HTMLElement).click();
    await pumpEventQueue();

    expect(copied, 'flutter test\n\ndone');
    expect(button.textContent, button.getAttribute('aria-label'));
  });
}
