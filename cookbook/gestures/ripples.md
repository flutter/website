---
layout: page
title: "Adding Material Touch Ripples"
permalink: /cookbook/gestures/ripples/
---

While designing an app that should follow the Material Design Guidelines, we'll 
want to add the ripple animation to Widgets when tapped. 

Flutter provides the [`InkWell`](https://docs.flutter.io/flutter/material/InkWell-class.html)
Widget to achieve this effect.

## Directions

  1. Create a Widget we want to tap
  2. Wrap it in an `InkWell` Widget to manage tap callbacks and ripple animations 
  
```dart
// The InkWell Wraps our custom flat button Widget
new InkWell(
  // When the user taps the button, show a snackbar
  onTap: () {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Tap'),
    ));
  },
  child: new Container(
    padding: new EdgeInsets.all(12.0),
    child: new Text('Flat Button'),
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
    final title = 'InkWell Demo';

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
    // The InkWell Wraps our custom flat button Widget
    return new InkWell(
      // When the user taps the button, show a snackbar
      onTap: () {
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Tap'),
        ));
      },
      child: new Container(
        padding: new EdgeInsets.all(12.0),
        child: new Text('Flat Button'),
      ),
    );
  }
}
```

![Ripples Demo](/images/cookbook/ripples.gif)