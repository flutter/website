---
title: Deep linking
description: Navigate to routes when the app receives a new URL
---

Flutter supports deep linking on iOS, Android, and web browsers.
Opening a URL displays that screen in your app. With the following
steps, you can launch and display routes by using named routes
(either with the [`routes`][routes] parameter or
[`onGenerateRoute`][onGenerateRoute]), or by
using the [`Router`][Router] widget.

{{site.alert.note}}
  Named routes are no longer recommended for most
  applications. For more information, see
  [Limitations][] in the [navigation overview][] page.
{{site.alert.end}}

[Limitations]: {{site.url}}/ui/navigation#limitations
[navigation overview]: {{site.url}}/ui/navigation

If you're running the app in a web browser, there's no additional setup
required. Route paths are handled in the same way as an iOS or Android deep
link. By default, web apps read the deep link path from the url fragment using
the pattern: `/#/path/to/app/screen`, but this can be changed by
[configuring the URL strategy][] for your app.

If you are a visual learner, check out the following video:

<iframe width="560" height="315" src="{{site.youtube-site}}/embed/KNAb2XL7k2g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
<b>Deep linking in Flutter</b>

## Get started

To get started, see our cookbooks for Android and iOS:

<div class="card-deck mb-8">
  <a class="card" href="{{site.url}}/cookbook/navigation/set-up-app-links">
    <div class="card-body">
      <header class="card-title text-center m-0">
        Android
      </header>
    </div>
  </a>
  <a class="card" href="{{site.url}}/cookbook/navigation/set-up-universal-links">
    <div class="card-body">
      <header class="card-title text-center m-0">
        iOS
      </header>
    </div>
  </a>
</div>

## Migrating from plugin-based deep linking

If you have written a plugin to handle deep links, as described in
[Deep Links and Flutter applications][plugin-linking]
(a free article on Medium),
it will continue to work until you opt-in to this behavior by adding
`FlutterDeepLinkingEnabled` to `Info.plist` or
`flutter_deeplinking_enabled` to `AndroidManifest.xml`, respectively.

## Behavior

The behavior varies slightly based on the platform and whether the app is
launched and running.

<div class="table-wrapper" markdown="1">
| Platform / Scenario      | Using Navigator                                                     | Using Router                                                                                                                                                                                        |
|--------------------------|---------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| iOS (not launched)       | App gets initialRoute ("/") and a short time after gets a pushRoute | App gets initialRoute ("/") and a short time after uses the RouteInformationParser to parse the route and call RouterDelegate.setNewRoutePath, which configures the Navigator with the corresponding Page. |
| Android - (not launched) | App gets initialRoute containing the route ("/deeplink")            | App gets initialRoute ("/deeplink") and passes it to the RouteInformationParser to parse the route and call RouterDelegate.setNewRoutePath, which configures the Navigator with the corresponding Pages.   |
| iOS (launched)           | pushRoute is called                                                 | Path is parsed, and the Navigator is configured with a new set of Pages.                                                                                                                                   |
| Android (launched)       | pushRoute is called                                                 | Path is parsed, and the Navigator is configured with a new set of Pages.                                                                                                                                   |
{:.table.table-striped}
</div>

When using the [`Router`][Router] widget,
your app has the ability to replace the
current set of pages when a new deep link
is opened while the app is running.

## For more information

[Learning Flutter’s new navigation and routing system][] provides an introduction to the Router system.

[Learning Flutter’s new navigation and routing system]: {{site.flutter-medium}}/learning-flutters-new-navigation-and-routing-system-7c9068155ade
[switching-channels]: {{site.url}}/release/upgrade#switching-flutter-channels
[routes]: {{site.api}}/flutter/material/MaterialApp/routes.html
[onGenerateRoute]: {{site.api}}/flutter/material/MaterialApp/onGenerateRoute.html
[Router]: {{site.api}}/flutter/widgets/Router-class.html
[Navigator 2.0]: {{site.flutter-medium}}/learning-flutters-new-navigation-and-routing-system-7c9068155ade
[intent filter]: {{site.android-dev}}/guide/components/intents-filters
[plugin-linking]: {{site.medium}}/flutter-community/deep-links-and-flutter-applications-how-to-handle-them-properly-8c9865af9283
[verify-android-links]: {{site.android-dev}}/training/app-links/verify-android-applinks
[router-sample]: {{site.repo.samples}}/tree/main/navigation_and_routing

[configuring the URL strategy]: {{site.url}}/ui/navigation/url-strategies
