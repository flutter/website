---
title: Display images from the internet
description: How to display images from the internet.
prev:
  title: Implement swipe to dismiss
  path: /docs/cookbook/gestures/dismissible
next:
  title: Fade in images with a placeholder
  path: /docs/cookbook/images/fading-in-images
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

Displaying images is fundamental for most mobile apps.
Flutter provides the [`Image`][] widget to
display different types of images.

To work with images from a URL, use the
[`Image.network()`][] constructor.

<!-- skip -->
```dart
Image.network('https://picsum.photos/250?image=9')
```

## Bonus: animated gifs

One useful thing about the `Image` widget:
It supports animated gifs.

<!-- skip -->
```dart
Image.network('https://github.com/flutter/plugins/raw/master/packages/video_player/video_player/doc/demo_ipod.gif?raw=true');
```

## Placeholders and caching

The default `Image.network` constructor doesn't handle more advanced
functionality, such as fading images in after loading, or caching images
to the device after they're downloaded. To accomplish these tasks, see
the following recipes:

* [Fade in images with a placeholder][]
* [Work with cached images][]

## Interactive example

```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
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
        body: Image.network('https://picsum.photos/250?image=9'),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/network-image.png" alt="Network image demo" class="site-mobile-screenshot" />
</noscript>


[Fade in images with a placeholder]: /docs/cookbook/images/fading-in-images
[`Image`]: {{site.api}}/flutter/widgets/Image-class.html
[`Image.network()`]: {{site.api}}/flutter/widgets/Image/Image.network.html
[Work with cached images]: /docs/cookbook/images/cached-images
