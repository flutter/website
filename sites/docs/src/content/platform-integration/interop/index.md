---
title: Native interop
description: Learn about the options to call platform-specific code in your app.
---

Flutter apps run on multiple platforms,
but sometimes you need to communicate directly
with the host operating system or run code from an existing native library.

To solve this, Flutter provides several interop tools ranging from
code generators to direct FFI bindings.

Use the following decision tree to choose your interop solution,
or read on to learn about the native interop layers.

## Choose your interop solution

```mermaid
flowchart TD
    Start(["Step 1: What is your primary goal?"]) --> GoalA["Goal A: Platform integration<br>(Swift, Kotlin, Java, Obj-C)"]
    Start --> GoalB["Goal B: C-ABI wrapping<br>(C, C++, Rust, Go)"]
    Start --> GoalC["Goal C: Pure Dart package<br>(No Flutter framework)"]

    GoalB --> FFIgen["Use FFIgen<br>(or Flutter Rust Bridge)"]:::directNode
    GoalC --> Direct["Use FFIgen or JNIgen"]:::directNode

    GoalA --> EvalPigeon{"Step 2: Do high-complexity<br>constraints apply?"}
    EvalPigeon -->|"No (most common)"| Pigeon["Use Pigeon<br>(Recommended default)"]:::recommendedNode
    EvalPigeon -->|"Yes (advanced)"| DirectInterop["Use FFIgen or JNIgen"]:::directNode

    classDef recommendedNode stroke:#1e8e3e,stroke-width:2px;
    classDef directNode stroke:#1a73e8,stroke-width:2px;
```

---

Follow the steps below to walk through the decision tree in detail:

### Step 1: Determine your primary goal

- **Goal A: Platform integration.**
  Communicate with native OS features (Swift, Kotlin, Java, or Objective-C)
  or expose an API surface.
  Proceed to [Step 2: Evaluate Pigeon for Flutter plugins](#step-2-evaluate-pigeon-for-flutter-plugins).
- **Goal B: C-ABI wrapping.**
  Wrap an existing native library (C, C++, Rust, or Go).
  Use [FFIgen](/platform-integration/interop/ffigen)
  (or [Flutter Rust Bridge][frb] for Rust).
- **Goal C: Pure Dart package.**
  Build a Dart CLI tool without Flutter framework dependencies.
  Use [FFIgen](/platform-integration/interop/ffigen) or
  [JNIgen](/platform-integration/interop/jnigen).

### Step 2: Evaluate Pigeon for Flutter plugins

If you are building a Flutter plugin,
first verify whether [Pigeon](/platform-integration/interop/pigeon) satisfies
your technical constraints.

:::important
Migrating a plugin between Pigeon and FFIgen or JNIgen is non-trivial.
Choose your interop solution carefully based on your initial project
constraints.
:::

Do any of the following requirements apply to your feature?

- Your app processes high-frequency raw data (for example, video processing).
- Your integration requires advanced language bridging
  (for example, cross-language subclasses, delegates, or proxies).
- Your feature requires manual memory management and multithreading over
  guardrails.
- Your target language is C, C++, Rust, or Go.

- **No (most common): Use [Pigeon](/platform-integration/interop/pigeon).**
  This is the default, recommended path.
  It provides necessary guardrails, creates easily digestible interface
  mappings, and is highly efficient for most API surface areas.
- **Yes: Use [FFIgen](/platform-integration/interop/ffigen) or
  [JNIgen](/platform-integration/interop/jnigen).**
  You need the flexibility, complexity, and performance of direct interop for
  larger surface areas.

:::note
Directly using FFIgen and JNIgen introduces potential pitfalls,
particularly around threading and memory management.
Pigeon is generally recommended because it has fewer potential pitfalls
and provides safer guardrails.
:::

## Package your interop code

Depending on how you plan to share your code,
choose the option that best suits your use case.

:::note
To learn about the difference between a package and a plugin,
refer to [Using packages](/packages-and-plugins/using-packages).
:::

- **In-app integration.**
  Write your native interop code directly inside your Flutter app without
  creating a separate package.
- **Plugin.**
  A specialized package that makes native platform functionality (such as a
  device's camera or sensors) available to your app
  (`flutter create --template=plugin`).
  For more details, refer to
  [Developing plugin packages](/packages-and-plugins/developing-packages#plugin).
- **FFI package.**
  A package that compiles and bundles native C or C++ code using Dart build
  hooks and [`dart:ffi`](/platform-integration/interop/dart-ffi).
  This template also includes an `ffigen.yaml` configuration file to regenerate
  Dart bindings (`flutter create --template=package_ffi`).
  For more details, refer to
  [Developing FFI packages](/packages-and-plugins/developing-packages#ffi).

:::note
If you're using pre-compiled binaries (such as `.so` files on Android or
`.dylib` files on iOS and macOS), use `CodeAsset` in your `hook/build.dart`
script to bundle them into your package.
:::

For more details on package authoring,
refer to [Developing packages and plugins](/packages-and-plugins/developing-packages).

## Tool comparison

The following table compares the two interop approaches across target
languages:

- **Direct interop:** Lower-level direct bindings with higher performance for
  large data; requires manual memory and threading management.
- **Pigeon:** Structured, type-safe code generator; recommended default for
  Flutter plugins.

| Target language | Direct interop | Pigeon |
| --- | --- | --- |
| **C** | [FFIgen](/platform-integration/interop/ffigen) | Not recommended. Supported with platform channels, but not maintained by the Flutter team. |
| **C++ with `extern "C"`** | [FFIgen](/platform-integration/interop/ffigen) | (Refer to C) |
| **C++ without `extern "C"`** | FFIgen (not yet supported) | Supported with platform channels, but not maintained by the Flutter team. |
| **Rust with `extern "C"`** | [FFIgen](/platform-integration/interop/ffigen) | (Refer to C) |
| **Rust without `extern "C"`** | [Flutter Rust Bridge][frb] | Not supported |
| **Go with `extern "C"`** | [FFIgen](/platform-integration/interop/ffigen) | (Refer to C) |
| **Go without `extern "C"`** | Not supported | Not supported |
| **Java** | [JNIgen](/platform-integration/interop/jnigen) | Supported through Kotlin |
| **Kotlin** | [JNIgen](/platform-integration/interop/jnigen) | Supported (recommended) |
| **Objective-C** | [FFIgen](/platform-integration/interop/ffigen) | Supported through Swift |
| **Swift without Obj-C compatibility annotations** | [`package:swiftgen`][swiftgen-pub] (experimental) | Supported (recommended) |

## Understand interop layers

Dart structures native interop into three distinct layers:
low-level bindings, idiomatic Dart APIs, and framework-specific plugins.

For complete architectural details,
consult the [native interop layers guide][interop-layers].

### Layer 1: Low-level bindings

Layer 1 consists of thin, high-performance, and unopinionated wrappers around
native code (for example, [`dart:ffi`](/platform-integration/interop/dart-ffi),
`dart:js_interop`, [FFIgen](/platform-integration/interop/ffigen),
and [JNIgen](/platform-integration/interop/jnigen)).
These APIs mirror native signatures closely,
but require manual memory and threading management.

### Layer 2: Idiomatic Dart APIs

Layer 2 consists of idiomatic Dart APIs that wrap the low-level layer to hide
platform-specific complexities (for example,
[Pigeon](/platform-integration/interop/pigeon) or the
[`sqlite3` package][sqlite3-pub]).
These manage concurrency, memory lifetimes, and data conversions automatically.

### Layer 3: Framework-specific plugins

Layer 3 provides integration with framework-specific APIs (for example, the
Flutter Plugin API).
This layer exposes Dart APIs to the framework while hiding platform details
like Android's `Context` or iOS's application lifecycle.

[frb]: {{site.pub-pkg}}/flutter_rust_bridge
[swiftgen-pub]: {{site.pub-pkg}}/swiftgen
[sqlite3-pub]: {{site.pub-pkg}}/sqlite3
[interop-layers]: https://github.com/dart-lang/native/blob/main/doc/interop-layers.md
