# DevTools 2.15.0 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## General Updates
The DevTools 2.15 release includes improvements to all tables in
DevTools (logging view, network profiler, CPU profiler, and so on).
See [#4175](https://github.com/flutter/devtools/pull/4175)

## Performance Updates
* Added outlines to each layer displayed in the Raster Metrics
   tool&mdash;[#4192](https://github.com/flutter/devtools/pull/4192)
![raster-metrics-layer-outlines]({{site.url}}/development/tools/devtools/release-notes/images-2.15.0/image1.png "raster metrics layer outlines")
* Fix a bug with loading offline data&mdash;[#4189](https://github.com/flutter/devtools/pull/4189)

## Network Updates
* Added a Json viewer with syntax highlighting for network responses - [#4167](https://github.com/flutter/devtools/pull/4167)
![network-response-json-viewer]({{site.url}}/development/tools/devtools/release-notes/images-2.15.0/image2.png "network response json viewer")
* Added the ability to copy network responses - [#4190](https://github.com/flutter/devtools/pull/4190)

## Memory Updates
* Added the ability to select a different isolate from the DevTools footer - [#4173](https://github.com/flutter/devtools/pull/4173)
* Made the automatic snapshotting feature a configurable setting - [#4200](https://github.com/flutter/devtools/pull/4200)

## CPU Profiler
* Stop manually truncating source URIs in the profiler tables - [#4166](https://github.com/flutter/devtools/pull/4166)

## Changelog
More details about changes and fixes are available in our
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
