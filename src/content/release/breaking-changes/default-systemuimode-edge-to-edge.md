---
title: Set default of `SystemUiMode` to edge-to-edge
description: >-
    By default, apps targeting Android SDK 15+ will opt
    in to edge-to-edge mode.
---

## Summary

If your Flutter app targets Android SDK version 15 or later,
your app automatically displays in edge-to-edge mode,
as documented on the [`SystemUiMode`][] API page.
To maintain non-edge-to-edge app behavior
(including an unset `SystemUiMode`),
follow the steps in [migration guide](#migration-guide).

[`SystemUiMode`]: {{site.api}}/flutter/services/SystemUiMode.html

## Context

By default, Android enforces [edge-to-edge mode][] for all apps that
target Android 15 or later.
To learn more about this change, check out the [Android release notes][].
This impacts devices running on Android SDK 15+ or API 35+.

Prior to Flutter 3.27, Flutter apps target Android 14 by default and
won't opt into edge-to-edge mode automatically, but
your app _will_ be impacted when you choose to target Android 15.
If your app targets `flutter.targetSdkVersion` (as it does by default),
then it targets Android 15 starting with Flutter version 3.27,
automatically opting your app in to edge-to-edge.

If your app explicitly sets `SystemUiMode.edgeToEdge` to run in
edge-to-edge mode by calling [`SystemChrome.setEnabledSystemUIMode`][],
then your app is already migrated. Apps needing more time to migrate to
edge-to-edge mode must use the following steps to opt out on
devices running Android SDK 15+.

Be aware of the following:

 1. Android plans for the workaround detailed here to be temporary.
 2. Flutter plans to align with Android (and iOS) to
    support edge-to-edge by default within the year, so
    **migrate to edge-to-edge mode before the operating system
    removes the ability to opt out**.

[edge-to-edge mode]: {{site.android-dev}}/develop/ui/views/layout/edge-to-edge
[Android release notes]: {{site.android-dev}}/about/versions/15/behavior-changes-15#edge-to-edge
[`SystemChrome.setEnabledSystemUIMode`]: {{site.api}}/flutter/services/SystemChrome/setEnabledSystemUIMode.html

## Migration guide

To opt out of edge-to-edge on SDK 15, specify
the new style attribute in each activity that requires it.
If you have a parent style that child styles need to opt out of,
you can modify the parent only.
In the following example,
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

Find where this style is defined in
`your_app/android/app/src/main/res/values/styles.xml`.
There, add the following attribute to the style:

```xml title="styles.xml" highlightLines=7
<?xml version="1.0" encoding="utf-8"?>
<resources>
    ...
    <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
        ...
	      <!-- Add the following line: -->
        <item name="android:windowOptOutEdgeToEdgeEnforcement">true</item>
    </style>
</resources>
```

This modified style opts your app out of edge-to-edge for
apps targeting Android SDK 15+.
So now you're done!

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

[The supported Flutter `SystemUiMode`s]: {{site.api}}/flutter/services/SystemUiMode.html
[The Android 15 edge-to-edge behavior changes guide]: {{site.android-dev}}/about/versions/15/behavior-changes-15#edge-to-edge
