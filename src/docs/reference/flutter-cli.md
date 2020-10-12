---
title: "flutter: The Flutter command-line tool"
description: "The reference page for using 'flutter' in a terminal window."
---

The `flutter` command-line tool is how developers (or IDEs on behalf of developers) interact with Flutter.

Here's how you might use the `flutter` tool to create, analyze, test, and run an app:

```terminal
$ flutter create my_app
$ cd my_app
$ flutter analyze
$ flutter test
$ flutter run bin/my_app.dart
```

You can also run [`pub` commands][] using the `flutter` tool:

```terminal
$ flutter pub get
$ flutter pub outdated
$ flutter pub upgrade
```

The following table shows which commands you can use with the `flutter` tool.

|---------+--------------------------------+-----------------------------------|
| Command | Example of use                 | More information                  |
|---------|--------------------------------|-----------------------------------|
| analyze | `flutter analyze`     | Analyzes the project's Dart source code.<br>Use instead of [`dartanalyzer`][]. |
| assemble | `flutter assemble` | Assemble and build flutter resources. |
| attach | `flutter attach -d <DEVICE_ID>` | Attach to a running application. |
| bash-completion | `flutter bash-completion` | Output command line shell completion setup scripts. |
| build | `flutter build <DIRECTORY>` | Flutter build commands. |
| channel | `flutter channel` | List or switch flutter channels. |
| config | `flutter config` | Configure Flutter settings. |
| create  | `flutter create <DIRECTORY>`      | Creates a new project. |
| devices | `flutter devices` | List all connected devices. |
| doctor | `flutter doctor` | Show information about the installed tooling. |
| downgrade | `flutter downgrade` | Downgrade Flutter to the last active version for the current channel. |
| drive | `flutter drive` | Runs Flutter Driver tests for the current project. |
| emulators | `flutter emulators` | List, launch and create emulators. |
| format | `flutter format` | Format one or more dart files. |
| gen-l10n | `flutter gen-l10n <DIRECTORY>` | Generate localizations for the Flutter project. |
| install | `flutter install` | Install a Flutter app on an attached device. |
| logs | `flutter logs` | Show log output for running Flutter apps. | 
| format  | `flutter format <DIRECTORY|DART_FILE>` | Formats Flutter source code.<br>Use instead of [`dartfmt`][]. | 
| precache | `flutter precache <ARGUMENTS>` | Populates the Flutter tool's cache of binary artifacts. |
| pub     | `flutter pub <PUB_COMMAND>`       | Works with packages.<br>Use instead of [`pub`][]. | 
| run     | `flutter run <DART_FILE>`         | Runs a Flutter program. | 
| symbolize | `flutter symbolize` | Symbolize a stack trace from the AOT compiled flutter application. |
| test    | `flutter test [<DIRECTORY|DART_FILE>]` | Runs tests in this package.<br>Use instead of [`pub run test`][`pub`]. |
| upgrade | `flutter upgrade` | Upgrade your copy of Flutter. | Symbolize a stack trace from an AOT compiled flutter application. |
| _(none)_| `flutter <DART_FILE>`             | Runs a Flutter program, just like `flutter run`. |
{:.table .table-striped .nowrap}

For additional help on any of the commands, enter `flutter help <command>`
or follow the links in the **More information** column.
You can also get details on `pub` commands — for example,
`flutter help pub outdated`.

[`dartanalyzer`]: {{site.dart-site}}/tools/dartanalyzer
[`dartfmt`]: {{site.dart-site}}/tools/dartfmt
[`pub`]: {{site.dart-site}}/tools/pub/cmd
[`pub` commands]: {{site.dart-site}}/tools/pub/cmd
