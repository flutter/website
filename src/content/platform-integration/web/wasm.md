---
title: Support for WebAssembly (Wasm)
description: >-
  Current status of Flutter's experimental support for WebAssembly (Wasm).
short-title: Wasm
last-update: March 13, 2024
---

**_Last updated {{last-update}}_**

The Flutter and Dart teams are excited to add
[WebAssembly](https://webassembly.org/) as a compilation target when building
applications for the web.

Development of WebAssembly support for Dart and Flutter remains ongoing,
which will potentially result in frequent changes. 
Revisit this page for the latest updates.

:::note
**Support for Wasm is now in beta!**
: WebAssembly support for Flutter web is
  available on the Flutter [`beta`][] and [`main`][] channels.

**Dart's next-gen Web interop is now stable!**
: Migrate your packages to [`package:web`][] and [`dart:js_interop`][]
  to make them compatible with Wasm. Read the
  [Requires JS-interop](#js-interop-wasm)
  section to learn more. 
:::

[`beta`]: {{site.github}}/flutter/flutter/wiki/flutter-build-release-channels#beta
[`main`]: {{site.github}}/flutter/flutter/wiki/flutter-build-release-channels#master-aka-main
[`package:web`]: {{site.pub-pkg}}/web
[`dart:js_interop`]: {{site.dart.api}}/{{site.dart.sdk.channel}}/dart-js_interop 

## Background

To run a Flutter app that has been compiled to Wasm,
you need a browser that supports [WasmGC][].
The Wasm standard plans to add WasmGC to help garbage-collected languages
like Dart execute code in an efficient manner.

[Chromium and V8][] released stable support for WasmGC in Chromium 119.
Note that Chrome on iOS uses WebKit, which doesn't yet [support WasmGC][].
Firefox announced stable support for WasmGC in Firefox 120,
but currently does not work due to a [known limitation](#known-limitations). 

[WasmGC]: https://github.com/WebAssembly/gc/tree/main/proposals/gc
[Chromium and V8]: https://chromestatus.com/feature/6062715726462976
[support WasmGC]: https://bugs.webkit.org/show_bug.cgi?id=247394
[issue]: https://bugzilla.mozilla.org/show_bug.cgi?id=1788206

## Try it out

To try a pre-built Flutter web app using Wasm, check out the
[Material 3 WasmGC preview demo](https://flutterweb-wasm.web.app/).

To experiment with Wasm in your own apps, follow the steps below.

### Switch to the Flutter `beta` channel and upgrade

Wasm compilation is available on the latest builds of
the `beta` channel (preferred) or `main`.

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
    --wasm                       Compile to WebAssembly rather than JavaScript.
                                 See https://flutter.dev/wasm for more information.
    --[no-]strip-wasm            Whether to strip the resulting wasm file of static symbol names.
                                 (defaults to on)
```

### Pick a (simple) Flutter web application

Try the default template [sample app][], or choose any Flutter application
that has been migrated to be
[compatible with Wasm](#js-interop-wasm).

[sample app]: /get-started/test-drive

### Modify `index.html`

Before building with Wasm, you'll need to modify the bootstrap logic in
your app's `web/index.html` file.

```html
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <title>Flutter web app</title>
  <script src="flutter.js"></script>
</head>
<body>
  <script>
    {% raw %}{{flutter_build_config}}{% endraw %}
    _flutter.loader.load();
  </script>
</body>
</html>
```

This feature is under development. The current syntax
(`flutter.js`, `{% raw %}{{flutter_build_config}}{% endraw %}`,
`_flutter.loader.load()`) is a temporary solution in the `beta` and `main`
channels now, but will be replaced by the actual syntax in an upcoming stable
release. Stay tuned!

### Run `flutter build web --wasm`

To build a web application with Wasm, add the `--wasm` flag to
the existing `flutter build web` command.

```console
flutter build web --wasm
```

The command sends its output to the `build/web` directory relative to
package root.

### Serve the output locally with an HTTP server

If you don't have a local HTTP server installed, you can use the
[`dhttpd` package]({{site.pub-pkg}}/dhttpd):

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

Most packages owned by the Dart and Flutter teams have been
migrated to be compatible with Wasm support in Flutter,
such as [`package:url_launcher`][].
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

### Only build support

Neither `flutter run` nor [DevTools](/tools/devtools) support
Wasm at the moment.

## Learn more

Check out Flutter's
[existing web support]({{site.main-url}}/multi-platform/web).
Work on Flutter and Dart Wasm support continues.
Once finished, your existing Flutter web apps
shouldn't need much work to support Wasm.

If you want to learn more, watch this talk from our team at Wasm I/O 2023:
[Flutter, Dart, and WasmGC: A new model for web applications](https://youtu.be/Nkjc9r0WDNo).

To follow the latest changes in the Flutter and Dart WebAssembly effort,
revisit [flutter.dev/wasm]({{site.main-url}}/wasm).
