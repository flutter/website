---
title: JNIgen
description: >-
  Learn how to use JNIgen to generate type-safe Dart bindings
  for Java and Kotlin APIs.
---

## Overview

JNIgen (Java Native Interface generator) is a code generator tool
that creates type-safe Dart bindings for Java and Kotlin libraries and APIs.
With JNIgen, you can call Android APIs, JARs, and AARs directly
and synchronously from your Dart code.

## When to use JNIgen

Use JNIgen when you need to call Java or Kotlin libraries directly from Dart,
wrap compiled JAR or AAR files,
or build a standalone Dart package that interacts with the JVM.

Because JNIgen calls into the JVM directly through `dart:ffi`,
it's also suited for high-performance, low-latency interop
or passing large volumes of raw data between Dart and the JVM.

For standard Android plugin development where you don't need direct access
to raw JNI references, use [Pigeon](/platform-integration/interop/pigeon)
with native interop (`useJni: true`) instead.

## Developer flow

Generating bindings with JNIgen follows four steps:

1.  Reference the native classes, JARs, or AARs.
1.  Write the JNIgen configuration script.
1.  Generate the bindings by running the configuration script.
1.  Call the generated code from Dart.

To start, identify the Java or Kotlin classes, packages,
or compiled JAR and AAR files that you want to wrap.
Then create a configuration script in `tool/jnigen.dart`
(some older projects use a legacy `jnigen.yaml` file).
This script specifies where the native files are located,
which classes or packages to include,
and where to output the generated Dart bindings.
For a complete list of configuration options,
consult the [`package:jnigen` documentation on pub.dev][jnigen-pub].

Next, run the configuration script (`dart run tool/jnigen.dart`,
or `dart run jnigen --config jnigen.yaml` if your project uses `jnigen.yaml`),
which parses the classes and generates the corresponding Dart bindings.

Finally, import the generated Dart file into your app or package
and call the methods directly.
Because JNIgen communicates directly through the underlying FFI layer,
consult the [`dart:ffi` guide](/platform-integration/interop/dart-ffi)
to learn how to manage native memory lifetimes
and run blocking native calls without freezing the UI thread.

:::note
When the native API changes, update your configuration script
and regenerate the bindings.
:::

## Examples

To explore complete implementations of this workflow,
including how to configure the generator,
refer to the [`permissions_plugin` demo][permissions-demo]
and the [`android_toast_demo`][toast-demo]
in the Flutter native interop demos repository.

## Constraints and limitations

Keep the following considerations and limitations in mind
when working with JNIgen:

### Threading considerations

JNIgen calls execute synchronously on the calling thread.
Watch out for two common scenarios:

- **Platform thread APIs.**
  To call Android APIs that must run on the platform main thread,
  use `runOnPlatformThread` from `dart:ui`.
- **Cross-thread callbacks.**
  Dart callbacks invoked from Java or Kotlin run on the Dart isolate
  that created them.
  Avoid blocking a Java thread while waiting for a Dart isolate that is itself
  blocked waiting on that Java thread, which causes a deadlock.

### Lifecycle of Java objects

JNI wrappers hold Java global references,
which have an Android runtime limit of approximately 50,000 active references.
Call `.release()` or scope objects inside `.using()` blocks
to free references promptly and prevent memory leaks.
When implementing Java interfaces in Dart, use `WeakReference`
to avoid reference cycles between the Dart and JVM garbage collectors.

### JVM runtime type checks

JNI wrappers are Dart extension types that compile to `JObject` at runtime.
Because of this, Dart's `is` and `as` keywords don't check
the Java runtime type.
Use `x.isA(Foo.type)` and `x.as(Foo.type)` instead.

### Debugging reference errors

To trace JNI reference lifecycle bugs such as `DoubleReleaseError`
and `UseAfterReleaseError`,
set `Jni.captureStackTraceOnRelease = true` to capture allocation and release
stack traces.

## Resources

To learn about generating Java and Kotlin bindings,
consult the following resources:

- [`package:jnigen` on pub.dev][jnigen-pub]
- [`package:jni` on pub.dev][jni-pub]
- [Official JNIgen examples on GitHub][jnigen-examples]

[jnigen-pub]: {{site.pub-pkg}}/jnigen
[jni-pub]: {{site.pub-pkg}}/jni
[jnigen-examples]: https://github.com/dart-lang/native/tree/main/pkgs/jnigen/example
[permissions-demo]: {{site.repo.demos}}/tree/main/native_interop_demos/permissions_plugin
[toast-demo]: {{site.repo.demos}}/tree/main/native_interop_demos/android_toast_demo
