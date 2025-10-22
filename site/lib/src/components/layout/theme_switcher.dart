// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../common/button.dart';
import '../common/dropdown.dart';
import '../common/material_icon.dart';

@client
final class ThemeSwitcher extends StatefulComponent {
  const ThemeSwitcher();

  @override
  State<StatefulComponent> createState() => _ThemeSwitcherState();
}

enum _Theme {
  light('Light', 'Switch to the light theme.', 'light_mode'),
  dark('Dark', 'Switch to the dark theme.', 'dark_mode'),
  auto('Automatic', 'Match theme to device theme.', 'night_sight_auto');

  final String label;
  final String description;
  final String iconId;

  const _Theme(this.label, this.description, this.iconId);

  String get id => '$name-mode';
}

final class _ThemeSwitcherState extends State<ThemeSwitcher> {
  _Theme _currentTheme = _Theme.light;

  @override
  void initState() {
    if (kIsWeb) {
      final classList = web.document.body!.classList;
      // If them theme is auto, it and the result will be added as classes.
      // So it should be checked for first.
      if (classList.contains(_Theme.auto.id)) {
        _currentTheme = _Theme.auto;
      } else if (classList.contains(_Theme.dark.id)) {
        _currentTheme = _Theme.dark;
      } else if (classList.contains(_Theme.light.id)) {
        _currentTheme = _Theme.light;
      } else {
        // Default to light mode if no theme is set yet.
        _currentTheme = _Theme.light;
        classList.add(_Theme.light.id);
      }
    }

    super.initState();
  }

  void _setTheme(_Theme newTheme) {
    if (newTheme == _currentTheme) return;

    final classList = web.document.body!.classList;
    for (final mode in _Theme.values) {
      classList.remove(mode.id);
    }
    classList.add(newTheme.id);
    if (newTheme == _Theme.auto) {
      classList.add(
        web.window.matchMedia('(prefers-color-scheme: dark)').matches
            ? _Theme.dark.id
            : _Theme.light.id,
      );
    }

    web.window.localStorage.setItem('theme', newTheme.id);

    setState(() {
      _currentTheme = newTheme;
    });
  }

  @override
  Component build(BuildContext _) => Dropdown(
    id: 'theme-switcher',
    children: [
      const DropdownToggle(Button(icon: 'routine', title: 'Select a theme.')),
      DropdownContent(
        div(
          classes: 'dropdown-menu',
          [
            ul(
              attributes: {'role': 'listbox'},
              [
                for (final mode in _Theme.values)
                  _ThemeButtonEntry(
                    mode: mode,
                    selected: _currentTheme == mode,
                    setMode: _setTheme,
                  ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

final class _ThemeButtonEntry extends StatelessComponent {
  const _ThemeButtonEntry({
    required this.mode,
    required this.selected,
    required this.setMode,
  });

  final _Theme mode;
  final bool selected;
  final void Function(_Theme) setMode;

  @override
  Component build(BuildContext _) => li([
    button(
      events: {
        'click': (_) {
          setMode(mode);
        },
      },
      attributes: {
        'title': mode.description,
        'aria-label': mode.description,
        'aria-selected': selected.toString(),
      },
      [
        MaterialIcon(mode.iconId),
        span([text(mode.label)]),
      ],
    ),
  ]);
}
