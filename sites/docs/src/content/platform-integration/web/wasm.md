---
title: Support for WebAssembly (Wasm)
description: >-
  Current status of Flutter's support for WebAssembly (Wasm).
shortTitle: Wasm
last-update: Nov 9, 2026
---

Flutter and Dart support
[WebAssembly](https://webassembly.org/)
as a compilation target when building
applications for the web.

[`stable`]: {{site.repo.flutter}}/blob/master/docs/releases/Flutter-build-release-channels.md#stable
[`package:web`]: {{site.pub-pkg}}/web
[`dart:js_interop`]: {{site.dart.api}}/dart-js_interop/dart-js_interop-library.html

## Get started

To try a pre-built Flutter web app using Wasm, check out the
[Wonderous demo app](https://wonderous.app/web/).

To experiment with Wasm in your own apps, use the following steps.

### Switch to the latest version of Flutter

Switch to Flutter version 3.24 or higher
to run and compile Flutter applications to WebAssembly.
To ensure you are running the latest version, run `flutter upgrade`.

### Ensure that your app's dependencies are compatible

Try the default template [sample app][],
or choose any Flutter application
that has been migrated to be
[compatible with Wasm](#js-interop-wasm).

[sample app]: /reference/create-new-app

### Modify the index page

Make sure your app's `web/index.html` is updated to the latest
[Flutter web app initialization][] for Flutter 3.22 and later.

If you would like to use the default, delete the contents of the `web/`
directory and run the following command to regenerate them:

```console
$ flutter create . --platforms web
```

[Flutter web app initialization]: /platform-integration/web/initialization

### Run or build your app

To run the app with Wasm for development or testing,
use the `--wasm` flag with the `flutter run` command.

```console
$ flutter run -d chrome --wasm
```

To build a web application with Wasm, add the `--wasm` flag to
the existing `flutter build web` command.

```console
$ flutter build web --wasm
```

The command produces output into the `build/web` directory relative to the
package root, just like `flutter build web`.

:::note
Enabling Wasm compilation for a Flutter web app does not use deferred loading
by default. Deferred loading in Wasm is available in Flutter 3.50 and later and
can be enabled using the `--enable-wasm-deferred-loading` flag:

```console
$ flutter build web --wasm --enable-wasm-deferred-loading
```

To customize how deferred `.wasm` modules are downloaded at runtime, provide a
`wasmDeferredModulesLoader` callback in your [Flutter web app initialization][]
configuration.
:::

#### Wasm production debugging

By default, Wasm release builds strip debug symbols and omit source maps
to minimize binary size.

- **For error monitoring (recommended)**: Pass `--source-maps` to generate
  a `main.dart.wasm.map` file for symbolication in error tracking services.
  For security recommendations and deployment warnings, see
  [Source maps](/deployment/web#source-maps).
- **For staging or QA builds**: Pass `--no-strip-wasm` to preserve Wasm
  function names directly in browser console stack traces, at the cost of
  an approximate **47% increase** in Wasm binary size.

```console
# Generate source maps for production error tracking:
$ flutter build web --wasm --source-maps

# Preserve Wasm function names for staging/QA debugging:
$ flutter build web --wasm --no-strip-wasm
```

### Open the app in a compatible web browser
Even with the `--wasm` flag, Flutter will still compile the application to
JavaScript. If WasmGC support is not detected at runtime, the JavaScript output
is used so the application will continue to work in all major browsers.

You can verify whether the app is actually running with Wasm by checking for
the `dart2wasm` environment variable, set during compilation (preferred).

```dart
const isRunningWithWasm = bool.fromEnvironment('dart.tool.dart2wasm');
```

Alternatively, you can use differences in number representations
to test whether the native (Wasm) number representation is used.

```dart
final isRunningWithWasm = identical(double.nan, double.nan);
```

### Serve the built output with an HTTP server

Flutter web WebAssembly can use multiple threads to render your application
faster, with less jank. To do this, Flutter uses advanced browser features that
require specific HTTP response headers.

:::important
Flutter web applications compiled with WebAssembly won't run with multiple-threads
unless the server is configured to send specific HTTP headers.
:::

| Name | Value |
|-|-|
| `Cross-Origin-Embedder-Policy` | `credentialless` <br> or <br> `require-corp` |
| `Cross-Origin-Opener-Policy` | `same-origin` |

{:.table}

To learn more about these headers, check out
[Load cross-origin resources without CORP headers using COEP: credentialless][coep].
For production MIME types, pre-compression, cold-start optimization, and CDN
serving, refer to [Deploying WebAssembly in production][deploy-wasm].

[coep]: https://developer.chrome.com/blog/coep-credentialless-origin-trial
[deploy-wasm]: /deployment/web#deploy-webassembly-in-production

## Learn more about browser compatibility

In Flutter 3.50 and later, running a Flutter app compiled to Wasm (`dart2wasm` +
`skwasm`) requires a browser that supports three standardized WebAssembly
features:

- [WasmGC][] (Garbage Collection)
- [JS String Builtins][wasm-js-string] (`wasm:js-string`)
- [Phase 4 Exception Handling][wasm-eh] (`try_table` / `exnref`)

At startup, `flutter_bootstrap.js` probes the browser's WebAssembly engine for
these features and checks the `wasmAllowList` configuration before selecting the
Wasm build. When a browser does not support these features or is not enabled in
`wasmAllowList`, Flutter automatically falls back to the JavaScript (`dart2js`)
and CanvasKit build produced by `flutter build web --wasm`.

| Browser engine | Minimum version for Wasm | Default behavior in Flutter 3.50 (`--wasm`) | How to enable Wasm |
| :--- | :--- | :--- | :--- |
| **Chromium** (Chrome, Edge, Opera, Brave) | **137+** (Desktop & Android) | Runs `dart2wasm` + `skwasm` by default; Chrome `< 137` falls back to `dart2js` + CanvasKit. | Enabled by default (`wasmAllowList.blink: true`). |
| **WebKit** (Safari macOS & iOS, all iOS browsers) | **Safari 26.2+** (macOS & iOS 26.2+) | Falls back to `dart2js` + CanvasKit by default (`wasmAllowList.webkit: false`). | Set `wasmAllowList: { webkit: true }` in [Flutter web app initialization][]. Safari `<= 26.1` automatically falls back to `dart2js` + CanvasKit via runtime feature detection. |
| **Gecko** (Firefox) | **Firefox 147+** | Falls back to `dart2js` + CanvasKit by default (`wasmAllowList.gecko: false`). | Set `wasmAllowList: { gecko: true }` in [Flutter web app initialization][]. Firefox `< 147` automatically falls back to `dart2js` + CanvasKit. |

{:.table}

[WasmGC]: https://github.com/WebAssembly/gc/tree/main/proposals/gc
[wasm-js-string]: https://github.com/WebAssembly/js-string-builtins
[wasm-eh]: https://github.com/WebAssembly/exception-handling

## Using compatible JS interop libraries {:#js-interop-wasm}

To support compilation to Wasm, Dart has modernized
how it enables interop with browser and JavaScript APIs.
Legacy Dart SDK web and JS interop libraries (`dart:html`, `dart:js`,
`dart:js_util`, `dart:indexed_db`, `dart:svg`, `dart:web_audio`, and
`dart:web_gl`) are **deprecated and planned for removal from the Dart SDK in an
upcoming release**, and neither those libraries nor the deprecated `package:js`
package are supported when compiling to Wasm.

Instead, Dart provides lightweight interop solutions built around
static JS interop that work across both JavaScript and WebAssembly targets:

- [`package:web`][], which replaces `dart:html` (and other legacy web libraries)
- [`dart:js_interop`][], which replaces `package:js`, `dart:js`, and `dart:js_util`

For a detailed guide on migrating existing code,
see the [`package:web` migration guide][].

When compiling to Wasm, be aware of runtime differences
in JS interop types (such as `is`/`as` type casts
and Zone propagation in callbacks).
For details, check out Dart's
[JS interop types documentation]({{site.dart-site}}/interop/js-interop/js-types#compatibility-type-checks-and-casts)
and the [package:web Zones section]({{site.dart-site}}/interop/js-interop/package-web#zones).

To learn more about JS interop in Dart,
see Dart's [JS interop][] documentation page.

### Diagnosing Wasm compilation errors {:#diagnosing-wasm-compilation-errors}

When compiling a Flutter web project with `--wasm`, if your application or its
packages import unsupported web APIs (such as `dart:html` or `package:js`),
the compilation will fail.

#### 1. Perform early detection and enforce modern JS interop

You can detect incompatibilities early with dry-run warnings. When you run
`flutter build web` without the `--wasm` flag, a Wasm dry run is still performed
automatically (pass `--no-wasm-dry-run` to suppress it). If incompatibilities
are found, you will see a non-fatal warning like this:

```console
Wasm dry run failed:
Found incompatibilities with WebAssembly.

package:my_app/main.dart 1:1 - dart:html unsupported (0)
```

In Flutter 3.50 and later, you can also enforce modern JS interop across
JavaScript (`dart2js` and `ddc`) builds. This ensures Wasm compatibility and
prepares your app for the upcoming removal of deprecated web libraries from the
Dart SDK. Pass `--no-deprecated-js-interop` to `flutter build web`,
`flutter run`, `flutter drive`, or `flutter test --platform chrome`:

```console
$ flutter build web --no-deprecated-js-interop
```

Passing `--no-deprecated-js-interop` causes imports of deprecated `dart:*` web
libraries (and packages that import them, such as `package:js`) to fail at
compile time. It also evaluates `dart.library.html`, `dart.library.js`, and
`dart.library.js_util` to `false` in conditional imports.

#### 2. Inspect the compiler dependency tree

If you run `flutter build web --wasm` and it fails due to an unsupported
import, `flutter_tools` prints a structured `Context` tree showing which
package and file imported the unavailable library:

```console
Context: The unavailable library 'dart:html' is imported through these packages:

    main.dart => package:my_app => dart:html

Detailed import paths for (some of) these imports:

    main.dart => package:my_app/main.dart => dart:html
```

#### 3. Migrate legacy imports

To fix these compilation errors, you must migrate from legacy JS interop
packages to modern WebAssembly-compatible alternatives:

- Replace `dart:html` and other legacy web libraries with [`package:web`][].
- Replace `dart:js` and `package:js` with [`dart:js_interop`][].

For comprehensive migration instructions, check out the
[`package:web` migration guide on dart.dev]({{site.dart-site}}/interop/js-interop/package-web)
and Dart's [JS interop usage guide]({{site.dart-site}}/interop/js-interop).

If you need to support both legacy and modern environments during your
migration, use conditional imports by checking for `dart.library.js_interop`:

```dart
import 'fallback.dart'
  if (dart.library.js) 'legacy_web_interop.dart'
  if (dart.library.js_interop) 'wasm_web_interop.dart';
```

To learn more about selecting implementations at compile time, see the
[conditional imports documentation on dart.dev]({{site.dart-site}}/interop/js-interop/package-web#conditional-imports).

## Interoperate with JavaScript and browser APIs {:#host-scripts-and-measurement-apis}

When a Flutter Wasm app interacts with external JavaScript libraries,
host-page scripts, or browser APIs, use [`dart:js_interop`][] and
[`package:web`][] to communicate across the Wasm-to-JS boundary with static
type safety.

### Call external JavaScript libraries with extension types {:#call-external-javascript-sdks}

To call a JavaScript library loaded on the page (such as an analytics SDK or
a custom host API), declare a zero-cost `extension type` over `JSObject`
annotated with `@JS()`.
Convert Dart primitives with `.toJS` and structured maps with `.jsify()`:

```dart title="analytics_interop.dart"
import 'dart:js_interop';

@JS('appAnalytics')
external AppAnalytics? get _analytics;

extension type AppAnalytics._(JSObject _) implements JSObject {
  external void trackEvent(JSString name, [JSAny? parameters]);
}

void logAnalyticsEvent(String eventName, Map<String, Object?> parameters) {
  // Safely no-ops if the external script hasn't loaded.
  _analytics?.trackEvent(eventName.toJS, parameters.jsify());
}
```

### Communicate with the host page using custom DOM events {:#decouple-embedded-views-with-customevent}

Rather than coupling Dart code directly to global JavaScript functions on the
host page, dispatch standard DOM `CustomEvent` messages through `package:web`.
Host scripts can subscribe and unsubscribe independently using
`window.addEventListener`:

```dart title="host_events.dart"
import 'dart:js_interop';
import 'package:web/web.dart' as web;

void notifyHostPage(String eventName, Map<String, Object?> payload) {
  web.window.dispatchEvent(
    web.CustomEvent(
      eventName,
      web.CustomEventInit(detail: payload.jsify(), bubbles: true),
    ),
  );
}
```

On the host page, listen for the custom event:

```js title="host_page.js"
window.addEventListener('flutter:view-ready', (event) => {
  console.log('Flutter view ready:', event.detail);
});
```

### Measure startup and frame timing with the User Timing API {:#record-startup-and-frame-milestones}

To record Flutter startup and interaction milestones in Chrome DevTools
**Performance** traces and browser `PerformanceObserver` listeners, combine
`WidgetsBinding.instance.addPostFrameCallback` with the browser's User Timing
API (`window.performance.mark` and `window.performance.measure`):

```dart title="main.dart"
import 'dart:js_interop';
import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

void main() {
  web.window.performance.mark('flutter_main_start');
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    web.window.performance.mark('flutter_first_frame');
    web.window.performance.measure(
      'flutter_first_frame_render',
      'flutter_main_start'.toJS,
      'flutter_first_frame',
    );
  });

  runApp(const MyApp());
}
```

### Batch calls across the Wasm-to-JS boundary

In Wasm builds, Dart memory (managed WasmGC heap objects) is separate from the
JavaScript heap.
Crossing the Wasm-to-JS boundary to convert strings, lists, or maps incurs
copying overhead when performed repeatedly.

To keep frame times smooth:

- Perform tight loops, filtering, and state aggregation in Dart on the Wasm
  heap rather than calling JS getters or setters on each iteration.
- Batch state or structured data updates into a single interop call per frame
  or user action instead of invoking JS interop per list item.

To learn more about how `dart2wasm` represents types and compiles interop calls,
consult [Dart WebAssembly compilation][dart-wasm].

[dart-wasm]: {{site.dart-site}}/web/wasm
[`package:url_launcher`]: {{site.pub-pkg}}/url_launcher
[`package:web` migration guide]: {{site.dart-site}}/interop/js-interop/package-web
[JS interop]: {{site.dart-site}}/interop/js-interop
[`wasm-ready`]: {{site.pub-pkg}}?q=is%3Awasm-ready
[pub.dev]: {{site.pub}}
