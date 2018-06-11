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

## In-Memory

In this example, we'll use the [transparent_image](https://pub.dartlang.org/packages/transparent_image)
package for a simple transparent placeholder.

<!-- skip -->
```dart
FadeInImage.memoryNetwork(
  placeholder: kTransparentImage,
  image: 'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
);
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Fade in images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
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

### From Asset Bundle

You can also consider using local assets for placeholders. First, add the asset
to the project’s _pubspec.yaml_ file:

<!-- skip -->
```diff
 flutter:
   assets:
+    - assets/loading.gif
```

(See [Assets and Images](/assets-and-images/) for a full guide to adding assets.)

Then, use the [`FadeInImage.assetNetwork`](https://docs.flutter.io/flutter/widgets/FadeInImage/FadeInImage.assetNetwork.html)
constructor:

<!-- skip -->
```dart
FadeInImage.assetNetwork(
  placeholder: 'assets/loading.gif',
  image: 'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
);
```

### Complete Example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Fade in images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image:
                'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
          ),
        ),
      ),
    );
  }
}
```

<img alt="Demo of asset fading in" height="566" src="/images/cookbook/fading-in-asset-demo.gif" width="318" />
