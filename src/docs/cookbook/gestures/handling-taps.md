---
title: Handle taps
prev:
  title: Add Material touch ripples
  path: /docs/cookbook/gestures/ripples
next:
  title: Implement swipe to dismiss
  path: /docs/cookbook/gestures/dismissible
---

You not only want to display information to users,
you want users to interact with your app.
Use the [`GestureDetector`][] widget to respond
to fundamental actions, such as tapping and dragging.

This recipe shows how to make a custom button that shows
a snackbar when tapped with the following steps:

  1. Create the button.
  2. Wrap it in a `GestureDetector` that an `onTap()` callback.

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

  1. For information on adding the Material ripple effect to your
     button, see the [Add Material touch ripples][] recipe.
  2. Although this example creates a custom button,
     Flutter includes a handful of button implementations, such as:
     [`RaisedButton`][], [`FlatButton`][], and
     [`CupertinoButton`][].

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

![Handle taps demo](/images/cookbook/handling-taps.gif){:.site-mobile-screenshot}


[Add Material touch ripples]: /docs/cookbook/gestures/ripples
[`CupertinoButton`]: {{site.api}}/flutter/cupertino/CupertinoButton-class.html
[`FlatButton`]: {{site.api}}/flutter/material/FlatButton-class.html
[`GestureDetector`]: {{site.api}}/flutter/widgets/GestureDetector-class.html
[`RaisedButton`]: {{site.api}}/flutter/material/RaisedButton-class.html
