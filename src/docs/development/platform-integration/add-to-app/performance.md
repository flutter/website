---
title: Load sequence, performance and memory
short-title: Load sequence, performance and memory
description: Behind the scenes on how Flutter loads inside your application, and
its performance and memory impacts.
---

This page serves to inform the reader of the breakdown of the steps involved
to show a Flutter UI. Knowing this, the user can make better informed decisions
about when to pre-warm the Flutter engine, which operations are possible
at which stage and the latency and memory costs of those operations.

## Loading Flutter

Both Android/iOS (the 2 supported platforms for integrating into existing
apps) and full-Flutter apps and add-to-app patterns have a similar sequence
of conceptual loading steps when showing Flutter UI.

### Finding the Flutter resources

Flutter's engine runtime and your application's compiled Dart code are both
bundled as shared libraries on Android and iOS. The first step of loading
Flutter is to find those resources in your .apk/.ipa/.app etc. (along with
other Flutter assets such as images, fonts, JIT code if applicable).

This happens when you construct a FlutterEngine for the first time on both
[Android]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)
and [iOS]({{site.api}}/objcdoc/Classes/FlutterEngine.html) APIs.

### Loading the Flutter library

Once found, the engine's shared libraries are memory loaded once per process.

On Android, this happens also when the [`FlutterEngine`]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)
is constructed since the JNI connectors need to reference the Flutter C++
library. On iOS, this happens when the [`FlutterEngine`]({{site.api}}/objcdoc/Classes/FlutterEngine.html)
is first run, such as via [`runWithEntrypoint:`](https://{{site.api}}/objcdoc/Classes/FlutterEngine.html#/c:objc(cs)FlutterEngine(im)runWithEntrypoint:).

### Starting the Dart VM

The Dart runtime is responsible for managing Dart memory, concurrency etc. for
your Dart code. In JIT mode, it's additionally responsible for compiling
the Dart source code into machine code during runtime.

A single Dart runtime exists per application session on Android and iOS.

A one-time Dart VM start is done when constructing the [`FlutterEngine`]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)
for the first time on Android and when [running a Dart entrypoint](https://{{site.api}}/objcdoc/Classes/FlutterEngine.html#/c:objc(cs)FlutterEngine(im)runWithEntrypoint:) for the first time on iOS.

At this point, your Dart code's [snapshot](https://github.com/dart-lang/sdk/wiki/Snapshots)
is also loaded into memory from your application's files.

This is a generic process that would also occur if you used the [Dart SDK](https://dart.dev/tools/sdk)
directly without the Flutter engine.

### Creating and running a Dart Isolate

Once the Dart runtime is initialized, the Flutter engine's usage of the Dart
runtime is the next step.

This is done by starting a Dart Isolate in the Dart runtime. The Isolate is
Dart's container for memory and thread. A number of [auxiliary threads](https://github.com/flutter/flutter/wiki/The-Engine-architecture#threading)
on the host platform is also created at this point to support the Dart Isolate,
such as offloading GPU handling and image decoding off of the Dart Isolate.


