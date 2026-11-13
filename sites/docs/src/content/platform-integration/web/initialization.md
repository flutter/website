---
title: Flutter web app initialization
description: Customize how Flutter apps are initialized on the web.
---

This page details the initialization process for Flutter web apps and
how it can be customized.

## Bootstrap the app {:#bootstrapping}

The `flutter build web` command produces
a script called `flutter_bootstrap.js` in
the build output directory (`build/web`).
This file contains the JavaScript code needed to initialize and
run your Flutter app.
You can use this script by placing an async-script tag for it in
your `index.html` file in the `web` subdirectory of your Flutter app:

```html highlightLines=3
<html>
  <body>
    <script src="flutter_bootstrap.js" async></script>
  </body>
</html>
```

Alternatively, you can inline the entire contents of
the `flutter_bootstrap.js` file by inserting the
template token `{% raw %}{{flutter_bootstrap_js}}{% endraw %}` in
your `index.html` file:

```html highlightLines=4
<html>
  <body>
    <script>
      {% raw %}{{flutter_bootstrap_js}}{% endraw %}
    </script>
  </body>
</html>
```

The `{% raw %}{{flutter_bootstrap_js}}{% endraw %}` token is
replaced with the contents of the `flutter_bootstrap.js` file when
the `index.html` file is copied to the
output directory (`build/web`) during the build step.
Inlining the bootstrap script eliminates an extra network round-trip during
startup.
For production optimization guidance, refer to
[Reduce cold-start latency][cold-start].

[cold-start]: /deployment/web#reduce-cold-start-latency

<a id="customizing-initialization" aria-hidden="true"></a>

## Customize initialization

By default, `flutter build web` generates a `flutter_bootstrap.js` file that
does a simple initialization of your Flutter app.
However, in some scenarios, you might have a reason to
customize this initialization process, such as:

* Setting a custom Flutter configuration for your app.
* Integrating a custom service worker for offline support or caching.
* Writing custom JavaScript code to
  run at different stages of the startup process.

To write your own custom bootstrapping logic instead of
using the default script produced by the build step, you can
place a `flutter_bootstrap.js` file in the `web` subdirectory of your project,
which is copied over and used instead of
the default script produced by the build.
This file is also templated, and you can insert several special tokens that
the build step substitutes at build time when copying
the `flutter_bootstrap.js` file to the output directory.
The following table lists the tokens that the build step will
substitute in either the `flutter_bootstrap.js` or `index.html` files:

| Token | Replaced with |
|---|---|
| `{% raw %}{{flutter_js}}{% endraw %}` | The JavaScript code that makes the `FlutterLoader` object available in the `_flutter.loader` global variable (refer to [Customize the Flutter loader](#customize-the-flutter-loader)). |
| `{% raw %}{{flutter_build_config}}{% endraw %}` | A JavaScript statement that sets metadata produced by the build process which gives the `FlutterLoader` information needed to properly bootstrap your application. |
| `{% raw %}{{flutter_service_worker_version}}{% endraw %}` | **Deprecated.** Previously substituted a build version number for Flutter's legacy service worker loader. Flutter no longer generates or registers a caching service worker; refer to [Service worker deprecation](#service-worker-version-deprecation) and the [Web FAQ](/platform-integration/web/faq#how-do-i-configure-a-service-worker). |
| `{% raw %}{{flutter_bootstrap_js}}{% endraw %}` | As mentioned above, this inlines the contents of the `flutter_bootstrap.js` file directly into the `index.html` file. Note that this token can only be used in the `index.html` and not the `flutter_bootstrap.js` file itself. |

{:.table .table-striped}

<a id="write-a-custom-flutter_bootstrap-js" aria-hidden="true"></a>

## Write a custom bootstrap script {:#custom-bootstrap-js}

Any custom `flutter_bootstrap.js` script needs to have three components in
order to successfully start your Flutter app:

* A `{% raw %}{{flutter_js}}{% endraw %}` token,
  to make `_flutter.loader` available.
* A `{% raw %}{{flutter_build_config}}{% endraw %}` token,
  which provides information about the build to the
  `FlutterLoader` needed to start your app.
* A call to `_flutter.loader.load()`, which actually starts the app.

The most basic `flutter_bootstrap.js` file would look something like this:

```js
{% raw %}{{flutter_js}}{% endraw %}
{% raw %}{{flutter_build_config}}{% endraw %}

_flutter.loader.load();
```

:::tip Compatibility with `--web-content-hash`
When you build with [`flutter build web --web-content-hash`][web-content-hashing],
Flutter injects the content-hashed entrypoint filenames (`mainJsPath`,
`mainWasmPath`, `jsSupportRuntimePath`) and hashed asset manifest mappings
(`assetManifest`, `fontManifest`, `extraAssets`) into
`{% raw %}{{flutter_build_config}}{% endraw %}`. Custom `web/index.html` or
`web/flutter_bootstrap.js` files must include
`{% raw %}{{flutter_build_config}}{% endraw %}` and call `_flutter.loader.load()`
rather than hardcoding `"main.dart.js"` or calling the deprecated
`FlutterLoader.loadEntrypoint()` API.
:::

[web-content-hashing]: /deployment/web#web-content-hashing

## Customize the Flutter loader

The `_flutter.loader.load()` JavaScript API can be invoked with optional
arguments to customize initialization behavior:

| Name                    | Description                                                                                                                   | JS&nbsp;type |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------|--------------|
| `config`                | The Flutter configuration of your app.                                                                                        | `Object`     |
| `onEntrypointLoaded`    | The function called when the engine is ready to be initialized. Receives an `engineInitializer` object as its only parameter. | `Function`   |

{:.table .table-striped}

The `config` argument is an object that accepts the following optional fields:

### App embedding, URLs, and debugging

| Name | Description | JS&nbsp;type |
|---|---|---|
| `assetBase` | Base URL for the app's `assets` directory when loading from another domain, subdirectory, or CDN (refer to [Serve assets from a CDN or self-hosted origin][multi-asset-cdn]). | `string` |
| `debugShowSemanticsNodes` | Visibly renders the semantics tree onscreen for accessibility debugging. | `boolean` |
| `entrypointBaseUrl` | Base URL for the Flutter app's compiled entrypoint. Defaults to `"/"`. | `string` |
| `fontFallbackBaseUrl` | Base URL for fallback fonts when bundled fonts lack glyphs. Defaults to `"https://fonts.gstatic.com/s/"`. | `string` |
| `hostElement` | HTML element into which Flutter renders a single-view app (refer to [Add Flutter to any web application][embedding-flutter-web]). When omitted, Flutter renders across the full page. | `HTMLElement` |
| `multiViewEnabled` | Enables multi-view mode for dynamically adding and removing embedded views (refer to [Embedded mode][embedded-mode]). | `boolean` |
| `nonce` | [Content Security Policy (CSP) nonce][nonce-mdn] applied to inline scripts and styles created by the engine. | `string` |

{:.table .table-striped}

<a id="forcesinglethreadedskwasm" aria-hidden="true"></a>

### WebAssembly and build selection

| Name | Description | JS&nbsp;type |
|---|---|---|
| `forceSingleThreadedSkwasm` | Forces single-threaded WebAssembly rendering when [WebAssembly][wasm-support] is selected at runtime (for example, when `SharedArrayBuffer` or `COOP` and `COEP` headers are unavailable). Defaults to `false`. | `boolean` |
| `renderer` | Forces the renderer to `'canvaskit'` or `'skwasm'`. | `string` |
| `suppressMultithreadingWarning` | Suppresses the console warning logged when WebAssembly runs single-threaded because `COOP` and `COEP` headers are absent. | `boolean` |
| `verboseBuildSelection` | Logs `console.warn` diagnostics explaining why each candidate build in `_flutter.buildConfig.builds` was selected or skipped. | `boolean` |
| `wasmAllowList` | Browser engine allowlist (`{ blink, webkit, gecko, unknown }`) controlling which engines run the WebAssembly build (refer to [Support for WebAssembly][wasm-support]). Defaults to `{ blink: true, gecko: false, webkit: false, unknown: false }`. | `Object` |
| `wasmDeferredModulesLoader` | Custom loader callback `(moduleNames, onModuleLoaded) => Promise<void>` for fetching deferred `.wasm` modules when `--enable-wasm-deferred-loading` is enabled (refer to [Serve assets from a CDN or self-hosted origin][multi-asset-cdn]). `onModuleLoaded` accepts `(moduleName: string, module: Response \| Promise<Response> \| ArrayBuffer) => Promise<void>`. | `Function` |

{:.table .table-striped}

### CanvasKit options

| Name | Description | JS&nbsp;type |
|---|---|---|
| `canvasKitBaseUrl` | Base URL from which `canvaskit.wasm` and rendering engine files are downloaded. | `string` |
| `canvasKitForceCpuOnly` | Forces CPU-only rendering in CanvasKit without WebGL. | `boolean` |
| `canvasKitMaximumSurfaces` | Maximum number of overlay surfaces that the CanvasKit renderer can allocate. | `number` |
| `canvasKitVariant` | CanvasKit build to download: `'auto'` (default, selects the optimal build), `'full'` (all browsers), or `'chromium'` (smaller build for Chromium-based browsers only). | `string` |
| `preferWebParagraph` | **Experimental.** Uses the browser's text layout APIs through [WebParagraph][web-paragraph] instead of the text stack bundled in CanvasKit. Has no effect when the browser or renderer doesn't support it. Defaults to `false`. | `boolean` |

{:.table .table-striped}

[embedding-flutter-web]: /platform-integration/web/embedding-flutter-web
[multi-asset-cdn]: /deployment/web#multi-asset-and-cdn-loading
[nonce-mdn]: https://developer.mozilla.org/docs/Web/HTML/Global_attributes/nonce
[wasm-support]: /platform-integration/web/wasm
[web-paragraph]: /platform-integration/web/web-paragraph

## Example usage

```js
_flutter.loader.load({
  config: {
    forceSingleThreadedSkwasm: true,
    wasmAllowList: {
      blink: true,
      webkit: true,
      gecko: true,
    },
  },
});
```

## Example: Customize Flutter configuration based on URL query parameters {:#example-customizing-flutter-configuration-based-on-url-query-parameters}

The following example shows a custom `flutter_bootstrap.js` that enables
single-threaded mode when a `force_st` query parameter is present in the URL:

```js
{% raw %}{{flutter_js}}{% endraw %}
{% raw %}{{flutter_build_config}}{% endraw %}

const searchParams = new URLSearchParams(window.location.search);
const forceSt = searchParams.has('force_st');
const userConfig = forceSt ? { forceSingleThreadedSkwasm: true } : {};
_flutter.loader.load({
  config: userConfig,
});
```

This script evaluates the `URLSearchParams` of the page to determine whether
the user passed a `force_st` query parameter and configures the app accordingly.

## The onEntrypointLoaded callback

You can also pass an `onEntrypointLoaded` callback into the `load` API in order
to perform custom logic at different parts of the initialization process.
The initialization process is split into the following stages:

**Loading the entrypoint script**
: The `load` function calls the `onEntrypointLoaded` callback once the
  main entrypoint script has been downloaded and run by the browser.
  Flutter also calls `onEntrypointLoaded` on
  every hot restart during development.

**Initializing the Flutter engine**
: The `onEntrypointLoaded` callback receives an
  **engine initializer** object as its only parameter.
  Use the engine initializer `initializeEngine()` function to
  set the run-time configuration, like `multiViewEnabled: true`,
  and start the Flutter web engine.

**Running the app**
: The `initializeEngine()` function returns a [`Promise`][js-promise]
  that resolves with an **app runner** object. The app runner has a
  single method, `runApp()`, that runs the Flutter app.

**Adding views to (or removing views from) an app**
: The `runApp()` method returns a **flutter app** object.
  In multi-view mode, the `addView` and `removeView`
  methods can be used to manage app views from the host app.
  To learn more, check out [Embedded mode][embedded-mode].

[embedded-mode]: /platform-integration/web/embedding-flutter-web#embedded-mode
[js-promise]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise

:::warning
When you provide a custom `onEntrypointLoaded` callback,
`_flutter.loader.load()` consumes loader-stage options (such as
`wasmAllowList`, `renderer`, `entrypointBaseUrl`,
`forceSingleThreadedSkwasm`, `suppressMultithreadingWarning`,
`verboseBuildSelection`, and `wasmDeferredModulesLoader`),
but doesn't automatically forward the `config` object to
`engineInitializer.initializeEngine()`.

Pass the configuration object to both `_flutter.loader.load()` and
`initializeEngine()` so that both loader-stage and engine-stage settings
(such as `multiViewEnabled`, `hostElement`, `assetBase`, and `nonce`)
take effect:

```js
const flutterConfig = {
  renderer: 'canvaskit',
  assetBase: 'https://cdn.example.com/app/',
};

_flutter.loader.load({
  config: flutterConfig,
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine(flutterConfig);
    await appRunner.runApp();
  },
});
```

:::

## Example: Display a progress indicator

To give the user of your application feedback
during the initialization process,
use the hooks provided for each stage to update the DOM:

```js
{% raw %}{{flutter_js}}{% endraw %}
{% raw %}{{flutter_build_config}}{% endraw %}

const loading = document.createElement('div');
document.body.appendChild(loading);
loading.textContent = "Loading Entrypoint...";
_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    loading.textContent = "Initializing engine...";
    // If you have a `config`, pass it here. The config given to `load()`
    // is not forwarded when you supply your own `onEntrypointLoaded`.
    const appRunner = await engineInitializer.initializeEngine();

    loading.textContent = "Running app...";
    await appRunner.runApp();
  }
});
```

## Common warnings {:#common-warnings}

This section describes common web build and initialization warnings
and how to resolve them.

### Service worker deprecation {:#service-worker-version-deprecation}

If you experience a warning similar to the following during `flutter build web`:

```text
Warning: In index.html:37: Flutter's service worker is deprecated and will be removed in a future Flutter release.
See https://github.com/flutter/flutter/issues/156910 for more details.
```

Remove legacy service worker variables, registration calls, and
`serviceWorkerSettings` from your `web/index.html` or custom
`web/flutter_bootstrap.js` file:

```js
// Remove legacy serviceWorkerVersion declarations:
var serviceWorkerVersion = null;
const serviceWorkerVersion = null;

// Remove legacy flutter_service_worker.js registration calls:
navigator.serviceWorker.register('flutter_service_worker.js');

// Remove serviceWorkerSettings from _flutter.loader.load():
_flutter.loader.load({
  serviceWorkerSettings: {
    serviceWorkerVersion: {% raw %}{{flutter_service_worker_version}}{% endraw %},
  },
});
```

If your app requires a custom service worker, refer to the
[Web FAQ](/platform-integration/web/faq#how-do-i-configure-a-service-worker)
and [Web content hashing (`precache_manifest.json`)][web-content-hashing].

### FlutterLoader.loadEntrypoint deprecation

If you experience a warning similar to the following:

```text
Warning: In index.html:40: "FlutterLoader.loadEntrypoint" is deprecated.
Use "FlutterLoader.load" instead.
```

This warning occurs when an older `web/index.html` file uses
`_flutter.loader.loadEntrypoint()` instead of `_flutter.loader.load()`.
The CLI message references the `FlutterLoader` interface,
which JavaScript code accesses through `_flutter.loader`.

If your app uses the default initialization and doesn't require
custom bootstrapping, replace the legacy script block in `web/index.html`
with the standard script tag:

```html title="web/index.html"
<script src="flutter_bootstrap.js" async></script>
```

If you customized your initialization logic,
update your bootstrap code in `web/index.html`
(or a custom `web/flutter_bootstrap.js` file)
to call `_flutter.loader.load()` instead:

```js
_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
  }
});
```

To review an example that updates DOM elements during startup,
refer to the [progress indicator example][].

[progress indicator example]: #example-display-a-progress-indicator
