// Copyright (c) 2023. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:excerpter/excerpter.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  group('Updater setup', _setup);
  group('Default update behavior', _defaultBehavior);
}

void _setup() {
  test('includes default exclusions', () {
    expect(
      Updater(baseSourcePath: 'example', validTargetExtensions: {'.md'})
          .excludePaths
          .any((excludePattern) => excludePattern.hasMatch('.dart_tool')),
      isTrue,
    );
  });

  test('includes default exclusions', () {
    expect(
      Updater(baseSourcePath: 'example', validTargetExtensions: {'.md'})
          .excludePaths
          .any((excludePattern) => excludePattern.hasMatch('.dart_tool')),
      isTrue,
    );
  });
}

void _defaultBehavior() {
  final examplePath = path.join('test_data', 'example');
  final expectedPath = path.join('test_data', 'expected');
  final srcPath = path.join('test_data', 'src');
  final srcCopyPath = path.join('test_data', 'src_copy');

  final updater = Updater(
    baseSourcePath: examplePath,
    validTargetExtensions: {'.md'},
  );

  test('no updates - no errors - no update', () async {
    final results = await updater.update(expectedPath, makeUpdates: false);
    expect(results.warnings, hasLength(0));
    expect(results.errors, hasLength(0));
    expect(results.excerptsNeedingUpdates, equals(0));
    expect(results.excerptsVisited, greaterThan(0));
    expect(results.totalFilesToVisit, equals(4));
    expect(results.filesVisited, equals(4));
    expect(results.madeUpdates, isFalse);
  });

  test('update works', () async {
    copyPathSync(srcPath, srcCopyPath);

    final results = await updater.update(srcCopyPath, makeUpdates: true);
    expect(results.warnings, hasLength(0));
    expect(results.errors, hasLength(0));
    expect(results.excerptsNeedingUpdates, greaterThan(0));
    expect(results.excerptsNeedingUpdates, equals(results.excerptsVisited));
    expect(results.madeUpdates, isTrue);

    for (final expectedFile in Directory(expectedPath).listSync()) {
      if (expectedFile is File) {
        final updatedPath = path.join(
          srcCopyPath,
          path.basename(expectedFile.path),
        );
        final updatedFile = File(updatedPath);
        expect(updatedFile.existsSync(), isTrue);

        expect(
          expectedFile.readAsStringSync(),
          equals(updatedFile.readAsStringSync()),
        );
      }
    }

    Directory(srcCopyPath).deleteSync(recursive: true);
  });
}
