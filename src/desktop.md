---
title: Desktop support for Flutter
description: Announcing the alpha release of Flutter for desktop.
toc: true
---

Desktop support allows you to compile Flutter source code
to a native macOS Desktop app. Flutter's desktop
support also extends to plugins&mdash;you can
install existing plugins that support the macOS platform,
or you can create your own.

{{site.alert.note}}
  **This page covers desktop support for macOS
  which is available as an alpha release.**
  Window and Linux platforms are still under development.
  You can try Windows and Linux platform support
  as explained in the [Desktop shells][] page in the
  [Flutter wiki][].
  If you experience a problem that hasn’t yet been reported,
  please [file an issue][] and make sure that "desktop:macos",
  for example, appears in the title.
{{site.alert.end}}

## Requirements

To create a Flutter app with macOS support, you need the
following software:

* Flutter SDK. See the
  [Flutter SDK][] installation instructions.
* [Xcode][]
* [CocoaPods][] if you use plugins
* Optional: An IDE that supports Flutter.
  You can install [Android Studio][], [IntelliJ IDEA][],
  or [Visual Studio Code][] and
  [install the Flutter and Dart plugins][]
  to enable language support and tools for refactoring,
  running, debugging, and reloading your desktop app
  within an editor. See [setting up an editor][]
  for more details.

## Create a new project

You can use the following steps
to create a new project with macOS support.

### Set up

At the command line, perform the following commands to
make sure that you have the latest support for macOS and that
it's enabled. If you see "flutter: command not found",
then make sure that you have installed the
[Flutter SDK][] and that it’s in your path.

```terminal
$ flutter channel master  # or dev
$ flutter upgrade
$ flutter config --enable-macos-desktop
```

To ensure that desktop _is_ installed,
list the devices available.
You should see something like the following:

``` terminal
$ flutter devices
1 connected device:

macOS      • macOS      • darwin-x64     • Mac OS X 10.15.4 19E266
```

You might also run `flutter doctor` to see if there are
any unresolved issues. It should look something like
the following:

```terminal
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, 1.18.0-10.0.pre, on Mac OS X 10.15.4 19E287, locale
    en-US)
 
[✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
[✓] Xcode - develop for iOS and macOS (Xcode 11.2)
[✓] Chrome - develop for the web
[✓] Android Studio (version 3.6)
[✓] VS Code (version 1.44.2)
[✓] Connected device (3 available)

• No issues found!
```

**After enabling macOS support, restart your IDE.**
You should now see **macOS (desktop)** in the device pulldown.

{{site.alert.note}}
  You only need to execute `flutter config --enable-desktop` once. 
  You can always check the status of your configuration using
  the no-argument `flutter config` command.
{{site.alert.end}}

### Create and run

Creating a new project with desktop support is no different
than [creating a new Flutter project][] for other platforms.

Once you've configured your environment for desktop
support, you can create and run a desktop app either
in the IDE or from the command line.

#### IDE

After you've configured your environment to support
desktop, make sure you restart the IDE if it was
already running.

Create a new app in your IDE and it automatically
creates iOS, Android, and macOS versions of your app.
(And web, too, if you've enabled [web support][].)
From the device pulldown, select **macOS (desktop)**
and run your app to see it launch on the desktop.

#### Command line

To create a new app that includes desktop support
(in addition to mobile support), run the following commands,
substituting `myapp` with the name of your project:

```terminal
$ flutter create myapp
$ cd myapp
```
To launch your app from the command line,
enter the following from the top of the package:

```terminal
$ flutter run -d macos
```

{{site.alert.note}}
  If there aren't any other connected devices,
  the `-d macos` is optional.
{{site.alert.end}}

### Build

To generate a release build run the following command:

```terminal
$ flutter build macos
```

## Add desktop support to an existing app

To add desktop support to an existing project,
run the following command in a terminal from the
root project directory:

```terminal
$ flutter create .
```

This adds the necessary files and directories to your
Flutter project.

## Entitlements and the App Sandbox

macOS builds are configured by default to be signed,
and sandboxed with App Sandbox.
This means that if you want to confer specific
capabilities or services on your macOS app,
such as the following:

* Accessing the internet
* Capturing movies and images from the built-in camera 
* Accessing files

Then you must set up specific _entitlements_ in Xcode.
The following section tells you how to do this.

### Setting up entitlements

Managing sandbox settings is done in the
`macos/Runner/*.entitlements` files. When editing
these files, you shouldn't remove the original
`Runner-DebugProfile.entitlements` exceptions
(that support incoming network connections and JIT),
as they are necessary for the `debug` and `profile`
modes to function correctly.

If you are used to managing entitlement files through
the **Xcode capabilities UI**, be aware that the capabilities
editor updates only one of the two files or,
in some cases, it creates a whole new entitlements
file and switches the project to use it for all configurations.
Either scenario causes issues. We recommend that you
edit the files directly. Unless you have a very specific
reason, you should always make identical changes to both files.

If you keep the App Sandbox enabled (which is required if you
plan to distribute your app in the App Store), you need to manage
entitlements for your application when you add certain plugins
or other native functionality. For instance, using the
[`file_chooser`][] plugin requires adding either the
`com.apple.security.files.user-selected.read-only` or
`com.apple.security.files.user-selected.read-write` entitlement.
Another common entitlement is `com.apple.security.network.client`,
which you must add if you make any network requests.

{{site.alert.secondary}}
  **Important:** The `com.apple.security.network.server`
  entitlement, which allows incoming network connections,
  is enabled by default only for `debug` and `profile`
  builds to enable communications between Flutter tools
  and a running app. If you need to allow incoming
  network requests in your application,
  you must add the `com.apple.security.network.server`
  entitlement to `Runner-Release.entitlements` as well,
  otherwise your app will work correctly for debug or
  profile testing, but will fail with release builds.
{{site.alert.end}}

For more information on these topics,
see [App Sandbox][] and [Entitlements][]
on the Apple Developer site.

## Hardened runtime

If you choose to distribute your application outside
of the App Store, you need to notarize your application
for compatibility with macOS 10.15+.
This requires enabling the Hardened Runtime option.
Once you have enabled it, you need a valid signing
certificate in order to build.

By default, the entitlements file allows JIT for debug builds but,
as with App Sandbox, you may need to manage other entitlements.
If you have both App Sandbox and Hardened Runtime enabled,
you may need to add multiple entitlements for the same resource.
For instance, microphone access would require both
`com.apple.security.device.audio-input` (for Hardened Runtime)
and `com.apple.security.device.microphone` (for App Sandbox).

For more information on this topic,
see [Hardened Runtime][] on the Apple Developer site.

## Plugin support

Flutter on the desktop supports using and creating plugins.

To use a plugin that supports macOS,
follow the steps for plugins in [using packages][].
Flutter automatically adds the necessary native code
to your project, as with iOS or Android.

These are a few of the plugins that support desktop
on macOS:

* [`url_launcher`][]
* [`shared_preferences`][]
* [`connectivity`][]
* [`path_provider`][]

### Creating a plugin

Federated plugins are a recent addition to
Flutter's plugin support. They allow you to
separate functionality for different platforms
into different packages; so the Android
implementation can be in one package,
and the macOS implementation in another.
Desktop plugins are perfectly suited
to be implemented as part of a federated
plugin. For more information, see
the following resources:

* [Developing packages and plugins][], including the
  [Federated plugins][] section.
* [How to write a Flutter web plugin, part 2][],
  covers the structure of federated plugins and
  contains information applicable to desktop
  plugins.
* [Modern Flutter Plugin Development][] covers
  recent enhancements to Flutter's plugin support.
* [Federated Plugin proposal][]

## Samples

You can run the following samples as desktop apps,
as well as download and inspect the source code to
learn more about Flutter desktop support.

Flutter Gallery [running web app][], [repo][]
: A samples project hosted on GitHub to help developers
  evaluate and use Flutter. The Gallery consists of a
  collection of Material design widgets, behaviors,
  and vignettes implemented with Flutter.
  You can clone the project and run Gallery as a desktop app
  by following the instructions provided in the [README][].

[Photo Search app][]
: A sample app built as a desktop application that uses
  the following desktop-supported plugins:
  * [`file_chooser`][]
  * [`menubar`][]
  * [`url_launcher`][]

## What's next

Stay tuned for updates on desktop support!
We continue to develop support for macOS,
Windows, and Linux.

Watch the [Desktop shells][] page on the [Flutter wiki][]
for more information and ongoing updates.


[Android Studio]: {{site.android-dev}}/studio/install
[App Sandbox]: https://developer.apple.com/documentation/security/app_sandbox
[CocoaPods]: https://cocoapods.org/
[`connectivity`]: {{site.pub}}/packages/connectivity
[Desktop shells]: {{site.repo.flutter}}/wiki/Desktop-shells
[Developing packages and plugins]: /docs/development/packages-and-plugins/developing-packages
[Federated Plugin proposal]: /go/federated-plugins
[Federated plugins]: /docs/development/packages-and-plugins/developing-packages#federated-plugins
[creating a new Flutter project]: /docs/get-started/test-drive
[Entitlements]: https://developer.apple.com/documentation/bundleresources/entitlements
[file an issue]: {{site.github}}/flutter/flutter/issues/new?title=[desktop]:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-desktop&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_desktop%20version,+browser+version
[`file_chooser`]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/file_chooser
[Flutter SDK]: /docs/get-started/install
[Flutter wiki]: {{site.repo.flutter}}/wiki/
[flutter-desktop-embedding]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins#dart
[Hardened Runtime]: https://developer.apple.com/documentation/security/hardened_runtime
[How to write a Flutter web plugin, part 2]: https://medium.com/flutter/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6
[install the Flutter and Dart plugins]: /docs/get-started/editor
[IntelliJ IDEA]: https://www.jetbrains.com/idea/download/
[`menubar`]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/menubar
[Modern Flutter Plugin Development]: {{site.medium}}/flutter/modern-flutter-plugin-development-4c3ee015cf5a
[`path_provider`]: {{site.pub}}/packages/path_provider
[Photo Search app]: {{site.repo.organization}}/samples/tree/master/experimental/desktop_photo_search
[README]: {{site.github}}/flutter/gallery#flutter-gallery
[repo]: {{site.github}}/flutter/flutter/tree/master/dev/integration_tests/flutter_gallery
[running web app]: https://flutter.github.io/gallery/#/
[setting up an editor]: /docs/get-started/editor
[`shared_preferences`]: {{site.pub}}/packages/shared_preferences
[`url_launcher`]: {{site.pub}}/packages/url_launcher
[using packages]: /docs/development/packages-and-plugins/using-packages
[Visual Studio Code]: /docs/development/tools/vs-code
[web support]: /docs/get-started/web
[Xcode]: https://developer.apple.com/xcode/
