---
title: Add Material touch ripples
description: How to implement ripple animations.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/gestures/ripples/"?>

Widgets that follow the Material Design guidelines display
a ripple animation when tapped.

Flutter provides the [`InkWell`][]
widget to perform this effect.
Create a ripple effect using the following steps:

  1. Create a widget that supports tap.
  2. Wrap it in an `InkWell` widget to manage tap callbacks and
     ripple animations.

<?code-excerpt "lib/main.dart (InkWell)" replace="/return //g;/;$//g"?>
```dart
// The InkWell wraps the custom flat button widget.
InkWell(
  // When the user taps the button, show a snackbar.
  onTap: () {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Tap'),
    ));
  },
  child: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Flat Button'),
  ),
)
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad run="true"
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'InkWell Demo';

    return const MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: MyButton(),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    // The InkWell wraps the custom flat button widget.
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Tap'),
        ));
      },
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Text('Flat Button'),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/ripples.gif" alt="Ripples Demo" class="site-mobile-screenshot" />
</noscript>


[`InkWell`]: {{site.api}}/flutter/material/InkWell-class.html
