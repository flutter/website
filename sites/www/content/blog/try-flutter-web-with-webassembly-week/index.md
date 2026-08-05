---
title: "Try Flutter Web with WebAssembly Week"
description: >-
  Unlock up to 2x to 5x faster web performance by opting into Wasm compilation today
publishDate: 2026-08-17
author: kevmoo
image: images/header_placeholder.webp
category: event
layout: blog
---

<!-- TODO(graphics): Replace with finalized banner artwork featuring Dash and WebAssembly branding -->
<DashImage figure src="images/header_placeholder.webp" alt="Dash celebrating Try Flutter Web with WebAssembly Week" caption="Welcome to Try Flutter Web with WebAssembly Week" />

Flutter lets you build expressive, multi-platform apps for the web from a
single codebase. Whether you're building a dashboard, a tool for your team, or
a full web application, Flutter Web gives you the power to bring your app to
any browser.

From August 17 to August 21, we're hosting **Try Flutter Web with WebAssembly
Week**! Throughout the week, Dart and Flutter engineers will triage incoming
issues in real time to help unblock migrations, and our developer relations team
will share your wins across community channels.

---

## WebAssembly in Flutter Web

We stabilized WebAssembly (Wasm) support in Flutter 3.22 back in May 2024 by
pairing the Dart compiler with WebAssembly Garbage Collection (WasmGC).

Since then, Wasm compilation has proven itself on real-world apps. For
example, **Dart DevTools** (`dartdevtools`)—a complex, highly interactive
Flutter web app—has shipped with WebAssembly by default since late 2024.
Today, over 97% of developers using DevTools run it on Wasm, benefiting from
smooth UI inspection, fast loading, and rock-solid stability.

Wasm compilation is battle-tested and production-ready. In fact, our analysis
shows that **over 58% of existing Flutter web apps compile to WebAssembly
today with zero code changes**.

When you compile to WebAssembly, your app can unlock huge performance gains:

> [!WARNING]
> **🚧 EDITORIAL HOLD / NEEDS REAL-WORLD VALIDATION 🚧**
> 
> *The performance multipliers below come from internal micro-benchmarks
> (Golem and LUCI). Because micro-benchmarks don't always match real-world
> apps, validate these figures against production applications and frame them
> with "up to" caveats before public release:*
>
> *   ⚡ **Up to 5x faster app load times**: Drastically reduces initial
>     loading and Time-to-Interactive (TTI).
> *   ⚡ **Up to 2x faster execution speed**: Powered by `dart2wasm` and
>     native WasmGC execution.
> *   ⚡ **Up to 3–4x faster UI rendering**: Reduces frame build times and
>     delivers smooth 60–120 FPS performance.
> *   📦 **Minimal bundle size change**: Adds only ~1.5% on average to
>     compressed bundle sizes.
>
> **🚧 END EDITORIAL HOLD 🚧**

<!-- TODO(graphics): Insert side-by-side performance chart, GIF, or bouncing.web.app framerate comparison visual using validated production metrics -->
<DashImage figure src="images/perf_comparison_placeholder.webp" alt="WebAssembly versus JavaScript framerate and startup performance comparison" caption="WasmGC benchmarks demonstrate substantial gains in startup speed, runtime throughput, and UI rendering framerates over legacy dart2js." />

---

## Why JavaScript is still the default compiler target

If Wasm delivers better speed and stability, why does `flutter build web`
still default to JavaScript (`dart2js`)?

Changing the default compiler for millions of developers is a big move. While
over half of Flutter web apps build with Wasm out of the box, some `pub.dev`
packages still rely on legacy JavaScript interop (`dart:html` or `dart:js`)
that needs to be updated for Wasm compatibility.

This creates a classic chicken-and-egg dilemma:
* We can't make `--wasm` the default until more ecosystem packages update
  their JS interop code.
* Package authors often don't prioritize updating until developers opt in to
  Wasm and request Wasm support.

---

## WebAssembly migration resources

To help you migrate, we've updated our web documentation. Check out these
guides before building:

*   **[WebAssembly on Flutter Web](https://docs.flutter.dev/platform-integration/web/wasm)**:
    Learn how to set server headers (`COEP: credentialless` and `COOP:
    same-origin`), debug production builds, and detect Wasm support at runtime.
*   **[Migrating to `package:web` and modern JS interop](https://dart.dev/interop/js-interop)**:
    Moving away from `dart:html` and `dart:js` is key for Wasm compatibility.
    This guide shows how to migrate to `package:web` and `dart:js_interop`.
*   **[Web building and deployment guide](https://docs.flutter.dev/deployment/web)**:
    Find instructions for release builds, source maps, Firebase Hosting, and CDN
    caching.
*   **[Flutter web technical FAQ](https://docs.flutter.dev/platform-integration/web/faq)**:
    Get answers about web workers, service workers, and conditional imports.

---

## Try WebAssembly this week

Whether you maintain a `pub.dev` package, manage a production web app, or
build side projects, test your code with WebAssembly this week!

### How to get started
1.  **Upgrade to Flutter 3.47:** Run `flutter upgrade` to ensure you're on
    the latest stable release with our newest WasmGC optimizations and runtime
    fixes.
2.  **Build with Wasm:** Run `flutter build web --wasm` in your project
    terminal.
3.  **Report any blockers:** If you run into package dependencies or runtime
    issues, let us know! File a report at
    👉 **[https://goo.gle/flutter-wasm-feedback](https://goo.gle/flutter-wasm-feedback)**
    so our engineers can help unblock migration.
5.  **Share your wins:** If your app builds cleanly and runs faster, tell us!
   Share your before-and-after metrics or framerate gains at
    👉 **[https://goo.gle/flutter-web-wasm-win](https://goo.gle/flutter-web-wasm-win)**.

When posting on social media, use **`#FlutterWasmWeek`** so we can feature
your results!

---

## Building a Wasm-by-default web future

By testing your apps and resolving package dependencies together this week,
we can pave the way to making **WebAssembly the default compiler for Flutter
Web**.

Run `flutter upgrade`, try `flutter build web --wasm`, and let us know how it
goes!
