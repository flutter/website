---
layout: page
title: Resolution Aware Images
permalink: /resolution-aware-images/
---

Flutter can load resolution-appropriate images for the current device
pixel ratio.

AssetImage understands how to map a logical requested asset onto one that most
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

*Tip*: Remember to declare your resources inside `flutter.yaml`,
as shown in the [Tutorial](/tutorial/). Flutter's build phase automatically
picks up any asset variants in subfolders that have the same name as a main
asset. For example, if you declare `my_icon.png` in `flutter.yaml`,
the build phase
automatically includes `2.0x/my_icon.png` and `3.0x/my_icon.png` in the
asset bundle.

On devices with a device pixel ratio of 1.8, the asset `.../2.0x/my_icon.png`
would be chosen. For a device pixel ratio of 2.7, the asset
`.../3.0x/my_icon.png` would be chosen.

If the width and height of the rendered image are not specified, the nominal
resolution is used to scale the asset so that it will occupy the same amount
of screen space as the main asset would have, just with a higher resolution.
That is, if `.../my_icon.png` is 72px by 72px, then `.../3.0x/my_icon.png`
should be 216px by 216px; but they both will render into 72px by 72px
(in logical pixels) if width and height are not specified.

The way this works is through an object called AssetVendor established at the
top of the build tree.  AssetVendor replaces the default asset bundle, so
really anything using the default asset bundle will inherit resolution awareness
when loading images.  If you work with some of the lower level classes, like
ImageResource or ImageCache, you'll also notice parameters related
to scale.

Some caveats:

* If you're not using MaterialApp in your application, and you want to use
  resolution awareness, you'll need to establish your own AssetVendor in your
  build logic. (This may change, please see
  [this issue](https://github.com/flutter/flutter/issues/1346).)
* If for some reason you establish a custom MediaQuery or DefaultAssetBundle
  farther down in the widget hierarchy, the top-level AssetVendor won't be aware
  of the change.  If you want resolution awareness with the new MediaQuery or
  DefaultAssetBundle you specify, you'll need to create an AssetVendor at that
  point in the tree as well.

You can see an example
([examples/widgets.dart](https://github.com/flutter/flutter/tree/master/examples/widgets))
from the flutter repo.
Run `flutter start -t resolution_awareness.dart` to see it in action.