// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:html/parser.dart' as html;
import 'package:path/path.dart' as path;

import 'utils.dart';

/// Reports IDs shared by multiple elements in the same HTML file,
/// with paths relative to [buildDirectory].
///
/// Ignores IDs inside `<template>` elements,
/// whose contents belong to a separate document fragment,
/// and inside inline `<svg>` elements, where repeated graphics,
/// such as icons or the light and dark copies of a rendered Mermaid diagram,
/// often include identical internal IDs.
List<String> findDuplicateIds(Directory buildDirectory) {
  final duplicates = <String>[];
  for (final file in listHtmlFiles(buildDirectory)) {
    final document = html.parse(file.readAsStringSync());
    for (final ignored in document.querySelectorAll('template, svg')) {
      ignored.remove();
    }

    final counts = <String, int>{};
    for (final element in document.querySelectorAll('[id]')) {
      counts.update(element.id, (count) => count + 1, ifAbsent: () => 1);
    }

    final relativePath = path.relative(file.path, from: buildDirectory.path);
    for (final MapEntry(key: id, value: count) in counts.entries) {
      if (count > 1) {
        duplicates.add('$relativePath: "$id" matches $count elements.');
      }
    }
  }
  return duplicates..sort();
}
