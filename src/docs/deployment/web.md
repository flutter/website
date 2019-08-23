---
title: Preparing a web app for release
description: How to prepare for and release a web app.
short-title: Web
---

During a typical development cycle,
you test an app using `flutter run -d chrome`
(for example) at the command line.
This builds a _profile_ version of your app.

This page helps you prepare a _release_ version
of your app.

This page covers the following topics:

* [Adding a launcher icon](#adding-a-launcher-icon)
* [Signing the app ??](#signing-the-app)
* [Building the app for release](#building-the-app-for-release)
* [Deploying to the web](#deploying-to-the-web)

## Adding a launcher icon

TBD

## Signing the app

Is signing an available option for web apps?

What about obfuscation and minification?
Are web apps automatically obfuscated and minified?

## Building the app for release

Build the app for deployment using the
`flutter build web` command.
This generates the app, including the assets,
and places the files into the `/build/web`
directory of the project.

Launch a web server (for example,
`python -m SimpleHTTPServer 8000`)
and open the /build/web directory. Navigate to
`localhost:8000` in your browser to view the release
version of your app.

## Deploying to the web

When you are ready to deploy your app,
upload the release bundle
to Firebase, the cloud, or a similar service.
(Anything else to say here?)

