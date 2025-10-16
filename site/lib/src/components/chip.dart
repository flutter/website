// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../util.dart';
import 'material_icon.dart';

/// A set of Material Design-like chips for configuration.
class ChipSet extends StatelessComponent {
  const ChipSet(this.chips, {this.resettable = false});

  final List<Component> chips;
  final bool resettable;

  @override
  Component build(BuildContext context) => div(classes: 'chip-set', [
    ...chips,
    if (resettable)
      button(
        id: 'reset-filters',
        classes: 'text-button',
        [text('Clear filters')],
      ),
  ]);
}

class InfoChip extends StatelessComponent {
  const InfoChip({
    super.key,
    required this.label,
    this.icon,
    this.iconPath,
    this.iconSize = 18,
    this.iconViewBox = '0 0 18 18',
    this.title,
    this.classes,
    this.attributes,
  });

  final String label;
  final String? icon;
  final String? iconPath;
  final int iconSize;
  final String iconViewBox;
  final String? title;
  final List<String>? classes;
  final Map<String, String>? attributes;

  @override
  Component build(BuildContext context) {
    final chipClasses = ['chip', 'info-chip', ...?classes];

    return div(
      classes: chipClasses.toClasses,
      attributes: attributes,
      [
        if (icon case final icon?)
          MaterialIcon(icon, title: title, classes: ['chip-icon'])
        else if (iconPath case final iconPath?)
          svg(
            classes: 'chip-icon',
            width: iconSize.px,
            height: iconSize.px,
            viewBox: iconViewBox,
            attributes: {
              'aria-hidden': 'true',
              'title': ?title,
            },
            [
              Component.element(
                tag: 'path',
                attributes: {'d': iconPath},
              ),
            ],
          ),
        span(classes: 'label', [text(label)]),
      ],
    );
  }
}

class FilterChip extends StatelessComponent {
  const FilterChip({
    super.key,
    required this.label,
    required this.dataFilter,
    this.icon,
    this.iconPath,
    this.iconSize = 18,
    this.iconViewBox = '0 0 18 18',
    this.ariaLabel,
    this.showCheckIcon = true,
    this.onTap,
  });

  final String label;
  final String dataFilter;
  final String? icon;
  final String? iconPath;
  final int iconSize;
  final String iconViewBox;
  final String? ariaLabel;
  final bool showCheckIcon;
  final void Function()? onTap;

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'chip filter-chip',
      attributes: {
        'data-filter': dataFilter,
        'role': 'checkbox',
        'aria-checked': 'false',
        'aria-label': ?ariaLabel,
      },
      [
        if (showCheckIcon)
          svg(
            classes: 'chip-icon leading-icon',
            attributes: {
              'viewBox': iconViewBox,
              'aria-hidden': 'true',
            },
            [
              const Component.element(
                tag: 'path',
                attributes: {
                  'd':
                      'M6.75012 12.1274L3.62262 8.99988L2.55762 10.0574L'
                      '6.75012 14.2499L15.7501 5.24988L14.6926 4.19238L'
                      '6.75012 12.1274Z',
                },
              ),
            ],
          )
        else if (icon case final icon?)
          MaterialIcon(icon, classes: ['chip-icon', 'leading-icon'])
        else if (iconPath case final iconPath?)
          svg(
            classes: 'chip-icon leading-icon',
            width: iconSize.px,
            height: iconSize.px,
            viewBox: iconViewBox,
            attributes: {'aria-hidden': 'true'},
            [
              Component.element(
                tag: 'path',
                attributes: {'d': iconPath},
              ),
            ],
          ),
        span(classes: 'label', [text(label)]),
      ],
    );
  }
}

class SelectChip extends StatelessComponent {
  const SelectChip({
    super.key,
    required this.label,
    required this.menuId,
    this.dataTitle,
    this.menuItems = const [],
    this.showDropdownIcon = true,
    this.dropdownIconPath,
  });

  final String label;
  final String menuId;
  final String? dataTitle;
  final List<SelectMenuItem> menuItems;
  final bool showDropdownIcon;
  final String? dropdownIconPath;

  @override
  Component build(BuildContext context) {
    return div(classes: 'button-menu-wrapper', [
      button(
        classes: 'chip select-chip',
        attributes: {
          'data-menu': menuId,
          'data-title': ?dataTitle,
          'aria-controls': menuId,
          'aria-expanded': 'false',
        },
        [
          span(classes: 'label', [text(label)]),
          if (showDropdownIcon)
            svg(
              classes: 'chip-icon trailing-icon',
              width: 24.px,
              height: 24.px,
              viewBox: '0 0 24 24',
              attributes: {'aria-hidden': 'true'},
              [
                Component.element(
                  tag: 'path',
                  attributes: {
                    'd': dropdownIconPath ?? 'M7 10l5 5 5-5H7z',
                  },
                ),
              ],
            ),
        ],
      ),
      if (menuItems.isNotEmpty)
        div(
          id: menuId,
          classes: 'select-menu',
          [
            ul(
              attributes: {'role': 'listbox'},
              menuItems,
            ),
          ],
        ),
    ]);
  }
}

class SelectMenuItem extends StatelessComponent {
  const SelectMenuItem({
    super.key,
    required this.label,
    required this.dataFilter,
    this.icon,
    this.iconPath,
    this.iconSize = 24,
    this.iconViewBox = '0 0 24 24',
    this.isSelected = false,
    this.onTap,
  });

  final String label;
  final String dataFilter;
  final String? icon;
  final String? iconPath;
  final int iconSize;
  final String iconViewBox;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Component build(BuildContext context) {
    return li([
      button(
        attributes: {
          'data-filter': dataFilter,
          'role': 'option',
          'aria-selected': isSelected.toString(),
        },
        [
          if (icon case final icon?)
            MaterialIcon(icon)
          else if (iconPath case final iconPath?)
            svg(
              classes: 'menu-icon',
              width: iconSize.px,
              height: iconSize.px,
              viewBox: iconViewBox,
              attributes: {'aria-hidden': 'true'},
              [
                Component.element(
                  tag: 'path',
                  attributes: {'d': iconPath},
                ),
              ],
            ),
          span(classes: 'label', [text(label)]),
        ],
      ),
    ]);
  }
}
