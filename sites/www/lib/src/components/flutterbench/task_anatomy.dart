// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/ide_explorer/ide_explorer.dart';
import 'package:site_shared/components/common/ide_explorer/models.dart';

import '../../models/content/flutterbench_content.dart';
import 'methodology_components.dart';

/// Maps [FlutterBenchTaskTreeNode] data into the [IdeTreeNode] tree consumed
/// by [IdeExplorer]'s sidebar.
List<IdeTreeNode> buildIdeTreeNodes(List<FlutterBenchTaskTreeNode> nodes) {
  return [for (final node in nodes) _buildIdeTreeNode(node)];
}

IdeTreeNode _buildIdeTreeNode(FlutterBenchTaskTreeNode node) {
  final badgeColor = node.badgeColor == null
      ? null
      : IdeBadgeColor.fromString(node.badgeColor!);

  if (node.type == 'folder') {
    return IdeFolderNode(
      id: node.id,
      label: node.label,
      subtitle: node.subtitle,
      badge: node.badge,
      badgeColor: badgeColor,
      isDefaultPage: node.isDefaultPage,
      startsClosed: node.startsClosed,
      children: buildIdeTreeNodes(node.children),
    );
  }

  return IdeFileNode(
    id: node.id,
    label: node.label,
    subtitle: node.subtitle,
    badge: node.badge,
    badgeColor: badgeColor,
    isDefaultPage: node.isDefaultPage,
  );
}

/// Flattens [FlutterBenchTaskTreeNode] data (including nested children) into
/// a map of node id to the detail-pane [Component] [IdeExplorer] should show
/// for it, built from each node's prose `body` and optional `code` sample.
Map<String, Component> buildIdeCustomContents(
  List<FlutterBenchTaskTreeNode> nodes,
) {
  final contents = <String, Component>{};
  for (final node in nodes) {
    contents[node.id] = _buildNodeDetail(node);
    contents.addAll(buildIdeCustomContents(node.children));
  }
  return contents;
}

Component _buildNodeDetail(FlutterBenchTaskTreeNode node) {
  final children = <Component>[];

  final body = node.body;
  if (body != null && body.isNotEmpty) {
    for (final paragraph in body.split('\n\n')) {
      if (paragraph.trim().isEmpty) continue;
      children.add(p([renderDescriptionWithCode(paragraph)]));
    }
  }

  final codeSample = node.code;
  if (codeSample != null) {
    children.add(
      div(classes: 'code-block-wrapper', [
        pre([
          code(classes: 'language-${codeSample.lang}', [
            .text(codeSample.text),
          ]),
        ]),
      ]),
    );
  }

  return .fragment(children);
}
