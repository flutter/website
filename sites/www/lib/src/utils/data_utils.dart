// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

/// Typed content-decoding helpers for page data.
///
/// Use these methods at content boundaries (page/layout/component build methods)
/// to decode YAML-backed data into strongly typed models.
extension DataContext on BuildContext {
  /// Decodes an object at [path] and maps it with [fromJson].
  ///
  /// [path] must use dot notation (for example `consultants.data.partners`).
  /// Throws [FormatException] when the path is missing, the value shape is
  /// invalid, or [fromJson] fails.
  T decodeJsonObject<T>(
    String path,
    T Function(Map<String, Object?> json) fromJson,
  ) {
    final value = _valueAtPath(page.data, path);
    final map = _asJsonMap(value, path: path);
    try {
      return fromJson(map);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        FormatException('Invalid JSON object at "$path": $error'),
        stackTrace,
      );
    }
  }

  /// Decodes a list of objects at [path] and maps each item with [fromJson].
  ///
  /// [path] must use dot notation (for example `events.data.featured`).
  /// Throws [FormatException] when the path is missing, the value is not a
  /// list, an item is not a map, or [fromJson] fails for any item.
  List<T> decodeJsonList<T>(
    String path,
    T Function(Map<String, Object?> json) fromJson,
  ) {
    final value = _valueAtPath(page.data, path);
    if (value is! List) {
      throw FormatException(
        'Expected a list at "$path", got ${_describeType(value)}.',
      );
    }

    final result = <T>[];
    for (var index = 0; index < value.length; index++) {
      final itemPath = '$path[$index]';
      final map = _asJsonMap(value[index], path: itemPath);
      try {
        result.add(fromJson(map));
      } catch (error, stackTrace) {
        Error.throwWithStackTrace(
          FormatException('Invalid JSON object at "$itemPath": $error'),
          stackTrace,
        );
      }
    }

    return result;
  }
}

/// Returns the value at a dot-separated [path] within [data].
///
/// Throws [FormatException] when an intermediate node is not a map or when
/// any required path segment is missing.
Object? _valueAtPath(PageDataMap data, String path) {
  final keys = path.split('.');
  Object? value = data;
  var currentPath = 'page.data';

  for (final key in keys) {
    if (value is! Map) {
      throw FormatException(
        'Expected a map at "$currentPath", got ${_describeType(value)}.',
      );
    }
    if (!value.containsKey(key)) {
      throw FormatException('Missing required key "$key" at "$currentPath".');
    }
    value = value[key];
    currentPath = '$currentPath.$key';
  }

  return value;
}

/// Converts [value] to a `Map<String, Object?>` for safe model decoding.
///
/// Returns [value] directly when it is already a `Map<String, Object?>`.
/// Otherwise validates that all keys are strings and returns a typed copy.
/// Throws [FormatException] when [value] is not a map or contains non-string
/// keys.
Map<String, Object?> _asJsonMap(Object? value, {required String path}) {
  if (value is Map<String, Object?>) return value;
  if (value is! Map) {
    throw FormatException(
      'Expected a map at "$path", got ${_describeType(value)}.',
    );
  }

  final map = <String, Object?>{};
  for (final entry in value.entries) {
    final key = entry.key;
    if (key is! String) {
      throw FormatException(
        'Expected string keys in map at "$path", got ${_describeType(key)}.',
      );
    }
    map[key] = entry.value;
  }

  return map;
}

/// Returns a user-friendly type label for error messages.
String _describeType(Object? value) =>
    value == null ? 'null' : value.runtimeType.toString();
