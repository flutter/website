---
layout: page
title: Adding Assets and Images in Flutter

permalink: /assets-and-images/
---

* TOC Placeholder
{:toc}

## Introduction

Flutter apps can include both code and _assets_ (sometimes called
resources). An asset is a file that is bundled and deployed with your
app, and is accessible at runtime. Common types of assets include
static data (for example, JSON files), configuration files, icons, and
images.

## Specifying assets

Flutter uses
the [`pubspec.yaml`](https://www.dartlang.org/tools/pub/pubspec) file,
located at the root of your project, to identify assets required by an
app.

Here is an example:

```yaml
flutter:
  assets:
    - assets/my_icon.png
    - assets/background.png
```

The `assets` subsection of the `flutter` section specifies files that
should be included with the app. Each asset is identified by an
explicit path (relative to the `pubspec.yaml` file) where the asset
file is located. The order in which the assets are declared does not
matter. The actual directory used (`assets` in this case) does not
matter.

During a build, Flutter places assets into a special archive called
the _asset bundle_, which apps can read from at runtime.

### Asset variants

The build process supports the notion of asset variants: different
versions of an asset that might be displayed in different contexts.
When an asset's path is specified in the `assets` section of
`pubspec.yaml`, the build process looks for any files with the same
name in adjacent subdirectories. Such files are then included in the
asset bundle along with the specified asset.

For example, if you have the following files in your application
directory:

* .../pubspec.yaml
* .../graphics/my_icon.png
* .../graphics/background.png
* .../graphics/dark/background.png
* ...etc.

...and your `pubspec.yaml` file contains:

```yaml
flutter:
  assets:
    - graphics/background.png
```

...then both `graphics/background.png` and `graphics/dark/background.png`
will be included in your asset bundle. The former is considered the
_main asset_, while the latter is considered a _variant_.

Flutter uses asset variants when choosing resolution appropriate
images; see below. In the future, this mechanism may be extended to
include variants for different locales or regions, reading directions,
etc.

## Loading assets

Your app can access its assets through an
[`AssetBundle`](https://docs.flutter.io/flutter/services/AssetBundle-class.html)
object.

The two main methods on an asset bundle allow you to load a
string/text asset (`loadString`) or an image/binary asset (`load`) out
of the bundle, given a logical key. The logical key maps to the path
to the asset specified in the `pubspec.yaml` file at build time.

### Loading text assets

Each Flutter app has a
[`rootBundle`](https://docs.flutter.io/flutter/services/rootBundle.html)
object for easy access to the main asset bundle. It is possible to
load assets directly using the `rootBundle` global static from
`package:flutter/services.dart`.

However, it's recommended to obtain the AssetBundle for the current
BuildContext using
[`DefaultAssetBundle`](https://docs.flutter.io/flutter/widgets/DefaultAssetBundle-class.html).
Rather than the default asset bundle that was built with the app, this
approach enables a parent widget to substitute a different AssetBundle
at run time, which can be useful for localization or testing
scenarios.

Typically, you'll use `DefaultAssetBundle.of()` to indirectly load an
asset, for example a JSON file, from the app's runtime `rootBundle`.

{% comment %}

  Need example here to show obtaining the AssetBundle for the current
  BuildContext using DefaultAssetBundle.of

{% endcomment %}

Outside of a Widget context, or when a handle to an AssetBundle is not
available, you can use `rootBundle` to directly load such assets, 
for example:

```dart
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}
```

### Loading images

Flutter can load resolution-appropriate images for the current device
pixel ratio.

#### Declaring resolution-aware image assets

[`AssetImage`](https://docs.flutter.io/flutter/services/AssetImage-class.html)
understands how to map a logical requested asset onto one that most
closely matches the current [device pixel ratio](https://docs.flutter.io/flutter/dart-ui/Window/devicePixelRatio.html).
In order for this mapping to
work, assets should be arranged according to a particular directory structure:

* .../image.png
* .../Mx/image.png
* .../Nx/image.png
* ...etc.

...where _M_ and _N_ are numeric identifiers that correspond to the nominal resolution
of the images contained within, in other words, they specify the device pixel ratio that
the images are intended for.

The main asset is assumed to correspond to a
resolution of 1.0. For example, consider the following asset layout for an
image named `my_icon.png`:

* .../my_icon.png
* .../2.0x/my_icon.png
* .../3.0x/my_icon.png

On devices with a device pixel ratio of 1.8, the asset `.../2.0x/my_icon.png`
would be chosen. For a device pixel ratio of 2.7, the asset
`.../3.0x/my_icon.png` would be chosen.

If the width and height of the rendered image are not specified on the `Image` widget, the nominal
resolution is used to scale the asset so that it will occupy the same amount
of screen space as the main asset would have, just with a higher resolution.
That is, if `.../my_icon.png` is 72px by 72px, then `.../3.0x/my_icon.png`
should be 216px by 216px; but they both will render into 72px by 72px
(in logical pixels) if width and height are not specified.

Each entry in the asset section of the `pubspec.yaml` should correspond to a real file, with the 
exception of the main asset entry. If the main asset entry does not correspond
to a real file, then the asset with the lowest resolution will be used as the fallback
for devices with device pixel ratios below that resolution. The entry should still
be included in the `pubspec.yaml` manifest, however.

#### Loading images

To load an image, use the
[`AssetImage`](https://docs.flutter.io/flutter/services/AssetImage-class.html)
class in a widget's `build` method.

For example, your app can load the background image from the asset
declarations above:

```dart
Widget build(BuildContext context) {
  // ...
  return new DecoratedBox(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('graphics/background.png'),
        // ...
      ),
      // ...
    ),
  );
  // ...
}
```

Anything using the default asset bundle will inherit resolution
awareness when loading images. (If you work with some of the lower
level classes, like
[`ImageStream`](https://docs.flutter.io/flutter/services/ImageStream-class.html)
or
[`ImageCache`](https://docs.flutter.io/flutter/services/ImageCache-class.html),
you'll also notice parameters related to scale.)
