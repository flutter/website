// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/button.dart';
import 'package:universal_web/web.dart' as web;

import '../../../models/cuj_model.dart';
import '../filterable_index.dart';
import 'cuj_filters_sidebar.dart';

/// The id of the search field, so its result count can label it.
const _searchId = 'cuj-search';

/// The search controls and result summary for the critical user journey index.
@client
class CujFilters extends StatefulComponent {
  const CujFilters({super.key});

  /// The ID of the checkbox that toggles the filter drawer on narrow screens.
  static const String drawerToggleId = 'cuj-filter-toggle';

  @override
  State<CujFilters> createState() => _CujFiltersState();
}

class _CujFiltersState extends State<CujFilters> {
  /// The filters selected in the critical user journey sidebar.
  static CujFiltersNotifier get _filters => CujFiltersSidebar.filters;

  /// The journeys reconstructed from the rendered journey cards.
  final List<Cuj> _cujs = [];

  /// The current search query.
  String _searchQuery = '';

  /// The number of journeys matching the active search and filters.
  int _filteredCujCount = 0;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _filters.addListener(_setFilters);

      final cujList = web.document.getElementById('all-cujs-list');
      if (cujList == null) {
        return;
      }

      _recreateCujs(cujList.querySelectorAll('.cuj-card'));
    }
  }

  /// Populates [_cujs] from [cujCards].
  void _recreateCujs(web.NodeList cujCards) {
    for (var i = 0; i < cujCards.length; i++) {
      final element = cujCards.item(i) as web.Element;
      _cujs.add(Cuj.fromElement(element));
    }
    _filteredCujCount = _cujs.length;
  }

  /// Updates the filter state and re-evaluates which journeys to show.
  ///
  /// Use like the `setState` method by passing a callback that updates
  /// the relevant state variables.
  void _setFilters([void Function()? callback]) {
    setState(callback ?? () {});

    final cujsToShow = _filters.filterCujs(_cujs, _searchQuery);
    _filteredCujCount = cujsToShow.length;
    for (final cuj in _cujs) {
      final element =
          web.document.getElementById(cuj.elementId) as web.HTMLElement?;
      if (element == null) {
        continue;
      }

      if (cujsToShow.contains(cuj)) {
        element.classList.remove('hidden');
      } else {
        element.classList.add('hidden');
      }
    }
  }

  @override
  void dispose() {
    if (kIsWeb) {
      _filters.removeListener(_setFilters);
    }
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    return FilterSearchGroup(
      drawerToggleId: CujFilters.drawerToggleId,
      searchId: _searchId,
      placeholder: 'Try "testing" or "architecture"...',
      label: 'Search critical user journeys by goal, persona, and task',
      value: _searchQuery,
      onInput: (value) {
        _setFilters(() {
          _searchQuery = value;
        });
      },
      children: [
        div(classes: 'label-row', [
          label(
            attributes: {'for': _searchId, 'aria-live': 'polite'},
            [
              const .text('Showing '),
              span([.text('$_filteredCujCount')]),
              const .text(' / '),
              span([.text('${_cujs.length}')]),
            ],
          ),
          Button(
            icon: 'close_small',
            content: 'Clear filters',
            size: ButtonSize.compact,
            disabled: _searchQuery.isEmpty && !_filters.hasSelectedPersonas,
            onClick: () {
              // No setState needed, since resetting filters will trigger it.
              _searchQuery = '';
              _filters.reset();
            },
          ),
        ]),
      ],
    );
  }
}
