---
title: Desktop support for Flutter
description: Announcing the alpha release of Flutter for desktop.
toc: true
---

Desktop support allows you to compile Flutter source code
to a native Windows, macOS, or Linux desktop app. Flutter's desktop
support also extends to plugins&mdash;you can install 
existing plugins that support the macOS or Linux platforms,
or you can create your own.

{{site.alert.warning}}
  **Alpha!**
  This page covers desktop support,
  which is available as alpha-quality
  features in the Flutter dev channel.
  Support still has notable feature gaps,
  including accessibility support.
{{site.alert.end}}

{{site.alert.note}}
  To compile a desktop app, you must build the app **on**
  the targeted platform: build a Windows app on Windows,
  a macOS app on macOS, and a Linux app on Linux.
  If you experience a problem that hasn’t yet been reported,
  please file an issue and include
  "desktop:macos/linux/windows"
  (whichever platform is appropriate) in the title.
{{site.alert.end}}

[file an issue]: {{site.github}}/flutter/flutter/issues/new?title=[desktop]:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-desktop&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_desktop%20version,+browser+version

## Requirements

To create a Flutter app with desktop support, you need the
following software:

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
[Flutter SDK]: /docs/get-started/install
[install the Flutter and Dart plugins]: /docs/get-started/editor
[IntelliJ IDEA]: https://www.jetbrains.com/idea/download/
[setting up an editor]: /docs/get-started/editor
[Visual Studio Code]: /docs/development/tools/vs-code

### Additional Windows requirements

For Windows desktop development,
you need the following in addition to the Flutter SDK:

* [Visual Studio 2019][] (not to be confused with Visual Studio Code)
  with the "Desktop development with C++" workload installed,
  including all of its default components

[Visual Studio 2019]: https://visualstudio.microsoft.com/downloads/

### Additional macOS requirements

For macOS desktop development,
you need the following in addition to the Flutter SDK:

* [Xcode][]
* [CocoaPods][] if you use plugins

[CocoaPods]: https://cocoapods.org/
[Xcode]: https://developer.apple.com/xcode/

### Additional Linux requirements

For Linux desktop development,
you need the following in addition to the Flutter SDK:

* [Clang][]
* [CMake][]
* [GTK development headers][]
* [Ninja build][]
* [pkg-config][]
* libblkid
* liblzma

The easiest way to install the Flutter SDK along with these
dependencies is by using [snapd][].
For more information, see [Installing snapd][].

Once you have `snapd`, you can install Flutter using the [Snap Store][],
or at the command line:

```terminal
$ sudo snap install flutter --classic
```

If `snapd` is unavailable on the Linux distro you're using,
you might use the following command:

```terminal
$ sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev libblkid-dev liblzma-dev
```

[Clang]: https://clang.llvm.org/
[CMake]: https://cmake.org/
[GTK development headers]: https://developer.gnome.org/gtk3/3.2/gtk-getting-started.html
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[Ninja build]: https://ninja-build.org/
[pkg-config]: https://www.freedesktop.org/wiki/Software/pkg-config/
[Snap Store]: https://snapcraft.io/store
[snapd]: https://snapcraft.io/flutter

## Create a new project

You can use the following steps
to create a new project with desktop support.

### Set up

At the command line, perform the following commands to
make sure that you have the latest desktop support and that
it's enabled. If you see "flutter: command not found",
then make sure that you have installed the
[Flutter SDK][] and that it’s in your path.

```terminal
$ flutter channel dev
$ flutter upgrade
$ flutter config --enable-<platform>-desktop
```

Where _&lt;platform&gt;_ is `windows`, `macos`, or `linux`:

```terminal
$ flutter config --enable-windows-desktop
$ flutter config --enable-macos-desktop
$ flutter config --enable-linux-desktop
```

To ensure that desktop _is_ installed,
list the devices available.
You should see something like the following
(you'll see Windows, macOS, or Linux,
depending on which platforms you've enabled):

``` terminal
$ flutter devices
1 connected device:

Windows (desktop) • windows • windows-x64 • Microsoft Windows [Version 10.0.18362.1082]
macOS (desktop) • macos • darwin-x64 • Mac OS X 10.15.5 19F101
Linux (desktop) • linux • linux-x64 • Linux
```

You might also run `flutter doctor` to see if there are
any unresolved issues. It should look something like
the following on Windows:

```terminal
[✓] Flutter (Channel master, 1.22.0-10.0.pre.196, on Microsoft Windows [Version 10.0.18362.1082], locale en-US)
[✓] Visual Studio - develop for Windows (Visual Studio Professional 2019 16.6.2)
[✓] VS Code (version 1.48.2)
[✓] Connected device (1 available)
```

On macOS, you might see something like the following:

```terminal
[✓] Flutter (Channel master, 1.18.0-10.0.pre, on Mac OS X 10.15.4 19E287, locale
    en-US)
[✓] Xcode - develop for iOS and macOS (Xcode 11.2)
[✓] Chrome - develop for the web
[✓] VS Code (version 1.44.2)
[✓] Connected device (3 available)
```

On Linux, you might see something like the following:

```terminal
$ flutter doctor
[✓] Flutter (Channel master, 1.20.0-1.0.pre.132, on Linux, locale en_US.UTF-8)
[✓] Linux toolchain - develop for Linux desktop
[✓] VS Code (version 1.33.1)
[✓] Connected device (1 available)
```

If `flutter doctor` finds problems for a platform you don't
support, you can ignore those warnings. You don't have
to install Android Studio and the Android SDK,
for example, if you're writing a Linux desktop app.

**After enabling desktop support, restart your IDE.**
You should now see **windows (desktop)**, **macOS (desktop)**, or 
**linux (desktop)** in the device pulldown.

{{site.alert.note}}
  You only need to execute `flutter config --enable-<platform>-desktop`
  once.  You can always check the status of your configuration using
  the no-argument `flutter config` command.
{{site.alert.end}}

### Create and run

Creating a new project with desktop support is no different
than [creating a new Flutter project][] for other platforms.

Once you've configured your environment for desktop
support, you can create and run a desktop app either
in the IDE or from the command line.

[creating a new Flutter project]: /docs/get-started/test-drive

#### IDE

After you've configured your environment to support
desktop, make sure you restart the IDE if it was
already running.

Create a new app in your IDE and it automatically
creates iOS, Android, and desktop versions of your app.
(And web, too, if you've enabled [web support][].)
From the device pulldown, select **windows (desktop)**,
**macOS (desktop)**, or **linux (desktop)**
and run your app to see it launch on the desktop.

[web support]: /docs/get-started/web

#### Command line

To create a new app that includes desktop support
(in addition to mobile support), run the following commands,
substituting `myapp` with the name of your project:

```terminal
$ flutter create myapp
$ cd myapp
```
To launch your app from the command line,
enter one of the following commands from the top
of the package:

```terminal
$ flutter run -d windows
$ flutter run -d macos
$ flutter run -d linux
```

{{site.alert.note}}
  If there aren't any other connected devices,
  the `-d <platform>` tag is optional.
{{site.alert.end}}

### Build a release app

To generate a release build run one of the following commands:

```terminal
$ flutter build windows
$ flutter build macos
$ flutter build linux
```

### Distribution

**In general, we don't recommend releasing a desktop app until
desktop support is stable.**
There are not yet full instructions, or tooling support,
for making distributable applications. However,
here is some information about how to use the current
build output on other machines for testing purposes.

#### Windows

The executable can be found in your project under
`build\windows\runner\<build mode>\`.
In addition to that executable, you need the following:

* From the same directory:
    * all the `.dll` files
    * the `data` directory
* The Visual C++ redistributables.
  You can use any of the methods shown in the
  [deployment example walkthroughs][] on the Microsoft site.
  If you use the `application-local` option, you need to copy:
    * `msvcp140.dll`
    * `vcruntime140.dll`
    * `vcruntime140_1.dll`

Place the DLL files in a directory next to the executable
and the other DLLs, and bundle them together in a zip file.

[deployment example walkthroughs]: https://docs.microsoft.com/en-us/cpp/windows/deployment-examples?view=vs-2019

#### macOS

The `.app` is self-contained, and can be distributed as-is.

#### Linux

For information on publishing a Linux app to the
[Snap Store][], see
[Build and release a Linux desktop app][].

As the tooling solidifies, stay tuned for updates on other ways
to distribute a Linux desktop app.

[Build and release a Linux desktop app]: /docs/deployment/linux

## Add desktop support to an existing Flutter app

To add desktop support to an existing Flutter project,
run the following command in a terminal from the
root project directory:

```terminal
$ flutter create .
```

This adds the necessary desktop files and directories to your
existing Flutter project.

## macOS-specific support

The following information applies only to macOS development.

### Entitlements and the App Sandbox

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

#### Setting up entitlements

Managing sandbox settings is done in the
`macos/Runner/*.entitlements` files. When editing
these files, you shouldn't remove the original
`Runner-DebugProfile.entitlements` exceptions
(that support incoming network connections and JIT),
as they're necessary for the `debug` and `profile`
modes to function correctly.

If you're used to managing entitlement files through
the **Xcode capabilities UI**, be aware that the capabilities
editor updates only one of the two files or,
in some cases, it creates a whole new entitlements
file and switches the project to use it for all configurations.
Either scenario causes issues. We recommend that you
edit the files directly. Unless you have a very specific
reason, you should always make identical changes to both files.

If you keep the App Sandbox enabled (which is required if you
plan to distribute your app in the [App Store][]), you need to manage
entitlements for your application when you add certain plugins
or other native functionality. For instance, using the
[`file_chooser`][] plugin requires adding either the
`com.apple.security.files.user-selected.read-only` or
`com.apple.security.files.user-selected.read-write` entitlement.
Another common entitlement is `com.apple.security.network.client`,
which you must add if you make any network requests.

Without the `com.apple.security.network.client` entitlement,
for example, network requests will fail with a message such as:

```terminal
flutter: SocketException: Connection failed
(OS Error: Operation not permitted, errno = 1),
address = example.com, port = 443
```

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

[App Sandbox]: https://developer.apple.com/documentation/security/app_sandbox
[App Store]: https://developer.apple.com/app-store/submissions/
[Entitlements]: https://developer.apple.com/documentation/bundleresources/entitlements
[`file_chooser`]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/file_chooser

### Hardened runtime

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

[Hardened Runtime]: https://developer.apple.com/documentation/security/hardened_runtime

## Plugin support

Flutter on the desktop supports using and creating plugins.

### Using a plugin

To use a plugin that supports desktop,
follow the steps for plugins in [using packages][].
Flutter automatically adds the necessary native code
to your project, as with iOS or Android.

We recommend the following plugins, which have been
updated to work for desktop apps:

* [`url_launcher`][]
* [`shared_preferences`][]
* [`path_provider`][]

Use the following links to find all packages on pub.dev
that support desktop apps. These links lists _all_ packages,
not just plugin packages. (Remember that _plugin packages_,
or _plugins_, provide an interface to platform-specific services.)

* [Windows packages][]
* [macOS packages][]
* [Linux packages][]

[Linux packages]: {{site.pub}}/flutter/packages?platform=linux
[macOS packages]: {{site.pub}}/flutter/packages?platform=macos
[`path_provider`]: {{site.pub}}/packages/path_provider
[`shared_preferences`]: {{site.pub}}/packages/shared_preferences
[`url_launcher`]: {{site.pub}}/packages/url_launcher
[using packages]: /docs/development/packages-and-plugins/using-packages
[windows packages]: {{site.pub}}/flutter/packages?platform=windows

### Writing a plugin

When you start building your own plugins,
you’ll want to keep federation in mind.
Federation is the ability to define several different packages,
each targeted at a different set of platforms,
brought together into a single plugin for ease of use by developers.
For example, the Windows implementation of the `url_launcher` is really
`url_launcher_windows`, but a Flutter developer can simply add the
`url_launcher` package to their `pubspec.yaml` as a dependency and the
build process pulls in the correct implementation based on the target platform.
Federation is handy because different teams with different expertise
can build plugin implementations for different platforms.
You can add a new platform implementation to any
endorsed federated plugin on pub.dev, so long as you coordinate
this effort with the original plugin author.

For more information, including information about endorsed plugins,
see the following resources:

* [Developing packages and plugins][], particularly the
  [Federated plugins][] section.
* [How to write a Flutter web plugin, part 2][],
  covers the structure of federated plugins and
  contains information applicable to desktop
  plugins.
* [Modern Flutter Plugin Development][] covers
  recent enhancements to Flutter's plugin support.
* [Federated Plugin proposal][]

[Developing packages and plugins]: /docs/development/packages-and-plugins/developing-packages
[Federated Plugin proposal]: /go/federated-plugins
[Federated plugins]: /docs/development/packages-and-plugins/developing-packages#federated-plugins
[How to write a Flutter web plugin, part 2]: https://medium.com/flutter/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6
[Modern Flutter Plugin Development]: {{site.medium}}/flutter/modern-flutter-plugin-development-4c3ee015cf5a

## Samples and codelabs

[Write a Flutter desktop application][]
: A codelab that walks you through building
a desktop app that integrates the GitHub
GraphQL API with your Flutter app.

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
: A sample app built as a desktop application that
  uses the following desktop-supported plugins:
  * [`file_chooser`][]
  * [`menubar`][]
  * [`url_launcher`][]

[`menubar`]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/menubar
[Photo Search app]: {{site.repo.organization}}/samples/tree/master/experimental/desktop_photo_search
[README]: {{site.github}}/flutter/gallery#flutter-gallery
[repo]: {{site.github}}/flutter/flutter/tree/master/dev/integration_tests/flutter_gallery
[running web app]: https://flutter.github.io/gallery/#/
[Write a Flutter desktop application]: https://codelabs.developers.google.com/codelabs/flutter-github-graphql-client/index.html
