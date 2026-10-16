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
* [Deploying to the web](#deploying-to-the-web)
* [Deploying to Firebase Hosting](#deploying-to-firebase-hosting)
* [Handling images on the web](#handling-images-on-the-web)
* [Opting-in to WebAssembly](#opting-in-to-webassembly)
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
Profile builds are specialized for performance profiling using Chrome DevTools,
and debug builds can be used to configure dart2js
to respect assertions and change the optimization level (using the `-O` flag.)

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

See the [Web FAQ][web-faq-caching] for a complete `firebase.json` example.

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
deployment** strategy: retain at least the previous release's (`N-1`) hashed
`main.dart.*` and `assets/**` files in your CDN or storage bucket alongside
release `N`'s hashed files (or prune old hashes after a 24–72 hour grace
window), and update `index.html` and `flutter_bootstrap.js` atomically last.
Also exclude `/assets/**`, `/canvaskit/**`, `/icons/**`, and `/main.dart.*`
from single-page application (SPA) `/index.html` catch-all rewrites so missing
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

## Opting-in to WebAssembly

To compile and optimize your app for WebAssembly,
use the `--wasm` flag when running or building.

For more information, see [Support for WebAssembly (Wasm)][Wasm support].

:::important Serving WebAssembly builds
WebAssembly builds use multiple threads for improved rendering performance
and require your web server to return specific COEP/COOP HTTP response headers
(`Cross-Origin-Embedder-Policy: credentialless` and
`Cross-Origin-Opener-Policy: same-origin`).
For full details, see [Support for WebAssembly (Wasm)][Wasm support].
:::

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
wrapped in a [`SafeArea`][] widget. For migration details, see the
[`viewport-fit=cover` SafeArea breaking change guide][viewport-fit-breaking].
:::

### URL percent-encoding in browser history

In Flutter 3.50 and later, route strings passed to
`SystemNavigator.routeInformationUpdated` preserve percent-encoded sequences
(such as `%2F`, `%26`, `%23`, and `%20`) when written to the browser's URL bar
and history, rather than decoding them via `Uri.decodeComponent`.

## Embedding a Flutter app into an HTML page

See [Embedding Flutter web][].

[Embedding Flutter web]: /platform-integration/web/embedding-flutter-web

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
[Workbox]: https://github.com/GoogleChrome/workbox
