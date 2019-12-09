---
title: Display images from the internet
prev:
  title: Implement swipe to dismiss
  path: /docs/cookbook/gestures/dismissible
next:
  title: Fade in images with a placeholder
  path: /docs/cookbook/images/fading-in-images
---

Displaying images is fundamental for most mobile apps.
Flutter provides the [`Image`][] widget to
display different types of images.

To work with images from a URL, use the
[`Image.network()`][] constructor.

<!-- skip -->
```dart
Image.network(
  'https://picsum.photos/250?image=9',
)
```

## Bonus: animated gifs

One useful thing about the `Image` widget:
It supports animated gifs.

<!-- skip -->
```dart
Image.network(
  'https://github.com/flutter/plugins/raw/master/packages/video_player/doc/demo_ipod.gif?raw=true',
);
```

## Placeholders and caching

The default `Image.network` constructor doesn't handle more advanced
functionality, such as fading images in after loading, or caching images
to the device after they're downloaded. To accomplish these tasks, see
the following recipes:

* [Fade in images with a placeholder][]
* [Working with cached images][]

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

![Network image demo](/images/cookbook/network-image.png){:.site-mobile-screenshot}


[Fade in images with a placeholder]: /docs/cookbook/images/fading-in-images
[`Image`]: {{site.api}}/flutter/widgets/Image-class.html
[`Image.network()`]: {{site.api}}/flutter/widgets/Image/Image.network.html
[Working with cached images]: /docs/cookbook/images/cached-images
