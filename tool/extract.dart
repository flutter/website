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
  print(file.path);

  // Look for ```dart sections.
  String source = file.readAsStringSync();
  List<String> lines = source.split('\n');

  int index = 1;
  int count = 0;

  String lastComment;

  while (index < lines.length) {
    final trimmed = lines[index].trim();
    // Look for ```dart sections.
    if ((trimmed.startsWith('```dart') ||
            trimmed.startsWith('```run-dartpad')) &&
        lastComment?.trim() != 'skip') {
      int startIndex = index + 1;
      index++;
      while (index < lines.length && !lines[index].trim().startsWith('```')) {
        index++;
      }
      final snippet = maxUnindent(lines.sublist(startIndex, index));
      _extractSnippet(file, ++count, startIndex, snippet,
          includeSource: lastComment);
    } else if (lines[index].trim().startsWith('<!--')) {
      // Look for <!-- comment sections.
      int startIndex = index;
      while (!lines[index].trim().endsWith('-->')) {
        index++;
        if (index >= lines.length) {
          throw StateError(
              'Line ${startIndex + 1} in $file has an unterminated '
              'comment - failed to find "-->" before EOF.');
        }
      }

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

const String defaultImports = '''
// ignore_for_file: unused_import

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
''';

String _createDirAndFileName(File sourceFile, int count) {
  final String filename = p.basename(sourceFile.path);
  final String dartFileName = p.join(
    generatedExampleDirPath,
    sourceFile.parent.path,
    '${filename.replaceAll('-', '_').replaceAll('.', '_')}_$count.dart',
  );
  Directory(p.join(
    generatedExampleDirPath,
    sourceFile.parent.path,
  )).createSync(recursive: true);
  return dartFileName;
}

void _extractSnippet(
    File sourceFile, int snippet, int startLine, Iterable<String> lines,
    {String includeSource}) {
  if (lines.isEmpty || lines.every((String line) => line.isEmpty)) {
    throw StateError('Passed empty lines to extractSnippet');
  }

  final int importCount =
      lines.where((String line) => line.trim().startsWith('import ')).length;
  if (importCount == lines.length) {
    return;
  }

  bool hasImport = importCount > 0;

  String path = _createDirAndFileName(sourceFile, snippet);

  StringBuffer source =
      StringBuffer('// Extracted from ${sourceFile.path}, line $startLine\n');

  if (!hasImport) {
    source.writeln(defaultImports);
  }

  if (includeSource != null) {
    source.writeln('$includeSource');
  }

  lines.map(_removeMarkup).forEach(source.writeln);

  File(path).writeAsStringSync(source.toString());
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
