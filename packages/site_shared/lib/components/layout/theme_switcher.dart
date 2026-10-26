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
  /// The theme the user selected, which is marked as selected in the menu.
  _Theme _currentTheme = .light;

  /// The media query for whether the device prefers a dark color scheme,
  /// used to resolve the [_Theme.auto] theme.
  late final web.MediaQueryList _prefersDarkQuery;

  /// The subscriptions to window and media query events,
  /// which are canceled when this state is disposed.
  final List<StreamSubscription<web.Event>> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _prefersDarkQuery = web.window.matchMedia('(prefers-color-scheme: dark)');
      _syncThemeFromStorage();
      _subscriptions.addAll([
        web.EventStreamProviders.pageShowEvent
            .forTarget(web.window)
            .listen(_onPageShow),
        web.EventStreamProviders.storageEvent
            .forTarget(web.window)
            .listen(_onStorageChange),
        web.EventStreamProviders.changeEvent
            .forTarget(_prefersDarkQuery)
            .listen(_onPrefersDarkChange),
      ]);
    }
  }

  @override
  void dispose() {
    // DOM event stream cancellations complete synchronously and
    // don't need to be awaited in synchronous lifecycle teardown.
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    super.dispose();
  }

  /// Resyncs the theme when the page is restored from the back/forward cache,
  /// as it might have been changed on another page.
  void _onPageShow(web.Event event) {
    if ((event as web.PageTransitionEvent).persisted) {
      _syncThemeFromStorage();
    }
  }

  /// Resyncs the theme when another tab or window changes
  /// the stored theme preference or clears storage.
  void _onStorageChange(web.StorageEvent event) {
    if (event.key == null || event.key == 'theme') {
      _syncThemeFromStorage();
    }
  }

  /// Reapplies the automatic theme when
  /// the device's preferred color scheme changes.
  void _onPrefersDarkChange(web.Event _) {
    if (_currentTheme == .auto) {
      _applyThemeToBody(.auto);
    }
  }

  /// Updates the theme classes on the document body to reflect [theme],
  /// resolving [_Theme.auto] to light or dark based on the device preference.
  void _applyThemeToBody(_Theme theme) {
    final classList = web.document.body?.classList;
    if (classList == null) return;

    final isAuto = theme == .auto;
    final isDark = isAuto ? _prefersDarkQuery.matches : theme == .dark;

    classList.toggle(_Theme.light.id, !isDark);
    classList.toggle(_Theme.dark.id, isDark);
    classList.toggle(_Theme.auto.id, isAuto);
  }

  /// Applies the theme preference saved in local storage
  /// and updates [_currentTheme] to match it.
  void _syncThemeFromStorage() {
    _Theme resolvedTheme;
    try {
      // Match the early theme script, which defaults to light
      // when no valid theme is stored.
      final storedTheme = web.window.localStorage.getItem('theme');
      resolvedTheme = _Theme.values.firstWhere(
        (theme) => theme.id == storedTheme,
        orElse: () => .light,
      );
    } catch (_) {
      // localStorage is not available, keep the current theme.
      resolvedTheme = _currentTheme;
    }

    _applyThemeToBody(resolvedTheme);

    if (resolvedTheme != _currentTheme) {
      setState(() {
        _currentTheme = resolvedTheme;
      });
    }
  }

  /// Applies [newTheme] and saves it as the user's theme preference.
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
