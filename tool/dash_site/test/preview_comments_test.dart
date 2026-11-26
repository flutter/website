// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dash_site/src/preview_comments.dart';
import 'package:dash_site/src/sites.dart';
import 'package:test/test.dart';

void main() {
  group('PreviewEntry', () {
    test('serializes and deserializes ready status', () {
      const entry = PreviewEntry(
        status: PreviewStatus.ready,
        url: 'https://flutter-docs-prod--pr100.web.app',
        commitSha: '4977bb96d8ac0d94e8954c0682c80adce95b810e',
      );

      final json = entry.toJson();
      expect(PreviewEntry.fromJson(json), equals(entry));
    });

    test('serializes and deserializes pending status without url', () {
      const entry = PreviewEntry(
        status: PreviewStatus.pending,
        commitSha: '4977bb96d8ac0d94e8954c0682c80adce95b810e',
      );

      final json = entry.toJson();
      expect(json.containsKey('url'), isFalse);
      expect(PreviewEntry.fromJson(json), equals(entry));
    });

    test('serializes and deserializes failed status', () {
      const entry = PreviewEntry(
        status: PreviewStatus.failed,
        commitSha: '4977bb96d8ac0d94e8954c0682c80adce95b810e',
      );

      final json = entry.toJson();
      expect(PreviewEntry.fromJson(json), equals(entry));
    });

    test('returns null on invalid JSON', () {
      expect(PreviewEntry.fromJson(null), isNull);
      expect(PreviewEntry.fromJson(<String, Object?>{}), isNull);
      expect(PreviewEntry.fromJson({'status': 'ready'}), isNull);
    });
  });

  group('buildPreviewCommentBody', () {
    test('formats a single pending site table cleanly', () {
      final previews = {
        Site.docs: const PreviewEntry(
          status: PreviewStatus.pending,
          commitSha: '4977bb96d8ac0d94e8954c0682c80adce95b810e',
        ),
      };

      final body = buildPreviewCommentBody(
        previews,
        repoFullName: 'flutter/website',
      );

      expect(body, contains(previewCommentMarker));
      expect(body, contains('<!-- flutter-preview-data: '));
      expect(body, contains('### 🚀 Staged Previews'));
      expect(body, contains('| Site | Status | Preview Link | Commit |'));
      expect(body, contains('**docs.flutter.dev**'));
      expect(body, contains('⏳ Building'));
      expect(body, contains('_Deploying..._'));
      expect(
        body,
        contains(
          '[`4977bb9`](https://github.com/flutter/website/commit/'
          '4977bb96d8ac0d94e8954c0682c80adce95b810e)',
        ),
      );
    });

    test('formats a single ready site table cleanly', () {
      final previews = {
        Site.docs: const PreviewEntry(
          status: PreviewStatus.ready,
          url: 'https://flutter-docs-prod--pr100.web.app',
          commitSha: '4977bb96d8ac0d94e8954c0682c80adce95b810e',
        ),
      };

      final body = buildPreviewCommentBody(previews);

      expect(body, contains('**docs.flutter.dev**'));
      expect(body, contains('✅ Ready'));
      expect(
        body,
        contains('[Visit Preview ↗](https://flutter-docs-prod--pr100.web.app)'),
      );
      expect(body, contains('`4977bb9`'));
    });

    test('formats a failed site table cleanly', () {
      final previews = {
        Site.docs: const PreviewEntry(
          status: PreviewStatus.failed,
          commitSha: '4977bb96d8ac0d94e8954c0682c80adce95b810e',
        ),
      };

      final body = buildPreviewCommentBody(previews);

      expect(body, contains('**docs.flutter.dev**'));
      expect(body, contains('❌ Failed'));
      expect(body, contains('_Failed_'));
    });

    test('formats multiple sites in deterministic order', () {
      // Intentionally insert www before docs:
      final previews = {
        Site.www: const PreviewEntry(
          status: PreviewStatus.pending,
          commitSha: '1111111111111111',
        ),
        Site.docs: const PreviewEntry(
          status: PreviewStatus.ready,
          url: 'https://flutter-docs-prod--pr100.web.app',
          commitSha: '2222222222222222',
        ),
      };

      final body = buildPreviewCommentBody(
        previews,
        repoFullName: 'flutter/website',
      );

      expect(body, contains('### 🚀 Staged Previews'));

      final docsIndex = body.indexOf('**docs.flutter.dev**');
      final wwwIndex = body.indexOf('**flutter.dev**');
      expect(docsIndex, isPositive);
      expect(wwwIndex, isPositive);
      // docs should always precede www according to Site.values order:
      expect(docsIndex, lessThan(wwwIndex));

      expect(body, contains('✅ Ready'));
      expect(body, contains('⏳ Building'));
    });
  });

  group('parsePreviewCommentEntries', () {
    test('round-trips single-site comment', () {
      final original = {
        Site.docs: const PreviewEntry(
          status: PreviewStatus.ready,
          url: 'https://flutter-docs-prod--pr100.web.app',
          commitSha: '4977bb96d8ac0d94e8954c0682c80adce95b810e',
        ),
      };

      final body = buildPreviewCommentBody(original);
      final parsed = parsePreviewCommentEntries(body);

      expect(parsed, equals(original));
    });

    test('round-trips multi-site comment with mixed statuses', () {
      final original = {
        Site.docs: const PreviewEntry(
          status: PreviewStatus.ready,
          url: 'https://flutter-docs-prod--pr100.web.app',
          commitSha: '2222222222222222',
        ),
        Site.www: const PreviewEntry(
          status: PreviewStatus.pending,
          commitSha: '1111111111111111',
        ),
      };

      final body = buildPreviewCommentBody(original);
      final parsed = parsePreviewCommentEntries(body);

      expect(parsed, equals(original));
    });

    test('returns empty map for corrupted JSON metadata', () {
      const corruptBody = '''
<!-- flutter-preview -->
<!-- flutter-preview-data: {not-valid-json} -->
### 🚀 Staged Previews
''';

      expect(parsePreviewCommentEntries(corruptBody), isEmpty);
    });

    test('returns empty map for unrelated comment', () {
      expect(parsePreviewCommentEntries('Hello world! LGTM!'), isEmpty);
    });
  });
}
