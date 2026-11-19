---
title: DevTools 2.51.1 release notes
shortTitle: 2.51.1 release notes
breadcrumb: 2.51.1
showToc: false
---

The 2.51.1 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).

## General updates

- Flutter beta channel users were opted into the DevTools-on-Wasm experiment.
  All other users can still enable the Wasm-compiled DevTools from the settings
  dialog. - [#9455](https://github.com/flutter/devtools/pull/9455)
- Added a horizontal scrollbar to data tables to help with navigation. -
  [#9482](https://github.com/flutter/devtools/pull/9482)
- Made it possible to resize data table columns by dragging the header separators. -
  [#9485](https://github.com/flutter/devtools/pull/9485)

## Inspector updates

- Fixed an issue where selecting a widget with the Inspector would open the
  widget definition file instead of the user's project file. -
  [#176530](https://github.com/flutter/flutter/pull/176530)

## Network profiler updates

- Fixed layout of the "error count" badge in the tab name. -
  [#9470](https://github.com/flutter/devtools/pull/9470)
- Fixed display of "Response Headers" and "Request Headers" when there are no
  headers. - [#9492](https://github.com/flutter/devtools/pull/9492)
- Added a banner to clearly indicate when DevTools is not logging network
  requests. - [#9495](https://github.com/flutter/devtools/pull/9495)

## VS Code updates

- Fixed issue preventing shortcuts like `Cmd`+`C` and `Cmd`+`V` from working when DevTools was
  embedded inside VS Code on macOS. -
  [#9472](https://github.com/flutter/devtools/pull/9472)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.51.1).
