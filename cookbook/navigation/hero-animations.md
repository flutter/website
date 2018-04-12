---
layout: page
title: "Animating a Widget across screens"
permalink: /cookbook/navigation/hero-animations/
---

It's often helpful to guide users through our apps as they navigate from screen
to screen. A common technique to lead users through an app is to animate a 
Widget from one screen to the next. This creates a visual anchor connecting
the two screens.

How can we animate a Widget from one screen to the next with Flutter? Using the 
[`Hero`](https://docs.flutter.io/flutter/widgets/Hero-class.html) Widget!  

## Directions

  1. Create two screens showing the same image
  2. Add a `Hero` Widget to the first screen
  3. Add a `Hero` Widget to the second screen

## 1. Create two screens showing the same image

In this example, we'll display the same image on both screens. We'll want to 
animate the image from the first screen to the second screen when the user taps 
on the image. For now, we'll create the visual structure, and handle animations 
in the next steps!

*Note:* This example builds upon the 
[Navigate to a new screen and back](/cookbook/navigation/navigation-basics/) 
and [Handling Taps](/cookbook/gestures/handling-taps/) recipes. 

```dart
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Main Screen'),
      ),
      body: new GestureDetector(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (_) {
            return new DetailScreen();
          }));
        },
        child: new Image.network(
          'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: new Center(
          child: new Image.network(
            'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
          ),
        ),
      ),
    );
  }
}
```

## 2. Add a `Hero` Widget to the first screen

In order to connect the two screens together with an animation, we need to wrap
the `Image` Widget on both screens in a `Hero` Widget. The `Hero` Widget 
requires two arguments:

  1. `tag`: An object that identifies the `Hero`. It must be the same on both 
  screens.
  2. `child`: The Widget we want to animate across screens.
  
```dart
new Hero(
  tag: 'imageHero',
  child: new Image.network(
    'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
  ),
);
```  

## 3. Add a `Hero` Widget to the second screen

To complete the connection with the first screen, we need to wrap the `Image` 
on the second screen with a `Hero` Widget as well! It must use the same `tag` 
as the first screen.

After you apply the `Hero` Widget to the second screen, the animation between 
screens will work!

```dart
new Hero(
  tag: 'imageHero',
  child: new Image.network(
    'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
  ),
);
```

Note: this code is identical to what we had on the first screen! In general, you 
could create a reusable Widget instead of repeating code, but for this example, 
we'll duplicate the code for demonstration purposes.

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new HeroApp());

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Transition Demo',
      home: new MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Main Screen'),
      ),
      body: new GestureDetector(
        child: new Hero(
          tag: 'imageHero',
          child: new Image.network(
            'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
          ),
        ),
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (_) {
            return new DetailScreen();
          }));
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new GestureDetector(
        child: new Center(
          child: new Hero(
            tag: 'imageHero',
            child: new Image.network(
              'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
```

![Hero Demo](/images/cookbook/hero.gif)
