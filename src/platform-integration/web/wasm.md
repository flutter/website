---
title: Support for WebAssembly (Wasm)
description:
  Current status of Flutter's experimental support for WebAssembly (Wasm).
short-title: Wasm
last-update: May 23, 2023
---

The Flutter and Dart teams are excited to add
[WebAssembly](https://webassembly.org/) as a compilation target when building
applications for the web.

{{site.alert.warning}} Development of WebAssembly support for Dart and Flutter
remains ongoing.

You can preview Wasm and WebAssembly garbage collection (WasmGC) in the
[`master` channel](https://github.com/flutter/flutter/wiki/flutter-build-release-channels#master).
As Flutter provides these features as previews,
ongoing development might result in frequent changes.
Revisit this page for the latest updates.

**_Last updated {{page.last-update}}_**

{{site.alert.end}}

### Background

To compile Dart and Flutter to Wasm, you need a browser that supports
[WasmGC](https://github.com/WebAssembly/gc/tree/main/proposals/gc). The Wasm
standard plans to add WasmGC to help garbage-collecting languages like Dart
execute code in an efficient manner.

Both the [Chromium V8](https://chromestatus.com/feature/6062715726462976) and
Firefox teams continue to work on WasmGC. To see the current status on the
WasmGC and other proposals, check out the
[WebAssembly roadmap](https://webassembly.org/roadmap/).

### Try it out

#### Switch to the Flutter `master` channel.

To learn more about Flutter build release channels, check out the
[Flutter wiki](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels).

Wasm compilation is only available on the `master` channel.

To verify that you set your environment to the `master` channel, run
`flutter build web --help`.

At the bottom of the output, you should see something like

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

Choose a Flutter application without platform-specific packages or JavaScript
interop code. These [known limitations](#known-limitations) cause issues with
Wasm.

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
[`dhttpd` package](https://pub.dev/packages/dhttpd). Then change to the
`build/web_wasm` directory and run the server.

```terminal
> cd build/web_wasm
> dhttpd
Server started on port 8080
```

#### Load it in a browser

As of {{page.last-update}}, there are two known browser types that should run
Flutter/Wasm content.

- Chromium-based browsers
  - Run version 113 or greater.
  - Set the `enable-webassembly-garbage-collection`
    [flag](https://developer.chrome.com/docs/web-platform/chrome-flags/).
- Firefox
  - Run the
    [nightly channel](https://www.mozilla.org/en-US/firefox/channel/desktop/#nightly)
    build. (Verified on v.115.0a1)
  - Set two additional preferences in
    [about:config](https://support.mozilla.org/kb/about-config-editor-firefox):
    - `javascript.options.wasm_function_references`
    - `javascript.options.wasm_gc`

If your configured browser meets the requirements stated earlier, open `localhost:8080`
in the browser to view the app.

If the application doesn't load:

1. Check the developer console for errors.
1. Validate a successful build with the typical JavaScript output.

### Known limitations

Wasm support has some limitations. The following list covers the common issues.

#### Chrome or Firefox nightly, with flags

As mentioned in [Load it in a browser](#load-it-an-a-browser), 
to run Flutter web apps compiled to Wasm, 
use _Chrome 113 or later_ or a _Firefox nightly build_ with 
experimental flags enabled.

#### Requires preview JS-interop to access browser and JS APIs.

To support Wasm, Dart shifts how it targets browser and JavaScript APIs. This
shift prevents Dart code that uses `dart:html` or `package:js` from compiling to
Wasm. Most platform-specific packages, like
[`package:url_launcher`](https://pub.dev/packages/url_launcher), use these
libraries.

To check if a Wasm build failed due to these APIs, review the error output.
These often return soon after a build invocation. An API-related error should
resemble the following:

```console
Target dart2wasm failed: Exception: ../../../../.pub-cache/hosted/pub.dev/url_launcher_web-2.0.16/lib/url_launcher_web.dart:6:8: Error: Dart library 'dart:html' is not available on this platform.
import 'dart:html' as html;
       ^
Context: The unavailable library 'dart:html' is imported through these packages:

    web_plugin_registrant.dart => package:url_launcher_web => dart:html
    web_plugin_registrant.dart => package:url_launcher_web => package:flutter_web_plugins => dart:html
    web_plugin_registrant.dart => package:flutter_web_plugins => dart:html
```

You can expect documentation on the replacements to these APIs later in 2023,
including updates to the packages owned by the Dart and Flutter teams.

In the meantime, to experiment with Wasm support in Flutter, avoid these APIs.

#### Only build support

Neither `flutter run` nor [DevTools]({{site.main-url}}/tools/devtools) support
Wasm at the moment.

### Learn more

Check out Flutter's
[existing web support]({{site.main-url}}/multi-platform/web). Flutter to Wasm
work continues. Once finished, we believe your existing Flutter web apps
shouldn't need much work to support Wasm.

If you want to learn more, watch this talk from our team at Wasm I/O 2023:
[Flutter, Dart, and WasmGC: A new model for web applications](https://youtu.be/Nkjc9r0WDNo).

To check out the latest details on the Flutter and Dart WebAssembly effort,
visit at [flutter.dev/wasm]({{site.main-url}}/wasm).
