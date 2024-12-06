---
title: Navigation and routing
description: Overview of Flutter's navigation and routing features
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
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
`Navigator` through the route's `BuildContext` and call imperative methods such
as `push()` `or pop()`:

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter navigation hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Navigation Basics',
      home: FirstScreen(),
    )
  );
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open second screen'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Pop current screen'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/navigation-basics.gif" alt="Navigation Basics Demo" class="site-mobile-screenshot" />
</noscript>

Because `Navigator` keeps a stack of `Route` objects (representing the history
stack), The `push()` method also takes a `Route` object. The `MaterialPageRoute`
object is a subclass of `Route` that specifies the transition animations for
Material Design. For more examples of how to use the `Navigator`, follow the
[navigation recipes][] from the Flutter Cookbook or visit the [Navigator API
documentation][`Navigator`].

## Using named routes

:::note
Named routes aren't recommended for most applications.
For more information, see [Limitations](#limitations).
:::

If an application requires deep links, _named routes_ are an option. To add
named routes (`routes`), use the [`MaterialApp.routes`][] parameter with the
`Navigator` widget as follows:

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter navigation hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Navigation Basics',
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
      },
    )
  );
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open second screen'),
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Pop current screen'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/navigation-basics.gif" alt="Navigation Basics Demo" class="site-mobile-screenshot" />
</noscript>

For a complete example, follow the [Navigate with named routes][] recipe from
the Flutter Cookbook.

#### Limitations

For the following reasons, named routes are not recommended in most
applications:

* Although named routes can handle deep links, the behavior is always the same
  and can't be customized. When a new deep link is received by the platform,
  Flutter pushes a new `Route` onto the Navigator regardless of where the user
  currently is.

* Flutter doesn't support the browser forward button for applications using
  named routes.

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

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter navigation hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    MaterialApp.router(
      title: 'Navigation Basics',
      routerConfig: _router,
    )
  );
}

// Declare routing information
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FirstScreen(),
    ),
    GoRoute(
      path: '/second',
      builder: (context, state) => const SecondScreen(),
    ),
  ],
);

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open second screen'),
          onPressed: () => context.go('/second'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to first screen'),
          onPressed: () => context.go('/'),
        ),
      ),
    );
  }
}
```

Because packages like go_router are _declarative_, they will always display the
same screen(s) when a deep link is received.


:::note Note for advanced developers
If you prefer not to use a routing package
and would like full control over navigation and routing in your app, override
`RouteInformationParser` and `RouterDelegate`. When the state in your app
changes, you can precisely control the stack of screens by providing a list of
`Page` objects using the `Navigator.pages` parameter. For more details, see the
`Router` API documentation.
:::

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
navigates by removing a _page-backed_ route from the Navigator, all _pageless_
routes after (up until the next _page-backed_ route) are removed too.

:::note
You can't prevent navigation from page-backed screens using `WillPopScope`.
Instead, you should consult your routing package's API documentation.
:::

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
[Deep linking]: /ui/navigation/deep-linking
[navigation recipes]: /cookbook#navigation
[`MaterialApp.routes`]: {{site.api}}/flutter/material/MaterialApp/routes.html
[Navigate with named routes]: /cookbook/navigation/named-routes
[go_router]: {{site.pub}}/packages/go_router
[`Page`]: {{site.api}}/flutter/widgets/Page-class.html
[`pages`]: {{site.api}}/flutter/widgets/Navigator/pages.html
[reverse chronological navigation]: https://material.io/design/navigation/understanding-navigation.html#reverse-navigation
[Understanding navigation]: https://material.io/design/navigation/understanding-navigation.html
[Learning Flutter's new navigation and routing system]: {{site.medium}}/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade
[Router design document]: {{site.main-url}}/go/navigator-with-router
