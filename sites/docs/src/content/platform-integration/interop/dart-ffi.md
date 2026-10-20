---
title: Interact with native memory using dart:ffi
shortTitle: dart:ffi
description: >-
  Learn how to interact with native memory using the dart:ffi library.
---

The `dart:ffi` (Foreign Function Interface) library is a core Dart SDK library
that provides low-level APIs to call C-ABI functions and manage native memory
from Dart.

Unlike code generation tools such as [Pigeon](/platform-integration/interop/pigeon),
[FFIgen](/platform-integration/interop/ffigen),
or [JNIgen](/platform-integration/interop/jnigen),
`dart:ffi` is the underlying runtime layer that powers those tools
and enables direct native memory interop.

## When to use `dart:ffi`

When you use FFIgen or JNIgen to generate Dart bindings for low-level APIs,
the generated bindings often take native pointers or C structs
rather than Dart objects like `String` or `List`.
Because Dart memory is garbage collected
and native C memory is manually managed,
you use `dart:ffi` and `package:ffi` to bridge the two memory models:

- **Memory allocation.**
  Allocate space on the native heap for C pointers, structs, and buffers,
  and free that memory when the native call finishes to prevent memory leaks.
- **Data conversion.**
  Convert Dart types (such as `String` or typed data lists) into C-compatible
  representations (such as `Pointer<Utf8>`) that native code can read.

## Core libraries: `dart:ffi` and `package:ffi`

To work with native memory in Dart, you use two libraries together:

- **`dart:ffi`.**
  Built into the core Dart SDK.
  Provides native representation types (`Pointer`, `Struct`, `Union`, `Int32`),
  `@Native` annotations, and dynamic library lookup APIs.
- **`package:ffi`.**
  A companion package on pub.dev that provides native memory allocators
  (`calloc`, `malloc`, and `Arena`) and string conversion helpers
  (`toNativeUtf8`, `toDartString`).

## Concurrency in Flutter

FFI calls execute synchronously on the calling thread.
If you invoke a long-running or blocking C function on your Flutter app's
main UI isolate, your app drops frames or freezes.
To keep the UI responsive, run blocking FFI calls inside a background
Dart isolate using `Isolate.run`.

## Resources

To explore code examples for memory allocation, string conversion,
structs, and dynamic library loading, consult the following resources:

- [C interop guide on dart.dev][dart-c-interop]
- [`dart:ffi` API reference][dart-ffi-api]
- [`package:ffi` on pub.dev][package-ffi-pub]

[dart-c-interop]: {{site.dart-site}}/interop/c-interop
[dart-ffi-api]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[package-ffi-pub]: {{site.pub-pkg}}/ffi
