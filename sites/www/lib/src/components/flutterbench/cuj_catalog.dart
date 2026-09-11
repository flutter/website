// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';

import '../common/filters.dart';

/// The five FlutterBench CUJ personas, in catalog display order.
const List<String> cujPersonas = [
  'The App Developer',
  'The Tech Lead / Architect',
  'The Plugin Developer',
  'The Full Stack Developer',
  'The Hybrid (Native + Flutter) Developer',
];

/// A short, reader-facing label for a raw CUJ persona value.
String personaLabel(String persona) => switch (persona) {
  'The App Developer' => 'App developer',
  'The Tech Lead / Architect' => 'Tech lead / architect',
  'The Plugin Developer' => 'Plugin developer',
  'The Full Stack Developer' => 'Full-stack developer',
  'The Hybrid (Native + Flutter) Developer' => 'Hybrid developer',
  _ => persona,
};

/// A CSS color-modifier slug for a raw CUJ persona value.
String _personaColorClass(String persona) => switch (persona) {
  'The App Developer' => 'blue',
  'The Tech Lead / Architect' => 'purple',
  'The Plugin Developer' => 'teal',
  'The Full Stack Developer' => 'magenta',
  'The Hybrid (Native + Flutter) Developer' => 'amber',
  _ => 'grey',
};

/// Filterable, searchable catalog of FlutterBench critical user journeys.
///
/// Hydrated on the client via Jaspr's `@client` boundary.
@client
class CujCatalog extends StatefulComponent {
  const CujCatalog({required this.cujs, super.key});

  final List<Map<String, Object?>> cujs;

  @override
  State<CujCatalog> createState() => _CujCatalogState();
}

class _CujCatalogState extends State<CujCatalog> {
  Map<FilterType, Set<String>> _activeFilters = {};
  String _searchQuery = '';
  final Set<int> _expandedIds = {};

  static const String _personaFilterId = 'personas';

  List<FilterType> _buildFilters() {
    return [
      FilterType(
        _personaFilterId,
        'Persona',
        [for (final persona in cujPersonas) personaLabel(persona)],
      ),
    ];
  }

  void _applyFilters(Map<FilterType, Set<String>> filters) {
    setState(() => _activeFilters = filters);
  }

  void _toggleExpanded(int id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final filterType = _buildFilters().first;
    final activePersonaLabels = _activeFilters[filterType] ?? {};

    final filtered = component.cujs.where((cuj) {
      final persona = cuj['persona'] as String? ?? '';
      if (activePersonaLabels.isNotEmpty &&
          !activePersonaLabels.contains(personaLabel(persona))) {
        return false;
      }

      if (_searchQuery.trim().isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final goal = (cuj['goal'] as String? ?? '').toLowerCase();
        final tasks = (cuj['tasks'] as List<Object?>? ?? const [])
            .whereType<Map<String, Object?>>();
        final matchesTask = tasks.any(
          (t) => (t['task'] as String? ?? '').toLowerCase().contains(query),
        );
        if (!goal.contains(query) &&
            !personaLabel(persona).toLowerCase().contains(query) &&
            !matchesTask) {
          return false;
        }
      }

      return true;
    }).toList();

    return div(classes: 'cuj-catalog', [
      div(classes: 'bench-filter-bar', [
        FiltersDropdown(
          filters: [filterType],
          activeFilters: _activeFilters,
          applyFilters: _applyFilters,
        ),
        div(classes: 'filter-group search-input-group', [
          input(
            type: InputType.search,
            classes: 'bench-search-input',
            value: _searchQuery,
            attributes: const {
              'placeholder': 'Try "testing" or "architecture"...',
            },
            onInput: (value) {
              setState(() => _searchQuery = value?.toString() ?? '');
            },
          ),
        ]),
        span(classes: 'cuj-result-count', [
          .text('${filtered.length} / ${component.cujs.length} journeys'),
        ]),
      ]),
      if (filtered.isEmpty)
        const div(classes: 'empty-table-message', [
          .text('No journeys match the selected filters.'),
        ])
      else
        div(classes: 'cuj-card-list', [
          for (final cuj in filtered) _buildCard(cuj),
        ]),
    ]);
  }

  Component _buildCard(Map<String, Object?> cuj) {
    final id = (cuj['id'] as num).toInt();
    final goal = cuj['goal'] as String? ?? '';
    final persona = cuj['persona'] as String? ?? '';
    final tasks = (cuj['tasks'] as List<Object?>? ?? const [])
        .whereType<Map<String, Object?>>()
        .toList();
    final isExpanded = _expandedIds.contains(id);

    return div(
      classes: ['cuj-card', if (isExpanded) 'expanded'].toClasses,
      id: 'cuj-$id',
      [
        button(
          classes: 'cuj-card-header',
          type: ButtonType.button,
          attributes: {'aria-expanded': '$isExpanded'},
          events: {'click': (_) => _toggleExpanded(id)},
          [
            span(
              classes: [
                'persona-tag',
                'color-${_personaColorClass(persona)}',
              ].toClasses,
              [.text(personaLabel(persona))],
            ),
            h3(classes: 'cuj-goal', [.text(goal)]),
            span(classes: 'cuj-task-count', [
              .text(tasks.length == 1 ? '1 task' : '${tasks.length} tasks'),
            ]),
            MaterialIcon(
              isExpanded ? 'expand_less' : 'expand_more',
              label: 'Expand or collapse tasks',
            ),
          ],
        ),
        if (isExpanded)
          ul(classes: 'cuj-task-list', [
            for (final task in tasks)
              li([.text(task['task'] as String? ?? '')]),
          ]),
      ],
    );
  }
}
