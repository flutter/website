---
title: Desktop support for Flutter
description: Announcing the alpha release of Flutter for desktop.
toc: true
---

With desktop support,
you can compile Flutter source code
to a native macOS Desktop app.
Flutter's desktop support also extends to plugins&mdash;you can
install existing plugins that support the macOS platform,
or you can create your own.

**This page covers desktop support for macOS
which is available as an alpha release as of 1.13.**
This page does not cover Windows or Linux platforms,
which are in technical preview. You can try Windows and Linux platform support
by reading the [Desktop shells page] in the [Flutter wiki].

## Requirements
To create a Flutter app with desktop support, you need the following software:
* Flutter SDK. See the [Flutter SDK installation instructions][install flutter].
* Optional: An IDE that supports Flutter.
You can install [Android Studio], [IntelliJ IDEA], or [Visual Studio Code]
and [install the Flutter and Dart plugins] to enable language support and
tools for refactoring, running, debugging, and reloading your desktop app
within an editor. See the [IDE support] section for more details.

### Set up
You must be on the master [flutter build release channel]
and enable the macOS desktop platform feature:

```terminal
$ flutter channel master
$ flutter upgrade
$ flutter config --enable-macos-desktop
```
### Create and run
Create and/or navigate to the directory for your new project
using the following commands.
Replace `myapp` with the name you would like to use for your project.

```terminal
$ mkdir myapp
$ cd myapp
```

Once you have navigated to your root project directory,
use the following commands to create and run the [Flutter starter app]
as a new desktop project:

```terminal
$ flutter create .
$ flutter run -d macOS
```
![Desktop Hello World](/images/desktop/desktop_hello_world.gif){:width="70%"}

Flutter's desktop support includes the `create` and `build` commands as well as the `run`
command with [debug mode], [release mode], [profile mode], and [hot reload].

### Build
To generate a release build run the following command:
```terminal
$ flutter build macos
```

## Add desktop support to an existing Flutter project
To add desktop support to an existing project,
run the following command in a terminal from the root project directory:

```terminal
$ flutter create .
```
To run your project as a desktop app, use the following command:

```terminal
$ flutter run -d macOS
```

## IDE Support
You can create, run, and debug a Flutter project with desktop support
using the existing Dart and Flutter extensions for [Android Studio and IntelliJ] as well
as [Visual Studio Code]. Follow the instructions to [set up an editor] and install
the Dart and Flutter extensions (also referred to as editor plugins).

### VS Code: Create and run a new project with desktop support
Creating a new project with desktop support is no different than
[creating a new Flutter project][flutter starter app] for other platforms.
Running a Flutter desktop app is no different than
[running and debugging in VS Code] for other target platforms:
 1. Select **macOS** as a target device from the VS Code status bar.
 2. Click the **Debug > Start Without Debugging** or press <kbd>F5</kbd>.

![Desktop VS Code](/images/desktop/desktop_vscode.gif){:width="70%"}

{{site.alert.note}}
  Is `macOS` not listed as one of your available devices?
  Make sure to first run `flutter create`
  to create the `macos` directory in your project root.
{{site.alert.end}}

### Android Studio and IntelliJ IDEA: Create and run a new project with desktop support
Creating a new project with desktop support is no different than
[creating a new Flutter project][flutter starter app] for other platforms.
To run a Flutter project with desktop support, use the same
process for [running and debugging Flutter projects in Android Studio and IntelliJ] with other
target platforms:
1. Select **macOS (desktop)** from the **target selector** dropdown menu in the
   Flutter extension toolbar.
2. Click the **Play** icon in the toolbar, or invoke **Run > Run**.

![Desktop IntelliJ](/images/desktop/desktop_intellij.gif){:width="70%"}

## Plugin support
Flutter Desktop supports both using and creating plugins.

To use a plugin that supports macOS, follow the steps for plugins in [using
packages].
Flutter automatically adds the necessary native code
to your project, as with iOS or Android.

1. Add the latest version of the plugin to `pubspec.yaml`.
2. Run `flutter pub get`.
3. Run `flutter run`.

The following plugins have macos desktop support:

* [url_launcher]
* [shared_preferences]
* [connectivity]
* [path_provider]

[url_launcher] and [shared_preferences] are fully supported as normal plugins.
To use [connectivity] and [path_provider] you need to declare an
extra dependency in your pubspec.yaml with a `_macos` suffix
(you don't need to add any additional imports):

```yaml
connectivity: ^0.4.6
connectivity_macos: ^0.0.1
```

### Creating plugins
To create a plugin with desktop support you should use the following resources:
* [Developing plugin packages]
* [Federated Plugin Spec]

## Samples
You can run the following samples as desktop apps,
as well as download and inspect the source code to learn more about Flutter
desktop support.

[Flutter Gallery]
: A samples project hosted on GitHub to help developers evaluate and use Flutter.
The Gallery consists of a collection of material design widgets, behaviors, and vignettes
implemented with Flutter.
You can clone the project and run Gallery as a desktop app
by following the provided instructions in the README.

[Photo Search app]
: A sample app built as a desktop application that uses
the following desktop-specific plugins:
* file_chooser
* menubar
* url_launcher

## What's next
Stay tuned for updates on desktop support!
We will continue to develop desktop support for Mac, Windows, and Linux.
* Watch the [Desktop shells page] on the [Flutter wiki] for more
information and ongoing updates.
* Learn more about desktop support for plugins at the [flutter-desktop-embedding]
GitHub repository.

[Android Studio and IntelliJ]: /docs/development/tools/android-studio
[Android Studio]: {{site.android-dev}}/studio/install
[color_panel]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/color_panel
[connectivity]: {{site.pub}}/packages/connectivity
[debug mode]: /docs/testing/build-modes#debug
[dependencies on unpublished packages]: /docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages
[Desktop shells page]: {{site.repo.flutter}}/wiki/Desktop-shells
[Desktop shells page]: {{site.repo.flutter}}/wiki/Desktop-shells
[Developing plugin packages]: /docs/development/packages-and-plugins/developing-packages
[federated plugin spec]: https://docs.google.com/document/d/1LD7QjmzJZLCopUrFAAE98wOUQpjmguyGTN2wd_89Srs/edit?pli=1#heading=h.pub7jnop54q0
[file_chooser]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/file_chooser
[flutter build release channel]: {{site.repo.flutter}}/wiki/Flutter-build-release-channels
[Flutter Gallery]: {{site.repo.samples}}/tree/master/gallery/gallery
[flutter starter app]: /docs/get-started/test-drive
[flutter wiki]: {{site.repo.flutter}}/wiki/
[flutter-desktop-embedding]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins#dart
[flutter/plugins]: {{site.repo.organization}}/plugins
[git reference]: {{site.dart-site}}/tools/pub/dependencies#git-packages
[hot reload]: /docs/development/tools/hot-reload
[IDE support]: /desktop#ide-support
[install flutter]: /docs/get-started/install
[install the Flutter and Dart plugins]: /docs/get-started/editor
[IntelliJ IDEA]: https://www.jetbrains.com/idea/download/
[path_provider]: {{site.pub}}/packages/path_provider
[Photo Search app]: {{site.repo.organization}}/samples/tree/master/experimental/desktop_photo_search
[plugins/flutter_plugins]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/flutter_plugins
[profile mode]: /docs/testing/build-modes#profile
[release mode]: /docs/testing/build-modes#release
[Run and debug in Android Studio and IntelliJ]: /docs/development/tools/android-studio#running-and-debugging
[Running and debugging in VS Code]: /docs/development/tools/vs-code#running-and-debugging
[set up an editor]: /docs/get-started/editor
[shared_preferences]: {{site.pub}}/packages/shared_preferences
[steps to install Flutter]: /docs/get-started/install/macos
[url_launcher]: {{site.pub}}/packages/url_launcher
[Using packages]: /docs/development/packages-and-plugins/using-packages
[Visual Studio Code]: /docs/development/tools/vs-code