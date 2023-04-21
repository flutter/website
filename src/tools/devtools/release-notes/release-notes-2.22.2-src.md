# DevTools 2.22.2 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## General updates
- Prevent crashes if there is no main isolate - [#5232](https://github.com/flutter/devtools/pull/5232)

## CPU profiler updates
- Display stack frame uri inline with method name to ensure the URI is always visible
in deeply nested trees - [#5181](https://github.com/flutter/devtools/pull/5181)

  ![inline uri]({{site.url}}/development/tools/devtools/release-notes/images-2.22.2/5181.png "inline uri")

- Add the ability to filter by method name or source URI - [#5204](https://github.com/flutter/devtools/pull/5204)

## Memory updates
- Change filter default to show only project and 3rd party dependencies [#5201](https://github.com/flutter/devtools/pull/5201).

  ![filter default]({{site.url}}/development/tools/devtools/release-notes/images-2.22.2/5201.png "filter default")

- Support expression evaluation in console for running application [#5248](https://github.com/flutter/devtools/pull/5248).

  ![evaluation]({{site.url}}/development/tools/devtools/release-notes/images-2.22.2/5248.png "evaluation")

- Add column `Persisted` for memory diffing [#5290](https://github.com/flutter/devtools/pull/5290)

  ![persisted]({{site.url}}/development/tools/devtools/release-notes/images-2.22.2/5290.png "persisted")

## Debugger updates
- Add support for browser navigation history when navigating using the `File Explorer` [#4906](https://github.com/flutter/devtools/pull/4906)
- Designate positional fields for `Record` types with the getter syntax beginning at `$1` [#5272](https://github.com/flutter/devtools/pull/5272)
- Fix variable inspection for `Map` and `List` instances: [#5320](https://github.com/flutter/devtools/pull/5320)

  ![map and list]({{site.url}}/development/tools/devtools/release-notes/images-2.22.2/5320.png "map and list")

- Fix variable inspection for `Set` instances: [#5323](https://github.com/flutter/devtools/pull/5323)

  ![set]({{site.url}}/development/tools/devtools/release-notes/images-2.22.2/5323.png "set")


## Network profiler updates
- Improve reliability and performance of the Network tab - [#5056](https://github.com/flutter/devtools/pull/5056)

## Changelog
More details about changes and fixes are available in the DevTools
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
