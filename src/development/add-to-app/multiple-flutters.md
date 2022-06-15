---
title: Multiple Flutter screens or views
short-title: Adding multiple Flutters
description: How to integrate multiple instances of Flutter engine, screens or views to your application.
---



## Scenarios


If you're integrating Flutter into an existing app, or gradually migrating an
existing app to use Flutter, you may find yourself wanting to add multiple
Flutter instances to the same project. In particular, this can be useful in the
following scenarios:

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
[docs.flutter.dev/go/multiple-flutters][].

Flutter 2 and above are optimized for this scenario, with a low incremental
memory cost (~180kB) for adding additional Flutter instances. This fixed cost
reduction allows the multiple Flutter instance pattern to be used more liberally
in your add-to-app integration.

{{site.alert.warning}}
  Memory usage is only fully optimized in AOT mode (in profile and release
  builds). Some memory redundancy will still be present in JIT mode (in debug
  builds). This is tracked in [issue 74520][].
{{site.alert.end}}

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

* When all `FlutterEngine`s from a `FlutterEngineGroup` are destroyed, the next
  `FlutterEngine` created has the same performance characteristics as the very
  first engine.

* The `FlutterEngineGroup` itself doesn't need to live beyond all of the spawned
  engines. Destroying the `FlutterEngineGroup` doesn't affect existing spawned
  `FlutterEngine`s but does remove the ability to spawn additional
  `FlutterEngine`s that share resources with existing spawned engines.

## Communication

Communication between Flutter instances is handled using [platform channels][]
(or [Pigeon][]) through the host platform. To see our roadmap on communication,
or other planned work on enhancing multiple Flutter instances, see 
[Issue 72009][].

## Samples

You can find a sample demonstrating how to use `FlutterEngineGroup`
on both Android and iOS on [GitHub][].

{% include docs/app-figure.md image="development/add-to-app/multiple-flutters-sample.gif" alt="A sample demonstrating multiple-Flutters" %}

[GitHub]: {{site.repo.samples}}/tree/main/add_to_app/multiple_flutters
[`FlutterActivity`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html
[`FlutterViewController`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html
[performance characteristics]: {{site.url}}/development/add-to-app/performance
[docs.flutter.dev/go/multiple-flutters]: {{site.url}}/go/multiple-flutters
[Issue 72009]: {{site.repo.flutter}}/issues/72009
[Pigeon]: {{site.pub}}/packages/pigeon
[platform channels]: {{site.url}}/development/platform-integration/platform-channels
[Android API]: https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/embedding/engine/FlutterEngineGroup.java
[iOS API]: https://cs.opensource.google/flutter/engine/+/master:shell/platform/darwin/ios/framework/Headers/FlutterEngineGroup.h
[issue 74520]: https://github.com/flutter/flutter/issues/74520
