---
title: Support for WebAssembly (Wasm)
description: >-
  Current status of Flutter's support for WebAssembly (Wasm).
shortTitle: Wasm
last-update: Nov 6, 2024
---

Flutter and Dart support
[WebAssembly](https://webassembly.org/)
as a compilation target when building
applications for the web.

[`stable`]: {{site.github}}/flutter/flutter/blob/master/docs/releases/Flutter-build-release-channels.md#stable
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

[coep]: https://developer.chrome.com/blog/coep-credentialless-origin-trial

## Learn more about browser compatibility
To run a Flutter app that has been compiled to Wasm,
you need a browser that supports [WasmGC][].

[Chromium and V8][] support WasmGC since version 119.
Chrome on iOS uses WebKit, which doesn't yet [support WasmGC][].
Firefox announced stable support for WasmGC in Firefox 120,
but currently doesn't work due to a known limitation (see details below).

[WasmGC]: {{site.github}}/WebAssembly/gc/tree/main/proposals/gc
[Chromium and V8]: https://chromestatus.com/feature/6062715726462976
[support WasmGC]: https://bugs.webkit.org/show_bug.cgi?id=247394
[issue]: https://bugzilla.mozilla.org/show_bug.cgi?id=1788206

- **Why not Firefox?**
  Firefox versions 120 and later were previously able to run Flutter/Wasm, but
  they're experiencing a bug that is blocking compatibility with Flutter's Wasm
  renderer. Follow [this bug][firefox-bug] for details.
- **Why not Safari?**
  Safari now supports WasmGC, but is experiencing a similar bug that is
  blocking compatibility with Flutter's Wasm renderer.
  Follow [this bug][safari-bug] for details.

[firefox-bug]: https://bugzilla.mozilla.org/show_bug.cgi?id=1788206
[safari-bug]: https://bugs.webkit.org/show_bug.cgi?id=267291

:::warning
Flutter compiled to Wasm can't run on the iOS version of any browser.
All browsers on iOS are required to use WebKit,
and can't use their own browser engine.
:::

## Using compatible JS interop libraries {:#js-interop-wasm}

To support compilation to Wasm, Dart has changed
how it enables interop with browser and JavaScript APIs.
This prevents Dart code that uses `dart:html` or `package:js`
from compiling to Wasm.

Instead, Dart now provides new, lightweight interop solutions built around
static JS interop:

- [`package:web`][], which replaces `dart:html` (and other web libraries)
- [`dart:js_interop`][], which replaces `package:js` and `dart:js`

To learn more about JS interop in Dart,
see Dart's [JS interop][] documentation page.

[`package:url_launcher`]: {{site.pub-pkg}}/url_launcher
[`package:web` migration guide]: {{site.dart-site}}/interop/js-interop/package-web
[JS interop]: {{site.dart-site}}/interop/js-interop
[`wasm-ready`]: {{site.pub-pkg}}?q=is%3Awasm-ready
[pub.dev]: {{site.pub}}
