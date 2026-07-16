---
title: "Flutter web: Navigating URLs using named routes"
description: "Named routes can be used to navigate between pages inside a Flutter mobile app, but they also work for URLs in Flutter web apps. This…"
publishDate: 2020-03-30
author: perclasson
image: images/0Uoo0IGsUFUf8GJsT.webp
category: tutorial
layout: blog
---

👉 Update: [Flutter’s new Navigation and Routing system](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade) is now available, and it is the preferred way to handle URLs in Flutter.

Named routes can be used to navigate between pages inside a Flutter mobile app, but they also work for URLs in Flutter web apps. This article explains how to add named routes to your app, and how you can customize them, to have pattern matching inside the routes.

## Defining named routes

Named routes can be added to your application by defining them within the `MaterialApp` class. The `MaterialApp.routes` property contains a map listing each named route and its associated display widget. The `MaterialApp.initialRoute` property determines what route displays as the application starts. The `initialRoute` thus needs to be defined inside of the `routes` property. For example:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomePage(),
    '/overview': (context) => OverviewPage(),
  },
);
```

A good practice to keep your code organized is to put named routes inside static variables, for example, on the widgets themselves:

```dart
class OverviewPage extends StatelessWidget {
  static const String route = '/overview';
}
```

Next, refactor `MaterialApp.routes` with the named routes now defined as static variables:

```dart
MaterialApp(
  initialRoute: HomePage.route,
  routes: {
    HomePage.route: (context) => HomePage(),
    OverviewPage.route: (context) => OverviewPage(),
  },
);
```

## Navigating between pages

To navigate from one page to another, simply push the named route to the navigator:

```dart
RaisedButton(
  onPressed: () {
    Navigator.of(context).pushNamed(OverviewPage.route);
  },
)
```

See a [full interactive example of this on DartPad](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=named_routes/lib&theme=dark). If you build and [run the application yourself for the web](https://flutter.dev/docs/get-started/web), you can also just type in `/#/overview` inside the web browser. This pushes the route named *overview* to the `Navigator`, and takes you to the `OverviewPage` widget, as you can see in the following GIF:

<DashImage figure src="images/0kDK1lFIWHzjcEVKA.webp" alt="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=named_routes/lib&theme=dark)" caption="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=named_routes/lib&theme=dark)" />


## Routing logic for dynamic URLs

You may need to address more complex scenarios then addressed here, such as having pattern matching inside the routes to allow for dynamic URLs. To extend this example, assume that you have many different articles on the overview page. For each article you want to be able to navigate directly via URLs:

```plaintext
/#/article/a-very-interesting-article
/#/article/newsworthy-news
```


To define named routes for all of the articles within the `MaterialApp` does not scale very well. For such dynamic cases you need to do something more custom. As of this writing, the stable channel of Flutter is at v1.12, and there is no *simple way* to do this, though there are plans to add support for more advanced routing with the [new Navigator](https://github.com/flutter/flutter/issues/45938).

For now you can use an external package, for example the [Fluro package](https://pub.dev/packages/fluro/) provides more advanced routing. It gives you wildcard pattern matching in routes, as well as parsing for query strings in URLs. There are probably many other available packages, so please leave a comment with the name of your favorite.

If you are up for the challenge, you can also get dynamic routes by making use of the `MaterialApp.onGenerateRoute` property. Use this to write routing logic for when a named route is not inside of `MaterialApp.routes`.

For each route, define a `Path` with a `RegEx` pattern. If the named route matches the pattern, return the associated widget. Next, define the `Path` class to support that:

```dart
class Path {
  const Path(this.pattern, this.builder);
  
  final String pattern;
  final Widget Function(BuildContext, String) builder;
}
```

For the overview page and the home route, it is quite simple and looks similar to what you had before. The following example creates a `RegEx` pattern that matches [a slug](https://en.wikipedia.org/wiki/Clean_URL#Slug) (lowercase letters with a dash) that is used to find the corresponding article:

```dart
static List<Path> paths = [
  Path(
    r'^/article/([\w-]+)$',
    (context, match) => Article.getArticlePage(match),
  ),
  Path(
    r'^' + OverviewPage.route,
    (context, match) => OverviewPage(),
  ),
  Path(
    r'^' + HomePage.route,
    (context, match) => HomePage(),
  ),
];
```

All that remains is to create an `onGenerateRoute` function for `MaterialApp`. If the current named route (`settings.name`) is defined in the paths list, return the associated widget. Make sure to pass any named matches in the `RegEx` (in this example it is the slug). If no matches are found, simply return null, `WidgetsApp.onUnknownRoute` is called to handle such cases:

```dart
static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  for (Path path in paths) {
    final regExpPattern = RegExp(path.pattern);
    if (regExpPattern.hasMatch(settings.name)) {
      final firstMatch = regExpPattern.firstMatch(settings.name);
      final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
      return MaterialPageRoute<void>(
        builder: (context) => path.builder(context, match),
        settings: settings,
      );
    }
  }
  // If no match is found, [WidgetsApp.onUnknownRoute] handles it.
  return null;
}
```

Make sure to define the `onGenerateRoute` function inside the `MaterialApp` class; you have implemented dynamic URLs with Flutter, using named routes! You can [see a full interactive example on DartPad](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=custom_named_routes/lib&theme=dark).

<DashImage figure src="images/0Uoo0IGsUFUf8GJsT.webp" alt="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=custom_named_routes/lib&theme=dark)" caption="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=custom_named_routes/lib&theme=dark)" />


## Conclusion

Whether you choose to write your own custom logic for routes, or simply use the routes support that exists within `MaterialApp`, you get URL support by default with a Flutter app on the web, when using named routes. Implementing named routes can also ensure that you decouple the presentation logic from the routing logic, which leads to less code duplication.

Let me know in the comments what solution you use in your app, whether it is writing your own custom logic or using an external package.

Happy hacking!