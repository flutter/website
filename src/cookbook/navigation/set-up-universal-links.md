---
title: Set up universal links for iOS
description: How set up universal links for an iOS application built with Flutter
prev:
  title: Set up app links for Android
  path: /cookbook/navigation/set-up-app-links
next:
  title: Return data from a screen
  path: /cookbook/navigation/returning-data
js:
- defer: true
  url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="codelabs/deeplink_cookbook"?>

Deep linking is a mechanism for launching an app with a URI. This URI
contains scheme, host, and path, and opens the app to a specific
screen.

A _universal link_ is a type of deep link that uses `http` or `https` and
is exclusive to Apple devices.


Setting up universal links requires one to own a web domain. Otherwise, consider
using [Firebase Hosting][] or [GitHub Pages][] as a temporary solution.


## 1. Customize a Flutter application

Write a Flutter app that can handle an incoming URL.
This example uses the [go_router][] package to handle the routing.
The Flutter team maintains the `go_router` package.
It provides a simple API to handle complex routing scenarios.

1. To create a new application, type `flutter create <app-name>`.

    ```shell
    $ flutter create deeplink_cookbook
    ```

2. To include the `go_router` package as a dependency, 
   run `flutter pub add`:

    ```terminal
    $ flutter pub add go_router
    ```

3. To handle the routing, create a `GoRouter` object in the `main.dart` file:

    <?code-excerpt "lib/main.dart"?>
    ```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example
    import 'package:flutter/material.dart';
    import 'package:go_router/go_router.dart';

    void main() => runApp(MaterialApp.router(routerConfig: router));

    /// This handles '/' and '/details'.
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => Scaffold(
            appBar: AppBar(title: const Text('Home Screen')),
          ),
          routes: [
            GoRoute(
              path: 'details',
              builder: (_, __) => Scaffold(
                appBar: AppBar(title: const Text('Details Screen')),
              ),
            ),
          ],
        ),
      ],
    );
    ```



## 2. Adjust iOS build settings

1. Launch Xcode.
2. Open the `ios/Runner.xcworkspace` file inside the project’s `ios` folder.
3. Navigate to the `Info` Plist file in the `ios/Runner` folder.

    <img src="/assets/images/docs/cookbook/set-up-universal-links-info-plist.png" alt="Xcode info.Plist screenshot" width="100%" />

4. In the `Info` property list, control-click at the list to add a row.
5. Control-click the newly added row and turn on the **Raw Keys and Values** mode
6. Update the key to `FlutterDeepLinkingEnabled` with a `Boolean` value set to `YES`.

    <img src="/assets/images/docs/cookbook/set-up-universal-links-flutterdeeplinkingenabled.png" alt="flutter deeplinking enabled screenshot" width="100%" />

   {{site.alert.note}}
       The FlutterDeepLinkingEnabled property opts into Flutter's default deeplink handler. If
       you are using the third-party plugins, such as [uni_links][], setting this property will
       break these plugins. Skip this step if you prefer to use third-party plugins.
   {{site.alert.end}}

7. Click the top-level **Runner**.
8. Click **Sign & Signature**.
9. Click **+ Capability** to add a new domain.
10. Click **Associated Domains**.

    <img src="/assets/images/docs/cookbook/set-up-universal-links-associated-domains.png" alt="Xcode associated domains screenshot" width="100%" />

11. In the **Associated Domains** section, click **+**.
12. Enter `applinks:<web domain>`. Replace `<web domain>` with your own domain name.

    <img src="/assets/images/docs/cookbook/set-up-universal-links-add-associated-domains.png" alt="Xcode add associated domains screenshot" width="100%" />

You have finished configuring the application for deep linking.

## 3. Hosting apple-app-site-association file

You need to host an `apple-app-site-association` file in the web domain.
This file tells the mobile browser which iOS application to open instead of the browser.
To create the file, get the app ID of the Flutter app you created in the previous step.

### App ID

Apple formats the app ID as `<team id>.<bundle id>`.

* Locate the bundle ID in the Xcode project.
* Locate the team ID in the [developer account][].

**For example:** Given a team ID of `S8QB4VV633`
and a bundle ID of `com.example.deeplinkCookbook`, The app ID is
`S8QB4VV633.com.example.deeplinkCookbook`.

### apple-app-site-association

The hosted file should have the following content:
```json
{
  "applinks": {
      "apps": [],
      "details": [
      {
        "appID": "S8QB4VV633.com.example.deeplinkCookbook",
        "paths": ["*"]
      }
    ]
  }
}
```

1. Set the `appID` value to your Flutter application ID.

2. Set the `paths` value to `["*"]`.
   The `paths` field specifies the allowed universal links.
   Using the asterisk, `*` redirects every path to the Flutter application.
   If needed, change the `paths` value to a setting more appropriate
   to your app.

3. Host the file at a URL that resembles the following:
`<webdomain>/.well-known/apple-app-site-association`

4. Verify that your browser can access this file.


## Testing
{{site.alert.note}}
  It might take up to 24 hours before Apple’s
  [Content Delivery Network](https://en.wikipedia.org/wiki/Content_delivery_network) (CDN)
  requests the apple-app-site-association (AASA) file from your web domain.
  The universal link won’t work until the CDN requests the file.
  To bypass Apple’s CDN, check out the [alternate mode section][].
{{site.alert.end}}

You can use a real device or the Simulator to test a universal link,
but first make sure you have executed `flutter run` at least once on
the devices. This ensures that the Flutter application is installed.

<img src="/assets/images/docs/cookbook/set-up-universal-links-simulator.png" alt="Simulator screenshot" width="50%" />

If using the Simulator, test using the Xcode CLI:
```shell
xcrun simctl openurl booted https://<web domain>/details
```

Otherwise, type the URL in the **Note** app and click it.

If everything is set up correctly, the Flutter application
launches and displays the details screen:

<img src="/assets/images/docs/cookbook/set-up-universal-links-simulator-deeplinked.png" alt="Deeplinked Simulator screenshot" width="50%" />

## Appendix

Source code: [deeplink_cookbook][]

[alternate mode section]: https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains?language=objc
[deeplink_cookbook]: https://github.com/flutter/codelabs/tree/main/deeplink_cookbook
[developer account]: https://developer.apple.com/account
[Firebase Hosting]: https://firebase.google.com/docs/hosting
[go_router]: https://pub.dev/packages/go_router
[GitHub Pages]: https://pages.github.com
[uni_links]: https://pub.dev/packages/uni_links
