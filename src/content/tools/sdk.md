---
title: Flutter SDK overview
shortTitle: Flutter SDK
description: Flutter libraries and command-line tools.
---

The Flutter SDK has the packages and command-line tools that you need to develop
Flutter apps across platforms. To get the Flutter SDK, see [Install][].

## What's in the Flutter SDK

The following is available through the Flutter SDK:

* [Dart SDK][]
* Heavily optimized, mobile-first 2D rendering engine with
  excellent support for text
* Modern react-style framework
* Rich set of widgets implementing Material Design and iOS styles
* APIs for unit and integration tests
* Interop and plugin APIs to connect to the system and 3rd-party SDKs
* Headless test runner for running tests on Windows, Linux, and Mac
* [Flutter DevTools][] for testing, debugging, and profiling your app
* `flutter` and `dart` command-line tools for creating, building, testing,
  and compiling your apps

Note: For more information about the Flutter SDK, see its
[README file][].

## `flutter` command-line tool

The [`flutter` CLI tool][] (`flutter/bin/flutter`) is how developers
(or IDEs on behalf of developers) interact with Flutter.

## `dart` command-line tool

The [`dart` CLI tool][] is available with the Flutter SDK at `flutter/bin/dart`.

[Flutter DevTools]: /tools/devtools
[Dart SDK]: {{site.dart-site}}/tools/sdk
[`dart` CLI tool]: {{site.dart-site}}/tools/dart-tool
[`flutter` CLI tool]: /reference/flutter-cli
[Install]: /get-started
[README file]: {{site.repo.flutter}}/blob/main/README.md

## SDK support for Flutter developer tools

The IDE tooling for Flutter (Android Studio and Intellij plugins, VS Code
extensions) supports Flutter SDK versions going back two years. This means that
while the tools might still function with SDKs older than two years, they will
no longer provide fixes for issues specific to these older versions.
