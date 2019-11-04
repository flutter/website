---
title: Desktop support for Flutter
description: "Announcing the alpha release of Flutter for desktop."
---
With desktop support, you can compile Flutter code to a native macOS Desktop
app, complete with all of Flutter's features and editor tooling. You can also
use some existing plugins, as well as create your own. As of 1.12, desktop
support is available as an alpha release. The Objective-C API layer is largely
stable, and breaking changes should be rare.

## Tools
Before you begin, make sure you have completed the [steps to install Flutter].
Desktop support includes features for running and building your code using the
flutter CLI as well as IDEs.

### Flutter CLI - Create and run a Flutter desktop app (summary)
Flutter Desktop supports the `create` and `build` commands as well as the `run`
command in [debug mode] with [hot reload]. Flutter Desktop does not currently
support [profile mode] or [release mode].

The following commands demonstrate how to create and run a new Flutter project
that makes use of Flutter's desktop support. You must be using the master
channel, and you must enable the macos desktop platform feature:

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
{{site.alert.warning}}
The Flutter desktop APIs are still in early stages of
development, and are subject to change without warning. No backwards
compatibility, either API or ABI, will be provided. Expect any code using these
libraries to need to be updated and recompiled after any Flutter update.
{{site.alert.end}}

### IDE Support
You can create, run, and debug a Flutter desktop project using the existing
tools provided by the Flutter extension for [Android Studio / IntelliJ] as well
as [Visual Studio Code]. Follow the [Set up an editor] instructions to install the
Dart and Flutter extensions (also called plugins).

#### VS Code - Running and debugging

Running a Flutter Desktop project from VS Code is no different than [running
and debugging in VS Code] for a Flutter project with other target platforms:
 1. Select **macOS** as a target device from the VS Code status bar.
 2. Click the **Debug > Start Without Debugging** or press item from the navbar menu.

![Desktop VS Code](/images/desktop/desktop_vscode.gif){:width="70%"}

#### Android Studio / IntelliJ IDEA - Running and debugging
Running a Flutter Desktop project with Android Studio or IntelliJ is no
different than [running and debugging in Android Studio / IntelliJ] for a Flutter
project with other target platforms:
1. Select **macOS (desktop)** from the **target selector** dropdown menu in the
   Flutter extension toolbar.
2. Click the **Play** icon in the toolbar, or invoke **Run > Run**.


![Desktop IntelliJ](/images/desktop/desktop_intellij.gif){:width="70%"}

## Plugin support
Flutter Desktop supports both creating and using plugins. In general, using and
creating plugins for desktop APIs 
### Using plugins


- Nothing different about using plugins in macOS
- There are a limited number of plugins available:


To use a plugin with macOS support, add it to pubspec.yaml. Flutter will
automatically add the necessary native code to your project, as with iOS or
Android.

### Creating plugins
The process for creating a desktop plugin follows the steps listed in
[Developing plugin packages], with only one difference:
1. To create a plugin, pass the --macos flag when you `flutter create` your
   plugin.
2. Use the [Federated Plugin Spec]

## Samples
You can learn from existing samples to get started with Flutter desktop support.

### Flutter Gallery

### TreeView
- File Tree Widget

## What's next
- Windows & Linux: tech preview

## More
- Wiki
- FDE links

## Feedback & questions

## TODO:
- [ ] Be more descriptive about *this doc highlights the differences...*
- [ ] Center and/or re-size the gifs; add top/bottom margin
- [ ] Find Gallery/TreeView links

[steps to install Flutter]: /docs/get-started/install/macos
[hot reload]: /docs/development/tools/hot-reload
[debug mode]: /docs/testing/build-modes#debug
[profile mode]: /docs/testing/build-modes#profile
[release mode]: /docs/testing/build-modes#release
[federated plugin spec]: https://docs.google.com/document/d/1LD7QjmzJZLCopUrFAAE98wOUQpjmguyGTN2wd_89Srs/edit?pli=1#heading=h.pub7jnop54q0

[Android Studio / IntelliJ]: /docs/development/tools/android-studio
[Visual Studio Code]: /docs/development/tools/vs-code
[Set up an editor]: /docs/get-started/editor

[Running and debugging in VS Code]: /docs/development/tools/vs-code#running-and-debugging
[Running and debugging in Android Studio / IntelliJ]: /docs/development/tools/android-studio#running-and-debugging