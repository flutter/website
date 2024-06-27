---
title: Build and release a web app
description: How to prepare for and release a web app.
short-title: Web
---

During a typical development cycle,
you test an app using `flutter run -d chrome`
(for example) at the command line.
This builds a _debug_ version of your app.

This page helps you prepare a _release_ version
of your app and covers the following topics:

* [Building the app for release](#building-the-app-for-release)
* [Deploying to the web](#deploying-to-the-web)
* [Deploying to Firebase Hosting](#deploying-to-firebase-hosting)
* [Handling images on the web](#handling-images-on-the-web)
* [Choosing a web renderer](#choosing-a-web-renderer)
* [Minification](#minification)

## Building the app for release

Build the app for deployment using the
`flutter build web` command.
You can also choose which renderer to use
by using the `--web-renderer` option (See [Web renderers][]).
This generates the app, including the assets,
and places the files into the `/build/web`
directory of the project.

The release build of a simple app has the
following structure:

```plaintext
/build/web
  assets
    AssetManifest.json
    FontManifest.json
    NOTICES
    fonts
      MaterialIcons-Regular.ttf
      <other font files>
    <image files>
    packages
      cupertino_icons
        assets
          CupertinoIcons.ttf
    shaders
      ink_sparkle.frag
  canvaskit
    canvaskit.js
    canvaskit.wasm
    profiling
      canvaskit.js
      canvaskit.wasm
  favicon.png
  flutter.js
  flutter_service_worker.js
  index.html
  main.dart.js
  manifest.json
  version.json
```

:::note
The `canvaskit` directory and its contents are only present when the
CanvasKit renderer is selected—not when the HTML renderer is selected.
:::

Launch a web server (for example,
`python -m http.server 8000`,
or by using the [dhttpd][] package),
and open the /build/web directory. Navigate to
`localhost:8000` in your browser
(given the python SimpleHTTPServer example)
to view the release version of your app.

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

## Choosing a web renderer

By default, the `flutter build` and `flutter run` commands
use the `auto` choice for the web renderer. This means that
your app runs with the HTML renderer on mobile browsers and
CanvasKit on desktop browsers. We recommend this combination
to optimize for the characteristics of each platform.

For more information, see [Web renderers][].

## Minification

Minification is handled for you when you
create a release build.

| Type of web app build | Code minified? | Tree shaking performed? |
|-----------------------|----------------|-------------------------|
| debug                 | No             | No                      |
| profile               | No             | Yes                     |
| release               | Yes            | Yes                     |

## Embedding a Flutter app into an HTML page

### `hostElement`

_Added in Flutter 3.10_<br>
You can embed a Flutter web app into
any HTML element of your web page.

To tell Flutter web in which element to render,
pass an object with a `config` field to the `_flutter.loader.load` function
that specifies a `HTMLElement` as the `hostElement`.

```html highlightLines=11-13
<html>
  <body>
    <!-- Ensure your flutter target is present on the page... -->
    <div id="flutter_host">Loading...</div>

    <script>
      {% raw %}{{flutter_js}}{% endraw %}
      {% raw %}{{flutter_build_config}}{% endraw %}

      _flutter.loader.load({
        config: {
          hostElement: document.getElementById('flutter_host'),
        }
      });
    </script>
  </body>
</html>
```

To learn more about other configuration options,
check out [Customizing web app initialization][customizing-web-init].

:::version-note
This method of specifying the `hostElement` was changed in Flutter 3.22.
To learn how to configure the `hostElement` in earlier Flutter versions,
reference [Legacy web app initialization][web-init-legacy].
:::

[customizing-web-init]: /platform-integration/web/initialization
[web-init-legacy]: /platform-integration/web/initialization-legacy

### Iframe

You can embed a Flutter web app,
as you would embed other content,
in an [`iframe`][] tag of an HTML file.
In the following example, replace "URL"
with the location of your HTML page:

```html
<iframe src="URL"></iframe>
```


## PWA Support

As of release 1.20, the Flutter template for web apps includes support
for the core features needed for an installable, offline-capable PWA app.
Flutter-based PWAs can be installed in the same way as any other web-based
PWA; the settings signaling that your Flutter app is a PWA are provided by
`manifest.json`, which is produced by `flutter create` in the `web` directory.

PWA support remains a work in progress,
so please [give us feedback][] if you see something that doesn't look right.

[dhttpd]: {{site.pub}}/packages/dhttpd
[Displaying images on the web]: /platform-integration/web/web-images
[Firebase Hosting]: {{site.firebase}}/docs/hosting/frameworks/flutter
[Firebase framework-aware CLI]: {{site.firebase}}/docs/hosting/frameworks/frameworks-overview
[install-firebase-cli]: {{site.firebase}}/docs/cli#install_the_firebase_cli
[GitHub Pages]: https://pages.github.com/
[give us feedback]: {{site.repo.flutter}}/issues/new?title=%5Bweb%5D:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version
[Google Cloud Hosting]: https://cloud.google.com/solutions/web-hosting
[`iframe`]: https://html.com/tags/iframe/
[Web renderers]: /platform-integration/web/renderers

