# DevTools 2.24.0 release notes

The 2.24.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## General updates

* Improve the overall performance of DevTools tables -
  [#5664](https://github.com/flutter/devtools/pull/5664),
  [#5696](https://github.com/flutter/devtools/pull/5696)

## CPU profiler updates

* Fix bug with CPU flame chart selection and tooltips -
  [#5676](https://github.com/flutter/devtools/pull/5676)

## Debugger updates

* Improve support for inspecting
  `UserTag` and `MirrorReferent` instances -
  [#5490](https://github.com/flutter/devtools/pull/5490)
* Fix expression evaluation bug where
  selecting an autocomplete result for a field would clear the current input -
  [#5717](https://github.com/flutter/devtools/pull/5717)
* Make selection of a stack frame 
  scroll to the frame location in the source code -
  [#5722](https://github.com/flutter/devtools/pull/5722)
* Improve performance of searching for a file and searching in a file -
  [#5733](https://github.com/flutter/devtools/pull/5733)
* Disable syntax highlighting for files with more than 100,000 characters
  due to performance constraints -
  [#5743](https://github.com/flutter/devtools/pull/5743)
* Fix bug where source code wasn't visible if
  syntax highlighting for a file was disabled -
  [#5743](https://github.com/flutter/devtools/pull/5743)
* Prevent file names and source code from getting out of sync -
  [#5827](https://github.com/flutter/devtools/pull/5827)

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.23.1...v2.24.0).
