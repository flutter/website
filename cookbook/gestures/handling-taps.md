---
layout: page
title: "Handling Taps"
permalink: /cookbook/gestures/handling-taps/
---

We not only want to display information to our users, we want our users to 
interact with our apps! So how do we respond to fundamental actions such as 
tapping and dragging? We'll use the [`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) 
Widget!

Say we want to make a custom button that shows a snackbar when tapped. How would
we approach this?

## Directions

  1. Create the button
  2. Wrap it in a `GestureDetector` with an `onTap` callback

```dart
// Our GestureDetector wraps our button
new GestureDetector(
  // When the child is tapped, show a snackbar 
  onTap: () {
    Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Tap"),
        ));
  },
  // Our Custom Button!
  child: new Container(
    padding: new EdgeInsets.all(12.0),
    decoration: new BoxDecoration(
      color: Theme.of(context).buttonColor,
      borderRadius: new BorderRadius.circular(8.0),
    ),
    child: new Text('My Button'),
  ),
);
```   

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Gesture Demo';

    return new MaterialApp(
      title: title,
      home: new MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(child: new MyButton()),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text("Tap"),
            ));
      },
      child: new Container(
        padding: new EdgeInsets.all(12.0),
        decoration: new BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Text('My Button'),
      ),
    );
  }
}
```