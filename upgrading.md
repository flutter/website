---
layout: page
title: Upgrading Flutter
sidebar: home_sidebar
permalink: /upgrading/
---

We recommend tracking the `master` branch in the flutter repository, which
updates continuously as we improve Flutter.

## Specifying the Flutter SDK for your project

You specify dependencies from the Flutter SDK in the `pubspec.yaml` file. For
example, the following snippet specifies that the
`flutter` and `flutter_test` packages use the Flutter SDK.

```
name: hello_world
dependencies:
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_test:
    sdk: flutter
```

The `sdk: flutter` line tells the `flutter` command-line tool find the
correct package for you.

Do not use the `pub get` or `pub upgrade` commands to manage your dependencies.
Instead, use `flutter packages get` or `flutter packages upgrade`. If you want to use
pub manually, you can run it directly by setting the `FLUTTER_ROOT` environment variable.

## Upgrading Flutter channel and your packages

To update both the Flutter SDK and your packages, use the `flutter upgrade`
command from the root of your app (the same directory that contains the
`pubspec.yaml` file):

```
$pubspec.yaml` file, or you want to only update
the packages your app depends upon instead of both the packages and
Flutter itself, then use the following commands:
* `flutter packages get` to get all the dependencies listed
in the `pubspec.yaml` file, or
* `flutter packages upgrade` to get the latest versions
of all the dependencies listed in the `pubspec.yaml` file

We publish breaking change announcements to our
[mailing list](https://groups.google.com/forum/#!forum/flutter-dev). We
strongly recommend that you subscribe to get announcements from us.
Plus, we'd love to hear from you!
