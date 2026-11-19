// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/dartpad/dartpad_injector.dart';
import 'package:site_shared/page_extensions.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    if (!Jaspr.isInitialized) {
      Jaspr.initializeApp();
    }
  });

  test(
    'DartPadWrapper renders SSR placeholder pre with pixel height',
    () async {
      final response = await renderComponent(
        DartPadWrapper(
          content: 'void main() {}',
          title: 'Example',
          height: 520,
        ),
        standalone: false,
      );
      final rendered = utf8.decode(response.body);
      expect(rendered, contains('<pre class="embedded-dartpad"'));
      expect(rendered, contains('height: 520px'));
      expect(rendered, contains('<code title="Example">void main() {}</code>'));
    },
  );

  group('CodeBlockProcessor DartPad height', () {
    Future<DartPadWrapper> processDartPad(String metadata) async {
      const processor = CodeBlockProcessor(
        defaultTitle: 'Runnable Flutter example',
      );
      final nodes = await processor.apply(_page('/test'), [
        ElementNode('pre', {}, [
          ElementNode(
            'code',
            {'class': 'language-dartpad', 'data-meta': metadata},
            [const TextNode('void main() {}')],
          ),
        ]),
      ]);
      return (nodes.single as ComponentNode).component as DartPadWrapper;
    }

    test('defaults to 400 pixels when unspecified', () async {
      expect((await processDartPad('title="Example"')).height, 400);
    });

    test(
      'parses positive whole pixel integers and optional px suffix',
      () async {
        expect((await processDartPad('height="520"')).height, 520);
        expect((await processDartPad('height="640px"')).height, 640);
      },
    );

    test('rejects heights that are not positive whole pixels', () async {
      for (final height in [
        '',
        '0',
        '0px',
        '-100',
        '400.5',
        '32rem',
        '50%',
        '1e3',
        'NaN',
        'Infinity',
        '400px; display: none',
      ]) {
        await expectLater(
          processDartPad('height="$height"'),
          throwsArgumentError,
          reason: 'height: "$height"',
        );
      }
    });
  });
}

Page _page(String url) => Page(
  path: '${url.substring(1)}.md',
  url: url,
  content: '',
  initialData: const {
    'page': <String, Object?>{},
    'site': {'url': 'https://docs.flutter.dev', 'title': 'Flutter'},
  },
  config: const PageConfig(),
  loader: MemoryLoader(pages: []),
);
