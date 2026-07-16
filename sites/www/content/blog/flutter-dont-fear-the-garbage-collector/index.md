---
title: "Flutter: Don’t Fear the Garbage Collector"
description: "Flutter uses Dart as a development language and as a runtime. Dart’s runtime is ever-present, both in debug and release modes, but there…"
publishDate: 2019-01-04
author: mjohnsullivan
image: images/1oVVba1QhXL1hUBKE9sfenw.webp
category: engineering
layout: blog
---

Flutter uses [Dart](https://www.dartlang.org/) as a development language and as a runtime. Dart’s runtime is ever-present, both in debug and release modes, but there are big differences between the two build flavors.

In debug mode, most of Dart’s plumbing is shipped to the device: the Dart runtime, the just-in-time compiler/interpreter (JIT for Android and interpreter for iOS), debugging and profiling services. In release mode, the JIT/interpreter and debugging services are stripped out, but the runtime remains, and this is a major contributor to the base size of a Flutter app.

<DashImage figure src="images/1oVVba1QhXL1hUBKE9sfenw.webp" alt="*Dart components in Flutter’s debug and release modes*" caption="*Dart components in Flutter’s debug and release modes*" />


Dart’s runtime includes a garbage collector, a necessary component for allocating and deallocating memory as objects are instantiated and become unreachable.

And with Flutter, that can be *a lot* of objects. Stateless Widgets are created as they’re rendered on screen, destroyed and rebuilt when the app’s state changes or when they’re no longer visible, most with a short lifespan. For an app with a reasonably complex UI, that can run to thousands of widgets.

So should Flutter developers fear the garbage collector? With Flutter creating and destroying objects with great frequency, should developers take steps to limit this behavior? It’s not uncommon to see new Flutter developers create references to widgets they know will not change over time, and place them in state so that they won’t be destroyed and rebuilt.

Don’t do this.

Fearing Dart’s garbage collector is largely unfounded, due to its generational architecture and an implementation that is optimized for the rapid creation and destruction of objects. In most scenarios, you should let Flutter’s engine create and destroy all the widgets it likes.

## The Dart Garbage Collector

Dart’s garbage collector is [generational](https://en.wikipedia.org/wiki/Tracing_garbage_collection#Generational_GC_(ephemeral_GC)) and consists of two phases: the young space scavenger and parallel mark sweep collectors.

### Scheduling

To minimize the effects of garbage collection on app and UI performance, the garbage collector provides hooks to the Flutter engine that alerts it when the engine detects that the app is idle and there’s no user interaction. This gives the garbage collector windows of opportunity to run its collection phases without impacting performance.

The garbage collector can also run sliding compaction during those idle intervals, which minimizes memory overhead by reducing memory fragmentation.

### Young Space Scavenger

This phase is designed to clean up ephemeral objects that have a short lifespan, such as stateless widgets. While it is blocking, it is much faster than the second generation mark/sweep, and when combined with scheduling, virtually eliminates perceived pauses in the app when run.

In essence, objects are allocated to a contiguous space in memory, and as objects are created, they’re allocated the next available space, until the allocated memory is filled. Dart uses bump pointer allocation to rapidly allocate in new space, making the process very fast.

The new space (or nursery), where new objects are allocated, consists of two halves, known as semi spaces. Only one half is used at any time: one being active, the other inactive. New objects are allocated in the active half, and once that is filled, live objects are copied from active to inactive, ignoring dead objects. The inactive half then becomes active and the process repeats.

To determine which objects are alive or dead, the collector starts with root objects, such as stack variables, and examines what they reference. It then moves the referenced objects. From there it examines what these evacuated objects point to, and moves these referenced objects. This continues until all live objects are moved. Dead objects have no references and are thus left behind; live objects will be copied over them in a future garbage collection event.

For more information on this, check out [Cheney’s algorithm](https://en.wikipedia.org/wiki/Cheney%27s_algorithm).

<DashImage figure src="images/1pNaeZ0l8oMCP-f1UUs-V1g.webp" alt="*Young Space Scavenger garbage collection*" caption="*Young Space Scavenger garbage collection*" />


### Parallel Marking and Concurrent Sweeping

When objects achieve a certain lifespan, they are promoted to a new memory space, managed by the second generation collector: mark-sweep.

This garbage collection technique has two phases: the object graph is first traversed and objects that are still in use are marked. During the second phase the entire memory is scanned, and any objects not marked are recycled. All flags are then cleared.

This form of garbage collection blocks on the marking phase; no memory mutation can occur and the UI thread is blocked. This collection is more infrequent as short-lived objects are handled by the young scavenger, but there will be times when the Dart runtime needs to pause in order to run this form of garbage collection. Given Flutter’s ability to schedule collection, the impact of this should be minimized.

It should be noted that if an app doesn’t adhere to the *weak generational hypothesis* (which states that most objects die young), then this form of collection will occur more often. Given how Flutter’s widget implementation works, this is unlikely, but something to bear in mind.

## Isolates

It’s worth noting that Dart isolates have their own private heap, independent of one another. As each isolate runs in a separate thread, garbage collection events for each isolate should not impact the performance of others. Using [isolates](https://docs.flutter.io/flutter/foundation/compute.html) is a great way to avoid blocking the UI and offloading process intensive activities.

## Wrapping Up

And there you have it: Dart employs a powerful generational garbage collector to minimize the effects for blocking garbage collection in Flutter apps. Don’t fear the garbage collector; it’s got your app’s best interests at heart.