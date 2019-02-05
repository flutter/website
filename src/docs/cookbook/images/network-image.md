---
title: Display images from the internet
prev:
  title: Implement Swipe to Dismiss
  path: /docs/cookbook/gestures/dismissible
next:
  title: Fade in images with a placeholder
  path: /docs/cookbook/images/fading-in-images
---

Displaying images is fundamental for most mobile apps. Flutter provides the
[`Image`]({{site.api}}/flutter/widgets/Image-class.html) Widget to
display different types of images.

In order to work with images from a URL, use the
[`Image.network`]({{site.api}}/flutter/widgets/Image/Image.network.html)
constructor.

<!-- skip -->
```dart
Image.network(
  'https://picsum.photos/250?image=9',
)
```

## Bonus: Animated Gifs

One amazing thing about the `Image` Widget: It also supports animated gifs out
of the box!

<!-- skip -->
```dart
Image.network(
  'https://github.com/flutter/plugins/raw/master/packages/video_player/doc/demo_ipod.gif?raw=true',
);
```

## Placeholders and Caching

The default `Image.network` constructor does not handle more advanced
functionality, such as fading images in after loading or caching images
to the device after they're downloaded. To achieve these tasks, please see
the following recipes:

  * [Fade in images with a placeholder](/docs/cookbook/images/fading-in-images/)
  * [Working with cached images](/docs/cookbook/images/cached-images/)

## Complete example

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Image.network(
          'https://picsum.photos/250?image=9',
        ),
      ),
    );
  }
}
```

![Network Image Demo](/images/cookbook/network-image.png){:.site-mobile-screenshot}
