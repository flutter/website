// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:liquify/liquify.dart';
import 'package:path/path.dart' as path;

import '../util.dart';

/// A template engine for Jaspr Content that
/// uses `package:liquify` to parse and render Liquid templates.
final class DashTemplateEngine implements TemplateEngine {
  DashTemplateEngine({required this.partialDirectoryPath});

  /// The path to the directory containing partial files.
  final String partialDirectoryPath;

  /// The `package:liquify` environment to render templates with.
  final Environment _renderEnvironment = Environment()
    ..registerFilter('slugify', (value, _, _) {
      if (value is! String) return value;

      return slugify(value);
    })
    ..registerFilter('sortBy', (value, arguments, _) {
      if (value is! List<Object?>) return value;
      final keyToSortBy = arguments[0] as Object;

      // For now only support maps.
      return value.cast<Map<String, Object?>>().sorted((left, right) {
        final leftValue = left[keyToSortBy];
        final rightValue = right[keyToSortBy];

        if (leftValue == null && rightValue == null) return 0;
        if (leftValue == null) return -1;
        if (rightValue == null) return 1;

        // Check if both values are Comparable and of the same type.
        final int compareResult;
        if (leftValue is Comparable &&
            rightValue.runtimeType == leftValue.runtimeType) {
          compareResult = leftValue.compareTo(rightValue);
        } else {
          // If not comparable or their types are different,
          // treat them as equal.
          compareResult = 0;
        }

        return compareResult;
      });
    });

  @override
  Future<void> render(Page page, List<Page> pages) async {
    if (page.data.page['skipTemplateRendering'] == true) {
      return;
    }

    final template = Template.parse(
      page.content,
      data: {
        ...page.data,
        'pages': pages.map((page) => page.data.page).toList(growable: false),
      },
      root: _PartialResolver(
        page: page,
        partialDirectoryPath: partialDirectoryPath,
      ),
      environment: _renderEnvironment,
    );

    page.apply(content: await template.renderAsync());
  }
}

class _PartialResolver implements Root {
  _PartialResolver({required this.page, required this.partialDirectoryPath});

  final Page page;
  final String partialDirectoryPath;

  @override
  Source resolve(String relPath) {
    final filePath = path.join(partialDirectoryPath, relPath);
    final content = page.readPartialSync(filePath);
    return Source(Uri.file(filePath), content, this);
  }

  @override
  Future<Source> resolveAsync(String relPath) async {
    final partialPath = path.join(partialDirectoryPath, relPath);
    final partialContent = await page.readPartial(partialPath);
    return Source(Uri.file(partialPath), partialContent, this);
  }
}
