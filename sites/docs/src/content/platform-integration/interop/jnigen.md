---
title: JNIgen
description: >-
  Learn how to use JNIgen to generate type-safe Dart bindings
  for Java and Kotlin APIs.
---

## Overview

JNIgen (Java Native Interface generator) is a code generator tool that creates
type-safe Dart bindings for Java and Kotlin libraries and APIs.
This allows you to call Android APIs directly and synchronously from your
Dart code.

## When to use JNIgen

Use JNIgen when you need to call Java or Kotlin libraries, wrap compiled JAR
or AAR files, or interact directly with Android from your Dart code.

Because JNIgen uses direct JNI bindings through `dart:ffi`,
it is also the recommended tool when you require high-performance,
low-latency interop, or need to pass massive amounts of raw data between Dart
and the JVM.

For standard, cross-platform plugin development where you don't have
critical data transfers, use [Pigeon](/platform-integration/interop/pigeon)
instead.

## Developer flow

Generating bindings with JNIgen follows this general flow:

1.  Reference the native classes or JARs.
1.  Write the JNIgen configuration script.
1.  Generate the bindings by running JNIgen.
1.  Call the generated code from Dart.

:::note
For a complete list of configuration options, consult the
[JNIgen documentation on pub.dev][jnigen-pub] and the JNIgen README.
:::

To start, identify the native Java classes, packages, or compiled JAR/AAR files
you want to wrap.
Then write a configuration script (typically `tool/jnigen.dart` or
`jnigen.yaml`).
This configuration specifies where the native files are located,
what packages to include, and where to output the generated Dart code.

Next, run the generator tool (such as `dart run tool/jnigen.dart` or
`dart run jnigen --config jnigen.yaml`),
which parses the classes and generates the corresponding Dart bindings.

Last, import the generated Dart file into your app and call the functions
directly.
Because JNIgen communicates directly using the underlying FFI layer,
refer to the [`dart:ffi` guide](/platform-integration/interop/dart-ffi) to learn
how to manage native memory lifetimes and execute native calls without blocking
the UI thread.

:::note
If the native API changes, you need to update your configuration script and
regenerate the bindings.
:::

## Examples

To explore complete implementations of this flow,
including how to configure the generator,
refer to the [`permissions_plugin` demo][permissions-demo] and the
[`android_toast_demo`][toast-demo] in the official Flutter native interop
demos repository.

## Constraints and limitations

Keep these general considerations and limitations in mind when working with
JNIgen:

### Threading considerations

JNIgen calls execute synchronously on the calling thread.
Watch out for two common scenarios:

- Calling platform APIs that must run on the platform thread.
  Use `runOnPlatformThread` from `dart:ui`.
- Dart callbacks from Java run on the isolate that created them.
  This can lead to deadlocks if a blocked Java thread waits for a blocked
  Dart thread.

### Lifecycle of Java objects

JNI wrappers use Java global references.
There is a hard limit of 50,000 active references.
Call `.release()` or use `.using()` blocks to prevent memory leaks.
Use `WeakReference` to break reference cycles between Dart and Java GCs
when implementing interfaces.

### JVM runtime type checks

JNI wrappers are Dart extension types, and they compile down to `JObject`
at runtime.
Because of this, Dart's native `is` and `as` keywords do not check the Java
runtime type.
Use `x.isA(Foo.type)` and `x.as(Foo.type)` instead.

### General debugging

Tracking down JNI memory allocation bugs like `DoubleReleaseError`
and `UseAfterReleaseError` can be difficult.
Set `Jni.captureStackTraceOnRelease = true` to log stack traces
and help trace leaks.

## Resources

- [JNIgen package on pub.dev][jnigen-pub]
- [JNI package on pub.dev][jni-pub]
- [Official JNIgen examples on GitHub][jnigen-examples]

[jnigen-pub]: {{site.pub-pkg}}/jnigen
[jni-pub]: {{site.pub-pkg}}/jni
[jnigen-examples]: https://github.com/dart-lang/native/tree/main/pkgs/jnigen/example
[permissions-demo]: {{site.repo.demos}}/tree/main/native_interop_demos/permissions_plugin
[toast-demo]: {{site.repo.demos}}/tree/main/native_interop_demos/android_toast_demo
