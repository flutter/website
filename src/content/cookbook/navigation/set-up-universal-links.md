---
title: Set up universal links for iOS
description: >-
   Learn how to set up universal links for an
   iOS application built with Flutter.
---

Deep linking allows an app user to launch an app with a URI.
This URI contains scheme, host, and path,
and opens the app to a specific screen.

A _universal link_, a type of deep link exclusive to iOS devices,
uses only the `http` or `https` protocols.

To set up universal links, you need to own a web domain.
As a temporary solution,
consider using [Firebase Hosting][] or [GitHub Pages][].

Once you've set up your deep links, you can validate them.
To learn more, see [Validate deep links][].

## Create or modify a Flutter app

Write a Flutter app that can handle an incoming URL.

This example uses the [go_router][] package to handle the routing.
The Flutter team maintains the `go_router` package.
It provides a simple API to handle complex routing scenarios.

1. To create a new application, type `flutter create <app-name>`.

    ```console
    $ flutter create deeplink_cookbook
    ```

2. To include the `go_router` package as a dependency,
   run `flutter pub add`:

    ```console
    $ flutter pub add go_router
    ```

3. To handle the routing, create a `GoRouter` object in the `main.dart` file:

    ```dart title="main.dart"
    import 'package:flutter/material.dart';
    import 'package:go_router/go_router.dart';

    void main() => runApp(MaterialApp.router(routerConfig: router));

    /// This handles '/' and '/details'.
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => Scaffold(
            appBar: AppBar(title: const Text('Home Screen')),
          ),
          routes: [
            GoRoute(
              path: 'details',
              builder: (_, _) => Scaffold(
                appBar: AppBar(title: const Text('Details Screen')),
              ),
            ),
          ],
        ),
      ],
    );
    ```

## Adjust iOS build settings

1. Launch Xcode.

1. Open the `ios/Runner.xcworkspace` file inside the
   Flutter project's `ios` folder.

   :::version-note
   If you use a Flutter version earlier than 3.27,
   you need to manually opt in to deep linking by adding the
   key and value pair `FlutterDeepLinkingEnabled` and `YES` to `info.Plist`.
   :::

   :::note
   If you're using third-party plugins to handle deep links,
   such as [app_links][],
   Flutter's default deeplink handler will
   break these plugins.

   If you use a third-party plugin, add the
   key and value pair `FlutterDeepLinkingEnabled` and `NO` to `info.Plist`.
   :::

### Add associated domains

:::warning
Personal development teams don't support the Associated Domains
capability. To add associated domains, choose the IDE tab.
:::

<Tabs key="darwin-editors">
<Tab name="Xcode">

1. Launch Xcode if necessary.

1. Click the top-level **Runner**.

1. In the Editor, click the **Runner** target.

1. Click **Signing & Capabilities**.

1. To add a new domain, click **+ Capability** under
   **Signing & Capabilities**.

1. Click **Associated Domains**.

   <img
      src="/assets/images/docs/cookbook/set-up-universal-links-associated-domains.png"
      alt="Xcode associated domains screenshot"
      width="100%" />

1. In the **Associated Domains** section, click **+**.

1. Enter `applinks:<web domain>`. Replace `<web domain>` with your own domain name.

   <img
      src="/assets/images/docs/cookbook/set-up-universal-links-add-associated-domains.png"
      alt="Xcode add associated domains screenshot"
      width="100%" />

</Tab>
<Tab name="Other editors">

1. Open the `ios/Runner/Runner.entitlements` XML file in your preferred editor.

1. Add an associated domain inside the `<dict>` tag.

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
     [!<key>com.apple.developer.associated-domains</key>!]
     [!<array>!]
       [!<string>applinks:example.com</string>!]
     [!</array>!]
   </dict>
   </plist>
   ```

1. Save the `ios/Runner/Runner.entitlements` file.

To check that the associated domains you created are available,
perform the following steps:

1. Launch Xcode if necessary.

1. Click the top-level **Runner**.

1. In the Editor, click the **Runner** target.

1. Click **Signing & Capabilities**.
   The domains should appear in the
   **Associated Domains** section.

   <img
      src="/assets/images/docs/cookbook/set-up-universal-links-add-associated-domains.png"
      alt="Xcode add associated domains screenshot"
      width="100%" />

</Tab>
</Tabs>

You have finished configuring the application for deep linking.

## Associate your app with your web domain

You need to host an `apple-app-site-association` file in the web domain.
This file tells the mobile browser which
iOS application to open instead of the browser.
To create the file, find the `appID` of the Flutter app you
created in the previous section.

### Locate components of the `appID`

Apple formats the `appID` as `<team id>.<bundle id>`.

* Locate the bundle ID in the Xcode project.
* Locate the team ID in the [developer account][].

**For example:** Given a team ID of `S8QB4VV633`
and a bundle ID of `com.example.deeplinkCookbook`,
you would enter an `appID` entry of
`S8QB4VV633.com.example.deeplinkCookbook`.

### Create and host `apple-app-site-association` JSON file

This file uses the JSON format.
Don't include the `.json` file extension when you save this file.
Per [Apple's documentation][apple-app-site-assoc],
this file should resemble the following content:

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appIDs": [
          "S8QB4VV633.com.example.deeplinkCookbook"
        ],
        "paths": [
          "*"
        ],
        "components": [
          {
            "/": "/*"
          }
        ]
      }
    ]
  },
  "webcredentials": {
    "apps": [
      "S8QB4VV633.com.example.deeplinkCookbook"
    ]
  }
}
```

1. Set one value in the `appIDs` array to
   `<team id>.<bundle id>`.

1. Set the `paths` array to `["*"]`.
   The `paths` array specifies the allowed universal links.
   Using the asterisk, `*` redirects every path to the Flutter app.
   If needed, change the `paths` array value to a setting more
   appropriate to your app.

1. Host the file at a URL that resembles the following structure.

   `<webdomain>/.well-known/apple-app-site-association`

1. Verify that your browser can access this file.

:::note
If you have more than one scheme/flavor, you can
add more than one `appID` into the `appIDs` field.
:::

## Test the universal link

Test a universal link using a physical iOS device or the Simulator.

:::note
It might take up to 24 hours before Apple's [Content Delivery Network][] (CDN)
requests the `apple-app-site-association` (AASA) file from your web domain.
Until the CDN requests the file, the universal link won't work.
To bypass Apple's CDN, check out the [alternate mode section][].
:::

1. Before testing,
   install the Flutter app on the iOS device or Simulator,
   Use `flutter run` on the desired device.

   <img
       src="/assets/images/docs/cookbook/set-up-universal-links-simulator.png"
       alt="Simulator screenshot"
       width="50%" />

   When complete,
   the Flutter app displays on the home screen of the
   iOS device or Simulator.

1. If you test using the Simulator, use the Xcode CLI:

   ```console
   $ xcrun simctl openurl booted https://<web domain>/details
   ```

1. If you test with a physical iOS device:

   1. Launch the **Note** app.
   1. Type the URL in the **Note** app.
   1. Click the resulting link.

   If successful, the Flutter app launches and displays its details screen.

   <img
      src="/assets/images/docs/cookbook/set-up-universal-links-simulator-deeplinked.png"
      alt="Deeplinked Simulator screenshot"
      width="50%" />

[Content Delivery Network]: https://en.wikipedia.org/wiki/Content_delivery_network

## Find the source code

You can find the source code for the [deeplink_cookbook][]
recipe in the GitHub repo.

[apple-app-site-assoc]: {{site.apple-dev}}/documentation/xcode/supporting-associated-domains
[alternate mode section]: {{site.apple-dev}}/documentation/bundleresources/entitlements/com_apple_developer_associated-domains?language=objc
[deeplink_cookbook]: {{site.repo.organization}}/codelabs/tree/main/deeplink_cookbook
[developer account]: {{site.apple-dev}}/account
[Firebase Hosting]: {{site.firebase}}/docs/hosting
[go_router]: {{site.pub-pkg}}/go_router
[GitHub Pages]: https://pages.github.com
[app_links]: {{site.pub-pkg}}/app_links
[Validate deep links]: /tools/devtools/deep-links
