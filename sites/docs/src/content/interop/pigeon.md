---
title: Pigeon
description: >-
  Learn how to use Pigeon to generate type-safe bindings
  between your Dart code and the host platform.
---

## Overview

Pigeon is the recommended default tool for building Flutter plugins.
Pigeon replaces the manual setup of raw platform channels with generated,
type-safe APIs.
This helps prevent typos in method names or mismatched argument types.

## Choose a communication option with Pigeon

Pigeon supports the following two communication options depending on your target
platform and performance needs:
native interop (direct FFI and JNI) or platform channels.

:::note
For low-level integrations that require direct access to native memory
or C and C++ libraries, use [FFIgen](/interop/ffigen)
or [JNIgen](/interop/jnigen) instead.
:::

### Pigeon with native interop

Pigeon with native interop uses [FFIgen](/interop/ffigen)
and [JNIgen](/interop/jnigen) under the hood to generate
direct native bindings (using FFI on iOS and macOS, and JNI on Android).

Use this option if your use case requires any of the following:

- You need synchronous execution on your native platform.
- You're doing high-frequency data streaming
  (for example, audio or camera frames).
- You're calling native code from background Dart isolates.

### Pigeon with platform channels

Pigeon with platform channels generates standard platform channels that support
Android, iOS, macOS, Windows, and Linux.

Use this option if your use case requires any of the following:

- You need desktop support on Windows or Linux.
- You want zero external toolchains.

## Developer flow

Generate type-safe bindings with Pigeon using the following steps:

1.  Create the Pigeon definition file.
1.  Generate the code.
1.  Implement the native interface.
1.  Call the API from Flutter.

To start, create a Pigeon definition file in Dart
(typically outside of your `lib/` directory, such as `pigeons/messages.dart`).
This file defines the data structures and the API interfaces
using Pigeon annotations like `@HostApi` and `@FlutterApi`.
Next, run the Pigeon generator tool, which parses your Pigeon definition file
and produces the necessary code for both Dart and your target native platform.

:::note
If you're using Pigeon with the native interop communication option,
set `appDirectory`, `swiftOptions: SwiftOptions(useFfi: true, ffiModuleName: 'Runner')`,
and `kotlinOptions: KotlinOptions(useJni: true)` in the `@ConfigurePigeon`
section of your Pigeon definition file.
For complete prerequisites and build configuration,
refer to the [native interop guide][pigeon-native-guide].
:::

After the code is generated, implement the generated native interfaces
in the platform-specific directories of your Flutter project
(such as `android/`, `ios/`, or `macos/`)
and register them with the Flutter engine.
Finally, call the generated Dart classes from your Flutter app
(using `<MyApi>.createWithNativeInteropApi()` when using native interop),
or invoke the generated native APIs to call back into your Dart code.

If you need to modify the API, first modify the Pigeon definition file,
regenerate the code, and then update your implementation accordingly.

## Examples

To explore a complete implementation of this flow,
including the Pigeon definition file, generated code,
and native implementations, refer to the following examples:

- [Example of Pigeon with native interop][pigeon-native-example]
- [Example of Pigeon with platform channels][pigeon-example]
- [`shared_preferences` plugin][shared-preferences-source]

## Constraints and limitations

Keep the following constraints and limitations in mind when working with Pigeon:

### High-frequency data

For specialized use cases requiring direct manipulation of raw native pointers
or C and C++ memory management,
use [FFIgen](/interop/ffigen) or
[JNIgen](/interop/jnigen) instead.

### Inheritance

Pigeon doesn't support complex inheritance.
Flatten your data models where possible.

### (Pigeon with platform channels only) Async errors

In Kotlin and Swift, `@async` generates `suspend` and `async throws`
functions where native code throws `FlutterError` or `PigeonError` directly.
For `@asyncCallback` methods—or when using the Java, Objective-C, C++,
or GObject generators—native code must return errors through the provided
completion callback.

## Resources

To learn about building and migrating plugins with Pigeon,
refer to the following resources:

- [Migrating from Pigeon with platform channels to Pigeon with native interop][pigeon-migration-guide]
- [Pigeon native interop guide][pigeon-native-guide]
- [Pigeon package on pub.dev][pigeon-pub]
- [Pigeon source code][pigeon-source]
- [Flutter native interop demos][native-interop-demos]

[pigeon-pub]: {{site.pub-pkg}}/pigeon
[pigeon-source]: {{site.repo.packages}}/tree/main/packages/pigeon
[pigeon-example]: {{site.repo.packages}}/tree/main/packages/pigeon/example
[pigeon-native-example]: {{site.repo.packages}}/tree/main/packages/pigeon/example/native_interop_app
[pigeon-native-guide]: {{site.repo.packages}}/blob/main/packages/pigeon/native_interop_guide.md
[pigeon-migration-guide]: {{site.repo.packages}}/blob/main/packages/pigeon/native_interop_migration_guide.md
[shared-preferences-source]: {{site.repo.packages}}/tree/main/packages/shared_preferences
[native-interop-demos]: {{site.repo.demos}}/tree/main/native_interop_demos
