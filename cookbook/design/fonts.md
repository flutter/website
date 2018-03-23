---
layout: page
title: "Using custom fonts"
permalink: /cookbook/design/fonts/
---

While Android and iOS offer high quality system fonts, one of the most common
requests from designers is to use custom fonts! For example, we may have a 
custom-built font from our designer or downloaded a font from 
[Google Fonts](https://fonts.google.com/).

Flutter works out of the box with custom fonts. We can apply fonts across an
entire app or to individual Widgets. 

## Directions

  1. Import the font files
  2. Declare the font in the `pubspec.yaml`
  3. Set a font as the default 
  4. Use a font in a specific Widget
  
## 1. Import the font files

In order to work with a font, we need to import the font files into the project.
It is common practice to put font files in a `fonts` or `assets` folder at the 
root of a Flutter project. 

For example, if we want to import the Raleway and Roboto Mono font files into 
our project, the folder structure would look like this:

```
awesome_app/
  fonts/
    Raleway-Regular.ttf
    Raleway-Italic.ttf
    RobotoMono-Regular.ttf
    RobotoMono-Bold.ttf
```

## 2. Declare the font in the `pubspec.yaml`

Now that we have a font to work with, we need to tell Flutter where to find it.
We can do so by including a font definition in the `pubspec.yaml`.

```yaml
flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: fonts/Raleway-Regular.ttf
        - asset: fonts/Raleway-Italic.ttf
          style: italic
    - family: RobotoMono
      fonts:
        - asset: fonts/RobotoMono-Regular.ttf
        - asset: fonts/RobotoMono-Bold.ttf
          weight: 700
```

### `pubspec.yaml` option definitions

The `family` determines the name of the font, which we can use in the
[`fontFamily`](https://docs.flutter.io/flutter/painting/TextStyle/fontFamily.html)
property of a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
object.

The `asset` is a path to the font file, relative to the `pubspec.yaml` file.
These files contain the outlines for the glyphs in the font. When building our 
app, these files are included in our app's asset bundle.

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

## 3. Set a font as the default

We have two options for how to apply fonts to text: as the default font or only 
within specific Widgets.

To use a font as the default, we can set the `fontFamily` property as part of 
the app's `theme`. The value we provide to `fontFamily` must match the `family` 
name declared in the `pubspec.yaml`. 

```dart
new MaterialApp(
  title: 'Custom Fonts',
  // Set Raleway as the default app font
  theme: new ThemeData(fontFamily: 'Raleway'),
  home: new MyHomePage(),
);
```

For more information on themes, please view the ["Using Themes to share colors 
and font styles"](/cookbook/design/themes/) recipe.

## 4. Use the font in a specific Widget

If we want to apply the font to a specific Widget, such as a `Text` Widget, 
we can provide a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
to the Widget.

In this example, we'll apply the RobotoMono font to a single `Text` Widget. Once 
again, the `fontFamily` must match the `family` name we declared in the 
`pubspec.yaml`. 

```dart
new Text(
  'Roboto Mono sample',
  style: new TextStyle(fontFamily: 'RobotoMono'),
);
```

### TextStyle

If a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
object specifies a weight or style for which is there is no exact font file, the
engine uses one of the more generic files for the font and attempts to
extrapolate outlines for the requested weight and style.  

## Complete Example

### Fonts

The Raleway and RobotoMono fonts were downloaded from [Google Fonts](https://fonts.google.com/).

### `pubspec.yaml`

```yaml
name: custom_fonts
description: An example of how to use custom fonts with Flutter

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: fonts/Raleway-Regular.ttf
        - asset: fonts/Raleway-Italic.ttf
          style: italic
    - family: RobotoMono
      fonts:
        - asset: fonts/RobotoMono-Regular.ttf
        - asset: fonts/RobotoMono-Bold.ttf
          weight: 700
  uses-material-design: true
```

### `main.dart`

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Custom Fonts',
      // Set Raleway as the default app font
      theme: new ThemeData(fontFamily: 'Raleway'),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // The AppBar will use the app-default Raleway font
      appBar: new AppBar(title: new Text('Custom Fonts')),
      body: new Center(
        // This Text Widget will use the RobotoMono font 
        child: new Text(
          'Roboto Mono sample',
          style: new TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
    );
  }
}
```

![Custom Fonts Demo](/images/cookbook/fonts.png)
