---
title: Multiple Flutter screens or views
short-title: Adding multiple Flutters
description: How to integrate multiple instances of Flutter engine, screens or views to your application.
---

## Experimental

{{site.alert.note}}
  Support for adding multiple instances of Flutter became available
  as of Flutter 1.26. Use at your own risk since stability or
  performance issues, and API changes are still possible.
{{site.alert.end}}

The current memory footprint for each additional Flutter instance beyond the
first instance is ~180kB on Android and iOS.

For the 1.26 release, communication between Flutter instances is done using
[platform channels](https://flutter.dev/docs/development/platform-integration/platform-channels)
(or [Pigeon](https://pub.dev/packages/pigeon)) via the host platform. To see
our roadmap on communication or other multiple-Flutters issues, see [flutter/flutter#72009](https://github.com/flutter/flutter/issues/72009).

## Scenarios

Before Flutter 1.26, multiple instances of `FlutterEngine` and its associated
UI could be launched, but each instance came with significant latency
and fixed memory cost.

Multiple Flutter instances can be useful in the following scenarios:

- An application where the integrated Flutter screen is not a leaf node of
  the navigation graph. And the navigation stack could be a hybrid mixture of
  native -> Flutter -> native -> Flutter.
- A screen where multiple partial screen Flutter views could be integrated
  and visible at once.

The advantage of using multiple Flutter instances is that each
instance is independent and maintains its own internal navigation
stack, UI, and application states. This simplifies the overall application code's
responsibility for state keeping and improves modularity. More details on the
scenarios motivating the usage of multiple Flutters can be found at
[flutter.dev/go/multiple-flutters][].

[flutter.dev/go/multiple-flutters]: /go/multiple-flutters

The 1.26 Flutter release drastically reduces the memory footprint of additional
Flutter engines from **~19MB** on Android and **~13MB** on iOS, to **~180kB** on Android and
iOS. This ~99% fixed cost reduction allows the multiple Flutters pattern to be
used more liberally in your add-to-app integration.

## Components

The primary API for using multiple Flutters on both Android and iOS is based
on using a new `FlutterEngineGroup` class
[[Android](https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/embedding/engine/FlutterEngineGroup.java)/[iOS](https://cs.opensource.google/flutter/engine/+/master:shell/platform/darwin/ios/framework/Headers/FlutterEngineGroup.h)]
to construct `FlutterEngines` instead of using the standard `FlutterEngine`
constructors like before.

Whereas the `FlutterEngine` API was more direct and easier to consume, the
`FlutterEngines` spawned from the same `FlutterEngineGroup` has the performance
advantage of sharing many of the common, reusable resources among themselves
such as the GPU context, font metrics data etc, leading to a faster initial
rendering latency and lower memory footprint.

*`FlutterEngine`s spawned from `FlutterEngineGroup` can be used to
   connect to UI classes like [`FlutterActivity`][] or [`FlutterViewController`][]
   in the same way as normally constructed cached `FlutterEngine`s.

[`FlutterActivity`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html
[`FlutterViewController`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html

* The first `FlutterEngine` spawned from the `FlutterEngineGroup` doesn't need
  to continue surviving in order for subsequent `FlutterEngine`s to share
  resources as long as there's at least 1 living `FlutterEngine` at all
  times.

* Creating the very first `FlutterEngine` from a `FlutterEngineGroup` has
  the same [performance characteristics][] as constructing a
  `FlutterEngine` using the constructors did previously.
  
[performance characteristics]: /docs/development/add-to-app/performance

* When all `FlutterEngine`s from a `FlutterEngineGroup` are destroyed,
the next `FlutterEngine` created has the same performance
characteristics as the very first engine.

* The `FlutterEngineGroup` itself doesn't need to live beyond all of the spawned
engines. Destroying the `FlutterEngineGroup` doesn't affect existing spawned
`FlutterEngine`s but does remove the ability to spawn additional
`FlutterEngine`s that share resources with existing spawned engines.

## Samples

You can find a sample demonstrating how to use `FlutterEngineGroup`
on both Android and iOS on[GitHub][]. 

[GitHub]: {{site.github}}/flutter/samples/tree/master/add_to_app/multiple_flutters

{% include app-figure.md image="development/add-to-app/multiple-flutters-sample.gif" alt="A sample demonstrating multiple-Flutters" %}
