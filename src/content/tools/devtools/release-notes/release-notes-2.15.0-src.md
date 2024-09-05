# DevTools 2.15.0 release notes

The 2.15.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## General updates

* The DevTools 2.15 release includes improvements to all tables in
  DevTools (logging view, network profiler, CPU profiler, and so on) -
  [#4175](https://github.com/flutter/devtools/pull/4175)

## Performance updates

* Added outlines to each layer displayed in the Raster Metrics tool -
  [#4192](https://github.com/flutter/devtools/pull/4192)

  ![raster-metrics-layer-outlines](/tools/devtools/release-notes/images-2.15.0/image1.png "raster metrics layer outlines")

* Fix a bug with loading offline data -
  [#4189](https://github.com/flutter/devtools/pull/4189)

## Network updates

* Added a Json viewer with syntax highlighting for network responses -
  [#4167](https://github.com/flutter/devtools/pull/4167)

  ![network-response-json-viewer](/tools/devtools/release-notes/images-2.15.0/image2.png "network response json viewer")

* Added the ability to copy network responses -
  [#4190](https://github.com/flutter/devtools/pull/4190)

## Memory updates

* Added the ability to select a different isolate from the DevTools footer -
  [#4173](https://github.com/flutter/devtools/pull/4173)
* Made the automatic snapshotting feature a configurable setting -
  [#4200](https://github.com/flutter/devtools/pull/4200)

## CPU profiler

* Stop manually truncating source URIs in the profiler tables -
  [#4166](https://github.com/flutter/devtools/pull/4166)

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.14.0...v2.15.0).
