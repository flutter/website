# DevTools 2.13.1 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## General Updates
* This release included a lot of cleanup and reduction in technical debt. The most notable is the completion of our
migration to sound null safety. Please see our
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md) for a detailed list of commits.
* Show release notes in embedded versions of DevTools (i.e. when DevTools is embedded in your IDE) - [#4053](https://github.com/flutter/devtools/pull/4053)
* Polish to the DevTools footer - [#3989](https://github.com/flutter/devtools/pull/3989),
[#4026](https://github.com/flutter/devtools/pull/4026),
[#4041](https://github.com/flutter/devtools/pull/4041),
[#4076](https://github.com/flutter/devtools/pull/4076)

## Performance Updates
* Added a new feature to help you debug raster jank in your Flutter app. This feature allows you to take a snapshot
of the current screen shown in your app, and then break down rendering time for that scene by layer. This can help you
identify parts of a scene that are expensive to rasterize - [#4046](https://github.com/flutter/devtools/pull/4046)

![raster-metrics-feature]({{site.url}}/development/tools/devtools/release-notes/images-2.13.1/image1.png "raster metrics feature")

* Added a scope setting for "Track Widget Builds", allowing you to specify whether widget builds should be tracked in
your code only or in all code - [#4010](https://github.com/flutter/devtools/pull/4010)

![track-widget-builds-scope-setting]({{site.url}}/development/tools/devtools/release-notes/images-2.13.1/image2.png "track widget builds scope setting")

## CPU Profiler Updates
* Use package uris instead of file uris in the CPU profiler "Source" column - [#3932](https://github.com/flutter/devtools/pull/3932)

## Debugger Updates
* Fix scrolling bug with debugger breakpoints - [#4074](https://github.com/flutter/devtools/pull/4074)

## Flutter Inspector Updates
* Add support for displaying flex values larger than 5 in the Layout Explorer - [#4055](https://github.com/flutter/devtools/pull/4055)

## Changelog
More details about changes and fixes are available in our
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
