// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import 'filters_dropdown.dart';

class FilterType {
  final String id;
  final String title;
  final List<String> options;

  const FilterType(this.id, this.title, this.options);

  String optionId(String option) {
    return '${id.substring(0, id.length - 1)}-${option.toLowerCase().replaceAll(' ', '-').replaceAll('&', '')}-mobile';
  }
}

class Filters extends StatefulComponent {
  const Filters({
    this.title,
    required this.data,
    required this.items,
    required this.filters,
    super.key,
  });

  final Component? title;
  final List<Map<String, Object?>> data;
  final List<Component> items;
  final List<FilterType> filters;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  int _showItemsCount = 9;
  Map<FilterType, Set<String>> _activeFilters = {};

  List<Component> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = component.items;

    if (kIsWeb) {
      _loadFiltersFromUrl();
      _applyFilters(_activeFilters);
    }
  }

  void _loadFiltersFromUrl() {
    final url = Uri.parse(web.window.location.href);

    for (final type in component.filters) {
      final params = url.queryParameters[type.id]?.split(',');
      _activeFilters[type] = params?.toSet() ?? {};
    }
  }

  void _applyFilters(Map<FilterType, Set<String>> filters) {
    setState(() {
      _activeFilters = filters;
    });

    final url = Uri.parse(web.window.location.href);
    final newQueryParameters = <String, String>{...url.queryParameters};

    for (final type in component.filters) {
      newQueryParameters.remove(type.id);
      if (filters[type] case final options? when options.isNotEmpty) {
        newQueryParameters[type.id] = options.join(',');
      }
    }

    web.window.history.replaceState(
      web.window.history.state,
      '',
      url.replace(queryParameters: newQueryParameters).toString(),
    );

    setState(() {
      _filteredItems = component.items.where(_filterItem).toList();
    });
  }

  bool _filterItem(Component item) {
    if (_activeFilters.values.every((set) => set.isEmpty)) {
      return true;
    }

    final index = component.items.indexOf(item);
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

  @override
  Component build(BuildContext context) {
    return div(classes: 'container story-grid', [
      div(classes: 'story-grid-header', [
        ?component.title,
        FiltersDropdown(
          filters: component.filters,
          activeFilters: _activeFilters,
          applyFilters: _applyFilters,
        ),
      ]),
      div(classes: 'story-grid-items', [
        for (final item in component.items)
          div(
            styles:
                _filteredItems.contains(item) &&
                    _filteredItems.indexOf(item) < _showItemsCount
                ? null
                : const Styles(display: .none),
            [item],
          ),
      ]),
      if (_filteredItems.length > _showItemsCount)
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
