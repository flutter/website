---
title: Desktop support for Flutter
description: General information about Flutter support for desktop apps.
---

Flutter provides support for compiling
 a native Windows, macOS, or Linux desktop app.
Flutter's desktop support also extends to plugins&mdash;you
can install existing plugins that support the Windows,
macOS, or Linux platforms, or you can create your own.

## Requirements

To compile a desktop application, you must build it **on** the targeted
platform: build a Windows application on Windows, a macOS application on macOS,
and a Linux application on Linux.

To create a Flutter application with desktop support,
you need the following software:

* Flutter SDK. See the
  [Flutter SDK][] installation instructions.
* Optional: An IDE that supports Flutter.
  You can install [Android Studio][], [IntelliJ IDEA][],
  or [Visual Studio Code][] and
  [install the Flutter and Dart plugins][]
  to enable language support and tools for refactoring,
  running, debugging, and reloading your desktop app
  within an editor. See [setting up an editor][]
  for more details.

[Android Studio]: {{site.android-dev}}/studio/install
[Flutter SDK]: {{site.url}}/get-started/install
[install the Flutter and Dart plugins]: {{site.url}}/get-started/editor
[IntelliJ IDEA]: https://www.jetbrains.com/idea/download/
[setting up an editor]: {{site.url}}/get-started/editor
[Visual Studio Code]: {{site.url}}/development/tools/vs-code

### Additional Windows requirements

For Windows desktop development,
you need the following in addition to the Flutter SDK:

* [Visual Studio 2022][] When installing Visual Studio select the "Desktop
  development with C++" workload, including all of its default components, to
  install the necessary C++ toolchain and Windows SDK header files.

{{site.alert.note}}
  **Visual Studio** is different than Visual Studio _Code_.
{{site.alert.end}}

[Visual Studio 2022]: https://visualstudio.microsoft.com/downloads/

### Additional macOS requirements

For macOS desktop development,
you need the following in addition to the Flutter SDK:

* [Xcode][]
* [CocoaPods][] if you use plugins

[CocoaPods]: https://cocoapods.org/
[Xcode]: {{site.apple-dev}}/xcode/

### Additional Linux requirements

For Linux desktop development,
you need the following in addition to the Flutter SDK:

* [Clang][]
* [CMake][]
* [GTK development headers][]
* [Ninja build][]
* [pkg-config][]
* [liblzma-dev][] This dependency may be required

One easy way to install the Flutter SDK along with the necessary
dependencies is by using [snapd][].
For more information, see [Installing snapd][].

Once you have `snapd`, you can install Flutter
using the [Snap Store][], or at the command line:

```terminal
$ sudo snap install flutter --classic
```

Alternatively, if you prefer not to use `snapd`,
you can use the following command:

```terminal
$ sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

[Clang]: https://clang.llvm.org/
[CMake]: https://cmake.org/
[GTK development headers]: https://developer.gnome.org/gtk3/3.2/gtk-getting-started.html
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[Ninja build]: https://ninja-build.org/
[pkg-config]: https://www.freedesktop.org/wiki/Software/pkg-config/
[liblzma-dev]: https://packages.debian.org/sid/liblzma-dev
[Snap Store]: https://snapcraft.io/store
[snapd]: https://snapcraft.io/flutter

## Create a new project

You can use the following steps
to create a new project with desktop support.

### Set up

On Windows, desktop support is enabled on Flutter 2.10 or higher.
On macOS and Linux, desktop support is enabled on Flutter 3 or higher.

You might run `flutter doctor` to see if there are any unresolved issues.
You should see a checkmark for each successfully configured area. It should look
something like the following on Windows, with an entry for "develop for Windows":

```terminal
C:\> flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.0.0, on Microsoft Windows [Version 10.0.19044.1706], locale en-US)
[✓] Chrome - develop for the web
[✓] Visual Studio - develop for Windows (Visual Studio Professional 2022 17.2.0)
[✓] VS Code (version 1.67.2)
[✓] Connected device (3 available)
[✓] HTTP Host Availability

• No issues found!
```

On macOS, look for a line like this:

```terminal
[✓] Xcode - develop for iOS and macOS
```

On Linux, look for a line like this:

```terminal
[✓] Linux toolchain - develop for Linux desktop
```

If `flutter doctor` finds problems or missing components for a platform that you
don't want to develop for, you can ignore those warnings. Or you can disable the
platform altogether using the `flutter config` command, for example:

```terminal
$ flutter config --no-enable-ios
```

After enabling desktop support, restart your IDE so that it can detect the new
device.

### Create and run

Creating a new project with desktop support is no different
than [creating a new Flutter project][] for other platforms.

Once you've configured your environment for desktop
support, you can create and run a desktop application
either in the IDE or from the command line.

[creating a new Flutter project]: {{site.url}}/get-started/test-drive

#### Using an IDE

After you've configured your environment to support
desktop, make sure you restart the IDE if it was
already running.

Create a new application in your IDE and it automatically
creates iOS, Android, web, and desktop versions of your app.
From the device pulldown, select **windows (desktop)**,
**macOS (desktop)**, or **linux (desktop)**
and run your application to see it launch on the desktop.

[web support]: {{site.url}}/get-started/web

#### From the command line

To create a new application that includes desktop support
(in addition to mobile and web support), run the following commands,
substituting `my_app` with the name of your project:

```terminal
$ flutter create my_app
$ cd my_app
```

To launch your application from the command line,
enter one of the following commands from the top
of the package:

```terminal
C:\> flutter run -d windows
$ flutter run -d macos
$ flutter run -d linux
```

{{site.alert.note}}
  If you do not supply the `-d` flag, `flutter run` lists
  the available targets to choose from.
{{site.alert.end}}

## Build a release app

To generate a release build,
run one of the following commands:

```terminal
PS C:\> flutter build windows
$ flutter build macos
$ flutter build linux
```

## Add desktop support to an existing Flutter app

To add desktop support to an existing Flutter project,
run the following command in a terminal from the
root project directory:

```terminal
$ flutter create --platforms=windows,macos,linux .
```

This adds the necessary desktop files and directories
to your existing Flutter project.
To add only specific desktop platforms,
change the `platforms` list to include only
the platform(s) you want to add.

## Plugin support

Flutter on the desktop supports using and creating plugins.
To use a plugin that supports desktop,
follow the steps for plugins in [using packages][].
Flutter automatically adds the necessary native code
to your project, as with any other platform.

### Writing a plugin

When you start building your own plugins,
you’ll want to keep federation in mind.
Federation is the ability to define several
different packages, each targeted at a
different set of platforms, brought together
into a single plugin for ease of use by developers.
For example, the Windows implementation of the
`url_launcher` is really `url_launcher_windows`,
but a Flutter developer can simply add the
`url_launcher` package to their `pubspec.yaml`
as a dependency and the build process pulls in
the correct implementation based on the target platform.
Federation is handy because different teams with
different expertise can build plugin implementations
for different platforms.
You can add a new platform implementation to any
endorsed federated plugin on pub.dev,
so long as you coordinate this effort with the
original plugin author.

For more information, including information
about endorsed plugins, see the following resources:

* [Developing packages and plugins][], particularly the
  [Federated plugins][] section.
* [How to write a Flutter web plugin, part 2][],
  covers the structure of federated plugins and
  contains information applicable to desktop
  plugins.
* [Modern Flutter Plugin Development][] covers
  recent enhancements to Flutter's plugin support.

[using packages]: {{site.url}}/development/packages-and-plugins/using-packages
[Developing packages and plugins]: {{site.url}}/development/packages-and-plugins/developing-packages
[Federated plugins]: {{site.url}}/development/packages-and-plugins/developing-packages#federated-plugins
[How to write a Flutter web plugin, part 2]: {{site.flutter-medium}}/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6
[Modern Flutter Plugin Development]: {{site.flutter-medium}}/modern-flutter-plugin-development-4c3ee015cf5a

## Samples and codelabs

[Write a Flutter desktop application][]
: A codelab that walks you through building
a desktop application that integrates the GitHub
GraphQL API with your Flutter app.

You can run the following samples as desktop apps,
as well as download and inspect the source code to
learn more about Flutter desktop support.

Flutter Gallery [running web app][], [repo][flutter-gallery-repo]
: A samples project hosted on GitHub to help developers
  evaluate and use Flutter. The Gallery consists of a
  collection of Material design widgets, behaviors,
  and vignettes implemented with Flutter.
  You can clone the project and run Gallery as a desktop app
  by following the instructions provided in the [README][].
  
Flokk [announcement blogpost][gskinner-flokk-blogpost], [repo][gskinner-flokk-repo]
: A Google contacts manager that integrates with GitHub and Twitter.
  It syncs with your Google account, imports your contacts,
  and allows you to manage them.

[Photo Search app][]
: A sample application built as a desktop application that
  uses desktop-supported plugins.

[Photo Search app]: {{site.repo.organization}}/samples/tree/main/desktop_photo_search
[running web app]: {{site.gallery}}
[flutter-gallery-repo]: {{site.repo.gallery}}
[README]: {{site.repo.gallery}}#readme
[gskinner-flokk-repo]: {{site.github}}/gskinnerTeam/flokk
[gskinner-flokk-blogpost]: https://blog.gskinner.com/archives/2020/09/flokk-how-we-built-a-desktop-app-using-flutter.html
[Write a Flutter desktop application]: {{site.codelabs}}/codelabs/flutter-github-client
