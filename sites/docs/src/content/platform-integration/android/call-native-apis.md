---
title: "Calling Android APIs"
description: "How to call Android-specific APIs or native libraries from Flutter code."
---

<?code-excerpt path-base="platform_integration"?>

Flutter apps running on Android can always make use of the
latest APIs on the first day they are released on Android,
no matter what.

To choose the best integration model for your app,
first review the [Platform-specific options guide](/platform-integration/native-code-options).

## Native Android integrations

Once you have selected an integration architecture,
use the following resources to implement it on Android:

### Call Java or Kotlin code directly
To invoke standard Android APIs, Jetpack libraries, or custom JVM classes:
* Read our guide on using [jnigen to bind Java/Kotlin code](/platform-integration/android/jnigen).

### Call C or C++ NDK libraries directly
To execute low-level C libraries or native engine code:
* Read our guide on using [Dart FFI](/platform-integration/bind-native-code).

### Communicate using a message bridge
To build plugins or communicate asynchronously with platform-specific code:
* Use [Pigeon or manual MethodChannels](/platform-integration/platform-channels).
