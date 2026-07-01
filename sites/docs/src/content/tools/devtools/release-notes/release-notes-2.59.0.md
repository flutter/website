---
title: DevTools 2.59.0 release notes
shortTitle: 2.59.0 release notes
breadcrumb: 2.59.0
description: Release notes for Dart and Flutter DevTools version 2.59.0.
showToc: false
---

The 2.59.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).

## General updates

- Fixed a `RangeError` thrown by `SplitPane` when the parent
  rebuilt the widget with a different number of children.
  For example, when toggling a panel in or out of the layout. -
  [#9822](https://github.com/flutter/devtools/pull/9822)

## Inspector updates

- Fixed an issue where hover tooltips in the widget tree were
  being clipped by the window boundaries. -
  [#9823](https://github.com/flutter/devtools/pull/9823)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.59.0).
