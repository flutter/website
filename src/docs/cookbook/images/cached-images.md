---
title: Work with cached images
description: How to work with cached images.
prev:
  title: Fade in images with a placeholder
  path: /docs/cookbook/images/fading-in-images
next:
  title: Use lists
  path: /docs/cookbook/lists/basic-list
---

In some cases, it's handy to cache images as they're downloaded from the
web, so they can be used offline. For this purpose,
use the [`cached_network_image`][] package.

In addition to caching, the `cached_network_image`
package also supports placeholders and fading images
in as they're loaded.

<!-- skip -->
```dart
CachedNetworkImage(
  imageUrl: 'https://picsum.photos/250?image=9',
);
```

## Adding a placeholder

The `cached_network_image` package allows you to use any widget as a
placeholder. In this example, display a spinner while the image loads.

<!-- skip -->
```dart
CachedNetworkImage(
  placeholder: (context, url) => CircularProgressIndicator(),
  imageUrl: 'https://picsum.photos/250?image=9',
);
```

## Complete example

<!-- skip -->
```dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Cached Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:
                'https://picsum.photos/250?image=9',
          ),
        ),
      ),
    );
  }
}
```


[`cached_network_image`]: {{site.pub-pkg}}/cached_network_image
