---
layout: page
title: "Working with cached images"
---

In some cases, it can be handy to cache images as they're downloaded from the 
web so they can be used offline. For this purpose, we'll employ the 
[`cached_network_image`](https://pub.dartlang.org/packages/cached_network_image)
package.

In addition to caching, the cached_image_network package also supports 
placeholders and fading images in as they're loaded! 

<!-- skip -->
```dart
CachedNetworkImage(
  imageUrl: 'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true',
);
```

## Adding a placeholder

The `cached_network_image` package allows us to use any Widget as a placeholder! 
In this example, we'll display a spinner while the image loads.

<!-- skip -->
```dart
CachedNetworkImage(
  placeholder: CircularProgressIndicator(),
  imageUrl: 'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true',
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
            placeholder: CircularProgressIndicator(),
            imageUrl:
                'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true',
          ),
        ),
      ),
    );
  }
}
```
