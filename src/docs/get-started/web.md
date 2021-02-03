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

{{site.alert.note}}
  Flutter has early support for running web applications, but
  you need to be running the `beta` channel of Flutter at present.
  If you experience a problem that hasn’t yet been reported,
  please [file an issue][] and make sure that "web" appears in the title.
{{site.alert.end}}

## Create a new project with web support

You can use the following steps
to create a new project with web support.

### Set up

Run the following commands to use the latest version of the Flutter SDK
from the beta channel and enable web support:

```terminal
$ flutter channel beta
$ flutter upgrade
$ flutter config --enable-web
```

{{site.alert.warning}}
  Running `flutter channel beta` replaces your current version of Flutter
  with the beta version and can take time if your connection is slow.
  After this, running `flutter upgrade` upgrades your install to the latest
 `beta`.  Returning to the stable channel (or any other) requires calling
 `flutter channel <channel>` explicitly.
{{site.alert.end}}

{% comment %}
[PENDING: Do we really need the following note?]
{% endcomment %}
{{site.alert.note}}
  The `flutter upgrade` command silently fails
  when `origin` points to a personal fork.
  To validate that `origin` points to `{{site.repo.flutter}}.git`,
  run the following commands in the root directory
  of your local copy of the `{{site.repo.flutter}}` repository:

  ```terminal
  $ cd <inside local copy of the flutter/flutter repo>
  $ git remote get-url origin
  https://github.com/flutter/flutter.git
  ```
{{site.alert.end}}

Once web is enabled,
the `flutter devices` command outputs a `Chrome` device
that opens the Chrome browser with your app running,
and a `Web Server` that provides the URL serving the app.

```terminal
$ flutter devices
2 connected device:

Web Server • web-server • web-javascript • Flutter Tools
Chrome     • chrome     • web-javascript • Google Chrome 81.0.4044.129
```

**After enabling web support, restart your IDE.**
You should now see **Chrome (web)** and
**Web Server (web)** in the device pulldown.

{{site.alert.note}}
  You only need to execute `flutter config --enable-web` once.
  You can always check the status of your configuration using
  the no-argument `flutter config` command.
{{site.alert.end}}

### Create and run

Creating a new project with web support is no different
than [creating a new Flutter project][] for other platforms.

Once you've configured your environment for web
support, you can create and run a web app either
in the IDE or from the command line.

#### IDE

After you've configured your environment to support
the web, make sure you restart the IDE if it was
already running.

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

To add web support to an existing project,
run the following command in a
terminal from the root project directory:

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
