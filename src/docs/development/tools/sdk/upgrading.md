---
title: Upgrading Flutter
short-title: Upgrading
description: Upgrading Flutter
---

No matter which [Flutter release channel][] you follow,
you can use the `flutter` command to upgrade your Flutter SDK
and the packages that your app depends on.


## One-time setup

For the `flutter` command to work correctly,
your app's `pubspec.yaml` file must require the Flutter SDK.
For example, the following snippet specifies that the
`flutter` and `flutter_test` packages require the Flutter SDK:

```yaml
name: hello_world
dependencies:
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_test:
    sdk: flutter
```

{{site.alert.warning}}
Don't use the `pub get` or `pub upgrade` commands to manage dependencies
for Flutter apps.
Instead, use `flutter packages get` or `flutter packages upgrade`.
If you want to use pub manually, you can run it directly by setting the
`FLUTTER_ROOT` environment variable.
{{site.alert.end}}


## Upgrading the Flutter SDK and packages

To update both the Flutter SDK and the packages that your app depends on,
use the `flutter upgrade` command from the root of your app
(the same directory that contains the `pubspec.yaml` file):

```terminal
$ flutter upgrade
```

This command first gets the most recent version of the Flutter SDK
that's available on your Flutter channel.
Then this command updates each package that your app depends on
to the most recent compatible version.

If you want an even more recent version of the Flutter SDK,
switch to a less stable Flutter channel
and then run `flutter upgrade`.

## Switching Flutter channels

Flutter has [four release channels][Flutter release channel]:
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
you can download it from the [Flutter SDK archive][].
{{site.alert.end}}

## Upgrading packages only

If you've modified your `pubspec.yaml` file or you want to update
only the packages that your app depends upon (instead of both the packages and
Flutter itself), then use one of the `flutter packages` commands.

To get all the dependencies listed in the `pubspec.yaml` file,
without unnecessary updates, use the `get` command:

```terminal
$ flutter packages get
```

To update to the _latest compatible versions_ of
all the dependencies listed in the `pubspec.yaml` file,
use the `upgrade` command:

```terminal
$ flutter packages upgrade
```


## Keeping informed

We publish breaking change announcements to our [mailing list][].
We strongly recommend that you subscribe to get announcements from us.
Plus, we'd love to hear from you!

[Flutter SDK archive]: /docs/development/tools/sdk/archive
[Flutter release channel]: https://github.com/flutter/flutter/wiki/Flutter-build-release-channels
[mailing list]: https://groups.google.com/forum/#!forum/flutter-dev
