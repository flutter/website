// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/file_icon.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../src/markdown/markdown_parser.dart';
import '../../util.dart';
import 'material_icon.dart';

/// A single top-level file tree shown by an [IdeExplorer], such as
/// "Project" or "Global". It contains all of the 'files' (IdeTreeNodes)
/// inside the project thats displayed in the IDE.
///
/// When you have multiple projects to display, they're displayed as
/// tabs that you can switch between.
class IdeExplorerProjectRoot {
  const IdeExplorerProjectRoot({
    required this.id,
    this.label = '',
    this.children = const [],
  });

  final String id;
  final String label;
  final List<IdeTreeNode> children;

  factory IdeExplorerProjectRoot.fromMap(Map<Object?, Object?> map) {
    if (map case {
      'id': final String id,
      'label': final String label,
      'children': final List<Map<Object?, Object?>> children,
    }) {
      final treeNodes = children.map(IdeTreeNode.fromMap).toList();
      return IdeExplorerProjectRoot(
        id: id,
        label: label,
        children: treeNodes.toList(),
      );
    }

    throw Exception('Malformed IdeExplorerProjectRoot data');
  }
}

/// A single file or folder entry in an [IdeExplorer] tree.
class IdeTreeNode {
  const IdeTreeNode({
    required this.id,
    required this.label,
    this.startsClosed = false,
    this.badge,
    this.badgeColor,
    this.subtitle,
    this.note,
    this.title,
    this.children = const [],
  });

  final String id;
  final String label;
  final bool startsClosed;
  final String? badge;
  final IdeBadgeColor? badgeColor;
  final String? title;
  final String? subtitle;
  final String? note;
  final List<IdeTreeNode> children;

  bool get isFolder => children.isNotEmpty || label.endsWith('/');

  factory IdeTreeNode.fromMap(Map<Object?, Object?> map) {
    switch (map) {
      // explicit case to handle folder
      case {
            'id': final String id,
            'label': final String label,
            'children': final List<Map<Object?, Object?>> children,
          }
          when children.isNotEmpty || label.endsWith('/'):
        final treeNodes = children.map(IdeTreeNode.fromMap).toList();
        final startsClosed =
            map.containsKey('startsClosed') && map['startsClosed'] == true;

        return IdeTreeNode(
          id: id,
          label: label,
          startsClosed: startsClosed,
          badge: map['badge']?.toString(),
          badgeColor: IdeBadgeColor.fromString(map['badgeColor']?.toString()),
          title: map['title']?.toString(),
          subtitle: map['subtitle']?.toString(),
          note: map['note']?.toString(),
          children: treeNodes,
        );

      // explicit case to handle files
      case {
            'id': final String id,
            'label': final String label,
          }
          // Files shouldn't be empty, that's bad UX
          when map.containsKey('note'):
       
        return IdeTreeNode(
          id: id,
          label: label,
          badge: map['badge']?.toString(),
          badgeColor: IdeBadgeColor.fromString(map['badgeColor']?.toString()),
          title: map['title']?.toString() ?? label,
          subtitle: map['subtitle']?.toString() ?? '',
          note: map['note']!.toString(),
        );
      default:
        throw Exception('Malformed IdeTreeNode data');
    }
  }
}

/// Corresponds to colors used for badges on an [IdeTreeNode].
enum IdeBadgeColor {
  neutral,
  info,
  tip,
  important,
  warning,
  error;

  static IdeBadgeColor fromString(String? data) {
    if (data == null) return IdeBadgeColor.neutral;
    return switch (data.toLowerCase()) {
      'info' => IdeBadgeColor.info,
      'tip' => IdeBadgeColor.tip,
      'important' => IdeBadgeColor.important,
      'warning' => IdeBadgeColor.warning,
      'error' => IdeBadgeColor.error,
      _ => IdeBadgeColor.neutral,
    };
  }
}

/// A flattened [IdeTreeNode] paired with the path of ancestor labels
/// leading to it, used to render the breadcrumb in its detail pane.
typedef _BreadcrumbNode = ({IdeTreeNode node, String domId, List<String> path});

/// An interactive file-tree explorer, similar to an IDE's sidebar.
///
/// Renders a clickable directory tree next to a detail pane that shows
/// per-file/folder documentation: a description, tips, an example snippet,
/// and a link to learn more. Clicking an entry in the tree (or in a
/// folder's "Contents" list) swaps which detail pane is shown.
///
/// Can be constructed directly in Dart with [IdeExplorer.new] or
/// [IdeExplorer.fromNodes], or used in Markdown via `<IdeExplorer data="..." />`
/// powered by [DashIdeExplorer].
class IdeExplorer extends StatelessComponent {
  const IdeExplorer({
    super.key,
    required this.roots,
    this.instanceId,
    this.customContents = const {},
  });

  /// Creates an [IdeExplorer] with a single root from a list of [children].
  IdeExplorer.fromNodes({
    super.key,
    required List<IdeTreeNode> children,
    String rootLabel = '',
    this.instanceId,
    this.customContents = const {},
  }) : roots = [
         IdeExplorerProjectRoot(
           id: 'root',
           label: rootLabel,
           children: children,
         ),
       ];

  // Prevents DOM id collisions
  static int _nextInstanceId = 0;

  final List<IdeExplorerProjectRoot> roots;

  final String? instanceId;

  final Map<String, Component> customContents;

  String _domId(String effectiveInstanceId, String nodeId) =>
      'ide-$effectiveInstanceId-$nodeId';

  @override
  Component build(BuildContext context) {
    if (roots.isEmpty) {
      return const Component.empty();
    }

    final effectiveInstanceId = instanceId ?? '${_nextInstanceId++}';

    final flatNodesByRoot = {
      for (final root in roots)
        root.id: _flatten(
          root.children,
          instanceId: effectiveInstanceId,
          path: root.label.isEmpty ? [] : [root.label],
        ),
    };
    final allFlatNodes = flatNodesByRoot.values
        .expand((nodes) => nodes)
        .toList(growable: false);
    final firstNodeDomId = flatNodesByRoot[roots.first.id]?.firstOrNull?.domId;

    return div(classes: 'ide-explorer not-content', [
      div(classes: 'ide-sidebar', [
        if (roots.length > 1)
          div(
            classes: 'ide-root-tabs',
            attributes: {'role': 'tablist'},
            [
              for (final (rootIndex, root) in roots.indexed)
                button(
                  classes: [
                    'ide-root-tab',
                    if (rootIndex == 0) 'active',
                  ].toClasses,
                  attributes: {
                    'data-ide-root': root.id,
                    'role': 'tab',
                    'aria-selected': '${rootIndex == 0}',
                  },
                  [.text(root.label.isEmpty ? root.id : root.label)],
                ),
              _buildToggleAllButton(),
            ],
          )
        else
          div(classes: 'ide-root-tabs ide-root-tabs-single', [
            _buildToggleAllButton(),
          ]),
        for (final (rootIndex, root) in roots.indexed)
          div(
            classes: [
              'ide-tree',
              if (rootIndex == 0) 'active',
            ].toClasses,
            attributes: {'data-ide-root': root.id},
            [
              ul([
                for (final node in root.children)
                  _buildTreeNode(
                    node,
                    instanceId: effectiveInstanceId,
                    selectedDomId: firstNodeDomId,
                  ),
              ]),
            ],
          ),
      ]),
      div(classes: 'ide-detail', [
        for (final flat in allFlatNodes)
          _buildDetailPanel(
            flat,
            instanceId: effectiveInstanceId,
            isActive: flat.domId == firstNodeDomId,
          ),
      ]),
    ]);
  }

  Component _buildToggleAllButton() {
    return const button(
      classes: 'ide-toggle-all',
      type: ButtonType.button,
      attributes: {
        'data-ide-toggle-all': '',
        'title': 'Expand or collapse all folders',
        'aria-label': 'Expand or collapse all folders',
      },
      [
        MaterialIcon('unfold_more', label: 'Expand or collapse all folders'),
      ],
    );
  }

  List<_BreadcrumbNode> _flatten(
    List<IdeTreeNode> nodes, {
    required String instanceId,
    required List<String> path,
  }) {
    final result = <_BreadcrumbNode>[];
    for (final node in nodes) {
      final nodePath = [...path, node.label];
      result.add((
        node: node,
        domId: _domId(instanceId, node.id),
        path: path,
      ));
      result.addAll(
        _flatten(
          node.children,
          instanceId: instanceId,
          path: nodePath,
        ),
      );
    }
    return result;
  }

  Component _buildTreeNode(
    IdeTreeNode node, {
    required String instanceId,
    required String? selectedDomId,
  }) {
    final domId = _domId(instanceId, node.id);
    final isSelected = domId == selectedDomId;
    final icon = node.isFolder
        ? FileIcon.folderIcon
        : FileIcon.forFile(node.label);

    if (!node.isFolder) {
      return li(classes: 'ide-node ide-node-file', [
        button(
          classes: ['ide-node-row', if (isSelected) 'active'].toClasses,
          type: ButtonType.button,
          attributes: {
            'data-ide-select': domId,
            if (isSelected) 'aria-current': 'true',
          },
          [
            icon,
            span(classes: 'ide-node-label', [.text(node.label)]),
            _buildBadgeDot(
              node.badge,
              node.badgeColor ?? IdeBadgeColor.neutral,
            ),
          ],
        ),
      ]);
    }

    return li(classes: 'ide-node ide-node-folder', [
      details(
        open: !node.startsClosed,
        [
          summary(
            classes: isSelected ? 'active' : null,
            attributes: {
              'data-ide-select': domId,
              if (isSelected) 'aria-current': 'true',
            },
            [
              icon,
              span(classes: 'ide-node-label', [.text(node.label)]),
              _buildBadgeDot(
                node.badge,
                node.badgeColor ?? IdeBadgeColor.neutral,
              ),
            ],
          ),
          ul([
            for (final child in node.children)
              _buildTreeNode(
                child,
                instanceId: instanceId,
                selectedDomId: selectedDomId,
              ),
          ]),
        ],
      ),
    ]);
  }

  Component _buildBadgeDot(
    String? badge, [
    IdeBadgeColor color = IdeBadgeColor.neutral,
  ]) {
    if (badge == null) return const Component.empty();
    return span(
      classes: [
        'ide-badge-dot',
        'ide-badge-color-${color.name}',
        'ide-tone-${color.name}',
      ].toClasses,
      attributes: {
        'role': 'img',
        'aria-label': badge,
        'title': badge,
      },
      [],
    );
  }

  Component _buildDetailPanel(
    _BreadcrumbNode flat, {
    required String instanceId,
    required bool isActive,
  }) {
    final node = flat.node;

    return div(
      classes: ['ide-detail-panel', if (isActive) 'active'].toClasses,
      attributes: {'data-ide-panel': flat.domId},
      [
        if (flat.path.isNotEmpty)
          div(
            classes: 'ide-path',
            [
              for (final (i, segment) in flat.path.indexed) ...[
                if (i > 0) const span(classes: 'ide-path-sep', [.text('/')]),
                span([.text(segment.replaceFirst(RegExp(r'/$'), ''))]),
              ],
            ],
          ),
        div(classes: 'ide-detail-header', [
          node.isFolder ? FileIcon.folderIcon : FileIcon.forFile(node.label),
          div(classes: 'ide-detail-heading', [
            div(classes: 'ide-detail-title', [.text(node.title ?? node.label)]),
            if (node.subtitle case final subtitle?)
              div(classes: 'ide-detail-subtitle', [.text(subtitle)]),
          ]),
          if (node.badge case final badge?)
            span(
              classes: [
                'ide-badge',
                'ide-badge-color-'
                    '${node.badgeColor?.name ?? IdeBadgeColor.neutral.name}',
              ].toClasses,
              [.text(badge)],
            ),
        ]),

        if (customContents[node.id] case final customChild?)
          div(classes: 'ide-custom-body', [customChild])
        else ...[
          if (node.note case final note?)
            div(classes: 'ide-note', [
              if (node.title case final title?)
                div(classes: 'ide-note-title', [.text(title)]),
              DashMarkdown(content: note, inline: true),
            ]),
        ],

        if (node.children.isNotEmpty)
          div(classes: 'ide-contents', [
            const div(classes: 'ide-contents-title', [.text('Contents')]),
            div(classes: 'ide-contents-list', [
              for (final child in node.children)
                button(
                  classes: 'ide-content-link',
                  type: ButtonType.button,
                  attributes: {
                    'data-ide-select': _domId(instanceId, child.id),
                  },
                  [
                    child.isFolder
                        ? FileIcon.folderIcon
                        : FileIcon.forFile(child.label),
                    span(classes: 'ide-node-label', [.text(child.label)]),
                    if (child.subtitle case final subtitle?)
                      span(
                        classes: 'ide-content-one-liner',
                        [.text(subtitle)],
                      ),
                  ],
                ),
            ]),
          ]),
      ],
    );
  }
}

/// A custom markdown component wrapper for [IdeExplorer].
///
/// Can be authored in Markdown using HTML-like tags:
/// ```html
/// <IdeExplorer>
///   <IdeRoot label="my_project/" id="project">
///     <IdePage label="main.dart" subtitle="App entry point">
///       Main entry point content.
///     </IdePage>
///     <IdeFolder label="lib/">
///       <IdePage label="app.dart">
///         App widget definition.
///       </IdePage>
///     </IdeFolder>
///   </IdeRoot>
/// </IdeExplorer>
/// ```
///
/// Or referenced by a `data` attribute pointing to a YAML/JSON data key.
class DashIdeExplorer extends CustomComponent {
  const DashIdeExplorer() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode ||
        !(node.tag == 'IdeExplorer' || node.tag == 'DashIdeExplorer')) {
      return null;
    }

    final customContents = <String, Component>{};
    final roots = parseRootsFromNode(
      node,
      builder,
      customContents,
      rootLabel: node.attributes['rootLabel'],
    );

    if (roots.isEmpty && node.attributes['data'] != null) {
      final dataKey = node.attributes['data']!;
      return Builder(
        builder: (context) {
          final rawData = context.page.data[dataKey];
          if (rawData == null) {
            throw ArgumentError('No page data found for "$dataKey".');
          }

          final parsedRoots = parseRoots(
            rawData,
            rootLabel: node.attributes['rootLabel'],
          );

          return IdeExplorer(
            roots: parsedRoots,
            customContents: customContents,
          );
        },
      );
    }

    if (roots.isEmpty) {
      return const Component.empty();
    }

    return IdeExplorer(
      roots: roots,
      customContents: customContents,
    );
  }

  /// Parses [IdeExplorerProjectRoot]s from child AST [ElementNode]s.
  static List<IdeExplorerProjectRoot> parseRootsFromNode(
    ElementNode node,
    NodesBuilder builder,
    Map<String, Component> customContents, {
    String? rootLabel,
  }) {
    final directElementChildren =
        node.children?.whereType<ElementNode>().toList(growable: false) ?? [];

    final rootElements = directElementChildren
        .where((n) => n.tag == 'IdeRoot')
        .toList(growable: false);

    if (rootElements.isNotEmpty) {
      return [
        for (final (index, rootEl) in rootElements.indexed)
          IdeExplorerProjectRoot(
            id:
                rootEl.attributes['id'] ??
                (rootEl.attributes['label'] != null
                    ? slugify(rootEl.attributes['label']!)
                    : 'root-$index'),
            label: rootEl.attributes['label'] ?? '',
            children: _parseTreeNodes(rootEl.children, builder, customContents),
          ),
      ];
    }

    final treeElements = directElementChildren
        .where((n) => n.tag == 'IdeFolder' || n.tag == 'IdePage')
        .toList(growable: false);

    if (treeElements.isNotEmpty) {
      return [
        IdeExplorerProjectRoot(
          id: node.attributes['id'] ?? 'root',
          label: rootLabel ?? node.attributes['rootLabel'] ?? '',
          children: _parseTreeNodes(node.children, builder, customContents),
        ),
      ];
    }

    return const [];
  }

  static List<IdeTreeNode> _parseTreeNodes(
    List<Node>? nodes,
    NodesBuilder builder,
    Map<String, Component> customContents,
  ) {
    if (nodes == null || nodes.isEmpty) return const [];

    final result = <IdeTreeNode>[];

    for (final (index, child) in nodes.whereType<ElementNode>().indexed) {
      if (child.tag != 'IdeFolder' && child.tag != 'IdePage') {
        continue;
      }

      final label = child.attributes['label'] ?? child.attributes['name'] ?? '';
      final id =
          child.attributes['id'] ??
          (label.isNotEmpty ? slugify(label) : 'node-$index');
      final startsClosed =
          child.attributes['closed'] == 'true' ||
          child.attributes['startsClosed'] == 'true';

      final badge = child.attributes['badge'];
      final badgeColorStr =
          child.attributes['badgeColor'] ?? child.attributes['badgeTone'];
      final badgeColor = badgeColorStr != null
          ? IdeBadgeColor.fromString(badgeColorStr)
          : null;

      final subtitle = child.attributes['subtitle'];

      final nestedTreeNodes = _parseTreeNodes(
        child.children,
        builder,
        customContents,
      );

      final hasBody =
          child.children?.any((n) {
            if (n is ElementNode &&
                (n.tag == 'IdeFolder' || n.tag == 'IdePage')) {
              return false;
            }
            if (n is TextNode && n.text.trim().isEmpty) {
              return false;
            }
            return true;
          }) ??
          false;

      if (hasBody) {
        final contentNodes = child.children!
            .where((n) {
              if (n is ElementNode &&
                  (n.tag == 'IdeFolder' || n.tag == 'IdePage')) {
                return false;
              }
              return true;
            })
            .toList(growable: false);

        if (contentNodes.isNotEmpty) {
          customContents[id] = builder.build(contentNodes);
        }
      }

      result.add(
        IdeTreeNode(
          id: id,
          label: label,
          startsClosed: startsClosed,
          badge: badge,
          badgeColor: badgeColor,
          subtitle: subtitle,
          children: nestedTreeNodes,
        ),
      );
    }

    return result;
  }

  /// Parses raw page data (from YAML/JSON) into a list of [IdeExplorerProjectRoot]s.
  static List<IdeExplorerProjectRoot> parseRoots(
    Object? rawData, {
    String? rootLabel,
  }) {
    if (rawData is List) {
      return [
        IdeExplorerProjectRoot(
          id: 'root',
          label: rootLabel ?? '',
          children: rawData
              .whereType<Map<Object?, Object?>>()
              .map(IdeTreeNode.fromMap)
              .toList(growable: false),
        ),
      ];
    }

    if (rawData is Map) {
      final rawRoots = rawData['roots'];
      if (rawRoots is List) {
        return rawRoots
            .whereType<Map<Object?, Object?>>()
            .map(IdeExplorerProjectRoot.fromMap)
            .toList(growable: false);
      }
    }

    throw ArgumentError(
      'Invalid <IdeExplorer> data: expected a list of nodes, or a map with '
      'a "roots" list.',
    );
  }
}
