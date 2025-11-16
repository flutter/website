// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../pages/glossary.dart';
import '../util.dart';

/// A node-processing, page extension for Jaspr Content that looks for links to
/// glossary entries and enhances them with interactive glossary tooltips.
class GlossaryLinkProcessor implements PageExtension {
  const GlossaryLinkProcessor();

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    final glossary = Glossary.fromList(page.data['glossary'] as List<Object?>);
    return _processNodes(nodes, glossary);
  }

  List<Node> _processNodes(List<Node> nodes, Glossary glossary) {
    final processedNodes = <Node>[];

    for (final node in nodes) {
      if (node is ElementNode &&
          node.tag == 'a' &&
          node.attributes['href']?.startsWith('/resources/glossary') == true) {
        // Found a glossary link, extract its id from the url and
        // create the tooltip component.

        final id = Uri.parse(node.attributes['href']!).fragment;
        final entry = glossary.entries.where((e) => e.id == id).firstOrNull;

        if (entry == null) {
          // If the glossary entry is not found, keep the original node.
          processedNodes.add(node);
          continue;
        }

        processedNodes.add(
          ElementNode(
            'span',
            {'class': 'tooltip-wrapper'},
            [
              ElementNode('a', {
                ...node.attributes,
                'class': [
                  ?node.attributes['class'],
                  'tooltip-target',
                ].toClasses,
              }, node.children),
              ComponentNode(GlossaryTooltip(entry: entry)),
            ],
          ),
        );
      } else if (node is ElementNode && node.children != null) {
        processedNodes.add(
          ElementNode(
            node.tag,
            node.attributes,
            _processNodes(node.children!, glossary),
          ),
        );
      } else {
        processedNodes.add(node);
      }
    }

    return processedNodes;
  }
}

class GlossaryTooltip extends StatelessComponent {
  const GlossaryTooltip({required this.entry});

  final GlossaryEntry entry;

  @override
  Component build(BuildContext context) {
    return span(classes: 'tooltip', [
      span(classes: 'tooltip-header', [text(entry.term)]),
      span(classes: 'tooltip-content', [
        text(entry.shortDescription),
        text(' '),
        a(
          href: '/resources/glossary#${entry.id}',
          attributes: {
            'title':
                'Learn more about \'${entry.term}\' and '
                'find related resources.',
          },
          [text('Learn more')],
        ),
      ]),
    ]);
  }
}
