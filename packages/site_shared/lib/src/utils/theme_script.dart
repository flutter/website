// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Inline `<script>` component that
/// applies the user's saved theme preference to
/// `document.body` before the page paints.
const Component themeInitScript = script(
  content: '''
try {
  const storedTheme = window.localStorage.getItem('theme');
  const isAuto = storedTheme === 'auto-mode';
  const isDark = isAuto
      ? window.matchMedia('(prefers-color-scheme: dark)').matches
      : storedTheme === 'dark-mode';
  document.body.classList.add(isDark ? 'dark-mode' : 'light-mode');
  if (isAuto) document.body.classList.add('auto-mode');
} catch (_) {
  // localStorage is not available; fall back to default light theme.
}
''',
);
