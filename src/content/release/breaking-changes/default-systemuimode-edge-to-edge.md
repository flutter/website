---
title: Set default for SystemUiMode to Edge-to-Edge
description: >
    By default, apps targeting Android SDK 15+ will opt
    into edge-to-edge mode.
---

## Summary
If your Flutter app targets Android SDK version 15 or later,
your app will automatically display in edge-to-edge mode,
as shown in the [`SystemUiMode`][1] API page.
To maintain non-edge-to-edge app behavior
(including an unset `SystemUiMode`),
use the info in the [migration guide](#migration-guide).

## Context
By default, Android enforces [edge-to-edge mode][2] for all apps targeting
Android 15 and later. For more details, check out the [Android release notes][3].
This impacts devices running on Android SDK 15+ or API 35+.

Prior to the Q4 2024 release, Flutter apps target Android 14 by
default and won't opt into edge-to-edge mode automatically, but
your app _will_ be impacted when you choose to target Android 15.
If your app targets `flutter.targetSdkVersion` (as it does by default),
then it will target Android 15 starting with Flutter version 3.26, automatically opting your
app into edge-to-edge. Visit the [timeline](#timeline) for details.
If your app explicitly sets `SystemUiMode.edgeToEdge` to run in
edge-to-edge mode by calling [`SystemChrome.setEnabledSystemUIMode`][4],
then your app is already migrated. Apps needing more time to migrate to
edge-to-edge mode must use the following steps to opt out on
devices running Android SDK 15+.

Be aware of the following:

1. Android plans for the workaround detailed here to be temporary.
2. Flutter plans to align with Android (and iOS) to
    support edge-to-edge by default within the year,
    so please **migrate to edge-to-edge mode before the operating system
    removes the ability to opt out**.

## Migration guide

To opt out of edge-to-edge on SDK 15, specify the new style attribute
in each activity that requires it. If you have a parent style that child styles
need to opt out of, you can modify the parent only.
In the following example, update the style generated from `flutter create`.

By default, the styles used in a Flutter app are set in the manifest file
(`your_app/android/app/src/main/AndroidManifest.xml`). Generally,
styles are denoted by `@style` and help theme your app.
Modify these default styles in your manifest:

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

Find where this style is defined in
`your_app/android/app/src/main/res/values/styles.xml`.
There, add the following attribute to the style:

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

This modified style opts your app out of edge-to-edge for
apps targeting Android SDK 15+. So now you are done!

## Timeline
Flutter apps will target Android 15 in the next stable version (3.26), so if
you wish to use this version and not manually set a lower target SDK version
for your Flutter app, these [migration steps](#migration-guide) will be
required to maintain an unset or non-edge-to-edge `SystemUiMode`.

## References

* [The supported Flutter `SystemUiMode`s][1]
* [The Android 15 edge-to-edge behavior changes guide][3]


[1]: {{site.api}}/flutter/services/SystemUiMode.html
[2]: {{site.android-dev}}/develop/ui/views/layout/edge-to-edge 
[3]: {{site.android-dev}}/about/versions/15/behavior-changes-15#edge-to-edge 
[4]: {{site.api}}/flutter/services/SystemChrome/setEnabledSystemUIMode.html