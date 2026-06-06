// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:flutter_website/src/utils/countries.dart';
import 'package:test/test.dart';

void main() {
  group('countryNameByCode', () {
    test('contains the expected number of entries', () {
      // If this fails, validate the change is intended,
      // then update the expected count to match.
      const expectedCount = 250;
      expect(countryNameByCode, hasLength(expectedCount));
    });

    test('contains a few common country entries', () {
      expect(countryNameByCode, contains('DE'));
      expect(countryNameByCode, contains('GB'));
      expect(countryNameByCode, contains('IN'));
      expect(countryNameByCode, contains('US'));
    });

    test('uses common name format, not official', () {
      expect(countryNameByCode['US'], equals('United States'));
      expect(
        countryNameByCode['US'],
        isNot(equals('United States of America')),
      );
    });

    test('does not contain non-existent country codes', () {
      expect(countryNameByCode, isNot(contains('ZZ')));
      expect(countryNameByCode, isNot(contains('XX')));
    });
  });
}
