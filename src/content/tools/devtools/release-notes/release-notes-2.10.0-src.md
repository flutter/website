# DevTools 2.10.0 release notes

The 2.10.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## Flutter inspector updates

* Added search support to the Widget Tree, and 
  added a breadcrumb navigator to the Widget Details Tree to
  allow for quickly navigating through the tree hierarchy -
  [#3525](https://github.com/flutter/devtools/pull/3525)

  ![inspector search](/tools/devtools/release-notes/images-2.10.0/image1.png "inspector_search")

## CPU profiler updates

* Fix a null reference in the CPU profiler
  when loading an offline snapshot -
  [#3596](https://github.com/flutter/devtools/pull/3596)

## Debugger updates

* Added support for multi-token file search, and 
  improved search match prioritization to
  rank file name matches over full path matches - 
  [#3582](https://github.com/flutter/devtools/pull/3582)
* Fix some focus-related issues -
  [#3602](https://github.com/flutter/devtools/pull/3602)

## Logging view updates

* Fix a fatal error that occurred when
  filtering logs more than once -
  [#3588](https://github.com/flutter/devtools/pull/3588)

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.9.2...v2.10.0).
