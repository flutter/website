# DevTools 2.11.2 release notes

Dart & Flutter DevTools&mdash;A suite of performance tools
for Dart and Flutter

## General updates

* This release included a lot of cleanup and reduction in technical debt.

## CPU profiler updates

* Added the source line number to file uris in CPU profiles -
  [#3718](https://github.com/flutter/devtools/pull/3718)

  ![cpu stack frame line numbers]({{site.url}}/tools/devtools/release-notes/images-2.11.2/image1.png "cpu stack frame line numbers")

## Debugger updates

* File opener UX improvements, including support for clicking
  the source file name to open the file search window -
  [#3612](https://github.com/flutter/devtools/pull/3612),
  [#3758](https://github.com/flutter/devtools/pull/3758)
* Added support for auto-scrolling the File Explorer to the selected file -
  [#3786](https://github.com/flutter/devtools/pull/3786),
  [#3794](https://github.com/flutter/devtools/pull/3794)

  ![debugger file explorer scrolling]({{site.url}}/tools/devtools/release-notes/images-2.11.2/image2.gif "debugger file explorer scrolling")

## Full commit history

More details about changes and fixes are available from the
[DevTools git log](https://github.com/flutter/devtools/commits/master).
