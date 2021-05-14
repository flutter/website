---
title: Animate a widget across screens
description: How to animate a widget from one screen to another
prev:
  title: Report errors to a service
  path: /docs/cookbook/maintenance/error-reporting
next:
  title: Navigate to a new screen and back
  path: /docs/cookbook/navigation/navigation-basics
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/navigation/hero_animations"?>

It's often helpful to guide users through an app as they navigate from screen
to screen. A common technique to lead users through an app is to animate a
widget from one screen to the next. This creates a visual anchor connecting
the two screens.

Use the [`Hero`][] widget
to animate a widget from one screen to the next.
This recipe uses the following steps:

  1. Create two screens showing the same image.
  2. Add a `Hero` widget to the first screen.
  3. Add a `Hero` widget to the second screen.

## 1. Create two screens showing the same image

In this example, display the same image on both screens.
Animate the image from the first screen to the second screen when
the user taps the image. For now, create the visual structure;
handle animations in the next steps.

{{site.alert.note}}
  This example builds upon the
  [Navigate to a new screen and back][]
  and [Handle taps][] recipes.
{{site.alert.end}}

<?code-excerpt "lib/main_original.dart"?>
```dart
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen();
          }));
        },
        child: Image.network(
          'https://picsum.photos/250?image=9',
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            'https://picsum.photos/250?image=9',
          ),
        ),
      ),
    );
  }
}
```

## 2. Add a `Hero` widget to the first screen

To connect the two screens together with an animation, wrap
the `Image` widget on both screens in a `Hero` widget.
The `Hero` widget requires two arguments:

<dl>
  <dt>`tag`</dt>
  <dd>An object that identifies the `Hero`.
      It must be the same on both screens.</dd>
  <dt>`child`</dt>
  <dd>The widget to animate across screens.</dd>
</dl>

{% comment %}
RegEx removes the first "child" property name and removed the trailing comma at the end
{% endcomment %}
<?code-excerpt "lib/main.dart (Hero1)" replace="/^child: //g;/,$//g"?>
```dart
Hero(
  tag: 'imageHero',
  child: Image.network(
    'https://picsum.photos/250?image=9',
  ),
)
```

## 3. Add a `Hero` widget to the second screen

To complete the connection with the first screen,
wrap the `Image` on the second screen with a `Hero`
widget that has the same `tag` as the `Hero` in the first screen.

After applying the `Hero` widget to the second screen,
the animation between screens just works.

{% comment %}
RegEx removes the first "child" property name and removed the trailing comma at the end
{% endcomment %}
<?code-excerpt "lib/main.dart (Hero2)" replace="/^child: //g;/,$//g"?>
```dart
Hero(
  tag: 'imageHero',
  child: Image.network(
    'https://picsum.photos/250?image=9',
  ),
)
```


{{site.alert.note}}
  This code is identical to what you have on the first screen.
  As a best practice, create a reusable widget instead of
  repeating code. This example uses identical code for both
  widgets, for simplicity.
{{site.alert.end}}

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() => runApp(HeroApp());

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transition Demo',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen();
          }));
        },
        child: Hero(
          tag: 'imageHero',
          child: Image.network(
            'https://picsum.photos/250?image=9',
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              'https://picsum.photos/250?image=9',
            ),
          ),
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/hero.gif" alt="Hero demo" class="site-mobile-screenshot" />
</noscript>


[Handle taps]: /docs/cookbook/gestures/handling-taps
[`Hero`]: {{site.api}}/flutter/widgets/Hero-class.html
[Navigate to a new screen and back]: /docs/cookbook/navigation/navigation-basics
