---
title: Building a web application with Flutter
description: Instructions for creating a Flutter app for the web.
---

This page covers the following steps for getting started with web support:

* Configure the `flutter` tool for web support.
* Create a new project with web support.
* Run a new project with web support.
* Build an app with web support.
* Add web support to an existing project.

## Requirements

To create a Flutter app with web support,
you need the following software:

* Flutter SDK. See the
  [Flutter SDK][] installation instructions.
* [Chrome][]; debugging a web app requires
  the Chrome browser.
* Optional: An IDE that supports Flutter.
  You can install [Android Studio][], [IntelliJ IDEA][],
  or [Visual Studio Code][] and
  [install the Flutter and Dart plugins][]
  to enable language support and tools for refactoring,
  running, debugging, and reloading your web app
  within an editor. See [setting up an editor][]
  for more details.

[Android Studio]: https://developer.android.com/studio
[IntelliJ IDEA]: https://www.jetbrains.com/idea/
[Visual Studio Code]: https://code.visualstudio.com/


For more information, see the [web FAQ][].

## Create a new project with web support

You can use the following steps
to create a new project with web support.

### Set up

Run the following commands to use the latest version of the Flutter SDK:

```terminal
$ flutter channel stable
$ flutter upgrade
```

{{site.alert.warning}}
  Running `flutter channel stable` replaces your current version of Flutter
  with the stable version and can take time if your connection is slow.
  After this, running `flutter upgrade` upgrades your install to the latest
 `stable`.  Returning to another channel (beta, dev, or master) requires calling
 `flutter channel <channel>` explicitly.
{{site.alert.end}}

If Chrome is installed,
the `flutter devices` command outputs a `Chrome` device
that opens the Chrome browser with your app running,
and a `Web Server` that provides the URL serving the app.

```terminal
$ flutter devices
1 connected device:

Chrome (web) • chrome • web-javascript • Google Chrome 88.0.4324.150
```

In your IDE, you should see **Chrome (web)** in the device pulldown.

### Create and run

Creating a new project with web support is no different
than [creating a new Flutter project][] for other platforms.

#### IDE

Create a new app in your IDE and it automatically
creates iOS, Android, and web versions of your app.
(And macOS, too, if you've enabled [desktop support][].)
From the device pulldown, select **Chrome (web)**
and run your app to see it launch in Chrome.

#### Command line

To create a new app that includes web support
(in addition to mobile support), run the following commands,
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
[development compiler] in a Chrome browser.

{{site.alert.warning}}
  **Hot reload is not supported in a web browser**
  Currently, Flutter supports **hot restart**,
  but not **hot reload** in a web browser.
{{site.alert.end}}

### Build

Run the following command to generate a release build:

```terminal
$ flutter build web
```

A release build uses [dart2js][]
(instead of the [development compiler][])
to produce a single JavaScript file `main.dart.js`.
You can create a release build using release mode
(`flutter run --release`) or by using `flutter build web`.
This populates a `build/web` directory
with built files, including an `assets` directory,
which need to be served together.

You can also include `--web-renderer html`  or `--web-renderer canvaskit` to
select between the HTML or CanvasKit renderers, respectively. For more
information, see [Web renderers][].

For more information, see
[Build and release a web app][].

## Add web support to an existing app

To add web support to an existing project
created using a previous version of Flutter,
run the following command
from your project's directory:

```terminal
$ flutter create .
```

[Build and release a web app]: /docs/deployment/web
[creating a new Flutter project]: /docs/get-started/test-drive
[dart2js]: https://dart.dev/tools/dart2js
[desktop support]: /desktop
[development compiler]: https://dart.dev/tools/dartdevc
[file an issue]: {{site.github}}/flutter/flutter/issues/new?title=[web]:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version
[install the Flutter and Dart plugins]: /docs/get-started/editor
[setting up an editor]: /docs/get-started/editor
[web FAQ]: /docs/development/platform-integration/web
[Chrome]: https://www.google.com/chrome/
[Flutter SDK]: https://flutter.dev/docs/get-started/install
[Web renderers]: /docs/development/tools/web-renderers
