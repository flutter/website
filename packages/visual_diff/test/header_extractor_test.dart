// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('HeaderExtractor', () {
    test('extracts title, canonical, and diverse meta tags correctly', () {
      const html = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Flutter &amp; Dart Docs &#39;Official&#39;</title>
  <link rel="canonical" href="https://docs.flutter.dev/ui/widgets" />
  <meta name="description" content="A comprehensive catalog of widgets &amp; controls.">
  <meta property="og:title" content="Flutter &amp; Dart">
  <meta property="og:image" content="https://flutter.dev/thumb.png">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="robots" content="index, follow">
</head>
<body>
  <h1>Hello</h1>
</body>
</html>
''';

      final meta = extractHeaderMetadataFromHtml(html);
      expect(meta.title, equals("Flutter & Dart Docs 'Official'"));
      expect(meta.canonical, equals('https://docs.flutter.dev/ui/widgets'));
      expect(
        meta.meta['description'],
        equals('A comprehensive catalog of widgets & controls.'),
      );
      expect(meta.meta['og:title'], equals('Flutter & Dart'));
      expect(meta.meta['og:image'], equals('https://flutter.dev/thumb.png'));
      expect(meta.meta['twitter:card'], equals('summary_large_image'));
      expect(meta.meta['robots'], equals('index, follow'));
    });

    test('handles missing or malformed tags gracefully', () {
      const html = '<html><head></head><body>No meta</body></html>';
      final meta = extractHeaderMetadataFromHtml(html);
      expect(meta.title, isEmpty);
      expect(meta.canonical, isNull);
      expect(meta.meta.isEmpty, isTrue);
    });

    test(
      'correctly parses meta content containing apostrophes and newlines',
      () {
        const html = '''
<head>
  <meta name="description" content="ReorderableListView's localized strings are moved from material localizations to widgets localizations.
"/>
</head>
''';
        final meta = extractHeaderMetadataFromHtml(html);
        expect(
          meta.meta['description'],
          equals(
            "ReorderableListView's localized strings are moved from material "
            'localizations to widgets localizations.',
          ),
        );
      },
    );
  });
}
