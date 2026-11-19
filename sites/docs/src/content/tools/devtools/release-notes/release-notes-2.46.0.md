---
title: DevTools 2.46.0 release notes
shortTitle: 2.46.0 release notes
breadcrumb: 2.46.0
description: Release notes for Dart and Flutter DevTools version 2.46.0.
showToc: false
---

The 2.46.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).

## General updates

- Fixed a bug which caused web apps to remain paused after triggering a hot-restart from
  DevTools. - [#9125](https://github.com/flutter/devtools/pull/9125)
- Landed a change to dismiss stale banner messages when the connected app state changes. - [#9148](https://github.com/flutter/devtools/pull/9148)
- Fixed a focus traversal issue with search fields. [#9166](https://github.com/flutter/devtools/pull/9166)

## Performance updates

- Fixed a bug where the Performance page would hang when connected to a paused
  Flutter app. - [#9162](https://github.com/flutter/devtools/pull/9162)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.46.0).
