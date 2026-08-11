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

/// An interactive file-tree explorer, similar to an IDE's sidebar.
///
/// Renders a clickable directory tree next to a detail pane that shows
/// per-file/folder documentation: a description, tips, an example snippet,
/// and a link to learn more. Clicking an entry in the tree (or in a
/// folder's "Contents" list) swaps which detail pane is shown.
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
/// Each node supports: `id` (required, unique), `label` (required),
/// `type` (`file` or `folder`; inferred from `children`/a trailing `/`
/// when omitted), `closed` (folders are expanded by default), `badge`
/// (a short string, or a map with `label` and `tone` of `info`, `success`,
/// `warning`, or `neutral`), `oneLiner`, `note`/`noteTitle` (a short
/// highlighted callout), `description` (Markdown), `tips` (a list of
/// Markdown strings), `example`/`exampleLanguage`/`exampleTitle` (a
/// syntax-highlighted, copyable snippet), `docsLink`/`docsLinkLabel`, and
/// nested `children`.
///
/// Usage from Markdown: `<IdeExplorer data="myTreeData" />`.
class IdeExplorer extends CustomComponentBase {
  const IdeExplorer();

  static int _nextInstanceId = 0;

  @override
  Pattern get pattern => 'IdeExplorer';

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

        final roots = _parseRoots(rawData, rootLabel: attributes['rootLabel']);

        return _IdeExplorer(
          instanceId: '${_nextInstanceId++}',
          roots: roots,
        );
      },
    );
  }

  static List<IdeExplorerRoot> _parseRoots(
    Object? rawData, {
    String? rootLabel,
  }) {
    if (rawData is List) {
      return [
        IdeExplorerRoot._({
          'id': 'root',
          'label': rootLabel ?? '',
          'children': rawData,
        }),
      ];
    }

    if (rawData is Map) {
      final data = rawData.cast<String, Object?>();
      final rawRoots = data['roots'];
      if (rawRoots is List) {
        return rawRoots
            .cast<Map<Object?, Object?>>()
            .map((root) => IdeExplorerRoot._(root.cast<String, Object?>()))
            .toList(growable: false);
      }
    }

    throw ArgumentError(
      'Invalid <IdeExplorer> data: expected a list of nodes, or a map with '
      'a "roots" list.',
    );
  }
}

/// A single top-level tree shown by an [IdeExplorer], such as "Project" or
/// "Global".
extension type IdeExplorerRoot._(Map<String, Object?> _data) {
  String get id => _data['id'] as String;
  String get label => _data['label'] as String? ?? '';

  List<IdeTreeNode> get children =>
      (_data['children'] as List<Object?>? ?? const [])
          .cast<Map<Object?, Object?>>()
          .map((node) => IdeTreeNode._(node.cast<String, Object?>()))
          .toList(growable: false);
}

/// A single file or folder entry in an [IdeExplorer] tree.
extension type IdeTreeNode._(Map<String, Object?> _data) {
  String get id => _data['id'] as String;
  String get label => _data['label'] as String;

  List<IdeTreeNode> get children =>
      (_data['children'] as List<Object?>? ?? const [])
          .cast<Map<Object?, Object?>>()
          .map((node) => IdeTreeNode._(node.cast<String, Object?>()))
          .toList(growable: false);

  bool get isFolder =>
      (_data['type'] as String?) == 'folder' ||
      children.isNotEmpty ||
      label.endsWith('/');

  /// Whether a folder should render collapsed by default.
  bool get startsClosed => _data['closed'] == true;

  IdeBadge? get badge => switch (_data['badge']) {
    final String label => IdeBadge(label: label),
    final Map<Object?, Object?> map => IdeBadge(
      label: map['label'] as String,
      tone: switch (map['tone']) {
        'info' => .info,
        'success' => .success,
        'warning' => .warning,
        _ => .neutral,
      },
    ),
    _ => null,
  };

  String? get oneLiner => _data['oneLiner'] as String?;
  String? get note => _data['note'] as String?;
  String? get noteTitle => _data['noteTitle'] as String?;
  String? get description => _data['description'] as String?;

  List<String> get tips =>
      (_data['tips'] as List<Object?>? ?? const []).cast<String>();

  String? get example => _data['example'] as String?;
  String get exampleLanguage =>
      _data['exampleLanguage'] as String? ?? 'plaintext';
  String get exampleTitle => _data['exampleTitle'] as String? ?? label;

  String? get docsLink => _data['docsLink'] as String?;
  String get docsLinkLabel => _data['docsLinkLabel'] as String? ?? 'Learn more';
}

/// A short highlighted label attached to an [IdeTreeNode], such as
/// "committed" or "gitignored".
final class IdeBadge {
  const IdeBadge({required this.label, this.tone = IdeBadgeTone.neutral});

  final String label;
  final IdeBadgeTone tone;
}

enum IdeBadgeTone { neutral, info, success, warning }

/// A flattened [IdeTreeNode] paired with the path of ancestor labels
/// leading to it, used to render the breadcrumb in its detail pane.
typedef _FlatNode = ({IdeTreeNode node, String domId, List<String> path});

class _IdeExplorer extends StatelessComponent {
  const _IdeExplorer({required this.instanceId, required this.roots});

  final String instanceId;
  final List<IdeExplorerRoot> roots;

  String _domId(String nodeId) => 'ide-$instanceId-$nodeId';

  @override
  Component build(BuildContext context) {
    final flatNodesByRoot = {
      for (final root in roots)
        root.id: _flatten(
          root.children,
          path: root.label.isEmpty ? [] : [root.label],
        ),
    };
    final allFlatNodes = flatNodesByRoot.values
        .expand((nodes) => nodes)
        .toList();
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
                  attributes: {'data-ide-root': root.id},
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
                  _buildTreeNode(node, selectedDomId: firstNodeDomId),
              ]),
            ],
          ),
      ]),
      div(classes: 'ide-detail', [
        for (final flat in allFlatNodes)
          _buildDetailPanel(flat, isActive: flat.domId == firstNodeDomId),
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
      },
      [
        MaterialIcon('unfold_more', label: 'Expand or collapse all folders'),
      ],
    );
  }

  List<_FlatNode> _flatten(
    List<IdeTreeNode> nodes, {
    required List<String> path,
  }) {
    final result = <_FlatNode>[];
    for (final node in nodes) {
      final nodePath = [...path, node.label];
      result.add((node: node, domId: _domId(node.id), path: path));
      result.addAll(_flatten(node.children, path: nodePath));
    }
    return result;
  }

  Component _buildTreeNode(IdeTreeNode node, {required String? selectedDomId}) {
    final domId = _domId(node.id);
    final isSelected = domId == selectedDomId;
    final icon = node.isFolder
        ? FileIcon.folderIcon
        : FileIcon.forFile(node.label);

    if (!node.isFolder) {
      return li(classes: 'ide-node ide-node-file', [
        button(
          classes: ['ide-node-row', if (isSelected) 'active'].toClasses,
          type: ButtonType.button,
          attributes: {'data-ide-select': domId},
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
            attributes: {'data-ide-select': domId, 'tabindex': '0'},
            [
              icon,
              span(classes: 'ide-node-label', [.text(node.label)]),
              _buildBadgeDot(node.badge),
            ],
          ),
          ul([
            for (final child in node.children)
              _buildTreeNode(child, selectedDomId: selectedDomId),
          ]),
        ],
      ),
    ]);
  }

  Component _buildBadgeDot(IdeBadge? badge) {
    if (badge == null) return const Component.empty();
    return span(
      classes: ['ide-badge-dot', 'ide-tone-${badge.tone.name}'].toClasses,
      attributes: {'title': badge.label},
      [],
    );
  }

  Component _buildDetailPanel(_FlatNode flat, {required bool isActive}) {
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
              classes: ['ide-badge', 'ide-tone-${badge.tone.name}'].toClasses,
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
          div(classes: 'ide-description', [DashMarkdown(content: description)]),
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
                  for (final line in example.split('\n'))
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
                  attributes: {'data-ide-select': _domId(child.id)},
                  [
                    child.isFolder
                        ? FileIcon.folderIcon
                        : FileIcon.forFile(child.label),
                    span(classes: 'ide-node-label', [.text(child.label)]),
                    if (child.oneLiner case final oneLiner?)
                      span(classes: 'ide-content-one-liner', [.text(oneLiner)]),
                  ],
                ),
            ]),
          ]),
      ],
    );
  }
}
