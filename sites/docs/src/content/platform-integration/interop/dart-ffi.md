---
title: Interact with native memory using dart:ffi
shortTitle: dart:ffi
description: Learn how to interact with native memory using the dart:ffi library.
---

The `dart:ffi` (Foreign Function Interface) library is a core Dart SDK library that
provides the low-level APIs to call C-ABI functions from Dart.

Rather than a code generation tool like Pigeon, FFIgen, or JNIgen, `dart:ffi` is the
underlying technology that powers these tools and enables native memory interop.

## When do you need dart:ffi

When you use FFIgen or JNIgen to generate Dart bindings, the generated code does not
automatically convert Dart objects like Strings or Lists into native formats.
Because Dart memory is automatically garbage collected and native C memory is manually
managed, you must use `dart:ffi` to bridge this gap.

The two most common scenarios when `dart:ffi` is needed are memory allocation and data conversion.

With memory allocation, you use `dart:ffi` to allocate space on the system heap for
native arguments, and you must manually free that memory when done. This helps avoid
memory leaks.

With data conversion, you use `dart:ffi` to convert Dart data types so they can be read
by native code.

## Core tools: dart:ffi and package:ffi

To write interop code, you use two libraries:

* **`dart:ffi`:** This is built into the core Dart SDK. It provides native representation
  types and lookup signatures.
* **`package:ffi`:** This package is a required dependency for working with `dart:ffi`.
  It provides memory allocation methods and conversion helpers.

## Concurrency in Flutter

FFI calls are synchronous and run on the thread they are called on. If you invoke a heavy
or blocking C function on your Flutter app's main UI thread, your app will freeze or drop
frames. To prevent this, you should execute blocking FFI calls inside a background Dart
isolate using `Isolate.run`.

## Resources

To explore examples of memory allocation, string conversion, and dynamic library loading,
refer to these Dart interop resources:

* [C interop guide (includes code examples for pointers, memory allocation, and structs)][dart-c-interop]
* [dart:ffi API reference][dart-ffi-api]
* [package:ffi on pub.dev][package-ffi-pub]

[dart-c-interop]: {{site.dart-site}}/interop/c-interop
[dart-ffi-api]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[package-ffi-pub]: https://pub.dev/packages/ffi
