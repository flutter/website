// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:dash_site/src/duplicate_ids.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  late Directory output;
  setUp(() {
    output = Directory.systemTemp.createTempSync('dash-site-duplicate-ids-');
    addTearDown(() => output.deleteSync(recursive: true));
  });

  void writePage(String relativePath, String content) {
    File(path.join(output.path, relativePath))
      ..createSync(recursive: true)
      ..writeAsStringSync(content);
  }

  test('reports each duplicate ID with its output file and count', () {
    final aiPage = path.join('ai', 'index.html');
    writePage(aiPage, '''
<main id="tabs"><a id="tabs" aria-hidden="true"></a></main>
<a id="a&amp;b" aria-hidden="true"></a>
<h2 id="a&amp;b">Heading</h2>
<h2 id="a&amp;b">Heading</h2>
''');
    writePage('404.html', '''
<h2 id="dup">One</h2>
<p id="dup">Two</p>
''');
    expect(findDuplicateIds(output), [
      '404.html: "dup" matches 2 elements.',
      '$aiPage: "a&b" matches 3 elements.',
      '$aiPage: "tabs" matches 2 elements.',
    ]);
  });

  test('counts only live IDs on the same HTML page', () {
    writePage('index.html', '''
<a id="cpp" aria-hidden="true"></a>
<a data-tab-save-id="cpp" href="#cpp">C++</a>
<template><p id="cpp"></p></template>
<code>&lt;p id="cpp"&gt;</code>
''');
    writePage('other.html', '<p id="cpp"></p>');
    writePage('index.md', '<p id="cpp"></p><p id="cpp"></p>');
    expect(findDuplicateIds(output), isEmpty);
  });

  test('ignores IDs inside inline SVG elements', () {
    writePage('icons.html', '''
<h2 id="A">Heading</h2>
<h2 id="A">Heading</h2>
<svg><g id="A"></g></svg>
<svg><g id="A"></g></svg>
''');
    expect(findDuplicateIds(output), ['icons.html: "A" matches 2 elements.']);
  });
}
