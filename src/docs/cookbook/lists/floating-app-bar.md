---
title: Place a floating app bar above a list
description: How to place a floating app bar above a list.
prev:
  title: Create lists with different types of items
  path: /docs/cookbook/lists/mixed-list
next:
  title: Work with long lists
  path: /docs/cookbook/lists/long-lists
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/lists/floating_app_bar/"?>

To make it easier for users to view a list of items,
you might want to hide the app bar as the user scrolls down the list.
This is especially true if your app displays a "tall"
app bar that occupies a lot of vertical space.

Typically, you create an app bar by providing an `appBar` property to the
`Scaffold` widget. This creates a fixed app bar that always remains above
the `body` of the `Scaffold`.

Moving the app bar from a `Scaffold` widget into a
[`CustomScrollView`][] allows you to create an app bar
that scrolls offscreen as you scroll through a
list of items contained inside the `CustomScrollView`.

This recipe demonstrates how to use a `CustomScrollView` to display a list of
items with an app bar on top that scrolls offscreen as the user scrolls
down the list using the following steps:

  1. Create a `CustomScrollView`.
  2. Use `SliverAppBar` to add a floating app bar.
  3. Add a list of items using a `SliverList`.

## 1. Create a `CustomScrollView`

To create a floating app bar, place the app bar inside a
`CustomScrollView` that also contains the list of items.
This synchronizes the scroll position of the app bar and the list of items.
You might think of the `CustomScrollView` widget as a `ListView`
that allows you to mix and match different types of scrollable lists
and widgets together.

The scrollable lists and widgets provided to the
`CustomScrollView` are known as _slivers_. There are several types
of slivers, such as `SliverList`, `SliverGridList`, and `SliverAppBar`.
In fact, the `ListView` and `GridView` widgets use the `SliverList` and
`SliverGrid` widgets to implement scrolling.

For this example, create a `CustomScrollView` that contains a
`SliverAppBar` and a `SliverList`. In addition, remove any app bars
that you provide to the `Scaffold` widget.

<!-- skip -->
```dart
Scaffold(
  // No appBar property provided, only the body.
  body: CustomScrollView(
    // Add the app bar and list of items as slivers in the next steps.
    slivers: <Widget>[]
  ),
);
```

### 2. Use `SliverAppBar` to add a floating app bar

Next, add an app bar to the [`CustomScrollView`][].
Flutter provides the [`SliverAppBar`][] widget which,
much like the normal `AppBar` widget,
uses the `SliverAppBar` to display a title,
tabs, images and more.

However, the `SliverAppBar` also gives you the ability to create a "floating"
app bar that scrolls offscreen as the user scrolls down the list.
Furthermore, you can configure the `SliverAppBar` to shrink and
expand as the user scrolls.

To create this effect:

  1. Start with an app bar that displays only a title.
  2. Set the `floating` property to `true`.
     This allows users to quickly reveal the app bar when
     they scroll up the list.
  3. Add a `flexibleSpace` widget that fills the available
     `expandedHeight`.

<?code-excerpt "lib/step2.dart (SliverAppBar)" replace="/^body: //g;/,$//g"?>
```dart
CustomScrollView(
  slivers: <Widget>[
    // Add the app bar to the CustomScrollView.
    SliverAppBar(
      // Provide a standard title.
      title: Text(title),
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

{{site.alert.tip}}
  Play around with the
  [various properties you can pass to the `SliverAppBar` widget][],
  and use hot reload to see the results. For example, use an `Image`
  widget for the `flexibleSpace` property to create a background image that
  shrinks in size as it's scrolled offscreen.
{{site.alert.end}}


### 3. Add a list of items using a `SliverList`

Now that you have the app bar in place, add a list of items to the
`CustomScrollView`. You have two options: a [`SliverList`][]
or a [`SliverGrid`][].  If you need to display a list of items one after the other,
use the `SliverList` widget.
If you need to display a grid list, use the `SliverGrid` widget.

The `SliverList` and `SliverGrid` widgets take one required parameter: a
[`SliverChildDelegate`][], which provides a list
of widgets to `SliverList` or `SliverGrid`.
For example, the [`SliverChildBuilderDelegate`][]
allows you to create a list of items that are built lazily as you scroll,
just like the `ListView.builder` widget.

<?code-excerpt "lib/main.dart (SliverList)" replace="/,$//g"?>
```dart
// Next, create a SliverList
SliverList(
  // Use a delegate to build items as they're scrolled on screen.
  delegate: SliverChildBuilderDelegate(
    // The builder function returns a ListTile with a title that
    // displays the index of the current item.
    (context, index) => ListTile(title: Text('Item #$index')),
    // Builds 1000 ListTiles
    childCount: 1000,
  ),
)
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        body: CustomScrollView(
          slivers: <Widget>[
            // Add the app bar to the CustomScrollView.
            SliverAppBar(
              // Provide a standard title.
              title: Text(title),
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

<noscript>
  <img src="/images/cookbook/floating-app-bar.gif" alt="Use list demo" class="site-mobile-screenshot"/> 
</noscript>


[`CustomScrollView`]: {{site.api}}/flutter/widgets/CustomScrollView-class.html
[`SliverAppBar`]: {{site.api}}/flutter/material/SliverAppBar-class.html
[`SliverChildBuilderDelegate`]: {{site.api}}/flutter/widgets/SliverChildBuilderDelegate-class.html
[`SliverChildDelegate`]: {{site.api}}/flutter/widgets/SliverChildDelegate-class.html
[`SliverGrid`]: {{site.api}}/flutter/widgets/SliverGrid-class.html
[`SliverList`]: {{site.api}}/flutter/widgets/SliverList-class.html
[various properties you can pass to the `SliverAppBar` widget]: {{site.api}}/flutter/material/SliverAppBar/SliverAppBar.html
