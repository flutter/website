---
title: Set up universal links for iOS
description: How to animate a widget from one screen to another
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

<?code-excerpt path-base="cookbook/navigation/deeplink"?>

Deeplink is a mechanism to launch an app with a uri. This uri contains
scheme, hostnamethat leads users to a specific screen 
of an app. A universal link is a deep link with http or https
scheme that is exclusive to Apple devices.

Universal links lead users to apps instead of web browsers if
the apps are installed on their Apple devices.

## Prerequisite
1. A mac with Flutter SDK and Xcode installed
2. A web domain

If you don’t own a web domain and still want to test the
universal link, consider using [Firebase Hosting][] or
[GitHub Pages][] as a temporary solution. These instructions
use GitHub Pages.


## 1. Write a Flutter application

First, write a flutter application that can handle an incoming
URL. Start by creating a new application with flutter create.

```shell
$ flutter create universallinks
```

This example uses [go_router][] to handle the routing. The
go_router is a first party package maintained by Flutter
that provides a simple API to handle complex routing scenarios.

Add <strong>go_router</strong> to the <strong>pubspec.yaml</strong>:
```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^6.0.0
```

In the <strong>main.dart</strong> file, create a <strong>GoRouter</strong>
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

Launch Xcode. Open the <strong>ios/Runner.xcworkspace</strong>
file inside the project’s Flutter folder. Navigate to the
<strong>info.Plist</strong> file:

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-info-plist.png" alt="Xcode info.Plist screenshot"/>
</noscript>

Add a row to the <strong>info.Plist</strong> with the key
<strong>FlutterDeepLinkingEnabled</strong> and a
<strong>Boolean</strong> value set to <strong>YES</strong>.

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-flutterdeeplinkingenabled.png" alt="flutter deeplinking enabled screenshot"/>
</noscript>

Next, navigate to <strong>Runner-> Sign & Signature -> + Capability -> Associated Domains</strong>

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-associated-domains.png" alt="Xcode associated domains screenshot"/>
</noscript>

In the <strong>Associated Domains</strong> section click +
and enter <strong>applinks:\<web domain\></strong>.
This recipe uses the domain name: chunhtai.github.io.
You should replace it with your own domain name.

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

The app ID has the format of \<team id\>.\<bundle id\>. The bundle ID
is found in the Xcode project, and the team ID is found in
[developer account][]. If the team ID is <strong>S8QB4VV633</strong>
and bundle ID is <strong>com.myapp.universallinks</strong>, the app ID
is then <strong>S8QB4VV633.com.myapp.universallinks</strong>.

### apple-app-site-association

The hosted file should have the following content:
```json
{
  "applinks": {
      "details": [
      {
        "appID": "S8QB4VV633.com.myapp.universallinks",
        "paths": ["*"]
      }
    ]
  }
}
```

Replace the value of <strong>appID</strong> with your own. The
<strong>paths</strong> field specifies the allowed universal links,
and using a <strong>*</strong> means every path is redirected
to the Flutter application. Adjust the paths as desired.

Host the file at the following URL:
<strong>\<webdomain\>/.well-known/apple-app-site-association</strong>.
If using GitHub Pages, your repository should look similar to this
[sample repo]. Once this is done, make sure that the file is
accessible directly from your browser.


## Testing
{{site.alert.note}}
It might take up to 24 hours before Apple’s CDN requests the AASA
file from your web domain. The universal link won’t work until it
does. To bypass Apple’s CDN, see the [alternate mode section].
{{site.alert.end}}

You can use a real device or the Simulator to test the universal link.
Before you actually test the universal links, make sure you have
executed <strong>flutter run</strong> at least once on the device. This ensures that the
Flutter application is installed.

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-simulator.png" alt="Simulator screenshot"/>
</noscript>

If using the Simulator, you can test using Xcode CLI.
```shell
xcrun simctl openurl booted https://<web domain>/details
```

Otherwise, type the url in the Note app and click it.

If everything is set up correctly, the Flutter application
launches and displays the details screen:

<noscript>
  <img src="/assets/images/docs/cookbook/set-up-universal-links-simulator-deeplinked.png" alt="Simulator screenshot"/>
</noscript>

[alternate mode section]: https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains?language=objc
[sample repo]: https://github.com/chunhtai/chunhtai.github.io
[developer account]: https://developer.apple.com/account
[Firebase Hosting]: https://firebase.google.com/docs/hosting
[go_router]: https://pub.dev/packages/go_router
[GitHub Pages]: https://pages.github.com
