---
title: Navigate to a new screen and back
description: How to navigate between routes.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/navigation/navigation_basics"?>

Most apps contain several screens for displaying different types of
information.
For example, an app might have a screen that displays products.
When the user taps the image of a product, a new screen displays
details about the product.

:::note Terminology
In Flutter, _screens_ and _pages_ are called _routes_.
The remainder of this recipe refers to routes.
:::

In Android, a route is equivalent to an Activity.
In iOS, a route is equivalent to a ViewController.
In Flutter, a route is just a widget.

This recipe uses the [`Navigator`][] to navigate to a new route.

The next few sections show how to navigate between two routes,
using these steps:

  1. Create two routes.
  2. Navigate to the second route using Navigator.push().
  3. Return to the first route using Navigator.pop().

## 1. Create two routes

First, create two routes to work with. Since this is a basic example,
each route contains only a single button. Tapping the button on the
first route navigates to the second route. Tapping the button on the
second route returns to the first route.

First, set up the visual structure:

<?code-excerpt "lib/main_step1.dart (FirstSecondRoutes)"?>
```dart
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

## 2. Navigate to the second route using Navigator.push()

To switch to a new route, use the [`Navigator.push()`][]
method. The `push()` method adds a `Route` to the stack of routes managed by
the `Navigator`. Where does the `Route` come from?
You can create your own, or use a [`MaterialPageRoute`][],
which is useful because it transitions to the
new route using a platform-specific animation.

In the `build()` method of the `FirstRoute` widget,
update the `onPressed()` callback:

<?code-excerpt "lib/main_step2.dart (FirstRouteOnPressed)"?>
```dart
// Within the `FirstRoute` widget
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SecondRoute()),
  );
}
```

## 3. Return to the first route using Navigator.pop()

How do you close the second route and return to the first?
By using the [`Navigator.pop()`][] method.
The `pop()` method removes the current `Route` from the stack of
routes managed by the `Navigator`.

To implement a return to the original route, update the `onPressed()`
callback in the `SecondRoute` widget:

<?code-excerpt "lib/main_step2.dart (SecondRouteOnPressed)"?>
```dart
// Within the SecondRoute widget
onPressed: () {
  Navigator.pop(context);
}
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad run="true"
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/navigation-basics.gif" alt="Navigation Basics Demo" class="site-mobile-screenshot" />
</noscript>

## Navigation with CupertinoPageRoute

In the previous example you learned how to navigate between screens
using the [`MaterialPageRoute`][] from [Material Components][].
However, in Flutter you are not limited to Material design language,
instead, you also have access to [Cupertino][] (iOS-style) widgets.

Implementing navigation with Cupertino widgets follows the same steps
as when using [`MaterialPageRoute`][], 
but instead you use [`CupertinoPageRoute`][]
which provides an iOS-style transition animation.

In the following example, these widgets have been replaced:

- [`MaterialApp`][] replaced by [`CupertinoApp`].
- [`Scaffold`][] replaced by [`CupertinoPageScaffold`][].
- [`ElevatedButton`][] replaced by [`CupertinoButton`][].

This way, the example follows the current iOS design language.

:::secondary
You don't need to replace all Material widgets with Cupertino versions
to use [`CupertinoPageRoute`][]
since Flutter allows you to mix and match Material and Cupertino widgets
depending on your needs.
:::

<?code-excerpt "lib/main_cupertino.dart"?>
```dartpad run="true"
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const CupertinoApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('First Route'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Second Route'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/navigation-basics-cupertino.gif" alt="Navigation Basics Cupertino Demo" class="site-mobile-screenshot" />
</noscript>

[Cupertino]: {{site.docs}}/ui/widgets/cupertino
[Material Components]: {{site.docs}}/ui/widgets/material
[`CupertinoApp`]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[`CupertinoButton`]: {{site.api}}/flutter/cupertino/CupertinoButton-class.html
[`CupertinoPageRoute`]: {{site.api}}/flutter/cupertino/CupertinoPageRoute-class.html
[`CupertinoPageScaffold`]: {{site.api}}/flutter/cupertino/CupertinoPageScaffold-class.html
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp-class.html
[`MaterialPageRoute`]: {{site.api}}/flutter/material/MaterialPageRoute-class.html
[`Navigator.pop()`]: {{site.api}}/flutter/widgets/Navigator/pop.html
[`Navigator.push()`]: {{site.api}}/flutter/widgets/Navigator/push.html
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html
