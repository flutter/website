// Copyright (c) 2023. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:excerpter/excerpter.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  late Directory temporaryDirectory;
  late Updater updater;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'excerpter-injection-test-',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));

    await File(
      path.join(temporaryDirectory.path, 'source.dart'),
    ).writeAsString('void main() {}\n');

    updater = Updater(
      baseSourcePath: temporaryDirectory.path,
      validTargetExtensions: const {'.md'},
    );
  });

  test('empty excerpt converges after updating', () async {
    final target = await _writeTarget(
      temporaryDirectory,
      '<?code-excerpt "source.dart" take="0"?>\n'
      '```dart\n'
      '\n'
      '```\n',
    );

    final updateResult = await updater.update(target.path);
    expect(updateResult.errors, isEmpty);
    expect(updateResult.excerptsNeedingUpdates, 1);
    expect(
      await target.readAsString(),
      '<?code-excerpt "source.dart" take="0"?>\n'
      '```dart\n'
      '```\n',
    );

    final checkResult = await updater.update(target.path, makeUpdates: false);
    expect(checkResult.errors, isEmpty);
    expect(checkResult.excerptsNeedingUpdates, 0);
  });

  test('empty source file can be excerpted as a whole file', () async {
    await File(
      path.join(temporaryDirectory.path, 'source.dart'),
    ).writeAsString('');
    final target = await _writeTarget(
      temporaryDirectory,
      '<?code-excerpt "source.dart"?>\n'
      '```dart\n'
      'void main() {}\n'
      '```\n',
    );

    final updateResult = await updater.update(target.path);
    expect(updateResult.errors, isEmpty);
    expect(updateResult.excerptsNeedingUpdates, 1);
    expect(
      await target.readAsString(),
      '<?code-excerpt "source.dart"?>\n'
      '```dart\n'
      '```\n',
    );

    final checkResult = await updater.update(target.path, makeUpdates: false);
    expect(checkResult.errors, isEmpty);
    expect(checkResult.excerptsNeedingUpdates, 0);
  });

  test('default transforms run before instruction transforms', () async {
    final updaterWithDefaultTransform = Updater(
      baseSourcePath: temporaryDirectory.path,
      validTargetExtensions: const {'.md'},
      defaultTransforms: [SimpleReplaceTransform('void', 'int')],
    );
    final target = await _writeTarget(
      temporaryDirectory,
      '<?code-excerpt "source.dart" retain="int"?>\n'
      '```dart\n'
      'int main() {}\n'
      '```\n',
    );

    final result = await updaterWithDefaultTransform.update(
      target.path,
      makeUpdates: false,
    );

    expect(result.errors, isEmpty);
    expect(result.excerptsNeedingUpdates, 0);
  });

  test('unclosed code block is reported as an injection error', () async {
    final target = await _writeTarget(
      temporaryDirectory,
      '<?code-excerpt "source.dart"?>\n'
      '```dart\n'
      'void main() {}\n',
    );

    final result = await updater.update(target.path, makeUpdates: false);

    expect(result.errors, hasLength(1));
    expect(result.errors.single, contains('Unclosed or unmatched code block.'));
  });

  for (final (:argument, :description) in [
    (argument: 'skip="not-a-number"', description: 'invalid skip'),
    (argument: 'take="not-a-number"', description: 'invalid take'),
    (argument: 'indent-by="not-a-number"', description: 'invalid indent'),
    (argument: 'retain="/[/"', description: 'invalid pattern'),
    (argument: 'replace="/[/replacement/g;"', description: 'invalid replace'),
  ]) {
    test('$description is reported as an injection error', () async {
      final target = await _writeTarget(
        temporaryDirectory,
        '<?code-excerpt "source.dart" $argument?>\n'
        '```dart\n'
        'void main() {}\n'
        '```\n',
      );

      final result = await updater.update(target.path, makeUpdates: false);

      expect(result.errors, hasLength(1));
    });
  }

  for (final (:argument, :description) in [
    (argument: 'garbage', description: 'bare argument'),
    (argument: 'skip=1', description: 'unquoted value'),
    (argument: 'skip "1"', description: 'missing equals sign'),
    (argument: 'skip="1', description: 'unterminated value'),
    (
      argument: 'skip="1" garbage take="1"',
      description: 'junk between arguments',
    ),
  ]) {
    test('$description is reported as invalid argument syntax', () async {
      final target = await _writeTarget(
        temporaryDirectory,
        '<?code-excerpt "source.dart" $argument?>\n'
        '```dart\n'
        'void main() {}\n'
        '```\n',
      );

      final result = await updater.update(target.path, makeUpdates: false);

      expect(result.errors, hasLength(1));
      expect(result.errors.single, contains('Invalid argument syntax'));
    });
  }

  test('well-formed unsupported argument is reported', () async {
    final target = await _writeTarget(
      temporaryDirectory,
      '<?code-excerpt "source.dart" skpi="1"?>\n'
      '```dart\n'
      'void main() {}\n'
      '```\n',
    );

    final result = await updater.update(target.path, makeUpdates: false);

    expect(result.errors, hasLength(1));
    expect(result.errors.single, contains('unsupported argument'));
  });

  test('valid arguments with whitespace are parsed', () async {
    final target = await _writeTarget(
      temporaryDirectory,
      '<?code-excerpt "source.dart" skip = "0"  take = "1"?>\n'
      '```dart\n'
      'void main() {}\n'
      '```\n',
    );

    final result = await updater.update(target.path, makeUpdates: false);

    expect(result.errors, isEmpty);
    expect(result.excerptsNeedingUpdates, 0);
  });
}

Future<File> _writeTarget(Directory directory, String content) async {
  final target = File(path.join(directory.path, 'target.md'));
  await target.writeAsString(content);
  return target;
}
