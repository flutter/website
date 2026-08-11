// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/file_icon.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../../src/extensions/code_block_processor.dart';
import '../../src/markdown/markdown_parser.dart';
import '../../util.dart';
import 'material_icon.dart';
import 'wrapped_code_block.dart';

/// A single top-level tree shown by an [IdeExplorer], such as
/// "Project" or "Global". It contains all of the 'files' (IdeTreeNodes)
/// inside the project thats displayed in the IDE. 
/// 
/// When you have multiple projects to display, they're displayed as
/// tabs that you can switch between.
/// 
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
    final id = map['id']?.toString() ?? 'root';
    final label = map['label']?.toString() ?? '';
    final rawChildren = map['children'];
    final children = switch (rawChildren) {
      final List<Object?> list =>
        list
            .whereType<Map<Object?, Object?>>()
            .map(IdeTreeNode.fromMap)
            .toList(growable: false),
      _ => const <IdeTreeNode>[],
    };

    return IdeExplorerProjectRoot(
      id: id,
      label: label,
      children: children,
    );
  }
}

/// A single file or folder entry in an [IdeExplorer] tree.
class IdeTreeNode {
  const IdeTreeNode({
    required this.id,
    required this.label,
    bool? isFolder,
    this.startsClosed = false,
    this.badge,
    this.oneLiner,
    this.note,
    this.noteTitle,
    this.description,
    this.tips = const [],
    this.example,
    this.exampleLanguage = 'plaintext',
    this.exampleTitle,
    this.docsLink,
    this.docsLinkLabel = 'Learn more',
    this.children = const [],
  }) : _explicitIsFolder = isFolder;

  final String id;
  final String label;
  final bool? _explicitIsFolder;
  final bool startsClosed;
  final IdeBadge? badge;
  final String? oneLiner;
  final String? note;
  final String? noteTitle;
  final String? description;
  final List<String> tips;
  final String? example;
  final String exampleLanguage;
  final String? exampleTitle;
  final String? docsLink;
  final String docsLinkLabel;
  final List<IdeTreeNode> children;

  bool get isFolder =>
      _explicitIsFolder ?? (children.isNotEmpty || label.endsWith('/'));

  factory IdeTreeNode.fromMap(Map<Object?, Object?> map) {
    final id = map['id']?.toString() ?? '';
    final label = map['label']?.toString() ?? '';
    final type = map['type']?.toString();
    final isFolder = type != null ? type == 'folder' : null;
    final startsClosed = map['closed'] == true;
    final badge = map['badge'] != null ? IdeBadge.from(map['badge']) : null;
    final oneLiner = map['oneLiner']?.toString();
    final note = map['note']?.toString();
    final noteTitle = map['noteTitle']?.toString();
    final description = map['description']?.toString();
    final rawTips = map['tips'];
    final tips = switch (rawTips) {
      final List<Object?> list =>
        list
            .map((e) => e?.toString() ?? '')
            .where((tip) => tip.isNotEmpty)
            .toList(growable: false),
      _ => const <String>[],
    };
    final example = map['example']?.toString();
    final exampleLanguage = map['exampleLanguage']?.toString() ?? 'plaintext';
    final exampleTitle = map['exampleTitle']?.toString();
    final docsLink = map['docsLink']?.toString();
    final docsLinkLabel = map['docsLinkLabel']?.toString() ?? 'Learn more';
    final rawChildren = map['children'];
    final children = switch (rawChildren) {
      final List<Object?> list =>
        list
            .whereType<Map<Object?, Object?>>()
            .map(IdeTreeNode.fromMap)
            .toList(growable: false),
      _ => const <IdeTreeNode>[],
    };

    return IdeTreeNode(
      id: id,
      label: label,
      isFolder: isFolder,
      startsClosed: startsClosed,
      badge: badge,
      oneLiner: oneLiner,
      note: note,
      noteTitle: noteTitle,
      description: description,
      tips: tips,
      example: example,
      exampleLanguage: exampleLanguage,
      exampleTitle: exampleTitle,
      docsLink: docsLink,
      docsLinkLabel: docsLinkLabel,
      children: children,
    );
  }
}

/// Corresponds to colors used for the [IdeBadge]
enum IdeBadgeTone { neutral, info, success, warning }

/// A highlighted pill-style label displayed next to an [IdeTreeNode] title.
/// Intended to be used to display a single word of crucial metadata,
/// e.g. if you were including pubspec.lock in the component,
/// you could add "gitignored".
final class IdeBadge {
  const IdeBadge({
    required this.label,
    this.tone = IdeBadgeTone.neutral,
  });

  final String label;
  final IdeBadgeTone tone;

  factory IdeBadge.from(Object? data) {
    if (data is String) {
      return IdeBadge(label: data);
    }
    if (data is Map<Object?, Object?>) {
      final label = data['label']?.toString() ?? '';
      final toneStr = data['tone']?.toString();
      final tone = switch (toneStr) {
        'info' => IdeBadgeTone.info,
        'success' => IdeBadgeTone.success,
        'warning' => IdeBadgeTone.warning,
        _ => IdeBadgeTone.neutral,
      };
      return IdeBadge(label: label, tone: tone);
    }
    throw ArgumentError('Invalid badge data: $data');
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
  });

  /// Creates an [IdeExplorer] with a single root from a list of [children].
  IdeExplorer.fromNodes({
    super.key,
    required List<IdeTreeNode> children,
    String rootLabel = '',
    this.instanceId,
  }) : roots = [
         IdeExplorerProjectRoot(
           id: 'root',
           label: rootLabel,
           children: children,
         ),
       ];

  // TODO: What is this used for? Is it not always 0 given that its static?
  static int _nextInstanceId = 0;

  final List<IdeExplorerProjectRoot> roots;

  final String? instanceId;

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

  // TODO: The _BreadcumbNode class can just be a record
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
            _buildBadgeDot(node.badge),
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
              _buildBadgeDot(node.badge),
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

  Component _buildBadgeDot(IdeBadge? badge) {
    if (badge == null) return const Component.empty();
    return span(
      classes: ['ide-badge-dot', 'ide-tone-${badge.tone.name}'].toClasses,
      attributes: {
        'role': 'img',
        'aria-label': badge.label,
        'title': badge.label,
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
            div(classes: 'ide-detail-title', [.text(node.label)]),
            if (node.oneLiner case final oneLiner?)
              div(classes: 'ide-detail-one-liner', [.text(oneLiner)]),
          ]),
          if (node.badge case final badge?)
            span(
              classes: [
                'ide-badge',
                'ide-tone-${badge.tone.name}',
              ].toClasses,
              [.text(badge.label)],
            ),
        ]),
        if (node.note case final note?)
          div(classes: 'ide-note', [
            if (node.noteTitle case final title?)
              div(classes: 'ide-note-title', [.text(title)]),
            DashMarkdown(content: note, inline: true),
          ]),
        if (node.description case final description?)
          div(
            classes: 'ide-description',
            [DashMarkdown(content: description)],
          ),
        if (node.tips.isNotEmpty)
          div(classes: 'ide-tips', [
            const div(classes: 'ide-tips-title', [.text('Tips')]),
            ul([
              for (final tip in node.tips)
                li([DashMarkdown(content: tip, inline: true)]),
            ]),
          ]),
        if (node.example case final example?)
          div(classes: 'ide-example', [
            WrappedCodeBlock(
              content: CodeBlockProcessor.highlightCode(
                [
                  for (final line in example.trimRight().split('\n'))
                    CodeLine(content: line, highlights: const []),
                ],
                language: node.exampleLanguage,
              ),
              language: node.exampleLanguage,
              title: node.exampleTitle,
            ),
          ]),
        if (node.docsLink case final docsLink?)
          a(href: docsLink, classes: 'ide-docs-link', [
            .text(node.docsLinkLabel),
            const MaterialIcon('arrow_forward'),
          ]),
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
                    if (child.oneLiner case final oneLiner?)
                      span(
                        classes: 'ide-content-one-liner',
                        [.text(oneLiner)],
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
/// The tree is authored as data, referenced by the required `data`
/// attribute, which names a top-level key in the page's data (loaded from
/// a YAML/JSON file in the site's `src/data` directory). The data can
/// either be a single list of nodes, or a map with a `roots` list if the
/// explorer should offer more than one top-level tree (e.g. "Project" and
/// "Global", shown as tabs above the sidebar):
///
/// ```yaml
/// # A single implicit root:
/// - id: main-dart
///   label: main.dart
///   oneLiner: The app's entry point.
///   example: |
///     void main() => runApp(const MyApp());
///   exampleLanguage: dart
///
/// # Or, multiple named roots shown as tabs:
/// roots:
///   - id: project
///     label: my_app/
///     children: [ ... ]
///   - id: global
///     label: "~/"
///     children: [ ... ]
/// ```
///
/// Usage from Markdown: `<IdeExplorer data="myTreeData" />`.
class DashIdeExplorer extends CustomComponentBase {
  const DashIdeExplorer();

  @override
  Pattern get pattern => RegExp(r'^(Dash)?IdeExplorer$', caseSensitive: false);

  @override
  Component apply(
    String name,
    Map<String, String> attributes,
    Component? child,
  ) {
    final dataKey = attributes['data'];
    if (dataKey == null) {
      throw ArgumentError(
        'The <IdeExplorer> element requires a "data" attribute naming a key '
        'in the page data.',
      );
    }

    return Builder(
      builder: (context) {
        final rawData = context.page.data[dataKey];
        if (rawData == null) {
          throw ArgumentError('No page data found for "$dataKey".');
        }

        final roots = parseRoots(rawData, rootLabel: attributes['rootLabel']);

        return IdeExplorer(roots: roots);
      },
    );
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
