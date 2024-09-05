# DevTools 2.23.1 release notes

The 2.23.1 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## General updates

* Update DevTools to the new Material 3 design -
  [#5429](https://github.com/flutter/devtools/pull/5429)
* Use the default Flutter service worker -
  [#5331](https://github.com/flutter/devtools/pull/5331)
* Added the new verbose logging feature for helping us debug user issues -
  [#5404](https://github.com/flutter/devtools/pull/5404)

  ![verbose logging](/tools/devtools/release-notes/images-2.23.1/verbose-logging.png "verbose_logging")

* Fix a bug where some asynchronous errors were not being reported -
  [#5456](https://github.com/flutter/devtools/pull/5456)
* Added support for viewing data after an app disconnects for
  screens that support offline viewing
  (currently only the Performance and CPU profiler pages) -
  [#5509](https://github.com/flutter/devtools/pull/5509)
* Include settings button in the footer of the embedded view -
  [#5528](https://github.com/flutter/devtools/pull/5528)

## Performance updates

* Fix a performance regression in timeline event processing -
  [#5460](https://github.com/flutter/devtools/pull/5460)
* Persist a user's preference for whether the
  Flutter Frames chart should be shown by default -
  [#5339](https://github.com/flutter/devtools/pull/5339)
* Point users to [Impeller](https://docs.flutter.dev/perf/impeller) when
  shader compilation jank is detected on an iOS device -
  [#5455](https://github.com/flutter/devtools/pull/5455)
* Remove the CPU profiler from the legacy trace viewer -
  [#5539](https://github.com/flutter/devtools/pull/5539)

## CPU profiler updates

* Add a Method Table to the CPU profiler -
  [#5366](https://github.com/flutter/devtools/pull/5366)

  ![Method table](/tools/devtools/release-notes/images-2.23.1/cpu-method-table.png "method_table")

* Improve the performance of data processing in the CPU profiler -
  [#5468](https://github.com/flutter/devtools/pull/5468),
  [#5533](https://github.com/flutter/devtools/pull/5533),
  [#5535](https://github.com/flutter/devtools/pull/5535)
* Polish and performance improvements for the CPU profile flame chart -
  [#5529](https://github.com/flutter/devtools/pull/5529)
* Add ability to inspect statistics for a CPU profile -
  [#5340](https://github.com/flutter/devtools/pull/5340)
* Fix a bug where Native stack frames were missing their name -
  [#5344](https://github.com/flutter/devtools/pull/5344)
* Fix an error in total and self time calculations for the bottom up tree -
  [#5348](https://github.com/flutter/devtools/pull/5348)
* Add support for zooming and navigating the flame chart
  with ,AOE keys (helpful for Dvorak users) -
  [#5545](https://github.com/flutter/devtools/pull/5545)

## Memory updates

* Fix filtering bug in the "Trace Instances" view -
  [#5406](https://github.com/flutter/devtools/pull/5406)
* Enabled evaluation and browsing for instances in heap snapshot -
  [#5542](https://github.com/flutter/devtools/pull/5542)
* Fix heap snapshot failure -
  [#5520](https://github.com/flutter/devtools/pull/5520)
* Stop displaying external sizes in the allocation profile -
  [#5555](https://github.com/flutter/devtools/pull/5555)
* Expose totals for memory in heap snapshot -
  [#5593](https://github.com/flutter/devtools/pull/5593)

## Debugger updates

* Fix a bug where variable inspection
  for instances sometimes showed no children -
  [#5356](https://github.com/flutter/devtools/pull/5356)
* Hide "search in file" dialog if the "file search" dialog is open -
  [#5393](https://github.com/flutter/devtools/pull/5393)
* Fix file search bug where last letter disappeared when
  searching at end of file name -
  [#5397](https://github.com/flutter/devtools/pull/5397)
* Add search icon in file bar to make file search more discoverable -
  [#5351](https://github.com/flutter/devtools/issues/5351)
* Allow expression evaluation when pausing in JS for web apps -
  [#5427](https://github.com/flutter/devtools/pull/5427)
* Update syntax highlighting to
  [dart-lang/dart-syntax-highlight v1.2.0](https://github.com/dart-lang/dart-syntax-highlight/blob/master/CHANGELOG.md#120-2023-01-30) -
  [#5477](https://github.com/flutter/devtools/pull/5477)
* Debugger panel respects "dense mode" -
  [#5517](https://github.com/flutter/devtools/pull/5517)

## Network profiler updates

* Fix a bug viewing JSON responses with null values -
  [#5424](https://github.com/flutter/devtools/pull/5424)
* Fix a bug where JSON requests were shown in plain text,
  instead of the formatted JSON viewer -
  [#5463](https://github.com/flutter/devtools/pull/5463)
* Fix a UI issue where the copy button on the response or request tab
  would let you copy while still loading the data -
  [#5476](https://github.com/flutter/devtools/pull/5476)

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.22.2...v2.23.1).
