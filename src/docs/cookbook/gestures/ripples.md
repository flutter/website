---
title: Add Material touch ripples
description: How to implement ripple animations.
prev:
  title: Create an expandable FAB 
  path: /docs/cookbook/effects/expandable-fab
next:
  title: Handle taps
  path: /docs/cookbook/gestures/handling-taps
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

{% comment %}
prev:
  title: Focus and text fields
  path: /docs/cookbook/forms/focus
{% endcomment %}

Widgets that follow the Material Design guidelines display
a ripple animation when tapped.

Flutter provides the [`InkWell`][]
widget to perform this effect.
Create a ripple effect using the following steps:

  1. Create a widget that supports tap.
  2. Wrap it in an `InkWell` widget to manage tap callbacks and
     ripple animations.

<!-- skip -->
```dart
// The InkWell wraps the custom flat button widget.
InkWell(
  // When the user taps the button, show a snackbar.
  onTap: () {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Tap'),
    ));
  },
  child: Container(
    padding: EdgeInsets.all(12.0),
    child: Text('Flat Button'),
  ),
);
```

## Interactive example

```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'InkWell Demo';

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
    // The InkWell wraps the custom flat button widget.
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Tap'),
        ));
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Text('Flat Button'),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/ripples.gif" alt="Ripples Demo" class="site-mobile-screenshot" />
</noscript>


[`InkWell`]: {{site.api}}/flutter/material/InkWell-class.html
