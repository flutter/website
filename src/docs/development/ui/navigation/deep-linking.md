---
title: Deep linking
description: Navigate to routes when the app receives a new URL
---

Flutter supports deep linking on iOS and Android in the dev channel. Any link
matching the configured scheme will be handled by the Navigator. By following
these steps, your app will be able to launch and display routes via named routes
(either with the [`routes`][routes] parameter or
[`onGenerateRoute`][onGenerateRoute]), or by using the [Router][Router] widget.

If you're running the app in a web browser,  there's no additional setup
required. Route paths are handled in the same way as an iOS or Android deep
link. Web apps currently read the path from the url fragment by default
(`/#/path/to/app/screen`)

To follow along, create a new Flutter project with [this code
sample][router-example].

## Enable deep linking on Android

Add a metadata tag and [intent filter][intents-filters] to `AndroidManifest.xml`
inside the `<activity> `tag with the `".MainActivity"` name:

```
<!-- Deep linking -->
<meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="http" android:host="flutterbooksample.com" />
    <data android:scheme="https" />
</intent-filter>
```

A full restart is required to apply these changes.

## Test on Android Emulator
To test with an Android emulator, the `adb` command can be given an intent. The
host name should match the name defined in `AndroidManifest.xml`:


```
adb shell am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "http://flutterbooksample.com/book/1"
```


See the [Verify Android App Links][verify-android-links] documentation for more
details.

## Enable deep linking on iOS
Add two new keys to `Info.plist` in the ios/Runner directory:

```
<key>FlutterDeepLinkingEnabled</key>
<true/>
<key>CFBundleURLTypes</key>
<array>
    <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>flutterbooksample.com</string>
    <key>CFBundleURLSchemes</key>
    <array>
    <string>customscheme</string>
    </array>
    </dict>
</array>
```

The CFBundleURLName is a unique URL used to distinguish your app from others
that use the same scheme. The scheme (`customscheme://`)  can also be unique to
help avoid conflicts.

A full restart is required to apply these changes.

## Test on iOS Simulator
The `xcrun` command can be used to test on the iOS Simulator:

```
xcrun simctl openurl booted customscheme://flutterbooksample.com/book/1 
```

## Migrating from plugin-based deep linking

If you have written a plugin to handle deep links, as described in [this
article][plugin-linking], it will continue to work until you opt-in to this
behavior by adding `FlutterDeepLinkingEnabled` to `Info.plist` or
`flutter_deeplinking_enabled` to `AndroidManifest.xml`, respectively.

## Behavior

The behavior varies slightly based on the platform and whether or not the app is
launched and running.

| Platform / Scenario      | Using Navigator                                                     | Using Router                                                                                                                                                                                        |
|--------------------------|---------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| iOS (not launched)       | App gets initialRoute ("/") and a short time after gets a pushRoute | App gets initialRoute ("/") and a short time after uses the RouteInformationParser to parse the route and call RouterDelegate.setNewRoutePath, which configures the Navigator with the corresponding Page. |
| Android - (not launched) | App gets initialRoute containing the full route ("http:/deeplink/") | App gets initialRoute ("/deeplink") and passes it to the RouteInformationParser to parse the route and call RouterDelegate.setNewRoutePath, which configures the Navigator with the corresponding Pages.   |
| iOS (launched)           | pushRoute is called                                                 | Path is parsed, and the Navigator is configured with a new set of Pages.                                                                                                                                   |
| Android (launched)       | pushRoute is called                                                 | Path is parsed, and the Navigator is configured with a new set of Pages.                                                                                                                                   |

After upgrading to the Router widget, your app has the ability to replace the
current set of pages when a new deep link is opened while the app is running.

[routes]: https://api.flutter.dev/flutter/material/MaterialApp/routes.html
[onGenerateRoute]: https://api.flutter.dev/flutter/material/MaterialApp/onGenerateRoute.html
[Router]: https://api.flutter.dev/flutter/widgets/Router-class.html
[intents-filters]: https://developer.android.com/guide/components/intents-filters
[plugin-linking]: https://medium.com/flutter-community/deep-links-and-flutter-applications-how-to-handle-them-properly-8c9865af9283
[verify-android-links]: https://developer.android.com/training/app-links/verify-site-associations
[router-example]: https://github.com/flutter/samples/blob/master/navigation_and_routing/lib/nav_2/router.dart