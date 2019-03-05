---
title: Place a floating app bar above a list 
prev:
  title: Creating lists with different types of items
  path: /docs/cookbook/lists/mixed-list
next:
  title: Working with long lists
  path: /docs/cookbook/lists/long-lists
---

To make it easier for users to view a list of items, you may want to hide the
app bar as the user scrolls down the list. This is especially true if your app
displays a "tall" app bar that occupies a lot of vertical space.

Traditionally, you create an app bar by providing an `appBar` property to the
`Scaffold` Widget. This creates a fixed app bar that always remains above
the `body` of the `Scaffold`.

Moving the app bar from a `Scaffold` Widget into a
[`CustomScrollView`](https://docs.flutter.io/flutter/widgets/CustomScrollView-class.html)
allows you to create an app bar that scrolls offscreen as you scroll through a
list of items contained inside the `CustomScrollView`.

This recipe demonstrates how to use a `CustomScrollView` to display a list of 
items with an app bar on top that scrolls offscreen as the user scrolls down the
list.

### Directions

  1. Create a `CustomScrollView`
  2. Use `SliverAppBar` to add a floating app bar
  3. Add a list of items using a `SliverList`

## 1. Create a `CustomScrollView`

In order to create a floating app bar, you need to place the app bar inside a
`CustomScrollView` that also contains the list of items. This synchronizes the
scroll position of the app bar and the list of items. You may think of the
`CustomScrollView` Widget as a `ListView` that allows you to mix and match
different types of scrollable lists and widgets together!

The scrollable lists and widgets that can be provided to the the
`CustomScrollView` are known as slivers. There are several types of Slivers,
such as a `SliverList`, `SliverGridList`, and `SliverAppBar`! In fact, the
`ListView` and `GridView` Widgets use the `SliverList` and `SliverGrid` widgets
under the hood!

For this example, create a `CustomScrollView` that contains a 
`SliverAppBar` and a `SliverList`. In addition, you need to remove any app bars
you may be providing to the `Scaffold` Widget!

<!-- skip -->
```dart
Scaffold(
  // No appBar property provided, only the body!
  body: CustomScrollView(
    // Add the app bar and list of items as slivers in the next steps
    slivers: <Widget>[]
  ),
);
```

### 2. Use `SliverAppBar` to add a floating app bar

Next, add an app bar to the
[`CustomScrollView`](https://docs.flutter.io/flutter/widgets/CustomScrollView-class.html).
Flutter provides the
[`SliverAppBar`](https://docs.flutter.io/flutter/material/SliverAppBar-class.html)
Widget out of the box.  Much like the normal `AppBar` widget, you can use the
`SliverAppBar` to display a title, tabs, images and more.

However, the `SliverAppBar` also gives you the ability to create a "floating"
app bar that scrolls offscreen as the user scrolls down the list. Furthermore,
you can configure the `SliverAppBar` to shrink and expand as the user scrolls.

To achieve this effect:

  1. Start with an app bar that displays only a title 
  2. Set the `floating` property to `true`. This allows users to quickly reveal
  the app bar when they being scrolling up the list.
  3. Add a `flexibleSpace` widget that will fill the available `expandedHeight`.

<!-- skip -->
```dart
CustomScrollView(
  slivers: <Widget>[
    SliverAppBar(
      title: Text('Floating app bar'),
      // Allows the user to reveal the app bar if they begin scrolling back
      // up the list of items
      floating: true,
      // Display a placeholder Widget to visualize the shrinking size
      flexibleSpace: Placeholder(),
      // Make the initial height of the SliverAppBar larger than normal
      expandedHeight: 200,
    ),
  ],
);
```

{{site.alert.tip}}
Play around with the [various properties you can pass to the `SliverAppBar`
Widget](https://docs.flutter.io/flutter/material/SliverAppBar/SliverAppBar.html)
and use hot reload to see the results. For example, you can use an `Image`
Widget for the `flexibleSpace` property to create a background image that
shrinks in size as it's scrolled offscreen.
{{site.alert.end}}


### 3. Add a list of items using a `SliverList`

Now that you have the app bar in place, add a list of items to the
`CustomScrollView`. You have two options: a
[`SliverList`](https://docs.flutter.io/flutter/widgets/SliverList-class.html) or
a [`SliverGrid`](https://docs.flutter.io/flutter/widgets/SliverGrid-class.html).
If you need to display a list of items one after the other, use the `SliverList`
Widget. If you need to display a grid list, use the `SliverGrid` Widget.

The `SliverList` and `SliverGrid` Widgets take one required parameter: a
[`SliverChildDelegate`](https://docs.flutter.io/flutter/widgets/SliverChildDelegate-class.html).
While this sounds fancy, the delegate is simply used to provide a list Widgets
to `SliverList` or `SliverGrid`. For example, the
[`SliverChildBuilderDelegate`](https://docs.flutter.io/flutter/widgets/SliverChildBuilderDelegate-class.html)
allows you to create a list of items that are built lazily as you scroll, just
like the the `ListView.builder` Widget.

<!-- skip -->
```dart
// Create a SliverList
SliverList(
  // That uses a delegate to build items as they're scrolled on screen. 
  delegate: SliverChildBuilderDelegate(
    // The builder function returns a ListTile with a title that
    // displays the index of the current item
    (context, index) => ListTile(title: Text('Item #$index')),
    // Builds 1000 ListTiles
    childCount: 1000,
  ),
)
```

## Complete example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView
        body: CustomScrollView(
          slivers: <Widget>[
            // Add the app bar to the CustomScrollView
            SliverAppBar(
              // Provide a standard title
              title: Text(title),
              // Allows the user to reveal the app bar if they begin scrolling
              // back up the list of items
              floating: true,
              // Display a placeholder Widget to visualize the shrinking size
              flexibleSpace: Placeholder(),
              // Make the initial height of the SliverAppBar larger than normal
              expandedHeight: 200,
            ),
            // Next, create a SliverList
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item
                (context, index) => ListTile(title: Text('Item #$index')),
                // Builds 1000 ListTiles
                childCount: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

![Basic List Demo](/images/cookbook/floating-app-bar.gif){:.site-mobile-screenshot}
