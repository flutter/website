# DevTools 2.19.0 release notes

The 2.19.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## Performance updates

* Added a button to toggle the visibility of the Flutter Frames chart -
  [#4577](https://github.com/flutter/devtools/pull/4577)

  ![diff](/tools/devtools/release-notes/images-2.19.0/4577.png "Flutter Frames")

* Polish the debug mode warning to better describe which data is
  accurate in debug mode and which data may be misleading -
  [#3537](https://github.com/flutter/devtools/pull/3537) 
* Reorder performance tool tabs and only show the CPU profiler
  for the "Timeline Events" tab -
  [#4629](https://github.com/flutter/devtools/pull/4629) 

## Memory updates

* Improvements to the memory Profile tab -
  [#4583](https://github.com/flutter/devtools/pull/4583)

## Debugger updates

* Fix an issue with hover cards where they were appearing
  but never disappearing -
  [#4627](https://github.com/flutter/devtools/pull/4627) 
* Fix a bug with the file search autocomplete dialog -
  [#4409](https://github.com/flutter/devtools/pull/4409) 

## Network profiler updates

* Added a "Copy" button in the Network Request view
  (thanks to @netos23) -
  [#4509](https://github.com/flutter/devtools/pull/4509) 

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.18.0...v2.19.0).

