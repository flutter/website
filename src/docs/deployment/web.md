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

* [Minification](#minification)
* [Building the app for release](#building-the-app-for-release)
* [Deploying to the web](#deploying-to-the-web)


## Minification

Minification is handled for you when you
create a release build.

A debug build of a web app is not minified and
tree shaking has not been performed.

A profile build is not minified and tree shaking
has been performed.

A release build is both minified and tree shaking
has been performed.

## Building the app for release

Build the app for deployment using the
`flutter build web` command.
This generates the app, including the assets,
and places the files into the `/build/web`
directory of the project.

The release build of a simple app has the
following structure:

```none
/build/web
  assets
    AssetManifest.json
    FontManifest.json
    NOTICES
    fonts
      MaterialIcons-Regular.ttf
      <other font files>
    <image files>
  index.html
  main.dart.js
  main.dart.js.map
```

Launch a web server (for example,
`python -m http.server 8000`,
or by using the [dhttpd][] package),
and open the /build/web directory. Navigate to
`localhost:8000` in your browser
(given the python SimpleHTTPServer example)
to view the release version of your app.

## Embedding a Flutter app into an HTML page

You can embed a Flutter web app,
as you would embed other content,
in an [`iframe`][] tag of an HTML file.
In the following example, replace "URL"
with the location of your HTML page:

```html
<iframe src="URL"></iframe>
```

## Deploying to the web

When you are ready to deploy your app,
upload the release bundle
to Firebase, the cloud, or a similar service.
Here are a few possibilities, but there are
many others:

* [Firebase Hosting][]
* [GitHub Pages][]
* [Google Cloud Hosting][]

## PWA Support
By default Flutter template for web apps now includes support for the core features needed for an installable, offline-capable PWA app.
Flutter-based PWAs can be installed in the same way as any other web-based PWA; the settings signaling that your Flutter app is a PWA are provided by manifest.json, which is produced by flutter create in the web/ subfolder.

PWA support remains a work in progress, so please give us feedback if you see something that doesn’t look right.

[dhttpd]: {{site.pub}}/packages/dhttpd
[Firebase Hosting]: https://firebase.google.com/docs/hosting
[GitHub Pages]: https://pages.github.com/
[Google Cloud Hosting]: https://cloud.google.com/solutions/smb/web-hosting/
[`iframe`]: https://html.com/tags/iframe/

