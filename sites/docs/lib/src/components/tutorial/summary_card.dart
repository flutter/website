// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:yaml/yaml.dart';

import '../../markdown/markdown_parser.dart';
import '../../models/summary_card_model.dart';
import '../common/material_icon.dart';

class SummaryCard extends CustomComponent {
  const SummaryCard() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is ElementNode && node.tag.toLowerCase() == 'summarycard') {
      if (node.children?.whereType<ElementNode>().isNotEmpty ?? false) {
        throw Exception(
          'Invalid SummaryCard content. Remove any leading empty lines to '
          'avoid parsing as markdown.',
        );
      }

      final content = node.children?.map((n) => n.innerText).join('\n') ?? '';
      final data = loadYamlNode(content);
      assert(
        data is YamlMap,
        'Invalid SummaryCard content. Expected a YAML map.',
      );
      final model = SummaryCardModel.fromMap(data as YamlMap);
      assert(
        model.items.isNotEmpty,
        'SummaryCard must contain at least one item.',
      );

      final expandsAttr = node.attributes['expands'];
      final expands = expandsAttr != 'false';

      return SummaryCardComponent(model: model, expands: expands);
    }
    return null;
  }
}

class SummaryCardComponent extends StatelessComponent {
  const SummaryCardComponent({
    super.key,
    required this.model,
    this.expands = true,
  });

  final SummaryCardModel model;
  final bool expands;

  @override
  Component build(BuildContext context) {
    return div(classes: 'summary-card', [
      header([
        div([
          h3([.text(model.title)]),
          if (model.subtitle case final subtitle?) span([.text(subtitle)]),
        ]),
        if (model.completed)
          const span(classes: 'summary-card-completed', [
            MaterialIcon('check_circle'),
          ]),
      ]),
      for (final item in model.items) _buildSummaryItem(item),
    ]);
  }

  Component _buildSummaryItem(SummaryCardItem item) {
    if (item.details case final d?) {
      if (!expands) {
        return div(classes: 'summary-card-item-static', [
          div(classes: 'summary-card-item', [
            span([MaterialIcon(item.icon)]),
            span(classes: 'summary-card-item-title', [.text(item.title)]),
          ]),
          div(classes: 'summary-card-item-details', [
            DashMarkdown(content: d),
          ]),
        ]);
      }
      return details([
        summary(classes: 'summary-card-item', [
          span([MaterialIcon(item.icon)]),
          span(classes: 'summary-card-item-title', [.text(item.title)]),
          const MaterialIcon('keyboard_arrow_up'),
        ]),
        div(classes: 'summary-card-item-details', [
          DashMarkdown(content: d),
        ]),
      ]);
    }
    return div(classes: 'summary-card-item', [
      span([MaterialIcon(item.icon)]),
      span(classes: 'summary-card-item-title', [.text(item.title)]),
    ]);
  }
}
