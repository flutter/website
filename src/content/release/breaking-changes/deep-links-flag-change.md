---
title: Deep links flag change
description: >-
  If you use a third party deep linking plugin package for mobile apps,
  set Flutter's deep linking flag to false.
---

## Summary

**This breaking change only affects mobile apps that
use a third party deep linking plugin package.**

The default value for Flutter's deep linking option has changed from
`false` to `true`, meaning that deep linking is now opt-in by default.

## Migration guide

If you're using Flutter's default deep linking setup,
this isn't a breaking change for you.

However, if you're using a third-party plugin for deep links,
such as the following, this update introduces a breaking change:

- [Firebase dynamic links](https://firebase.google.com/docs/dynamic-links)
- [`package:uni_link`]({{site.pub-pkg}}/uni_links)
- [`package:app_links`]({{site.pub-pkg}}/app_links)

In this case, you must manually reset the
Flutter deep linking option to `false`.

Within your app's `AndroidManifest.xml` file for Android:

```xml title="AndroidManifest.xml" highlightLines=4
<manifest>
   <application
       <activity>
<meta-data android:name="flutter_deeplinking_enabled" android:value="false" />
       </activity>
   </application>
</manifest>
```

Within your app's `info.plist` file for iOS:

```xml title="info.plist"
 <key>FlutterDeepLinkingEnabled</key>
 <false/>
```

## Timeline

Landed in version: 3.25.0-0.1.pre<br>
Stable release: 3.27

## References

Design document:

- [flutter.dev/go/deep-link-flag-migration]({{site.main-url}}/go/deep-link-flag-migration)

Relevant PR:

* [Set deep linking flag to true by default]({{site.github}}/flutter/engine/pull/52350)
