---
layout: page
title: Assets and Images
permalink: /assets-and-images/
---

Flutter applications include both code and assets (sometimes called resources).
Assets can include static data, configuration files, or anything else an
application needs to function; in particular, assets include icons and other
images displayed in the UI.

## Specifying assets

Flutter uses the `flutter.yaml` file to identify assets required by an
application, as shown in the [Tutorial](/tutorial/). A typical `flutter.yaml`
file might include something like the following:

    assets:
      - assets/my_icon.png
      - assets/background.png

The `assets` section specify files that should be included with the application. Flutter
places them in a special archive called the _asset bundle_, which applications
can read from at runtime.

The main difference between these sections is that Flutter knows how to find
[Material Design icons](https://design.google.com/icons/) by their logical
name. The `assets` section on the other hand lists explicit paths (relative to
the `flutter.yaml` file) where the asset files are located.

### Asset variants

The build process supports the notion of asset variants: different versions of
an asset that might be displayed in different contexts. When an asset's path is
specified in the `assets` section of `flutter.yaml`, the build process looks for
any files with the same name in adjacent subdirectories. Such files are then
included in the asset bundle along with the specified asset.

For example, if you have the following assets:

    assets/background.png
    assets/dark/background.png

and your `flutter.yaml` file contains:

    assets:
      - assets/background.png

then both `assets/background.png` and `assets/dark/background.png` will be
included in your asset bundle. The former is considered the _main asset_, while
the latter is considered a _variant_.

Flutter uses asset variants when choosing resolution appropriate images; see
below. In the future, this mechanism may be extended to include variants for
different locales or regions, reading directions, etc.

## Working with assets

Your application can access its assets through the
[AssetBundle](http://docs.flutter.io/flutter/services/AssetBundle-class.html)
interface. The two main methods on an asset bundle allow you to load a string
(`loadString`) or an image (`loadImage`) out of the bundle, given a logical key.
The logical key maps to the path to the asset specified in the `flutter.yaml`
file at build time. The application's asset bundle is accessible through the
[DefaultAssetBundle](http://docs.flutter.io/flutter/widgets/DefaultAssetBundle/of.html)
widget's `of` method.

For example, the dark background from the example above could be loaded in a
widget's `build` method like so:

    Widget build(BuildContext context) {
      ...
      String name = 'assets/dark/background.png';
      ImageResource image = DefaultAssetBundle.of(context).loadImage(name);
      ...
    }

As a convenience, the
[AssetImage](http://docs.flutter.io/flutter/widgets/AssetImage-class.html)
widget provides a simple way to display an image in the UI.  Images may also
be specified as the background in a
[DecoratedBox](http://docs.flutter.io/flutter/widgets/DecoratedBox-class.html).

## Resolution awareness

Flutter can load resolution-appropriate images for the current device
pixel ratio.

[AssetImage](http://docs.flutter.io/flutter/widgets/AssetImage-class.html)
understands how to map a logical requested asset onto one that most
closely matches the current device pixel ratio. In order for this mapping to
work, assets should be arranged according to a particular directory structure:

    .../image.png
    .../Mx/image.png
    .../Nx/image.png
    ...etc.

Where M and N are numeric identifiers that correspond to the nominal resolution
of the images contained within. The main asset is assumed to correspond to a
resolution of 1.0. For example, consider the following asset layout for an
image named `my_icon.png`:

    .../my_icon.png
    .../2.0x/my_icon.png
    .../3.0x/my_icon.png

On devices with a device pixel ratio of 1.8, the asset `.../2.0x/my_icon.png`
would be chosen. For a device pixel ratio of 2.7, the asset
`.../3.0x/my_icon.png` would be chosen.

If the width and height of the rendered image are not specified, the nominal
resolution is used to scale the asset so that it will occupy the same amount
of screen space as the main asset would have, just with a higher resolution.
That is, if `.../my_icon.png` is 72px by 72px, then `.../3.0x/my_icon.png`
should be 216px by 216px; but they both will render into 72px by 72px
(in logical pixels) if width and height are not specified.

The way this works is through an object called
[AssetVendor](http://docs.flutter.io/flutter/widgets/AssetVendor-class.html)
established at the top of the build tree. AssetVendor replaces the default asset
bundle, so anything using the default asset bundle will inherit resolution
awareness when loading images.  (If you work with some of the lower level
classes, like
[ImageResource](http://docs.flutter.io/flutter/services/ImageResource-class.html)
or
[ImageCache](http://docs.flutter.io/flutter/services/ImageCache-class.html),
you'll also notice parameters related to scale.)

Some caveats:

* If you're not using
  [MaterialApp](http://docs.flutter.io/flutter/material/MaterialApp-class.html)
  in your application, and you want to use resolution awareness, you'll need to
  establish your own AssetVendor in your build logic. (This may change, please see
  [this issue](https://github.com/flutter/flutter/issues/1346).)
* If you want establish a your own
  [MediaQuery](http://docs.flutter.io/flutter/widgets/MediaQuery-class.html) or
  [DefaultAssetBundle](http://docs.flutter.io/flutter/widgets/DefaultAssetBundle-class.html)
  below the root of the widget hierarchy, the root-level AssetVendor won't be
  aware of the change.  If you want resolution awareness with the new MediaQuery
  or DefaultAssetBundle you specify, you'll need to create an AssetVendor at
  that point in the tree as well.

You can see an example
([examples/widgets.dart](https://github.com/flutter/flutter/tree/master/examples/widgets))
from the flutter repo.
Run `flutter run -t resolution_awareness.dart` to see it in action.
