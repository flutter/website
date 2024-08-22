---
title: Default `SystemUiMode` set to Edge-to-Edge
description: >
    Apps targeting Android SDK 15+ will be opted
    into edge-to-edge by default.
---

## Summary
If your Flutter app runs on Android and targets SDK version 15 or above,
your app will automatically be displayed in [edge-to-edge mode][1] on
devices running Android SDK 15+. In order to maintain your current
non-edge-to-edge app layout (including an unset `SystemUiMode`),
follow the [migration guide](#migration-guide) below.

## Context
Android is enforcing [edge-to-edge mode][2] by default for all apps targeting
Android 15 and above; see the [Android release notes][3] for more details on
this change. As a result, all Flutter apps running on Android that target
Android 15 and above will be opted into edge-to-edge mode by default, impacting
devices running on Android SDK 15+/API 35+ just like any other Android app.

At the time of publishing this guide, Flutter apps target Android 14 by
default and will not be opted into edge-to-edge mode automatically, but
your app will be impacted when you choose to target Android 15. If your app
targets `flutter.targetSdkVersion` (as it does by default), then your app will
target Android 15 starting with Flutter version 3.26, automatically opting your
app into edge-to-edge as a result; see the [timeline](#timeline) below for
details. If your app explicitly sets `SystemUiMode.edgeToEdge` for it to run in
edge-to-edge mode via a call to [`SystemChrome.setEnabledSystemUIMode`][4],
then your app is already migrated. Apps needing more time to migrate to
edge-to-edge mode will need to follow the steps below to opt out on
devices running Android SDK 15+.

Please note that 

1. Android plans for the workaround detailed below to be temporary.
2. Flutter plans to align with Android (and iOS) to
support edge-to-edge by default within the year, so **please migrate to**
**edge-to-edge before the operating system removes the ability to opt out**.

## Migration Guide
To opt out of edge-to-edge by default on SDK 15, a new style attribute
specification is required in each activity that needs an opt out. If
you have a parent style that all other styles that need an opt out inherit
from, then you can modify the parent only. In the example below, you will
update the style generated from `flutter create`.

By default, the styles used in a Flutter app are set in the manifest
(`your_app/android/app/src/main/AndroidManifest.xml`). Generally,
styles used in your app are denoted by `@style` and help theme your app.
Find these styles in your manifest. By default, you will find a normal theme
that you need to migrate:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application ...>
        <activity ...>
            <!-- Style you will need to modify: -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
            />
        </activity>
    </application>
</manifest>
```

To migrate this style, find where it is defined in
`your_app/android/app/src/main/res/values/styles.xml`. There, add the
following attribute to the style:

```xml
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

This modified style will opt your app out of edge-to-edge by default for
apps targeting Android SDK 15+, so now you are done!

## Timeline
Flutter apps will target Android 15 in the next stable version (3.26), so if
you wish to use this version and not manually set a lower target SDK version
for your Flutter app, these [migration steps](#migration-guide) will be
required to maintain an unset or non-edge-to-edge `SystemUiMode`.

## References

* [The supported Flutter `SystemUiMode`s][1]
* [The Android 15 edge-to-edge behavior changes guide][3]


[1]: https://api.flutter.dev/flutter/services/SystemUiMode.html
[2]: https://developer.android.com/develop/ui/views/layout/edge-to-edge 
[3]: https://developer.android.com/about/versions/15/behavior-changes-15#edge-to-edge 
[4]: https://api.flutter.dev/flutter/services/SystemChrome/setEnabledSystemUIMode.html