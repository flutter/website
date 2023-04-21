# DevTools 2.19.0 release notes

Dart & Flutter DevTools&emdash;A suite of performance tools
for Dart and Flutter

## Performance updates

* Added a button to toggle the visibility of the Flutter Frames
  chart - [#4577](https://github.com/flutter/devtools/pull/4577) 
  ![diff]({{site.url}}/development/tools/devtools/release-notes/images-2.19.0/4577.png "Flutter Frames")
* Polish the debug mode warning to better describe which data
  is accurate in debug mode and which data may be misleading -
  [#3537](https://github.com/flutter/devtools/pull/3537) 
* Reorder performance tool tabs and only show the CPU profiler
  for the “Timeline Events” tab -
  [#4629](https://github.com/flutter/devtools/pull/4629) 

## Memory updates

* Improvements to the memory Profile tab -
  [#4583](https://github.com/flutter/devtools/pull/4583)

## Debugger updates

* Fix an issue with hovercards where they were appearing
  but never disappearing -
  [#4627](https://github.com/flutter/devtools/pull/4627) 
* Fix a bug with the file search autocomplete dialog -
  [#4409](https://github.com/flutter/devtools/pull/4409) 

## Network profiler updates

* Added a “Copy” button in the Network Request view
  (thanks to @netos23) -
  [#4509](https://github.com/flutter/devtools/pull/4509) 

## Changelog

More details about changes and fixes are available in the DevTools
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
