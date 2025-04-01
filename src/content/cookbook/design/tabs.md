---
title: Work with tabs
description: How to implement tabs in a layout.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/design/tabs/"?>

Working with tabs is a common pattern in apps that follow the
Material Design guidelines.
Flutter includes a convenient way to create tab layouts as part of
the [material library][].

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

<?code-excerpt "lib/partials.dart (TabController)"?>
```dart
return MaterialApp(
  home: DefaultTabController(length: 3, child: Scaffold()),
);
```

## 2. Create the tabs

When a tab is selected, it needs to display content.
You can create tabs using the [`TabBar`][] widget.
In this example, create a `TabBar` with three
[`Tab`][] widgets and place it within an [`AppBar`][].

<?code-excerpt "lib/partials.dart (Tabs)"?>
```dart
return MaterialApp(
  home: DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
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

:::note
Order is important and must correspond to the
order of the tabs in the `TabBar`.
:::

<?code-excerpt "lib/main.dart (TabBarView)"?>
```dart
body: const TabBarView(
  children: [
    Icon(Icons.directions_car),
    Icon(Icons.directions_transit),
    Icon(Icons.directions_bike),
  ],
),
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter TabBar DartPad hands-on example" run="true"
import 'package:flutter/material.dart';

void main() {
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
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

<noscript>
  <img src="/assets/images/docs/cookbook/tabs.webp" alt="Tabs Demo" class="site-mobile-screenshot" />
</noscript>


[`AppBar`]: {{site.api}}/flutter/material/AppBar-class.html
[`DefaultTabController`]: {{site.api}}/flutter/material/DefaultTabController-class.html
[material library]: {{site.api}}/flutter/material/material-library.html
[`Tab`]: {{site.api}}/flutter/material/Tab-class.html
[`TabBar`]: {{site.api}}/flutter/material/TabBar-class.html
[`TabBarView`]: {{site.api}}/flutter/material/TabBarView-class.html
[`TabController`]: {{site.api}}/flutter/material/TabController-class.html
