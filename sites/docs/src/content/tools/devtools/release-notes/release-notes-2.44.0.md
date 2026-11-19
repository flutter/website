---
title: DevTools 2.44.0 release notes
shortTitle: 2.44.0 release notes
breadcrumb: 2.44.0
description: Release notes for Dart and Flutter DevTools version 2.44.0.
showToc: false
---

The 2.44.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).

## General updates

* Fixed various memory leaks and lifecycle issues. -
  [#8901](https://github.com/flutter/devtools/pull/8901),
  [#8902](https://github.com/flutter/devtools/pull/8902),
  [#8907](https://github.com/flutter/devtools/pull/8907),
  [#8917](https://github.com/flutter/devtools/pull/8917),
  [#8932](https://github.com/flutter/devtools/pull/8932),
  [#8933](https://github.com/flutter/devtools/pull/8933),
  [#8934](https://github.com/flutter/devtools/pull/8934),
  [#8935](https://github.com/flutter/devtools/pull/8935),
  [#8937](https://github.com/flutter/devtools/pull/8937),
  [#8953](https://github.com/flutter/devtools/pull/8953),
  [#8969](https://github.com/flutter/devtools/pull/8969),
  [#8970](https://github.com/flutter/devtools/pull/8970),
  [#8975](https://github.com/flutter/devtools/pull/8975)

## CPU profiler updates

* Improved the load time and memory usage of CPU profiles.
  * [#8892](https://github.com/flutter/devtools/pull/8892)
  * [#8878](https://github.com/flutter/devtools/pull/8878)
  * [#8839](https://github.com/flutter/devtools/pull/8839)
* Fixed incorrect duration calculations when there is time during which no
  samples were taken - [#8941](https://github.com/flutter/devtools/pull/8941).

## Memory updates

* Changed the memory heap snapshot tool so that references are
  included in snapshots by default. -
  [#8899](https://github.com/flutter/devtools/pull/8899)

## Debugger updates

* Added a tooltip to describe the exception mode drop-down. -
  [#8849](https://github.com/flutter/devtools/pull/8849)
* Updated syntax highlighting with support for digit separators
  and improved comment and string interpolation handling. -
  [#8861](https://github.com/flutter/devtools/pull/8861)
* Updated `string_scanner` dependency to avoid some syntax highlighting issues
  when source contains `\r\n` in certain positions on Windows. -
  [#8904](https://github.com/flutter/devtools/pull/8904)
* Added soft line wrapping in the debugger console.
  [#8855](https://github.com/flutter/devtools/pull/8855).

## Network profiler updates

* Added offline support for the network screen (thanks to @hrajwade96!) -
  [#8332](https://github.com/flutter/devtools/pull/8332)

  ![Network profiler controls](/assets/images/docs/tools/devtools/release-notes/images-2.44.0/network_controls.png "Network profiler controls")

  ![Network profiler open / save button](/assets/images/docs/tools/devtools/release-notes/images-2.44.0/network_open_save_button.png "Network profiler open / save button")

* Changed the context menu style to be consistent with other screens
  [#8859](https://github.com/flutter/devtools/pull/8859).

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.44.0).
