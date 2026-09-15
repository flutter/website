---
title: JNIgen
description: Learn how to use JNIgen to generate type-safe Dart bindings for Java and Kotlin APIs.
---

JNIgen (Java Native Interface generator) is a code generator tool that creates
type-safe Dart bindings for Java and Kotlin libraries and APIs.
This allows you to call Android APIs directly and synchronously from your
Dart code.

## When to use JNIgen

Use JNIgen when you need to call Java or Kotlin libraries, wrap compiled JAR
or AAR files, or interact directly with Android platform APIs from your Dart code.
It is most appropriate when you need to wrap existing third-party Java/Kotlin SDKs,
integrate complex Android system APIs without writing manual platform channel
handlers, or transfer high-throughput data to and from the JVM.

Because JNIgen uses direct JNI bindings through `dart:ffi`,
it is also the recommended tool when you require high-performance,
low-latency interop, or need to pass massive amounts of raw data between Dart
and the JVM.

For standard, cross-platform mobile plugin development where you don't have
critical data transfers, consider using
[Pigeon](/platform-integration/interop/pigeon) instead.

## Developer flow

Generating bindings with JNIgen follows this general flow:

1. **Identify native classes or JARs:**
   Identify the native Java/Kotlin classes, packages, or compiled `.jar`/`.aar`
   files you want to wrap.

2. **Write the JNIgen configuration file:**
   Create a configuration file (typically `jnigen.yaml`):

   ```yaml
   # jnigen.yaml
   output:
     dart: 'lib/src/generated/android_utils.dart'
   classes:
     - 'android.text.format.DateFormat'
   ```

   :::note
   For a complete list of configuration options,
   consult the [JNIgen documentation on pub.dev][jnigen-pub] and the
   [JNIgen README][jnigen-readme].
   :::

3. **Generate bindings:**
   Run the generator from your terminal:

   ```bash
   dart run jnigen --config jnigen.yaml
   ```

4. **Call the generated code from Dart:**
   Import the generated Dart file into your app and call the functions
   directly:

   ```dart
   import 'src/generated/android_utils.dart';

   void printFormattedDate() {
     final formatted = DateFormat.format(
       'yyyy-MM-dd',
       DateTime.now().millisecondsSinceEpoch,
     );
     print('Formatted date: $formatted');
   }
   ```

   Because JNIgen communicates directly using the underlying FFI layer,
   refer to the [dart:ffi guide](/platform-integration/interop/dart-ffi)
   to learn how to manage native memory lifetimes and execute native calls
   without blocking the UI thread.

:::note
If the native API changes, update your configuration file and regenerate
the bindings.
:::

## Examples

To explore complete implementations of this flow, including how to configure
the generator, consult:

* [`permissions_plugin` demo][permissions-demo]
  in the official Flutter native interop demos repository
* [`android_toast_demo`][toast-demo]
  in the official Flutter native interop demos repository
* [Official JNIgen examples on GitHub][jnigen-examples]

## Constraints and limitations

### Threading considerations

JNIgen calls execute synchronously on the calling thread.
Watch out for two common scenarios:

* **Platform UI thread affinity:**
  Any Android API that interacts with Views, Activities, or UI components
  must run on the Android main thread.
  If invoking these from a background Dart isolate or worker thread,
  dispatch the call to the Android main looper:
  `Handler(Looper.getMainLooper()).post { ... }`.
* **Deadlock risk with reverse callbacks:**
  Dart callbacks from Java run on the isolate that created them.
  This can lead to deadlocks if a blocked Java thread waits for a blocked
  Dart thread.

### Android Context

Many Android platform APIs require an application or activity `Context`.
When working with JNIgen in a Flutter Android app, you can obtain the global
application context through `Jni.androidApplicationContext` or retrieve the
current activity reference through `Jni.getCurrentActivity()`.

### Lifecycle of Java objects

JNI wrappers use Java global references.
Android has a hard limit of 50,000 active global references.
Call `.release()` or use `.using()` blocks to prevent memory leaks.
Use `WeakReference` to break reference cycles between Dart and Java garbage
collectors when implementing interfaces.

### JVM runtime type checks

JNI wrappers are Dart extension types, and they compile down to `JObject`
at runtime.
Because of this, Dart's native `'is'` and `'as'` keywords do not check the Java
runtime type.
Use `x.isA(Foo.type)` and `x.as(Foo.type)` instead.

### General debugging

Tracking down JNI memory allocation bugs like `DoubleReleaseError` and
`UseAfterReleaseError` can be difficult.
Set `Jni.captureStackTraceOnRelease = true` to log stack traces and help
trace leaks.

## Resources

* [JNIgen package on pub.dev][jnigen-pub]
* [JNI package on pub.dev][jni-pub]
* [JNIgen source code on GitHub][jnigen-readme]
* [Official JNIgen examples on GitHub][jnigen-examples]

[jnigen-pub]: https://pub.dev/packages/jnigen
[jni-pub]: https://pub.dev/packages/jni
[jnigen-readme]: https://github.com/dart-lang/native/tree/main/pkgs/jnigen
[jnigen-examples]: https://github.com/dart-lang/native/tree/main/pkgs/jnigen/example
[permissions-demo]: https://github.com/flutter/demos/tree/main/native_interop_demos/permissions_plugin
[toast-demo]: https://github.com/flutter/demos/tree/main/native_interop_demos/android_toast_demo
