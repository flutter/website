---
layout: page
title: Upgrading Flutter
sidebar: home_sidebar
permalink: /upgrading/
---

We recommend tracking the `master` branch in the flutter repository, which
updates continuously as we improve Flutter.

## Upgrading Flutter channel and your packages

To update both the Flutter SDK and your packages, use the `flutter upgrade`
command from the root of your app (the same directory that contains the
`pubspec.yaml` file):

```
$ flutter upgrade
```

## Upgrading your packages

If you've modified your `pubspec.yaml` file, or you want to only update
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
