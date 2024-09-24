---
title: Deep linking
description: Navigate to routes when the app receives a new URL.
---
Deep links are links that not only open an app, but also take the
user to a specific location "deep" inside the app. For example,
a deep link from an advertisement for a pair of sneakers might open
a shopping app and display the product page for those particular shoes.

Flutter supports deep linking on iOS, Android, and the web.
Opening a URL displays that screen in your app.
With the following steps,
you can launch and display routes by using named routes
(either with the [`routes`][routes] parameter or
[`onGenerateRoute`][onGenerateRoute]), or by
using the [`Router`][Router] widget.

:::note
Named routes are no longer recommended for most
applications. For more information, see
[Limitations][] in the [navigation overview][] page.
:::

[Limitations]: /ui/navigation#limitations
[navigation overview]: /ui/navigation

If you're running the app in a web browser, there's no additional setup
required. Route paths are handled in the same way as an iOS or Android deep
link. By default, web apps read the deep link path from the url fragment using
the pattern: `/#/path/to/app/screen`, but this can be changed by
[configuring the URL strategy][] for your app.

If you are a visual learner, check out the following video:

{% ytEmbed 'KNAb2XL7k2g', 'Deep linking in Flutter' %}

## Get started

To get started, see our cookbooks for Android and iOS:

<div class="card-grid">
  <a class="card" href="/cookbook/navigation/set-up-app-links">
    <div class="card-body">
      <header class="card-title card-center">
        Android
      </header>
    </div>
  </a>
  <a class="card" href="/cookbook/navigation/set-up-universal-links">
    <div class="card-body">
      <header class="card-title card-center">
        iOS
      </header>
    </div>
  </a>
</div>

## Migrating from plugin-based deep linking

If you have written a plugin to handle deep links, as described in
[Deep Links and Flutter applications][plugin-linking]
(a free article on Medium),
it will continue to work until you opt in to this behavior by adding
`FlutterDeepLinkingEnabled` to `Info.plist` or
`flutter_deeplinking_enabled` to `AndroidManifest.xml`, respectively.

## Behavior

The behavior varies slightly based on the platform and whether the app is
launched and running.

| Platform / Scenario      | Using Navigator                                                     | Using Router                                                                                                                                                                                               |
|--------------------------|---------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| iOS (not launched)       | App gets initialRoute ("/") and a short time after gets a pushRoute | App gets initialRoute ("/") and a short time after uses the RouteInformationParser to parse the route and call RouterDelegate.setNewRoutePath, which configures the Navigator with the corresponding Page. |
| Android - (not launched) | App gets initialRoute containing the route ("/deeplink")            | App gets initialRoute ("/deeplink") and passes it to the RouteInformationParser to parse the route and call RouterDelegate.setNewRoutePath, which configures the Navigator with the corresponding Pages.   |
| iOS (launched)           | pushRoute is called                                                 | Path is parsed, and the Navigator is configured with a new set of Pages.                                                                                                                                   |
| Android (launched)       | pushRoute is called                                                 | Path is parsed, and the Navigator is configured with a new set of Pages.                                                                                                                                   |

{:.table .table-striped}

When using the [`Router`][Router] widget,
your app has the ability to replace the
current set of pages when a new deep link
is opened while the app is running.

## To learn more

* [Learning Flutter's new navigation and routing system][] provides an
introduction to the Router system.
* [Deep dive into Flutter deep linking][io-dl] video from Google I/O 2023
* [Flutter Deep Linking: The Ultimate Guide][],
   a step-by-step tutorial showing how to implement deep links in Flutter.

[io-dl]: {{site.yt.watch}}?v=6RxuDcs6jVw&t=3s
[Learning Flutter's new navigation and routing system]: {{site.flutter-medium}}/learning-flutters-new-navigation-and-routing-system-7c9068155ade
[routes]: {{site.api}}/flutter/material/MaterialApp/routes.html
[onGenerateRoute]: {{site.api}}/flutter/material/MaterialApp/onGenerateRoute.html
[Router]: {{site.api}}/flutter/widgets/Router-class.html
[plugin-linking]: {{site.medium}}/flutter-community/deep-links-and-flutter-applications-how-to-handle-them-properly-8c9865af9283
[Flutter Deep Linking: The Ultimate Guide]: https://codewithandrea.com/articles/flutter-deep-links/

[configuring the URL strategy]: /ui/navigation/url-strategies
