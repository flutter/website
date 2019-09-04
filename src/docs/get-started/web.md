---
title: Building a web application with Flutter
description: Instructions for creating a Flutter app for the web.
---

{% comment %}
  TODO: Once published, remove this page on the GitHub wiki:
  (https://github.com/flutter/flutter/wiki/Building-a-web-application-with-Flutter)
  and forward to this page.
{% endcomment %}

As of 1.9, Flutter has early support for running web
applications. There are still missing features and known
performance issues, so it
**isn't recommended for production use.**

{{site.alert.note}}
  Currently, web support requires the Chrome browser.
  If you haven't already, [install Chrome][].
{{site.alert.end}}

For more information, see the [web FAQ][].

## Summary

Here are the short and sweet instructions to get started.
To add support to an existing project,
run the following commands in a terminal from the
top of the project package:

```terminal
flutter channel master
flutter upgrade
flutter config --enable-web
flutter create .
flutter run -d chrome
```

To generate a release build:

```terminal
flutter build web
```

The rest of this page breaks this process down
into individual steps.

## Download the Flutter SDK

Currently, you need the master channel of the Flutter SDK
for web support:

```terminal
flutter channel master
flutter upgrade
```

## Enable web support

Use the config command to enable web support:

```terminal
flutter config --enable-web
```

You need only run this once.

Once this is enabled,
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

To add web support to an existing project,
run the following command in a terminal
from the top of the project package:

```terminal
flutter create .
```

## Create a new app with web support

To create a new app that includes web support
(in addition to mobile support), run the following,
substituting `myapp` with the name of your project:

```terminal
flutter create myapp
```

## Run the web app

To run the app on the web, enter the following
from the top of the package:

```terminal
flutter run -d chrome
```

If there aren't any other connected devices,
the `-d chrome` is optional.

## Generate a release build

Run the following, from the top of the project:

```terminal
flutter build web
```

A release build uses [dart2js][]
(instead of the development compiler) to produce a single
JavaScript file.  This can be run with the release flag
or built using `flutter build web`. This outputs files at
`build/web`, including the assets, which need to be served together.
There is no support for building a debug build,
since they consist of potentially thousands of small files.



[dart2js]: https://dart.dev/tools/dart2js
[development compiler]: https://dart.dev/tools/dartdevc
[web FAQ]: /docs/development/platform-integration/web
[install Chrome]: https://www.google.com/chrome/
