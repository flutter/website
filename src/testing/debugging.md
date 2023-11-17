---
title: Debugging Flutter apps
description: How to debug your app using the DevTools suite.
---

<?code-excerpt path-base="testing/debugging"?>

There's a wide variety of tools and features to help debug
Flutter applications. Here are some of the available tools:

* [VS Code][](recommended) and [Android Studio/IntelliJ][], 
  (enabled with the Flutter and Dart plugins)
  support a built-in source-level debugger with
  the ability to set breakpoints, step through code,
  and examine values.
* If you are looking for a way to use GDB to remotely debug the
  Flutter engine running within an Android app process,
  check out [`flutter_gdb`][].
* [DevTools][], a suite of performance and profiling
  tools that run in a browser.
* [Flutter inspector][], a widget inspector available
  in DevTools, and also directly from Android Studio
  and IntelliJ (enabled with the Flutter plugin).
  The inspector allows you to examine a visual
  representation of the widget tree, inspect
  individual widgets and their property values,
  enable the performance overlay, and more.


[`flutter_gdb`]: https://github.com/flutter/engine/blob/main/sky/tools/flutter_gdb

## Other resources

You might find the following docs useful:

* [Performance best practices][]
* [Flutter performance profiling][]
* [Use a native debugger][]
* [Flutter's modes][]
* [Debugging Flutter apps programmatically][]

[Flutter enabled IDE/editor]: {{site.url}}/get-started/editor

[Debugging Flutter apps programmatically]: {{site.url}}/testing/code-debugging
[perform traces programmatically]: {{site.url}}/testing/code-debugging#tracing-dart-code-performance
[Debug flags: application layers]: {{site.url}}/testing/code-debugging#debug-flags-application-layers
[Debug flags: performance]: {{site.url}}/testing/code-debugging#debug-flags-performance
[slow the animations programmatically]: {{site.url}}/testing/code-debugging#debugging-animations
[breakpoints]: {{site.url}}/testing/code-debugging#setting-breakpoints
[logging]: {{site.url}}/testing/code-debugging#logging
[Flutter's modes]: {{site.url}}/testing/build-modes
[Flutter performance profiling]: {{site.url}}/perf/ui-performance
[Performance best practices]: {{site.url}}/perf/best-practices
[Use a native debugger]: {{site.url}}/testing/native-debugging

[The Layer Cake]: {{site.medium}}/flutter-community/the-layer-cake-widgets-elements-renderobjects-7644c3142401

[GitHub wiki]: {{site.repo.flutter}}/wiki/
[Using the Dart analyzer]: {{site.repo.flutter}}/wiki/Using-the-Dart-analyzer
[The Framework architecture]: {{site.repo.flutter}}/wiki/The-Framework-architecture

[Android Studio/IntelliJ]: {{site.url}}/tools/android-studio#run-app-with-breakpoints
[VS Code]: {{site.url}}/tools/vs-code#run-app-with-breakpoints
[DevTools]: {{site.url}}/tools/devtools
[Flutter inspector]: {{site.url}}/tools/devtools/inspector
[DevTools debugger]: {{site.url}}/tools/devtools/debugger
[logging view]: {{site.url}}/tools/devtools/logging
[Timeline view]: {{site.url}}/tools/devtools/performance
[The performance overlay]: {{site.url}}/perf/ui-performance#the-performance-overlay
[Flutter performance profiling]: {{site.url}}/perf/ui-performance
[overlay]: {{site.url}}/testing/code-debugging#performance-overlay
[debug mode]: {{site.url}}/testing/build-modes#debug
[profile mode]: {{site.url}}/testing/build-modes#profile
[release mode]: {{site.url}}/testing/build-modes#release
[how the Widget Inspector uses widget creation tracking]: {{site.url}}/tools/devtools/inspector#track-widget-creation

[Assert]: {{site.dart-site}}/language/error-handling#assert
[Dart language documentation]: {{site.dart-site}}/language

[WidgetInspectorService.isWidgetCreationTracked]: {{site.api}}/flutter/widgets/WidgetInspectorService/isWidgetCreationTracked.html
[widget_inspector.dart]: {{site.repo.flutter}}/blob/master/packages/flutter/lib/src/widgets/widget_inspector.dart
[kernel transform that implements this feature]: {{site.github}}/dart-lang/sdk/blob/main/pkg/kernel/lib/transformations/track_widget_constructor_locations.dart
