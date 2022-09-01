---
title: Navigation and routing
description: Overview of Flutter's navigation and routing features
---

Flutter provides a complete system for navigating between screens and handling
deep links. Small applications without complex deep linking can use
[`Navigator`][], while apps with specific deep linking and navigation
requirements should also use the [`Router`][] to correctly handle deep links on
Android and iOS, and to stay in sync with the address bar when the app is
running on the web.

To configure your Android or iOS application to handle deep links, see 
[Deep linking][].

## Using the Navigator

The `Navigator` widget displays screens as a stack using the correct transition
animations for the target platform. To navigate to a new screen, access the
`Navigator` through the route’s `BuildContext` and call imperative methods such
as `push()` `or pop()`:

```dart
onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const SongScreen(song: song),
    ),
  );
},
child: Text(song.name),
```


Because `Navigator` keeps a stack of `Route` objects (representing the history
stack), The `push()` method also takes a `Route` object. The `MaterialPageRoute`
object is a subclass of `Route` that specifies the transition animations for
Material Design. For more examples of how to use the `Navigator`, follow the
[navigation recipes][] from the Flutter Cookbook or visit the [Navigator API
documentation][`Navigator`].

## Using named routes

{{site.alert.note}}
  We don't recommend using named routes for most applications.
  For more information, see the Limitations section below.
{{site.alert.end}}

Applications with simple navigation and deep linking requirements can use the
`Navigator` for navigation and the [`MaterialApp.routes`][] parameter for deep
links:

```dart
@override
  Widget build(BuildContext context) {
  return MaterialApp(
    routes: {
      '/': (context) => HomeScreen(),
      '/details': (context) => DetailScreen(),
    },
  );
}
```

Routes specified here are called _named routes_. For a complete example, follow
the [Navigate with named routes][] recipe from the Flutter Cookbook.


### Limitations

Although named routes can handle deep links, the behavior is always the same and
can't be customized. When a new deep link is received by the platform, Flutter
pushes a new `Route` onto the Navigator regardless where the user currently is.

Flutter also doesn’t support the browser forward button for applications using
named routes. For these reasons, we don’t recommend using named routes in most
applications.

## Using the Router

Flutter applications with advanced navigation and routing requirements (such as
a web app that uses direct links to each screen, or an app with multiple
`Navigator` widgets) should use a routing package such as [go_router][] that can
parse the route path and configure the `Navigator` whenever the app receives a
new deep link.

To use the Router, switch to the `router` constructor on `MaterialApp` or
`CupertinoApp` and provide it with a `Router` configuration. Routing packages,
such as [go_router][], typically provide a
configuration for you. For example:

```dart
MaterialApp.router(
  routerConfig: GoRouter(
    // …
  )
);
```

Because packages like go_router are _declarative_, they will always display the
same screen(s) when a deep link is received.


{{site.alert.secondary}}
  **Note for advanced developers**:  If you prefer not to use a routing package
  and would like full control over navigation and routing in your app, override
  `RouteInformationParser` and `RouterDelegate`. When the state in your app
  changes, you can precisely control the stack of screens by providing a list of
  `Page` objects using the `Navigator.pages` parameter. For more details, see the
  `Router` API documentation.
{{site.alert.end}}

## Using Router and Navigator together

The `Router` and `Navigator` are designed to work together. You can navigate
using the `Router` API through a declarative routing package, such as
`go_router`, or by calling imperative methods such as `push()` and `pop()` on
the `Navigator`.

When you navigate using the `Router` or a declarative routing package, each
route on the Navigator is _page-backed_, meaning it was created from a
[`Page`][] using the [`pages`][]
argument on the `Navigator` constructor. Conversely, any `Route`
created by calling `Navigator.push` or `showDialog` will add a _pageless_
route to the Navigator. If you are using a routing package, Routes that are
_page-backed_ are always deep-linkable, whereas _pageless_ routes
are not.

When a _page-backed_ `Route` is removed from the `Navigator`, all of the
_pageless_ routes after it are also removed. For example, if a deep link
navigates by removing a _page-backed_ route from the Navigator, all _pageless
_routes after (up until the next _page-backed_ route) are removed too.

{{site.alert.note}}
  You can't prevent navigation from page-backed screens using `WillPopScope`.
  Instead, you should consult your routing package's API documentation.
{{site.alert.end}}

## Web support

Apps using the `Router` class integrate with the browser History API to provide
a consistent experience when using the browser's back and forward buttons.
Whenever you navigate using the `Router`, a History API entry is added to the
browser's history stack. Pressing the **back** button uses _[reverse
chronological navigation][]_, meaning that the user is taken to the previously
visited location that was shown using the `Router`. This means that if the user
pops a page from the `Navigator` and then presses the browser **back** button
the previous page is pushed back onto the stack.

## More information

For more information on navigation and routing, check out the following
resources:

* The Flutter cookbook includes multiple [navigation recipes][] that show how to
  use the `Navigator`.
* The [`Navigator`][] and [`Router`][] API documentation contain details on how
  to set up declarative navigation without a routing package.
* [Understanding navigation][], a page from the Material Design documentation,
  outlines concepts for designing the navigation in your app, including
  explanations for forward, upward, and chronological navigation.
* [Learning Flutter's new navigation and routing system][], an article on
  Medium, describes how to use the `Router` widget directly, without
  a routing package.
* The [Router design document][] contains the motivation and design of the
  Router` API.

[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Router`]: {{site.api}}/flutter/widgets/Router-class.html
[Deep linking]: {{site.url}}/development/ui/navigation/deep-linking
[navigation recipes]: {{site.url}}/cookbook#navigation
[`MaterialApp.routes`]: {{site.url}}/flutter/material/MaterialApp/routes.html
[Navigate with named routes]: {{site.url}}/cookbook/navigation/named-routes
[go_router]: {{site.pub}}/packages/go_router
[`Page`]: {{site.api}}/flutter/widgets/Page-class.html
[`pages`]: {{site.api}}/flutter/widgets/Navigator/pages.html
[reverse chronological navigation]: https://material.io/design/navigation/understanding-navigation.html#reverse-navigation
[Understanding navigation]: https://material.io/design/navigation/understanding-navigation.html
[Learning Flutter's new navigation and routing system]: {{site.medium}}/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade
[Router design document]: {{site.main-url}}/go/navigator-with-router