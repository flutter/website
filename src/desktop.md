---
title: Desktop support for Flutter
description: Announcing the alpha release of Flutter for desktop.
toc: true
---

With desktop support,
you can compile Flutter source code
to a native macOS Desktop app.
Flutter desktop support also extends to plugins&mdash;you can
install existing plugins that support the macOS platform,
or you can create your own.

**This page covers desktop support for macOS
which is available as an alpha release as of 1.13.**
This page does not cover Windows and Linux platforms,
which are in technical preview. You can try out Windows and Linux platforms
by reading the instructions at the [Desktop shells wiki].

## Requirements
- [Install the Flutter SDK on your platform][install flutter].
- Optional: Install [Android Studio], [IntelliJ IDEA], or [Visual Studio Code]
to make use of Desktop supported features
for running and building your code using IDEs.

## Create a new project with desktop support
You can use the following commands to create and run a new Flutter project
with desktop support.

### Set up
To use desktop support,
you must be on the master [flutter build release channel]
and enable the macOS desktop platform feature:

```terminal
$ flutter channel master
$ flutter upgrade
$ flutter config --enable-macos-desktop
```
### Create and run
Create and/or navigate to the directory for your new project
using the following commands.
You can replace `myapp` with the name you would like to use for your project.

```terminal
$ mkdir myapp
$ cd myapp
```

Once you have navigated to your root project directory,
run the following commands to create and run your new desktop project:

```terminal
$ flutter create --macos .
$ flutter run -d macOS
```
![Desktop Hello World](/images/desktop/desktop_hello_world.gif){:width="70%"}

Flutter Desktop supports the `create` and `build` commands as well as the `run`
command with [debug mode] and [hot reload]. Flutter Desktop does not currently
support [profile mode] or [release mode].


### Build
To generate a release build run the following command:
```terminal
$ flutter build macos
```

## Add Desktop support to an existing project
To add desktop support to an existing project,
run the following command in a terminal from the root project directory:

```terminal
$ flutter create --macos .
```
To run your project as a desktop app, use the following command:

```terminal
$ flutter run -d macOS
```

## IDE Support
You can create, run, and debug a Flutter desktop project using the existing
tools provided by the Flutter extension for [Android Studio / IntelliJ] as well
as [Visual Studio Code]. Follow the instructions to [set up an editor] and install
the Dart and Flutter extensions (also referred to as editor plugins).

### VS Code - Running and debugging

Running a Flutter Desktop project from VS Code is no different than [running and
debugging in VS Code] for a Flutter project with other target platforms:
 1. Select **macOS** as a target device from the VS Code status bar.
 2. Click the **Debug > Start Without Debugging** or press <kbd>F5</kbd>.

![Desktop VS Code](/images/desktop/desktop_vscode.gif){:width="70%"}

{{site.alert.note}}
`macOS` will not show up as a device if you have not yet created the `macos`
directory with the `flutter create --macos` command.
{{site.alert.end}}

### Android Studio / IntelliJ IDEA - Running and debugging
Running a Flutter Desktop project with Android Studio or IntelliJ uses the same
process for [running and debugging Flutter projects in Android Studio / IntelliJ] with other
target platforms:
1. Select **macOS (desktop)** from the **target selector** dropdown menu in the
   Flutter extension toolbar.
2. Click the **Play** icon in the toolbar, or invoke **Run > Run**.

![Desktop IntelliJ](/images/desktop/desktop_intellij.gif){:width="70%"}

## Plugin support
Flutter Desktop supports both using and creating plugins.

### Using plugins
To use a plugin that supports macOS, follow the steps for plugins in [using
packages]:
1. Add the plugin to `pubspec.yaml`.
2. Run `flutter pub get`.
3. Run `flutter run`.

Flutter will automatically add the necessary native code
   to your project, as with iOS or Android.

#### flutter_plugins
The following plugins are available in the [flutter-desktop-embedding] GitHub
repository within the [plugins/flutter_plugins] directory:
- connectivity_fde
- path_provider_fde
- shared_preferences_fde
- url_launcher_fde

For each of these plugins there is a corresponding plugin with the same name,
without the `_fde` suffix, within the [flutter/plugins] GitHub repository.
The `_fde` implementations exist only as a temporary solution
while the plugin APIs on each desktop platform stabilize;
they will eventually move to an official location and be distributed as Flutter plugins.

The Dart code for these `_fde` plugins comes from the official plugin,
so you must include both the official plugin as well as the `_fde` plugin in your
`pubspec.yaml`. To include the `_fde` plugin,
you can use the steps for adding [dependencies on unpublished packages]
by providing a [git reference] to the [flutter-desktop-embedding]
path for the plugin. For instance,
to use `url_launcher` with desktop support,
you must include both `url_launcher` and `url_launcher_fde`
in your `pubspec.yaml` file:

```yaml
dependencies:
  ...
  url_launcher: ^5.0.0
  url_launcher_fde:
    git:
      url: git://github.com/google/flutter-desktop-embedding.git
      path: plugins/flutter_plugins/url_launcher_fde
```

Since the Dart code for `flutter_plugins` in [flutter-desktop-embedding] comes
from the official plugin, you must import the official plugin in your Dart files
to use the plugin:

```dart
import 'package:url_launcher/url_launcher.dart';

void _launchURL() async {
  const url = 'https://github.com/google/flutter-desktop-embedding';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
```

#### Other plugins

The remaining plugins available with desktop support include:
- [color_panel]
- [file_chooser]

### Creating plugins
The process for creating a desktop plugin follows the steps listed in the
[Developing plugin packages] page, with only one difference:
1. To create a plugin, pass the `--macos` flag when you `flutter create` your
   plugin.
2. Use the [Federated Plugin Spec].

## Samples
You can run the following samples as desktop apps,
as well as download and inspect the source code to learn more about Flutter
desktop support.

[Flutter Gallery]
: A samples project hosted on GitHub to help developers evaluate and use Flutter.
It is a collection of material design widgets, behaviors, and vignettes
implemented with Flutter.
You can clone the project and run Gallery as a desktop app
by following the provided instructions in the README.

[Unsplash Search app]
: A sample app built as a desktop application that uses
the following desktop-specific plugins:
- file_chooser
- menubar
- url_launcher_fde


## What's next
- Desktop support for Windows and Linux platforms is available as a technical
preview. Check the [Desktop shells wiki] for more information and ongoing updates.
- Learn more about desktop support for plugins at the [flutter-desktop-embedding]
  GitHub repository.

[install flutter]: /docs/get-started/install
[Desktop shells wiki page]: {{site.repo.flutter}}/wiki/Desktop-shells
[flutter build release channel]: {{site.repo.flutter}}/wiki/Flutter-build-release-channels
[Developing plugin packages]: /docs/development/packages-and-plugins/developing-packages
[Unsplash Search app]: https://user.git.corp.google.com/brettmorgan/flutter_desktop_app/?pli=1
[file_chooser]: https://github.com/google/flutter-desktop-embedding/tree/master/plugins/file_chooser
[color_panel]: https://github.com/google/flutter-desktop-embedding/tree/master/plugins/color_panel

[IntelliJ IDEA]: https://www.jetbrains.com/idea/download/
[Android Studio]: https://developer.android.com/studio/install
[Android Studio / IntelliJ]: /docs/development/tools/android-studio
[Desktop shells wiki]: {{site.repo.flutter}}/wiki/Desktop-shells
[Flutter Gallery]: https://github.com/material-components/material-components-flutter-gallery
[Running and debugging Flutter projects in Android Studio / IntelliJ]: /docs/development/tools/android-studio#running-and-debugging
[Running and debugging in VS Code]: /docs/development/tools/vs-code#running-and-debugging
[Using packages]: /docs/development/packages-and-plugins/using-packages
[Visual Studio Code]: /docs/development/tools/vs-code
[debug mode]: /docs/testing/build-modes#debug
[dependencies on unpublished packages]: /docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages
[federated plugin spec]: https://docs.google.com/document/d/1LD7QjmzJZLCopUrFAAE98wOUQpjmguyGTN2wd_89Srs/edit?pli=1#heading=h.pub7jnop54q0
[flutter-desktop-embedding]: https://github.com/google/flutter-desktop-embedding/tree/master/plugins#dart
[flutter/plugins]: {{site.repo.organization}}/plugins
[git reference]: {{site.dart-site}}/tools/pub/dependencies#git-packages
[hot reload]: /docs/development/tools/hot-reload
[plugins/flutter_plugins]: https://github.com/google/flutter-desktop-embedding/tree/master/plugins/flutter_plugins
[profile mode]: /docs/testing/build-modes#profile
[release mode]: /docs/testing/build-modes#release
[set up an editor]: /docs/get-started/editor
[steps to install Flutter]: /docs/get-started/install/macos