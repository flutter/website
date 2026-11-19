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
      web.document.body!.appendChild(wrapper);
      addTearDown(() => wrapper.remove());

      final button = wrapper.querySelector('button[$codeBlockCopyAttribute]')!;
      expect(extractCodeBlockText(button), 'flutter test\n\nvoid main() {}\n');
    },
  );
}
