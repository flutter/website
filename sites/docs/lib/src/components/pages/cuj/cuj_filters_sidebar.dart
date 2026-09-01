// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/button.dart';

import '../../../models/cuj_model.dart';
import '../filterable_index.dart';
import 'cuj_filters.dart';

// TODO(ewindmill): Replace with the real feedback destination once it exists.
const _feedbackUrl = 'https://github.com/flutter/evals/issues';

/// The persona filters for the critical user journey index.
@client
class CujFiltersSidebar extends StatelessComponent {
  const CujFiltersSidebar({super.key});

  /// The filter state for the critical user journey list.
  ///
  /// This is static so that [CujFilters] can access it,
  /// since both client components don't share a common ancestor.
  static final CujFiltersNotifier filters = CujFiltersNotifier();

  @override
  Component build(BuildContext context) {
    return FiltersSidebar(
      drawerToggleId: CujFilters.drawerToggleId,
      footer: const [
        div(classes: 'cuj-feedback', [
          Button(
            href: _feedbackUrl,
            content: 'Provide feedback',
            style: ButtonStyle.outlined,
            title: 'Leave feedback or suggest new CUJs.',
            attributes: {
              'target': '_blank',
              'rel': 'noopener',
            },
          ),
        ]),
      ],
      children: [
        ListenableBuilder(
          listenable: filters,
          builder: (context) {
            return div(classes: 'table-content', [
              const h4([.text('Persona')]),
              ul([
                for (final persona in CujPersona.values)
                  li([
                    input(
                      type: InputType.checkbox,
                      attributes: {'name': 'cuj-filter-${persona.name}'},
                      id: 'cuj-filter-${persona.name}',
                      checked: filters.isPersonaSelected(persona),
                      onChange: (checked) {
                        filters.setPersona(
                          persona,
                          isSelected: checked as bool? ?? false,
                        );
                      },
                    ),
                    label(
                      attributes: {'for': 'cuj-filter-${persona.name}'},
                      [.text(persona.label)],
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

/// Stores the selected critical user journey filters and
/// notifies listeners when they change.
final class CujFiltersNotifier extends ChangeNotifier {
  /// The currently selected personas.
  final Set<CujPersona> _selectedPersonas = {};

  /// Whether any persona filters are selected.
  bool get hasSelectedPersonas => _selectedPersonas.isNotEmpty;

  /// Whether [persona] is selected.
  bool isPersonaSelected(CujPersona persona) =>
      _selectedPersonas.contains(persona);

  /// Updates whether [persona] is selected and notifies listeners.
  void setPersona(CujPersona persona, {required bool isSelected}) {
    if (isSelected) {
      _selectedPersonas.add(persona);
    } else {
      _selectedPersonas.remove(persona);
    }
    notifyListeners();
  }

  /// Clears all selected personas.
  void reset() {
    _selectedPersonas.clear();
    notifyListeners();
  }

  /// Returns the journeys matching [searchQuery] and the selected filters.
  Set<Cuj> filterCujs(List<Cuj> cujs, String searchQuery) {
    searchQuery = searchQuery.trim().toLowerCase();

    if (searchQuery.isEmpty && _selectedPersonas.isEmpty) {
      // No filters applied, return all journeys.
      return cujs.toSet();
    }

    final cujsToShow = <Cuj>{};

    for (final cuj in cujs) {
      final matchesPersona =
          _selectedPersonas.isEmpty || isPersonaSelected(cuj.persona);
      if (!matchesPersona) {
        continue;
      }

      final matchesSearchQuery =
          searchQuery.isEmpty ||
          cuj.goal.toLowerCase().contains(searchQuery) ||
          cuj.persona.label.toLowerCase().contains(searchQuery) ||
          cuj.tasks.any(
            (task) => task.task.toLowerCase().contains(searchQuery),
          );
      if (!matchesSearchQuery) {
        continue;
      }

      cujsToShow.add(cuj);
    }

    return cujsToShow;
  }
}
