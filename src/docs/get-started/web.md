---
title: Building a web application with Flutter
description: Instructions for creating a Flutter app for the web.
---

This page covers the following steps for getting started with web support:
- Configure the `flutter` tool for web support.
- Add web support to an existing project and/or create a new project with web
  support.
- Run and build an app with web support.

## Requirements
- [Install Chrome]. Currently, debugging a web app requires the Chrome browser.
- [Install flutter on your platform]. If you don't yet have the `flutter` tool installed, follow the instructions to install flutter on your platform, and return to this page.

For more information, see the [web FAQ][].

{{ site.alert.warning }}
As of 1.9, Flutter has early support for running web applications. There are
still missing features and known performance issues, so it **isn't recommended
for production use.**
{{ site.alert.end }}

## Summary

The following steps **add web support to an existing project**.

Assuming that you have the `flutter` tool installed, run the following commands
in a terminal from the root project directory:

```terminal
$ cd <project directory>
$ flutter channel dev
$ flutter upgrade
$ flutter config --enable-web
$ flutter create .
$ flutter run -d chrome
```

To generate a release build:

```terminal
$ flutter build web
```

The rest of this page breaks this process down
into individual steps.

## Download the Flutter SDK

Currently, you need either the master or dev channel of the Flutter SDK
for web support. Assuming that you already have the
`flutter` tool installed, run the following commands
to install the latest version from the dev channel:

```terminal
$ flutter channel dev
$ flutter upgrade
```

The `flutter upgrade` command silently fails
when "origin" points to a personal fork.
To validate that "origin" points to the
"flutter/flutter" repo, enter the following:

```terminal
$ cd <inside local copy of the flutter/flutter repo>
$ git remote get-url origin
ssh://git@github.com/flutter/flutter.git
```

## Enable web support

Use the config command to enable web support:

```terminal
$ flutter config --enable-web
```

You need only run this once.
This command modifies (or creates) the
`~/.flutter_settings` file (on Mac/Linux)
with the following:

```shell
{
  "enable-web": true
}
```

Once web is enabled,
`flutter devices` outputs a device named `Chrome`.

```terminal
$ flutter devices
1 connected device:

Chrome • chrome • web-javascript • Google Chrome 76.0.3809.100
```

**After enabling web support, restart the IDE.**
You should now see **Chrome (web)** in the device pulldown.

The `flutter run` command launches the application using the
[development compiler][] in a Chrome browser.
The name of the web device is currently `chrome`,
but this doesn't need to be specified
if there are no other devices attached.

## Add web support to an existing app

To add web support to an existing project, run the following command in a
terminal from the root project directory:

```terminal
$ flutter create .
```

## Create a new app with web support

To create a new app that includes web support
(in addition to mobile support), run the following,
substituting `myapp` with the name of your project:

```terminal
$ flutter create myapp
```

## Run the web app

To run the app on the web, enter the following
from the top of the package:

```terminal
$ flutter run -d chrome
```

If there aren't any other connected devices,
the `-d chrome` is optional.

## Generate a release build

Run the following, from the top of the project:

```terminal
$ flutter build web
```

A release build uses [dart2js][] (instead of
the [development compiler][]) to produce a single
JavaScript file.  This can be run with the release flag
or built using `flutter build web`. This outputs files at
`build/web`, including the assets, which need to be served together.



[dart2js]: https://dart.dev/tools/dart2js
[development compiler]: https://dart.dev/tools/dartdevc
[web FAQ]: /docs/development/platform-integration/web
[install Chrome]: https://www.google.com/chrome/
[install flutter on your platform]: https://flutter.dev/docs/get-started/install
