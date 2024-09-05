---
title: Upgrading Flutter
short-title: Upgrading
description: How to upgrade Flutter.
---

No matter which one of the Flutter release channels
you follow, you can use the `flutter` command to upgrade your
Flutter SDK or the packages that your app depends on.

## Upgrading the Flutter SDK

To update the Flutter SDK use the `flutter upgrade` command:

```console
$ flutter upgrade
```

This command gets the most recent version of the Flutter SDK
that's available on your current Flutter channel.

If you are using the **stable** channel
and want an even more recent version of the Flutter SDK,
switch to the **beta** channel using `flutter channel beta`,
and then run `flutter upgrade`.

### Keeping informed

We publish [migration guides][] for known breaking changes.

We send announcements regarding these changes to the
[Flutter announcements mailing list][flutter-announce].

To avoid being broken by future versions of Flutter,
consider submitting your tests to our [test registry][].


## Switching Flutter channels

Flutter has two release channels:
**stable** and **beta**.

### The **stable** channel

We recommend the **stable** channel for new users
and for production app releases.
The team updates this channel about every three months.
The channel might receive occasional hot fixes
for high-severity or high-impact issues.

The continuous integration for the Flutter team's plugins and packages
includes testing against the latest **stable** release.

The latest documentation for the **stable** branch
is at: <https://api.flutter.dev>

### The **beta** channel

The **beta** channel has the latest stable release.
This is the most recent version of Flutter that we have heavily tested.
This channel has passed all our public testing,
has been verified against test suites for Google products that use Flutter,
and has been vetted against [contributed private test suites][test registry].
The **beta** channel receives regular hot fixes
to address newly discovered important issues.

The **beta** channel is essentially the same as the **stable** channel
but updated monthly instead of quarterly.
Indeed, when the **stable** channel is updated,
it is updated to the latest **beta** release.

### Other channels

We currently have one other channel, **master**.
People who [contribute to Flutter][] use this channel.

This channel is not as thoroughly tested as
the **beta** and **stable** channels.

We do not recommend using this channel as
it is more likely to contain serious regressions.

The latest documentation for the **master** branch
is at: <https://main-api.flutter.dev>

### Changing channels

To view your current channel, use the following command:

```console
$ flutter channel
```

To change to another channel, use `flutter channel <channel-name>`.
Once you've changed your channel, use `flutter upgrade`
to download the latest Flutter SDK and dependent packages for that channel.
For example:

```console
$ flutter channel beta
$ flutter upgrade
```


## Switching to a specific Flutter version

To switch to a specific Flutter version:

1. Find your desired **Flutter version** on the [Flutter SDK archive][].

1. Navigate to the Flutter SDK:

   ```console
   $ cd /path/to/flutter
   ```

   :::tip
   You can find the Flutter SDK's path using `flutter doctor --verbose`.
   :::

1. Use `git checkout` to switch to your desired **Flutter version**:

   ```console
   $ git checkout <Flutter version>
   ```


## Upgrading packages

If you've modified your `pubspec.yaml` file, or you want to update
only the packages that your app depends upon
(instead of both the packages and Flutter itself),
then use one of the `flutter pub` commands.

To update to the _latest compatible versions_ of
all the dependencies listed in the `pubspec.yaml` file,
use the `upgrade` command:

```console
$ flutter pub upgrade
```

To update to the _latest possible version_ of
all the dependencies listed in the `pubspec.yaml` file,
use the `upgrade --major-versions` command:

```console
$ flutter pub upgrade --major-versions
```

This also automatically update the constraints
in the `pubspec.yaml` file.

To identify out-of-date package dependencies and get advice
on how to update them, use the `outdated` command. For details, see
the Dart [`pub outdated` documentation]({{site.dart-site}}/tools/pub/cmd/pub-outdated).

```console
$ flutter pub outdated
```

[Flutter SDK archive]: /release/archive
[flutter-announce]: {{site.groups}}/forum/#!forum/flutter-announce
[pubspec.yaml]: {{site.dart-site}}/tools/pub/pubspec
[test registry]: {{site.repo.organization}}/tests
[contribute to Flutter]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md
[migration guides]: /release/breaking-changes
