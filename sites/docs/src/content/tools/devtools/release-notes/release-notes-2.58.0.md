---
title: DevTools 2.58.0 release notes
shortTitle: 2.58.0 release notes
breadcrumb: 2.58.0
showToc: false
---

The 2.58.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).

## Inspector updates

- Deleted the option to use the legacy inspector.
  [#9782](https://github.com/flutter/devtools/pull/9782)
- Fixed an issue where navigating the Inspector widget tree with the keyboard arrow keys did not update the selected widget in the connected Flutter app. [#9810](https://github.com/flutter/devtools/pull/9810)
- Fixed an issue where clicking a widget row after collapsing a subtree with the left arrow key unexpectedly re-expanded the subtree. [#9810](https://github.com/flutter/devtools/pull/9810)
- Fixed an issue where collapsing the Inspector widget tree to a single row with the left arrow key caused a loading spinner to appear instead of showing the root node. [#9810](https://github.com/flutter/devtools/pull/9810)

## Performance updates

- Fixed an issue where 'More Debug Options' showed options as unselected in
profile mode even when selected. [#9813](https://github.com/flutter/devtools/issues/9813)

## Debugger updates

- Fixed an issue where long string values in the console/variables view would overflow and overlap with other elements. [#7112](https://github.com/flutter/devtools/issues/7112)

## Network profiler updates

- Added response size column to the Network tab and displayed response size in the request inspector overview.  
  [#9744](https://github.com/flutter/devtools/pull/9744)

- Improved HTTP request status classification in the Network tab to better distinguish cancelled, completed, and in-flight requests (for example, avoiding some cases where cancelled requests appeared as pending). [#9683](https://github.com/flutter/devtools/pull/9683)

- Added a filter setting to hide HTTP-profiler socket data.  
  [#9698](https://github.com/flutter/devtools/pull/9698)
  
## Logging updates

- Fixed an issue where log messages containing newline characters were incorrectly split into multiple separate entries in the Logging screen. [#9757](https://github.com/flutter/devtools/pull/9757)

## Deep links tool updates

- Pluralized "domain" and "path" in the validation summary notification titles when multiple errors are present. [#9790](https://github.com/flutter/devtools/pull/9790)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.58.0).
