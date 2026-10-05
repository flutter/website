// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
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

/// A [ThemeSwitcher] variant for use inside an existing `@client` component,
/// such as a client-hydrated header, to avoid nested `@client` anchors.
final class NestedThemeSwitcher extends StatefulComponent {
  const NestedThemeSwitcher({super.key});

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

final class _ThemeSwitcherState extends State<StatefulComponent> {
  _Theme _currentTheme = _Theme.light;
  StreamSubscription<web.Event>? _pageShowSubscription;
  StreamSubscription<web.StorageEvent>? _storageSubscription;
  StreamSubscription<web.Event>? _mediaQuerySubscription;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _syncThemeFromStorage();
      _pageShowSubscription =
          const web.EventStreamProvider<web.Event>(
                'pageshow',
              )
              .forTarget(web.window)
              .listen(
                (_) => _syncThemeFromStorage(updateState: true),
              );
      _storageSubscription = web.EventStreamProviders.storageEvent
          .forTarget(web.window)
          .listen((event) {
            if (event.key == null || event.key == 'theme') {
              _syncThemeFromStorage(updateState: true);
            }
          });
      _mediaQuerySubscription =
          const web.EventStreamProvider<web.Event>(
                'change',
              )
              .forTarget(web.window.matchMedia('(prefers-color-scheme: dark)'))
              .listen(
                (_) {
                  if (_currentTheme == _Theme.auto) {
                    _applyThemeToBody(_Theme.auto);
                  }
                },
              );
    }
  }

  @override
  void dispose() {
    // DOM event stream cancellations complete synchronously and don't need to
    // be awaited in synchronous lifecycle teardown.
    unawaited(_pageShowSubscription?.cancel());
    unawaited(_storageSubscription?.cancel());
    unawaited(_mediaQuerySubscription?.cancel());
    super.dispose();
  }

  _Theme _themeFromBodyClasses() {
    final classList = web.document.body?.classList;
    if (classList == null) return _Theme.light;
    if (classList.contains(_Theme.auto.id)) {
      return _Theme.auto;
    } else if (classList.contains(_Theme.dark.id)) {
      return _Theme.dark;
    } else {
      return _Theme.light;
    }
  }

  void _applyThemeToBody(_Theme theme) {
    final classList = web.document.body?.classList;
    if (classList == null) return;

    final isAuto = theme == _Theme.auto;
    final isDark = isAuto
        ? web.window.matchMedia('(prefers-color-scheme: dark)').matches
        : theme == _Theme.dark;
    final resolvedId = isDark ? _Theme.dark.id : _Theme.light.id;
    final oppositeId = isDark ? _Theme.light.id : _Theme.dark.id;

    if (classList.contains(resolvedId) &&
        classList.contains(_Theme.auto.id) == isAuto &&
        !classList.contains(oppositeId)) {
      return;
    }
    for (final mode in _Theme.values) {
      classList.remove(mode.id);
    }
    classList.add(resolvedId);
    if (isAuto) {
      classList.add(_Theme.auto.id);
    }
  }

  void _syncThemeFromStorage({bool updateState = false}) {
    String? storedThemeId;
    try {
      storedThemeId = web.window.localStorage.getItem('theme');
    } catch (_) {
      // localStorage is not available, fall back to body classes.
    }

    final resolvedTheme = switch (storedThemeId) {
      'auto-mode' => _Theme.auto,
      'dark-mode' => _Theme.dark,
      'light-mode' => _Theme.light,
      _ => _themeFromBodyClasses(),
    };

    _applyThemeToBody(resolvedTheme);

    if (updateState && resolvedTheme != _currentTheme) {
      setState(() {
        _currentTheme = resolvedTheme;
      });
    } else {
      _currentTheme = resolvedTheme;
    }
  }

  void _setTheme(_Theme newTheme) {
    if (newTheme == _currentTheme) return;

    _applyThemeToBody(newTheme);

    try {
      web.window.localStorage.setItem('theme', newTheme.id);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to save theme preference: $e');
      }
    }

    setState(() {
      _currentTheme = newTheme;
    });
  }

  @override
  Component build(BuildContext _) {
    return Dropdown(
      id: 'theme-switcher',
      toggle: const Button(icon: 'routine', title: 'Select a theme.'),
      content: div(classes: 'dropdown-menu', [
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
      ]),
    );
  }
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
  Component build(BuildContext context) => li([
    button(
      events: {
        'click': (_) {
          setMode(mode);
          context.findAncestorStateOfType<DropdownState>()?.toggle(to: false);
        },
      },
      attributes: {
        'title': mode.description,
        'aria-label': mode.description,
        'aria-selected': selected.toString(),
      },
      [
        MaterialIcon(mode.iconId),
        span([.text(mode.label)]),
      ],
    ),
  ]);
}
