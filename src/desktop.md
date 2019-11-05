---
title: Desktop support for Flutter
description: Announcing the alpha release of Flutter for desktop.
toc: true
---
With desktop support, you can compile Flutter code to a native macOS Desktop
app, complete with all of Flutter's features and editor tooling. You can also
use some existing plugins, as well as create your own. As of 1.12, desktop
support is available as an alpha release for macOS, and Windows and Linux
platforms are still in technical preview.

## Tools
Before you begin, make sure you have completed the [steps to install Flutter].
Desktop support includes features for running and building your code using the
flutter CLI tool as well as IDEs.

### Flutter CLI - Create and run a Flutter desktop app (summary)
Flutter Desktop supports the `create` and `build` commands as well as the `run`
command with [debug mode] and [hot reload]. Flutter Desktop does not currently
support [profile mode] or [release mode].

The following commands demonstrate how to create and run a new Flutter project
that makes use of desktop support. You must be using the master channel, and you
must enable the macOS desktop platform feature:

```terminal
$ flutter channel master
$ flutter upgrade
$ flutter config --enable-macos-desktop
$ cd <into project directory>
$ flutter create --macos .
$ flutter run -d macOS
```

![Desktop Hello World](/images/desktop/desktop_hello_world.gif){:width="70%"}

To generate a release build:
```terminal
$ flutter build macos
```
{{site.alert.warning}} The Flutter desktop APIs are still in early stages of
development, and are subject to change without warning. No backwards
compatibility, either API or ABI, will be provided. Expect any code using these
libraries to need to be updated and recompiled after any Flutter update.
{{site.alert.end}}

### IDE Support
You can create, run, and debug a Flutter desktop project using the existing
tools provided by the Flutter extension for [Android Studio / IntelliJ] as well
as [Visual Studio Code]. Follow the instructions to [set up an editor] and install
the Dart and Flutter extensions (also called plugins).

#### VS Code - Running and debugging

Running a Flutter Desktop project from VS Code is no different than [running and
debugging in VS Code] for a Flutter project with other target platforms:
 1. Select **macOS** as a target device from the VS Code status bar.
 2. Click the **Debug > Start Without Debugging** or press <kbd>F5</kbd>.

![Desktop VS Code](/images/desktop/desktop_vscode.gif){:width="70%"}

#### Android Studio / IntelliJ IDEA - Running and debugging
Running a Flutter Desktop project with Android Studio or IntelliJ is no
different than [running and debugging in Android Studio / IntelliJ] for a
Flutter project with other target platforms:
1. Select **macOS (desktop)** from the **target selector** dropdown menu in the
   Flutter extension toolbar.
2. Click the **Play** icon in the toolbar, or invoke **Run > Run**.

![Desktop IntelliJ](/images/desktop/desktop_intellij.gif){:width="70%"}

## Plugin support
Flutter Desktop supports both creating and using plugins.

### Using plugins
To use a plugin with macOS support, follow the steps for plugins in
[using packages]:
1. Add the plugin to `pubspec.yaml`.
2. Run `flutter pub get`
3. Run `flutter run`. Flutter will automatically add the necessary native code
   to your project, as with iOS or Android.

#### flutter_plugins
The following plugins are available in the [flutter-desktop-embedding] repo within
the [plugins/flutter_plugins] directory:
- connectivity_fde
- path_provider_fde
- shared_preferences_fde
- url_launcher_fde

Each of these plugins has a corresponding plugin with the same name, without the
`_fde` suffix, within the [flutter/plugins] github repo. The `_fde`
implementations exist only as a temporary solution while the plugin APIs on each
desktop platform stabilize;  they will eventually move to an official location
and be distributed as normal Flutter plugins.

For these plugins, the Dart code comes from the official plugin, so you must
include both the official plugin as well as the `_fde` plugin in your
`pubspec.yaml`. To include the `_fde` plugin, you can use a [git reference] to
the [flutter-desktop-embedding] path for the plugin. For instance, to use
`url_launcher` on desktop, you would include:

```yaml
dependencies:
  ...
  url_launcher: ^5.0.0
  url_launcher_fde:
    git:
      url: git://github.com/google/flutter-desktop-embedding.git
      path: plugins/flutter_plugins/url_launcher_fde
```

Since the Dart code comes from the official plugin, you must import the official
plugin in your Dart files to use the plugin:

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
- video_player
- color_panel
- file_chooser

### Creating plugins
The process for creating a desktop plugin follows the steps listed in
[Developing plugin packages], with only one difference:
1. To create a plugin, pass the `--macos` flag when you `flutter create` your
   plugin.
2. Use the [Federated Plugin Spec]

## Samples
You can use the following samples to get started and learn more about Flutter
desktop support.

### Flutter Gallery

### TreeView
- File Tree Widget

## What's next
Desktop support for Windows and Linux platforms is available as a technical
preview. Check the [Desktop shells wiki] for more information and ongoing updates.

## More
- Check for ongoing desktop support updates at the [Desktop shells wiki].
- Learn more about desktop support for plugins at the [flutter-desktop-embedding]
  github repository.

## Feedback & questions

## TODO:
- [ ] Right click? Hover? Do we have any desktop-specific features we can showoff?
- [ ] Be more descriptive about *this doc highlights the differences...* in IDE
  section
- [ ] Center and/or re-size the gifs; add top/bottom margin a la /docs/testing/debugging
- [ ] Find Gallery/TreeView links
- [ ] Choose feedback link (create new issue?)
- [ ] Desktop plugins how-to-use: do we have any plugin in pub.dev?
- [ ] Desktop plugin how-to-create: what is the process?

[steps to install Flutter]: /docs/get-started/install/macos
[hot reload]: /docs/development/tools/hot-reload
[debug mode]: /docs/testing/build-modes#debug
[profile mode]: /docs/testing/build-modes#profile
[release mode]: /docs/testing/build-modes#release
[federated plugin spec]: https://docs.google.com/document/d/1LD7QjmzJZLCopUrFAAE98wOUQpjmguyGTN2wd_89Srs/edit?pli=1#heading=h.pub7jnop54q0

[Android Studio / IntelliJ]: /docs/development/tools/android-studio
[Visual Studio Code]: /docs/development/tools/vs-code
[set up an editor]: /docs/get-started/editor

[Running and debugging in VS Code]: /docs/development/tools/vs-code#running-and-debugging
[Running and debugging in Android Studio / IntelliJ]: /docs/development/tools/android-studio#running-and-debugging

[Using packages]: /docs/development/packages-and-plugins/using-packages
[Desktop shells wiki]: {{site.repo.flutter}}/wiki/Desktop-shells
[flutter-desktop-embedding]: https://github.com/google/flutter-desktop-embedding/tree/master/plugins#dart
[flutter/plugins]: {{site.repo.organization}}/plugins
[plugins/flutter_plugins]: https://github.com/google/flutter-desktop-embedding/tree/master/plugins/flutter_plugins
[git reference]: {{site.dart-site}}/tools/pub/dependencies#git-packages