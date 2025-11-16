// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../analytics/analytics.dart';
import '../../models/learning_resource_model.dart';
import '../../util.dart';
import '../common/material_icon.dart';
import 'learning_resource_filters.dart';

@client
class LearningResourceFiltersSidebar extends StatelessComponent {
  const LearningResourceFiltersSidebar({super.key});

  /// The filter state for the resources list.
  ///
  /// This is static so that [LearningResourceFilters] can access it,
  /// since both client components don't share a common ancestor.
  static FiltersNotifier filters = FiltersNotifier();

  @override
  Component build(BuildContext context) {
    return div(classes: 'right-col', [
      input(
        type: InputType.checkbox,
        id: 'open-filter-toggle',
        attributes: {'hidden': 'true'},
      ),
      div(id: 'resource-filter-group-wrapper', [
        div(id: 'resource-filter-group', [
          div(classes: 'filter-header', [
            label(
              attributes: {'for': 'open-filter-toggle', 'aria-hidden': 'true'},
              classes: 'close-icon',
              [const MaterialIcon('close')],
            ),
          ]),
          div(classes: 'table-title', [text('Filter by')]),
          ListenableBuilder(
            listenable: filters,
            builder: (context) {
              return div(classes: 'table-content', [
                h4([text('Subject')]),
                ul(classes: filters.tagsExpanded ? '' : 'collapsed', [
                  for (final (index, tag) in LearningResourceTag.values.indexed)
                    li(
                      classes: [
                        if (!filters.tagsExpanded && index > 3) 'hidden',
                      ].toClasses,
                      [
                        input(
                          type: InputType.checkbox,
                          attributes: {
                            'role': 'checkbox',
                            'name': 'filter-${tag.name}',
                          },
                          id: 'filter-${tag.name}',
                          checked: filters.selectedTags.contains(tag),
                          onChange: (checked) {
                            filters.setTag(tag, checked as bool);
                          },
                        ),
                        label(
                          attributes: {'for': 'filter-${tag.name}'},
                          [text(tag.label)],
                        ),
                      ],
                    ),
                ]),
                button(onClick: filters.toggleTagsExpanded, [
                  span(classes: 'label', [
                    text(filters.tagsExpanded ? 'Less' : 'More'),
                  ]),
                  MaterialIcon(
                    filters.tagsExpanded ? 'expand_less' : 'expand_more',
                  ),
                ]),
                h4([text('Type')]),
                ul([
                  for (final type in LearningResourceType.values)
                    li([
                      input(
                        type: InputType.checkbox,
                        attributes: {
                          'role': 'checkbox',
                          'name': 'filter-${type.name}',
                        },
                        id: 'filter-${type.name}',
                        checked: filters.selectedTypes.contains(type),
                        onChange: (checked) {
                          filters.setType(type, checked as bool);
                        },
                      ),
                      label(
                        attributes: {'for': 'filter-${type.name}'},
                        [text(type.label)],
                      ),
                    ]),
                ]),
              ]);
            },
          ),
        ]),
      ]),
    ]);
  }
}

/// Notifier to manage the state of the filters.
class FiltersNotifier extends ChangeNotifier {
  Set<LearningResourceTag> selectedTags = {};
  Set<LearningResourceType> selectedTypes = {};

  bool tagsExpanded = false;

  void setTag(LearningResourceTag tag, bool isSelected) {
    if (isSelected) {
      selectedTags.add(tag);

      analytics.sendEvent(
        'learning_resource_index_filter_selected',
        {
          'learning_resource_filter_name': tag.label.toLowerCase(),
          'learning_resource_filter_type': 'tags',
        },
      );
    } else {
      selectedTags.remove(tag);
    }
    notifyListeners();
  }

  void setType(LearningResourceType type, bool isSelected) {
    if (isSelected) {
      selectedTypes.add(type);

      analytics.sendEvent(
        'learning_resource_index_filter_selected',
        {
          'learning_resource_filter_name': type.label.toLowerCase(),
          'learning_resource_filter_type': 'type',
        },
      );
    } else {
      selectedTypes.remove(type);
    }
    notifyListeners();
  }

  void toggleTagsExpanded() {
    tagsExpanded = !tagsExpanded;
    notifyListeners();
  }

  void reset() {
    selectedTags.clear();
    selectedTypes.clear();
    notifyListeners();
  }

  Set<LearningResource> filterResources(
    List<LearningResource> resources,
    String searchQuery,
  ) {
    if (searchQuery.isEmpty && selectedTags.isEmpty && selectedTypes.isEmpty) {
      // No filters applied, return all resources.
      return resources.toSet();
    }

    final resourcesToShow = <LearningResource>{};
    searchQuery = searchQuery.trim().toLowerCase();

    final filterTags = selectedTags.expand((e) => e.tags).toSet();
    final filterTypes = selectedTypes.expand((e) => e.tags).toSet();

    for (final info in resources) {
      final matchesTags =
          selectedTags.isEmpty || info.tags.any(filterTags.contains);
      if (!matchesTags) {
        continue;
      }

      final matchesTypes =
          selectedTypes.isEmpty || filterTypes.contains(info.type);
      if (!matchesTypes) {
        continue;
      }

      final matchesSearchQuery =
          searchQuery.isEmpty ||
          info.name.toLowerCase().contains(searchQuery) ||
          info.tags.any((t) => t.contains(searchQuery)) ||
          info.type.contains(searchQuery) ||
          info.description.toLowerCase().contains(searchQuery);
      if (!matchesSearchQuery) {
        continue;
      }

      resourcesToShow.add(info);
    }

    return resourcesToShow;
  }
}
