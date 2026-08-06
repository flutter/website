// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import 'filters.dart';
import 'icon.dart';

class FiltersDropdown extends StatefulComponent {
  const FiltersDropdown({
    required this.filters,
    required this.activeFilters,
    required this.applyFilters,
    this.scope = '',
    super.key,
  });

  final List<FilterType> filters;
  final Map<FilterType, Set<String>> activeFilters;

  final void Function(Map<FilterType, Set<String>>) applyFilters;

  /// Prefix applied to the checkbox element IDs,
  /// so multiple dropdowns can coexist on one page.
  final String scope;

  @override
  State<FiltersDropdown> createState() => _FiltersDropdownState();
}

class _FiltersDropdownState extends State<FiltersDropdown> {
  bool _isMobile = false;
  bool _isOpen = false;

  Map<FilterType, Set<String>> _selectedFilters = {};
  final Set<FilterType> _openedMobileDropdowns = {};

  StreamSubscription<void>? _resizeSubscription;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _resizeSubscription = web.EventStreamProviders.resizeEvent
          .forTarget(web.window)
          .listen((_) => onResize());
      onResize();
    }

    _selectedFilters = _copyActiveFilters();
  }

  @override
  void didUpdateComponent(covariant FiltersDropdown oldComponent) {
    super.didUpdateComponent(oldComponent);
    // Rebuilds that don't touch the filters, such as showing more items,
    // shouldn't discard the options the user has checked but not applied.
    if (!identical(oldComponent.activeFilters, component.activeFilters) ||
        !identical(oldComponent.filters, component.filters)) {
      _selectedFilters = _copyActiveFilters();
    }
  }

  /// A mutable copy of [FiltersDropdown.activeFilters],
  /// so toggling a checkbox doesn't apply to the grid until confirmed.
  Map<FilterType, Set<String>> _copyActiveFilters() => {
    for (final type in component.filters)
      type: {...component.activeFilters[type] ?? {}},
  };

  /// The page-unique DOM element ID of the checkbox for [option] of [type].
  String _optionId(FilterType type, String option) =>
      '${component.scope}${type.optionId(option)}';

  void onResize() {
    // Resize events fire continuously while dragging,
    // but the layout only changes when the breakpoint is crossed.
    final isMobile = web.window.innerWidth < 768;
    if (isMobile == _isMobile) return;

    setState(() {
      _isMobile = isMobile;
    });
  }

  void toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isMobile) {
        _openedMobileDropdowns.clear();
      }
    });

    if (_isMobile && _isOpen) {
      web.document.body!.style.overflow = 'hidden';
    } else {
      web.document.body!.style.overflow = 'auto';
    }
  }

  void applyFilters() {
    component.applyFilters(_selectedFilters);

    toggleDropdown();
  }

  /// Deselects every option and immediately applies the empty selection.
  void clearAllFilters() {
    setState(() {
      _selectedFilters = {};
    });

    applyFilters();
  }

  void toggleMobileDropdown(FilterType type) {
    setState(() {
      if (_openedMobileDropdowns.contains(type)) {
        _openedMobileDropdowns.remove(type);
      } else {
        _openedMobileDropdowns.add(type);
      }
    });
  }

  @override
  void dispose() {
    if (_resizeSubscription case final resizeSubscription?) {
      unawaited(resizeSubscription.cancel());
    }
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    final filtersCount = component.activeFilters.values.fold(
      0,
      (acc, set) => acc + set.length,
    );

    return div(classes: 'dropdown', [
      button(
        classes: [
          'btn top-level filters-dropdown__button',
          if (_isMobile) 'mobile-button',
          if (filtersCount > 0) 'primary',
        ].join(' '),
        onClick: toggleDropdown,
        [
          const .text('Filters '),
          if (filtersCount > 0)
            div([
              const .text('('),
              span([.text('$filtersCount')]),
              const .text(')'),
            ])
          else
            const Icon(
              symbol: 'expand_more',
              size: .md,
            ),
        ],
      ),
      if (_isOpen)
        div(
          classes: [
            'filters-dropdown-content',
            'show',
            if (_isMobile) 'mobile-open',
          ].join(' '),
          [
            div(
              classes: [
                'filters-dropdown__mobile-header',
                if (_isMobile) 'show',
              ].join(' '),
              [
                const span([.text('Filters')]),
                span(events: events(onClick: toggleDropdown), const [
                  Icon(symbol: 'close'),
                ]),
              ],
            ),
            div(classes: 'filters-dropdown__filters-container', [
              for (final type in component.filters) ...[
                _buildFilterGroup(type),
                const span(classes: 'separator', []),
              ],
            ]),
            div(classes: 'filters-dropdown__buttons-container', [
              button(
                classes: 'btn filters-dropdown__clear-all-button',
                onClick: clearAllFilters,
                const [.text('Clear All')],
              ),
              button(classes: 'btn', onClick: applyFilters, const [
                .text('Apply'),
              ]),
            ]),
          ],
        ),
    ]);
  }

  Component _buildFilterGroup(FilterType type) {
    return div([
      span(
        classes: [
          'filter-title',
          if (_openedMobileDropdowns.contains(type)) 'selected',
        ].join(' '),
        events: events(onClick: () => toggleMobileDropdown(type)),
        [
          .text(type.title),
          const Icon(
            symbol: 'expand_more',
            size: .md,
          ),
        ],
      ),
      div(
        classes: [
          'filters-dropdown__checkbox-container',
          if (_openedMobileDropdowns.contains(type)) 'show',
        ].join(' '),
        [
          for (final option in type.options) _buildOption(type, option),
        ],
      ),
    ]);
  }

  Component _buildOption(FilterType type, String option) {
    final optionId = _optionId(type, option);
    return label(htmlFor: optionId, [
      input(
        id: optionId,
        type: InputType.checkbox,
        value: option,
        checked: _selectedFilters[type]?.contains(option) ?? false,
        onChange: (bool? value) {
          setState(() {
            final options = _selectedFilters[type] ??= {};
            if (value ?? false) {
              options.add(option);
            } else {
              options.remove(option);
            }
          });
        },
      ),
      .text(option),
    ]);
  }
}
