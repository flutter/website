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
  const dartSource = r'''final message = """
  $name
  C:\\src> dart test
""";''';
  for (final (language, markup, expected) in [
    (
      'console',
      '''<span aria-hidden="true">\$ </span>flutter test
\u200B
\$ echo \$HOME
\$HOME/.pub-cache/bin''',
      r'''flutter test

echo $HOME
$HOME/.pub-cache/bin''',
    ),
    ('dart', dartSource, dartSource),
  ]) {
    test('copies $language code and replaces the button label', () async {
      String? copied;
      _writeText = ((String text) {
        copied = text;
        return Future<void>.value().toJS;
      }).toJS;
      setUpCodeBlockCopyButtons();

      final block =
          '''
<pre><code>$markup</code></pre>
<button $codeBlockCopyAttribute><span>Copy</span></button>
''';
      final wrapper = web.document.createElement('div')
        ..className = 'code-block-wrapper language-$language'
        ..innerHTML = block.toJS;
      web.document.body!.appendChild(wrapper);
      addTearDown(() => web.document.body!.removeChild(wrapper));

      final button = wrapper.querySelector('button')!;
      (button.firstElementChild! as web.HTMLElement).click();
      await pumpEventQueue();

      expect(copied, expected);
      expect(button.textContent, button.getAttribute('aria-label'));
    });
  }
}
