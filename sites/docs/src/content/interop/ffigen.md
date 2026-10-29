---
title: FFIgen
description: >-
  Learn how to use FFIgen to generate type-safe Dart bindings
  for C, Objective-C, and Swift APIs.
---

## Overview

FFIgen (the Foreign Function Interface generator) is a code generator tool
that creates type-safe Dart bindings for C libraries and Apple frameworks
(Objective-C and Swift).
This allows calling Apple platform APIs (iOS and macOS) directly
and synchronously from your Dart code.

:::note
Direct Swift interop is in experimental support.
:::

## When to use FFIgen

Use FFIgen when you need to call C libraries,
wrap compiled binaries (like C, C++, Rust, or Go),
or interact directly with Objective-C and Swift frameworks on iOS and macOS.

:::note
FFIgen parses C and Objective-C headers.
To wrap C++ libraries, expose a C-compatible interface
around your C++ code.
FFIgen can't parse C++ classes or templates directly.
:::

For standard, cross-platform plugin development where you don't have
critical data transfers, use [Pigeon](/interop/pigeon)
instead.

## Developer flow

Generate bindings with FFIgen using the following steps:

1.  Reference the native headers.
1.  Write the FFIgen configuration script.
1.  Generate the bindings by running FFIgen.
1.  Call the generated code from Dart.

To start, identify the native header files or APIs you want to wrap.
Then write a configuration script (typically `tool/ffigen.dart`).
This configuration specifies where the header files are located
and where to output the generated Dart code.

Next, run the configuration script (`dart run tool/ffigen.dart`),
which parses the headers and generates the corresponding Dart bindings.

Last, import the generated Dart file into your app and call the functions
directly.
FFIgen communicates directly through the underlying FFI layer,
so refer to the [`dart:ffi` guide](/interop/dart-ffi)
to learn how to manage native memory lifetimes and execute native calls
without blocking the UI thread.

:::note
If the native API changes, update your configuration script
and regenerate the bindings.
:::

## Example

To explore a complete implementation of this flow,
including how to configure the generator,
refer to the [official FFIgen examples][ffigen-examples].

The `add` example highlights the general flow with a toy native API
(one function in a single header file).

The `code_assets` examples highlight real-world examples like
system hostname lookups and audio playback.

## Constraints and limitations

Some general considerations when working with FFIgen:

### Source header files

FFIgen uses `libclang` to parse headers.
Always resolve compiler warnings logged during generation
to prevent runtime crashes.

### OS differences

Dart has no equivalent of C macros (like `#if TARGET_OS_IPHONE`),
so handle minor API variations using runtime `Platform.isIOS` checks.

Some Objective-C and Swift-specific pitfalls when working with FFIgen:

### Objective-C bindings

Objective-C methods are dynamically resolved.
FFIgen automatically maps method selectors to Dart signatures,
but verify selectors by reading the bindings
if you're using heavily overloaded native methods.

### Objective-C memory management

Dart uses garbage collection while Objective-C uses reference counting.
Passing Dart closures that close over native wrapper objects can easily create
reference cycles and leak memory.
To break these reference cycles, wrap the captured object in a `WeakReference`,
as shown in the [Objective-C memory management guide][objc-gc-doc].

### Objective-C runtime checks

FFIgen wrappers enforce Dart static types,
but the underlying Objective-C object might have a different runtime subclass,
so Dart's `is` and `as` keywords won't work as expected.
Use `.isA()` and `.as()` instead.

### Objective-C multithreading

UI-related Objective-C calls must run on the iOS main platform thread.
Also, some types of callbacks can crash your app
if they're executed on the wrong thread.

### Swift compatibility

FFIgen interacts with Swift through Objective-C.
Pure Swift features (such as structs, generics, or enums associated with values)
aren't supported, and classes must be annotated with `@objc`.
For pure Swift interop, explore the Dart team's experimental
[`package:swiftgen`][swiftgen-pub] package,
or use [Pigeon](/interop/pigeon) for production Swift plugins.

## Resources

To learn about generating C, Objective-C, and Swift bindings with FFIgen,
refer to the following resources:

- [FFIgen package on pub.dev][ffigen-pub]
- [`objective_c` package on pub.dev][objc-pub]
- [Official FFIgen examples on GitHub][ffigen-examples]

[ffigen-pub]: {{site.pub-pkg}}/ffigen
[objc-pub]: {{site.pub-pkg}}/objective_c
[swiftgen-pub]: {{site.pub-pkg}}/swiftgen
[ffigen-examples]: https://github.com/dart-lang/native/tree/main/pkgs/ffigen/example
[objc-gc-doc]: https://github.com/dart-lang/native/blob/main/pkgs/ffigen/doc/objc_gc.md
