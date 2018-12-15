---
title: Navigate to a new screen and back
---


Most apps contain several screens/pages for displaying different types of information. In Flutter their `Widgets`.

A typical shopping app, for example:
 - Presents a home screen/page `Widget` that shows products
 - `onTap()` a product switches to a detail `Widget` screen
 - order button presents another screen etc, etc

# platform cases
 - On Android, screens/pages would be new [Activities](https://developer.android.com/reference/android/app/Activity) 
 - On iOS, new [ViewControllers](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/) 
 - With Flutter, screens are just widgets :-)

To switch and navigate between widgets, Flutter has the [`Navigator`](https://docs.flutter.io/flutter/widgets/Navigator-class.html) class.

## Directions

  1. Create two screens
  2. Navigate to the second screen using `Navigator.push`
  3. Return to the first screen using `Navigator.pop`

## 1. Create two screens

In this basic example, there are two screens, each containing a single button. 
- Tapping the button on the first screen will navigate to the second screen. 
- Tapping the button on the second screen will return back to the first screen.

```dart
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch second screen'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("The Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped!
          },
          child: Text('Go back to first!'),
        ),
      ),
    );
  }
}
```

## 2. Navigate to the second screen using `Navigator.push`

The [`Navigator.push`](https://docs.flutter.io/flutter/widgets/Navigator/push.html) method 
will **add** a `Route` to the stack of routes managed by the Navigator.

The `push` method requires a `Route`, but where does the `Route` come from?
We can create our own, or use the [`MaterialPageRoute`](https://docs.flutter.io/flutter/material/MaterialPageRoute-class.html)
out of the box. The `MaterialPageRoute` is handy because it transitions to the
new screen using a platform-specific animation.

In the `build` method of our `FirstScreen` Widget, update the `onPressed` callback:

<!-- skip -->
```dart
// Within the `FirstScreen` Widget
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SecondScreen()),
  );
}
```

## 3. Return to the first screen using `Navigator.pop`

The [`Navigator.pop`](https://docs.flutter.io/flutter/widgets/Navigator/pop.html)
method will remove the current `Route` from the stack of routes managed by the navigator.

<!-- skip -->
```dart
// Within the SecondScreen Widget
onPressed: () {
  Navigator.pop(context);
}
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
```

![Navigation Basics Demo](/images/cookbook/navigation-basics.gif){:.site-mobile-screenshot}
