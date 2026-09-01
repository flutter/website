// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/analytics.dart';
import 'package:site_shared/components/common/button.dart';
import 'package:site_shared/util.dart';

import '../../models/learning_resource_model.dart';
import 'filterable_index.dart';
import 'learning_resource_filters.dart';

/// The subject and type filters for the learning resources index.
@client
class LearningResourceFiltersSidebar extends StatelessComponent {
  const LearningResourceFiltersSidebar({super.key});

  /// The filter state for the resources list.
  ///
  /// This is static so that [LearningResourceFilters] can access it,
  /// since both client components don't share a common ancestor.
  static final LearningResourceFiltersNotifier filters =
      LearningResourceFiltersNotifier();

  @override
  Component build(BuildContext context) {
    return FiltersSidebar(
      drawerToggleId: LearningResourceFilters.drawerToggleId,
      children: [
        ListenableBuilder(
          listenable: filters,
          builder: (context) {
            return div(classes: 'table-content', [
              const h4([.text('Subject')]),
              ul([
                for (final (index, tag) in LearningResourceTag.values.indexed)
                  li(
                    classes: [
                      if (!filters.tagsExpanded && index > 3) 'hidden',
                    ].toClasses,
                    [
                      input(
                        type: InputType.checkbox,
                        attributes: {'name': 'resource-filter-${tag.name}'},
                        id: 'resource-filter-${tag.name}',
                        checked: filters.selectedTags.contains(tag),
                        onChange: (checked) {
                          filters.setTag(tag, checked as bool);
                        },
                      ),
                      label(
                        attributes: {'for': 'resource-filter-${tag.name}'},
                        [.text(tag.label)],
                      ),
                    ],
                  ),
              ]),
              Button(
                content: filters.tagsExpanded ? 'Less' : 'More',
                classes: const ['filter-expansion-button'],
                size: ButtonSize.compact,
                trailingIcon: filters.tagsExpanded
                    ? 'expand_less'
                    : 'expand_more',
                onClick: filters.toggleTagsExpanded,
              ),
              const h4([.text('Type')]),
              ul([
                for (final type in LearningResourceType.values)
                  li([
                    input(
                      type: InputType.checkbox,
                      attributes: {'name': 'resource-filter-${type.name}'},
                      id: 'resource-filter-${type.name}',
                      checked: filters.selectedTypes.contains(type),
                      onChange: (checked) {
                        filters.setType(type, isSelected: checked as bool);
                      },
                    ),
                    label(
                      attributes: {'for': 'resource-filter-${type.name}'},
                      [.text(type.label)],
                    ),
                  ]),
              ]),
            ]);
          },
        ),
      ],
    );
  }
}

/// Stores the selected learning resource filters and
/// notifies listeners when they change.
final class LearningResourceFiltersNotifier extends ChangeNotifier {
  /// The currently selected subject tags.
  final Set<LearningResourceTag> selectedTags = {};

  /// The currently selected resource types.
  final Set<LearningResourceType> selectedTypes = {};

  /// Whether all subject tags are visible.
  bool tagsExpanded = false;

  /// Updates whether [tag] is selected and notifies listeners.
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

  /// Updates whether [type] is selected and notifies listeners.
  void setType(LearningResourceType type, {required bool isSelected}) {
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

  /// Toggles whether all subject tags are visible.
  void toggleTagsExpanded() {
    tagsExpanded = !tagsExpanded;
    notifyListeners();
  }

  /// Clears all selected tags and resource types.
  void reset() {
    selectedTags.clear();
    selectedTypes.clear();
    notifyListeners();
  }

  /// Returns the resources matching [searchQuery] and the selected filters.
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
