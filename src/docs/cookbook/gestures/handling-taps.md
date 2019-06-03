---
title: Handling taps
prev:
  title: Adding Material touch ripples
  path: /docs/cookbook/gestures/ripples
next:
  title: Implement swipe to dismiss
  path: /docs/cookbook/gestures/dismissible
---

You not only want to display information to users,
you want users to interact with your app. Use the
[`GestureDetector`]({{site.api}}/flutter/widgets/GestureDetector-class.html)
widget to respond to fundamental actions, such as tapping and dragging.

Say you want to make a custom button that shows a snackbar when tapped.
How to do this?

## Directions

  1. Create the button
  2. Wrap it in a `GestureDetector` with an `onTap()` callback

<!-- skip -->
```dart
// The GestureDetector wraps the button.
GestureDetector(
  // When the child is tapped, show a snackbar.
  onTap: () {
    final snackBar = SnackBar(content: Text("Tap"));

    Scaffold.of(context).showSnackBar(snackBar);
  },
  // The custom button
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

  1. To add the Material ripple effect to your button, see the
     [Adding Material touch ripples](/docs/cookbook/gestures/ripples/) recipe.
  2. While this example creates a custom button to demonstrate these concepts,
     Flutter includes a handful of buttons out of the box:
     [RaisedButton]({{site.api}}/flutter/material/RaisedButton-class.html),
     [FlatButton]({{site.api}}/flutter/material/FlatButton-class.html), and
     [CupertinoButton]({{site.api}}/flutter/cupertino/CupertinoButton-class.html)

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
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        final snackBar = SnackBar(content: Text("Tap"));

        Scaffold.of(context).showSnackBar(snackBar);
      },
      // The custom button
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
