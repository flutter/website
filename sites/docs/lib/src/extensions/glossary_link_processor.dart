// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/common/client/simple_tooltip.dart';
import '../components/util/component_ref.dart';
import '../pages/glossary.dart';

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

        final target = a(
          href: node.attributes['href'] ?? '',
          attributes: node.attributes,
          [const NodesBuilder([]).build(node.children)],
        );
        final content = GlossaryTooltipContent(entry: entry);

        processedNodes.add(
          ComponentNode(
            Builder(
              builder: (context) {
                return SimpleTooltip(
                  target: context.ref(target),
                  content: context.ref(content),
                );
              },
            ),
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

class GlossaryTooltipContent extends StatelessComponent {
  const GlossaryTooltipContent({required this.entry});

  final GlossaryEntry entry;

  @override
  Component build(BuildContext context) {
    return span(classes: 'tooltip-content', [
      span(classes: 'tooltip-header', [.text(entry.term)]),
      span([
        .text('${entry.shortDescription} '),
        a(
          href: '/resources/glossary#${entry.id}',
          attributes: {
            'title':
                'Learn more about \'${entry.term}\' and '
                'find related resources.',
          },
          [const .text('Learn more')],
        ),
      ]),
    ]);
  }
}
