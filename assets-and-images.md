---
layout: page
title: Adding Assets and Images in Flutter
sidebar: home_sidebar
permalink: /assets-and-images/
---

* TOC Placeholder
{:toc}

## Introduction

Flutter apps can include both code and _assets_
(sometimes called resources). An asset is a file that is bundled
and deployed with your app, and is accessible at runtime.
Common types of assets include static data
(for example, JSON files), configuration files, icons,
and images.

## Specifying assets

Flutter uses the `flutter.yaml` file to identify assets required by an
app, as shown in the
[Introduction to Flutter's Widget Framework](/widgets-intro/).
A typical `flutter.yaml` file might include something like the following:

```yaml
assets:
  - assets/my_icon.png
  - assets/background.png
```

The `assets` section specifies files that should be included with the
app. Each asset is identified by an explicit path (relative
to the `flutter.yaml` file) where the asset file is located.

During a build, Flutter places assets into a special archive called
the _asset bundle_, which apps can read from at runtime.

### Asset variants

The build process supports the notion of asset variants: different versions of
an asset that might be displayed in different contexts. When an asset's path is
specified in the `assets` section of `flutter.yaml`, the build process looks for
any files with the same name in adjacent subdirectories. Such files are then
included in the asset bundle along with the specified asset.

For example, if you have the following assets:

```yaml
  - assets/my_icon.png
  - assets/background.png
```

and your `flutter.yaml` file contains:

```yaml
assets:
  - assets/background.png
```

then both `assets/background.png` and `assets/dark/background.png` will be
included in your asset bundle. The former is considered the _main asset_, while
the latter is considered a _variant_.

Flutter uses asset variants when choosing resolution appropriate images; see
below. In the future, this mechanism may be extended to include variants for
different locales or regions, reading directions, etc.

## Loading assets

Your app can access its assets through an
[`AssetBundle`](http://docs.flutter.io/flutter/services/AssetBundle-class.html)
object.

The two main methods on an asset bundle allow you to load a string/text asset
(`loadString`) or an image asset (`loadImage`) out of the bundle,
given a logical key.
The logical key maps to the path to the asset specified in the `flutter.yaml`
file at build time.

### Loading text assets

Each Flutter app has a
[`rootBundle`](http://docs.flutter.io/flutter/services/rootBundle.html)
object
for easy access to the main asset bundle. You can use the `rootBundle`
from `package:flutter/services.dart`
to easily load assets.

For example, use the `rootBundle` to easily
load a JSON file asset.

```dart
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}
```

### Loading image images

Flutter can load resolution-appropriate images for the current device
pixel ratio.

#### Declaring resolution-aware image assets

[`AssetImage`](http://docs.flutter.io/flutter/widgets/AssetImage-class.html)
understands how to map a logical requested asset onto one that most
closely matches the current device pixel ratio. In order for this mapping to
work, assets should be arranged according to a particular directory structure:


* .../image.png
* .../Mx/image.png
* .../Nx/image.png
* ...etc.

Where M and N are numeric identifiers that correspond to the nominal resolution
of the images contained within. The main asset is assumed to correspond to a
resolution of 1.0. For example, consider the following asset layout for an
image named `my_icon.png`:

* .../my_icon.png
* .../2.0x/my_icon.png
* .../3.0x/my_icon.png

On devices with a device pixel ratio of 1.8, the asset `.../2.0x/my_icon.png`
would be chosen. For a device pixel ratio of 2.7, the asset
`.../3.0x/my_icon.png` would be chosen.

If the width and height of the rendered image are not specified, the nominal
resolution is used to scale the asset so that it will occupy the same amount
of screen space as the main asset would have, just with a higher resolution.
That is, if `.../my_icon.png` is 72px by 72px, then `.../3.0x/my_icon.png`
should be 216px by 216px; but they both will render into 72px by 72px
(in logical pixels) if width and height are not specified.

#### Loading images

To load an image, use the
[`AssetImage`](https://docs.flutter.io/flutter/material/AssetImage-class.html)
class from inside of a widget's `build` method.

For example, your app can load the dark background image from the asset
declarations above:

```dart
Widget build(BuildContext context) {
  // ...
  return new DecoratedBox(
    decoration: new BoxDecoration(
      backgroundImage: new BackgroundImage(
        image: new AssetImage('my_asset.png'),
        // ...
      )
      // ...
    )
  );
  // ...
}
```

The way this works is through an object called
[`AssetVendor`](http://docs.flutter.io/flutter/widgets/AssetVendor-class.html)
established at the top of the build tree. AssetVendor replaces the default asset
bundle, so anything using the default asset bundle will inherit resolution
awareness when loading images.  (If you work with some of the lower level
classes, like
[`ImageResource`](http://docs.flutter.io/flutter/services/ImageResource-class.html)
or
[`ImageCache`](http://docs.flutter.io/flutter/services/ImageCache-class.html),
you'll also notice parameters related to scale.)

#### Caveats

* If you're not using
  [`MaterialApp`](http://docs.flutter.io/flutter/material/MaterialApp-class.html)
  or 
  [`WidgetsApp`](http://docs.flutter.io/flutter/widgets/WidgetsApp-class.html)
  in your app, and you want to use resolution awareness, you'll need to
  establish your own `AssetVendor` in your build logic.
* If you want establish a your own
  [`MediaQuery`](http://docs.flutter.io/flutter/widgets/MediaQuery-class.html) or
  [`DefaultAssetBundle`](http://docs.flutter.io/flutter/widgets/DefaultAssetBundle-class.html)
  below the root of the widget hierarchy, the root-level AssetVendor won't be
  aware of the change.  If you want resolution awareness with the new MediaQuery
  or DefaultAssetBundle you specify, you'll need to create an AssetVendor at
  that point in the tree as well.

You can see an example
([examples/widgets.dart](https://github.com/flutter/flutter/tree/master/examples/widgets))
from the flutter repo.
Run `flutter run -t resolution_awareness.dart` to see it in action.
