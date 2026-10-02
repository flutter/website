// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Inline `<script>` component that defines and runs `applyStoredTheme()`
/// to apply the user's saved theme preference (`light-mode`, `dark-mode`,
/// or `auto-mode`) before the page paints, and keeps it synced across
/// back/forward navigation (`pageshow`), tab storage updates (`storage`),
/// and OS color scheme changes.
const Component themeInitScript = script(
  content: '''
function applyStoredTheme() {
  try {
    const storedTheme = window.localStorage.getItem('theme') ?? 'light-mode';
    const isAuto = storedTheme === 'auto-mode';
    const isDark = isAuto
        ? window.matchMedia('(prefers-color-scheme: dark)').matches
        : storedTheme === 'dark-mode';
    const resolvedTheme = isDark ? 'dark-mode' : 'light-mode';
    const oppositeTheme = isDark ? 'light-mode' : 'dark-mode';
    for (const el of [document.documentElement, document.body]) {
      if (!el) continue;
      if (
        el.classList.contains(resolvedTheme) &&
        el.classList.contains('auto-mode') === isAuto &&
        !el.classList.contains(oppositeTheme)
      ) {
        continue;
      }
      el.classList.remove('light-mode', 'dark-mode', 'auto-mode');
      if (isAuto) {
        el.classList.add('auto-mode', resolvedTheme);
      } else {
        el.classList.add(resolvedTheme);
      }
    }
  } catch (_) {
    // localStorage is not available; fall back to default light theme.
  }
}
applyStoredTheme();
window.addEventListener('pageshow', applyStoredTheme);
window.addEventListener('storage', applyStoredTheme);
window
    .matchMedia('(prefers-color-scheme: dark)')
    .addEventListener('change', applyStoredTheme);
''',
);

/// Inline `<script>` component that runs `applyStoredTheme()` immediately
/// when `<body>` opens so `document.body` receives theme classes before
/// any body content renders.
const Component themeSyncBodyScript = script(content: 'applyStoredTheme();');
