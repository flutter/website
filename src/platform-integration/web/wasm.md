---
title: Support for WebAssembly (Wasm)
description: >-
  Current status of Flutter's experimental support for WebAssembly (Wasm).
short-title: Wasm
last-update: March 7, 2024
---

The Flutter and Dart teams are excited to add
[WebAssembly](https://webassembly.org/) as a compilation target when building
applications for the web.

{{site.alert.note}}
  Development of WebAssembly support for Dart and Flutter remains ongoing,
  which will potentially result in frequent changes. 
  Revisit this page for the latest updates.

  **_Last updated {{page.last-update}}_**

  **Wasm is now in beta!**
  : Wasm and WebAssembly garbage collection (WasmGC) are now 
    available on the Flutter [`beta` channel][] and [`master` channel][].

  **Static JS interop is now in stable!**
  : Migrate your packages to [`package:web`][] to make them compatible with Wasm.
    Read the [Requires JS-interop](#requires-js-interop-to-access-browser-and-js-apis)
    section to learn more. 

{{site.alert.end}}

[`beta` channel]: https://github.com/flutter/flutter/wiki/flutter-build-release-channels#beta
[`master` channel]: https://github.com/flutter/flutter/wiki/flutter-build-release-channels#beta
[`package:web`]: {{site.pub-pkg}}/web

### Background

To compile Dart and Flutter to Wasm, you need
a browser that supports [WasmGC][].
The Wasm standard plans to add WasmGC to help garbage-collected languages
like Dart execute code in an efficient manner.

[Chromium and V8][] released stable support for WasmGC in Chromium 119,
and the Firefox team announced stable support in Firefox 120.
Note that Chrome on iOS uses WebKit, which doesn't yet 
[support WasmGC][].
To see the current status of WasmGC and other proposals,
check out the [WebAssembly roadmap][].

[WasmGC]: https://github.com/WebAssembly/gc/tree/main/proposals/gc
[Chromium and V8]: https://chromestatus.com/feature/6062715726462976
[WebAssembly roadmap]: https://webassembly.org/roadmap/
[support WasmGC]: https://bugs.webkit.org/show_bug.cgi?id=247394

### Try it out

To try a pre-built Flutter web app using Wasm, check out the
[Material 3 WasmGC preview demo](https://flutterweb-wasm.web.app/).

To experiment with Wasm in your own apps, follow the steps below.

#### Switch to the Flutter `beta` channel and upgrade

Wasm compilation is available on the latest builds of the `beta` channel
(recommended) or `master` (not recommended).

To learn more about Flutter build release channels and how to switch to
the `beta` channel, check out the
[Flutter wiki](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels).

To then ensure you are running the latest version,
run `flutter upgrade`.

To verify if your Flutter install supports Wasm,
run `flutter build web --help`.

At the bottom of the output, you should find experimental Wasm options like:

```console
Experimental options
    --wasm                                              Compile to WebAssembly rather than JavaScript.
                                                        See https://flutter.dev/wasm for more information.
    --omit-type-checks                                  Omit type checks in Wasm output.
                                                        Reduces code size and improves performance, but might affect runtime correctness. Use with care.
    --wasm-opt                                          Optimize output wasm using the Binaryen (https://github.com/WebAssembly/binaryen) tool.

          [debug]                                       Similar to `full`, but member names are preserved. Debugging is easier, but size is a bit bigger.
          [full] (default)                              wasm-opt is run. Build time is slower, but output is smaller and faster.
          [none]                                        wasm-opt is not run. Fastest build; bigger, slower output.
```

#### Pick a (simple) Flutter web application

Choose a Flutter application that has been migrated
to use [`package:web`][] and the new [JS interop][] solutions.

Applications that use platform-specific packages and JS interop code
are not compatible with Wasm unless they have been
[migrated to use *static* JS interop](#requires-js-interop-to-access-browser-and-js-apis).

[JS interop]: {{site.dart-site}}/interop/js-interop

#### Run `flutter build web --wasm`

To build a web application with Wasm, add a `--wasm` flag to the existing
`flutter build web` command.

```console
flutter build web --wasm
```

The command sends its output to the `build/web_wasm` directory relative to
package root.

#### Serve the output locally with an HTTP server

If you don't have a local HTTP server installed, you can use the
[`dhttpd` package]({{site.pub-pkg}}/dhttpd):

```terminal
flutter pub global activate dhttpd
```

Then change to the `build/web_wasm` directory
and run the server:

```terminal
> cd build/web_wasm
> dhttpd
Server started on port 8080
```

#### Load it in a browser

As of {{page.last-update}},
two browser families should be able to run
Flutter/Wasm content:

- **Chromium-based browsers:** Version 119 or later.
- **Firefox:** Version 120 or later.

{{site.alert.note}}
  This does not include versions of these browsers on iOS.
{{site.alert.end}}

If your configured browser meets the requirements, open
[`localhost:8080`](http://localhost:8080) in the browser to view the app.

If the application doesn't load:

1. Check the developer console for errors.
1. Validate a successful build with the typical JavaScript output.

[ff-preview]: https://www.mozilla.org/en-US/firefox/channel/desktop/

### Known limitations

Wasm support has some limitations.
The following list covers some common issues.

#### Chrome 119 and Firefox 120 or later

As mentioned in [Load it in a browser](#load-it-in-a-browser), 
to run Flutter web apps compiled to Wasm, 
use _Chrome 119 or later_ or _Firefox 120 or later_.

Some earlier versions supported WasmGC with specific flags enabled,
but WasmGC encodings changed once the feature was stabilized.
To ensure compatibility, run the latest version of the Flutter `master` channel
and the latest version of Chrome or Firefox.

#### Requires JS-interop to access browser and JS APIs

To support Wasm, Dart has shifted how it targets browser and JavaScript APIs.
This shift prevents Dart code that uses `dart:html` or `package:js`
from compiling to Wasm.

Instead, Dart now provides new, lightweight interop solutions built around
static JS interop:

- [`package:web`][], which replaces `dart:html` (and other web libraries).
- [`dart:js_interop`][], which replaces `package:js`.

Most platform-specific packages, such as [`package:url_launcher`][], that used
the previous web and JS interop solutions
are [currently being migrated](https://github.com/flutter/packages/pull/5451/files)
to be compatible with Wasm support in Flutter.

To learn how to migrate to the new solutions, read the
[`package:web` migration guide][] and [JS interop][] documentation set.

To check if a Wasm build failed due to these APIs, review the error output.
These often return soon after a build invocation.
An API-related error should resemble the following:

```console
Target dart2wasm failed: Exception: ../../../../.pub-cache/hosted/pub.dev/url_launcher_web-2.0.16/lib/url_launcher_web.dart:6:8: Error: Dart library 'dart:html' is not available on this platform.
import 'dart:html' as html;
       ^
Context: The unavailable library 'dart:html' is imported through these packages:

    web_plugin_registrant.dart => package:url_launcher_web => dart:html
    web_plugin_registrant.dart => package:url_launcher_web => package:flutter_web_plugins => dart:html
    web_plugin_registrant.dart => package:flutter_web_plugins => dart:html
```

[`dart:js_interop`]: {{site.dart.api}}/{{site.dart.sdk.channel}}/dart-js_interop
[`package:url_launcher`]: {{site.pub-pkg}}/url_launcher
[`package:web` migration guide]: {{site.dart-site}}/interop/js-interop/package-web

#### Only build support

Neither `flutter run` nor [DevTools](/tools/devtools) support
Wasm at the moment.

### Learn more

Check out Flutter's
[existing web support]({{site.main-url}}/multi-platform/web).
Flutter to Wasm work continues.
Once finished, we believe your existing Flutter web apps
shouldn't need much work to support Wasm.

If you want to learn more, watch this talk from our team at Wasm I/O 2023:
[Flutter, Dart, and WasmGC: A new model for web applications](https://youtu.be/Nkjc9r0WDNo).

To check out the latest details on the Flutter and Dart WebAssembly effort,
visit at [flutter.dev/wasm]({{site.main-url}}/wasm).
