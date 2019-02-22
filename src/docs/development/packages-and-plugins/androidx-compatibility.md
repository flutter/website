---
title: AndroidX compatibility
description: How to fix AndroidX incompatibilities that have been detected by the Flutter framework.
---

{{site.alert.note}}
  You may be directed to this page if the framework detects a problem in your
  Flutter app involving AndroidX incompatibilities.
{{site.alert.end}}

Android code often uses the
[`android.support`]({{site.android-dev}}/topic/libraries/support-library/)
libraries to ensure backwards compatibility. The `android.support`
libraries are deprecated, and replaced with
[AndroidX]({{site.android-dev}}/jetpack/androidx/).
AndroidX has feature parity with the old libraries
with some additional capabilities but, unfortunately, these two sets of
libraries are incompatible.

_Gradle crashes when trying to build an APK that relies on both sets
of libraries._ This page explains how you can workaround this issue.

## Fixing AndroidX crashes in a Flutter app

AndroidX can break a Flutter app at compile time in two ways:

1. The app uses an AndroidX plugin and its main `build.gradle` file has a
   `compileSdkVersion` below version 28.
2. The app uses both deprecated and AndroidX code at the same time.

The error messages from Gradle vary. Sometimes the messages mention
"package androidx" or "package android.support" directly. However, often the
Gradle error messages aren't obvious, and instead talk about
"AAPT," "AAPT2," or otherwise mention failing at "parsing resources."

These problems must be fixed by either manually migrating the
code to the same library, or downgrading to versions of the plugins
that still use the original support libraries.

### How to migrate a Flutter app to AndroidX

{{site.alert.note}}
  It's impossible to fully migrate your app to AndroidX if it's
  actively using any plugins that rely on the old support library.
  If your app depends on plugins that use the old `android.support`
  packages, you'll need to [avoid using AndroidX](#avoiding-androidx).
{{site.alert.end}}

First make sure that `compileSdkVersion` is at least `28` in
`app/build.gradle`.  This property controls the version of the
Android SDK that Gradle uses to build your APK. It doesn't affect
the minimum SDK version that your app can run on. See the Android
developer docs on [the module-level build
file]({{site.android-dev}}/studio/build/#module-level)
for more information.

#### Recommended: Use Android Studio to migrate your app

This requires the latest version of Android Studio.
Use the following instructions:

1. Import your Flutter app into Android Studio so that the IDE can
   parse the Android code following the steps in
   [Editing Android code in Android Studio with full IDE
   support](/docs/development/tools/android-studio#android-ide).
2. Follow the instructions for [Migrating to
   AndroidX]({{site.android-dev}}/jetpack/androidx/migrate).

#### Not recommended: Manually migrate your app

See [Migrating to
AndroidX]({{site.android-dev}}/jetpack/androidx/migrate) for detailed
instructions on how to do this.

### Avoiding AndroidX

If you want or need to avoid migrating to AndroidX, you'll need to 
pin your plugin dependencies in your `pubspec.yaml` to the last major
version from before they were migrated.

These are the last available versions of all the `flutter/plugins`
packages that are pre AndroidX:

- `android_alarm_manager`: 0.2.3
- `android_intent`: 0.2.1
- `battery`: 0.3.0
- `camera`: 0.2.9+1
- `cloud_firestore`: 0.8.2+3
- `cloud_functions`: 0.0.5
- `connectivity`: 0.3.2
- `device_info`: 0.3.0
- `firebase_admob`: 0.7.0
- `firebase_analytics`: 1.1.0
- `firebase_auth`: 0.7.0
- `firebase_core`: 0.2.5+1
- `firebase_database`: 1.0.5
- `firebase_dynamic_links`: 0.1.1
- `firebase_messaging`: 2.1.0
- `firebase_ml_vision`: 0.2.1
- `firebase_performance`: 0.0.8+1
- `firebase_remote_config`: 0.0.6+1
- `firebase_storage`: 1.0.4
- `google_maps_flutter`: 0.1.0
- `google_sign_in`: 3.2.4
- `image_picker`: 0.4.12+1
- `local_auth`: 0.3.1
- `package_info`: 0.3.2+1
- `path_provider`: 0.4.1
- `quick_actions`: 0.2.2
- `sensors`: 0.3.5
- `share`: 0.5.3
- `shared_preferences`: 0.4.3
- `url_launcher`: 4.1.0+1
- `video_player`: 0.9.0
- `webview_flutter`: 0.2.0

Note that this is not an exhaustive list of all Flutter plugins
that use AndroidX, and the AndroidX dependency in your app may be
coming from another plugin besides these.

## For plugin maintainers: Migrating a Flutter plugin to AndroidX

Migrating a Flutter plugin to AndroidX follows basically the same process as
[migrating a Flutter app](#How-to-migrate-a-Flutter-app-to-AndroidX),
but with some additional concerns and some slight changes.

1. Make sure to increment the [major
   version]({{site.dart-site}}/tools/pub/versioning#semantic-versions) of
   your plugin for this change and clearly document it in your plugin's
   changelog. This breaking change requires manual migration for
   users to fix. Pub treats digits differently depending on whether
   a plugin is pre- or post-1.0.0. The very first digit is the major version
   for plugins that are at or above 1.0.0. For plugins below 1.0.0,
   the middle digit is considered to the major version.
2. Plugin code can be automatically migrated with Android Studio in the same
   way as Flutter app code. Import the `plugin_root/example` app into the
   IDE as if it's a regular Flutter app. Android Studio also imports and
   parses the plugin's Android code.

