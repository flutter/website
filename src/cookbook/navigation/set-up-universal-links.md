---
title: Set up universal links for iOS
description: How set up universal links for an iOS application built with Flutter
prev:
  title: Send data to a new screen
  path: /cookbook/navigation/passing-data
next:
  title: Delete data on the internet
  path: /cookbook/networking/delete-data
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

1. Write a Flutter app that can handle an incoming URL.
   To create a new application, type `flutter create <app-name>`.

```shell
$ flutter create universallinks
```

This example uses [go_router][] to handle the routing. The
go_router is a first party package maintained by the Flutter team
that provides a simple API to handle complex routing scenarios.

Add `go_router` to the `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^6.0.9
```

In the `main.dart` file, create a `GoRouter`
object to handle the routing:

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(MaterialApp.router(routerConfig: router));

/// The handles '/' and '/details'.
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

Launch Xcode. Open the `ios/Runner.xcworkspace`
file inside the project’s Flutter folder. Navigate to the
`info.Plist` file:

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-info-plist.png" alt="Xcode info.Plist screenshot"/>
</noscript>

Add a row to the `info.Plist` with the key
`FlutterDeepLinkingEnabled` and a
`Boolean` value set to `YES`.

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-flutterdeeplinkingenabled.png" alt="flutter deeplinking enabled screenshot"/>
</noscript>

Next, navigate to **Runner-> Sign & Signature -> + Capability -> Associated Domains**

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-associated-domains.png" alt="Xcode associated domains screenshot"/>
</noscript>

In the **Associated Domains** section click **+**
and enter `applinks:<web domain>`.
Replace `<web domain>` with your own domain name.

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-add-associated-domains.png" alt="Xcode add associated domains screenshot"/>
</noscript>

At this point, the application side is ready to go.

## 3. Hosting apple-app-site-association file

You need to host an apple-app-site-association file in the web domain.
This file tells the mobile browser which iOS application it should open
instead of opening in the browser. You need the app ID of the Flutter
application created in the previous step in order to create the file.

### App ID

The app ID has the format of `<team id>.<bundle id>`. The bundle ID
is found in the Xcode project, and the team ID is found in the
[developer account][]. For example, if the team ID is `S8QB4VV633`
and the bundle ID is `com.myapp.deeplink_cookbook`, the app ID
is then `S8QB4VV633.com.myapp.deeplink_cookbook`.

### apple-app-site-association

The hosted file should have the following content:
```json
{
  "applinks": {
      "details": [
      {
        "appID": "S8QB4VV633.com.myapp.deeplink_cookbook",
        "paths": ["*"]
      }
    ]
  }
}
```

Replace the value of `appID` with your own. The
`paths` field specifies the allowed universal links,
and the asterisk, `*`, means every path is redirected
to the Flutter application. Adjust the paths field as desired.

Host the file at the following URL:
`<webdomain>/.well-known/apple-app-site-association`.
Once this is done, make sure that the file is accessible directly
from your browser.


## Testing
{{site.alert.note}}
  It might take up to 24 hours before Apple’s CDN requests the AASA
  file from your web domain. The universal link won’t work until it
  does. To bypass Apple’s CDN, see the [alternate mode section][].
{{site.alert.end}}

You can use a real device or the Simulator to test a universal link,
but first make sure you have executed `flutter run` at least once on
the real device. This ensures that the Flutter application is installed.

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-simulator.png" alt="Simulator screenshot"/>
</noscript>

If using the Simulator, test using the Xcode CLI:
```shell
xcrun simctl openurl booted https://<web domain>/details
```

Otherwise, type the URL in the **Note** app and click it.

If everything is set up correctly, the Flutter application
launches and displays the details screen:

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-simulator-deeplinked.png" alt="Simulator screenshot"/>
</noscript>

[alternate mode section]: https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains?language=objc
[developer account]: https://developer.apple.com/account
[Firebase Hosting]: https://firebase.google.com/docs/hosting
[go_router]: https://pub.dev/packages/go_router
[GitHub Pages]: https://pages.github.com
