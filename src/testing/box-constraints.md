---
title: Debugging box constraints
description: How box constraints might go wrong.
short-title: Box constraints
---

{{site.alert.note}}
  You might be directed to this page if the
  framework detects a problem involving box constraints.
{{site.alert.end}}

Perhaps you’ve run into an issue where an image is
cut off (or not even visible) on your app.
Maybe you received the
"viewport was given unbounded height" error.
The two most frequent types of Flutter errors are both problems
with layout: widget overflow and "renderbox not laid out" issues.

This page helps you understand and debug the three most
common types of layout errors
using the Flutter inspector, and a sample app.

![Screenshot of menu demo]({{site.url}}/assets/images/docs/testing/layout/menu-demo.png)

## Set up the menu app

1. Create the sample menu app

```sh
flutter create menu
```

2. Replace `lib/main.dart` content with the following:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(Menu());
}

class MenuItem extends StatelessWidget {
  const MenuItem(this.icon, this.itemText);
  final String icon;
  final String itemText;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        icon,
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
      title: Text(itemText),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu Demo'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Modify code here
              Example1(),
            ],
          ),
        ),
      ),
    );
  }
}

// Problem 1: Overflow error
class Example1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          Text(
            'Explore the restaurant\'s delicious menu items below!',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}

// Problem 2: Viewport was given unbounded height error
class Example2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuItem('🍔', 'Burger'),
        MenuItem('🌭', 'Hot Dog'),
        MenuItem('🍟', 'Fries'),
        MenuItem('🥤', 'Soda'),
        MenuItem('🍦', 'Ice Cream'),
      ],
    );
  }
}

// Problem 3: Invisible VerticalDivider
class Example3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          onPressed: () {
            print('Pickup button pressed.');
          },
          child: Text(
            'Pickup',
          ),
        ),
        // This widget is not shown on screen initially.
        VerticalDivider(
          width: 20.0,
          thickness: 5.0,
        ),
        RaisedButton(
          onPressed: () {
            print('Delivery button pressed.');
          },
          child: Text(
            'Delivery',
          ),
        )
      ],
    );
  }
}
```

## Debugging an overflow error


Maybe don't need?
![Screenshot of the Flutter inspector window]({{site.url}}/assets/images/docs/testing/layout/devtools-issue1.png)


