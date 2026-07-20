---
title: Fade in images with a placeholder
description: How to fade images into view.
---

<?code-excerpt path-base="cookbook/images/fading_in_images"?>

When displaying images using the default `Image` widget,
you might notice they simply pop onto the screen as they're loaded.
This might feel visually jarring to your users.

Instead, wouldn't it be nice to display a placeholder at first,
and images would fade in as they're loaded? Use the
[`FadeInImage`][] widget for exactly this purpose.

`FadeInImage` works with images of any type: in-memory, local assets,
or images from the internet.

## In-memory

Complete the following steps to use a
one-pixel transparent PNG as the placeholder.

1.  **Create the transparent image data.**

    Import `dart:convert` and `dart:typed_data`,
    then decode the image from a Base64-encoded string:

    <?code-excerpt "lib/memory_main.dart (TransparentImage)" plaster="none"?>
    ```dart
    import 'dart:convert';
    import 'dart:typed_data';
    final Uint8List transparentImage = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4'
      'nGMAAQAABQABDQottAAAAABJRU5ErkJggg==',
    );
    ```

1.  **Use the image data as a placeholder.**

    Pass the decoded image data to the `placeholder` parameter:

    <?code-excerpt "lib/memory_main.dart (MemoryNetwork)" replace="/^child\: //g"?>
    ```dart
    FadeInImage.memoryNetwork(
      placeholder: transparentImage,
      image: 'https://picsum.photos/250?image=9',
    ),
    ```

{:.steps}

### Complete example

<?code-excerpt "lib/memory_main.dart"?>
```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

final Uint8List transparentImage = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4'
  'nGMAAQAABQABDQottAAAAABJRU5ErkJggg==',
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Fade in images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Stack(
          children: <Widget>[
            const Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: transparentImage,
                image: 'https://picsum.photos/250?image=9',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

![Fading In Image Demo](/assets/images/docs/cookbook/fading-in-images.webp){:.site-mobile-screenshot}

## From asset bundle

Complete the following steps to use a
local image asset as the placeholder.

1.  **Add the placeholder to the asset bundle.**

    Add a placeholder image to the project's `assets` directory,
    such as `assets/loading.gif`.
    Then, declare the asset in the project's `pubspec.yaml` file.
    For more details, see [Adding assets and images][].

    ```yaml diff
      flutter:
        assets:
    +     - assets/loading.gif
    ```

1.  **Use the asset as a placeholder.**

    Pass the asset path to the `placeholder` parameter of
    the [`FadeInImage.assetNetwork`][] constructor:

    <?code-excerpt "lib/asset_main.dart (AssetNetwork)" replace="/^child\: //g"?>
    ```dart
    FadeInImage.assetNetwork(
      placeholder: 'assets/loading.gif',
      image: 'https://picsum.photos/250?image=9',
    ),
    ```

{:.steps}

### Complete example

<?code-excerpt "lib/asset_main.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Fade in images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Center(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: 'https://picsum.photos/250?image=9',
          ),
        ),
      ),
    );
  }
}
```

![Asset fade-in](/assets/images/docs/cookbook/fading-in-asset-demo.webp){:.site-mobile-screenshot}


[Adding assets and images]: /ui/assets/assets-and-images
[`FadeInImage`]: {{site.api}}/flutter/widgets/FadeInImage-class.html
[`FadeInImage.assetNetwork`]: {{site.api}}/flutter/widgets/FadeInImage/FadeInImage.assetNetwork.html
