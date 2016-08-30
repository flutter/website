---
layout: page
title: Upgrading Flutter
sidebar: home_sidebar
permalink: /upgrading/
---

We recommend that you
keep your app updated to our `alpha` branch, as we update as frequently
as every week.

To update, use the `flutter upgrade`
command from the root of your app (the same directory that contains the
`pubspec.yaml` file):

```
$ flutter upgrade
```

If you've modified your `pubspec.yaml` file, or you want to update
the packages you app depends upon without updating flutter itself,
use...
* `flutter packages get` to get all the dependencies listed
in the `pubspec.yaml` file, or
* `flutter packages upgrade` to get the latest versions
of all the dependencies listed in the `pubspec.yaml` file

We publish breaking change announcements to our
[mailing list](https://groups.google.com/forum/#!forum/flutter-dev). We
strongly recommend that you subscribe to get announcements from us.
Plus, we'd love to hear from you!
