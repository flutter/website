// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../util.dart';
import '../util/global_event_listener.dart';
import 'material_icon.dart';

/// A set of Material Design-like chips for configuration.
class ChipSet extends StatelessComponent {
  const ChipSet(this.chips, {this.onReset});

  final List<Component> chips;
  final void Function()? onReset;

  @override
  Component build(BuildContext context) => div(classes: 'chip-set', [
    ...chips,
    if (onReset case final onReset?)
      button(
        id: 'reset-filters',
        classes: 'text-button',
        events: {'click': (_) => onReset()},
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
              Component.element(tag: 'path', attributes: {'d': iconPath}),
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
    this.icon,
    this.iconPath,
    this.iconSize = 18,
    this.iconViewBox = '0 0 18 18',
    this.ariaLabel,
    this.showCheckIcon = true,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final String? icon;
  final String? iconPath;
  final int iconSize;
  final String iconViewBox;
  final String? ariaLabel;
  final bool showCheckIcon;
  final bool selected;
  final void Function()? onTap;

  @override
  Component build(BuildContext context) {
    return button(
      classes: ['chip', 'filter-chip', if (selected) 'selected'].toClasses,
      attributes: {
        'role': 'checkbox',
        'aria-checked': selected ? 'true' : 'false',
        'aria-label': ?ariaLabel,
      },
      events: {'click': (_) => onTap?.call()},
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

class SelectChip<T> extends StatefulComponent {
  const SelectChip({
    super.key,
    required this.label,
    required this.menuId,
    this.menuItems = const [],
    this.showDropdownIcon = true,
    this.dropdownIconPath,
    this.selectedValue,
    this.onSelect,
  });

  final String label;
  final String menuId;
  final List<SelectMenuItem<T>> menuItems;
  final bool showDropdownIcon;
  final String? dropdownIconPath;
  final T? selectedValue;
  final void Function(T?)? onSelect;

  @override
  State createState() => _SelectChipState<T>();
}

class _SelectChipState<T> extends State<SelectChip<T>> {
  bool isMenuShown = false;

  @override
  void didUpdateComponent(SelectChip<T> oldComponent) {
    super.didUpdateComponent(oldComponent);

    if (oldComponent.selectedValue != component.selectedValue) {
      setState(() {
        isMenuShown = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return GlobalEventListener(
      onClick: (event) {
        // If not clicking inside a menu wrapper, close the menu.
        if ((event.target as web.Element?)?.closest('.button-menu-wrapper') ==
            null) {
          setState(() {
            isMenuShown = false;
          });
        }
      },
      onKeyDown: (event) {
        // If pressing the `esc` key in the menu wrapper, close the menu.
        if (event.key == 'Escape' &&
            (event.target as web.Element?)?.closest('.button-menu-wrapper') !=
                null) {
          setState(() {
            isMenuShown = false;
          });
        }
      },
      div(classes: 'button-menu-wrapper', [
        button(
          classes: [
            'chip',
            'select-chip',
            if (component.selectedValue != null) 'selected',
          ].toClasses,
          attributes: {
            'aria-controls': component.menuId,
            'aria-expanded': isMenuShown ? 'true' : 'false',
          },
          events: {
            'click': (_) {
              setState(() {
                isMenuShown = !isMenuShown;
              });
            },
          },
          [
            span(classes: 'label', [text(component.label)]),
            if (component.showDropdownIcon)
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
                      'd': component.dropdownIconPath ?? 'M7 10l5 5 5-5H7z',
                    },
                  ),
                ],
              ),
          ],
        ),
        if (component.menuItems.isNotEmpty)
          div(
            id: component.menuId,
            classes: 'select-menu${isMenuShown ? ' show-menu' : ''}',
            [
              ul(
                attributes: {'role': 'listbox'},
                [
                  for (final item in component.menuItems)
                    item._buildItem(
                      item.value == component.selectedValue,
                      () {
                        component.onSelect?.call(
                          item.value == component.selectedValue
                              ? null
                              : item.value,
                        );
                        setState(() {
                          isMenuShown = false;
                        });
                      },
                    ),
                ],
              ),
            ],
          ),
      ]),
    );
  }
}

class SelectMenuItem<T> {
  const SelectMenuItem({
    required this.label,
    required this.value,
    this.icon,
    this.iconPath,
    this.iconSize = 24,
    this.iconViewBox = '0 0 24 24',
  });

  final String label;
  final T value;
  final String? icon;
  final String? iconPath;
  final int iconSize;
  final String iconViewBox;

  Component _buildItem(bool isSelected, void Function()? onTap) {
    return li([
      button(
        classes: isSelected ? 'selected' : null,
        attributes: {
          'role': 'option',
          'aria-selected': isSelected.toString(),
        },
        events: {'click': (_) => onTap?.call()},
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
