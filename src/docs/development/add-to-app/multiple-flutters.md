---
title: Multiple Flutter screens or views
short-title: Adding multiple Flutters
description: How to integrate multiple instances of Flutter engine, screens or views to your application.
---

## Experimental

{{site.alert.note}}
  Support for adding multiple instances of Flutter became available
  as of Flutter 2.0.0. Use at your own risk since stability or
  performance issues, and API changes are still possible.
{{site.alert.end}}

The current memory footprint for each additional Flutter instance beyond the
first instance is ~180kB on Android and iOS.

As of the 2.0.0 release, communication between Flutter instances is handled using
[platform channels][] (or [Pigeon][]) through the host platform. To see
our roadmap on communication, or other multiple-Flutters issues, see [Issue 72009][].

{{site.alert.warning}}
  In 2.0.0, the use of [platform views][] is not supported in conjunction with
  multiple Flutters. When a second Flutter instance is created, platform views
  will be globally disabled.
{{site.alert.end}}

{{site.alert.warning}}
  In 2.0.0, the memory usage is only fully optimized in AOT mode (in profile
  and release builds). Some memory redundancy will still be present in JIT mode
  (in debug builds) and will be addressed in a future release.
{{site.alert.end}}

## Scenarios

Before Flutter 2.0.0, multiple instances of `FlutterEngine` and its associated
UI could be launched, but each instance came with significant latency
and fixed memory cost.

Multiple Flutter instances can be useful in the following scenarios:

* An application where the integrated Flutter screen is not a leaf node of
  the navigation graph, and the navigation stack might be a hybrid mixture of
  native -> Flutter -> native -> Flutter.
* A screen where multiple partial screen Flutter views might be integrated
  and visible at once.

The advantage of using multiple Flutter instances is that each
instance is independent and maintains its own internal navigation
stack, UI, and application states. This simplifies the overall application code's
responsibility for state keeping and improves modularity. More details on the
scenarios motivating the usage of multiple Flutters can be found at
[flutter.dev/go/multiple-flutters][].

The 2.0.0 Flutter release drastically reduces the memory footprint of additional
Flutter engines from **~19MB** on Android and **~13MB** on iOS, to **~180kB** on Android and
iOS. This ~99% fixed cost reduction allows the multiple Flutters pattern to be
used more liberally in your add-to-app integration.

## Components

The primary API for adding multiple Flutter instances on both Android and iOS
is based on a new `FlutterEngineGroup` class ([Android API][], [iOS API][])
to construct `FlutterEngine`s, rather than the `FlutterEngine`
constructors used previously.

Whereas the `FlutterEngine` API was direct and easier to consume, the
`FlutterEngine` spawned from the same `FlutterEngineGroup` have the performance
advantage of sharing many of the common, reusable resources such as the GPU
context, font metrics, and isolate group snapshot, leading to a faster initial
rendering latency and lower memory footprint.

* `FlutterEngine`s spawned from `FlutterEngineGroup` can be used to
   connect to UI classes like [`FlutterActivity`][] or [`FlutterViewController`][]
   in the same way as normally constructed cached `FlutterEngine`s.

* The first `FlutterEngine` spawned from the `FlutterEngineGroup` doesn't need
  to continue surviving in order for subsequent `FlutterEngine`s to share
  resources as long as there's at least 1 living `FlutterEngine` at all
  times.

* Creating the very first `FlutterEngine` from a `FlutterEngineGroup` has
  the same [performance characteristics][] as constructing a
  `FlutterEngine` using the constructors did previously.

* When all `FlutterEngine`s from a `FlutterEngineGroup` are destroyed,
the next `FlutterEngine` created has the same performance
characteristics as the very first engine.

* The `FlutterEngineGroup` itself doesn't need to live beyond all of the spawned
engines. Destroying the `FlutterEngineGroup` doesn't affect existing spawned
`FlutterEngine`s but does remove the ability to spawn additional
`FlutterEngine`s that share resources with existing spawned engines.

## Samples

You can find a sample demonstrating how to use `FlutterEngineGroup`
on both Android and iOS on [GitHub][].


{% include app-figure.md image="development/add-to-app/multiple-flutters-sample.gif" alt="A sample demonstrating multiple-Flutters" %}

[GitHub]: {{site.github}}/flutter/samples/tree/master/add_to_app/multiple_flutters
[`FlutterActivity`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html
[`FlutterViewController`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html
[performance characteristics]: /docs/development/add-to-app/performance
[flutter.dev/go/multiple-flutters]: /go/multiple-flutters
[Issue 72009]: {{site.github}}/flutter/flutter/issues/72009
[Pigeon]: {{site.pub}}/packages/pigeon
[platform channels]: /docs/development/platform-integration/platform-channels
[platform views]: /docs/development/platform-integration/platform-views
[Android API]: https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/embedding/engine/FlutterEngineGroup.java
[iOS API]: https://cs.opensource.google/flutter/engine/+/master:shell/platform/darwin/ios/framework/Headers/FlutterEngineGroup.h
