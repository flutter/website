---
title: Managing plugins and dependencies in add-to-app
short-title: Plugin setup
description: Learn how to use plugins and share your plugin's library dependencies with your existing app.
---

This guide describes how to set up your project to consume
plugins and how to manage your Gradle library dependencies
between your existing Android app and your Flutter module's plugins.

## A. Simple scenario

In the simple cases:

* Your Flutter module uses a plugin that has no additional
  Android Gradle dependency because it only uses Android OS
  APIs, such as the camera plugin.
* Your Flutter module uses a plugin that has an Android
  Gradle dependency, such as
  [ExoPlayer from the video_player plugin][],
  but your existing Android app didn't depend on ExoPlayer.

There are no additional steps needed. Your add-to-app
module will work the same way as a full-Flutter app.
Whether you integrate using Android Studio, 
Gradle subproject or AARs,
transitive Android Gradle libraries are automatically
bundled as needed into your outer existing app.

## B. Plugins needing project edits

Some plugins require you to make some edits to the
Android side of your project.

For example, the integration instructions for the
[firebase_crashlytics][] plugin require manual
edits to your Android wrapper project's `build.gradle` file.

For full-Flutter apps, these edits are done in your
Flutter project's `/android/` directory.

In the case of a Flutter module, there are only Dart
files in your module project. Perform those Android
Gradle file edits on your outer, existing Android
app rather than in your Flutter module.

{{site.alert.note}}
  Astute readers might notice that the Flutter module
  directory also contains an `.android` and an
  `.ios` directory. Those directories are Flutter-tool-generated
  and are only meant to bootstrap Flutter into generic
  Android or iOS libraries. They should not be edited or checked-in.
  This allows Flutter to improve the integration point should
  there be bugs or updates needed with new versions of Gradle,
  Android, Android Gradle Plugin, etc.

  For advanced users, if more modularity is needed and you must
  not leak knowledge of your Flutter module's dependencies into
  your outer host app, you can rewrap and repackage your Flutter
  module's Gradle library inside another native Android Gradle
  library that depends on the Flutter module's Gradle library.
  You can make your Android specific changes such as editing the
  AndroidManifest.xml, Gradle files or adding more Java files
  in that wrapper library.
{{site.alert.end}}

## C. Merging libraries

The scenario that requires slightly more attention is if
your existing Android application already depends on the
same Android library that your Flutter module
does (transitively via a plugin).

For instance, your existing app's Gradle may already have:

<!--code-excerpt "<existing app>/app/build.gradle" title-->
```gradle
…
dependencies {
  …
  implementation 'com.crashlytics.sdk.android:crashlytics:2.10.1'
  …
}
…
```

And your Flutter module also depends on
[firebase_crashlytics][] via pubspec.yaml:

<!--code-excerpt "<Flutter module>/pubspec.yaml" title-->
```yaml
…
dependencies:
  …
  firebase_crashlytics: ^0.1.3
  …
…
```

This plugin usage transitively adds a Gradle dependency again via
firebase_crashlytics v0.1.3's own [Gradle file][]:

<!--code-excerpt "<firebase_crashlytics via pub>/android/build.gradle" title-->
```gradle
…
dependencies {
  …
  implementation 'com.crashlytics.sdk.android:crashlytics:2.9.9'
  …
}
…
```

The two `com.crashlytics.sdk.android:crashlytics` dependencies
might not be the same version. In this example,
the host app requested v2.10.1 and the Flutter
module plugin requested v2.9.9.

By default, Gradle v5
[resolves dependency version conflicts][]
by using the newest version of the library.

This is generally ok as long as there are no API
or implementation breaking changes between the versions.
For example, you might use the new Crashlytics library
in your existing app as follows:

<!--code-excerpt "<existing app>/app/build.gradle" title-->
```gradle
…
dependencies {
  …
  implementation 'com.google.firebase:firebase-crashlytics:17.0.0-beta03
  …
}
…
```

This approach won't work since there are major API differences
between the Crashlytics' Gradle library version
v17.0.0-beta03 and v2.9.9.

For Gradle libraries that follow semantic versioning,
you can generally avoid compilation and runtime errors
by using the same major semantic version in your
existing app and Flutter module plugin.


[ExoPlayer from the video_player plugin]: {{site.github}}/flutter/plugins/blob/master/packages/video_player/video_player/android/build.gradle
[firebase_crashlytics]: {{site.pub}}/packages/firebase_crashlytics
[Gradle file]: {{site.github}}/FirebaseExtended/flutterfire/blob/bdb95fcacf7cf077d162d2f267eee54a8b0be3bc/packages/firebase_crashlytics/android/build.gradle#L40
[resolves dependency version conflicts]: https://docs.gradle.org/current/userguide/dependency_resolution.html#sub:resolution-strategy

