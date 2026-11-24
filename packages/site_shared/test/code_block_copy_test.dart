// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:site_shared/components/common/code_block_copy_button.dart';
import 'package:test/test.dart';

void main() {
  group('cleanCopiedCodeText', () {
    test('removes zero-width spaces', () {
      expect(cleanCopiedCodeText('hello\u200Bworld'), 'helloworld');
    });

    test('strips bash prompt prefix', () {
      expect(cleanCopiedCodeText(r'$ dart pub get'), 'dart pub get');
      expect(cleanCopiedCodeText(r'  $ flutter run'), 'flutter run');
    });

    test('strips Windows PowerShell prompt prefix', () {
      expect(
        cleanCopiedCodeText(r'PS C:\Users\dev> dart test'),
        'dart test',
      );
      expect(
        cleanCopiedCodeText(r'C:\Users\dev> dart test'),
        'dart test',
      );
      expect(
        cleanCopiedCodeText(r'C:\Users\dev> dart test > output.txt'),
        'dart test > output.txt',
      );
    });

    test('does not strip mid-line variables or symbols', () {
      expect(cleanCopiedCodeText(r'echo $HOME'), r'echo $HOME');
    });

    test('strips prompts on multiline input', () {
      final input = '''
\$ dart pub get
\$ dart test
''';
      expect(cleanCopiedCodeText(input), '''
dart pub get
dart test
''');
    });
  });
}
