// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../../analytics/analytics.dart';
import '../../models/learning_resource_model.dart';
import '../common/material_icon.dart';
import '../util/global_event_listener.dart';
import 'learning_resource_filters_sidebar.dart';

@client
class LearningResourceFilters extends StatefulComponent {
  const LearningResourceFilters({super.key});

  @override
  State<LearningResourceFilters> createState() =>
      _LearningResourceFiltersState();
}

class _LearningResourceFiltersState extends State<LearningResourceFilters> {
  String searchQuery = '';

  FiltersNotifier get filters => LearningResourceFiltersSidebar.filters;

  final List<LearningResource> resources = [];
  int filteredResourcesCount = 0;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      filters.addListener(setFilters);

      final resourceGrid = web.document.getElementById('all-resources-grid');
      if (resourceGrid == null) {
        return;
      }

      final resourceCards = resourceGrid.querySelectorAll('.card');
      recreateResources(resourceCards);
      shuffleCards(resourceGrid);
    }
  }

  void recreateResources(web.NodeList resourceCards) {
    for (var i = 0; i < resourceCards.length; i++) {
      final element = resourceCards.item(i) as web.Element;
      final info = LearningResource.fromElement(element);
      resources.add(info);

      element.addEventListener(
        'click',
        ((web.Event event) {
          analytics.sendEvent('learning_resource_index_click', {
            'learning_resource_type': info.type,
            'learning_resource_title': info.name,
          });
        }).toJS,
      );
    }
    filteredResourcesCount = resources.length;
  }

  void shuffleCards(web.Element container) {
    final r = Random();
    final elements = container.childNodes;
    for (var i = elements.length; i > 0; i--) {
      final card = elements.item(r.nextInt(i));
      container.appendChild(card!);
    }
  }

  /// Update the filter state and re-evaluate which resources to show.
  ///
  /// Use like the `setState` method by passing a callback that updates
  /// the relevant state variables.
  ///
  /// Example:
  ///
  /// ```dart
  /// setFilters(() {
  ///   searchQuery = '...';
  /// });
  /// ```
  void setFilters([void Function()? callback]) {
    setState(callback ?? () {});

    final resourcesToShow = filters.filterResources(resources, searchQuery);
    filteredResourcesCount = resourcesToShow.length;
    for (final info in resources) {
      final element =
          web.document.getElementById(info.name) as web.HTMLElement?;
      if (element == null) {
        continue;
      }

      if (resourcesToShow.contains(info)) {
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
      div(classes: 'top-row', [
        div(classes: 'search-wrapper', id: 'resource-search', [
          const MaterialIcon('search', classes: ['leading-icon']),
          input(
            type: InputType.search,
            attributes: {
              'placeholder': 'Try "button" or "networking"...',
              'aria-label': 'Search learning resources by name and category',
            },
            value: searchQuery,
            onInput: (value) {
              setFilters(() {
                searchQuery = value as String;
              });
            },
          ),
        ]),
        GlobalEventListener(
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
      ]),
      div(classes: 'label-row', [
        label(
          attributes: {'for': 'resource-search'},
          [
            text('Showing '),
            span([text('$filteredResourcesCount')]),
            text(' / '),
            span([text('${resources.length}')]),
          ],
        ),
        button(
          attributes: {
            if (searchQuery.isEmpty &&
                filters.selectedTags.isEmpty &&
                filters.selectedTypes.isEmpty)
              'disabled': 'true',
          },
          onClick: () {
            // No setState needed, since resetting filters will trigger it.
            searchQuery = '';
            filters.reset();
          },
          [
            const MaterialIcon('close_small'),
            span([text('Clear filters')]),
          ],
        ),
      ]),
    ]);
  }
}
