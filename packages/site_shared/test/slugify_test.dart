// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:site_shared/util.dart';
import 'package:test/test.dart';

void main() {
  group('slugify', () {
    tearDown(() {
      preserveUnderscoresInSlugify = false;
    });

    test('replaces underscores with hyphens by default', () {
      expect(slugify('Publish_to'), 'publish-to');
      expect(slugify('false_secrets'), 'false-secrets');
      expect(slugify('ignored_advisories'), 'ignored-advisories');
      expect(slugify('trailing_commas'), 'trailing-commas');
      expect(
        slugify('DO name import prefixes using lowercase_with_underscores'),
        'do-name-import-prefixes-using-lowercase-with-underscores',
      );
    });

    test('preserves underscores when preserveUnderscores is true', () {
      expect(slugify('Publish_to', preserveUnderscores: true), 'publish_to');
      expect(
        slugify('false_secrets', preserveUnderscores: true),
        'false_secrets',
      );
      expect(
        slugify('trailing_commas', preserveUnderscores: true),
        'trailing_commas',
      );
      expect(
        slugify(
          'DO name import prefixes using lowercase_with_underscores',
          preserveUnderscores: true,
        ),
        'do-name-import-prefixes-using-lowercase_with_underscores',
      );
      expect(
        slugify(
          'PREFER naming a method to___() '
          "if it copies the object's state to a new object",
          preserveUnderscores: true,
        ),
        'prefer-naming-a-method-to___-'
        'if-it-copies-the-objects-state-to-a-new-object',
      );
    });

    test(
      'preserves underscores when preserveUnderscoresInSlugify global is true',
      () {
        preserveUnderscoresInSlugify = true;

        expect(slugify('Publish_to'), 'publish_to');
        expect(slugify('false_secrets'), 'false_secrets');
        expect(
          slugify('DO name import prefixes using lowercase_with_underscores'),
          'do-name-import-prefixes-using-lowercase_with_underscores',
        );

        // Parameter can still override the global setting.
        expect(slugify('Publish_to', preserveUnderscores: false), 'publish-to');
      },
    );
  });
}
