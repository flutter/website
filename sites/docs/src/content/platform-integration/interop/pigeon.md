---
title: Pigeon
description: Learn how to use Pigeon to generate type-safe bindings between your Dart code and the host platform.
---

Pigeon is the recommended default tool for building Flutter plugins.
Pigeon replaces the manual setup of raw platform channels with generated,
type-safe APIs.
This helps prevent typos in method names or mismatched argument types.

## Choosing a communication option with Pigeon

Pigeon supports two communication options depending on your target
platform and performance needs:
**native interop** (direct FFI and JNI) or **platform channels**.

You can use both options simultaneously in the same plugin (for example,
generating native bindings for Android and iOS,
and platform channels for Windows and Linux).

:::note
For low-level integrations that require direct access to native memory or
C/C++ libraries, use [FFIgen](/platform-integration/interop/ffigen) or
[JNIgen](/platform-integration/interop/jnigen) instead.
:::

### Pigeon with native interop

Pigeon with native interop generates direct native bindings using FFI or JNI
for mobile platforms (Android and iOS).

Use this option if your use case requires any of the following:

* You need synchronous execution on your native platform.
* You perform high-frequency data streaming (for example, audio or camera frames).
* You call native code from background Dart isolates.

### Pigeon with platform channels

Pigeon with platform channels generates standard platform channels that support
all Flutter platforms (Android, iOS, macOS, Windows, Linux, and Web).

Use this option if your use case requires any of the following:

* You target platforms that do not yet support direct native bindings
  (Windows, Linux, or Web).
* You want zero external toolchains.

## Developer flow

The developer experience with Pigeon follows a structured cycle:

1. **Define the schema:**
   Define the communication contract in a Dart file (typically outside of your
   `lib/` directory, such as `pigeons/messages.dart`).
   This file defines data structures and API interfaces using Pigeon annotations
   like `@HostApi` and `@FlutterApi`.

2. **Generate the code:**
   Run the Pigeon generator tool, which parses your definition file and produces
   the necessary code for both Dart and your target native platforms:

   ```bash
   dart run pigeon --input pigeons/messages.dart
   ```

   :::note
   If you use Pigeon with native interop, set
   `swiftOptions: SwiftOptions(useFfi: true)` and
   `kotlinOptions: KotlinOptions(useJni: true)` in the `@ConfigurePigeon`
   section of your schema.
   For complete prerequisites and build configuration,
   refer to the [Pigeon native interop guide][pigeon-native-guide].
   :::

3. **Implement the native interface:**
   Implement the generated native interfaces in your host project (Swift,
   Kotlin, Java, or C++) and register them with the Flutter engine.

4. **Call the API from Flutter:**
   Call the generated Dart classes from your Flutter application,
   or invoke the generated native APIs to call back into your Dart code.

If you need to modify the API, update the definition file,
regenerate the code, and then update your implementation.

## Examples

To explore implementations of this flow, including Dart definitions,
generated code, and native implementations, consult:

* [Pigeon example app in the flutter/packages repository][pigeon-example]
* [Flutter native interop demos repository][native-interop-demos]

## Constraints and limitations

### High-frequency data

For specialized use cases requiring direct manipulation of raw native pointers
or manual C/C++ memory management, use
[FFIgen](/platform-integration/interop/ffigen) or
[JNIgen](/platform-integration/interop/jnigen) instead.

### Inheritance

Pigeon does not support complex inheritance across data models.
Flatten your data models where possible.

### Error handling

* **Platform channels:** For `@async` methods, native code must return errors
  through the provided callback handler.
* **Native bindings (FFI/JNI):** Throw native errors directly using standard
  language features (`throw` in Swift `async throws` methods,
  or throw exceptions in Kotlin `suspend` functions).

## Resources

* [Pigeon package on pub.dev][pigeon-pub]
* [Pigeon source code on GitHub][pigeon-source]
* [Pigeon native interop guide][pigeon-native-guide]
* [Flutter native interop demos][native-interop-demos]

[pigeon-pub]: https://pub.dev/packages/pigeon
[pigeon-source]: https://github.com/flutter/packages/tree/main/packages/pigeon
[pigeon-example]: https://github.com/flutter/packages/tree/main/packages/pigeon/example
[pigeon-native-guide]: https://github.com/flutter/packages/blob/main/packages/pigeon/native_interop_guide.md
[native-interop-demos]: https://github.com/flutter/demos/tree/main/native_interop_demos
