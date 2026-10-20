---
title: Pigeon
description: >-
  Learn how to use Pigeon to generate type-safe bindings
  between your Dart code and the host platform.
---

## Overview

Pigeon is the recommended default tool for building Flutter plugins.
Pigeon replaces the manual setup of raw platform channels
with generated, type-safe APIs,
which prevents typos in method names and mismatched argument types.

## Choose a communication option

Pigeon supports two communication options depending on your target platform
and performance requirements:
native interop (direct FFI and JNI) and platform channels.

:::note
For low-level integrations that require direct access to native memory
or C and C++ libraries, use [FFIgen](/platform-integration/interop/ffigen)
or [JNIgen](/platform-integration/interop/jnigen) instead.
:::

### Pigeon with native interop (recommended for Android, iOS, and macOS)

Pigeon with native interop generates direct native bindings
using FFI on iOS and macOS, and JNI on Android.
This is the recommended default when targeting Android, iOS, or macOS.

Use this option when building for Android, iOS, or macOS,
especially if your use case requires any of the following capabilities:

- Synchronous execution on the native platform.
- High-frequency data streaming (for example, audio or camera frames).
- Calling native code directly from background [Dart isolates][].

### Pigeon with platform channels

Pigeon with platform channels generates standard platform channels that support
Android, iOS, macOS, Windows, and Linux.
You can generate platform channels for Windows and Linux from the same
Pigeon definition file that uses native interop on Android, iOS, and macOS.

Use this option if your use case requires any of the following capabilities:

- Desktop support on Windows or Linux.
- Zero external toolchains.

## Developer flow

The developer workflow with Pigeon follows four steps:

1.  Create the Pigeon definition file.
1.  Generate the bindings.
1.  Implement the native interface.
1.  Call the API from Flutter.

To start, create a Pigeon definition file in Dart
(typically outside of your `lib/` directory, such as `pigeons/messages.dart`).
This file defines your data structures and API interfaces using Pigeon
annotations such as `@HostApi` and `@FlutterApi`.
Next, run the Pigeon generator tool (`dart run pigeon`),
which parses your Pigeon definition file and generates code for both Dart
and your target native platforms.

To turn on native interop, set `appDirectory`, `swiftOptions`,
and `kotlinOptions` in the `@ConfigurePigeon` annotation at the top of your
Pigeon definition file:

```dart title="pigeons/messages.dart"
@ConfigurePigeon(
  PigeonOptions(
    // Tells FFIgen and JNIgen where your compiled app lives
    // (use './' for an app, or 'example/' for a plugin).
    appDirectory: 'example/',
    // iOS and macOS: call your Swift implementation directly through FFI.
    swiftOptions: SwiftOptions(useFfi: true),
    // Android: call your Kotlin implementation directly through JNI.
    kotlinOptions: KotlinOptions(useJni: true),
  ),
)
```

For complete prerequisites and build configuration,
consult the [Pigeon native interop guide][pigeon-native-guide].

After generating the code, implement the generated native interfaces
in your app's or plugin's native platform directory
(such as `android/`, `ios/`, or `macos/`)
and register them with the Flutter engine.
Finally, call the generated Dart classes from your Flutter app,
or invoke the generated native APIs to call back into your Dart code.

To modify the API later, update the Pigeon definition file,
regenerate the code, and update your native implementation.

## Examples

To explore complete implementations of this workflow,
including the Pigeon definition file, generated code,
and native implementations, refer to the following examples:

- [Example of Pigeon with native interop][pigeon-native-example]
- [Example of Pigeon with platform channels][pigeon-example]
- [`shared_preferences` plugin][shared-preferences-source]
  (a production plugin that uses Pigeon with native interop)

## Constraints and limitations

Keep the following constraints in mind when working with Pigeon:

### High-frequency raw pointers

For specialized use cases that require direct manipulation of raw native
pointers or manual C and C++ memory management,
use [FFIgen](/platform-integration/interop/ffigen) or
[JNIgen](/platform-integration/interop/jnigen) instead.

### Inheritance

Pigeon doesn't support complex class inheritance.
Flatten your data models where possible.

### Asynchronous errors on platform channels

When using Pigeon with platform channels, native implementations of `@async`
methods must return errors through the provided callback.

## Resources

To learn about building and migrating plugins with Pigeon,
consult the following resources:

- [Migrating from Pigeon with platform channels to Pigeon with native interop][pigeon-migration-guide]
- [Pigeon native interop guide][pigeon-native-guide]
- [`package:pigeon` on pub.dev][pigeon-pub]
- [Pigeon source code][pigeon-source]
- [Flutter native interop demos][native-interop-demos]

[Dart isolates]: {{site.dart-site}}/language/isolates
[pigeon-pub]: {{site.pub-pkg}}/pigeon
[pigeon-source]: {{site.repo.packages}}/tree/main/packages/pigeon
[pigeon-example]: {{site.repo.packages}}/tree/main/packages/pigeon/example
[pigeon-native-example]: {{site.repo.packages}}/tree/main/packages/pigeon/example/native_interop_app
[pigeon-native-guide]: {{site.repo.packages}}/blob/main/packages/pigeon/native_interop_guide.md
[pigeon-migration-guide]: {{site.repo.packages}}/blob/main/packages/pigeon/native_interop_migration_guide.md
[shared-preferences-source]: {{site.repo.packages}}/tree/main/packages/shared_preferences
[native-interop-demos]: {{site.repo.demos}}/tree/main/native_interop_demos
