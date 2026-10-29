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

Select your goals and constraints in the following interactive guide to find
the recommended interop tool for your project, or click **Show all paths** to
compare every option at once:

<DecisionTree title="Choose your interop solution">
steps:
  - id: primary-goal
    question: What is your primary goal?
    description: >-
      Choose the option that best matches the native code you want to call
      and how your Dart or Flutter project is structured.
    options:
      - label: "Goal A: Platform integration"
        subtitle: >-
          Communicate with native OS features (Swift, Kotlin, Java, or
          Objective-C) or expose an API surface.
        icon: devices
        next_step: complexity-constraints
      - label: "Goal B: C-ABI wrapping"
        subtitle: >-
          Wrap an existing native library written in C, C++, Rust, or Go.
        icon: memory
        recommendation: c-abi-wrapping
      - label: "Goal C: Pure Dart package"
        subtitle: >-
          Build a Dart CLI tool or package without Flutter framework
          dependencies.
        icon: terminal
        recommendation: pure-dart
  # Step 2: Evaluate high-complexity constraints for platform integration.
  - id: complexity-constraints
    question: Do high-complexity constraints apply?
    description: >-
      If you're building a Flutter plugin, first verify whether
      [Pigeon](/interop/pigeon) satisfies your technical constraints.
      Do any of the following requirements apply to your feature?
    checklist:
      - >-
        Your app processes high-frequency raw data
        (for example, video processing).
      - >-
        Your integration requires advanced language bridging
        (for example, cross-language subclasses, delegates, or proxies).
      - >-
        Your feature requires manual memory management and multithreading
        over guardrails.
      - Your target language is C, C++, Rust, or Go.
    callout:
      type: important
      title: Important
      content: >-
        Migrating a plugin between Pigeon and FFIgen or JNIgen is non-trivial
        because the glue code lives in different languages. Evaluate your
        plugin's constraints carefully before choosing between them.
    options:
      - label: "No (most common)"
        subtitle: >-
          None of these high-complexity requirements apply to my plugin or app.
        icon: verified
        recommendation: pigeon
      - label: "Yes (advanced)"
        subtitle: >-
          One or more of these requirements apply; I need direct native
          bindings.
        icon: tune
        recommendation: direct-platform-interop
# Recommendations
recommendations:
  - id: pigeon
    title: Use Pigeon (Recommended default)
    icon: recommend
    description: >-
      **[Pigeon](/interop/pigeon)** is the default, recommended path for
      platform integration. It provides necessary guardrails, creates easily
      digestible interface mappings, and is highly efficient for most API
      surface areas.
    link: /interop/pigeon
    link_text: Learn about Pigeon
  - id: direct-platform-interop
    title: Use FFIgen or JNIgen
    icon: bolt
    description: >-
      Use **[FFIgen](/interop/ffigen)** (for C, Objective-C, or Swift) or
      **[JNIgen](/interop/jnigen)** (for Java or Kotlin) when you need the
      flexibility, complexity, and performance of direct interop for larger
      surface areas.
    callout:
      type: note
      title: Note
      content: >-
        Directly using FFIgen and JNIgen introduces potential pitfalls,
        particularly around threading and memory management. Pigeon is
        generally recommended because it has fewer potential pitfalls and
        provides safer guardrails.
    link: /interop/ffigen
    link_text: Explore FFIgen
  - id: c-abi-wrapping
    title: Use FFIgen (or Flutter Rust Bridge)
    icon: memory
    description: >-
      Use **[FFIgen](/interop/ffigen)** to generate Dart FFI bindings for
      existing C, C++, or Go libraries (or
      **[Flutter Rust Bridge]({{site.pub-pkg}}/flutter_rust_bridge)** when
      wrapping Rust libraries without `extern "C"`).
    link: /interop/ffigen
    link_text: Explore FFIgen
  - id: pure-dart
    title: Use FFIgen or JNIgen
    icon: terminal
    description: >-
      For pure Dart packages and CLI tools without Flutter framework
      dependencies, use **[FFIgen](/interop/ffigen)** (for C and Objective-C
      libraries) or **[JNIgen](/interop/jnigen)** (for Java and Kotlin
      libraries).
    link: /interop/ffigen
    link_text: Explore FFIgen
</DecisionTree>

## Package your interop code

Depending on how you plan to share your code,
choose the option that best suits your use case.
To learn about the difference between a [package](/resources/glossary#package)
and a [plugin](/resources/glossary#plugin),
refer to the [Flutter glossary](/resources/glossary).

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
  A package that compiles and bundles native C or C++ code (or pre-compiled
  binaries) using [Dart build hooks](/interop/bind-native-code) and
  [`dart:ffi`](/interop/dart-ffi).
  This template also includes an FFIgen configuration to regenerate
  Dart bindings (`flutter create --template=package_ffi`).
  For more details, refer to
  [Developing FFI packages](/packages-and-plugins/developing-packages#ffi).

For more details on package authoring,
refer to [Developing packages and plugins](/packages-and-plugins/developing-packages).

## Tool comparison

The following table compares two interop solutions:

- **Direct interop:** Lower-level direct bindings with higher performance for
  large data; requires manual memory and threading management.
- **Pigeon:** Structured, type-safe code generator; recommended default for
  Flutter plugins.

| Target language | Direct interop | Pigeon |
| --- | --- | --- |
| **C** | [FFIgen](/interop/ffigen) | Supported on Linux (GObject) with platform channels |
| **C++ with `extern "C"`** | [FFIgen](/interop/ffigen) | Supported on Windows with platform channels |
| **C++ without `extern "C"`** | FFIgen (not yet supported) | Supported on Windows with platform channels |
| **Rust with `extern "C"`** | [FFIgen](/interop/ffigen) | Not supported directly |
| **Rust without `extern "C"`** | [Flutter Rust Bridge][frb] | Not supported |
| **Go with `extern "C"`** | [FFIgen](/interop/ffigen) | Not supported directly |
| **Go without `extern "C"`** | Not supported | Not supported |
| **Java** | [JNIgen](/interop/jnigen) | Supported through Kotlin (native interop) or directly with platform channels |
| **Kotlin** | [JNIgen](/interop/jnigen) | Supported (recommended) |
| **Objective-C** | [FFIgen](/interop/ffigen) | Supported through Swift (native interop) or directly with platform channels |
| **Swift without Obj-C compatibility annotations** | [`package:swiftgen`][swiftgen-pub] (experimental) | Supported (recommended) |

{:.table .table-striped}

## Understand interop layers

Dart structures native interop into three distinct layers:
low-level bindings, idiomatic Dart APIs, and framework-specific plugins.

For complete architectural details,
consult the [native interop layers guide][interop-layers].

### Layer 1: Low-level bindings

Layer 1 consists of thin, high-performance, and unopinionated wrappers around
native code (for example, [`dart:ffi`](/interop/dart-ffi),
`dart:js_interop`, [FFIgen](/interop/ffigen),
and [JNIgen](/interop/jnigen)).
These APIs mirror native signatures closely,
but require manual memory and threading management.

### Layer 2: Idiomatic Dart APIs

Layer 2 consists of idiomatic Dart APIs that wrap the low-level layer to hide
platform-specific complexities (for example,
[Pigeon](/interop/pigeon) or the
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
