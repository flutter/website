// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'client/stepper.dart';

class Stepper extends CustomComponent {
  const Stepper() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(
      tag: 'Stepper',
      :final attributes,
      :final children,
    )) {
      final levelStr = attributes['level'] ?? '1';
      final level = int.tryParse(levelStr) ?? 1;
      final collapsible = attributes['collapsible']?.toLowerCase() != 'false';
      final showActions = attributes['actions']?.toLowerCase() != 'none';
      final showFinish =
          showActions &&
          attributes['actions']?.toLowerCase() != 'continue-only';

      assert(
        level >= 1 && level <= 6,
        'Stepper level must be between 1 and 6, got $level',
      );

      final steps = <({Node title, List<Node> content})>[];

      if (children != null) {
        for (final child in children) {
          if (child case final ElementNode heading
              when heading.tag == 'h$level') {
            steps.add((title: child, content: []));
          } else if (child
              case ElementNode(
                tag: 'div',
                attributes: {'class': 'header-wrapper'},
                children: [final ElementNode heading, ..._],
              )
              when heading.tag == 'h$level') {
            steps.add((title: heading, content: []));
          } else {
            if (steps.isEmpty) {
              throw Exception(
                'Content found before first step title in Stepper. Make sure '
                'your Stepper content starts with a heading of level $level.',
              );
            }
            steps.last.content.add(child);
          }
        }
      }

      return InteractiveStepper(
        titles: [
          for (final step in steps) builder.build([step.title]),
        ],
        steps: [for (final step in steps) builder.build(step.content)],
        collapsible: collapsible,
        showActions: showActions,
        showFinish: showFinish,
      );
    }

    return null;
  }
}
