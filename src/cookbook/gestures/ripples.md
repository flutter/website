---
title: Add Material touch ripples
description: How to implement ripple animations.
prev:
  title: Retrieve the value of a text field
  path: /cookbook/forms/retrieve-input
next:
  title: Handle taps
  path: /cookbook/gestures/handling-taps
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="cookbook/gestures/ripples/"?>

{% comment %}
prev:
  title: Focus and text fields
  path: /cookbook/forms/focus
{% endcomment %}

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
    padding: EdgeInsets.all(12.0),
    child: Text('Flat Button'),
  ),
)
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
  const MyButton({Key? key}) : super(key: key);

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
        padding: EdgeInsets.all(12.0),
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
