// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/analytics.dart';
import 'package:site_shared/components/common/button.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../../models/learning_resource_model.dart';
import 'filterable_index.dart';
import 'learning_resource_filters_sidebar.dart';

/// The search controls and result summary for the learning resources index.
@client
class LearningResourceFilters extends StatefulComponent {
  const LearningResourceFilters({super.key});

  /// The ID of the checkbox that toggles the filter drawer on narrow screens.
  static const String drawerToggleId = 'learning-resource-filter-toggle';

  @override
  State<LearningResourceFilters> createState() =>
      _LearningResourceFiltersState();
}

class _LearningResourceFiltersState extends State<LearningResourceFilters> {
  /// The filters selected in the learning resource sidebar.
  static LearningResourceFiltersNotifier get _filters =>
      LearningResourceFiltersSidebar.filters;

  /// The learning resources reconstructed from the rendered resource cards.
  final List<LearningResource> _resources = [];

  /// The current search query.
  String _searchQuery = '';

  /// The number of resources matching the active search and filters.
  int _filteredResourcesCount = 0;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _filters.addListener(_setFilters);

      final resourceGrid = web.document.getElementById('all-resources-grid');
      if (resourceGrid == null) {
        return;
      }

      final resourceCards = resourceGrid.querySelectorAll('.card');
      _recreateResources(resourceCards);
      _shuffleCards(resourceGrid);
    }
  }

  /// Populates [_resources] from [resourceCards] and registers click analytics.
  void _recreateResources(web.NodeList resourceCards) {
    for (var i = 0; i < resourceCards.length; i++) {
      final element = resourceCards.item(i) as web.Element;
      final info = LearningResource.fromElement(element);
      _resources.add(info);

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
    _filteredResourcesCount = _resources.length;
  }

  /// Randomizes the order of the resource cards in [container].
  void _shuffleCards(web.Element container) {
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
  void _setFilters([void Function()? callback]) {
    setState(callback ?? () {});

    final resourcesToShow = _filters.filterResources(_resources, _searchQuery);
    _filteredResourcesCount = resourcesToShow.length;
    for (final info in _resources) {
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
      _filters.removeListener(_setFilters);
    }
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    return FilterSearchGroup(
      drawerToggleId: LearningResourceFilters.drawerToggleId,
      searchId: 'resource-search',
      placeholder: 'Try "button" or "networking"...',
      label: 'Search learning resources by name and category',
      value: _searchQuery,
      onInput: (value) {
        _setFilters(() {
          _searchQuery = value;
        });
      },
      children: [
        div(classes: 'label-row', [
          label(
            attributes: {'for': 'resource-search'},
            [
              const .text('Showing '),
              span([.text('$_filteredResourcesCount')]),
              const .text(' / '),
              span([.text('${_resources.length}')]),
            ],
          ),
          Button(
            icon: 'close_small',
            content: 'Clear filters',
            size: ButtonSize.compact,
            disabled:
                _searchQuery.isEmpty &&
                _filters.selectedTags.isEmpty &&
                _filters.selectedTypes.isEmpty,
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
