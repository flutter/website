---
title: Flutter web app initialization
description: Customize how Flutter apps are initialized on the web.
---

:::note
This page describes APIs that are available in Flutter 3.22 and later.
To customize web app initialization in Flutter 3.21 or earlier,
check out the previous [Customizing web app initialization][] documentation.
:::

[Customizing web app initialization]: /platform-integration/web/initialization-legacy

This page details the initialization process for Flutter web apps, and
how this process can be customized.

## `flutter_bootstrap.js`

When building your flutter app, the `flutter build web` command produces
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

<a id="customizing-initialization" aria-hidden="true"></a>

## Customize initialization

By default, `flutter build web` generates a `flutter_bootstrap.js` file that
does a simple initialization of your Flutter app.
However, in some scenarios, you might have a reason to
customize this initialization process, such as:

* Setting a custom Flutter configuration for your app.
* Changing the settings for the Flutter service worker.
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
| `{% raw %}{{flutter_js}}{% endraw %}` | The JavaScript code that makes the `FlutterLoader` object available in the `_flutter.loader` global variable. (See the `_flutter.loader.load() API` section below for more details.) |
| `{% raw %}{{flutter_build_config}}{% endraw %}` | A JavaScript statement that sets metadata produced by the build process which gives the `FlutterLoader` information needed to properly bootstrap your application. |
| `{% raw %}{{flutter_service_worker_version}}{% endraw %}` | A unique number representing the build version of the service worker, which can be passed as part of the service worker configuration (see the "Service Worker Settings" table below). |
| `{% raw %}{{flutter_bootstrap_js}}{% endraw %}` | As mentioned above, this inlines the contents of the `flutter_bootstrap.js` file directly into the `index.html` file. Note that this token can only be used in the `index.html` and not the `flutter_bootstrap.js` file itself. |

{:.table}

<a id="write-a-custom-flutter_bootstrap-js" aria-hidden="true"></a>

## Write a custom `flutter_bootstrap.js` {:#custom-bootstrap-js}

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

## The `_flutter.loader.load()` API

The `_flutter.loader.load()` JavaScript API can be invoked with optional
arguments to customize initialization behavior:

| Name                    | Description                                                                                                                   | JS&nbsp;type |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------|--------------|
| `config`                | The Flutter configuration of your app.                                                                                        | `Object`     |
| `onEntrypointLoaded`    | The function called when the engine is ready to be initialized. Receives an `engineInitializer` object as its only parameter. | `Function`   |
| `serviceWorkerSettings` | The configuration for the `flutter_service_worker.js` loader. (If not set, the service worker isn't used.)                    | `Object`     |

{:.table}

The `config` argument is an object that can have the following optional fields:

| Name | Description | Dart&nbsp;type |
|---|---|---|
|`assetBase`| The base URL of the `assets` directory of the app. Add this when Flutter loads from a different domain or subdirectory than the actual web app. You might need this when you embed Flutter web into another app, or when you deploy its assets to a CDN. |`String`|
|`canvasKitBaseUrl`| The base URL from where `canvaskit.wasm` is downloaded. |`String`|
|`canvasKitVariant`| The CanvasKit variant to download. Your options cover:<br><br>1. `auto`: Downloads the optimal variant for the browser. The option defaults to this value.<br>2. `full`: Downloads the full variant of CanvasKit that works in all browsers.<br>3. `chromium`: Downloads a smaller variant of CanvasKit that uses Chromium compatible APIs. **_Warning_**: Don't use the `chromium` option unless you plan on only using Chromium-based browsers. |`String`|
|`canvasKitForceCpuOnly`| When `true`, forces CPU-only rendering in CanvasKit (the engine won't use WebGL). |`bool`|
|`canvasKitMaximumSurfaces`| The maximum number of overlay surfaces that the CanvasKit renderer can use. |`double`|
|`debugShowSemanticNodes`| If `true`, Flutter visibly renders the semantics tree onscreen (for debugging).  |`bool`|
|`hostElement`| HTML Element into which Flutter renders the app. When not set, Flutter web takes over the whole page. |`HtmlElement`|
|`renderer`| Specifies the [web renderer][web-renderers] for the current Flutter application, either `"canvaskit"` or `"html"`. |`String`|

{:.table}

[web-renderers]: /platform-integration/web/renderers

The `serviceWorkerSettings` argument has the following optional fields.

| Name                   | Description                                                                                                                             | JS&nbsp;type |
|------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|--------------|
| `serviceWorkerUrl`     | The URL of the Service Worker JS file. The `serviceWorkerVersion` is appended to the URL. Defaults to `"flutter_service_worker.js?v="`. | `String`     |
| `serviceWorkerVersion` | Pass *the `serviceWorkerVersion` variable* set by the build process in your **`index.html`** file.                                      | `String`     |
| `timeoutMillis`        | The timeout value for the service worker load. Defaults to `4000`.                                                                      | `Number`     |

{:.table}

## Example: Customizing Flutter configuration based on URL query parameters

The following example shows a custom `flutter_bootstrap.js` that allows
the user to force the app to use the `CanvasKit` renderer by providing
a query parameter called `?force_canvaskit=true` in the URL of their website:

```js
{% raw %}{{flutter_js}}{% endraw %}
{% raw %}{{flutter_build_config}}{% endraw %}

const searchParams = new URLSearchParams(window.location.search);
const forceCanvaskit = searchParams.get('force_canvaskit') === 'true';
const userConfig = forceCanvaskit ? {'renderer': 'canvaskit'} : {};
_flutter.loader.load({
  config: userConfig,
  serviceWorkerSettings: {
    serviceWorkerVersion: {% raw %}{{flutter_service_worker_version}}{% endraw %},
  },
});
```

This script evaluates the `URLSearchParams` of the page to determine whether
the user passed `force_canvaskit=true` and then
changes the user configuration of the Flutter app.
It also passes the service worker settings to use the flutter service worker,
along with the service worker version.

## The `onEntrypointLoaded` callback

You can also pass an `onEntrypointLoaded` callback into the `load` API in order
to perform custom logic at different parts of the initialization process.
The initialization process is split into the following stages:

**Loading the entrypoint script**
: The `load` function calls the `onEntrypointLoaded` callback once the
  Service Worker is initialized, and the `main.dart.js` entrypoint has
  been downloaded and run by the browser.
  Flutter also calls `onEntrypointLoaded` on
  every hot restart during development.

**Initializing the Flutter engine**
: The `onEntrypointLoaded` callback receives an
  **engine initializer** object as its only parameter.
  Use the engine initializer to set the run-time configuration, and
  start the Flutter web engine.

**Running the app**
: The `initializeEngine()` function returns a [`Promise`][js-promise]
  that resolves with an **app runner** object. The app runner has a
  single method, `runApp()`, that runs the Flutter app.

[js-promise]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise

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
    const appRunner = await engineInitializer.initializeEngine();

    loading.textContent = "Running app...";
    await appRunner.runApp();
  }
});
```

## Upgrade an older project

If your project was created in Flutter 3.21 or earlier, you can create a new
`index.html` file with the latest initialization template by running
`flutter create` as follows.

First, remove the files from your `/web` directory.

Then, from your project directory, run the following:

```console
$ flutter create . --platforms=web
```
