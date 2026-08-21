// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// The shell components shared by the filterable index pages:
/// the learning resources index and the critical user journey index.
///
/// The pages provide their own filter controls and results list,
/// but the surrounding layout, search field, and sidebar are the same,
/// and are styled by `_filterable-index.scss`.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/components/common/search.dart';
import 'package:site_shared/components/utils/global_event_listener.dart';
import 'package:universal_web/web.dart' as web;

/// The id of the hidden checkbox that opens and closes the filter sidebar
/// while it is a drawer on narrow screens.
///
/// The drawer is CSS-only: `_filterable-index.scss` keys off the checkbox's
/// `:checked` state, and the close button within the sidebar is a `<label>`
/// pointing back at it.
const _drawerToggleId = 'open-filter-toggle';

/// Selects the whole sidebar, so that clicks anywhere within the open drawer,
/// including in its [FiltersSidebar.footer], don't close it.
const _sidebarSelector = '.filter-sidebar';

/// The right hand column of a filterable index page.
///
/// Renders [children] within a card titled 'Filter by', with [footer] pinned
/// below it. On narrow screens the card and footer become a drawer that slides
/// in from the right, toggled by the [FilterSearchGroup] search field.
class FiltersSidebar extends StatelessComponent {
  const FiltersSidebar({
    required this.children,
    this.footer = const [],
    super.key,
  });

  /// The filter controls, rendered within the filter card.
  final List<Component> children;

  /// Optional page-specific content, rendered below the filter card.
  final List<Component> footer;

  @override
  Component build(BuildContext context) {
    return div(classes: 'right-col', [
      const input(
        type: InputType.checkbox,
        id: _drawerToggleId,
        attributes: {'hidden': 'true'},
      ),
      div(classes: 'filter-sidebar', [
        div(classes: 'filter-group-wrapper', [
          div(classes: 'filter-group', [
            const div(classes: 'filter-header', [
              label(
                attributes: {'for': _drawerToggleId, 'aria-hidden': 'true'},
                classes: 'close-icon',
                [MaterialIcon('close')],
              ),
            ]),
            const div(classes: 'table-title', [.text('Filter by')]),
            ...children,
          ]),
        ]),
        ...footer,
      ]),
    ]);
  }
}

/// The search field of a filterable index page,
/// followed by the page-specific [children], such as a result count.
///
/// On narrow screens, the field also contains the button
/// that opens the [FiltersSidebar] drawer.
class FilterSearchGroup extends StatelessComponent {
  const FilterSearchGroup({
    required this.searchId,
    required this.placeholder,
    required this.label,
    required this.value,
    required this.onInput,
    required this.children,
    super.key,
  });

  /// The id of the search field, so the page can label it.
  final String searchId;

  /// The placeholder text displayed in the search field.
  final String placeholder;

  /// The accessibility label for the search field.
  final String label;

  /// The current value of the search field.
  final String value;

  /// Callback triggered when the search field input changes.
  final void Function(String) onInput;

  /// Content rendered below the search field.
  final List<Component> children;

  @override
  Component build(BuildContext context) {
    return div(classes: 'filter-search-group', [
      SearchBar(
        placeholder: placeholder,
        label: label,
        value: value,
        id: searchId,
        onInput: onInput,
        trailing: const _DrawerToggleButton(),
      ),
      ...children,
    ]);
  }
}

/// The button that opens the filter drawer on narrow screens.
///
/// Also closes the drawer again when anything outside of it is clicked.
class _DrawerToggleButton extends StatelessComponent {
  const _DrawerToggleButton();

  static web.HTMLInputElement? get _toggle =>
      web.document.getElementById(_drawerToggleId) as web.HTMLInputElement?;

  @override
  Component build(BuildContext context) {
    return GlobalEventListener(
      onClick: (event) {
        final target = event.target;
        if (target == null || !target.isA<web.Element>()) return;

        final element = target as web.Element;
        if (element.closest(_sidebarSelector) == null &&
            element.closest('.show-filters-button') == null) {
          _toggle?.checked = false;
        }
      },
      button(
        classes: 'icon-button show-filters-button',
        attributes: const {'aria-label': 'Show filters'},
        onClick: () {
          if (_toggle case final toggle?) {
            toggle.checked = !toggle.checked;
          }
        },
        const [MaterialIcon('filter_list')],
      ),
    );
  }
}
