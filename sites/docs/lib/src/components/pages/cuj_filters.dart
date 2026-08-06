// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/components/common/search.dart';
import 'package:site_shared/components/utils/global_event_listener.dart';
import 'package:universal_web/web.dart' as web;

import '../../models/cuj_model.dart';
import 'cuj_filters_sidebar.dart';

@client
class CujFilters extends StatefulComponent {
  const CujFilters({super.key});

  @override
  State<CujFilters> createState() => _CujFiltersState();
}

class _CujFiltersState extends State<CujFilters> {
  String searchQuery = '';

  CujFiltersNotifier get filters => CujFiltersSidebar.filters;

  final List<Cuj> cujs = [];
  int filteredCujCount = 0;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      filters.addListener(setFilters);

      final cujList = web.document.getElementById('all-cujs-list');
      if (cujList == null) {
        return;
      }

      recreateCujs(cujList.querySelectorAll('.card'));
    }
  }

  void recreateCujs(web.NodeList cujCards) {
    for (var i = 0; i < cujCards.length; i++) {
      final element = cujCards.item(i) as web.Element;
      cujs.add(Cuj.fromElement(element));
    }
    filteredCujCount = cujs.length;
  }

  /// Update the filter state and re-evaluate which journeys to show.
  ///
  /// Use like the `setState` method by passing a callback that updates
  /// the relevant state variables.
  void setFilters([void Function()? callback]) {
    setState(callback ?? () {});

    final cujsToShow = filters.filterCujs(cujs, searchQuery);
    filteredCujCount = cujsToShow.length;
    for (final cuj in cujs) {
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
      filters.removeListener(setFilters);
    }
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    return div(id: 'resource-search-group', classes: 'chip-filters-group', [
      SearchBar(
        placeholder: 'Try "testing" or "architecture"...',
        label: 'Search critical user journeys by goal, persona, and task',
        value: searchQuery,
        id: 'resource-search',
        onInput: (value) {
          setFilters(() {
            searchQuery = value;
          });
        },
        trailing: GlobalEventListener(
          onClick: (event) {
            final target = event.target as web.Element?;
            // If clicking outside the filters or toggle, close the filters.
            if (target?.closest('#resource-filter-group-wrapper') == null &&
                target?.closest('.show-filters-button') == null) {
              final toggle =
                  web.document.getElementById('open-filter-toggle')
                      as web.HTMLInputElement?;
              toggle?.checked = false;
            }
          },
          button(
            classes: 'icon-button show-filters-button',
            onClick: () {
              final toggle =
                  web.document.getElementById('open-filter-toggle')
                      as web.HTMLInputElement?;
              toggle?.checked = !toggle.checked;
            },
            [
              const MaterialIcon('filter_list'),
            ],
          ),
        ),
      ),
      div(classes: 'label-row', [
        label(
          attributes: {'for': 'resource-search'},
          [
            const .text('Showing '),
            span([.text('$filteredCujCount')]),
            const .text(' / '),
            span([.text('${cujs.length}')]),
          ],
        ),
        button(
          attributes: {
            if (searchQuery.isEmpty && filters.selectedPersonas.isEmpty)
              'disabled': 'true',
          },
          onClick: () {
            // No setState needed, since resetting filters will trigger it.
            searchQuery = '';
            filters.reset();
          },
          [
            const MaterialIcon('close_small'),
            const span([.text('Clear filters')]),
          ],
        ),
      ]),
    ]);
  }
}
