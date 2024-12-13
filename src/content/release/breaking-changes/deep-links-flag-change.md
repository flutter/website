---
title: Deep links flag change
description: >-

---

## Summary

The default value for Flutter’s deep linking flag has changed from false to true, meaning deep linking is now opt-in by default.  

## Migration guide


If you’re using Flutter’s default deep linking setup, there’s no need to manually set the flag to true anymore.

However, if you’re using third-party plugins for deep links, such as:

[firebase dynamic links][https://firebase.google.com/docs/dynamic-links]
[uni_link][https://pub.dev/packages/uni_links]
[app_links][https://pub.dev/packages/app_links]
This update will introduce a breaking change. In this case, you’ll need to manually reset the Flutter deep linking flag to false.

Before: non-op

After:

Manually disable the deep linking flag if you're using third-party plugins:

* Android Manifest file

```dart
<manifest>
   <application
       <activity>
<meta-data android:name="flutter_deeplinking_enabled" android:value="false" />
       </activity>
   </application>
</manifest>
```

* iOS info.plist file

```
   <key>FlutterDeepLinkingEnabled</key>
   <false/>
```

## Timeline

Landed in version: 3.27.0-0.0.pre<br>
Stable release: 3.27

## References

Design documentation:
flutter.dev/go/deep-link-flag-migration.

Relevant PR:

* [Set deep linking flag to true by defaulte][https://github.com/flutter/engine/pull/52350]

