---
title: Writing custom platform-specific code
shortTitle: Platform-specific code
description: Learn how about the options to call platform specific code in your app.
---

## Overview

Flutter and Dart provide multiple options for using platform-specific code
to access system APIs or leverage existing native SDKs.
These options range from low-level direct interop
requiring knowledge of Dart and the host language,
to high-level messaging paradigms
that abstract the details of the host platform.

## Plugins

We recommend checking [pub.dev](https://pub.dev) first
to see if a package or plugin already exists.
Using an existing plugin saves time, effort, and boilerplate.
If no plugin exists,
you can build a custom solution using one of the following approaches.

## Custom solutions

If a package does not support your desired feature on pub.dev,
or if you have custom integration requirements,
you can write platform-specific code.

Dart and Flutter support two primary architectures for custom integrations.

:::note 
Neither solution below is inherently better or worse than existing plugins,
because all plugins use one of the following two options. 
:::

### Direct native interop (FFI or JNI)

Direct native interop executes synchronously directly in memory.
This approach compiles the binding into your Dart executable
and executes native code on the UI thread.

To create compilation bindings automatically,
use generator tools like [`ffigen`](https://pub.dev/packages/ffigen)
(for C, Objective-C, and Swift)
or [`jnigen`](https://pub.dev/packages/jnigen) (for Java and Kotlin on Android).

For advanced or custom cases where automated generators do not fit,
you can write manual binding code using `dart:ffi`.

### Method channels

Message passing uses asynchronous communication
that serializes data across a platform bridge.

We recommend using [`pigeon`](https://pub.dev/packages/pigeon)
to generate structured, type-safe channel code
and handle serialization automatically.

If Pigeon does not support your use case,
you can write manual `MethodChannel` code
to serialize and pass data yourself.

---

## Choose an approach

Selecting an approach depends on your familiarity with the host languages,
comfort with low-level details (like memory management),
and the layout of the API you want to cover.

### I need to access a few native-code functions

Use **direct native interop** (`ffigen` or `jnigen`).
Creating a complete plugin wrapper for a few discrete functions
introduces unnecessary overhead.

### I need to implement the same interface on iOS and Android

Use **type-safe platform channels** with `pigeon`.

### I need to re-implement a full native API in Dart

Consider using **Pigeon** augmented by **`ffigen`/`jnigen`**.
