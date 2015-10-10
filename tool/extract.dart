import 'dart:io';

import 'package:path/path.dart' as p;

/// Extract Dart snippets from the markdown documentation.
void main(List<String> args) {
  // Validate our cwd.
  File pubspec = new File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    fail('This tool must the run from the project root.');
  }

  // Remove any previously generated files.
  clean();

  // Traverse markdown files in the root.
  List<File> markdownFiles = Directory.current.listSync().where((entity) {
    return entity is File && entity.path.endsWith('.md');
  }).toList();

  markdownFiles.forEach(_processFile);
}

void _processFile(File file) {
  print(file.path);

  String name = p.basename(file.path);

  // Look for ```dart sections.
  String source = file.readAsStringSync();
  List<String> lines = source.split('\n');

  int index = 1;
  int count = 0;

  String lastComment;

  while (index < lines.length) {
    // Look for ```
    if (lines[index].startsWith('```dart') && lastComment != 'skip') {
      int startIndex = index + 1;
      index++;
      while (index < lines.length && !lines[index].startsWith('```')) {
        index++;
      }
      _extract(name, ++count, startIndex, lines.sublist(startIndex, index),
          includeSource: lastComment);
    } else if (lines[index].startsWith('<!--')) {
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
}

void _extract(String filename, int snippet, int startLine, List<String> lines,
    {String includeSource}) {
  String first = lines.first.trim();
  bool hasImport = first.startsWith('import ');
  // // TODO: Many of these should be analyzed as well.
  // print('  skipping ${filename} line ${startLine}, no import statement');
  // return;

  String path =
      'example/${filename.replaceAll('-', '_').replaceAll('.', '_')}_${snippet}.dart';

  String source =
    '// Extracted from ${filename} line ${startLine}.\n';

  int adjust = 1;

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

  print('  extracting ${path} from line ${startLine}');
  new File(path).writeAsStringSync(source);
}

void clean() {
  Iterable<File> files = new Directory('example').listSync().where((entity) {
    return entity is File && entity.path.endsWith('.dart');
  });
  files.forEach((file) => file.deleteSync());
}

void fail(String message) {
  print(message);
  exit(1);
}
