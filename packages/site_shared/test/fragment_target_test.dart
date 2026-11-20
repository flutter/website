// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/components/common/fragment_target.dart';
import 'package:site_shared/markdown.dart';
import 'package:test/test.dart';

Page _testPage(String content) => Page(
  path: 'test.md',
  url: '/test',
  content: content,
  config: const PageConfig(),
  loader: MemoryLoader(pages: const []),
);

void main() {
  group('FragmentTarget.fromAttributes', () {
    test('accepts valid HTML5 IDs', () {
      for (final validId in const [
        'old-section',
        'old_section',
        'step-3.1',
        '2026-schedule',
      ]) {
        expect(
          FragmentTarget.fromAttributes({'id': validId}).id,
          equals(validId),
        );
      }
    });

    test('rejects missing, empty, #-prefixed, or whitespace IDs', () {
      for (final attributes in const <Map<String, String>>[
        {},
        {'id': ''},
        {'id': '#old-id'},
        {'id': 'old id'},
        {'id': 'old\tid'},
      ]) {
        expect(
          () => FragmentTarget.fromAttributes(attributes),
          throwsArgumentError,
          reason: '$attributes',
        );
      }
    });

    test('rejects unexpected attributes', () {
      expect(
        () => FragmentTarget.fromAttributes(const {
          'id': 'old-id',
          'aria-hidden': 'true',
        }),
        throwsArgumentError,
      );
    });
  });

  group('FragmentTargetMarkdownComponent', () {
    const component = FragmentTargetMarkdownComponent();
    const builder = NodesBuilder([component]);

    test('ignores other elements', () {
      expect(
        component.create(const ElementNode('div', {'id': 'x'}, []), builder),
        isNull,
      );
    });

    test('accepts any tag casing and whitespace-only children', () {
      for (final node in const [
        ElementNode('FragmentTarget', {'id': 'legacy-top'}, []),
        ElementNode(
          'fragmenttarget',
          {'id': 'legacy-nested'},
          [
            TextNode('\n'),
          ],
        ),
      ]) {
        expect(
          component.create(node, builder),
          isA<FragmentTarget>().having(
            (target) => target.id,
            'id',
            node.attributes['id'],
          ),
        );
      }
    });

    test('throws ArgumentError on invalid attributes or child content', () {
      for (final node in const [
        ElementNode('FragmentTarget', {'id': '#bad-id'}, []),
        ElementNode(
          'FragmentTarget',
          {'id': 'old-id'},
          [
            TextNode('Unexpected text'),
          ],
        ),
      ]) {
        expect(
          () => component.create(node, builder),
          throwsArgumentError,
          reason: '$node',
        );
      }
    });
  });

  group('DashMarkdownParser with FragmentTarget', () {
    const parser = DashMarkdownParser();

    test(
      'parses stacked FragmentTarget tags without <p> wrapping '
      'or swallowing the heading',
      () {
        final page = _testPage('''
<FragmentTarget id="first-old" />
<FragmentTarget id="second-old" />

## Current heading
''');

        final elements = parser
            .parsePage(page)
            .whereType<ElementNode>()
            .toList();

        expect(
          [
            for (final element in elements)
              (element.tag, element.attributes['id']),
          ],
          equals([
            ('FragmentTarget', 'first-old'),
            ('FragmentTarget', 'second-old'),
            ('h2', 'current-heading'),
          ]),
        );
      },
    );

    test('parses FragmentTarget nested inside an ordered list item', () {
      final page = _testPage('''
 1. First step.

    <FragmentTarget id="nested" />

    Follow-up paragraph.
''');

      final nodes = parser.parsePage(page);
      final ol = nodes.whereType<ElementNode>().single;
      expect(ol.tag, equals('ol'));

      final li = ol.children!.whereType<ElementNode>().single;
      expect(li.tag, equals('li'));

      final liElements = li.children!.whereType<ElementNode>().toList();
      expect(
        liElements.map((e) => e.tag),
        equals(['p', 'FragmentTarget', 'p']),
      );
      expect(liElements[1].attributes, equals({'id': 'nested'}));
    });
  });
}
