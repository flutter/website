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
Choose the build flags that match the target runtime and metric under test:

- **CPU, frame, and memory profiling (`--profile`)**:
  Run `flutter run -d chrome --profile` (or add `--wasm` to profile a
  WebAssembly build).
  For a deployable profile bundle, run `flutter build web --profile` (or
  `flutter build web --wasm --profile`).
  In Wasm profile builds, `dart2wasm` compiles with `-O2` optimizations and
  passes `--no-strip-wasm` so Wasm function names and WasmGC type names remain
  readable in Chrome DevTools flame charts and heap snapshots.
- **Network transfer and cold-start size (`--release`)**:
  Build with `flutter build web` or `flutter build web --wasm` (release mode is
  the default).
  Release builds minify JavaScript and strip symbol names from
  `main.dart.wasm`, giving accurate compressed and uncompressed download sizes.
  To preserve readable stack traces in a Wasm staging build, pass
  `--no-strip-wasm` (expect an approximate 47% increase in `.wasm` binary size).

```console
# Launch in Chrome for interactive performance profiling (JS or Wasm):
flutter run -d chrome --profile
flutter run -d chrome --wasm --profile

# Build a stripped Wasm production bundle to measure download size:
flutter build web --wasm
```

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

Use Chrome DevTools to measure [Core Web Vitals][] under realistic network and
CPU conditions:

1.  Serve the built app (or staging URL) and open it in a Chrome **Incognito**
    or **Guest** window so browser extensions don't skew CPU timings or inject
    DOM nodes.
1.  Open Chrome DevTools and select the **Performance** panel to open the live
    metrics screen.
1.  To simulate target devices, set **CPU** to **4x slowdown** and **Network**
    to **Fast 4G**.
1.  To profile startup, click **Record and reload**.
    To inspect responsiveness and layout stability, record a trace while you
    interact with the page.

### Largest Contentful Paint (LCP ≤ 2.5 s)

- In full-page CanvasKit and `skwasm` apps, Chrome often attributes LCP to the
  host HTML loading element (or the initial canvas surface) rather than internal
  Flutter widgets painted onto the canvas.
- Pair the browser's LCP value with a User Timing mark recorded on the first
  Flutter frame (`window.performance.mark('flutter_first_frame')`; refer to
  [Measure startup and frame milestones][wasm-user-timing]).
- Expand the **Network** track in the recorded trace to verify that
  `flutter_bootstrap.js`, the rendering engine (`skwasm.wasm` or
  `canvaskit.wasm`), and the compiled app (`main.dart.wasm` or `main.dart.js`)
  download in parallel without sequential waterfalls.
  To eliminate bootstrap round-trips, refer to
  [Reduce cold-start latency][cold-start].

### Interaction to Next Paint (INP ≤ 200 ms)

- Interact with key flows in your app (clicking controls and typing) while
  watching the **Interactions** log on the live metrics screen.
- Record a trace around slow interactions and inspect the **Main** thread
  (plus `skwasm` worker threads when cross-origin isolation is active).
- Look for long tasks exceeding 50 ms, expensive synchronous layout or shader
  compilation spikes, or V8 `Minor GC` and `Major GC` pauses.

### Cumulative Layout Shift (CLS ≤ 0.1)

- Check the **Layout shifts** log on the live metrics screen during initial load
  and view transitions.
- Verify that removing the HTML loading indicator or mounting embedded Flutter
  views with `addView()` doesn't shift surrounding DOM content.
- For host container sizing rules that prevent layout shifts on embedded pages,
  refer to [Prevent Cumulative Layout Shift (CLS)][prevent-cls].

## Inspect Wasm module size and memory footprint {:#inspect-wasm-footprint}

Use the Chrome DevTools **Network** and **Memory** panels to audit both download
weight and runtime memory usage:

### Network transfer and binary footprint

1.  Build a stripped release bundle (`flutter build web --wasm`) and serve
    `build/web` over HTTP with Brotli (`br`) or Gzip (`gzip`) compression
    enabled.
1.  Open Chrome DevTools and select the **Network** panel.
1.  Select the **Disable cache** checkbox, and then click the **Wasm** filter.
1.  Reload the page and inspect the **Size** column for both `main.dart.wasm`
    (compiled Dart code) and `skwasm.wasm` (the rendering engine).
    With **Big request rows** enabled in **Network settings**, the top value
    shows compressed bytes transferred over the wire and the bottom value shows
    uncompressed resource size.
1.  To inspect payloads loaded from `assets/**`—such as bundled fonts,
    `AssetManifest.bin`, and images—click **All** (or **Font** and **Img**).
    To reduce initial download size, consult
    [Measuring app size][app-size] and consider splitting routes with the
    `--enable-wasm-deferred-loading` flag (refer to
    [Reduce cold-start latency][cold-start]).

### Runtime WasmGC and engine memory

1.  Run or serve the app with the `--profile` flag
    (or `flutter build web --wasm --no-strip-wasm`)
    so Dart class and type names are retained.
1.  Open Chrome DevTools, select the **Memory** panel, select **Heap snapshot**,
    and click **Take snapshot**.
1.  Inspect two distinct memory regions used by Flutter Wasm apps:
    - **Dart WasmGC objects**:
      Managed directly on the V8 garbage-collected heap alongside JavaScript
      objects.
      Filter by Dart class names in the snapshot **Summary** view (or compare
      two snapshots in the **Comparison** view) to spot retained state or leaks.
    - **Engine linear memory (`WebAssembly.Memory`)**:
      Allocated by `skwasm` for native C++ rendering structures, surfaces, and
      raster caches, visible under `JSArrayBufferData` / `WebAssembly.Memory`
      entries.

[app-size]: /perf/app-size
[Chrome DevTools Performance panel]: https://developer.chrome.com/docs/devtools/performance
[cold-start]: /deployment/web#reduce-cold-start-latency
[Core Web Vitals]: https://web.dev/articles/vitals
[`debugProfileBuildsEnabled`]: {{site.api}}/flutter/widgets/debugProfileBuildsEnabled.html
[`debugProfileBuildsEnabledUserWidgets`]: {{site.api}}/flutter/widgets/debugProfileBuildsEnabledUserWidgets.html
[`debugProfileLayoutsEnabled`]: {{site.api}}/flutter/rendering/debugProfileLayoutsEnabled.html
[`debugProfilePaintsEnabled`]: {{site.api}}/flutter/rendering/debugProfilePaintsEnabled.html
[prevent-cls]: /platform-integration/web/embedding-flutter-web#prevent-cls
[profile mode]: /testing/build-modes#profile
[start recording]: https://developer.chrome.com/docs/devtools/performance/#record
[`Timeline`]: {{site.api}}/flutter/dart-developer/Timeline-class.html
[`TimelineTask`]: {{site.api}}/flutter/dart-developer/TimelineTask-class.html
[wasm-user-timing]: /platform-integration/web/wasm#record-startup-and-frame-milestones
