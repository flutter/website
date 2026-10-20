---
title: Pigeon
description: Learn how to use Pigeon to generate type-safe bindings between your Dart code and the host platform.
---

## Overview

Pigeon is the recommended default tool for building Flutter plugins.
Pigeon replaces the manual setup of raw platform channels with generated,
type-safe APIs. This helps prevent typos in method names or mismatched argument types.

## Choosing a communication option with Pigeon

Pigeon supports the following two communication options depending on your target
platform and performance needs: native interop (direct FFI and JNI) or platform channels.

:::note
For low-level integrations that require direct access to native memory or C/C++ libraries,
use [FFIgen](/platform-integration/interop/ffigen) or [JNIgen](/platform-integration/interop/jnigen) instead.
:::

### Pigeon with native interop (recommended for Android, iOS, and macOS)

Pigeon with native interop (direct FFI and JNI) generates direct native bindings
using FFI on iOS and macOS, and JNI on Android.
This is the recommended default when targeting Android, iOS, or macOS.

Use this option if you're building for Android, iOS, or macOS,
especially when your use case requires any of the following:

* Synchronous execution on your native platform.
* High-frequency data streaming (for example, audio or camera frames).
* Calling native code directly from background Dart isolates.

### Pigeon with platform channels

Pigeon with platform channels generates standard platform channels that support
Android, iOS, macOS, Windows, and Linux.
You can generate platform channels for Windows and Linux from the same Pigeon
file that uses native interop on Android, iOS, and macOS.

Use this option if your use case requires any of the following:

* Desktop support on Windows or Linux.
* Zero external toolchains.

## Developer flow

The developer experience with Pigeon follows a structured cycle:

1. Define the schema.
2. Generate the code.
3. Implement the native interface.
4. Call the API from Flutter.

To start, define the communication definition in a Dart file (typically outside of your
`lib/` directory, such as `pigeons/message.dart`). This file defines the data structures
and the API interfaces using Pigeon annotations like `@HostApi` and `@FlutterApi`. Next,
run the Pigeon generator tool, which parses your definition file and produces the
necessary code for both Dart and your target native platform.

:::note
To enable Pigeon with native interop, set `swiftOptions: SwiftOptions(useFfi: true)`,
`kotlinOptions: KotlinOptions(useJni: true)`, and `appDirectory` (for example,
`'./'` for an app or `'example/'` for a plugin) in the `@ConfigurePigeon`
annotation of your Pigeon file.
For complete prerequisites and build configuration,
refer to the [Pigeon native interop guide][pigeon-native-guide].
:::

After the code is generated, you implement the generated native interfaces in your host
project and register them with the Flutter engine. Finally, you call the generated Dart
classes from your Flutter application, or invoke the generated native APIs to call back
into your Dart code.

If you need to modify the API, first modify the definition file, regenerate the code,
and then update your implementation accordingly.

## Examples

To explore a complete implementation of this flow, including the Dart definition,
generated code, and native implementations, refer to the following examples:

* [Example of Pigeon with native interop][pigeon-native-example]
* [Example of Pigeon with platform channels][pigeon-example]
* [`shared_preferences` plugin][shared-preferences-source] (a production plugin using Pigeon with native interop)

## Constraints and limitations

### High-frequency data

For specialized use cases requiring direct manipulation of raw native pointers or C/C++
memory management, use [FFIgen](/platform-integration/interop/ffigen) or
[JNIgen](/platform-integration/interop/jnigen) instead.

### Inheritance

Pigeon does not support complex inheritance. Flatten your data models where possible.

### (Pigeon with platform channels only) Async errors

For `@async` methods, native code must return errors through the provided callback.

## Resources

* [Migrating from Pigeon with platform channels to Pigeon with native interop][pigeon-migration-guide]
* [Pigeon native interop guide][pigeon-native-guide]
* [Pigeon package on pub.dev][pigeon-pub]
* [Pigeon source code][pigeon-source]
* [Flutter native interop demos][native-interop-demos]

[pigeon-pub]: https://pub.dev/packages/pigeon
[pigeon-source]: https://github.com/flutter/packages/tree/main/packages/pigeon
[pigeon-example]: https://github.com/flutter/packages/tree/main/packages/pigeon/example
[pigeon-native-example]: https://github.com/flutter/packages/tree/main/packages/pigeon/example/native_interop_app
[pigeon-native-guide]: https://github.com/flutter/packages/blob/main/packages/pigeon/native_interop_guide.md
[pigeon-migration-guide]: https://github.com/flutter/packages/blob/main/packages/pigeon/native_interop_migration_guide.md
[shared-preferences-source]: https://github.com/flutter/packages/tree/main/packages/shared_preferences
[native-interop-demos]: https://github.com/flutter/demos/tree/main/native_interop_demos
