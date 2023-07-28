---
title: List with spaced items
description: How to create a list with spaced or expanded items 
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="cookbook/lists/spaced_items/"?>

When working with lists, you might want to show all
items spaced evently, so that the items take the whole screen.
In the following screen, the four items are spaced evently,
being "Item 0" at the top, and "Item 3" at the bottom.

![Spaced items]({{site.url}}/assets/images/docs/cookbook/spaced-items-1.png){:.site-mobile-screenshot}

At the same time, you might want to allow users
to scroll through the list when the list of items won't fit,
maybe because a device is too small, a user resized a window,
or the items are larger.

![Scrollable items]({{site.url}}/assets/images/docs/cookbook/spaced-items-2.png){:.site-mobile-screenshot}

Typically, you use `Spacer` to tune the spacing between widgets,
or `Expanded` to expand a widget to fill the available space.
However, these solutions are not possible inside scrollable widgets,
because they need a finite height constraint.

This recipe demonstrates how to use `LayourBuilder` and `ConstrainedBox`
to space out list items evently when there is enough space, and to allow
users to scrolll when there is not enough space,
using the following steps:

  1. Add a `LayoutBuilder` with a `SingleChildScrollView`.
  2. Add a `ConstrainedBox` inside the `SingleChildScrollView`.
  3. Create a `Column` with spaced items.

## 1. Add a `LayoutBuilder` with a `SingleChildScrollView`



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

<?code-excerpt "lib/starter.dart (CustomScrollView)" replace="/^return //g"?>
```dart
Scaffold(
  // No appBar property provided, only the body.
  body: CustomScrollView(
      // Add the app bar and list of items as slivers in the next steps.
      slivers: <Widget>[]),
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
  slivers: [
    // Add the app bar to the CustomScrollView.
    const SliverAppBar(
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
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example
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
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        body: CustomScrollView(
          slivers: [
            // Add the app bar to the CustomScrollView.
            const SliverAppBar(
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
  <img src="/assets/images/docs/cookbook/floating-app-bar.gif" alt="Use list demo" class="site-mobile-screenshot"/> 
</noscript>


[`CustomScrollView`]: {{site.api}}/flutter/widgets/CustomScrollView-class.html
[`SliverAppBar`]: {{site.api}}/flutter/material/SliverAppBar-class.html
[`SliverChildBuilderDelegate`]: {{site.api}}/flutter/widgets/SliverChildBuilderDelegate-class.html
[`SliverChildDelegate`]: {{site.api}}/flutter/widgets/SliverChildDelegate-class.html
[`SliverGrid`]: {{site.api}}/flutter/widgets/SliverGrid-class.html
[`SliverList`]: {{site.api}}/flutter/widgets/SliverList-class.html
[various properties you can pass to the `SliverAppBar` widget]: {{site.api}}/flutter/material/SliverAppBar/SliverAppBar.html
