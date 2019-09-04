---
title: Preparing a web app for release
description: How to prepare for and release a web app.
short-title: Web
---

During a typical development cycle,
you test an app using `flutter run -d chrome`
(for example) at the command line.
This builds a _debug_ version of your app.

This page helps you prepare a _release_ version
of your app.

This page covers the following topics:

* [Adding a launcher icon](#adding-a-launcher-icon)
* [Obfuscation and minification](#obfuscation-and-minification)
* [Building the app for release](#building-the-app-for-release)
* [Deploying to the web](#deploying-to-the-web)

## Adding a launcher icon

TBD

## Obfuscation and minification

Obfuscation and minification  is handled for you when you
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

Launch a web server (for example,
`python -m SimpleHTTPServer 8000`,
or by using the [dhttpd][] package),
and open the /build/web directory. Navigate to
`localhost:8000` in your browser
(given the python example)
to view the release version of your app.

## Deploying to the web

The release build of a simple app has the following structure:

```none
/build/web
  assets
    AssetManifest.json
    FontManifest.json
    LICENSE
    fonts
      MaterialIcons-Regular.ttf
      <other font files>
    <image files>
  index.html
  main.dart.js
  main.dart.js.map
```

When you are ready to deploy your app,
upload the release bundle
to Firebase, the cloud, or a similar service.

In future, we plan to generate PWA configuration files
to support Progressive Web Apps.

[dhttpd]: {{site.pub}}/packages/dhttpd
