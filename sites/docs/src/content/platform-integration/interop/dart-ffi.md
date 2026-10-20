---
title: Interact with native memory using dart:ffi
shortTitle: dart:ffi
description: >-
  Learn how to interact with native memory using the dart:ffi library.
---

The `dart:ffi` (Foreign Function Interface) library is a core Dart SDK library
that provides the low-level APIs to call C-ABI functions from Dart.

Rather than a code generation tool like [Pigeon](/platform-integration/interop/pigeon),
[FFIgen](/platform-integration/interop/ffigen),
or [JNIgen](/platform-integration/interop/jnigen),
`dart:ffi` is the underlying technology that powers these tools
and enables native memory interop.

## When to use `dart:ffi`

When you use FFIgen or JNIgen to generate Dart bindings,
the generated code does not automatically convert Dart objects
like `String` or `List` into native formats.
Because Dart memory is automatically garbage collected
and native C memory is manually managed,
you must use `dart:ffi` to bridge this gap.

The two most common scenarios when `dart:ffi` is needed are
memory allocation and data conversion.

With memory allocation, you use `dart:ffi` to allocate space on the system heap
for native arguments, and you must manually free that memory when done.
This helps avoid memory leaks.

With data conversion, you use `dart:ffi` to convert Dart data types
so they can be read by native code.

## Core tools: `dart:ffi` and `package:ffi`

To write interop code, you use two libraries:

- **`dart:ffi`:** Built into the core Dart SDK.
  It provides native representation types and lookup signatures.
- **`package:ffi`:** A required dependency for working with `dart:ffi`.
  It provides memory allocation methods and conversion helpers.

## Concurrency in Flutter

FFI calls are synchronous and run on the thread they are called on.
If you invoke a heavy or blocking C function on your Flutter app's
main UI thread, your app freezes or drops frames.
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
