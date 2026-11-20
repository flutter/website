// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:convert';

import 'package:flutter_website/main.server.options.dart';
import 'package:flutter_website/src/components/sections/newsletter_section.dart';
import 'package:flutter_website/src/utils/scroll_spy.dart';
import 'package:jaspr/server.dart';
import 'package:site_shared/components/common/wrapped_code_block.dart';
import 'package:site_shared/src/extensions/code_block_processor.dart';
import 'package:site_shared/src/utils/html_code_block_copy.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    if (!Jaspr.isInitialized) {
      Jaspr.initializeApp(options: defaultServerOptions);
    }
  });

  group('CodeBlockCopyButton server rendering & stripping invariants', () {
    test(
      'renders static copy button without client island markers and marks prompts/folds aria-hidden',
      () async {
        final highlighted = CodeBlockProcessor.highlightCode(
          const [
            CodeLine(content: r'$ flutter pub get', highlights: []),
            CodeLine(content: '', highlights: []),
            CodeLine(content: 'void main() {', highlights: []),
            CodeLine(content: '  print("hi");', highlights: []),
            CodeLine(content: '}', highlights: []),
          ],
          language: 'console',
        );

        final rendered = await renderComponent(
          WrappedCodeBlock(
            content: highlighted,
            language: 'console',
            foldingRanges: const [(start: 3, end: 5, level: 0, open: false)],
          ),
        );
        final renderedHtml = utf8.decode(rendered.body);

        // No @client island marker should be emitted for copy_button.
        expect(renderedHtml, isNot(contains('copy_button')));

        final inspected = inspectRenderedCodeBlockCopyButton(renderedHtml);
        expect(inspected, isNotNull);
        expect(inspected!.type, 'button');
        expect(inspected.title, 'Copy code to clipboard');
        expect(inspected.ariaLabel, 'Copy code to clipboard');
        expect(
          inspected.classes,
          containsAll(['text-button', 'icon-button', 'copy-button']),
        );
        expect(
          inspected.copiedText,
          'flutter pub get\n\nvoid main() {\n  print("hi");\n}\n',
        );
      },
    );
  });

  group('NewsletterSection lazy reCAPTCHA loading', () {
    test(
      'omits synchronous recaptcha/api.js script from initial HTML',
      () async {
        final rendered = await renderComponent(const NewsletterSection());
        final renderedHtml = utf8.decode(rendered.body);

        expect(renderedHtml, contains('id="newsletter"'));
        expect(renderedHtml, isNot(contains('recaptcha/api.js')));
      },
    );
  });

  group('ScrollNotifier coalescing and short-circuiting', () {
    test('notifies listeners only when active scroll IDs actually change', () {
      final notifier = ScrollNotifier();
      var notifications = 0;
      notifier.addListener(() => notifications += 1);

      final thresholds = <(int, ScrollId?)>[
        (100, ScrollId.inHero),
        (300, ScrollId.inContent),
      ];

      // Below all thresholds: zero state changes, zero notifications.
      notifier.applyThresholds(50, thresholds);
      expect(notifier.activeIds, isEmpty);
      expect(notifications, 0);

      // Crossing both thresholds in one frame batches into a single notification.
      notifier.applyThresholds(350, thresholds);
      expect(
        notifier.activeIds,
        unorderedEquals([ScrollId.inHero, ScrollId.inContent]),
      );
      expect(notifications, 1);

      // Scrolling further without changing active state does not notify again.
      notifier.applyThresholds(500, thresholds);
      expect(notifications, 1);

      // Scrolling back above the second threshold notifies once.
      notifier.applyThresholds(200, thresholds);
      expect(notifier.activeIds, unorderedEquals([ScrollId.inHero]));
      expect(notifications, 2);
    });
  });
}
