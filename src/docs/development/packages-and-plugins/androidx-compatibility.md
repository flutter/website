---
title: AndroidX compatibility
---

{{site.alert.note}}
  You may be directed to this page if the framework detects a problem in your
  Flutter app involving AndroidX incompatibilities.
{{site.alert.end}}

Android code commonly uses [support
libraries](https://developer.android.com/topic/libraries/support-library/) to
stay backwards compatible. There's two conflicting sets of support libraries
technically available today, but the
original libraries are deprecated and no longer supported.
[AndroidX](https://developer.android.com/jetpack/androidx/) is the only current
version of the support libraries. It has feature parity with the originals and
some additional capabilities.

The original support libraries and AndroidX are unfortunately completely
incompatible with each other. Gradle will crash when trying to build APKs that
use both sets of libraries.

Some Flutter plugins have been migrated to AndroidX after originally using the
original support libraries. Flutter apps that aren't compatible with AndroidX
will fail to compile when using the latest version of these plugins.

## Fixing AndroidX crashes in a Flutter app

There's two main ways AndroidX can break a Flutter app at compile time.

1. The app is using an AndroidX plugin and its main `gradle.build` file has a
   `compileSdk` below 28.
2. The app is using both deprecated support and AndroidX code at the same time.

The error messages from Gradle vary. Occasionally the messages will mention
"package androidx" or "package android.support" directly. However often the
Gradle error messages aren't obviously related, and will instead talk about
"AAPT," "AAPT2," or otherwise mention failing at "parsing resources."

Both of these problems need to be fixed by either manually migrating the code or
downgrading to versions of the plugins that are still using the original support
libraries.

### How to migrate a Flutter app to AndroidX

{{site.alert.note}}
  It's impossible to fully migrate your app to AndroidX if it's actively using
  some plugins that are still on the previous old support library. If your app
  depends on plugins that are using the old `android.support` packages, you'll
  need to [avoid AndroidX](#avoiding-androidx) instead.
{{site.alert.end}}

First make sure that `compileSdkVersion` is at least `28` in `app/build.gradle`.
This property controls the version of the Android SDK that Gradle uses to build
your APK. It doesn't affect the minimum SDK version that your app can run on.
See the Android developer docs on ["The module-level build
file"](https://developer.android.com/studio/build/#module-level) for more
information.

#### Recommended: Use Android Studio to migrate your app

This requires the latest version of Android Studio.

1. Import your Flutter app into Android Studio so that the IDE can parse the
   Android code following the steps at ["Editing Android code in Android Studio
   with full IDE
   support"](https://flutter.io/docs/development/tools/android-studio#android-ide).
2. Then follow the instructions on ["Migrating to
   AndroidX"](https://developer.android.com/jetpack/androidx/migrate).

#### Not recommended: Manually migrate your app

See ["Migrating to
AndroidX"](https://developer.android.com/jetpack/androidx/migrate) for detailed
instructions on how to do this.

### Avoiding AndroidX

If you want or need to avoid migrating to AndroidX, you'll need to go through
and pin your plugin dependencies in your `pubspec.yaml` to the last major
version from before they were migrated.

These are the last available versions of all the `flutter/plugins` packages that
are pre AndroidX:

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

Note however that this list is not an exhaustive list of all the Flutter plugins
that use AndroidX, and the AndroidX dependency in your app may be coming from
another plugin besides these.

## For plugin maintainers: Migrating a Flutter plugin to AndroidX

Migrating a Flutter plugin to AndroidX follows basically the same process as
[migrating a Flutter app](#How-to-migrate-a-Flutter-app-to-AndroidX), but with
some additional concerns and some slight changes.

1. Make sure you increment the [major
   version](https://www.dartlang.org/tools/pub/versioning#semantic-versions) of
   your plugin for this change and clearly document it in your plugin's
   changelog. This is a breaking change that requires manual migration from
   users to fix. Pub treats different digits differently depending on if a
   plugin is pre or post 1.0.0. The very first digit is the major version for
   plugins that are at or above 1.0.0. For plugins that are below it, the middle
   digit is considered to the major version.
2. Plugin code can be automatically migrated with Android Studio the same way
   that Flutter app code can be. Import the `plugin_root/example` app into the
   IDE as if it's a regular Flutter app. Android Studio will also import and
   parse the plugin's Android code.
