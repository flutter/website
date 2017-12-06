---
layout: page
title: Learn Flutter; managing state

permalink: /learn/state/
---

This page teaches the basic concept of managing state in a widget.

* Placeholder for TOC
{:toc}

## Stateless widgets

Many widgets -- such as the `FlatButton` mentioned earlier are *stateless*. That means that their rendering is not dependent on mutable state, but rather is based on a constant configuration, such as a constant color or content.

To create a stateless widget:

1. `extend` the class `StatelessWidget`
1. Add a constructor that takes any needed configuration values
1. `Add an override of the [build method](/learn/build/)

Concrete example:

```dart
class OKButton extends StatelessWidget {
  final VoidCallback onPressed;

  PushButton({
    this.onPressed,
  });

  @override
  build(BuildContext context) {
    return new FlatButton(child: new Text('OK));
  }
}
```

## Stateful widgets

Real-world apps always contain some amount of mutable state. This often contains state built as the user is interacting with the application. Statefull widgets are rendered based on both their static configuration, and their assciated state.

Note that Flutter uses a reactive style, so you never need to tell Flutter when to update it's UI. Rather, you tell flutter 

To create a stateful widget:

1. `extend` the class `StatefulWidget`
1. Add a constructor that takes any needed configuration values
1. `Add an override of the `createState` method returning a new state
1. Add a State class extending `State<t>` where t is the widget's type
1. Wrap any changes to the state in `setState()`

Concrete example:

```dart
class CountingButton extends StatefulWidget {
  CountingButton({Key key, this.raised}) : super(key: key);

  final bool raised;

  @override
  CountingButtonState createState() => new CountingButtonState();
}

class CountingButtonState extends State<CountingButton> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String buttonLabel = 'You have pushed me $_counter times';
    if (widget.raised) {
      return new RaisedButton(
          child: new Text(buttonLabel), onPressed: _incrementCounter);
    } else {
      return new FlatButton(
          child: new Text(buttonLabel), onPressed: _incrementCounter);
    }
  }
}
```

## Next step

Now that you understand the basics of rendering both stateless and statefull widgets, let's move on to [adding multiple pages and navigation with routes](/learn/routes/).



