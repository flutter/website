// Copyright (c) 2023. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// A stored transformation that can transform from
/// a collection of strings, usually lines,
/// to a transformed version using [transform].
sealed class Transform {
  /// Transform the provided [lines] with the transform
  /// defined by this type.
  @useResult
  Iterable<String> transform(Iterable<String> lines);
}

/// A base class for transforms based off a singular [Pattern].
abstract final class PatternTransform extends Transform {
  /// The pattern to apply during the transform.
  final Pattern pattern;

  /// The super constructor for transforms that apply a singular pattern.
  PatternTransform(this.pattern);
}

/// A transform to remove the lines that don't contain the specified [pattern].
final class RetainTransform extends PatternTransform {
  /// Create a [RetainTransform] that removes the lines that
  /// don't contain the specified [pattern].
  RetainTransform(super.pattern);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    return lines.where((line) => line.contains(pattern));
  }
}

/// A transform to remove the lines that contain the specified [pattern].
final class RemoveTransform extends PatternTransform {
  /// Create a [RemoveTransform] that removes the lines that
  /// do contain the specified [pattern].
  RemoveTransform(super.pattern);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    return lines.whereNot((line) => line.contains(pattern));
  }
}

/// A transform to keep the lines after and including the first one
/// that contains the specified [pattern].
final class FromTransform extends PatternTransform {
  /// Create a [FromTransform] that keeps the lines after and including
  /// the first one that contains the specified [pattern].
  FromTransform(super.pattern);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    return lines.skipWhile((line) => !line.contains(pattern));
  }
}

/// A transform to keep only the lines before and including the first one
/// that contains the specified [pattern].
final class ToTransform extends PatternTransform {
  /// Create a [ToTransform] that keeps the lines before and including
  /// the first one that contains the specified [pattern].
  ToTransform(super.pattern);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    final newLines = <String>[];
    for (final line in lines) {
      newLines.add(line);
      if (line.contains(pattern)) {
        break;
      }
    }
    return newLines;
  }
}

/// A base class for transforms based off a singular integer [count].
abstract final class AmountTransform extends Transform {
  /// The count to use during the transform.
  final int count;

  /// The super constructor for transforms that utilize a singular [count].
  AmountTransform(this.count);
}

/// A transform to skip the first [count] lines if positive or
/// the last [count] lines if negative.
final class SkipTransform extends AmountTransform {
  /// Create a [SkipTransform] that skips the first [count] lines if
  /// positive or the last [count] lines if negative.
  SkipTransform(super.count);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    if (count.isNegative) {
      return lines.take(lines.length + count);
    } else {
      return lines.skip(count);
    }
  }
}

/// A transform to keep the first [count] lines if positive or
/// the last [count] lines if negative.
final class TakeTransform extends AmountTransform {
  /// Create a [TakeTransform] that keeps the first [count] lines if
  /// positive or the last [count] lines if negative.
  TakeTransform(super.count);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    if (count.isNegative) {
      return lines.skip(lines.length + count);
    } else {
      return lines.take(count);
    }
  }
}

/// A transform to indent each line with [count] whitespace.
final class IndentTransform extends AmountTransform {
  /// Create a [IndentTransform] that indents each line with [count] whitespace.
  IndentTransform(super.count) : assert(count >= 0);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    if (count == 0) return lines;

    final indentString = ' ' * count;
    return lines.map((line) => '$indentString$line');
  }
}

/// Convert the [replaceInstructions] string that can include multiple
/// regular expression-based replacements to multiple
/// [ReplaceTransform] instances representing their transformation.
///
/// Errors in parsing the [replaceInstructions] are reported to the
/// calling function through the [reportError] callback.
@useResult
Iterable<ReplaceTransform> stringToReplaceTransforms(
  String replaceInstructions,
  Never Function(String) reportError,
) {
  final parts = replaceInstructions
      .replaceAll(r'\/', _placeholderString)
      .split('/')
      .map((part) => part.replaceAll(_placeholderString, '/'))
      .toList(growable: false);

  final length = parts.length;
  if (length < 4 || length % 3 != 1) {
    reportError('Each replace transform must have 3 parts.');
  }

  final start = parts[0];
  if (start.isNotEmpty) {
    reportError('A replace transform must start with a forward slash (`/`).');
  }

  final transforms = <ReplaceTransform>[];

  for (var index = 1; index < length; index += 3) {
    final end = parts[index + 2];
    if (!_endReplacePattern.hasMatch(end)) {
      reportError('A replace transform must end with `g;`.');
    }

    final originalPattern = parts[index];
    final replaceWith = parts[index + 1];
    final encodedReplaceWith = _encodeSlashChar(replaceWith);

    if (!encodedReplaceWith.contains(_matchDollarNumRE)) {
      transforms.add(
        SimpleReplaceTransform(
          RegExp(originalPattern, multiLine: true),
          encodedReplaceWith,
        ),
      );
    } else {
      transforms.add(
        BackReferenceReplaceTransform(
          RegExp(originalPattern, multiLine: true),
          encodedReplaceWith,
        ),
      );
    }
  }

  return transforms;
}

/// A base class for replacement transforms that convert
/// text from one form to another, based on a provided [from] pattern
/// and [to] string.
sealed class ReplaceTransform extends Transform {
  /// The pattern to match text to consider for replacement.
  final Pattern from;

  /// The string to replace the text matching the [from] pattern with.
  final String to;

  /// The super constructor for transforms that apply a replacement.
  ReplaceTransform(this.from, this.to);

  /// Transform the provided [lines] with the transform
  /// defined by this type.
  ///
  /// Note that, compared to other [Transform] types,
  /// [ReplaceTransform] subtypes tend to operator on combined lines
  /// rather than each line individually.
  @override
  Iterable<String> transform(Iterable<String> lines);
}

/// A transform to replace each instance of the
/// [from] pattern with the [to] string.
final class SimpleReplaceTransform extends ReplaceTransform {
  /// Create a [SimpleReplaceTransform] that replaces each instance of the
  /// [from] pattern with the [to] string in the combined text.
  SimpleReplaceTransform(super.from, super.to);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    return lines.join('\n').replaceAll(from, to).split('\n');
  }
}

/// A transform to replace each instance of the
/// [from] pattern with the [to] string while
/// allowing backreferences to captured groups in the [to] string.
final class BackReferenceReplaceTransform extends ReplaceTransform {
  /// Create a [BackReferenceReplaceTransform] that replaces each instance of
  /// the [from] pattern with the [to] string in the combined text,
  /// while allowing backreferences to captured groups in the [to] string.
  BackReferenceReplaceTransform(super.from, super.to);

  @override
  Iterable<String> transform(Iterable<String> lines) {
    return lines
        .join('\n')
        .replaceAllMapped(
          from,
          (match) => to.replaceAllMapped(_matchDollarNumRE, (replaceMatch) {
            // The following works to match JS `replace` semantics.
            // $$ becomes $ in a replacement string.

            final dollarSignCount = replaceMatch[1]!.length;

            // The escaped dollar sign characters present (if any).
            final escapedDollarSigns = r'$' * (dollarSignCount ~/ 2);

            // Potentially a reference to a captured group,
            // otherwise the content after the escaped dollar signs.
            final potentialGroupReference = replaceMatch[2];

            if (potentialGroupReference == null ||
                potentialGroupReference.isEmpty) {
              return escapedDollarSigns;
            }

            if (dollarSignCount.isEven) {
              return '$escapedDollarSigns$potentialGroupReference';
            }

            // $& references the entire matched substring.
            if (potentialGroupReference == '&') {
              return '$escapedDollarSigns${match[0]}';
            }

            final groupNumber = int.tryParse(potentialGroupReference);
            if (groupNumber == null || groupNumber > match.groupCount) {
              // If there is no corresponding capture group,
              // just output the reference itself.
              return '$escapedDollarSigns\$$potentialGroupReference';
            }

            return '$escapedDollarSigns${match[groupNumber]}';
          }),
        )
        .split('\n');
  }
}

const String _placeholderString = '\u{0}';

final RegExp _matchDollarNumRE = RegExp(r'(\$+)(&|\d*)');

final RegExp _slashHexCharRE = RegExp(r'\\x(..)');
final RegExp _slashLetterRE = RegExp(r'\\([\\nt])');

/// Encode special characters: '\t', `\n`, and `\xHH` where `HH` are hex digits.
String _encodeSlashChar(String s) => s
    .replaceAllMapped(_slashLetterRE, (match) => _slashCharToChar(match[1]))
    .replaceAllMapped(
      _slashHexCharRE,
      // At this point, escaped `\` is encoded as [_placeholderString].
      (match) => _hexToChar(match[1], errorValue: '\\x${match[1]}'),
    )
    .replaceAll(_placeholderString, '\\'); // Recover `\` characters.

String _hexToChar(String? hexDigits, {required String errorValue}) {
  final charCode = int.tryParse(hexDigits ?? '', radix: 16);
  return charCode == null ? errorValue : String.fromCharCode(charCode);
}

String _slashCharToChar(String? char) => switch (char) {
  'n' => '\n',
  't' => '\t',
  '\\' => _placeholderString,
  _ => '\\$char',
};

final RegExp _endReplacePattern = RegExp(r'^g;?\s*$');
