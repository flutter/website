---
title: Working with Tabs
prev:
  title: Using custom fonts
  path: /docs/cookbook/design/fonts
next:
  title: Building a form with validation
  path: /docs/cookbook/forms/validation
---

Working with tabs is a common pattern in apps following the Material Design
guidelines. Flutter includes a convenient way to create tab layouts as part of
the [material library]({{site.api}}/flutter/material/material-library.html).

## Directions

  1. Create a `TabController`
  2. Create the tabs
  3. Create content for each tab

## 1. Create a `TabController`

In order for tabs to work, we'll need to keep the selected tab and content
sections in sync. This is the job of the
[`TabController`]({{site.api}}/flutter/material/TabController-class.html).

We can either manually create a `TabController` or use the
[`DefaultTabController`]({{site.api}}/flutter/material/DefaultTabController-class.html)
Widget. Using the `DefaultTabController` is the simplest option, since it will
create a `TabController` for us and make it available to all descendant Widgets.

<!-- skip -->
```dart
DefaultTabController(
  // The number of tabs / content sections we need to display
  length: 3,
  child: // See the next step!
);
```

## 2. Create the tabs

Now that we have a `TabController` to work with, we can create our tabs using
the [`TabBar`]({{site.api}}/flutter/material/TabController-class.html)
Widget. In this example, we'll create a `TabBar` with 3
[`Tab`]({{site.api}}/flutter/material/Tab-class.html)
Widgets and place it within an
[`AppBar`]({{site.api}}/flutter/material/AppBar-class.html).

<!-- skip -->
```dart
DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
        ],
      ),
    ),
  ),
);
```

By default, the `TabBar` looks up the Widget tree for the nearest
`DefaultTabController`. If you're manually creating a `TabController`, you'll
need to pass it to the `TabBar`.

## 3. Create content for each tab

Now that we have tabs, we'll want to display content when a tab is selected.
For this purpose, we'll employ the
[`TabBarView`]({{site.api}}/flutter/material/TabBarView-class.html) Widget.

*Note:* Order is important and must correspond to the order of the tabs in the
`TabBar`!

<!-- skip -->
```dart
TabBarView(
  children: [
    Icon(Icons.directions_car),
    Icon(Icons.directions_transit),
    Icon(Icons.directions_bike),
  ],
);
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
```

![Tabs Demo](/images/cookbook/tabs.gif){:.site-mobile-screenshot}
