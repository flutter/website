// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/util.dart';
import 'package:universal_web/web.dart' as web;

import 'filters_dropdown.dart';

/// A single, independently selectable dimension items can be filtered by,
/// such as their location or their host.
class FilterType {
  final String id;
  final String title;
  final List<String> options;

  const FilterType(this.id, this.title, this.options);

  String optionId(String option) {
    return '${id.substring(0, id.length - 1)}-${option.toLowerCase().replaceAll(' ', '-').replaceAll('&', '')}-mobile';
  }

  /// Filter types are equal when they share an [id].
  ///
  /// They are used as map keys, so a caller that
  /// rebuilds an equivalent filter list keeps its
  /// active selections rather than dropping them.
  @override
  bool operator ==(Object other) => other is FilterType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class Filters extends StatefulComponent {
  const Filters({
    this.title,
    required this.data,
    required this.items,
    required this.filters,
    this.scope = '',
    this.emptyResultsMessage = 'No results match these filters.',
    this.emptyDataMessage = 'No results are available.',
    super.key,
  });

  final Component? title;
  final List<Map<String, Object?>> data;
  final List<Component> items;
  final List<FilterType> filters;

  /// Prefix applied to the URL parameters and element IDs this component owns.
  ///
  /// Use a unique value when a page hosts more than one [Filters] instance.
  final String scope;

  /// Message displayed when active filters match no items.
  final String emptyResultsMessage;

  /// Message displayed when there are no items to filter.
  final String emptyDataMessage;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  int _showItemsCount = 9;
  Map<FilterType, Set<String>> _activeFilters = {};

  /// Indexes into [Filters.items] of the items matching [_activeFilters],
  /// in their original order.
  List<int> _matchingIndexes = const [];

  /// Whether any filter type currently has options selected.
  bool get _hasActiveFilters =>
      _activeFilters.values.any((options) => options.isNotEmpty);

  /// The URL parameter name that stores the active options of [type].
  String _paramName(FilterType type) => '${component.scope}${type.id}';

  @override
  void initState() {
    super.initState();
    _matchingIndexes = [
      for (var index = 0; index < component.items.length; index++) index,
    ];

    if (kIsWeb) {
      _loadFiltersFromUrl();

      // Only rerun the filters if the URL actually requested some,
      // as every item is already visible.
      if (_hasActiveFilters) _applyFilters(_activeFilters);
    }
  }

  /// Reads the active filters out of the URL.
  void _loadFiltersFromUrl() {
    final url = Uri.parse(web.window.location.href);

    for (final type in component.filters) {
      final params = url.queryParameters[_paramName(type)]?.split(',');
      _activeFilters[type] = params?.toSet() ?? {};
    }
  }

  /// Narrows the visible items down to those matching [filters],
  /// and records the selection in the URL so it survives a reload or a share.
  void _applyFilters(Map<FilterType, Set<String>> filters) {
    final url = Uri.parse(web.window.location.href);
    final newQueryParameters = <String, String>{...url.queryParameters};

    for (final type in component.filters) {
      final paramName = _paramName(type);
      newQueryParameters.remove(paramName);
      if (filters[type] case final options? when options.isNotEmpty) {
        newQueryParameters[paramName] = options.join(',');
      }
    }

    web.window.history.replaceState(
      web.window.history.state,
      '',
      url.withQueryParameters(newQueryParameters).toString(),
    );

    setState(() {
      _activeFilters = filters;
      _matchingIndexes = [
        for (var index = 0; index < component.items.length; index++)
          if (_matchesFilters(index)) index,
      ];
    });
  }

  /// Whether the item at [index] matches at least one selected option
  /// of every filter type that has any.
  bool _matchesFilters(int index) {
    final data = component.data[index];

    for (final type in component.filters) {
      final activeOptions = _activeFilters[type] ?? {};

      if (activeOptions.isNotEmpty) {
        var dataOptions = data[type.id];
        if (dataOptions is String) {
          dataOptions = dataOptions
              .split(',')
              .map((opt) => opt.trim())
              .toList();
        }
        if (dataOptions is List) {
          if (dataOptions.isEmpty) return false;
          if (!dataOptions.any(activeOptions.contains)) {
            return false;
          }
        }
      }
    }

    return true;
  }

  /// Deselects every option, bringing all of the items back into view.
  void _clearFilters() => _applyFilters(const {});

  @override
  Component build(BuildContext context) {
    final hasData = component.items.isNotEmpty;
    final hasMatches = _matchingIndexes.isNotEmpty;
    final shownIndexes = _matchingIndexes.take(_showItemsCount).toSet();

    return div(classes: 'container story-grid', [
      div(classes: 'story-grid-header', [
        ?component.title,
        if (hasData)
          FiltersDropdown(
            filters: component.filters,
            activeFilters: _activeFilters,
            scope: component.scope,
            applyFilters: _applyFilters,
          ),
      ]),
      div(classes: 'story-grid-items', [
        for (final (index, item) in component.items.indexed)
          div(
            styles: shownIndexes.contains(index)
                ? null
                : const Styles(display: .none),
            [item],
          ),
      ]),
      if (!hasMatches)
        div(classes: 'filters-empty-results', [
          p([
            .text(
              hasData
                  ? component.emptyResultsMessage
                  : component.emptyDataMessage,
            ),
          ]),
          if (_hasActiveFilters)
            button(classes: 'btn quiet', onClick: _clearFilters, const [
              .text('Clear filters'),
            ]),
        ]),
      if (_matchingIndexes.length > _showItemsCount)
        button(
          classes: 'btn',
          onClick: () {
            setState(() {
              _showItemsCount += 9;
            });
          },
          const [.text('Load more')],
        ),
    ]);
  }
}
