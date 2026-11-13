---
title: DevTools 2.62.0 release notes
shortTitle: 2.62.0 release notes
breadcrumb: 2.62.0
showToc: false
---

The 2.62.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).

## General updates

* Removed the legacy Provider screen, which was a placeholder to point users to
the `package:provider` DevTools extension. [#10046](https://github.com/flutter/devtools/pull/10046)
* Added user-facing error notifications when importing data files that are
  missing required fields or contain no data for the screen.
  [#10005](https://github.com/flutter/devtools/pull/10005)

## Performance updates

* Reduced the memory used when saving Performance data for offline viewing,
  and made the saved files smaller. Files saved with this version cannot be
  opened in older versions of DevTools. Files saved with older versions can
  still be opened.
  [#10034](https://github.com/flutter/devtools/pull/10034),
  [#10010](https://github.com/flutter/devtools/issues/10010)
* Fixed an issue where importing performance data with Flutter frames but no
  timeline trace would treat the data as empty.
  [#10005](https://github.com/flutter/devtools/pull/10005)

## Debugger updates

* Improved syntax highlighting of fenced code blocks that use more than three
  backticks.
  [#10021](https://github.com/flutter/devtools/pull/10021)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.62.0).
