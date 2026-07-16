---
title: "Handling 404: Page not found error in Flutter"
description: "Learn how to handle 404 errors and create a custom page not found error page in your Flutter web application."
publishDate: 2020-06-10
author: josealba
image: images/1eU-430nepv8cz3OYLIycng.webp
category: tutorial
layout: blog
---

<DashImage figure src="images/1eU-430nepv8cz3OYLIycng.webp" />

Flutter has released web support that allows you to create dynamic websites. Flutter supports handling any error that might come from web usage such as 404 errors. But, how do you make a custom 404 page for your Flutter application?

This article describes how to create custom pages that are shown anytime a user navigates to a page that doesn’t exist.

## How to redirect clients to a custom 404 page in Flutter

Everyone has encountered a “404: Page not found error” when browsing the internet. Flutter handles this issue by automatically redirecting you to the initial route. This is usually the home page of your application. But what if you want to have a fancy 404 page like the ones at [AirBnb](https://36bvmt283fg61unuud3h7qua-wpengine.netdna-ssl.com/wp-content/uploads/2013/03/airbnb-404.gif), [GitHub](https://mamchenkov.net/wordpress/wp-content/uploads/2013/11/github-404.png), or even the [Flutter website](https://flutter.dev/foo)? You can do this easily with Flutter.

To create a custom 404 page, your application needs to use the `MaterialApp`, `CupertinoApp`, or `WidgetsApp` widget. Most applications use one of these three widgets; it is the first widget you call when creating a Flutter application.

The MaterialApp configures the top-level Navigator to search for routes in the following order:

1. For the `/` route, the [`home`](https://api.flutter.dev/flutter/material/MaterialApp/home.html) property, if non-null, is used.

1. Otherwise, the [`routes`](https://api.flutter.dev/flutter/material/MaterialApp/routes.html) table is used, if it has an entry for the route.

1. Otherwise, [`onGenerateRoute`](https://api.flutter.dev/flutter/material/MaterialApp/onGenerateRoute.html) is called, if provided. It should return a non-null value for any valid route not handled by [`home`](https://api.flutter.dev/flutter/material/MaterialApp/home.html) and [`routes`](https://api.flutter.dev/flutter/material/MaterialApp/routes.html).

1. Finally if all else fails [`onUnknownRoute`](https://api.flutter.dev/flutter/material/MaterialApp/onUnknownRoute.html) is called.

If your route isn’t handled in any of these tables then it uses the [`onUnknownRoute`](https://api.flutter.dev/flutter/material/MaterialApp/onUnknownRoute.html) property to handle your navigation. This callback is typically used for error handling. For example, this function might always generate a “not found” page that describes the route that wasn’t found. Unknown routes can arise either from errors in the app or from external requests to push routes, such as from Android intents.

The following example code demonstrates how to define an anonymous function for the `onUnknownRoute` property, which takes a `RouteFactory`, a factory method that takes a `RouteSettings function` as input and returns a `Route`. The following snippet shows how simple it can be to define the `onUnknownRoute` property:

```dart
onUnknownRoute: (settings) {

  return MaterialPageRoute(builder: (_) => PageNotFound());

},
```

PageNotFound is a custom widget that creates the 404 page . This page might explain what happened and redirect the user to the home page, but you can be as creative as you want when creating your 404 your page.

## Closing Remarks

When creating a Flutter application it is important to handle any issues that might arise. Using the `onUnknownRoute` property within `MaterialApp`, `CupertinoApp`, or `WidgetApp` lets you handle the inevitable “page not found” errors in your website.

To learn more about routes in Flutter, see the Medium post [“Navigating URLs using named routes”](https://medium.com/flutter/flutter-web-navigating-urls-using-named-routes-307e1b1e2050).

*About the author: Jose recently graduated from university and now works on [Material](https://material.io), a design system that helps teams build high-quality digital experiences. Jose’s team maintains the Flutter [material library](https://api.flutter.dev/flutter/material/material-library.html). To learn more, visit his Jose’s pages on [GitHub](https://github.com/JoseAlba), [LinkedIn](https://www.linkedin.com/in/josealba1996/), [YouTube](https://www.youtube.com/channel/UCOdKA_On0oPe1tz02z1QfxA?view_as=subscriber), and [Instagram](https://www.instagram.com/jose.alba/).*
