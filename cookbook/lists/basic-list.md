---
layout: page
title: "Basic List"
permalink: /cookbook/lists/basic-list/
---

Displaying lists of data is a fundamental pattern for mobile apps. Flutter 
includes the [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html)
Widget to make working with lists a breeze!

## Create a ListView 

Using the standard `ListView` constructor is perfect for lists that contain only 
a few items. We will also employ the built-in `ListTile` Widget to give our 
items a visual structure.

```dart
new ListView(
  children: <Widget>[
    new ListTile(
      leading: new Icon(Icons.map),
      title: new Text('Map'),
    ),
    new ListTile(
      leading: new Icon(Icons.photo_album),
      title: new Text('Album'),
    ),
    new ListTile(
      leading: new Icon(Icons.phone),
      title: new Text('Phone'),
    ),
  ],
);
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';
    
    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.map),
              title: new Text('Map'),
            ),
            new ListTile(
              leading: new Icon(Icons.photo_album),
              title: new Text('Album'),
            ),
            new ListTile(
              leading: new Icon(Icons.phone),
              title: new Text('Phone'),
            ),
          ],
        ),
      ),
    );
  }
}
```

![Basic List Demo](/images/cookbook/basic-list.png)
