---
title: FFIgen
description: >-
  Learn how to use FFIgen to generate type-safe Dart bindings
  for C, Objective-C, and Swift APIs.
---

## Overview

FFIgen (Foreign Function Interface generator) is a code generator tool
that creates type-safe Dart bindings for C libraries and Apple frameworks
(Objective-C and `@objc`-annotated Swift).
With FFIgen, you can call C, iOS, and macOS APIs directly and synchronously
from your Dart code.

:::note
Direct Swift interop without Objective-C compatibility annotations (`@objc`)
is experimental and uses [`package:swiftgen`][swiftgen-pub].
For production Swift plugins on iOS and macOS,
use [Pigeon](/platform-integration/interop/pigeon).
:::

## When to use FFIgen

Use FFIgen when you need to call C libraries,
wrap compiled C-ABI binaries (from C, C++, Rust, or Go),
or interact directly with Objective-C frameworks on iOS and macOS.

:::note
FFIgen parses C and Objective-C headers.
To wrap a C++ library, expose a C-compatible interface (`extern "C"`)
around your C++ code.
FFIgen can't parse C++ classes or templates directly.
:::

For cross-platform plugin development on Android, iOS, and macOS
where you don't need direct access to raw C pointers,
use [Pigeon](/platform-integration/interop/pigeon) instead.

## Developer flow

Generating bindings with FFIgen follows four steps:

1.  Reference the native headers.
1.  Write the FFIgen configuration script.
1.  Generate the bindings by running the configuration script.
1.  Call the generated code from Dart.

To start, identify the native header files or Apple framework APIs
that you want to wrap.
Then create a configuration script in `tool/ffigen.dart`
(some existing templates, such as `flutter create --template=package_ffi`,
use a `ffigen.yaml` file).
This configuration specifies where the header files are located
and where to write the generated Dart bindings.

Next, run the configuration script (`dart run tool/ffigen.dart`,
or `dart run ffigen` if your project uses `ffigen.yaml`),
which parses the headers and generates the corresponding Dart bindings.

Finally, import the generated Dart file into your app or package
and call the functions directly.
Because FFIgen communicates directly through the underlying FFI layer,
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
refer to the [official FFIgen examples][ffigen-examples]:

- The `simple` example demonstrates the general workflow with a minimal C API
  (a single function in one header file).
- The `objective_c` and `swift` examples demonstrate calling Apple frameworks
  using `tool/ffigen.dart`.
- The [`code_assets` examples][code-assets-examples] demonstrate real-world
  bundling use cases, such as system hostname lookups and audio playback.

## Constraints and limitations

Keep the following general considerations in mind when working with FFIgen:

### Source header files

FFIgen uses `libclang` to parse headers.
Resolve any compiler warnings logged during generation
to prevent unexpected runtime crashes.

### Operating system differences

Dart has no preprocessor equivalent to C macros
(such as `#if TARGET_OS_IPHONE`),
so handle platform-specific API variations at runtime
using `Platform.isIOS` or `Platform.isMacOS` checks.

### Objective-C bindings

Objective-C methods are resolved dynamically at runtime.
FFIgen maps Objective-C selectors to Dart method signatures automatically,
but inspect the generated bindings if you wrap heavily overloaded
native methods.

### Objective-C memory management

Dart uses garbage collection, whereas Objective-C uses reference counting.
Passing Dart closures that capture native wrapper objects can create
reference cycles across runtimes and leak memory.
To avoid retain cycles, consult the
[Objective-C memory management guide][objc-gc-doc].

### Objective-C runtime type checks

FFIgen wrappers enforce static Dart types,
but the underlying Objective-C object might be a different subclass at runtime.
Because of this, Dart's `is` and `as` keywords don't check the Objective-C
runtime type.
Use `.isA()` and `.as()` instead.

### Objective-C multithreading

UI-related Objective-C calls must run on the platform's main thread.
Some native callbacks can also crash your app if invoked on the wrong thread.

### Swift compatibility

FFIgen interacts with Swift through Objective-C compatibility headers.
Swift classes and methods must be annotated with `@objc` (or `@objcMembers`)
and inherit from `NSObject`.
Pure Swift features without an Objective-C representation—such as Swift structs,
generics, and enums with associated values—aren't supported by FFIgen.
For Swift plugins, use [Pigeon](/platform-integration/interop/pigeon),
or explore the experimental [`package:swiftgen`][swiftgen-pub] package.

## Resources

To learn about generating C and Objective-C bindings,
consult the following resources:

- [`package:ffigen` on pub.dev][ffigen-pub]
- [`package:objective_c` on pub.dev][objc-pub]
- [Official FFIgen examples on GitHub][ffigen-examples]

[ffigen-pub]: {{site.pub-pkg}}/ffigen
[objc-pub]: {{site.pub-pkg}}/objective_c
[swiftgen-pub]: {{site.pub-pkg}}/swiftgen
[ffigen-examples]: https://github.com/dart-lang/native/tree/main/pkgs/ffigen/example
[code-assets-examples]: {{site.pub-pkg}}/code_assets/example
[objc-gc-doc]: https://github.com/dart-lang/native/blob/main/pkgs/ffigen/doc/objc_gc.md
