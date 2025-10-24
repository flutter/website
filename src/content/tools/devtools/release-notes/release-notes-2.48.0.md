---
title: DevTools 2.48.0 release notes
shortTitle: 2.48.0 release notes
breadcrumb: 2.48.0
description: Release notes for Dart and Flutter DevTools version 2.48.0.
showToc: false
---

The 2.48.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).

## Network profiler updates

* Fixed network logging after a hot restart. -
  [#9271](https://github.com/flutter/devtools/pull/9271).

## Logging updates

* Started displaying events related to timers in the Logging View. -
  [#9238](https://github.com/flutter/devtools/pull/9238).

## Advanced developer mode updates

* Added a Queued Microtasks tab to the VM Tools screen, which allows a user to
  see details about the microtasks scheduled in an isolate's microtask queue.
  This tab currently only appears when DevTools is connected to a Flutter or
  Dart app started with `--profile-microtasks`. -
  [#9239](https://github.com/flutter/devtools/pull/9239).

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.48.0).
