// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:convert';

import 'package:flutter_website/main.server.options.dart';
import 'package:html/parser.dart' as html;
import 'package:jaspr/server.dart';
import 'package:site_shared/components/common/code_block_copy_button.dart';
import 'package:site_shared/components/common/wrapped_code_block.dart';
import 'package:test/test.dart';

void main() {
  test('code blocks render an accessible copy button on the server', () async {
    Jaspr.initializeApp(options: defaultServerOptions);
    final rendered = await renderComponent(
      const WrappedCodeBlock(
        language: 'console',
        content: [
          [Component.text('flutter test')],
        ],
      ),
    );
    final document = html.parse(utf8.decode(rendered.body));
    final button = document.querySelector('button[$codeBlockCopyAttribute]');

    expect(button?.attributes['aria-label'], isNotEmpty);
    expect(defaultServerOptions.clients, isNot(contains(CodeBlockCopyButton)));
  });
}
