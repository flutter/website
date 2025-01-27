---
title: Flutter's build modes
description: Describes Flutter's build modes and when you should use debug, release, or profile mode.
---

The Flutter tooling supports three modes when compiling your app,
and a headless mode for testing.
You choose a compilation mode depending on where you are in
the development cycle. Are you debugging your code? Do you
need profiling information? Are you ready to deploy your app?

A quick summary for when to use which mode is as follows:

* Use [debug](#debug) mode during development,
  when you want to use [hot reload][].
* Use [profile](#profile) mode when you want to analyze
  performance.
* Use [release](#release) mode when you are ready to release
  your app.

The rest of the page details these modes.

* To learn about the headless testing mode,
  refer to the engine wiki's docs on [Flutter's build modes][].
* To learn how to detect the build mode, check out the
  [Check for Debug/Release Mode in Flutter Apps] blog post.

[Check for Debug/Release Mode in Flutter Apps]: https://retroportalstudio.medium.com/check-for-debug-release-mode-in-flutter-apps-d8d545f20da3

## Debug

In _debug mode_, the app is set up for debugging on the physical
device, emulator, or simulator.

Debug mode for mobile apps mean that:

* [Assertions][] are enabled.
* Service extensions are enabled.
* Compilation is optimized for fast development and run cycles
  (but not for execution speed, binary size, or deployment).
* Debugging is enabled, and tools supporting source level debugging
  (such as [DevTools][]) can connect to the process.

Debug mode for a web app means that:

* The build is _not_ minified and tree shaking has _not_ been
  performed.
* The app is compiled with the [dartdevc][] compiler for
  easier debugging.

By default, `flutter run` compiles to debug mode.
Your IDE supports this mode. Android Studio,
for example, provides a **Run > Debug...** menu option,
as well as a green bug icon overlaid with a small triangle
on the project page.

:::note
* Hot reload works _only_ in debug mode.
* The emulator and simulator execute _only_ in debug mode.
* Application performance can be janky in debug mode.
  Measure performance in [profile](#profile)
  mode on an actual device.
:::

## Release

Use _release mode_ for deploying the app, when you want maximum
optimization and minimal footprint size. For mobile, release mode
(which is not supported on the simulator or emulator), means that:

* Assertions are disabled.
* Debugging information is stripped out.
* Debugging is disabled.
* Compilation is optimized for fast startup, fast execution,
  and small package sizes.
* Service extensions are disabled.

Release mode for a web app means that:

* The build is minified and tree shaking has been performed.
* The app is compiled with the [dart2js][] compiler for
  best performance.

The command `flutter run --release` compiles to release mode.
Your IDE supports this mode. Android Studio, for example,
provides a **Run > Run...** menu option, as well as a triangular
green run button icon on the project page.
You can compile to release mode for a specific target
with `flutter build <target>`. For a list of supported targets,
use `flutter help build`.

For more information, see the docs on releasing
[iOS][] and [Android][] apps.

## Profile

In _profile mode_, some debugging ability is maintained&mdash;enough
to profile your app's performance. Profile mode is disabled on
the emulator and simulator, because their behavior is not representative
of real performance. On mobile, profile mode is similar to release mode,
with the following differences:

* Some service extensions, such as the one that enables the performance
  overlay, are enabled.
* Tracing is enabled, and tools supporting source-level debugging
  (such as [DevTools][]) can connect to the process.

Profile mode for a web app means that:

* The build is _not_ minified but tree shaking has been performed.
* The app is compiled with the [dart2js][] compiler.
* DevTools can't connect to a Flutter web app running
  in profile mode. Use Chrome DevTools to
  [generate timeline events][] for a web app.

Your IDE supports this mode. Android Studio, for example,
provides a **Run > Profile...** menu option.
The command `flutter run --profile` compiles to profile mode.

:::note
Use the [DevTools][] suite to profile your app's performance.
:::

For more information on the build modes, see
[Flutter's build modes][].


[Android]: /deployment/android
[Assertions]: {{site.dart-site}}/language/error-handling#assert
[dart2js]: {{site.dart-site}}/tools/dart2js
[dartdevc]: {{site.dart-site}}/tools/dartdevc
[DevTools]: /tools/devtools
[Flutter's build modes]: {{site.repo.flutter}}/blob/main/engine/src/flutter/docs/Flutter's-modes.md
[generate timeline events]: {{site.developers}}/web/tools/chrome-devtools/evaluate-performance/performance-reference
[hot reload]: /tools/hot-reload
[iOS]: /deployment/ios
