---
title: DevTools 2.11.2 release notes
shortTitle: 2.11.2 release notes
breadcrumb: 2.11.2
description: Release notes for Dart and Flutter DevTools version 2.11.2.
showToc: false
---

The 2.11.2 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## General updates

* This release included a lot of cleanup and reduction in technical debt.

## CPU profiler updates

* Added the source line number to file uris in CPU profiles -
  [#3718](https://github.com/flutter/devtools/pull/3718)

  ![cpu stack frame line numbers](/assets/images/docs/tools/devtools/release-notes/images-2.11.2/image1.png "cpu stack frame line numbers")

## Debugger updates

* File opener UX improvements, including support for clicking
  the source file name to open the file search window -
  [#3612](https://github.com/flutter/devtools/pull/3612),
  [#3758](https://github.com/flutter/devtools/pull/3758)
* Added support for auto-scrolling the File Explorer to the selected file -
  [#3786](https://github.com/flutter/devtools/pull/3786),
  [#3794](https://github.com/flutter/devtools/pull/3794)

  ![debugger file explorer scrolling](/assets/images/docs/tools/devtools/release-notes/images-2.11.2/image2.gif "debugger file explorer scrolling")

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.10.0...v2.11.2).
