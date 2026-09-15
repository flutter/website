---
title: FFIgen
description: Learn how to use FFIgen to generate type-safe Dart bindings for C, Objective-C, and Swift APIs.
---

FFIgen (the Foreign Function Interface generator) is a code generator tool
that creates type-safe Dart bindings for C libraries and Apple frameworks
(Objective-C and Swift).
This allows you to call Apple platform APIs (iOS and macOS) directly and
synchronously from your Dart code.

:::note
Swift interop is currently in experimental support.
:::

## When to use FFIgen

Use FFIgen when you need to call C libraries, wrap compiled binaries (like C,
C++, Rust, or Go), or interact directly with Objective-C and Swift frameworks
on iOS and macOS.

:::note
FFIgen parses C and Objective-C headers using `libclang`.
To wrap C++ libraries, you must expose a C-compatible interface
(`extern "C"`) around your C++ code.
FFIgen cannot parse C++ classes or templates directly.
:::

For standard, cross-platform mobile plugin development where you don't have
critical data transfers, consider using
[Pigeon](/platform-integration/interop/pigeon) instead.

## Developer flow

Generating bindings with FFIgen follows these steps:

1. **Reference the native headers:**
   Identify the native header files or APIs you want to wrap.
2. **Write the FFIgen configuration file:**
   Create a configuration file (typically `ffigen.yaml`).
   This configuration specifies where the header files are located and where
   to output the generated Dart code:

   ```yaml
   # ffigen.yaml
   output: 'lib/src/generated_bindings.dart'
   headers:
     entry-points:
       - 'src/my_header.h'
   ```

3. **Generate bindings:**
   Run the generator from your terminal:

   ```bash
   dart run ffigen
   ```

4. **Call the generated code from Dart:**
   Import the generated Dart file into your app and call the functions
   directly.
   Because FFIgen communicates directly using the underlying FFI layer,
   refer to the [dart:ffi guide](/platform-integration/interop/dart-ffi)
   to learn how to manage native memory lifetimes and execute native calls
   without blocking the UI thread.

:::note
If the native API changes, update your configuration file and regenerate
the bindings.
:::

## Examples

To explore a complete implementation of this flow, including how to configure
the generator, consult the [official FFIgen examples on GitHub][ffigen-examples].

* **Add example:** Highlights the general flow with a toy native API
  (one function in a single header file).
* **`code_assets` examples:** Highlight real-world examples like system
  hostname lookups and audio playback.

## Constraints and limitations

### General considerations

* **Source header files:**
  FFIgen uses `libclang` to parse headers. Always resolve compiler warnings
  logged during generation to prevent runtime crashes.
* **OS differences:**
  Dart has no equivalent of C preprocessor macros (like `#if TARGET_OS_IPHONE`),
  so you must handle minor API variations using runtime `Platform.isIOS` checks.

### Objective-C and Swift pitfalls

* **Objective-C bindings:**
  Objective-C methods are dynamically resolved.
  FFIgen automatically maps method selectors to Dart signatures, but you should
  verify selectors by reading the bindings if you use heavily overloaded native
  methods.
* **Objective-C memory management:**
  Dart uses garbage collection while Objective-C uses reference counting.
  Passing Dart closures that close over native wrapper objects can easily create
  reference cycles and leak memory.
* **Objective-C runtime checks:**
  FFIgen wrappers enforce Dart static types, but the underlying Objective-C
  object might have a different runtime subclass, so Dart `'is'` and `'as'`
  keywords won't work as expected. Use `.isA()` and `.as()` instead.
* **Objective-C multithreading:**
  UI-related Objective-C calls must run on the iOS main platform thread.
  Also, some types of callbacks can crash your app if executed on the wrong
  thread.
* **Swift compatibility:**
  FFIgen interacts with Swift through Objective-C. Pure Swift features
  (such as structs, generics, or enums with associated values) are not
  supported directly without a compatibility wrapper.
  Classes must be annotated with `@objc` or inherit from `NSObject`.
  For native Swift plugin authoring, consider
  [Pigeon](/platform-integration/interop/pigeon).

## Resources

* [FFIgen package on pub.dev][ffigen-pub]
* [objective_c package on pub.dev][objc-pub]
* [Official FFIgen examples on GitHub][ffigen-examples]

[ffigen-pub]: https://pub.dev/packages/ffigen
[objc-pub]: https://pub.dev/packages/objective_c
[ffigen-examples]: https://github.com/dart-lang/native/tree/main/pkgs/ffigen/example
