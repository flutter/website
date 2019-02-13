---
title: Handling Taps
prev:
  title: Adding Material Touch Ripples
  path: /docs/cookbook/gestures/ripples
next:
  title: Implement Swipe to Dismiss
  path: /docs/cookbook/gestures/dismissible
---

We not only want to display information to our users, we want our users to
interact with our apps! So how do we respond to fundamental actions such as
tapping and dragging? We'll use the
[`GestureDetector`]({{site.api}}/flutter/widgets/GestureDetector-class.html)
Widget!

Say we want to make a custom button that shows a snackbar when tapped. How would
we approach this?

## Directions

  1. Create the button
  2. Wrap it in a `GestureDetector` with an `onTap` callback

<!-- skip -->
```dart
// Our GestureDetector wraps our button
GestureDetector(
  // When the child is tapped, show a snackbar
  onTap: () {
    final snackBar = SnackBar(content: Text("Tap"));

    Scaffold.of(context).showSnackBar(snackBar);
  },
  // Our Custom Button!
  child: Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Theme.of(context).buttonColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text('My Button'),
  ),
);
```

## Notes

  1. If you'd like to add the Material Ripple effect to your button, please
  see the "[Adding Material Touch ripples](/docs/cookbook/gestures/ripples/)" recipe.
  2. While we've created a custom button to demonstrate these concepts, Flutter
  includes a handful of buttons out of the box:
  [RaisedButton]({{site.api}}/flutter/material/RaisedButton-class.html),
  [FlatButton]({{site.api}}/flutter/material/FlatButton-class.html),
  and [CupertinoButton]({{site.api}}/flutter/cupertino/CupertinoButton-class.html)


## Complete example

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Gesture Demo';

    return MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: MyButton()),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Our GestureDetector wraps our button
    return GestureDetector(
      // When the child is tapped, show a snackbar
      onTap: () {
        final snackBar = SnackBar(content: Text("Tap"));

        Scaffold.of(context).showSnackBar(snackBar);
      },
      // Our Custom Button!
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text('My Button'),
      ),
    );
  }
}
```

![Handling Taps Demo](/images/cookbook/handling-taps.gif){:.site-mobile-screenshot}
