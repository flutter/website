---
layout: page
title: Using Custom Fonts
sidebar: home_sidebar
permalink: /custom-fonts/
---

You can use custom fonts in your Flutter application by including them in your
`flutter.yaml` file under the `fonts` heading:

```yaml
fonts:
  - family: Raleway
    fonts:
      - asset: assets/fonts/Raleway-Regular.ttf
      - asset: assets/fonts/Raleway-Medium.ttf
        weight: 500
      - asset: assets/fonts/Raleway-SemiBold.ttf
        weight: 600
  - family: AbrilFatface
    fonts:
      - asset: assets/fonts/abrilfatface/AbrilFatface-Regular.ttf
```

The `family` determines the name of the font, which you can use in the
[`fontFamily`](https://docs.flutter.io/flutter/painting/TextStyle/fontFamily.html)
property of a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
object to use the font with a [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html)
or a [`RichText`](https://docs.flutter.io/flutter/widgets/RichText-class.html)
widget.

The `asset` is a path to the font file, relative to the `flutter.yaml` file.
These files contain the outlines for the glyphs in the font. When building your
app, these files are included in your app's asset bundle.

A single font can reference many different files with different outline weights
and styles:

  * The `weight` property specifies the weight of the outlines in the file as an
    integer multiple of 100 between 100 and 900. These values correspond to the
    [`FontWeight`](https://docs.flutter.io/flutter/dart-ui/FontWeight-class.html)
    and can be used in the [`fontWeight`](https://docs.flutter.io/flutter/painting/TextStyle/fontWeight.html)
    property of a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
    object.

  * The `style` property specfies whether the outlines in the file are
    `italic` or `normal`. These values correspond to the
    [`FontStyle`](https://docs.flutter.io/flutter/dart-ui/FontStyle-class.html)
    and can be used in the [fontStyle](https://docs.flutter.io/flutter/material/TextStyle/fontStyle.html)
    property of a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
    object.

If a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
object specifies a weight or style for which is there is no exact font file, the
engine uses one of the more generic files for the font and attempts to
extrapolate outlines for the requested weight and style.
