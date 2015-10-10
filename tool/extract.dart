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
  Iterable<File> files = Directory.current
      .listSync()
      .where((entity) => entity is File && entity.path.endsWith('.md'));
  files.forEach((file) => extractCount += _processFile(file));
  print('\n${extractCount} code snippets extracted.');
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
    if (lines[index].startsWith('```dart') && lastComment != 'skip') {
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
      lastComment = lastComment.substring(0, lastComment.length - 3).trim();
    } else {
      lastComment = null;
    }

    index++;
  }

  return count;
}

void _extractSnippet(String filename, int snippet, int startLine, List<String> lines,
    {String includeSource}) {
  bool hasImport = lines.first.trim().startsWith('import ');
  String path = 'example/${filename.replaceAll('-', '_').replaceAll('.', '_')}_'
      '${snippet}.dart';

  int adjust = 1;
  String source = '// Extracted from ${filename}, line ${startLine}.\n';

  if (!hasImport) {
    source += "import 'package:sky/material.dart';\n";
    adjust++;
  }

  if (includeSource != null) {
    source += "${includeSource}\n";
    adjust += includeSource.split('\n').length;
  }

  source +=
    '${''.padRight(startLine - adjust, '\n')}'
    '${lines.join('\n')}\n';

  new File(path).writeAsStringSync(source);
  print('  ${lines.length} line snippet ==> ${path}');
}

void clean() {
  Iterable<File> files = new Directory('example')
      .listSync()
      .where((entity) => entity is File && entity.path.endsWith('.dart'));
  files.forEach((file) => file.deleteSync());
}
