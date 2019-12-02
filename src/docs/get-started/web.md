---
title: Building a web application with Flutter
description: Instructions for creating a Flutter app for the web.
---

This page covers the following steps for getting started with web support:
- Configure the `flutter` tool for web support.
- Create a new project with web support.
- Run a new project with web support.
- Build an app with web support.
- Add web support to an existing project.

## Requirements
- [Install the Flutter SDK on your platform][Install Flutter].
- [Install Chrome]. Currently, debugging a web app requires the Chrome browser.

For more information, see the [web FAQ][].

{{ site.alert.warning }}
As of 1.9, Flutter has early support for running web applications.
There are still missing features and known performance issues,
so it **isn't recommended for production use.**
{{ site.alert.end }}

## Create a new project with web support

You can use the following steps
to create a new project with web support.
Assuming that you have the `flutter` tool installed,
run the following commands in a terminal from the root project directory.

### Set up
Currently, you need either the master or dev channel of the Flutter SDK
for web support. Assuming that you already have the
`flutter` tool installed, run the following commands
to install the latest version from the beta channel
and enable web support:

```terminal
$ flutter channel beta
$ flutter upgrade
$ flutter config --enable-web
```

{{site.alert.note}}
The `flutter upgrade` command silently fails
when `origin` points to a personal fork.
To validate that `origin` points to the "flutter/flutter" repo,
run the following commands in the root directory
of your local copy of the "flutter/flutter" repository:

```
$ cd <inside local copy of the flutter/flutter repo>
$ git remote get-url origin
ssh://git@github.com/flutter/flutter.git
```
{{site.alert.end}}
Once web is enabled,
the `flutter devices` command outputs a device named `Chrome`:

```terminal
$ flutter devices
2 connected device:

Chrome     • chrome     • web-javascript • Google Chrome 78.0.3904.108
Web Server • web-server • web-javascript • Flutter Tools
```

**After enabling web support, restart your IDE.**
You should now see **Chrome (web)** in the device pulldown.

{{site.alert.note}}
You should only need to execute these configure steps once. You can always
check the status of your configuration using the `flutter config` command.
{{site.alert.end}}

### Create and run

To create a new app that includes web support
(in addition to mobile support), run the following,
substituting `myapp` with the name of your project:

```terminal
$ flutter create myapp
$ cd myapp
```

To serve your app from `localhost` in Chrome,
enter the following from the top of the package:

```terminal
$ flutter run -d chrome
```
{{site.alert.note}}
If there aren't any other connected devices,
the `-d chrome` is optional.
{{site.alert.end}}

The `flutter run` command launches the application using the
[development compiler][] in a Chrome browser.
The name of the web device is currently `chrome`,
but this doesn't need to be specified
if there are no other devices attached.

### Build

Run the following command to generate a release build:

```terminal
$ flutter build web
```

A release build uses [dart2js][] (instead of the [development compiler][])
to produce a single JavaScript file `main.dart.js`.
You can create a release build using release mode (`flutter run --release`)
or by using `flutter build web`. This populates a `build/web` directory
with built files, including an `assets` directory,
which need to be served together.

{%comment%} add link to deploy / build doc {%endcomment%}

### Add web support to an existing app

To add web support to an existing project,
run the following command in a
terminal from the root project directory:

```terminal
$ flutter create .
```
To serve your app from `localhost` in Chrome,
enter the following from the top of the package:

```terminal
$ flutter run -d chrome
```

[dart2js]: https://dart.dev/tools/dart2js
[development compiler]: https://dart.dev/tools/dartdevc
[web FAQ]: /docs/development/platform-integration/web
[install Chrome]: https://www.google.com/chrome/
[Install Flutter]: https://flutter.dev/docs/get-started/install