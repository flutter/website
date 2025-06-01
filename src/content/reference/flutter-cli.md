---
title: "flutter: The Flutter command-line tool"
description: "The reference page for using 'flutter' in a terminal window."
---

The `flutter` command-line tool is how developers (or IDEs on behalf of
developers) interact with Flutter. For Dart related commands,
you can use the [`dart`][] command-line tool.

Here's how you might use the `flutter` tool to create, analyze, test, and run an
app:

```console
$ flutter create my_app
$ cd my_app
$ flutter analyze
$ flutter test
$ flutter run lib/main.dart
```

To run [`pub`][`dart pub`] commands using the `flutter` tool:

```console
$ flutter pub get
$ flutter pub outdated
$ flutter pub upgrade
```

To view all commands that `flutter` supports:

```console
$ flutter --help --verbose
```

To get the current version of the Flutter SDK, including its framework, engine,
and tools:

```console
$ flutter --version
```

## `flutter` commands

The following table shows which commands you can use with the `flutter` tool:

| Command         | Example of use                                 | More information                                                                  |
|-----------------|------------------------------------------------|-----------------------------------------------------------------------------------|
| analyze         | `flutter analyze -d <DEVICE_ID>`               | Analyzes the project's Dart source code.<br>Use instead of [`dart analyze`][].    |
| assemble        | `flutter assemble -o <DIRECTORY>`              | Assemble and build flutter resources.                                             |
| attach          | `flutter attach -d <DEVICE_ID>`                | Attach to a running application.                                                  |
| bash-completion | `flutter bash-completion`                      | Output command line shell completion setup scripts.                               |
| build           | `flutter build <DIRECTORY>`                    | Flutter build commands.                                                           |
| channel         | `flutter channel <CHANNEL_NAME>`               | List or switch flutter channels.                                                  |
| clean           | `flutter clean`                                | Delete the `build/` and `.dart_tool/` directories.                                |
| config          | `flutter config --build-dir=<DIRECTORY>`       | Configure Flutter settings. To remove a setting, configure it to an empty string. |
| create          | `flutter create <DIRECTORY>`                   | Creates a new project.                                                            |
| custom-devices  | `flutter custom-devices list`                  | Add, delete, list, and reset custom devices.                                      |
| devices         | `flutter devices`                              | List all connected devices.                                                       |
| doctor          | `flutter doctor`                               | Show information about the installed tooling.                                     |
| downgrade       | `flutter downgrade`                            | Downgrade Flutter to the last active version for the current channel.             |
| drive           | `flutter drive`                                | Runs Flutter Driver tests for the current project.                                |
| emulators       | `flutter emulators`                            | List, launch and create emulators.                                                |
| gen-l10n        | `flutter gen-l10n <DIRECTORY>`                 | Generate localizations for the Flutter project.                                   |
| install         | `flutter install -d <DEVICE_ID>`               | Install a Flutter app on an attached device.                                      |
| logs            | `flutter logs`                                 | Show log output for running Flutter apps.                                         |
| precache        | `flutter precache <ARGUMENTS>`                 | Populates the Flutter tool's cache of binary artifacts.                           |
| pub             | `flutter pub <PUB_COMMAND>`                    | Works with packages.<br>Use instead of [`dart pub`][].                            |
| run             | `flutter run <DART_FILE>`                      | Runs a Flutter program.                                                           |
| screenshot      | `flutter screenshot`                           | Take a screenshot of a Flutter app from a connected device.                       |
| symbolize       | `flutter symbolize --input=<STACK_TRACK_FILE>` | Symbolize a stack trace from the AOT compiled flutter application.                |
| test            | `flutter test [<DIRECTORYDART_FILE>]`          | Runs tests in this package.<br>Use instead of [`dart test`][`dart test`].         |
| upgrade         | `flutter upgrade`                              | Upgrade your copy of Flutter.                                                     |

{:.table .table-striped .nowrap}

For additional help on any of the commands, enter `flutter help <command>`
or follow the links in the **More information** column.
You can also get details on `pub` commands — for example,
`flutter help pub outdated`.

[`dart`]: {{site.dart-site}}/tools/dart-tool
[`dart analyze`]: {{site.dart-site}}/tools/dart-analyze
[`dart format`]: {{site.dart-site}}/tools/dart-format
[`dart pub`]: {{site.dart-site}}/tools/dart-pub
[`dart test`]: {{site.dart-site}}/tools/dart-test
