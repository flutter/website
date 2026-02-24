---
title: Set default of `SystemUiMode` to edge-to-edge
description: >-
    By default, apps targeting Android SDK 15+ will opt
    in to edge-to-edge mode.
---

{% render "docs/breaking-changes.md" %}

## Summary

Edge-to-edge mode is Android's default display behavior as of
Android version 15 and above. In Android 15, you could
opt out of this behavior but, as of Android 16, you can't.
To learn more about this change,
check out the [Android 16 release notes][].

[Android 16 release notes]: {{site.android-dev}}/about/versions/16/behavior-changes-16#edge-to-edge

## Android 16 (or later)

Using the mechanism to opt out of edge-to-edge on Android 16
or later might cause your app to crash, but you can avoid this
by using version-specific resources; for details,
visit the [migration guide](#migration-guide).

To learn how to structure your app to avoid this,
we recommend that you visit the Leancode article, [Mastering Edge-To-Edge in Flutter:
A Deep Dive Into the System Navigation Bar in Android][article].
You can also find more discussion in [Issue 168635][] on GitHub.

[article]: https://leancode.co/blog/mastering-edge-to-edge-in-flutter
[Issue 168635]: {{site.github}}/flutter/flutter/issues/168635#issuecomment-3485274018

## Android 15 (and below)

If your Flutter app targets Android SDK version 15,
your app automatically displays in edge-to-edge mode,
as documented on the [`SystemUiMode`][] API page.
To maintain non edge-to-edge app behavior
(including an unset `SystemUiMode`),
follow the steps in the [migration guide](#migration-guide).

[`SystemUiMode`]: {{site.api}}/flutter/services/SystemUiMode.html

## Context

By default, Android enforces [edge-to-edge mode][] for all apps that
target Android 15 or later.
To learn more about this change, check out the [Android 15 release notes][].
This impacts devices running on Android SDK 15+ or API 35+.

Prior to Flutter 3.27, Flutter apps targeted Android 14 by default and
didn't opt into edge-to-edge mode automatically, but
your app _will_ be impacted when you choose to target Android 15.
If your app targets `flutter.targetSdkVersion` (as it does by default),
then it targets Android 15 starting with Flutter version 3.27,
automatically opting your app in to edge-to-edge.

If your app explicitly sets `SystemUiMode.edgeToEdge` to run in
edge-to-edge mode by calling [`SystemChrome.setEnabledSystemUIMode`][],
then your app is already migrated. Apps needing more time to migrate to
edge-to-edge mode must use the following steps to opt out on
devices running Android SDK 15.

Be aware of the following:

 1. Android plans for the workaround detailed here to be temporary.
 2. Flutter plans to align with Android (and iOS) to
    support edge-to-edge by default within the year, so
    **migrate to edge-to-edge mode before the operating system
    removes the ability to opt out**.

[edge-to-edge mode]: {{site.android-dev}}/develop/ui/views/layout/edge-to-edge
[Android 15 release notes]: {{site.android-dev}}/about/versions/15/behavior-changes-15#edge-to-edge
[`SystemChrome.setEnabledSystemUIMode`]: {{site.api}}/flutter/services/SystemChrome/setEnabledSystemUIMode.html

## Migration guide

To opt out of edge-to-edge on Android SDK 15,
specify the new style attribute in each activity that requires it.
If you have a parent style that child styles need to opt out of,
you can modify the parent only. In the following example,
update the style configuration generated from `flutter create`.

By default, the styles used in a Flutter app are set in
the Android manifest file (`your_app/android/app/src/main/AndroidManifest.xml`).
Generally, styles are denoted by `@style` and help theme your app.
Modify these default styles in your manifest file:

```xml title="AndroidManifest.xml" highlightLines=5-8
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application ...>
        <activity ...>
            <!-- Style to modify: -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
            />
        </activity>
    </application>
</manifest>
```

Locate the style definition in:
`your_app/android/app/src/main/res/values/styles.xml`.

Add the following attribute to the appropriate styles:

```xml title="styles.xml" highlightLines=6,12
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">
        ...
        <!-- Add the following line: -->
        <item name="android:windowOptOutEdgeToEdgeEnforcement">true</item>
    </style>
    ...
    <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
        ...
	      <!-- Add the following line: -->
        <item name="android:windowOptOutEdgeToEdgeEnforcement">true</item>
    </style>
</resources>
```

Make sure to apply the same change in the night mode styles file as well:
`your_app/android/app/src/main/res/values-night/styles.xml`.

Ensure both styles are updated consistently in both files.

This modified style opts your app out of edge-to-edge for
apps targeting Android SDK 15.

:::note
If your app runs on Android 16 or above, to avoid crashes you can
create a `your_app/android/app/src/main/res/values-35` resource
directory that contains styles without the
`android:windowOptOutEdgeToEdgeEnforcement` attribute.
:::

## Timeline

Starting in Flutter 3.27, Flutter apps target Android 15 by default, so
if you wish to use this version and not manually set
a lower target SDK version for your Flutter app,
follow the preceding [migration steps](#migration-guide) to
maintain an unset or non-edge-to-edge `SystemUiMode`.

Landed in version: 3.26.0-0.0.pre<br>
Stable release: 3.27

## References

* [The supported Flutter `SystemUiMode`s][]
* [The Android 15 edge-to-edge behavior changes guide][]
* [The Android 16 edge-to-edge behavior changes guide][]

[The supported Flutter `SystemUiMode`s]: {{site.api}}/flutter/services/SystemUiMode.html
[The Android 15 edge-to-edge behavior changes guide]: {{site.android-dev}}/about/versions/15/behavior-changes-15#edge-to-edge
[The Android 16 edge-to-edge behavior changes guide]: {{site.android-dev}}/about/versions/16/behavior-changes-16#edge-to-edge
[flutter#169810]: https://github.com/flutter/flutter/issues/169810
