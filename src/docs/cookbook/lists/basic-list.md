---
title: Use lists
description: How to implement a list.
prev:
  title: Work with cached images
  path: /docs/cookbook/images/cached-images
next:
  title: Create a horizontal list
  path: /docs/cookbook/lists/horizontal-list
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

Displaying lists of data is a fundamental pattern for mobile apps.
Flutter includes the [`ListView`][]
widget to make working with lists a breeze.

## Create a ListView

Using the standard `ListView` constructor is
perfect for lists that contain only a few items.
The built-in [`ListTile`][]
widget is a way to give items a visual structure.

<!-- skip -->
```dart
ListView(
  children: <Widget>[
    ListTile(
      leading: Icon(Icons.map),
      title: Text('Map'),
    ),
    ListTile(
      leading: Icon(Icons.photo_album),
      title: Text('Album'),
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('Phone'),
    ),
  ],
);
```

## Interactive example

```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
            ),
          ],
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/basic-list.png" alt="Basic List Demo" class="site-mobile-screenshot" /> 
</noscript>


[`ListTile`]: {{site.api}}/flutter/material/ListTile-class.html
[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html
