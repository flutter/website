---
title: Debugging Flutter apps
description: How to debug your Flutter app.
---

<?code-excerpt path-base="testing/debugging"?>

There's a wide variety of tools and features to help debug
Flutter applications. Here are some of the available tools:

* [VS Code][](recommended) and [Android Studio/IntelliJ][], 
  (enabled with the Flutter and Dart plugins)
  support a built-in source-level debugger with
  the ability to set breakpoints, step through code,
  and examine values.
* [DevTools][], a suite of performance and profiling
  tools that run in a browser.
* [Flutter inspector][], a widget inspector available
  in DevTools, and also directly from Android Studio
  and IntelliJ (enabled with the Flutter plugin).
  The inspector allows you to examine a visual
  representation of the widget tree, inspect
  individual widgets and their property values,
  enable the performance overlay, and more.
* If you are looking for a way to use GDB to remotely debug the
  Flutter engine running within an Android app process,
  check out [`flutter_gdb`][].


[`flutter_gdb`]: {{site.repo.engine}}/blob/main/sky/tools/flutter_gdb

## Other resources

You might find the following docs useful:

* [Performance best practices][]
* [Flutter performance profiling][]
* [Use a native debugger][]
* [Flutter's modes][]
* [Debugging Flutter apps programmatically][]

[Flutter enabled IDE/editor]: {{site.url}}/get-started/editor

[Debugging Flutter apps programmatically]: {{site.url}}/testing/code-debugging
[Flutter's modes]: {{site.url}}/testing/build-modes
[Flutter performance profiling]: {{site.url}}/perf/ui-performance
[Performance best practices]: {{site.url}}/perf/best-practices
[Use a native debugger]: {{site.url}}/testing/native-debugging

[Android Studio/IntelliJ]: {{site.url}}/tools/android-studio#run-app-with-breakpoints
[VS Code]: {{site.url}}/tools/vs-code#run-app-with-breakpoints
[DevTools]: {{site.url}}/tools/devtools
[Flutter inspector]: {{site.url}}/tools/devtools/inspector
