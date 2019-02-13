---
title: Basic List
prev:
  title: Working with cached images
  path: /docs/cookbook/images/cached-images
next:
  title: Create a horizontal list
  path: /docs/cookbook/lists/horizontal-list
---

Displaying lists of data is a fundamental pattern for mobile apps. Flutter
includes the [`ListView`]({{site.api}}/flutter/widgets/ListView-class.html)
Widget to make working with lists a breeze!

## Create a ListView

Using the standard `ListView` constructor is perfect for lists that contain only
a few items. We will also employ the built-in
[`ListTile`]({{site.api}}/flutter/material/ListTile-class.html)
Widget to give our items a visual structure.

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

## Complete example

```dart
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

![Basic List Demo](/images/cookbook/basic-list.png){:.site-mobile-screenshot}
