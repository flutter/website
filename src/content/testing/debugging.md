---
title: Debug Flutter apps
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


[`flutter_gdb`]: {{site.repo.flutter}}/blob/main/engine/src/flutter/sky/tools/flutter_gdb

## Other resources

You might find the following docs useful:

* [Performance best practices][]
* [Flutter performance profiling][]
* [Use a native debugger][]
* [Flutter's modes][]
* [Debugging Flutter apps programmatically][]

[Flutter enabled IDE/editor]: /get-started/editor

[Debugging Flutter apps programmatically]: /testing/code-debugging
[Flutter's modes]: /testing/build-modes
[Flutter performance profiling]: /perf/ui-performance
[Performance best practices]: /perf/best-practices
[Use a native debugger]: /testing/native-debugging

[Android Studio/IntelliJ]: /tools/android-studio#run-app-with-breakpoints
[VS Code]: /tools/vs-code#run-app-with-breakpoints
[DevTools]: /tools/devtools
[Flutter inspector]: /tools/devtools/inspector
