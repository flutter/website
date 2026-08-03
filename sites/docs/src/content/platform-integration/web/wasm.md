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

[coep]: https://developer.chrome.com/blog/coep-credentialless-origin-trial

## Learn more about browser compatibility
To run a Flutter app that has been compiled to Wasm,
you need a browser that supports [WasmGC][].

[Chromium and V8][] support WasmGC since version 119.
Chrome on iOS uses WebKit, which doesn't yet [support WasmGC][].
Firefox announced stable support for WasmGC in Firefox 120,
but currently doesn't work due to a known limitation (see details below).

[WasmGC]: https://github.com/WebAssembly/gc/tree/main/proposals/gc
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

By default, the Dart Wasm compiler emits a clean, structured dependency chain
tree, but this output can be buried in a long terminal exception stack trace.

#### 1. Perform early detection

You can detect incompatibilities early via dry-run warnings. When you run
`flutter build web` without the `--wasm` flag, a Wasm dry run is still performed
automatically. If incompatibilities are found, you will see a non-fatal warning
like this:

```console
Wasm dry run failed:
Found incompatibilities with WebAssembly.

package:my_app/main.dart 1:1 - dart:html unsupported (0)
```

#### 2. Isolate the compiler dependency tree

If you run `flutter build web --wasm` and it fails, `flutter_tools` outputs
a large exception stack trace (for example, `Target dart2wasm failed...`). 

**Ignore the long stack trace and command string.** Instead, scroll up to the
top of the error output to find the structured `Context` tree. This clean tree
tells you exactly which package and file imported the unsupported library:

```console
Context: The unavailable library 'dart:html' is imported through these packages:

    main.dart => package:my_app => dart:html

Detailed import paths for (some of) the these imports:

    main.dart => package:my_app/main.dart => dart:html
```

#### 3. Migrate legacy imports

To fix these compilation errors, you must migrate from legacy JS interop
packages to modern WebAssembly-compatible alternatives:

- Replace `dart:html` and other legacy web libraries with [`package:web`][].
- Replace `dart:js` and `package:js` with [`dart:js_interop`][].

If you need to support both legacy and modern environments during your
migration, use conditional imports by checking for `dart.library.js_interop`:

```dart
import 'fallback.dart'
  if (dart.library.js_interop) 'wasm_web_interop.dart'
  if (dart.library.js) 'legacy_web_interop.dart';
```

[`package:url_launcher`]: {{site.pub-pkg}}/url_launcher
[`package:web` migration guide]: {{site.dart-site}}/interop/js-interop/package-web
[JS interop]: {{site.dart-site}}/interop/js-interop
[`wasm-ready`]: {{site.pub-pkg}}?q=is%3Awasm-ready
[pub.dev]: {{site.pub}}
