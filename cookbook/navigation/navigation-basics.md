---
layout: page
title: "Navigate to a new screen and back"
permalink: /cookbook/navigation/navigation-basics/
---

Most apps contain several screens for displaying different types of information. 
For example, we might have a screen that shows products. Our users could then
tap on a product to get more information about it on a new screen.

In Android terms, our screens would be new Activities. In iOS terms, new 
ViewControllers. In Flutter, screens are just Widgets!

So how do we navigate to new screens? Using the [`Navigator`](https://docs.flutter.io/flutter/widgets/Navigator-class.html)!

## Directions

  1. Create two screens
  2. Navigate to the second screen using `Navigator.push`
  3. Return to the first screen using `Navigator.pop`

## 1. Create two screens

First, we'll need two screens to work with. Since this is a basic example, we'll
create two screens, each containing a single button. Tapping the button on the 
first screen will navigate to the second screen. Tapping the button on the 
second screen will return our user back to the first!

First, we'll set up the visual structure.

```dart
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('Launch new screen'),
          onPressed: () {
            // Navigate to second screen when tapped!
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped!
          },
          child: new Text('Go back!'),
        ),
      ),
    );
  }
}
```

## 2. Navigate to the second screen using `Navigator.push`

In order to Navigate to a new screen, we'll need to use the 
[`Navigator.push`](https://docs.flutter.io/flutter/widgets/Navigator/push.html) 
method. The `push` method will add a `Route` to the stack of routes managed by
the Navigator!

The `push` method requires a `Route`, but where does the `Route` come from? 
We can create our own, or use the [`MaterialPageRoute`](https://docs.flutter.io/flutter/material/MaterialPageRoute-class.html)
out of the box. The `MaterialPageRoute` is handy because it transitions to the 
new screen using a platform-specific animation. 

In the `build` method of our `FirstScreen` Widget, we'll update the `onPressed` 
callback:

```dart
// Within the `FirstScreen` Widget
onPressed: () {
  Navigator.push(
    context,
    new MaterialPageRoute(builder: (context) => new SecondScreen()),
  );
}
``` 

## 3. Return to the first screen using `Navigator.pop`

Now that we're on our second screen, how do we close it out and return to the 
first? Using the [`Navigator.pop`](https://docs.flutter.io/flutter/widgets/Navigator/pop.html)
method! The `pop` method will remove the current `Route` from the stack of 
routes managed by the navigator.

For this part, we'll need to update the `onPressed` callback found in our 
`SecondScreen` Widget

```dart
// Within the SecondScreen Widget
onPressed: () {
  Navigator.pop(context);
}
```    

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Navigation Basics',
    home: new FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('Launch new screen'),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new SecondScreen()),
            );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('Go back!'),
        ),
      ),
    );
  }
}
```

![Navigation Basics Demo](/images/cookbook/navigation-basics.gif)