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
      expect(
        cleanCopiedCodeText(r'$ dart pub get', isShell: true),
        'dart pub get',
      );
      expect(
        cleanCopiedCodeText('  \$\tflutter run', isShell: true),
        'flutter run',
      );
    });

    test('strips Windows PowerShell prompt prefix', () {
      expect(
        cleanCopiedCodeText(r'PS C:\Users\dev> dart test', isShell: true),
        'dart test',
      );
      expect(
        cleanCopiedCodeText(r'C:\Users\dev> dart test', isShell: true),
        'dart test',
      );
      expect(
        cleanCopiedCodeText(
          r'C:\Users\dev> dart test > output.txt',
          isShell: true,
        ),
        'dart test > output.txt',
      );
      expect(
        cleanCopiedCodeText(r'PS D:\work> flutter run', isShell: true),
        'flutter run',
      );
      expect(cleanCopiedCodeText(r'C:\> dir', isShell: true), 'dir');
    });

    test('preserves Windows path commands with output redirection', () {
      const command = r'C:\src\flutter\bin\flutter doctor -v > doctor.txt';
      expect(cleanCopiedCodeText(command, isShell: true), command);
    });

    test('preserves shell variables at the start and middle of a line', () {
      const source =
          r'$HOME/.pub-cache/bin'
          '\n'
          r'echo $HOME';
      expect(cleanCopiedCodeText(source, isShell: true), source);
    });

    test('strips prompts on multiline input', () {
      final input = '''
\$ dart pub get

\$ dart test
''';
      expect(cleanCopiedCodeText(input, isShell: true), '''
dart pub get

dart test
''');
    });
  });
}
