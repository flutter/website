---
title: Interact with native memory using dart:ffi
shortTitle: dart:ffi
description: Learn how to use dart:ffi to allocate native memory, work with pointers, and convert data types.
---

The `dart:ffi` (Foreign Function Interface) library is a core Dart SDK library
that provides low-level APIs to call C-ABI functions directly from Dart.

Rather than a code generation tool like Pigeon, FFIgen, or JNIgen,
`dart:ffi` is the underlying runtime technology that powers these tools
and enables direct native memory interop.

## When do you need dart:ffi

When you use FFIgen or JNIgen to generate Dart bindings,
the generated code does not automatically convert Dart objects
(like `String` or `List`) into native formats.
Because Dart memory is automatically garbage collected and native C memory is
manually managed, you must use `dart:ffi` to bridge this gap.

The two most common scenarios when `dart:ffi` is needed are:

* **Memory allocation:**
  Use `dart:ffi` to allocate space on the system heap for native arguments,
  and manually free that memory when done to avoid memory leaks.
* **Data conversion:**
  Use `dart:ffi` and helper extensions to convert Dart data types into native
  representations (such as Dart `String` to UTF-8 C string pointers)
  so they can be read by native code.

## Core tools: dart:ffi and package:ffi

To write low-level interop code, you use two complementary libraries:

* **`dart:ffi`:**
  Built into the core Dart SDK.
  It provides native representation types (`Int32`, `Pointer<Void>`, `Float`,
  `Struct`), lookup signatures, and dynamic library loading (`DynamicLibrary`).
* **`package:ffi`:**
  A required package dependency when working with `dart:ffi`.
  It provides memory allocators (`malloc`, `calloc`), extension methods,
  and conversion helpers (such as `toNativeUtf8()` and `toDartString()`).

## Concurrency in Flutter

FFI calls are synchronous and run on the thread they are invoked on.
If you invoke a heavy or blocking C function on your Flutter app's main UI thread,
your app freezes or drops frames.

To prevent UI jank, execute blocking FFI calls inside a background Dart isolate
using `Isolate.run`:

```dart
import 'dart:ffi';
import 'dart:isolate';

Future<int> computeHeavyNativeTask() async {
  return await Isolate.run(() {
    // Synchronous FFI call executes in a background isolate
    final result = nativeHeavyCalculation();
    return result;
  });
}
```

## Resources

To explore examples of memory allocation, string conversion, and dynamic
library loading, refer to these Dart interop resources:

* [C interop guide on dart.dev][dart-c-interop]
  (includes code examples for pointers, memory allocation, and structs)
* [dart:ffi API reference][dart-ffi-api]
* [package:ffi on pub.dev][package-ffi-pub]

[dart-c-interop]: {{site.dart-site}}/interop/c-interop
[dart-ffi-api]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[package-ffi-pub]: https://pub.dev/packages/ffi
