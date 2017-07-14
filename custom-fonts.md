---
layout: page
title: Using Fonts

permalink: /custom-fonts/
---

## Introduction

You can use different fonts in your Flutter application.
For example, you may have a custom font that your designer created,
or you may have a font from [Google Fonts](https://fonts.google.com/).

This page describes how to configure fonts for your Flutter app,
and use them when rendering text.


## Using fonts

Using fonts in your Flutter application is done in two steps. 
First declare them in your `pubspec.yaml`, 
second use the font with a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) property.

### Declaring in the font asset

First declare your font like in the `pubspec.yaml` example below.
Then copy the font file to the location specified in your `pubspec.yaml`.

```yaml
flutter:
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

### Using the font

Second use the font by creating a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html). 
Then set the [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) `fontFamily` property 
and use the font family specified in the `pubsec.yaml` declarations. 

```
// declare the text style
const textStyle = const TextStyle(
  fontFamily: 'Raleway',
);

// use the text style
var buttonText = const Text(
  "Use the font for this text",
  style: textStyle,
);
```

## Using the included Material Design fonts

When you want to use the Material Design fonts,
they can be simply included by adding a property `uses-material-design: true` to the `pubspec.yaml` file.

```
flutter:
  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the Icons class.
  uses-material-design: true
```

### Included Material Design fonts

Here are the included fonts that come with `uses-material-design: true`.

| Font | Features |
| ---- | -------- |
| Roboto-Regular.ttf | |
| Roboto-Italic.ttf | italic |
| Roboto-Thin.ttf | 100 |
| Roboto-ThinItalic.ttf | 100, italic |
| Roboto-Light.ttf | 300 |
| Roboto-LightItalic.ttf | 300, italic |
| Roboto-Medium.ttf | 500 |
| Roboto-MediumItalic.ttf | 500, italic |
| Roboto-Bold.ttf | 700 |
| Roboto-BoldItalic.ttf | 700, italic |
| Roboto-Black.ttf | 900 |
| Roboto-BlackItalic.ttf | 900, italic |
| &nbsp; | &nbsp; |
| RobotoCondensed-Regular.ttf | |
| RobotoCondensed-Italic.ttf | italic |
| RobotoCondensed-Light.ttf | 300 |
| RobotoCondensed-LightItalic.ttf | 300, italic |
| RobotoCondensed-Bold.ttf | 700 |
| RobotoCondensed-BoldItalic.ttf | 700, italic |

Check out the [material_fonts.yaml](https://github.com/flutter/flutter/blob/master/packages/flutter_tools/schema/material_fonts.yaml) 
to view all the included fonts.

## pubspec.yaml option definitions

The `family` determines the name of the font, which you can use in the
[`fontFamily`](https://docs.flutter.io/flutter/painting/TextStyle/fontFamily.html)
property of a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
object to use the font with a [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html)
or a [`RichText`](https://docs.flutter.io/flutter/widgets/RichText-class.html)
widget.

The `asset` is a path to the font file, relative to the `pubspec.yaml` file.
These files contain the outlines for the glyphs in the font. When building your app, 
these files are included in your app's asset bundle.

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
    and can be used in the [fontStyle](https://docs.flutter.io/flutter/painting/TextStyle/fontStyle.html)
    property of a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
    object.

## TextStyle

If a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
object specifies a weight or style for which is there is no exact font file, the
engine uses one of the more generic files for the font and attempts to
extrapolate outlines for the requested weight and style.

