// Copyright (c) 2023. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

import 'extract.dart';
import 'transform.dart';

/// An excerpt updater for an individual file that is
/// guaranteed to only run once.
final class FileUpdater {
  /// The default transforms to run initially on all code excerpt regions.
  final Iterable<Transform> defaultTransforms;

  /// The path to the directory of the source files to pull regions from.
  final String baseSourcePath;

  /// The content to include in plaster replacements by default.
  final String defaultPlasterContent;

  /// The path to the file to update the excerpt regions of.
  final String pathToUpdate;

  /// The update results for this file after
  /// running [process] for the first time.
  FileProcessResults? _results;

  /// Create a new [FileUpdater] that will process the file at the
  /// specified [pathToUpdate], pull code excerpt regions from the
  /// directory at [baseSourcePath], then optionally update
  /// the file with updated regions.
  ///
  /// The [defaultPlasterContent] is used when applying plasters
  /// if no the page or inject instruction doesn't override it.
  ///
  /// The [defaultTransforms] specified are ran to transform
  /// each regions pulled from the source files.
  FileUpdater(
    this.pathToUpdate, {
    required this.baseSourcePath,
    required this.defaultPlasterContent,
    required this.defaultTransforms,
  });

  /// Process the file at [pathToUpdate] and determine
  /// what, if any, updates need to be made to its injected
  /// code excerpts.
  Future<FileProcessResults> process() async {
    if (_results case final results?) return results;

    final updatedContent = StringBuffer();
    final warnings = <String>[];

    var excerptsVisited = 0;
    final excerptsUpdated = <({int instructionLine, String updated})>[];

    final extractor = ExcerptExtractor();

    final originalLines = await File(pathToUpdate).readAsLines();

    Iterable<ReplaceTransform> wholeFileTransforms = [];
    String? wholeFilePlasterTemplate;
    var wholeFilePathBase = '';

    for (var lineIndex = 0; lineIndex < originalLines.length; lineIndex += 1) {
      final line = originalLines[lineIndex];
      final trimmedLine = line.trimLeft();

      // The line won't change whether if
      // it's an instruction or not in a excerpt.
      updatedContent.writeln(line);
      if (!trimmedLine.startsWith(_instructionStart)) {
        continue;
      }

      final instructionLineNumber = lineIndex + 1;
      final instructionIndent = line.length - trimmedLine.length;

      Never reportError(String error) {
        throw InjectionException._(
          pathToUpdate,
          line,
          instructionLineNumber,
          error,
        );
      }

      final instruction = _Instruction.fromLine(line, reportError);
      if (instruction case _SetInstruction()) {
        switch (instruction) {
          case _SetPathBaseInstruction(:final pathBase):
            wholeFilePathBase = pathBase;
          case _SetPlasterInstruction(:final plasterTemplate):
            wholeFilePlasterTemplate = plasterTemplate;
          case _SetFileReplaceInstruction(:final transforms):
            wholeFileTransforms = transforms;
        }
      } else if (instruction case _InjectInstruction()) {
        // Move to index of what should be code block opening
        lineIndex += 1;

        if (lineIndex >= originalLines.length) {
          reportError(
            'An inject instruction must be followed by a code block. '
            'Found end of file.',
          );
        }

        final lineAfterInstruction = originalLines[lineIndex];
        final fencedCodeBlock = _codeBlockStart.firstMatch(
          lineAfterInstruction,
        );
        if (fencedCodeBlock == null) {
          reportError(
            'An inject instruction must be followed by a code block '
            'with a language specified.',
          );
        }

        excerptsVisited += 1;

        final backticks = fencedCodeBlock.namedGroup('backticks')!;
        final backtickCount = backticks.length;
        final language = fencedCodeBlock.namedGroup('language')!;
        final codeBlockEndMarker = RegExp('^\\s*`{$backtickCount}.*?\$');

        final oldLines = <String>[];
        String? codeBlockClose;

        while (lineIndex < originalLines.length) {
          lineIndex += 1;
          final codeLine = originalLines[lineIndex];

          if (codeBlockEndMarker.firstMatch(codeLine) != null) {
            codeBlockClose = codeLine;
            break;
          }

          oldLines.add(codeLine);
        }

        if (codeBlockClose == null) {
          reportError('Unclosed or unmatched code block.');
        }

        final combinedPath = path.join(
          baseSourcePath,
          wholeFilePathBase,
          instruction.targetPath,
        );

        final Region region;
        try {
          region = await extractor.extractRegion(
            combinedPath,
            instruction.regionName,
          );
        } on ExtractException catch (e) {
          reportError(e.error);
        }

        var plaster = (instruction.plasterTemplate ?? wholeFilePlasterTemplate)
            ?.replaceAll(r'$defaultPlaster', defaultPlasterContent);

        if (plaster == null) {
          final languageComments = _contentTypeToCommentFormat(language);
          if (languageComments case (:final prefix, :final suffix)) {
            plaster = '$prefix$defaultPlasterContent$suffix';
          }
        }

        var updatedLines = region.linesWithPlaster(plaster);

        final transforms = [
          ...instruction.transforms,
          ...wholeFileTransforms,
          ...defaultTransforms,
        ];

        for (final transform in transforms) {
          updatedLines = transform.transform(updatedLines);
        }

        updatedLines = updatedLines.map((line) => line.trimRight());

        // Remove all shared whitespace on the left.
        int? sharedLeftWhitespace;
        for (final line in updatedLines) {
          final leftWhitespace = line.length - line.trimLeft().length;
          // If this line has less left whitespace than preceding lines,
          // use its count as the shared left whitespace.
          if (sharedLeftWhitespace == null ||
              leftWhitespace < sharedLeftWhitespace) {
            sharedLeftWhitespace = leftWhitespace;
          }
        }

        if (sharedLeftWhitespace != null && sharedLeftWhitespace > 0) {
          updatedLines = [
            for (final line in updatedLines)
              line.substring(sharedLeftWhitespace),
          ];
        }

        // Add back the indentation from the file and any from the instruction.
        updatedLines = IndentTransform(
          instructionIndent + (instruction.indentBy ?? 0),
        ).transform(updatedLines);

        final updatedExcerpt = updatedLines.join('\n');
        if (!(const IterableEquality<String>().equals(
          oldLines,
          updatedLines,
        ))) {
          excerptsUpdated.add((
            instructionLine: instructionLineNumber,
            updated: updatedExcerpt,
          ));
        }

        updatedContent.writeln(lineAfterInstruction);
        updatedContent.writeln(updatedExcerpt);
        updatedContent.writeln(codeBlockClose);
      }
    }

    return FileProcessResults._(
      pathToUpdate,
      updatedContent.toString(),
      excerptsVisited,
      excerptsUpdated,
      warnings,
    );
  }
}

/// The results of processing a file and its injection instructions.
@immutable
final class FileProcessResults {
  /// The path of the file to process and update.
  final String pathToUpdate;

  /// The content of the file after applying updates.
  final String updatedContent;

  /// The amount of excerpts visited in the file.
  final int excerptsVisited;

  /// The warnings experienced while processing the file.
  final List<String> warnings;

  /// All instances where an excerpt needs to be updated,
  /// including the line number in the original file of the instruction
  /// and the contents after updating.
  final List<({int instructionLine, String updated})> excerptsUpdated;

  /// Create a [FileProcessResults] to communicate the results of
  /// processing a file and its code excerpt instructions.
  FileProcessResults._(
    this.pathToUpdate,
    this.updatedContent,
    this.excerptsVisited,
    this.excerptsUpdated,
    this.warnings,
  );

  /// If any excerpts at [pathToUpdate] need updates.
  bool get needsUpdates => excerptsUpdated.isNotEmpty;

  /// Write the excerpt updates determined as necessary
  /// to the file at [pathToUpdate].
  Future<void> writeUpdates() async {
    await File(pathToUpdate).writeAsString(updatedContent);
  }
}

/// An exception that occurs when a code-excerpt injection fails.
@immutable
final class InjectionException implements Exception {
  /// The path of the file this injection instruction exception occurred for.
  final String filePath;

  /// The line of the injection instruction that had errors or caused errors.
  final String line;

  /// The line number of the injection instruction that
  /// had errors or caused errors.
  ///
  /// This is the line number before the updates, if any, were made.
  final int lineNumber;

  /// The error that occurred due to the injection instruction.
  final String error;

  /// Create an exception to convey that an injection instruction of [line]
  /// at [lineNumber] in the file at [filePath] had an error
  /// or caused an error.
  InjectionException._(this.filePath, this.line, this.lineNumber, this.error);

  @override
  String toString() => '$filePath:$lineNumber - $error';
}

final RegExp _instructionPattern = RegExp(
  r'^\s*<\?code-excerpt\s+(?:"(?<path>\S+)(?:\s\((?<region>[^)]+)\))?\s*")?(?<args>.*?)\?>$',
);

final RegExp _instructionStart = RegExp(r'^<\?code-excerpt');

final RegExp _codeBlockStart = RegExp(
  r'^\s*(?<backticks>`{3,})(?<language>\S+).*?$',
);

final RegExp _splitArgs = RegExp(
  r'(?<arg>[-\w]+)\s*(=\s*"(?<value>.*?)"\s*)\s*',
);

/// A code excerpt set or injection instruction
/// found in a file being processed.
sealed class _Instruction {
  /// Parse and return an [_Instruction] from the specified [line].
  ///
  /// The line is assumed to at least look like like an instruction.
  ///
  /// Errors are reported to the calling function
  /// through the [reportError] callback.
  static _Instruction fromLine(
    String line,
    Never Function(String error) reportError,
  ) {
    final match = _instructionPattern.firstMatch(line);
    if (match == null) {
      reportError('Invalid code excerpt syntax.');
    }

    final path = match.namedGroup('path');
    final argumentString = match.namedGroup('args')?.trim() ?? '';
    final argumentPairs = _splitArgs
        .allMatches(argumentString)
        .map((m) => (arg: m.namedGroup('arg')!, value: m.namedGroup('value')!));

    if (path == null) {
      if (argumentPairs.length != 1) {
        reportError('A set instruction must have only one argument specified.');
      }
      final argName = argumentPairs.first.arg;
      final argValue = argumentPairs.first.value;
      return switch (argName) {
        'path-base' => _SetPathBaseInstruction(argValue),
        'plaster' => _SetPlasterInstruction(argValue),
        'replace' => _SetFileReplaceInstruction(
          stringToReplaceTransforms(argValue, reportError),
        ),
        _ => reportError(
          'A set instruction can only specify the '
          '`path-base`, `plaster`, and `replace` arguments.',
        ),
      };
    }

    return _InjectInstruction.fromArgs(
      targetPath: path,
      regionName: match.namedGroup('region') ?? '',
      arguments: argumentPairs,
      reportError: reportError,
    );
  }
}

sealed class _SetInstruction extends _Instruction {}

final class _SetPathBaseInstruction extends _SetInstruction {
  final String pathBase;

  _SetPathBaseInstruction(this.pathBase);
}

final class _SetPlasterInstruction extends _SetInstruction {
  final String plasterTemplate;

  _SetPlasterInstruction(this.plasterTemplate);
}

final class _SetFileReplaceInstruction extends _SetInstruction {
  final Iterable<ReplaceTransform> transforms;

  _SetFileReplaceInstruction(this.transforms);
}

/// An excerpt instruction that indicates an injection of content
/// from a source file and specified region,
/// with optional configuration such as transforms applied.
final class _InjectInstruction extends _Instruction {
  final String targetPath;
  final String regionName;

  final List<Transform> transforms;

  final int? indentBy;
  final String? plasterTemplate;

  _InjectInstruction({
    required this.targetPath,
    required this.regionName,
    required this.transforms,
    this.indentBy,
    this.plasterTemplate,
  });

  factory _InjectInstruction.fromArgs({
    required String targetPath,
    required String regionName,
    required Iterable<({String arg, String value})> arguments,
    required Never Function(String error) reportError,
  }) {
    String? indentByString;
    String? plasterTemplate;

    final transforms = <Transform>[];

    for (final (arg: argName, value: argValue) in arguments) {
      switch (argName) {
        case 'indent-by':
          if (indentByString != null) {
            reportError(
              'The `indent-by` argument can only be '
              'specified once per instruction.',
            );
          }
          indentByString = argValue;
        case 'plaster':
          if (plasterTemplate != null) {
            reportError(
              'The `plaster` argument can only be '
              'specified once per instruction.',
            );
          }
          plasterTemplate = argValue;
        case 'skip':
          transforms.add(SkipTransform(int.parse(argValue)));
        case 'take':
          transforms.add(TakeTransform(int.parse(argValue)));
        case 'from':
          transforms.add(FromTransform(_argStringToPattern(argValue)));
        case 'to':
          transforms.add(ToTransform(_argStringToPattern(argValue)));
        case 'remove':
          transforms.add(RemoveTransform(_argStringToPattern(argValue)));
        case 'retain':
          transforms.add(RetainTransform(_argStringToPattern(argValue)));
        case 'replace':
          transforms.addAll(stringToReplaceTransforms(argValue, reportError));
        default:
          reportError(
            '$argName is an unsupported argument '
            'in inject instructions.',
          );
      }
    }

    final indentBy = indentByString == null ? null : int.parse(indentByString);

    if (indentBy != null && indentBy < 0) {
      reportError('The `indent-by` argument must be positive.');
    }

    return _InjectInstruction(
      targetPath: targetPath,
      regionName: regionName,
      indentBy: indentBy,
      plasterTemplate: plasterTemplate,
      transforms: transforms,
    );
  }
}

/// Convert the specified string [value] to a regular expression
/// if wrapped in `/`.
Pattern _argStringToPattern(String value) {
  if (value.startsWith('/') && value.endsWith('/')) {
    final regularExpression = value.substring(1, value.length - 1);
    return RegExp(regularExpression);
  }

  // Unescape an escaped starting slash.
  if (value.startsWith(r'\/')) {
    return value.substring(1);
  }

  return value;
}

/// Convert from the specified [contentType],
/// representing a content type names or programming language, to
/// its line comment format, including prefix and suffix.
///
/// `null` is returned if no line comment format is known.
({String prefix, String suffix})? _contentTypeToCommentFormat(
  String contentType,
) {
  switch (contentType.trim().toLowerCase()) {
    case 'c':
    case 'c++':
    case 'cc':
    case 'cpp':
    case 'cs':
    case 'csharp':
    case 'dart':
    case 'go':
    case 'gradle':
    case 'groovy':
    case 'java':
    case 'javascript':
    case 'js':
    case 'kotlin':
    case 'kt':
    case 'objc':
    case 'rs':
    case 'sass':
    case 'scss':
    case 'swift':
    case 'ts':
    case 'typescript':
      return (prefix: '// ', suffix: '');
    case 'css':
      return (prefix: '/* ', suffix: ' */');
    case 'html':
    case 'xml':
      return (prefix: '<!-- ', suffix: ' -->');
    case 'python':
    case 'py':
    case 'yml':
    case 'yaml':
      return (prefix: '# ', suffix: '');
    case _:
      return null;
  }
}
