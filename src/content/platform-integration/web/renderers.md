---
title: Web renderers
description: How to choose a web renderer for running and building a web app.
---

When running and building apps for the web, you can choose between two different
renderers. This page describes both renderers and how to choose the best one for
your needs. The two renderers are:

**CanvasKit renderer**
: This renderer is fully consistent with Flutter mobile and desktop, has faster
  performance with higher widget density, but adds about 1.5MB in download size.
  [CanvasKit][canvaskit] uses WebGL to render Skia paint commands.

**HTML renderer**
: This renderer, which has a smaller download size than the CanvasKit renderer,
  uses a combination of HTML elements, CSS, Canvas elements, and SVG elements.

## Command line options

The `--web-renderer` command line option takes one of three values:
`canvaskit`, `html`, or `auto`.

* `canvaskit` (soon to be default) - always use the CanvasKit renderer
* `auto` (default) - automatically chooses which renderer to use. This option
    chooses the HTML renderer when the app is running in a mobile browser, and
    CanvasKit renderer when the app is running in a desktop browser.
* `html` - always use the HTML renderer

This flag can be used with the `run` or `build` subcommands. For example:

```console
flutter run -d chrome --web-renderer html
```

```console
flutter build web --web-renderer canvaskit
```

This flag is ignored when a non-browser (mobile or desktop) device
target is selected.

## Runtime configuration

To override the web renderer at runtime:

* Build the app with the `auto` option.
* Prepare a configuration object with the `renderer` property set to
  `"canvaskit"` or `"html"`.
* Pass that object to the `engineInitializer.initializeEngine(configuration);`
  method in the [Flutter Web app initialization][web-app-init] script.

```html
<body>
  <script>
    let useHtml = true;

    window.addEventListener('load', function(ev) {
    _flutter.loader.loadEntrypoint({
      serviceWorker: {
        serviceWorkerVersion: serviceWorkerVersion,
      },
      onEntrypointLoaded: function(engineInitializer) {
        let config = {
          renderer: useHtml ? "html" : "canvaskit",
        };
        engineInitializer.initializeEngine(config).then(function(appRunner) {
          appRunner.runApp();
        });
      }
    });
  });
  </script>
</body>
```

The web renderer can't be changed after the Flutter engine startup process
begins in `main.dart.js`.

:::note
Setting a `window.flutterWebRenderer`
(an approach used in previous releases) displays a
**deprecation notice** in the JS console. For more information,
check out [Customizing web app initialization][web-app-init].
:::

## Choosing which option to use

Choose the `canvaskit` option (default) if you are prioritizing performance and
pixel-perfect consistency on both desktop and mobile browsers.

Choose the `html` option if you are optimizing download size over performance on
both desktop and mobile browsers.

Choose the `auto` option if you are optimizing for download size on
mobile browsers and optimizing for performance on desktop browsers.

## Examples

Run in Chrome using the default renderer option (`auto`):

```console
flutter run -d chrome
```

Build your app in release mode, using the default (`auto`) option:

```console
flutter build web --release
```

Build your app in release mode, using just the CanvasKit renderer:

```console
flutter build web --web-renderer canvaskit --release
```

Run your app in profile mode using the HTML renderer:

```console
flutter run -d chrome --web-renderer html --profile
```

[canvaskit]: https://skia.org/docs/user/modules/canvaskit/
[file an issue]: {{site.repo.flutter}}/issues/new?title=[web]:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version
[web-app-init]: /platform-integration/web/initialization
