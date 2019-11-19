---
title: Debugging Flutter apps
description: How to debug your app using the DevTools suite.
---

There are a wide variety of tools and features to help debug
Flutter applications. Here are some of the available tools:

* [DevTools][], a suite of performance and profiling
  tools that run in a browser.
* [Android Studio/IntelliJ][], and [VS Code][]
  (enabled with the Flutter and Dart plugins)
  support a built-in source-level debugger with
  the ability to set breakpoints, step through code,
  and examine values.
* [Flutter inspector][], a widget inspector available
  in DevTools, and also directly from Android Studio
  and IntelliJ (enabled with the Flutter plugin).
  The inspector allows you to examine a visual
  representation of the widget tree, inspect
  individual widgets and their property values,
  enable the performance overlay, and more.

## DevTools

For debugging and profiling apps, DevTools might be
the first tool you reach for. DevTools runs in a
browser and supports a variety of features:

* source-level debugger
* widget inspector that displays a visual widget tree,
  and "widget select" mode where you select a widget
  in the app and it drills down to that widget in
  the tree
* memory profiler
* timeline view that supports tracing, and importing
  and exporting trace information
* logging view

If you run your application in [debug mode][] or
[profile mode][], while it's running you can open
DevTools in the browser to connect to your app.
DevTools doesn't work well with an app compiled to
[release mode][], as the debugging and profiling
information has been stripped away.

If you use DevTools for profiling, make sure to
run your application in [profile mode][]. Otherwise,
the main output that appears on your profile are the
debug asserts verifying the framework's various invariants
(see [Debug mode assertions](#debug-mode-assertions)).

![GIF showing DevTools features]({% asset tools/devtools/inspector.gif @path %}){:width="100%"}

For more information, see the
[DevTools][] documentation.

## Setting breakpoints

You can set breakpoints directly in your IDE/editor
(such as [Android Studio/IntelliJ][] and [VS Code][]),
in the [DevTools debugger][],
or [programmatically][breakpoints].

## The Dart analyzer

If you're using a [Flutter enabled IDE/editor][],
the Dart analyzer is already checking your code
and looking for possible mistakes.

If you run from the command line,
test your code with `flutter analyze`.

The Dart analyzer makes heavy use of type annotations that
you put in your code to help track problems down.
You are encouraged to use them everywhere (avoiding `var`,
untyped arguments, untyped list literals, and so on)
as this is the quickest and least painful way of tracking
down problems.

For more information, see [Using the Dart analyzer][].

## Logging

Another useful debugging tool is logging.
You set logging up [programmatically][logging]
then view the output in the DevTools
[logging view][], or in the console.

## Debugging application layers

Flutter was designed with a layered architecture that includes
widget, rendering, and painting layers. For links to more
information and videos, see [The Framework architecture][] on the
[GitHub wiki][], and the community article, [The Layer Cake][].

The Flutter widget inspector provides a visual representation
of the widget tree, but if you want a greater level of detail,
or you want a verbose text-based dump of the widget,
layer, or render trees, see
[Debug flags: application layers][]
in the [Debugging Flutter apps programatically][] page.

## Debug mode assertions

During development, you are highly encouraged to use Flutter's
[debug mode][]. This is the default if you use bug icon in
Android Studio, or `flutter run` at the command line.
Some tools support assert statements through the
command-line flag `--enable-asserts`.

In this mode, Dart assert statements are enabled,
and the Flutter framework evaluates the argument
to each assert statement encountered during execution,
throwing an exception if the result is false.
This allows developers to enable or disable invariant
checking, such that the associated performance cost
is only paid during debugging sessions.

When an invariant is violated, it's reported to the
console, with some context information to help track
down the source of the problem.

For more information, see [Assert][] in the
[Dart language tour][].

## Debugging animations

The easiest way to debug animations is to slow them down.
The [Flutter inspector][] provides a **Slow Animations** button,
or you can [slow the animations programmatically][].

For more information on debugging janky (non-smooth)
applications, see [Flutter performance profiling][].

## Measuring app startup time

To gather detailed information about the time it takes for your
Flutter app to start, you can run the `flutter run` command
with the `trace-startup` and `profile` options.

```
$ flutter run --trace-startup --profile
```

The trace output is saved as a JSON file called `start_up_info.json`
under the `build` directory of your Flutter project.
The output lists the elapsed time from app startup to these trace
events (captured in microseconds):

+ Time to enter the Flutter engine code.
+ Time to render the first frame of the app.
+ Time to initialize the Flutter framework.
+ Time to complete the Flutter framework initialization.

For example:

```
{
  "engineEnterTimestampMicros": 96025565262,
  "timeToFirstFrameMicros": 2171978,
  "timeToFrameworkInitMicros": 514585,
  "timeAfterFrameworkInitMicros": 1657393
}
```

## Tracing Dart code

To perform a performance trace,
you can use the DevTools [Timeline view][].
The Timeline view also supports importing
and exporting trace files. For more
information, see the [Timeline view][] docs.

You can also
[perform traces programmatically][],
though these traces can't be imported
into DevTool's Timeline view.

Be sure to use run your app in [profile mode][]
before tracing to ensure that the runtime performance
characteristics closely matches that of your final product.

## Performance overlay

To get a graphical view of the performance of your application,
turn on the performance overlay. You can do this in the
by clicking the **Performance Overlay** button in the
[Flutter inspector][].

You can also turn on the overlay [programmatically][overlay].

For information on how to interpret the graphs in the overlay,
see [The performance overlay][] in
the [Flutter performance profiling][] guide.

## Debug flags

In most cases, you won't need to use the debug flags
directly, as you'll find the most useful debugging
functionality in the [DevTools][] suite. But if you
prefer to use the debug flags directly, see
[Debug flags: performance][] in the
[Debugging Flutter apps programmatically][] page.

## Common problems

The following is a problem that some have encountered on MacOS.

### "Too many open files" exception (MacOS)

The default limit for Mac OS on how many files it can have open at a
time is rather low.  If you run into this limit,
increase the number of available
file handlers using the `ulimit` command:

```
ulimit -S -n 2048
```

If you use Travis or Cirrus for testing, increase the number of
available file handlers that they can open by adding the same line to
flutter/.travis.yml, or flutter/.cirrus.yml, respectively.

## Other resources

You might find the following docs useful:

* [Performance best practices][]
* [Flutter performance profiling][]
* [Using an OEM debugger][]
* [Flutter's modes][]
* [Debugging Flutter apps programatically][]
* [DevTools][]
* [Android Studio/IntelliJ][]
* [VS Code][]


[Flutter enabled IDE/editor]: /docs/get-started/editor

[Debugging Flutter apps programatically]: /docs/testing/code-debugging
[perform traces programmatically]: /docs/testing/code-debugging#tracing-dart-code-performance
[Debug flags: application layers]: /docs/testing/code-debugging#debug-flags-application-layers
[Debug flags: performance]: /docs/testing/code-debugging#debug-flags-performance
[slow the animations programmatically]: /docs/testing/code-debugging#debugging-animations
[breakpoints]: /docs/testing/code-debugging#setting-breakpoints
[logging]: /docs/testing/code-debugging#logging
[Flutter's modes]: /docs/testing/build-modes
[Flutter performance profiling]: /docs/perf/rendering/ui-performance
[Performance best practices]: /docs/perf/rendering/best-practices
[Using an OEM debugger]: /docs/testing/oem-debuggers

[The Layer Cake]: https://medium.com/flutter-community/the-layer-cake-widgets-elements-renderobjects-7644c3142401

[GitHub wiki]: {{site.github}}/flutter/flutter/wiki/
[Using the Dart analyzer]: {{site.github}}/flutter/flutter/wiki/Using-the-Dart-analyzer
[The Framework architecture]: {{site.github}}/flutter/flutter/wiki/The-Framework-architecture

[Android Studio/IntelliJ]: /docs/development/tools/android-studio#run-app-with-breakpoints
[VS Code]: /docs/development/tools/vs-code#run-app-with-breakpoints
[DevTools]: /docs/development/tools/devtools
[Flutter inspector]: /docs/development/tools/devtools/inspector
[DevTools debugger]: /docs/development/tools/devtools/debugger
[logging view]: /docs/development/tools/devtools/logging
[Timeline view]: /docs/development/tools/devtools/timeline
[The performance overlay]: /docs/perf/rendering/ui-performance#the-performance-overlay
[Flutter performance profiling]: /docs/perf/rendering/ui-performance
[overlay]: /docs/testing/code-debugging#performance-overlay
[debug mode]: /docs/testing/build-modes#debug
[profile mode]: /docs/testing/build-modes#profile
[release mode]: /docs/testing/build-modes#release

[Assert]: {{site.dart-site}}/guides/language/language-tour#assert
[Dart language tour]: {{site.dart-site}}/guides/language/language-tour
