---
title: Deep links flag change

---

## Summary

<b>This (potential) breaking change only affects mobile apps and only if you
use a third party deep linking plugin package.</b>

The default value for Flutter’s deep linking flag has changed from `false` to `true`,
meaning that deep linking is now opt-in by default.  

## Migration guide


If you’re using Flutter’s default deep linking setup, this is not a breaking change for you. 

However, if you’re using third-party plugins for deep links, such as:

[firebase dynamic links][https://firebase.google.com/docs/dynamic-links]
[uni_link][https://pub.dev/packages/uni_links]
[app_links][https://pub.dev/packages/app_links]

In this case, you must manually reset the Flutter deep linking flag to `false`.

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

