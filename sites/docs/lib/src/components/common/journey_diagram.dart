// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';

/// Reusable section model for [JourneyDiagram].
final class JourneySection {
  const JourneySection({
    required this.label,
    required this.icon,
    this.variant = 'blue',
    required this.items,
  });

  factory JourneySection.fromMap(Map<String, Object?> map) {
    return JourneySection(
      label: map['label'] as String? ?? '',
      icon: map['icon'] as String? ?? 'info',
      variant: map['variant'] as String? ?? 'blue',
      items: (map['items'] as List<Object?>? ?? const [])
          .map((item) => item.toString())
          .toList(),
    );
  }

  final String label;
  final String icon;
  final String variant;
  final List<String> items;
}

/// Backwards-compatible alias for [JourneySection].
typedef CujDiagramSection = JourneySection;

/// A structured, reusable diagram component visualizing a user journey flow
/// or step sequence across configurable sections and nested item pills.
final class JourneyDiagram extends StatelessComponent {
  const JourneyDiagram({
    required this.sections,
    this.classes = 'cuj-diagram-card',
    super.key,
  });

  final List<JourneySection> sections;
  final String classes;

  @override
  Component build(BuildContext context) {
    return div(classes: classes, [
      for (final section in sections)
        div(classes: 'cuj-diagram-section', [
          div(classes: 'section-sidebar', [
            div(classes: 'section-icon variant-${section.variant}', [
              MaterialIcon(section.icon),
            ]),
            span(classes: 'section-label', [.text(section.label)]),
          ]),
          div(classes: 'section-items', [
            for (final item in section.items)
              div(classes: 'cuj-pill pill-${section.variant}', [
                .text(item),
              ]),
          ]),
        ]),
    ]);
  }
}
