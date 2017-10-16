import 'dart:io';

import 'package:path/path.dart' as p;

/// Extract Dart snippets from the markdown documentation.
void main(List<String> args) {
  // Validate our cwd.
  if (!new File('pubspec.yaml').existsSync()) {
    print('This tool must be run from the project root.');
    exit(1);
  }

  // Remove any previously generated files.
  clean();

  // Traverse markdown files in the root.
  int extractCount = 0;
  Iterable<FileSystemEntity> files = Directory.current
      .listSync()
      .where((FileSystemEntity entity) => entity is File && entity.path.endsWith('.md'));
  files.forEach((FileSystemEntity file) => extractCount += _processFile(file));
  print('\n$extractCount code snippets extracted.');
}

int _processFile(File file) {
  String name = p.basename(file.path);
  print(name);

  // Look for ```dart sections.
  String source = file.readAsStringSync();
  List<String> lines = source.split('\n');

  int index = 1;
  int count = 0;

  String lastComment;

  while (index < lines.length) {
    // Look for ```dart sections.
    if (lines[index].startsWith('```dart') && lastComment?.trim() != 'skip') {
      int startIndex = index + 1;
      index++;
      while (index < lines.length && !lines[index].startsWith('```')) {
        index++;
      }
      _extractSnippet(name, ++count, startIndex, lines.sublist(startIndex, index),
          includeSource: lastComment);
    } else if (lines[index].startsWith('<!--')) {
      // Look for <!-- comment sections.
      int startIndex = index;
      while (!lines[index].endsWith('-->')) {
        index++;
      }

      lastComment = lines.sublist(startIndex, index + 1).join('\n');
      lastComment = lastComment.substring(4);
      if (lines[startIndex].trim() == '<!--') {
        // remove the first \n
        lastComment = lastComment.substring(1);
      }
      lastComment = lastComment.substring(0, lastComment.length - 3);
    } else {
      lastComment = null;
    }

    index++;
  }

  return count;
}

void _extractSnippet(String filename, int snippet, int startLine, List<String> lines,
    {String includeSource}) {
  bool hasImport = lines.any((String line) => line.startsWith('import '));
  String path = 'example/${filename.replaceAll('-', '_').replaceAll('.', '_')}_'
      '$snippet.dart';

  String source = '// Extracted from $filename, line $startLine.\n';

  if (!hasImport) {
    source += "import 'package:flutter/material.dart';\n\n";
  }

  if (includeSource != null) {
    source += "$includeSource\n";
  }

  source += '${lines.join('\n')}\n';

  source = _removeMarkup(source);

  new File(path).writeAsStringSync(source);
  print('  ${lines.length} line snippet ==> $path');
}

String _removeMarkup(String source) {
  List<String> tags = ['strike', 'highlight', 'note', 'red'];

  tags.forEach((String tag) {
    source = source.replaceAll('\[\[$tag\]\]', '');
    source = source.replaceAll('\[\[/$tag\]\]', '');
  });
  return source;
}

void clean() {
  var exampleDir = new Directory('example');
  if (!exampleDir.existsSync()) {
    exampleDir.createSync();
  }
  Iterable<File> files = exampleDir
      .listSync()
      .where((FileSystemEntity entity) => entity is File && entity.path.endsWith('.dart'));
  files.forEach((File file) => file.deleteSync());
}
