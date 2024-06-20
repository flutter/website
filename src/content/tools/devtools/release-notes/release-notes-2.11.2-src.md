# DevTools 2.11.2 release notes

The 2.11.2 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## General updates

* This release included a lot of cleanup and reduction in technical debt.

## CPU profiler updates

* Added the source line number to file uris in CPU profiles -
  [#3718](https://github.com/flutter/devtools/pull/3718)

  ![cpu stack frame line numbers](/tools/devtools/release-notes/images-2.11.2/image1.png "cpu stack frame line numbers")

## Debugger updates

* File opener UX improvements, including support for clicking
  the source file name to open the file search window -
  [#3612](https://github.com/flutter/devtools/pull/3612),
  [#3758](https://github.com/flutter/devtools/pull/3758)
* Added support for auto-scrolling the File Explorer to the selected file -
  [#3786](https://github.com/flutter/devtools/pull/3786),
  [#3794](https://github.com/flutter/devtools/pull/3794)

  ![debugger file explorer scrolling](/tools/devtools/release-notes/images-2.11.2/image2.gif "debugger file explorer scrolling")

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.10.0...v2.11.2).
