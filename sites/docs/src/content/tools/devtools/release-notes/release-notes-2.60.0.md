---
title: DevTools 2.60.0 release notes
shortTitle: 2.60.0 release notes
breadcrumb: 2.60.0
description: Release notes for Dart and Flutter DevTools version 2.60.0.
showToc: false
---

The 2.60.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).

## General updates

- Fixed an issue where DevTools could get stuck in a disconnected state
  (such as after a Mac goes to sleep) by adding a manual "Reconnect" button to
  the disconnected screen. -
  [#9838](https://github.com/flutter/devtools/issues/9838)
- Resolved several memory leaks. -
  [#9857](https://github.com/flutter/devtools/pull/9857)
- Fixed a bug where highlighted search matches in tables were unreadable in
  dark mode because the highlight color had become fully opaque. -
  [#9863](https://github.com/flutter/devtools/pull/9863)
- Rejected absolute paths in DevTools server file reads so they
  stay within the `~/.flutter-devtools/` directory and
  can't resolve to arbitrary files on disk. -
  [#9844](https://github.com/flutter/devtools/pull/9844)
- Validated the `devtoolsOptionsUri` parameter in the
  extension enabled-state handler so it must be
  a `file:` URI named `devtools_options.yaml`,
  preventing the DevTools server from writing to arbitrary file paths. -
  [#9834](https://github.com/flutter/devtools/pull/9834)

## Inspector updates

- Fixed an issue where the Inspector error badge count would
  improperly increase or disappear during navigation. -
  [#9524](https://github.com/flutter/devtools/issues/9524)

## Performance updates

- Fixed a bug where the selected feature tab wasn't
  restored when loading exported Performance data. -
  [#9861](https://github.com/flutter/devtools/pull/9861)

## Network profiler updates

- Fixed the Network tab search field becoming disabled
  after clearing all requests,
  so the search query can now be edited at any time. -
  [#9855](https://github.com/flutter/devtools/pull/9855)

## Deep links tool updates

- Only validate deep links when connected to a Flutter app. -
  [#8081](https://github.com/flutter/devtools/issues/8081)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.60.0).
