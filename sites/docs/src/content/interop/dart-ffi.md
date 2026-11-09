---
title: Interact with native memory using dart:ffi
shortTitle: dart:ffi
description: >-
  Learn how to interact with native memory using the dart:ffi library.
---

The `dart:ffi` (Foreign Function Interface) library is a core Dart SDK library
that provides the low-level APIs to call C-ABI functions from Dart.

Rather than code generation tools like [Pigeon](/interop/pigeon),
[FFIgen](/interop/ffigen),
or [JNIgen](/interop/jnigen),
`dart:ffi` is the underlying technology that powers these tools
and enables native memory interop.

## When to use `dart:ffi` and `package:ffi`

Dart memory is automatically garbage collected while native C memory is
manually managed, so use `dart:ffi` and `package:ffi` to bridge this gap.

The two most common scenarios when `package:ffi` is needed alongside `dart:ffi`
are memory allocation and C string conversion.

With memory allocation, use `package:ffi` to allocate space on the system heap
for native arguments, and manually free that memory when done
to prevent memory leaks.

With data conversion, use `package:ffi` to convert Dart strings into C strings
(`Pointer<Utf8>` or `Pointer<Utf16>`) so they can be read by native C code.

## Core tools: `dart:ffi` and `package:ffi`

To write C interop code, use two libraries:

- **`dart:ffi`:** Built into the core Dart SDK and required for doing FFI
  interop. It provides native representation types, pointers, structs, and
  function lookup signatures.
- **`package:ffi`:** A companion package that contains utilities helpful in
  common C interop use cases, such as memory allocation (`calloc` and `malloc`)
  and C string conversion helpers.

## Concurrency in Flutter

FFI calls are synchronous and run on the thread on which they're called.
If you invoke a heavy or blocking C function on your Flutter app's
main UI thread, your app may freeze or drop frames.
To prevent this, execute blocking FFI calls inside a background Dart isolate
using `Isolate.run`.

## Resources

To explore examples of memory allocation, string conversion,
and dynamic library loading, refer to these Dart interop resources:

- [C interop guide (includes code examples for pointers, memory allocation, and structs)][dart-c-interop]
- [`dart:ffi` API reference][dart-ffi-api]
- [`package:ffi` on pub.dev][package-ffi-pub]

[dart-c-interop]: {{site.dart-site}}/interop/c-interop
[dart-ffi-api]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[package-ffi-pub]: {{site.pub-pkg}}/ffi
