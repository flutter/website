---
title: Desktop support for Flutter
description: General information about Flutter support for desktop apps.
---

Flutter provides support for compiling
a native Windows, macOS, or Linux desktop app.
Flutter's desktop support also extends to plugins&mdash;you
can install existing plugins that support the Windows,
macOS, or Linux platforms, or you can create your own.

:::note
This page covers developing apps for all desktop
platforms. Once you've read this, you can dive into
specific platform information at the following links:

* [Building Windows apps with Flutter][]
* [Building macOS apps with Flutter][]
* [Building Linux apps with Flutter][]
:::

[Building Windows apps with Flutter]: /platform-integration/windows/building
[Building macOS apps with Flutter]: /platform-integration/macos/building
[Building Linux apps with Flutter]: /platform-integration/linux/building

## Create a new project

You can use the following steps
to create a new project with desktop support.

### Set up desktop devtools

Consult the guide for your target desktop environment:

* [Install Linux desktop devtools][Linux-devtools]
* [Install macOS desktop devtools][macOS-devtools]
* [Install Windows desktop devtools][Windows-devtools]

[Linux-devtools]: /platform-integration/linux/setup#set-up-tooling
[macOS-devtools]: /platform-integration/macos/setup#set-up-tooling
[Windows-devtools]: /platform-integration/windows/setup#set-up-tooling

If `flutter doctor` finds problems or missing components
for a platform that you don't want to develop for,
you can ignore those warnings. Or you can disable the
platform altogether using the `flutter config` command,
for example:

```console
$ flutter config --no-enable-ios
```

Other available flags:

* `--no-enable-windows-desktop`
* `--no-enable-linux-desktop`
* `--no-enable-macos-desktop`
* `--no-enable-web`
* `--no-enable-android`
* `--no-enable-ios`

After enabling desktop support,
restart your IDE so that it can detect the new device.

### Create and run

Creating a new project with desktop support is no different
from [creating a new Flutter project][] for other platforms.

Once you've configured your environment for desktop
support, you can create and run a desktop application
either in the IDE or from the command line.

[creating a new Flutter project]: /reference/create-new-app

#### Using an IDE

After you've configured your environment to support
desktop, make sure you restart the IDE if it was
already running.

Create a new application in your IDE and it automatically
creates iOS, Android, web, and desktop versions of your app.
From the device pulldown, select **windows (desktop)**,
**macOS (desktop)**, or **linux (desktop)**
and run your application to see it launch on the desktop.

#### From the command line

To create a new application that includes desktop support
(in addition to mobile and web support), run the following commands,
substituting `my_app` with the name of your project:

```console
$ flutter create my_app
$ cd my_app
```

To launch your application from the command line,
enter one of the following commands from the top
of the package:

```console
C:\> flutter run -d windows
$ flutter run -d macos
$ flutter run -d linux
```

:::note
If you do not supply the `-d` flag, `flutter run` lists
the available targets to choose from.
:::

## Build a release app

To generate a release build,
run one of the following commands:

```console
PS C:\> flutter build windows
$ flutter build macos
$ flutter build linux
```

## Add desktop support to an existing Flutter app

To add desktop support to an existing Flutter project,
run the following command in a terminal from the
root project directory:

```console
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
you'll want to keep federation in mind.
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

[using packages]: /packages-and-plugins/using-packages
[Developing packages and plugins]: /packages-and-plugins/developing-packages
[Federated plugins]: /packages-and-plugins/developing-packages#federated-plugins
[How to write a Flutter web plugin, part 2]: {{site.flutter-blog}}/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6
[Modern Flutter Plugin Development]: {{site.flutter-blog}}/modern-flutter-plugin-development-4c3ee015cf5a

## Samples and codelabs

[Write a Flutter desktop application][]
: A codelab that walks you through building
a desktop application that integrates the GitHub
GraphQL API with your Flutter app.

You can run the following samples as desktop apps,
as well as download and inspect the source code to
learn more about Flutter desktop support.

Wonderous app [running app][wonderous-app], [repo][wonderous-repo]
: A showcase app that uses Flutter to create a highly expressive user interface.
  Wonderous focuses on delivering an accessible and high-quality user experience
  while including engaging interactions and novel animations.
  To run Wonderous as a desktop app, clone the project and
  follow the instructions provided in the [README][wonderous-readme].

Flokk [announcement blogpost][gskinner-flokk-blogpost], [repo][gskinner-flokk-repo]
: A Google contacts manager that integrates with GitHub and Twitter.
  It syncs with your Google account, imports your contacts,
  and allows you to manage them.

[Photo Search app][]
: A sample application built as a desktop application that
  uses desktop-supported plugins.

[wonderous-app]: {{site.wonderous}}/web
[wonderous-repo]: {{site.repo.wonderous}}
[wonderous-readme]: {{site.repo.wonderous}}#wonderous
[Photo Search app]: {{site.repo.samples}}/tree/main/desktop_photo_search
[gskinner-flokk-repo]: {{site.github}}/gskinnerTeam/flokk
[gskinner-flokk-blogpost]: https://blog.gskinner.com/archives/2020/09/flokk-how-we-built-a-desktop-app-using-flutter.html
[Write a Flutter desktop application]: {{site.codelabs}}/codelabs/flutter-github-client
