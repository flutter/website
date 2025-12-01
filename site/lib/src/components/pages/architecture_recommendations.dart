// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../markdown/markdown_parser.dart';

class ArchitectureRecommendations extends CustomComponentBase {
  const ArchitectureRecommendations();

  @override
  Pattern get pattern => 'ArchitectureRecommendations';

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    return Builder(
      builder: (context) {
        final recommendations =
            (context.page.data['architectureRecommendations'] as List<Object?>)
                .cast<Map<String, Object?>>()
                .map(ArchitectureRecommendationCategory.new)
                .toList();

        final categoryName = attributes['category'];

        final category = recommendations
            .where((category) => category.category == categoryName)
            .firstOrNull;
        if (category == null) {
          throw ArgumentError('Category $categoryName not found');
        }

        if (category.recommendations.isEmpty) {
          return const Component.empty();
        }

        return table(
          classes: 'table table-striped',
          styles: Styles(
            border: Border.only(
              bottom: BorderSide.solid(
                color: const Color('#DADCE0'),
                width: 1.px,
              ),
            ),
          ),
          [
            thead([
              tr([
                th(styles: Styles(width: 30.percent), [
                  text('Recommendation'),
                ]),
                th(styles: Styles(width: 70.percent), [
                  text('Description'),
                ]),
              ]),
            ]),
            tbody([
              for (final rec in category.recommendations)
                tr([
                  td([
                    DashMarkdown(inline: true, content: rec.recommendation),
                    div(
                      classes: switch (rec.confidence) {
                        'strong' => 'rrec-pill success',
                        'recommend' => 'rrec-pill info',
                        _ => 'rrec-pill',
                      },
                      [
                        text(
                          switch (rec.confidence) {
                            'strong' => 'Strongly recommend',
                            'recommend' => 'Recommend',
                            _ => 'Conditional',
                          },
                        ),
                      ],
                    ),
                  ]),
                  td([
                    DashMarkdown(content: rec.description),
                    if (rec.confidenceDescription
                        case final String confidenceDescription)
                      DashMarkdown(content: confidenceDescription),
                  ]),
                ]),
            ]),
          ],
        );
      },
    );
  }
}

extension type ArchitectureRecommendationCategory(Map<String, Object?> data) {
  String get category => data['category'] as String;
  String get description => data['description'] as String;
  List<ArchitectureRecommendationItem> get recommendations =>
      (data['recommendations'] as List<Object?>)
          .cast<Map<String, Object?>>()
          .map(ArchitectureRecommendationItem.new)
          .toList();
}

extension type ArchitectureRecommendationItem(Map<String, Object?> data) {
  String get recommendation => data['recommendation'] as String;
  String get description => data['description'] as String;
  String get confidence => data['confidence'] as String;
  String? get confidenceDescription =>
      data['confidence-description'] as String?;
}
