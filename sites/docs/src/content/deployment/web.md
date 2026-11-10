---
title: Build and release a web app
description: How to prepare for and release a web app.
shortTitle: Web
---

During a typical development cycle,
you test an app using `flutter run -d chrome`
(for example) at the command line.
This builds a _debug_ version of your app.

This page helps you prepare a _release_ version
of your app and covers the following topics:

* [Building the app for release](#building-the-app-for-release)
* [Web content hashing and HTTP caching](#web-content-hashing)
* [Deploying WebAssembly in production](#deploy-webassembly-in-production)
* [Deploying to the web](#deploying-to-the-web)
* [Deploying to Firebase Hosting](#deploying-to-firebase-hosting)
* [Handling images on the web](#handling-images-on-the-web)
* [Minification](#minification)
* [Mobile browser viewport and SafeArea](#mobile-browser-viewport-and-safearea)

## Building the app for release

Build the app for deployment using the `flutter build web` command.

```console
flutter build web
```

To build your application with WebAssembly (Wasm), pass the `--wasm` flag:

```console
flutter build web --wasm
```

This
generates the app, including the assets, and places the files into the
`/build/web` directory of the project.

To validate the release build of your app,
launch a web server (for example,
`python -m http.server 8000`,
or by using the [dhttpd][] package),
and open the /build/web directory. Navigate to
`localhost:8000` in your browser
(given the python SimpleHTTPServer example)
to view the release version of your app.

## Additional build flags

You might need to deploy a profile or debug build for testing.
To do this, pass the `--profile` or `--debug` flag
to the `flutter build web` command.
Profile builds are specialized for performance profiling in Chrome DevTools,
while debug builds enable assertions for development testing.

To customize compiler optimizations for either WebAssembly (`dart2wasm`)
or JavaScript (`dart2js`), pass `-O<0-4>` (or `--optimization-level=<0-4>`):

* In `--release` and `--profile` modes, `dart2wasm` defaults to `-O2`
  (sound optimizations), whereas `dart2js` defaults to `-O4`.
* In `--profile` mode, `flutter build web --wasm --profile` automatically
  passes `-O2 --no-strip-wasm --no-minify` so function and type names remain
  readable in performance traces.

To learn how optimization levels affect `dart2wasm` code generation,
consult [Dart WebAssembly compilation][dart-wasm].

### Source maps

To generate source maps for symbolication in crash reporting services,
pass the `--source-maps` flag:

```console
flutter build web --source-maps
```

Generating source maps creates separate `.js.map` or `.wasm.map` files
(or both, depending on your build target) in the `build/web` directory
without adding binary overhead to the compiled output.

:::warning Exclude source maps from public hosting
By default, standard web deployment tools upload all files in `build/web/`.
If source maps are deployed publicly, browser DevTools will
automatically download them, exposing un-minified symbol names,
class hierarchies, and local file paths.

Upload `.map` files to your private error-monitoring service
(such as Sentry or Datadog) during CI/CD, and exclude `*.map` files
from public web hosting (for example, using `"ignore": ["**/*.map"]`
in `firebase.json` or stripping them prior to deployment).
:::

### Web content hashing (--web-content-hash) {:#web-content-hashing}

:::version-note
Web content hashing (`--web-content-hash`) requires Flutter 3.50 or later.
:::

To enable automatic content-based cache busting across deployments, pass
`--web-content-hash` to `flutter build web`:

```console
flutter build web --wasm --web-content-hash
```

When `--web-content-hash` is enabled, Flutter embeds an 8-character truncated
SHA-256 content hash into compiled entrypoints and all files under
`build/web/assets/**`, and records the hashed paths in `flutter_bootstrap.js`
(`_flutter.buildConfig`):

* **Hashed immutable files (`Cache-Control: public, max-age=31536000, immutable`)**:
  * Compiled entrypoints: `main.dart.<hash>.js`, `main.dart.<hash>.wasm`, and
    `main.dart.<hash>.mjs` (plus `main.dart.<hash>.js.map` and
    `main.dart.<hash>.mjs.map` if `--source-maps` is enabled).
  * All files under `assets/**`: including `AssetManifest.<hash>.bin`,
    `AssetManifest.bin.<hash>.json`, `FontManifest.<hash>.json`,
    `NOTICES.<hash>`, fonts, images, and `shaders/**`.
* **Unhashed bootstrap and root files (`Cache-Control: max-age=0, must-revalidate` or `no-cache`)**:
  * `index.html`, `flutter_bootstrap.js`, `flutter.js`, `manifest.json`,
    `version.json`, `404.html`, and `icons/**`.
  * Bundled `canvaskit/**` files when building with `--no-web-resources-cdn`.
  * `main.dart.wasm.map` when building with `--source-maps` (the `.wasm`
    binary's `sourceMappingURL` custom section references the unhashed
    `.wasm.map` filename).

For a complete `firebase.json` example, refer to the [Web FAQ][web-faq-caching].

:::note
`--web-content-hash` does not yet support deferred imports (`deferred as`) in
either JavaScript (`dart2js`) or WebAssembly (`dart2wasm` /
`--enable-wasm-deferred-loading`) builds.
:::

#### Overlay deployments for active browser tabs

When you deploy a new release (`N`), users with an already-open browser tab
running the previous release (`N-1`) might lazily fetch an asset, font, or
image whose filename carries release `N-1`'s content hash.

To avoid mid-session `404` errors during rollouts, use an **overlay
deployment** strategy:

* Retain at least the previous release's (`N-1`) hashed `main.dart.*` and
  `assets/**` files in your CDN or storage bucket alongside release `N`'s
  hashed files (or prune old hashes after a 24–72 hour grace window).
* Update `index.html` and `flutter_bootstrap.js` atomically last.
* Exclude `/assets/**`, `/canvaskit/**`, `/icons/**`, and `/main.dart.*` from
  single-page application (SPA) `/index.html` catch-all rewrites so missing
  assets return a genuine `404` instead of `200 text/html`.

#### Custom service workers (`precache_manifest.json`)

When `--web-content-hash` is enabled, `flutter build web` writes a bill of
materials to `build/web/precache_manifest.json`:

```json title="build/web/precache_manifest.json"
{
  "version": 1,
  "entries": [
    {
      "url": "flutter_bootstrap.js",
      "hash": "a1b2c3d4",
      "size": 10432,
      "urlHashed": false
    },
    {
      "url": "main.dart.f215ce97.wasm",
      "hash": "f215ce97",
      "size": 1842104,
      "urlHashed": true
    }
  ]
}
```

Custom PWA service workers or [Workbox][] pipelines can consume
`precache_manifest.json` directly (passing `revision: entry.urlHashed ? null : entry.hash`
so URL-hashed files aren't double-cached with query parameters).

<a id="opting-in-to-webassembly" aria-hidden="true"></a>

## Deploying WebAssembly in production {:#deploy-webassembly-in-production}

Running `flutter build web --wasm` produces a dual-target release bundle
in `build/web`:

* **WebAssembly target (`skwasm` + `dart2wasm`)**:
  Emits `main.dart.wasm` and its JS runtime module `main.dart.mjs`,
  paired with the `skwasm` rendering engine.
* **JavaScript fallback (CanvasKit + `dart2js`)**:
  Emits `main.dart.js`, paired with the CanvasKit renderer.

At startup, `flutter_bootstrap.js` probes the browser's WebAssembly capabilities
and automatically falls back to `main.dart.js` when a browser doesn't support
the required Wasm features or isn't enabled in `wasmAllowList`.
For browser compatibility details,
refer to [Support for WebAssembly (Wasm)][Wasm support].
For `dart2wasm` compiler internals,
consult [Dart WebAssembly compilation][dart-wasm].

### Configure server headers and compression {:#server-headers-and-compression}

Configure the production web server or CDN with the following response headers
and compression settings:

* **Wasm MIME type**:
  Serve all `.wasm` files with `Content-Type: application/wasm`
  so browsers can stream-compile modules during download using
  `WebAssembly.compileStreaming()`.
* **Cross-origin isolation for multi-threaded rendering**:
  Return `Cross-Origin-Opener-Policy: same-origin` and
  `Cross-Origin-Embedder-Policy: credentialless` (or `require-corp`)
  on the document response to enable `SharedArrayBuffer` and
  multi-threaded `skwasm` rendering.
  To learn more about `credentialless` isolation,
  visit the [Chrome COEP credentialless guide][coep].
* **Static pre-compression**:
  Pre-compress `.wasm`, `.mjs`, `.js`, font files, and asset manifests
  using Brotli (`br`) and Gzip (`gzip`) during CI/CD or at CDN ingest
  to minimize transfer size over the network.

### Reduce cold-start latency {:#reduce-cold-start-latency}

To shorten time-to-first-frame on cold cache loads:

* **Inline the bootstrap script**:
  Replace the external `<script src="flutter_bootstrap.js" async></script>` tag
  in `web/index.html` with an inline `<script>` containing
  `{% raw %}{{flutter_bootstrap_js}}{% endraw %}`.
  Inlining eliminates an extra network round-trip before the browser begins
  downloading `main.dart.wasm` and the rendering engine.
  For template syntax details, refer to [Bootstrapping][web-init-bootstrapping].
* **Trim initial bundle weight**:
  Release builds enable font icon tree shaking automatically
  (pass `--no-tree-shake-icons` only when debugging dynamic icon code points).
  To split large features into on-demand `.wasm` chunks,
  build with `--enable-wasm-deferred-loading`.
  Keep in mind that `--enable-wasm-deferred-loading` is incompatible with
  `--web-content-hash`.
* **Render an HTML loading shell**:
  Include lightweight HTML and CSS inside `web/index.html`
  (or update DOM state from `onEntrypointLoaded` in `flutter_bootstrap.js`)
  so users receive immediate visual feedback while the engine initializes.

### Serve assets from a CDN or self-hosted origin {:#multi-asset-and-cdn-loading}

Customize where engine binaries, compiled modules, and assets load from to
match the hosting architecture and privacy requirements:

* **Self-host engine binaries and fallback fonts**:
  Pass `--no-web-resources-cdn` to bundle CanvasKit and `skwasm` files
  directly into `build/web/canvaskit/` instead of fetching them from
  `gstatic.com` at runtime.
  When using `--web-content-hash`, bundled files under `canvaskit/**` remain
  unhashed and should use revalidating cache headers.
* **Serve static assets from a dedicated CDN**:
  Pass `--static-assets-url=https://cdn.example.com/` to `flutter build web`
  at build time, or configure `assetBase` and `entrypointBaseUrl` in
  `_flutter.loader.load({ config: ... })` at runtime.
  When using `--enable-wasm-deferred-loading` with custom asset routing,
  provide a `wasmDeferredModulesLoader` callback to fetch deferred `.wasm`
  modules from the CDN.
  For configuration details,
  refer to [Customize the Flutter loader][web-init-loader].

## Deploying to the web

When you are ready to deploy your app,
upload the release bundle
to Firebase, the cloud, or a similar service.
Here are a few possibilities, but there are
many others:

* [Firebase Hosting][]
* [GitHub Pages][]
* [Google Cloud Hosting][]

## Deploying to Firebase Hosting

You can use the Firebase CLI to build and release your Flutter app with Firebase
Hosting.

### Before you begin

To get started, [install or update][install-firebase-cli] the Firebase CLI:

```console
npm install -g firebase-tools
```

### Initialize Firebase

1. Enable the web frameworks preview to the [Firebase framework-aware CLI][]:

    ```console
    firebase experiments:enable webframeworks
    ```

2. In an empty directory or an existing Flutter project, run the initialization
command:

    ```console
    firebase init hosting
    ```

3. Answer `yes` when asked if you want to use a web framework.

4. If you're in an empty directory,
    you'll be asked to choose your web framework. Choose `Flutter Web`.

5. Choose your hosting source directory; this could be an existing flutter app.

6. Select a region to host your files.

7. Choose whether to set up automatic builds and deploys with GitHub.

8. Deploy the app to Firebase Hosting:

    ```console
    firebase deploy
    ```

    Running this command automatically runs `flutter build web --release`,
    so you don't have to build your app in a separate step.

To learn more, visit the official [Firebase Hosting][] documentation for
Flutter on the web.

## Handling images on the web

The web supports the standard `Image` widget to display images.
By design, web browsers run untrusted code without harming the host computer.
This limits what you can do with images compared to mobile and desktop platforms.

For more information, see [Displaying images on the web][].

## Minification

To improve app start-up the compiler reduces the size of the compiled code by
removing unused code (known as _tree shaking_), and by renaming code symbols to
shorter strings (e.g. by renaming `AlignmentGeometryTween` to something like
`ab`). Which of these two optimizations are applied depends on the build mode:

| Type of web app build | Code minified? | Tree shaking performed? |
|-----------------------|----------------|-------------------------|
| debug                 | No             | No                      |
| profile               | No             | Yes                     |
| release               | Yes            | Yes                     |

## Mobile browser viewport and SafeArea {:#mobile-browser-viewport-and-safearea}

:::version-note
Support for `viewport-fit=cover` `SafeArea` insets and URL percent-encoding
preservation in browser history requires Flutter 3.50 or later.
:::

On mobile browsers (such as iOS Safari and Android Chrome) with display cutouts,
notches, or home indicators, Flutter web defaults to rendering within the
browser's safe area (`viewport-fit=contain`).

To render edge-to-edge across the entire screen and populate Flutter's
[`SafeArea`][] and [`MediaQuery.paddingOf`][] with the browser's CSS
`env(safe-area-inset-*)` insets, add a `<meta name="viewport">` tag with
`viewport-fit=cover` inside the `<head>` of your `web/index.html` file (included
as a commented-out option in newly created `web/index.html` templates):

```html title="web/index.html"
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
```

:::note
If an existing web app already includes `viewport-fit=cover` in
`web/index.html`, Flutter 3.50 and later honors it instead of stripping it,
which causes the app to render behind device cutouts unless UI controls are
wrapped in a [`SafeArea`][] widget. For migration details, refer to the
[`viewport-fit=cover` SafeArea breaking change guide][viewport-fit-breaking].
:::

### URL percent-encoding in browser history

In Flutter 3.50 and later, route strings passed to
`SystemNavigator.routeInformationUpdated` preserve percent-encoded sequences
(such as `%2F`, `%26`, `%23`, and `%20`) when written to the browser's URL bar
and history, rather than decoding them using `Uri.decodeComponent`.

## Embedding a Flutter app into an HTML page

See [Embedding Flutter web][].

[Embedding Flutter web]: /platform-integration/web/embedding-flutter-web

[coep]: https://developer.chrome.com/blog/coep-credentialless-origin-trial
[dart-wasm]: {{site.dart-site}}/web/wasm
[dhttpd]: {{site.pub}}/packages/dhttpd
[Displaying images on the web]: /platform-integration/web/web-images
[Firebase Hosting]: {{site.firebase}}/docs/hosting/frameworks/flutter
[Firebase framework-aware CLI]: {{site.firebase}}/docs/hosting/frameworks/frameworks-overview
[install-firebase-cli]: {{site.firebase}}/docs/cli#install_the_firebase_cli
[GitHub Pages]: https://pages.github.com/
[give us feedback]: {{site.repo.flutter}}/issues/new?title=%5Bweb%5D:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version
[Google Cloud Hosting]: https://cloud.google.com/solutions/web-hosting
[`MediaQuery.paddingOf`]: {{site.api}}/flutter/widgets/MediaQuery/paddingOf.html
[`SafeArea`]: {{site.api}}/flutter/widgets/SafeArea-class.html
[viewport-fit-breaking]: /release/breaking-changes/viewport-fit-cover-safe-area
[Wasm support]: /platform-integration/web/wasm
[web-faq-caching]: /platform-integration/web/faq#how-do-i-configure-my-cache-headers
[web-init-bootstrapping]: /platform-integration/web/initialization#bootstrapping
[web-init-loader]: /platform-integration/web/initialization#customize-the-flutter-loader
[Workbox]: https://github.com/GoogleChrome/workbox
