---
title: DevTools 2.54.0 release notes
shortTitle: 2.54.0 release notes
breadcrumb: 2.54.0
showToc: false
---

The 2.54.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).

## General updates

- Dropped connections to DTD will now automatically be retried to improve the
  experience when your machine is resumed from sleep. -
  [#9587](https://github.com/flutter/devtools/pull/9587)

## Inspector updates

- Added a warning banner that the legacy inspector
  will be removed in a future release. -
  [#9572](https://github.com/flutter/devtools/pull/9572)

## Memory updates

- Fixed an error preventing users from changing the zoom duration. -
  [#9573](https://github.com/flutter/devtools/pull/9573)

## Deep links tool updates

- Added a more informative dialog if the Deep Links tool is
  unable to find build options for the iOS or Android app. -
  [#9571](https://github.com/flutter/devtools/pull/9571)
- Fixed null error when parsing universal link settings. -
  [#9581](https://github.com/flutter/devtools/pull/9581)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.54.0).
