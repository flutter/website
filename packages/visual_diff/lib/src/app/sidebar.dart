// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../models/diff_entry.dart';
import '../models/diff_manifest.dart';
import '../models/diff_route.dart';
import '../models/route_tree_node.dart';

/// The sidebar containing the search bar, status filters, and the VS Code
/// inspired route tree.
class SidebarComponent extends StatefulComponent {
  final DiffManifest manifest;
  final List<DiffRoute> filteredRoutes;
  final DiffRoute? selectedRoute;
  final ValueChanged<DiffRoute> onSelectRoute;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final String statusFilter;
  final ValueChanged<String> onStatusFilterChanged;
  final Map<String, DiffRoute> allRoutes;

  const SidebarComponent({
    required this.manifest,
    required this.filteredRoutes,
    required this.selectedRoute,
    required this.onSelectRoute,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.statusFilter,
    required this.onStatusFilterChanged,
    required this.allRoutes,
    super.key,
  });

  @override
  State<SidebarComponent> createState() => _SidebarComponentState();
}

class _SidebarComponentState extends State<SidebarComponent> {
  final Set<String> _expandedPaths = {};
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _autoExpandChangedNodes();
  }

  @override
  void didUpdateComponent(SidebarComponent oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.searchQuery != component.searchQuery ||
        oldComponent.statusFilter != component.statusFilter ||
        oldComponent.filteredRoutes.length != component.filteredRoutes.length) {
      _autoExpandChangedNodes();
    }
  }

  void _autoExpandChangedNodes() {
    final root = RouteTreeNode.buildTree(component.filteredRoutes);
    void collectExpanded(RouteTreeNode node) {
      if (node.isExpanded ||
          node.changedCount > 0 ||
          component.searchQuery.isNotEmpty) {
        _expandedPaths.add(node.path);
      }
      for (final child in node.children.values) {
        collectExpanded(child);
      }
    }

    collectExpanded(root);
    _initialized = true;
  }

  void _expandAll(RouteTreeNode root) {
    setState(() {
      void collectAll(RouteTreeNode node) {
        _expandedPaths.add(node.path);
        for (final child in node.children.values) {
          collectAll(child);
        }
      }

      collectAll(root);
    });
  }

  void _collapseAll() {
    setState(() {
      _expandedPaths.clear();
      _expandedPaths.add('/');
    });
  }

  void _toggleExpand(String path) {
    setState(() {
      if (_expandedPaths.contains(path)) {
        _expandedPaths.remove(path);
      } else {
        _expandedPaths.add(path);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final allRoutesList = component.allRoutes.values.toList();
    final totalUniqueRoutes = allRoutesList.length;
    final changedRoutes = allRoutesList
        .where((r) => r.status == DiffStatus.changed)
        .length;
    final addedRoutes = allRoutesList
        .where((r) => r.status == DiffStatus.added)
        .length;
    final removedRoutes = allRoutesList
        .where((r) => r.status == DiffStatus.removed)
        .length;
    final unchangedRoutes = allRoutesList
        .where((r) => r.status == DiffStatus.unchanged)
        .length;

    final treeRoot = RouteTreeNode.buildTree(component.filteredRoutes);

    // Synchronize tree node expansion with state set
    void applyExpansionState(RouteTreeNode node) {
      if (_expandedPaths.contains(node.path)) {
        node.isExpanded = true;
      } else if (_initialized) {
        node.isExpanded = false;
      }
      for (final child in node.children.values) {
        applyExpansionState(child);
      }
    }

    applyExpansionState(treeRoot);

    return aside(classes: 'vd-sidebar', [
      // Search and Filter controls
      div(classes: 'vd-sidebar-search', [
        div(classes: 'vd-search-wrapper', [
          const span(classes: 'vd-search-icon', [.text('🔍')]),
          input(
            id: 'vd-search-input',
            classes: 'vd-search-input',
            type: InputType.text,
            attributes: {
              'placeholder': 'Search routes (Press /)...',
              'value': component.searchQuery,
            },
            events: {
              'input': (e) {
                if (e.target case final web.HTMLInputElement inputEl) {
                  component.onSearchChanged(inputEl.value);
                }
              },
            },
          ),
          if (component.searchQuery.isNotEmpty)
            button(
              classes: 'vd-icon-btn',
              attributes: const {
                'style':
                    'position: absolute; right: 60px; '
                    'width: 20px; height: 20px; border: none; font-size: 11px;',
              },
              events: {'click': (_) => component.onSearchChanged('')},
              const [.text('✕')],
            ),
          // Tree actions: Expand / Collapse all
          div(
            attributes: const {
              'style': 'display: flex; gap: 2px; margin-left: 6px;',
            },
            [
              button(
                classes: 'vd-icon-btn',
                attributes: const {
                  'title': 'Expand all folders',
                  'style': 'font-size: 13px; width: 24px; height: 24px;',
                },
                events: {'click': (_) => _expandAll(treeRoot)},
                const [.text('⊞')],
              ),
              button(
                classes: 'vd-icon-btn',
                attributes: const {
                  'title': 'Collapse all folders',
                  'style': 'font-size: 13px; width: 24px; height: 24px;',
                },
                events: {'click': (_) => _collapseAll()},
                const [.text('⊟')],
              ),
            ],
          ),
        ]),

        // Status filter tabs for deduplicated routes
        div(classes: 'vd-status-filters', [
          for (final filter in [
            ('all', 'All', totalUniqueRoutes),
            ('changed', 'Changed', changedRoutes),
            ('added', 'Added', addedRoutes),
            ('removed', 'Removed', removedRoutes),
            ('unchanged', 'Unchanged', unchangedRoutes),
          ])
            if (filter.$3 > 0 || filter.$1 == 'all')
              button(
                classes: [
                  'vd-filter-pill',
                  if (component.statusFilter == filter.$1) 'active',
                ].join(' '),
                events: {
                  'click': (_) => component.onStatusFilterChanged(filter.$1),
                },
                [
                  .text(filter.$2),
                  span(classes: 'vd-count', [.text('(${filter.$3})')]),
                ],
              ),
        ]),
      ]),

      // Scrollable route tree list
      div(classes: 'vd-route-list', [
        if (component.filteredRoutes.isEmpty)
          const div(
            attributes: {
              'style':
                  'padding: 32px 16px; text-align: center; '
                  'color: var(--vd-text-muted); font-size: 13px;',
            },
            [.text('No matching routes found.')],
          )
        else
          div(classes: 'vd-tree-container', [
            // Render root if it has a route
            if (treeRoot.route != null)
              _buildTreeNodeRow(
                node: treeRoot,
                depth: 0,
                selectedRoute: component.selectedRoute,
                onSelectRoute: component.onSelectRoute,
                onToggleExpand: _toggleExpand,
              ),
            // Render all children recursively
            for (final child in treeRoot.children.values)
              ..._renderSubtree(
                node: child,
                depth: 0,
                selectedRoute: component.selectedRoute,
                onSelectRoute: component.onSelectRoute,
                onToggleExpand: _toggleExpand,
              ),
          ]),
      ]),
    ]);
  }

  List<Component> _renderSubtree({
    required RouteTreeNode node,
    required int depth,
    required DiffRoute? selectedRoute,
    required ValueChanged<DiffRoute> onSelectRoute,
    required ValueChanged<String> onToggleExpand,
  }) {
    final rows = <Component>[
      _buildTreeNodeRow(
        node: node,
        depth: depth,
        selectedRoute: selectedRoute,
        onSelectRoute: onSelectRoute,
        onToggleExpand: onToggleExpand,
      ),
    ];

    if (node.isFolder && node.isExpanded) {
      for (final child in node.children.values) {
        rows.addAll(
          _renderSubtree(
            node: child,
            depth: depth + 1,
            selectedRoute: selectedRoute,
            onSelectRoute: onSelectRoute,
            onToggleExpand: onToggleExpand,
          ),
        );
      }
    }

    return rows;
  }

  Component _buildTreeNodeRow({
    required RouteTreeNode node,
    required int depth,
    required DiffRoute? selectedRoute,
    required ValueChanged<DiffRoute> onSelectRoute,
    required ValueChanged<String> onToggleExpand,
  }) {
    final isSelected =
        selectedRoute != null && selectedRoute.route == node.path;
    final isFolder = node.isFolder;
    final hasRoute = node.route != null;
    final nodeStatus = node.status;
    final changedCount = node.changedCount;

    return div(
      classes: [
        'vd-tree-node',
        if (isSelected) 'selected',
        if (isFolder) 'is-folder',
      ].join(' '),
      attributes: {
        'style': 'padding-left: ${6 + depth * 14}px;',
      },
      events: {
        'click': (_) {
          if (isFolder) {
            onToggleExpand(node.path);
          }
          if (hasRoute) {
            onSelectRoute(node.route!);
          }
        },
      },
      [
        // Chevron (for folders)
        if (isFolder)
          span(
            classes: 'vd-tree-chevron',
            events: {
              'click': (e) {
                if (e case final web.MouseEvent me) {
                  me.stopPropagation();
                }
                onToggleExpand(node.path);
              },
            },
            [.text(node.isExpanded ? '▾' : '▸')],
          )
        else
          const span(
            classes: 'vd-tree-spacer',
            attributes: {'style': 'width: 20px; display: inline-block;'},
            [],
          ),

        // Status circle dot icon (inspired by VS Code test tree)
        span(
          classes: 'vd-status-dot ${nodeStatus.name}',
          attributes: {
            'title': 'Status: ${nodeStatus.name}',
          },
          [
            .text(nodeStatus == DiffStatus.unchanged ? '○' : '●'),
          ],
        ),

        // Concise label (segment name)
        span(
          classes: 'vd-tree-label',
          attributes: {'title': node.path},
          [
            .text(node.segment.isEmpty ? '/ (home)' : node.segment),
          ],
        ),

        // Changed badge or diff percentage
        if (isFolder && changedCount > 0)
          span(
            classes: 'vd-badge vd-badge-changed',
            attributes: const {
              'style': 'font-size: 9px; padding: 1px 5px; margin-left: 4px;',
            },
            [.text('$changedCount')],
          )
        else if (hasRoute && node.route!.hasDiff)
          span(
            classes: 'vd-badge vd-badge-${node.route!.status.name}',
            attributes: const {
              'style': 'font-size: 9px; padding: 1px 5px; margin-left: 4px;',
            },
            [
              .text(
                '${node.route!.maxDiffPercentage.toStringAsFixed(1)}%',
              ),
            ],
          ),
      ],
    );
  }
}
