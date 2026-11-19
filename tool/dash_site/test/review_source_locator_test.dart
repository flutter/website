// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:dash_site/src/review_source_locator.dart';
import 'package:dash_site/src/utils.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  late Directory tempRepo;

  setUp(() {
    tempRepo = Directory.systemTemp.createTempSync('dash_review_locator_test_');
  });

  tearDown(() {
    if (tempRepo.existsSync()) {
      tempRepo.deleteSync(recursive: true);
    }
  });

  File writeRepoFile(String relativePath, String contents) {
    final file = File(
      path.joinAll([tempRepo.path, ...path.posix.split(relativePath)]),
    );
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(contents);
    return file;
  }

  group('locateHighlightInRepo', () {
    test('resolves exact single-line and multi-line matches with snippet', () {
      writeRepoFile('sites/docs/src/content/ui/layout/index.md', '''
---
title: Layouts in Flutter
---

## Introduction

Flutter layouts are built from widgets.
Compose simple widgets to build complex user interfaces
across mobile, web, and desktop screens.
Always test with multiple screen sizes.
''');

      final single = locateHighlightInRepo(
        repoRoot: tempRepo.path,
        site: 'docs',
        sourceFile: 'sites/docs/src/content/ui/layout/index.md',
        selectedText: 'Flutter layouts are built from widgets.',
      );

      expect(single.resolvedFile, 'sites/docs/src/content/ui/layout/index.md');
      expect(single.startLine, 7);
      expect(single.endLine, 7);
      expect(
        single.codeSnippet,
        contains('Flutter layouts are built from widgets.'),
      );

      final multi = locateHighlightInRepo(
        repoRoot: tempRepo.path,
        site: 'docs',
        sourceFile: 'sites/docs/src/content/ui/layout/index.md',
        selectedText:
            'Compose simple widgets to build complex user interfaces\n'
            'across mobile, web, and desktop screens.',
      );

      expect(multi.resolvedFile, 'sites/docs/src/content/ui/layout/index.md');
      expect(multi.startLine, 8);
      expect(multi.endLine, 9);
    });

    test(
      'matches rendered prose across Markdown links, inline code, and bold',
      () {
        writeRepoFile('sites/docs/src/content/ui/layout/row-col.md', '''
---
title: Row and Column
---

To arrange children linearly,
use the [`Row`](/ui/widgets/row) and [`Column`][col-ref] widgets
with **flexible** `Expanded` children and `mainAxisAlignment`
or _cross_ axis properties.

[col-ref]: https://api.flutter.dev/flutter/widgets/Column-class.html
''');

        final located = locateHighlightInRepo(
          repoRoot: tempRepo.path,
          site: 'docs',
          sourceFile: 'sites/docs/src/content/ui/layout/row-col.html',
          selectedText:
              'use the Row and Column widgets with flexible Expanded children '
              'and mainAxisAlignment or cross axis properties.',
        );

        expect(
          located.resolvedFile,
          'sites/docs/src/content/ui/layout/row-col.md',
        );
        expect(located.startLine, 6);
        expect(located.endLine, 8);
        expect(located.codeSnippet, contains('[`Row`](/ui/widgets/row)'));
      },
    );

    test('preserves snake_case identifiers during tolerant matching', () {
      writeRepoFile('sites/docs/src/content/tools/pubspec.md', '''
Configure `flutter_lints` and `build_runner` in your _workspace_ file.
''');

      final located = locateHighlightInRepo(
        repoRoot: tempRepo.path,
        site: 'docs',
        sourceFile: 'sites/docs/src/content/tools/pubspec.md',
        selectedText:
            'Configure flutter_lints and build_runner in your workspace file.',
      );

      expect(located.resolvedFile, 'sites/docs/src/content/tools/pubspec.md');
      expect(located.startLine, 1);
      expect(located.endLine, 1);
    });

    test(
      'resolves delegated docs Liquid includes, data files, and examples',
      () {
        writeRepoFile('sites/docs/src/content/install/index.md', '''
---
title: Install Flutter
---

{% include 'docs/install/quick.md' %}
''');
        writeRepoFile('sites/docs/src/_includes/docs/install/quick.md', '''
## System requirements

Download the `flutter` archive and add `flutter/bin` to your `PATH`.
''');
        writeRepoFile('sites/docs/src/data/glossary.yml', '''
- term: Impeller
  short_description: Predictable shader compilation runtime for Flutter.
''');
        writeRepoFile('examples/get-started/hello/lib/main.dart', '''
void main() {
  print('Hello from Dash example');
}
''');

        final fromInclude = locateHighlightInRepo(
          repoRoot: tempRepo.path,
          site: 'docs',
          sourceFile: 'sites/docs/src/content/install/',
          selectedText:
              'Download the flutter archive and add flutter/bin to your PATH.',
        );
        expect(
          fromInclude.resolvedFile,
          'sites/docs/src/_includes/docs/install/quick.md',
        );
        expect(fromInclude.startLine, 3);

        final fromData = locateHighlightInRepo(
          repoRoot: tempRepo.path,
          site: 'docs',
          sourceFile: 'sites/docs/src/content/install/index.md',
          selectedText: 'Predictable shader compilation runtime for Flutter.',
        );
        expect(fromData.resolvedFile, 'sites/docs/src/data/glossary.yml');
        expect(fromData.startLine, 2);

        final fromExample = locateHighlightInRepo(
          repoRoot: tempRepo.path,
          site: 'docs',
          sourceFile: 'sites/docs/src/content/install/index.md',
          selectedText: "print('Hello from Dash example');",
        );
        expect(
          fromExample.resolvedFile,
          'examples/get-started/hello/lib/main.dart',
        );
        expect(fromExample.startLine, 2);
      },
    );

    test(
      'resolves www delegated Jaspr components and _data/YAML data files',
      () {
        writeRepoFile('sites/www/content/index.md', '''
---
title: Flutter
---

<HomePage />
''');
        writeRepoFile('sites/www/lib/src/pages/home_page.dart', '''
class HomePage {
  void build() {
    final subtitle =
        'Flutter transforms the development process. '
        'Build, test, and deploy beautiful apps from a single codebase.';
  }
}
''');
        writeRepoFile('sites/www/content/_data/featured_stories.yaml', '''
- company: Wonderous
  headline: Crafting rich cultural experiences at 60fps.
''');

        final fromComponent = locateHighlightInRepo(
          repoRoot: tempRepo.path,
          site: 'www',
          sourceFile: 'sites/www/content/index.md',
          selectedText:
              'Flutter transforms the development process. '
              'Build, test, and deploy beautiful apps from a single codebase.',
        );
        expect(
          fromComponent.resolvedFile,
          'sites/www/lib/src/pages/home_page.dart',
        );
        expect(fromComponent.startLine, 4);
        expect(fromComponent.endLine, 5);

        final fromData = locateHighlightInRepo(
          repoRoot: tempRepo.path,
          site: 'www',
          sourceFile: 'sites/www/content/index.md',
          elementText: 'Crafting rich cultural experiences at 60fps.',
        );
        expect(
          fromData.resolvedFile,
          'sites/www/content/_data/featured_stories.yaml',
        );
        expect(fromData.startLine, 2);
      },
    );

    test('resolves real www HomePage text in the live repository', () {
      final result = locateHighlightInRepo(
        repoRoot: repositoryRoot,
        site: 'www',
        sourceFile: 'sites/www/content/index.md',
        selectedText:
            'Flutter transforms the development process. '
            'Build, test, and deploy beautiful mobile, web, desktop, and '
            'embedded experiences from a single codebase.',
      );

      expect(result.resolvedFile, 'sites/www/lib/src/pages/home_page.dart');
      expect(result.startLine, isNotNull);
      expect(result.endLine, greaterThanOrEqualTo(result.startLine!));
    });

    test('falls back to headingAnchor when text selection is unavailable', () {
      writeRepoFile('sites/docs/src/content/perf/impeller.md', '''
# Impeller rendering engine

## How shader compilation works

Details here.

### Custom anchor section {#ios-metal-backend}

More details.
''');

      final slugMatch = locateHighlightInRepo(
        repoRoot: tempRepo.path,
        site: 'docs',
        sourceFile: 'sites/docs/src/content/perf/impeller.md',
        headingAnchor: '#how-shader-compilation-works',
      );
      expect(slugMatch.resolvedFile, 'sites/docs/src/content/perf/impeller.md');
      expect(slugMatch.startLine, 3);

      final explicitIdMatch = locateHighlightInRepo(
        repoRoot: tempRepo.path,
        site: 'docs',
        sourceFile: 'sites/docs/src/content/perf/impeller.md',
        headingAnchor: '#ios-metal-backend',
      );
      expect(explicitIdMatch.startLine, 7);
    });

    test('blocks path traversal and symlink escapes outside repoRoot', () {
      final outsideDir = Directory.systemTemp.createTempSync(
        'dash_review_outside_',
      );
      addTearDown(() {
        if (outsideDir.existsSync()) {
          outsideDir.deleteSync(recursive: true);
        }
      });

      final secretFile = File(path.join(outsideDir.path, 'secret.md'))
        ..writeAsStringSync('TOP_SECRET_OUTSIDE_TOKEN');

      final symlink = Link(
        path.join(tempRepo.path, 'sites', 'docs', 'escaped_secret.md'),
      )..createSync(secretFile.path, recursive: true);
      expect(symlink.existsSync(), isTrue);

      final traversal = locateHighlightInRepo(
        repoRoot: tempRepo.path,
        site: 'docs',
        sourceFile: '../../../${path.basename(outsideDir.path)}/secret.md',
        selectedText: 'TOP_SECRET_OUTSIDE_TOKEN',
      );
      expect(traversal.resolvedFile, isEmpty);
      expect(traversal.startLine, isNull);
      expect(traversal.codeSnippet, isNull);

      final viaSymlink = locateHighlightInRepo(
        repoRoot: tempRepo.path,
        site: 'docs',
        sourceFile: 'sites/docs/escaped_secret.md',
        selectedText: 'TOP_SECRET_OUTSIDE_TOKEN',
      );
      expect(viaSymlink.resolvedFile, isEmpty);
      expect(viaSymlink.startLine, isNull);
      expect(viaSymlink.codeSnippet, isNull);

      expect(
        sanitizeRepoRelativePath(tempRepo.path, '../../etc/passwd'),
        isNull,
      );
      expect(
        sanitizeRepoRelativePath(tempRepo.path, 'sites/docs/escaped_secret.md'),
        isNull,
      );
    });
  });
}
