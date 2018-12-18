---
title: Working with Tabs
---

Working with tabs is a common pattern in apps following the Material Design
guidelines. Flutter includes a convenient way to create tab layouts as part of
the [material library](https://docs.flutter.io/flutter/material/material-library.html).

## Steps

  1. Create a [`TabController`](https://docs.flutter.io/flutter/material/TabController-class.html)
  2. Create the [`TabBar`](https://docs.flutter.io/flutter/material/TabBar-class.html)
     with [`Tab's`](https://docs.flutter.io/flutter/material/Tab-class.html) 
  3. Create content for each tab in a [`TabBarView`](https://docs.flutter.io/flutter/material/TabBarView-class.html)

## 1. Create a `TabController`

The purpose of the [`TabController`](https://docs.flutter.io/flutter/material/TabController-class.html),
is to keep the selected 'tab' and content 'view' in sync. 

A `TabController` can be either:
- manually created `TabController` or sublcassed
- or using 
  the [`DefaultTabController`](https://docs.flutter.io/flutter/material/DefaultTabController-class.html)
  Widget. 
- Using the `DefaultTabController` is the simplest option, as it will
  create a `TabController` widget and make it available to all descendant Widgets.

<!-- skip -->
```dart
DefaultTabController(
  // The number of tabs / content sections we need to display
  length: 3,
  child: // See the next step!
);
```

## 2. Create the `TabBar` and `Tab`s

The example below shows 
- a [`TabBar`](https://docs.flutter.io/flutter/material/TabController-class.html) Widget
- with three [`Tab`](https://docs.flutter.io/flutter/material/Tab-class.html) Widgets 
- placed at the `bottom:` of the [`AppBar`](https://docs.flutter.io/flutter/material/AppBar-class.html).

<!-- skip -->
```dart
DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.directions_bike)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_car)),
        ],
      ),
    ),
  ),
);
```
The `TabBar` must have a **controller:**
- by passing a  `TabController` specifically created as the **controller:** var
- otherwise, the `TabBar` will look up the Widget tree for the nearest `DefaultTabController`
- and if one not found then an error

## 3. Create content in a `TabBarView`

The [`TabBarView`](https://docs.flutter.io/flutter/material/TabBarView-class.html)
is used to "switch" and display content when a tab is selected

*Note:* Order is important and must correspond to the order of the tabs in the `TabBar`!

<!-- skip -->
```dart
TabBarView(
  children: [
    Tab(icon: Icon(Icons.directions_bike)),
    Tab(icon: Icon(Icons.directions_transit)),
    Tab(icon: Icon(Icons.directions_car)),
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
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_car)),
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
