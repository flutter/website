---
layout: page
title: "Fade in images with a placeholder"
permalink: /cookbook/images/fading-in-images/
---

When displaying images using the default `Image` widget, you might notice they 
simply pop onto the screen as they're loaded. This might feel visually jarring
to your users.

Instead, wouldn't it be nice if you could display a placeholder at first, and 
images would fade in as they're loaded? We can use the [`FadeInImage`](https://docs.flutter.io/flutter/widgets/FadeInImage-class.html) 
Widget packaged with Flutter for exactly this purpose!

`FadeInImage` works with images of any type: in-memory, local assets, or images 
from the internet.

In this example, we'll use the [transparent_image](https://pub.dartlang.org/packages/transparent_image)
package for a simple transparent placeholder. You can also consider using local
assets for placeholders by following the [Assets and Images](/assets-and-images/)
guide.

```dart
new FadeInImage.memoryNetwork(
  placeholder: kTransparentImage,
  image: 'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
);
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Fade in images';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Stack(
          children: <Widget>[
            new Center(child: new CircularProgressIndicator()),
            new Center(
              child: new FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                    'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

![Fading In Image Demo](/images/cookbook/fading-in-images.gif)