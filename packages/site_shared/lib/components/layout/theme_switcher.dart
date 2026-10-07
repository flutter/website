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
  const ThemeSwitcher({super.key});

  @override
  State<StatefulComponent> createState() => _ThemeSwitcherState();
}

/// A [ThemeSwitcher] variant for use inside an existing `@client` component,
/// such as a client-hydrated header, to avoid nested `@client` anchors.
// TODO: Remove this variant once
//  Jaspr fixes nested `@client` components handling.
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
  _Theme _currentTheme = .light;
  web.MediaQueryList? _prefersDarkQuery;
  StreamSubscription<web.Event>? _pageShowSubscription;
  StreamSubscription<web.StorageEvent>? _storageSubscription;
  StreamSubscription<web.Event>? _mediaQuerySubscription;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      final prefersDarkQuery = _prefersDarkQuery = web.window.matchMedia(
        '(prefers-color-scheme: dark)',
      );
      _syncThemeFromStorage();
      _pageShowSubscription = web.EventStreamProviders.pageShowEvent
          .forTarget(web.window)
          .listen((_) => _syncThemeFromStorage());
      _storageSubscription = web.EventStreamProviders.storageEvent
          .forTarget(web.window)
          .listen((event) {
            if (event.key == null || event.key == 'theme') {
              _syncThemeFromStorage();
            }
          });
      _mediaQuerySubscription = web.EventStreamProviders.changeEvent
          .forTarget(prefersDarkQuery)
          .listen((_) {
            if (_currentTheme == .auto) {
              _applyThemeToBody(.auto);
            }
          });
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
    if (classList == null) return .light;
    if (classList.contains(_Theme.auto.id)) {
      return .auto;
    } else if (classList.contains(_Theme.dark.id)) {
      return .dark;
    } else {
      return .light;
    }
  }

  void _applyThemeToBody(_Theme theme) {
    final classList = web.document.body?.classList;
    if (classList == null) return;

    final isAuto = theme == .auto;
    final isDark = isAuto
        ? (_prefersDarkQuery?.matches ?? false)
        : theme == .dark;

    classList.toggle(_Theme.light.id, !isDark);
    classList.toggle(_Theme.dark.id, isDark);
    classList.toggle(_Theme.auto.id, isAuto);
  }

  void _syncThemeFromStorage() {
    _Theme resolvedTheme;
    try {
      // Match the early theme script, which defaults to light
      // when no valid theme is stored.
      resolvedTheme = switch (web.window.localStorage.getItem('theme')) {
        'auto-mode' => .auto,
        'dark-mode' => .dark,
        _ => .light,
      };
    } catch (_) {
      // localStorage is not available, fall back to body classes.
      resolvedTheme = _themeFromBodyClasses();
    }

    _applyThemeToBody(resolvedTheme);

    if (resolvedTheme != _currentTheme) {
      setState(() {
        _currentTheme = resolvedTheme;
      });
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
        span([.text(mode.label)]),
      ],
    ),
  ]);
}
