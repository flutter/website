// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:test/test.dart';
import 'package:visual_diff/visual_diff.dart';

void main() {
  group('HeaderMetadata', () {
    test('serializes and deserializes cleanly with JSON', () {
      const meta = HeaderMetadata(
        title: 'Widgets catalog | Flutter',
        canonical: 'https://docs.flutter.dev/ui/widgets',
        meta: {
          'description': 'A catalog of Flutter widgets.',
          'og:title': 'Widgets catalog',
          'og:image': 'https://docs.flutter.dev/image.png',
        },
      );

      final json = meta.toJson();
      final revived = HeaderMetadata.fromJson(json);

      expect(revived.title, equals('Widgets catalog | Flutter'));
      expect(revived.canonical, equals('https://docs.flutter.dev/ui/widgets'));
      expect(
        revived.meta['description'],
        equals('A catalog of Flutter widgets.'),
      );
      expect(revived.meta['og:title'], equals('Widgets catalog'));
      expect(revived, equals(meta));
    });

    test('HeaderDiff reports no diff for identical metadata', () {
      const a = HeaderMetadata(
        title: 'Home',
        canonical: 'https://flutter.dev/',
        meta: {'description': 'Desc'},
      );
      const b = HeaderMetadata(
        title: 'Home',
        canonical: 'https://flutter.dev/',
        meta: {'description': 'Desc'},
      );

      final diff = HeaderDiff.compare(a, b);
      expect(diff.hasDiff, isFalse);
      expect(diff.titleChanged, isFalse);
      expect(diff.canonicalChanged, isFalse);
      expect(diff.metaChanges.isEmpty, isTrue);
    });

    test('HeaderDiff detects title and canonical changes', () {
      const baseline = HeaderMetadata(
        title: 'Old Title',
        canonical: 'https://flutter.dev/old',
      );
      const current = HeaderMetadata(
        title: 'New Title',
        canonical: 'https://flutter.dev/new',
      );

      final diff = HeaderDiff.compare(baseline, current);
      expect(diff.hasDiff, isTrue);
      expect(diff.titleChanged, isTrue);
      expect(diff.baselineTitle, equals('Old Title'));
      expect(diff.currentTitle, equals('New Title'));
      expect(diff.canonicalChanged, isTrue);
      expect(diff.baselineCanonical, equals('https://flutter.dev/old'));
      expect(diff.currentCanonical, equals('https://flutter.dev/new'));
    });

    test('HeaderDiff detects added, removed, and modified meta tags', () {
      const baseline = HeaderMetadata(
        meta: {
          'kept': 'same',
          'modified': 'old-val',
          'removed': 'bye',
        },
      );
      const current = HeaderMetadata(
        meta: {
          'kept': 'same',
          'modified': 'new-val',
          'added': 'hello',
        },
      );

      final diff = HeaderDiff.compare(baseline, current);
      expect(diff.hasDiff, isTrue);
      expect(diff.metaChanges.containsKey('kept'), isFalse);

      expect(
        diff.metaChanges['added']?.type,
        equals(HeaderPropertyChangeType.added),
      );
      expect(diff.metaChanges['added']?.current, equals('hello'));

      expect(
        diff.metaChanges['removed']?.type,
        equals(HeaderPropertyChangeType.removed),
      );
      expect(diff.metaChanges['removed']?.baseline, equals('bye'));

      expect(
        diff.metaChanges['modified']?.type,
        equals(HeaderPropertyChangeType.modified),
      );
      expect(diff.metaChanges['modified']?.baseline, equals('old-val'));
      expect(diff.metaChanges['modified']?.current, equals('new-val'));
    });
  });
}
