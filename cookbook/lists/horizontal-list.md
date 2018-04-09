---
layout: page
title: "Create a horizontal list"
permalink: /cookbook/lists/horizontal-list/
---

At times, you may want to create a List that scrolls horizontally rather than 
vertically. The [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html) 
Widget supports horizontal lists out of the box.

We'll use the standard `ListView` constructor, passing through a horizontal 
`scrollDirection`, which will override the default vertical direction.

```dart
new ListView(
  // This next line does the trick.
  scrollDirection: Axis.horizontal,
  children: <Widget>[
    new Container(
      width: 160.0,
      color: Colors.red,
    ),
    new Container(
      width: 160.0,
      color: Colors.blue,
    ),
    new Container(
      width: 160.0,
      color: Colors.green,
    ),
    new Container(
      width: 160.0,
      color: Colors.yellow,
    ),
    new Container(
      width: 160.0,
      color: Colors.orange,
    ),
  ],
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Horizontal List';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Container(
          margin: new EdgeInsets.symmetric(vertical: 20.0),
          height: 200.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              new Container(
                width: 160.0,
                color: Colors.red,
              ),
              new Container(
                width: 160.0,
                color: Colors.blue,
              ),
              new Container(
                width: 160.0,
                color: Colors.green,
              ),
              new Container(
                width: 160.0,
                color: Colors.yellow,
              ),
              new Container(
                width: 160.0,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

![Horizontal List Demo](/images/cookbook/horizontal-list.gif)