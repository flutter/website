---
title: Upgrading Flutter
short-title: Upgrading
description: How to upgrade Flutter.
---

No matter which one of the Flutter [release channels][]
you follow, you can use the `flutter` command to upgrade your
Flutter SDK or the packages that your app depends on.

## Upgrading the Flutter SDK

To update the Flutter SDK use the `flutter upgrade` command:

```terminal
$ flutter upgrade
```

This command gets the most recent version of the Flutter SDK
that's available on your current Flutter channel.

If you want an even more recent version of the Flutter SDK,
switch to a less stable Flutter channel
and then run `flutter upgrade`.


## Switching Flutter channels

Flutter has four [release channels][]:
**stable**, **beta**, **dev**, and **master**.
We recommend using the **{{site.sdk.channel}}** channel
unless you need a more recent release.

To view your current channel, use the following command:

```terminal
$ flutter channel
```

To change to another channel, use `flutter channel <channel-name>`.
Once you've changed your channel, use `flutter upgrade`
to download the Flutter SDK and dependent packages.
For example:

```terminal
$ flutter channel dev
$ flutter upgrade
```

{{site.alert.note}}
  If you need a specific version of the Flutter SDK,
  you can download it from the [Flutter SDK releases][].
{{site.alert.end}}


## Upgrading packages

If you've modified your `pubspec.yaml` file, or you want to update
only the packages that your app depends upon
(instead of both the packages and Flutter itself),
then use one of the `flutter pub` commands.

To update to the _latest compatible versions_ of
all the dependencies listed in the `pubspec.yaml` file,
use the `upgrade` command:

```terminal
$ flutter pub upgrade
```

To identify out-of-date package dependencies and get advice
on how to update them, use the `outdated` command. For details, see
the Dart [`pub outdated` documentation](https://dart.dev/tools/pub/cmd/pub-outdated).

```terminal
$ flutter pub outdated
```

## Keeping informed

We publish breaking change announcements to the
[Flutter announcements mailing list][flutter-announce].
You can also ask questions on the [Flutter dev mailing list][flutter-dev].
Aside from subscribing to receive announcements,
we'd love to hear from you!

[Flutter SDK releases]: /docs/development/tools/sdk/releases
[release channels]: {{site.github}}/flutter/flutter/wiki/Flutter-build-release-channels
[flutter-announce]: {{site.groups}}/forum/#!forum/flutter-announce
[flutter-dev]: {{site.groups}}/forum/#!forum/flutter-dev
[pubspec.yaml]: https://dart.dev/tools/pub/pubspec
