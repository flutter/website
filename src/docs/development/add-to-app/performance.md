---
title: Load sequence, performance and memory
---

This page serves to inform the reader of the breakdown of the steps involved
to show a Flutter UI. Knowing this, the user can make better informed decisions
about when to pre-warm the Flutter engine, which operations are possible
at which stage and the latency and memory costs of those operations.

## Loading Flutter

Android and iOS apps (the two supported platforms for integrating into existing
apps), full Flutter apps, and add-to-app patterns have a similar sequence of
conceptual loading steps when displaying Flutter UI.

### Finding the Flutter resources

Flutter's engine runtime and your application's compiled Dart code are both
bundled as shared libraries on Android and iOS. The first step of loading
Flutter is to find those resources in your .apk/.ipa/.app etc. (along with
other Flutter assets such as images, fonts, JIT code if applicable).

This happens when you construct a FlutterEngine for the first time on both
**[Android]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)**
and **[iOS]({{site.api}}/objcdoc/Classes/FlutterEngine.html)** APIs.

### Loading the Flutter library

Once found, the engine's shared libraries are memory loaded once per process.

On **Android**, this happens also when the [`FlutterEngine`]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)
is constructed since the JNI connectors need to reference the Flutter C++
library. On **iOS**, this happens when the [`FlutterEngine`]({{site.api}}/objcdoc/Classes/FlutterEngine.html)
is first run, such as by running [`runWithEntrypoint:`]({{site.api}}/objcdoc/Classes/FlutterEngine.html#/c:objc(cs)FlutterEngine(im)runWithEntrypoint:).

### Starting the Dart VM

The Dart runtime is responsible for managing Dart memory and concurrency for
your Dart code. In JIT mode, it's additionally responsible for compiling
the Dart source code into machine code during runtime.

A single Dart runtime exists per application session on Android and iOS.

A one-time Dart VM start is done when constructing the [`FlutterEngine`]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)
for the first time on **Android** and when [running a Dart entrypoint]({{site.api}}/objcdoc/Classes/FlutterEngine.html#/c:objc(cs)FlutterEngine(im)runWithEntrypoint:)
for the first time on **iOS**.

At this point, your Dart code's [snapshot](https://github.com/dart-lang/sdk/wiki/Snapshots)
is also loaded into memory from your application's files.

This is a generic process that would also occur if you used the [Dart SDK](https://dart.dev/tools/sdk)
directly without the Flutter engine.

The Dart VM never shuts down once started.

### Creating and running a Dart Isolate

Once the Dart runtime is initialized, the Flutter engine's usage of the Dart
runtime is the next step.

This is done by starting a [Dart Isolate](https://api.dartlang.org/stable/dart-isolate/Isolate-class.html)
in the Dart runtime. The isolate is Dart's container for memory and thread. A
number of [auxiliary threads](https://github.com/flutter/flutter/wiki/The-Engine-architecture#threading)
on the host platform are also created at this point to support the isolate, such
as a thread for offloading GPU handling and another for image decoding.

One isolate exists per `FlutterEngine` instance and multiple isolates
can be hosted by the same Dart VM.

On **Android**, this happens when you call [`DartExecutor.executeDartEntrypoint()`]({{site.api}}/javadoc/io/flutter/embedding/engine/dart/DartExecutor.html#executeDartEntrypoint-io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint-)
on a `FlutterEngine` instance.

On **iOS**, this happens when you call [`runWithEntrypoint:`]({{site.api}}/objcdoc/Classes/FlutterEngine.html#/c:objc(cs)FlutterEngine(im)runWithEntrypoint:)
on a `FlutterEngine`.

At this point, your Dart code's selected entrypoint (the `main()` function of
your Dart library's main.dart file by default) is executed. If you called the
Flutter function [runApp()]({{site.api}}/flutter/widgets/runApp.html) in your
`main()` function, your Flutter app or library's widget tree are also created
and built. If you need to prevent certain functionalities from executing
in your Flutter code, the `AppLifecycleState.detached` enum value indicates
that the `FlutterEngine` is not yet attached to any UI components such as a
`FlutterViewController` on iOS or a `FlutterActivity` on Android.

### Attaching UI to the Flutter Engine

A standard full-Flutter app moves to reach this state as soon as the app is
launched.

In an add-to-app scenario, this happens when you attach a `FlutterEngine`
to a UI component such as by calling [`startActivity()`](https://developer.android.com/reference/android/content/Context.html#startActivity(android.content.Intent))
with an [`Intent`](https://developer.android.com/reference/android/content/Intent.html)
built using [`FlutterActivity.withCachedEngine()`]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html#withCachedEngine-java.lang.String-)
on **Android**. Or by presenting a [`FlutterViewController`]({{site.api}}/objcdoc/Classes/FlutterViewController.html)
initialized by using [`initWithEngine: nibName: bundle:`]({{site.api}}/objcdoc/Classes/FlutterViewController.html#/c:objc(cs)FlutterViewController(im)initWithEngine:nibName:bundle:)
on **iOS**.

This would also the case if a Flutter UI component was launched without
pre-warming a `FlutterEngine` such as with [`FlutterActivity.createDefaultIntent()`]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html#createDefaultIntent-android.content.Context-)
on **Android** or with [`FlutterViewController initWithProject: nibName: bundle:`]({{site.api}}/objcdoc/Classes/FlutterViewController.html#/c:objc(cs)FlutterViewController(im)initWithProject:nibName:bundle:)
on **iOS**. An implicit `FlutterEngine` is created in these cases.

Behind the scene, both platform's UI components serve to provide the
`FlutterEngine` with a rendering surface such as a [Surface](https://developer.android.com/reference/android/view/Surface)
on **Android** or a [CAEAGLLayer](https://developer.apple.com/documentation/quartzcore/caeagllayer)
or [CAMetalLayer](https://developer.apple.com/documentation/quartzcore/cametallayer)
on **iOS**.

At this point, the [Layer]({{site.api}}/flutter/rendering/Layer-class.html)
tree generated by your Flutter program per frame is converted into
OpenGL (or Vulkan or Metal) GPU instructions.

## Memory and latency

Showing a Flutter UI has non-trivial latency cost. This cost can be alleviated
by starting the Flutter engine ahead of time.

The most relevant choice for users in add-to-app scenarios is to decide
when to pre-load a `FlutterEngine` (that is, to load the Flutter library,
start the Dart VM, and run entrypoint in an isolate) and the memory and latency
cost of that pre-warm. Also, how it affects the memory and latency cost of
rendering a first Flutter frame when the UI component is subsequently attached
to that `FlutterEngine`.

As of Flutter v1.10.3, and testing on a low-end 2015 class device in release-AOT
mode, pre-warming the `FlutterEngine` costs:

- 42MB and 1530ms to prewarm on **Android**. 330ms of it is a blocking call on
the main thread.
- 22MB and 860ms to prewarm on **iOS**. 260ms of it is a blocking call on the
main thread.

A Flutter UI can be attached during the pre-warm. The remaining time would be
joined to the time-to-first-frame latency.

Memory-wise, a cost sample (variable depending on use case) could be:

- ~4MB OS's memory usage for creating pthreads.
- ~10MB GPU driver memory.
- ~1MB for Dart runtime-managed memory.
- ~5MB for Dart-loaded font maps.

Latency-wise, a cost sample (variable depending on use case) could be:

- ~20ms to collect the Flutter assets from the application package.
- ~15ms to dlopen the Flutter engine library.
- ~200ms to create the Dart VM, load the AOT snapshot.
- ~200ms to load Flutter dependent fonts and assets.
- ~400ms to run the entrypoint, create the first widget tree, compile the needed
GPU shader programs.

The `FlutterEngine` should be pre-warmed late enough such as to delay the
memory consumption needed but also early enough to avoid joining the
Flutter engine start-up time into the first frame latency of showing Flutter.

The exact timing depends on the app's structure and heuristic. An example would
be to load the Flutter engine in the screen before the screen drawn by Flutter.

Given an engine pre-warm, the first frame cost on UI attach is:

- 320ms on **Android** and an additional 12MB (highly dependent on screen
physical pixel size).
- 200ms on **iOS** and an additional 16MB (highly dependent on screen physical
pixel size).

Memory-wise, the cost is primarily the graphical memory buffer used for
rendering and dependent on the screen size.

Latency-wise, the cost is primarily waiting for the OS callback to provide
Flutter with a rendering surface, and compiling the remaining shader programs
that are not pre-emptively predictable. This is a one-time cost.

When the Flutter UI component is released, the UI related memory is freed.
This doesn't affect the Flutter state, which lives in the `FlutterEngine`
(unless the `FlutterEngine` is also released).
