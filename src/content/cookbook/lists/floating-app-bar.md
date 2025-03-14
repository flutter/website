---
title: Place a floating app bar above a list
description: How to place a floating app bar or navigation bar above a list.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/lists/floating_app_bar/"?>

This guide describes how to place a floating app bar or
navigation bar above a list in a Flutter app.

## Overview

To make it easier for users to view a list of items,
you might want to minimize the app bar (navigation bar), as
the user scrolls down the list.

Moving the app bar into a [`CustomScrollView`][] allows you
to create an app bar that can be minimized or scroll
offscreen as you scroll through a list of items contained
inside the `CustomScrollView`.

This recipe demonstrates how to use a `CustomScrollView` to
display a list of items with an app bar on top that
minimizes as the user scrolls down the list using the
following steps:

  1. Create a `CustomScrollView`.
  2. Add a floating app bar to `CustomScrollView`.
  3. Add a list of items to `CustomScrollView`.

## 1. Create a `CustomScrollView`

To create a floating app bar, place the app bar inside a
`CustomScrollView` that also contains the list of items.
This synchronizes the scroll position of the app bar and the
list of items. You might think of the `CustomScrollView`
widget as a `ListView` that allows you to mix and match
different types of scrollable lists and widgets together.

The scrollable lists and widgets provided to the
`CustomScrollView` are known as _slivers_. There are several
types of slivers, such as `SliverList`, `SliverGrid`, and
`SliverAppBar`. In fact, the `ListView` and `GridView`
widgets use the `SliverList` and `SliverGrid` widgets to
implement scrolling.

For this example, create a `CustomScrollView` that contains
a `SliverList`. Also, remove the app bar property from your
code if it exists.

{% tabs "device-type-tabs" %}

{% tab "Material widgets" %}

<?code-excerpt "lib/starter_material.dart (CustomScrollView)" replace="/^return const //g"?>
```dart
Scaffold(
  // No app bar property provided yet.
  body: CustomScrollView(
    // Add the app bar and list of items as slivers in the next steps.
    slivers: <Widget>[],
  ),
);
```

{% endtab %}

{% tab "Cupertino widgets" %}

<?code-excerpt "lib/starter_cupertino.dart (CustomScrollView)" replace="/^return const //g"?>
```dart
CupertinoApp(
  home: CupertinoPageScaffold(
    // No navigation bar property provided yet.
    child: CustomScrollView(
      // Add the navigation bar and list of items as slivers in the next steps.
      slivers: <Widget>[],
    ),
  ),
);
```

{% endtab %}

{% endtabs %}


## 2. Add a floating app bar

Next, add an app bar to the [`CustomScrollView`][].

{% tabs "device-type-tabs" %}

{% tab "Material widgets" %}

Flutter provides the [`SliverAppBar`][] widget which,
much like the normal `AppBar` widget,
uses the `SliverAppBar` to display a title,
tabs, images and more.

However, the `SliverAppBar` also gives you the ability to
create a "floating" app bar that scrolls offscreen as the
user scrolls down the list. Furthermore, you can configure
the `SliverAppBar` to shrink and expand as the user scrolls.

To create this effect:

  1. Start with an app bar that displays only a title.
  2. Set the `pinned` property to `true`.
  2. Set the `floating` property to `true`.
  3. Add a `flexibleSpace` widget that fills the available
     `expandedHeight`.

<?code-excerpt "lib/step2_material.dart (SliverAppBar)" replace="/^body: //g;/^\),$/)/g"?>
```dart
CustomScrollView(
  slivers: [
    // Add the app bar to the CustomScrollView.
    SliverAppBar(
      // Provide a standard title.
      title: Text(title),
      // Allows the user to reveal the app bar if they begin scrolling
      pinned: true,
      // Allows the user to reveal the app bar if they begin scrolling
      // back up the list of items.
      floating: true,
      // Display a placeholder widget to visualize the shrinking size.
      flexibleSpace: Placeholder(),
      // Make the initial height of the SliverAppBar larger than normal.
      expandedHeight: 200,
    ),
  ],
)
```

:::tip
Play around with the
[various properties you can pass to the `SliverAppBar` widget][],
and use hot reload to see the results. For example, use an
`Image` widget for the `flexibleSpace` property to create a
background image that shrinks in size as it's scrolled
offscreen.
:::

{% endtab %}

{% tab "Cupertino widgets" %}

Flutter provides the [`CupertinoSliverNavigationBar`][]
widget, which you can use to add a navigation bar for your
list. When used inside of a `CustomScrollView`,
the title shrinks when you scroll down and floats when
you're not at the top of the page.

For this example, add `CupertinoSliverNavigationBar` to
`CustomScrollView`.

<?code-excerpt "lib/step2_cupertino.dart (SliverAppBar)" replace="/^body: //g;/^\),$/)/g"?>
```dart
child: CustomScrollView(
  slivers: [
    // Add the navigation bar to the CustomScrollView.
    const CupertinoSliverNavigationBar(
      // Provide a standard title.
      largeTitle: Text(title),
    ),
  ],
)
```

{% endtab %}

{% endtabs %}


## 3. Add a list of items

Now that you have the app bar in place, add a list of items
to the `CustomScrollView`. You have two options: a
[`SliverList`][] or a [`SliverGrid`][].  If you need to
display a list of items one after the other, use the
`SliverList` widget. If you need to display a grid list, use
the `SliverGrid` widget.

The `SliverList` and `SliverGrid` widgets take one required
parameter: a sliver delegate, which provides a
list of widgets to `SliverList` or `SliverGrid`.

There are many types of sliver delegates. In the following
example, the [`SliverChildBuilderDelegate`][] is used to
to create a list of items that are built lazily as you
scroll, just like the `ListView.builder` widget.

{% tabs "device-type-tabs" %}

{% tab "Material widgets" %}

<?code-excerpt "lib/main_material.dart (SliverList)" replace="/^\),$/)/g"?>
```dart
// Next, create a SliverList
SliverList(
  // Use a delegate to build items as they're scrolled on screen.
  delegate: SliverChildBuilderDelegate(
    // The builder function returns a ListTile with a title that
    // displays the index of the current item.
    (context, index) => ListTile(title: Text('Item #$index')),
    // Builds 50 ListTiles
    childCount: 50,
  ),
)
```

{% endtab %}

{% tab "Cupertino widgets" %}

<?code-excerpt "lib/main_cupertino.dart (SliverList)" replace="/^\),$/)/g"?>
```dart
// Next, create a SliverList
SliverList(
  // Use a delegate to build items as they're scrolled on screen.
  delegate: SliverChildBuilderDelegate(
    // The builder function returns a ListTile with a title that
    // displays the index of the current item.
    (context, index) =>
        CupertinoListTile(title: Text('Item #$index')),
    // Builds 50 ListTiles
    childCount: 50,
  ),
)
```

{% endtab %}

{% endtabs %}

## Interactive example

{% tabs "device-type-tabs" %}

{% tab "Material widgets" %}

<?code-excerpt "lib/main_material.dart"?>
```dartpad title="Flutter floating app bar hands-on example in DartPad" run="false"
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        // No app bar provided to Scaffold, only a body with a
        // CustomScrollView.
        body: CustomScrollView(
          slivers: [
            // Add the app bar to the CustomScrollView.
            const SliverAppBar(
              // Provide a standard title.
              title: Text(title),
              // Allows the user to reveal the app bar if they begin scrolling
              pinned: true,
              // Allows the user to reveal the app bar if they begin scrolling
              // back up the list of items.
              floating: true,
              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: Placeholder(),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 200,
            ),
            // Next, create a SliverList
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => ListTile(title: Text('Item #$index')),
                // Builds 50 ListTiles
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/floating-app-bar.gif" alt="Use floating app bar demo" class="site-mobile-screenshot"/> 
</noscript>

{% endtab %}

{% tab "Cupertino widgets" %}

<?code-excerpt "lib/main_cupertino.dart"?>
```dartpad title="Flutter floating navigation bar hands-on example in DartPad" run="false"
import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating Navigation Bar';

    return CupertinoApp(
      title: title,
      home: CupertinoPageScaffold(
        // No navigation bar provided to CupertinoPageScaffold,
        // only a body with a CustomScrollView.
        child: CustomScrollView(
          slivers: [
            // Add the navigation bar to the CustomScrollView.
            const CupertinoSliverNavigationBar(
              // Provide a standard title.
              largeTitle: Text(title),
            ),
            // Next, create a SliverList
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) =>
                    CupertinoListTile(title: Text('Item #$index')),
                // Builds 50 ListTiles
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/floating-app-bar.gif" alt="Use floating nav bar demo" class="site-mobile-screenshot"/> 
</noscript>

{% endtab %}

{% endtabs %}

[`CupertinoSliverNavigationBar`]: {{site.api}}/flutter/cupertino/CupertinoSliverNavigationBar-class.html
[`CustomScrollView`]: {{site.api}}/flutter/widgets/CustomScrollView-class.html
[`SliverAppBar`]: {{site.api}}/flutter/material/SliverAppBar-class.html
[`SliverChildBuilderDelegate`]: {{site.api}}/flutter/widgets/SliverChildBuilderDelegate-class.html
[`SliverChildDelegate`]: {{site.api}}/flutter/widgets/SliverChildDelegate-class.html
[`SliverGrid`]: {{site.api}}/flutter/widgets/SliverGrid-class.html
[`SliverList`]: {{site.api}}/flutter/widgets/SliverList-class.html
[various properties you can pass to the `SliverAppBar` widget]: {{site.api}}/flutter/material/SliverAppBar/SliverAppBar.html
