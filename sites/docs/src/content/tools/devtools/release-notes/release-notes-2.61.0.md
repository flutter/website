---
title: DevTools 2.61.0 release notes
shortTitle: 2.61.0 release notes
breadcrumb: 2.61.0
showToc: false
---

The 2.61.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).

## General updates

* Fixed unreadable text in the release notes panel, where blockquotes were
  drawn on a hard coded light blue background in the dark theme.
  [#9957](https://github.com/flutter/devtools/pull/9957)
* Added support for proxying the VM service connection over a `MessagePort`
  using `?uri=messageport:<origin>`.
  [#9964](https://github.com/flutter/devtools/pull/9964)

## Inspector updates

* Added the widget source file path to the Inspector details pane
  (`filename.dart:line:column`), matching legacy Inspector behavior.
  [#9972](https://github.com/flutter/devtools/pull/9972),
  [#9922](https://github.com/flutter/devtools/issues/9922)

## Performance updates

* Fixed a bug where the Flutter frames chart could appear frozen after
  switching away from the Performance screen and coming back.
  [#9960](https://github.com/flutter/devtools/pull/9960)
* Added a message in the Performance panel when widget rebuild tracking is
  unavailable because the app is running in profile mode.
  [#9755](https://github.com/flutter/devtools/pull/9755)

## CPU profiler updates

* Fixed a bug where resizing the CPU flame chart changes the timing values
  across the top of the chart.
  [#9915](https://github.com/flutter/devtools/pull/9915)

## Memory updates

* Added the ability to pin classes to the top of the Profile Memory table.
  [#8898](https://github.com/flutter/devtools/issues/8898)

## Debugger updates

* Prevented values from being garbage-collected, while being evaluated.
  [#9885](https://github.com/flutter/devtools/pull/9885)
* Updated to latest version of the Dart syntax highlighting grammar
  [#9920](https://github.com/flutter/devtools/pull/9920)
* Fixed a bug in the TextMate grammar parser that could result in code after
  comments being classified as comments.
  [#9921](https://github.com/flutter/devtools/pull/9921)
* Fixed an overflow in the debugging controls when the Debugger screen is
  narrow, such as when DevTools is embedded in an IDE side panel. The controls
  now scroll horizontally instead of overflowing.
  [#9949](https://github.com/flutter/devtools/pull/9949)

## Network profiler updates

* Fixed Copy as cURL omitting request headers and body for failed or timed-out
  requests. [#9963](https://github.com/flutter/devtools/pull/9963)
* Added WebSocket support to the Network profiler, including WebSocket
  connection details, lifecycle events, frame-level inspection, and connection
  timing information. [#9968](https://github.com/flutter/devtools/pull/9968)
* Fixed an issue where the Network tab would stop capturing HTTP requests after
  a hot restart.
  [#9856](https://github.com/flutter/devtools/pull/9856)
* Fixed an issue where the Network tab would stop capturing new HTTP requests
  after pressing Clear while recording.
  [#9856](https://github.com/flutter/devtools/pull/9856)

## Logging updates

* Corrected time units and cumulative nature of GC events.
  [#9890](https://github.com/flutter/devtools/pull/9890)
* Fixed a bug where long `dart:developer` log messages lost their structured
  Details view.
  [#10011](https://github.com/flutter/devtools/pull/10011)

## Deep links tool updates

* Added a "Watch tutorial" link to the status line that points to the
  [deep links video tutorial](https://youtu.be/d7sZL6hIElw).
  [#9925](https://github.com/flutter/devtools/pull/9925)
* Validated build option parameters and surfaced iOS universal link settings
  errors in the Deep Links tool.
  [#10022](https://github.com/flutter/devtools/pull/10022)

## DevTools extension updates

* Hide the DevTools extensions menu button in single-screen embedded mode
  (`EmbedMode.embedOne`) on standard screens.
  [#8507](https://github.com/flutter/devtools/issues/8507)
* Added iframe sandboxing for embedded DevTools extensions to enforce origin
  isolation. [#9967](https://github.com/flutter/devtools/pull/9967)
* Improved DevTools extension isolation by tracking the providing package
  name for enablement, deduplication, and asset loading.
  [#9981](https://github.com/flutter/devtools/pull/9981)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.61.0).
