import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;

const siteSrcPath = 'src';
const generatedExampleDirPath = 'example.g';

/// Extract Dart snippets from the markdown documentation.
void main(List<String> args) {
  // Validate our cwd.
  if (!File('pubspec.yaml').existsSync()) {
    print('This tool must be run from the project root.');
    exit(1);
  }

  // Remove any previously generated files.
  clean();

  // Traverse all markdown files in the repository.
  int extractCount = 0;
  Iterable<FileSystemEntity> files = Directory(siteSrcPath)
      .listSync(recursive: true)
      .where((FileSystemEntity entity) =>
          entity is File &&
          entity.path.endsWith('.md') &&
          !entity.path.contains('README.md'));
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
    if (lines[index].trim().startsWith('```dart') &&
        lastComment?.trim() != 'skip') {
      int startIndex = index + 1;
      index++;
      while (index < lines.length && !lines[index].trim().startsWith('```')) {
        index++;
      }
      final snippet = maxUnindent(lines.sublist(startIndex, index));
      _extractSnippet(name, ++count, startIndex, snippet,
          includeSource: lastComment);
    } else if (lines[index].trim().startsWith('<!--')) {
      // Look for <!-- comment sections.
      int startIndex = index;
      while (!lines[index].trim().endsWith('-->')) index++;

      lastComment = lines.sublist(startIndex, index + 1).join('\n').trim();
      lastComment = lastComment.substring(4);
      if (lines[startIndex].trim() == '<!--') {
        // remove the first \n
        lastComment = lastComment.substring(1);
      }
      lastComment = lastComment.substring(0, lastComment.length - 3);
    } else if (lines[index].contains('<?code-')) {
      lastComment = 'skip';
    } else {
      lastComment = null;
    }

    index++;
  }

  return count;
}

void _extractSnippet(
    String filename, int snippet, int startLine, Iterable<String> lines,
    {String includeSource}) {
  bool hasImport =
      lines.any((String line) => line.trim().startsWith('import '));
  String path = p.join(generatedExampleDirPath,
      '${filename.replaceAll('-', '_').replaceAll('.', '_')}_$snippet.dart');

  String source = '// Extracted from $filename, line $startLine.\n';

  if (!hasImport) source += "import 'package:flutter/material.dart';\n\n";
  if (includeSource != null) source += "$includeSource\n";

  source += '${lines.join('\n')}\n';
  source = _removeMarkup(source);

  File(path).writeAsStringSync(source);
  print('  ${lines.length} line snippet ==> $path');
}

final highlightRE = RegExp(r'\[\[/?(highlight|note|red|strike)\]\]');
final abbreviatedHighlightRE = RegExp(r'\[!|!\]');

String _removeMarkup(String source) =>
    source.replaceAll(highlightRE, '').replaceAll(abbreviatedHighlightRE, '');

void clean() {
  var exampleDir = Directory(generatedExampleDirPath);
  if (!exampleDir.existsSync()) {
    exampleDir.createSync();
  }
  final files = exampleDir
      .listSync()
      .where((entity) => entity is File && entity.path.endsWith('.dart'));
  files.forEach((file) => file.deleteSync());
}

final blankLine = RegExp(r'^\s*$');
final _leadingWhitespace = RegExp(r'^[ \t]*');

/// Unindent [lines] to the extent possible without losing
/// the relative inter-line indentation. Note that blank
/// lines are ignored in the process computing the maximal
/// left-shift.
Iterable<String> maxUnindent(Iterable<String> lines) {
  final nonblankLines = lines.where((s) => !blankLine.hasMatch(s));
  // Length of leading spaces to be trimmed
  final lengths = nonblankLines.map((s) {
    final match = _leadingWhitespace.firstMatch(s);
    return match == null ? 0 : match[0].length;
  });
  if (lengths.isEmpty) return lines;
  final len = lengths.reduce(min);
  return len == 0
      ? lines
      : lines.map((line) => line.length < len ? line : line.substring(len));
}
