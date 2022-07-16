---
title: Work with cached images
description: How to work with cached images.
prev:
  title: Fade in images with a placeholder
  path: /cookbook/images/fading-in-images
next:
  title: Use lists
  path: /cookbook/lists/basic-list
---

<?code-excerpt path-base="cookbook/images/cached_images"?>

In some cases, it's handy to cache images as they're downloaded from the
web, so they can be used offline. For this purpose,
use the [`cached_network_image`][] package.

In addition to caching, the `cached_network_image`
package also supports placeholders and fading images
in as they're loaded.

<?code-excerpt "lib/simple.dart (SimpleCachedImage)" replace="/^return //g"?>
```dart
CachedNetworkImage(
  imageUrl: 'https://picsum.photos/250?image=9',
);
```

## Adding a placeholder

The `cached_network_image` package allows you to use any widget as a
placeholder. In this example, display a spinner while the image loads.

<?code-excerpt "lib/main.dart (CachedNetworkImage)" replace="/^child\: //g"?>
```dart
CachedNetworkImage(
  placeholder: (context, url) => const CircularProgressIndicator(),
  imageUrl: 'https://picsum.photos/250?image=9',
),
```

## Complete example

<?code-excerpt "lib/main.dart"?>
```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Cached Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Center(
          child: CachedNetworkImage(
            placeholder: (context, url) => const CircularProgressIndicator(),
            imageUrl: 'https://picsum.photos/250?image=9',
          ),
        ),
      ),
    );
  }
}
```


[`cached_network_image`]: {{site.pub-pkg}}/cached_network_image
