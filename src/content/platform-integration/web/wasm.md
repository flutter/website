---
title: Support for WebAssembly (Wasm)
description: >-
  Current status of Flutter's experimental support for WebAssembly (Wasm).
short-title: Wasm
last-update: May 14, 2024
---

**_Last updated {{last-update}}_**

The Flutter and Dart teams are excited to add
[WebAssembly](https://webassembly.org/)
as a compilation target when building
applications for the web.

:::note
**Support for Wasm is now stable!**
: WebAssembly support for Flutter web is available on the Flutter [`stable`][] channel.

**Dart's next-gen web interop is now stable!**
: Migrate your packages to [`package:web`][] and [`dart:js_interop`][]
  to make them compatible with Wasm. Read the
  [Requires JS-interop](#js-interop-wasm)
  section to learn more. 
:::

[`stable`]: {{site.github}}/flutter/flutter/blob/master/docs/releases/Flutter-build-release-channels.md#stable
[`package:web`]: {{site.pub-pkg}}/web
[`dart:js_interop`]: {{site.dart.api}}/{{site.dart.sdk.channel}}/dart-js_interop 

## Background

To run a Flutter app that has been compiled to Wasm,
you need a browser that supports [WasmGC][].

[Chromium and V8][] released stable support for WasmGC in Chromium 119.
Note that Chrome on iOS uses WebKit, which doesn't yet [support WasmGC][].
Firefox announced stable support for WasmGC in Firefox 120,
but currently doesn't work due to a [known limitation](#known-limitations). 

[WasmGC]: {{site.github}}/WebAssembly/gc/tree/main/proposals/gc
[Chromium and V8]: https://chromestatus.com/feature/6062715726462976
[support WasmGC]: https://bugs.webkit.org/show_bug.cgi?id=247394
[issue]: https://bugzilla.mozilla.org/show_bug.cgi?id=1788206

## Try it out

To try a pre-built Flutter web app using Wasm, check out the
[Wonderous demo app](https://wonderous.app/web/).

To experiment with Wasm in your own apps, use the following steps.

### Switch to the Flutter 3.22 stable or newer

To ensure you are running the latest version, run `flutter upgrade`.

To verify that your Flutter install supports Wasm,
run `flutter build web --help`.

At the bottom of the output, you should find experimental Wasm options like:

```console
Experimental options
    --wasm                       Compile to WebAssembly (with fallback to JavaScript).
                                 See https://flutter.dev/wasm for more information.
    --[no-]strip-wasm            Whether to strip the resulting wasm file of static symbol names.
                                 (defaults to on)
```

### Choose a (simple) Flutter web application

Try the default template [sample app][],
or choose any Flutter application
that has been migrated to be
[compatible with Wasm](#js-interop-wasm).

[sample app]: /get-started/test-drive

### Modify `index.html`

Make sure your app's `web/index.html` is updated to the latest
[Flutter web app initialization][] for Flutter 3.22 and later.

[Flutter web app initialization]: /platform-integration/web/initialization

### Run `flutter build web --wasm`

To build a web application with Wasm, add the `--wasm` flag to
the existing `flutter build web` command.

```console
flutter build web --wasm
```

The command produces output into the `build/web` directory relative to the
package root, just like `flutter build web`.

:::note
Even with the `--wasm` flag, `flutter build web` will still compile the
application to JavaScript. If WasmGC support is not detected at runtime,
the JavaScript output is used so the application will continue to work across
browsers.
:::

### Serve the output with an HTTP server

Flutter web WebAssembly uses multiple threads to render your application
faster, with less jank. To do this, advanced browser features are used that
require specific HTTP response headers.

:::warning
Flutter web applications won't run with WebAssembly unless the server is
configured to send specific HTTP headers.
:::

<div class="table-wrapper">

| Name | Value |
|-|-|
| `Cross-Origin-Embedder-Policy` | `credentialless` <br> or <br> `require-corp` |
| `Cross-Origin-Opener-Policy` | `same-origin` |

{:.table}

</div>

To learn more about these headers, check out
[Load cross-origin resources without CORP headers using COEP: credentialless][coep].

[coep]: https://developer.chrome.com/blog/coep-credentialless-origin-trial

### Serving Wasm locally

If you don't have a local HTTP server installed, you can use
the [`dhttpd` package]({{site.pub-pkg}}/dhttpd):

```console
flutter pub global activate dhttpd
```

Then change to the `build/web` directory
and run the server with special headers:

```console
$ cd build/web
$ dhttpd '--headers=Cross-Origin-Embedder-Policy=credentialless;Cross-Origin-Opener-Policy=same-origin'
Server started on port 8080
```

### Load it in a browser

As of {{last-update}},
[only **Chromium-based browsers**](#chrome-119-or-later)
(Version 119 or later) are able to run Flutter/Wasm content. 

If your configured browser meets the requirements, open
[`localhost:8080`](http://localhost:8080) in the browser to view the app.

If the application doesn't load:

1. Check the developer console for errors.
1. Validate a successful build with the typical JavaScript output.

## Known limitations

Wasm support currently has some limitations.
The following list covers some common issues.

### Chrome 119 or later

As mentioned in [Load it in a browser](#load-it-in-a-browser), 
to run Flutter web apps compiled to Wasm, 
use _Chrome 119 or later_.

Some earlier versions supported WasmGC with specific flags enabled,
but WasmGC encodings changed once the feature was stabilized.
To ensure compatibility, run the latest version of the Flutter `main` channel
and the latest version of Chrome.

- **Why not Firefox?**
  Firefox versions 120 and later were previously able to run Flutter/Wasm,
  but they're [currently experiencing a bug][] that is
  blocking compatibility with Wasm.
- **Why not Safari?**
  Safari does not support WasmGC yet; [this bug][] tracks their
  implementation efforts.

:::warning
Flutter compiled to Wasm can't run on the iOS version of any browser.
All browsers on iOS are required to use WebKit,
and can't use their own browser engine.
:::

[currently experiencing a bug]: https://bugzilla.mozilla.org/show_bug.cgi?id=1788206
[this bug]: https://bugs.webkit.org/show_bug.cgi?id=247394

### Requires JS-interop to access browser and JS APIs {:#js-interop-wasm}

To support compilation to Wasm, [Dart has shifted][JS interop]
how it enables interop with browser and JavaScript APIs.
This shift prevents Dart code that uses `dart:html` or `package:js`
from compiling to Wasm.

Instead, Dart now provides new, lightweight interop solutions built around
static JS interop:

- [`package:web`][], which replaces `dart:html` (and other web libraries)
- [`dart:js_interop`][], which replaces `package:js` and `dart:js`

The Dart and Flutter teams have migrated most packages
to support Wasm in Flutter,
such as [`package:url_launcher`][].
To find Wasm-compatible packages, 
use the [`wasm-ready`][] filter on [pub.dev][].


To learn how to migrate your packages and applications to the new solutions,
check out the [JS interop][] documentation and [`package:web` migration guide][].

To check if a Wasm build failed due to
incompatible APIs, review the error output.
These often return soon after a build invocation.
An API-related error should resemble the following:

```plaintext
Target dart2wasm failed: Exception: ../../../../.pub-cache/hosted/pub.dev/url_launcher_web-2.0.16/lib/url_launcher_web.dart:6:8: Error: Dart library 'dart:html' is not available on this platform.
import 'dart:html' as html;
       ^
Context: The unavailable library 'dart:html' is imported through these packages:

    web_plugin_registrant.dart => package:url_launcher_web => dart:html
    web_plugin_registrant.dart => package:url_launcher_web => package:flutter_web_plugins => dart:html
    web_plugin_registrant.dart => package:flutter_web_plugins => dart:html
```

[`package:url_launcher`]: {{site.pub-pkg}}/url_launcher
[`package:web` migration guide]: {{site.dart-site}}/interop/js-interop/package-web
[JS interop]: {{site.dart-site}}/interop/js-interop
[`wasm-ready`]: {{site.pub-pkg}}?q=is%3Awasm-ready
[pub.dev]: {{site.pub}}

### Only build support

Neither `flutter run` nor [DevTools](/tools/devtools) support
Wasm in Flutter 3.22. This feature has been
implemented, though, and will be available in the next stable release.
