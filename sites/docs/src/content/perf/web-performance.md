---
title: Debug performance for web apps
description: >-
  Learn how to profile Flutter web and WebAssembly apps, measure Core Web
  Vitals, and inspect Wasm footprint in Chrome DevTools.
---

The Flutter framework emits timeline events as it builds frames,
draws scenes, and tracks runtime activity such as garbage collections.
These events appear directly in the
[Chrome DevTools Performance panel][] for profiling and debugging.

:::note
To learn more about optimizing initial load times,
read the Flutter blog post
[Best practices for optimizing Flutter web loading speed][article].

[article]: {{site.flutter-blog}}/best-practices-for-optimizing-flutter-web-loading-speed-7cc0df14ce5c
:::

To emit custom timeline events from Dart code, use the `dart:developer`
[`Timeline`][] and [`TimelineTask`][] APIs, or record browser-level marks with
the `window.performance` property (refer to
[Measure startup and frame milestones][wasm-user-timing]).

![Screenshot of the Chrome DevTools performance panel](/assets/images/docs/tools/devtools/chrome-devtools-performance-panel.png)

## Build and run in profile mode {:#build-and-run-for-profiling}

Always evaluate runtime performance in [profile mode][] or release mode rather
than debug mode.
Choose the command that matches the metric under test:

| What to measure | Command | Notes |
| :--- | :--- | :--- |
| **CPU, frame rendering, and memory** | `flutter run -d chrome --profile` (add `--wasm` for WebAssembly) | Compiles with production optimizations (`-O2` for Wasm) while preserving symbol and WasmGC type names in traces and heap snapshots. |
| **Deployable profile bundle** | `flutter build web --profile` (add `--wasm` for WebAssembly) | Generates a static profile bundle in `build/web` for testing on staging hosts or target devices. |
| **Download size and cold-start load** | `flutter build web` or `flutter build web --wasm` | Builds a minified, symbol-stripped release bundle with production file sizes. |

{:.table .table-striped}

## Configure optional timeline flags {:#optional-flags-to-enhance-tracing}

To configure which widget and rendering timeline events are tracked, set any of
the following top-level properties to `true` in `main()` before profiling:

- [`debugProfileBuildsEnabled`][]:
  Adds `Timeline` events for every `Widget` built.
- [`debugProfileBuildsEnabledUserWidgets`][]:
  Adds `Timeline` events for every user-created `Widget` built.
- [`debugProfileLayoutsEnabled`][]:
  Adds `Timeline` events for every `RenderObject` layout.
- [`debugProfilePaintsEnabled`][]:
  Adds `Timeline` events for every `RenderObject` painted.

To capture a frame trace:

1.  Optional: Set the tracing flags that you want to track to `true` in
    `main()`.
1.  Launch the app in profile mode (`flutter run -d chrome --profile`, adding
    `--wasm` for WebAssembly builds).
1.  Open the [Chrome DevTools Performance panel][] and
    [record a runtime trace][start recording] while reproducing the interaction.

## Profile Core Web Vitals (LCP, INP, and CLS) {:#profile-core-web-vitals}

Record a trace in the [Chrome DevTools Performance panel][] to evaluate
[Core Web Vitals][] and inspect Flutter-specific rendering behavior:

- **Largest Contentful Paint (LCP)**:
  In full-page Flutter web apps, Chrome often attributes LCP to the host HTML
  loading element (or initial canvas surface) rather than internal Flutter
  widgets.
  - Record a User Timing mark on the first Flutter frame to measure actual app
    readiness (refer to
    [Measure startup and frame milestones][wasm-user-timing]).
  - Verify that `flutter_bootstrap.js`, Flutter's rendering engine, and
    `main.dart.wasm` (or `main.dart.js`) download in parallel without waterfalls
    (refer to [Reduce cold-start latency][cold-start]).
- **Interaction to Next Paint (INP)**:
  Inspect the **Main** thread (plus WebAssembly worker threads when
  cross-origin isolation is active) around slow interactions for long tasks,
  synchronous layout or shader compilation spikes, or V8 garbage-collection
  pauses.
- **Cumulative Layout Shift (CLS)**:
  Verify that removing the HTML loading indicator or mounting embedded Flutter
  views with `addView()` doesn't shift surrounding DOM content (refer to
  [Prevent Cumulative Layout Shift (CLS)][prevent-cls]).

## Inspect Wasm module size and memory footprint {:#inspect-wasm-footprint}

For general `dart2wasm` size and WasmGC heap profiling steps in Chrome
DevTools, refer to [Profile Wasm performance and footprint][dart-wasm-profile].
In a Flutter Wasm app, also check the following Flutter-specific artifacts:

- **Bundle and asset payloads**:
  Build a stripped release bundle (`flutter build web --wasm`) and inspect
  `main.dart.wasm`, Flutter's rendering engine `.wasm` binary, and `assets/**`
  in the [Chrome DevTools Network panel][].
  To reduce initial download size, refer to [Measuring app size][app-size] and
  [Reduce cold-start latency][cold-start] (`--enable-wasm-deferred-loading`).
- **Engine and WasmGC memory**:
  Run with `--profile` (or `flutter build web --wasm --no-strip-wasm`) when
  [recording heap snapshots][] to inspect both Dart WasmGC objects on the V8
  heap and `WebAssembly.Memory` linear memory allocated by Flutter's rendering
  engine.

[app-size]: /perf/app-size
[Chrome DevTools Network panel]: https://developer.chrome.com/docs/devtools/network
[Chrome DevTools Performance panel]: https://developer.chrome.com/docs/devtools/performance
[cold-start]: /deployment/web#reduce-cold-start-latency
[Core Web Vitals]: https://web.dev/articles/vitals
[dart-wasm-profile]: {{site.dart-site}}/web/wasm#profile-wasm
[`debugProfileBuildsEnabled`]: {{site.api}}/flutter/widgets/debugProfileBuildsEnabled.html
[`debugProfileBuildsEnabledUserWidgets`]: {{site.api}}/flutter/widgets/debugProfileBuildsEnabledUserWidgets.html
[`debugProfileLayoutsEnabled`]: {{site.api}}/flutter/rendering/debugProfileLayoutsEnabled.html
[`debugProfilePaintsEnabled`]: {{site.api}}/flutter/rendering/debugProfilePaintsEnabled.html
[prevent-cls]: /platform-integration/web/embedding-flutter-web#prevent-cls
[profile mode]: /testing/build-modes#profile
[recording heap snapshots]: https://developer.chrome.com/docs/devtools/memory-problems/heap-snapshots
[start recording]: https://developer.chrome.com/docs/devtools/performance/#record
[`Timeline`]: {{site.api}}/flutter/dart-developer/Timeline-class.html
[`TimelineTask`]: {{site.api}}/flutter/dart-developer/TimelineTask-class.html
[wasm-user-timing]: /platform-integration/web/wasm#record-startup-and-frame-milestones
