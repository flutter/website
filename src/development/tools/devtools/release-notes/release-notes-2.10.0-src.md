# DevTools 2.10.0 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## Flutter Inspector Updates
* Added search support to the Widget Tree, and added a breadcrumb navigator to the Widget Details Tree to allow for quickly navigating through the tree hierarchy - [#3525](https://github.com/flutter/devtools/pull/3525)

![inspector search]({{site.url}}/development/tools/devtools/release-notes/images-2.10.0/image1.png "inspector_search")

## CPU Profiler Updates
* Fix a null ref in the CPU profiler when loading an offline snapshot - [#3596](https://github.com/flutter/devtools/pull/3596)

## Debugger Updates
* Added support for multi-token file search, and improved search match prioritization to rank file name matches over full path matches - 
  [#3582](https://github.com/flutter/devtools/pull/3582)
* Fix some focus-related issues - [#3602](https://github.com/flutter/devtools/pull/3602)

## Logging View Updates
* Fix a fatal error that occurred when filtering logs more than once - [#3588](https://github.com/flutter/devtools/pull/3588)

## Changelog
More details about changes and fixes are available in our
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
