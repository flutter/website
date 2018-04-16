---
layout: page
title: "Display images from the internet"
permalink: /cookbook/images/network-image/
---

Displaying images is fundamental for most mobile apps. Flutter provides the 
[`Image`](https://docs.flutter.io/flutter/widgets/Image-class.html) Widget to 
display different types of images.

In order to work with images from the web, use the [`Image.network`](https://docs.flutter.io/flutter/widgets/Image/Image.network.html) 
constructor.

```dart
new Image.network(
  'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
)
```

## Bonus: Animated Gifs

One amazing thing about the `Image` Widget: It also supports animated gifs out
of the box!

```dart
new Image.network(
  'https://github.com/flutter/plugins/raw/master/packages/video_player/doc/demo_ipod.gif?raw=true',
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return new MaterialApp(
      title: title,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Image.network(
          'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
        ),
      ),
    );
  }
}
```
