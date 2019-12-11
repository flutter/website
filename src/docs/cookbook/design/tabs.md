---
title: Work with tabs
prev:
  title: Use custom fonts
  path: /docs/cookbook/design/fonts
next:
  title: Build a form with validation
  path: /docs/cookbook/forms/validation
---

Working with tabs is a common pattern in apps that follow the Material Design
guidelines. Flutter includes a convenient way to create tab layouts as part of
the [material library][].

{{site.alert.note}}
  To create tabs in a Cupertino app, see the
  [Building a Cupertino app with Flutter][] codelab.
{{site.alert.end}}

This recipe creates a tabbed example using the following steps;

  1. Create a `TabController`.
  2. Create the tabs.
  3. Create content for each tab.

## 1. Create a `TabController`

For tabs to work, you need to keep the selected tab and content
sections in sync.
This is the job of the [`TabController`][].

Either create a `TabController` manually,
or automatically by using a [`DefaultTabController`][] widget.

Using `DefaultTabController` is the simplest option, since it
creates a `TabController` and makes it available to all descendant widgets.

<!-- skip -->
```dart
DefaultTabController(
  // The number of tabs / content sections to display.
  length: 3,
  child: // Complete this code in the next step.
);
```

## 2. Create the tabs

When a tab is selected, it needs to display content.
You can create tabs using the [`TabBar`][] widget.
In this example, create a `TabBar` with three
[`Tab`][] widgets and place it within an [`AppBar`][].

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

By default, the `TabBar` looks up the widget tree for the nearest
`DefaultTabController`. If you're manually creating a `TabController`,
pass it to the `TabBar`.

## 3. Create content for each tab

Now that you have tabs, display content when a tab is selected.
For this purpose, use the [`TabBarView`][] widget.

{{site.alert.note}}
  Order is important and must correspond to the order of the tabs in the
  `TabBar`.
{{site.alert.end}}

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


[`AppBar`]: {{site.api}}/flutter/material/AppBar-class.html
[Building a Cupertino app with Flutter]: https://codelabs.developers.google.com/codelabs/flutter-cupertino
[`DefaultTabController`]: {{site.api}}/flutter/material/DefaultTabController-class.html
[material library]: {{site.api}}/flutter/material/material-library.html
[`Tab`]: {{site.api}}/flutter/material/Tab-class.html
[`TabBar`]: {{site.api}}/flutter/material/TabController-class.html
[`TabBarView`]: {{site.api}}/flutter/material/TabBarView-class.html
[`TabController`]: {{site.api}}/flutter/material/TabController-class.html
