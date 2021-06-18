---
title: Use a custom font
description: How to use custom fonts.
prev:
  title: Update the UI based on orientation
  path: /docs/cookbook/design/orientation
next:
  title: Use themes to share colors and font styles
  path: /docs/cookbook/design/themes
---

Although Android and iOS offer high quality system fonts,
one of the most common requests from designers is for custom fonts.
For example, you might have a custom-built font from a designer,
or perhaps you downloaded a font from [Google Fonts][].

{{site.alert.note}}
  Check out the [google_fonts][] package for direct access
  to over 1,000 open-sourced font families.
{{site.alert.end}}

{{site.alert.note}}
  For another approach to using custom fonts, 
  especially if you want to re-use one font over multiple projects, 
  see [Export fonts from a package][].
{{site.alert.end}}

Flutter works with custom fonts and you can apply a custom
font across an entire app or to individual widgets.
This recipe creates an app that uses custom fonts with
the following steps:

  1. Import the font files.
  2. Declare the font in the pubspec.
  3. Set a font as the default.
  4. Use a font in a specific widget.

## 1. Import the font files

To work with a font, import the font files into the project.
It's common practice to put font files in a `fonts` or `assets`
folder at the root of a Flutter project.

For example, to import the Raleway and Roboto Mono font
files into a project, the folder structure might look like this:

```
awesome_app/
  fonts/
    Raleway-Regular.ttf
    Raleway-Italic.ttf
    RobotoMono-Regular.ttf
    RobotoMono-Bold.ttf
```

### Supported font formats

Flutter supports the following font formats:

* `.ttf`
* `.otf`

Flutter does not support `.woff` and `.woff2` fonts for all platforms.

## 2. Declare the font in the pubspec

Once you've identified a font, tell Flutter where to find it.
You can do this by including a font definition in the `pubspec.yaml` file.

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

The `family` determines the name of the font, which you use in the
[`fontFamily`][] property of a [`TextStyle`][] object.

The `asset` is a path to the font file,
relative to the `pubspec.yaml` file.
These files contain the outlines for the glyphs in the font.
When building the app,
these files are included in the app's asset bundle.

A single font can reference many different files with different
outline weights and styles:

  * The `weight` property specifies the weight of the outlines in
    the file as an integer multiple of 100, between 100 and 900.
    These values correspond to the [`FontWeight`][]
    and can be used in the [`fontWeight`][] property of a
    [`TextStyle`][] object. For example, if you want to use
    the `RobotoMono-Bold` font defined above, you would set `fontWeight`
    to `FontWeight.w700` in your `TextStyle`.
    
    Note that defining the `weight` property does not
    override the actual weight of the font. You would not be able to
    access `RobotoMono-Bold` with `FontWeight.w100`, even if its `weight`
    was set to 100.

  * The `style` property specifies whether the outlines in the file are
    `italic` or `normal`. These values correspond to the
    [`FontStyle`][] and can be used in the [`fontStyle`][] property of a
    [`TextStyle`][] object. For example, if you want to use
    the `Raleway-Italic` font defined above, you would set `fontStyle`
    to `FontStyle.italic` in your `TextStyle`.
    
    Note that defining the `style` property does not
    override the actual style of the font; You would not be able to
    access `Raleway-Italic` with `FontStyle.normal`, even if its `style`
    was set to normal.

## 3. Set a font as the default

You have two options for how to apply fonts to text: as the default font
or only within specific widgets.

To use a font as the default, set the `fontFamily` property
as part of the app's `theme`. The value provided to
`fontFamily` must match the `family`
name declared in the `pubspec.yaml`.

<!-- skip -->
```dart
MaterialApp(
  title: 'Custom Fonts',
  // Set Raleway as the default app font.
  theme: ThemeData(fontFamily: 'Raleway'),
  home: MyHomePage(),
);
```

For more information on themes,
see the [Using Themes to share colors and font styles][] recipe.

## 4. Use the font in a specific widget

If you want to apply the font to a specific widget,
such as a `Text` widget,
provide a [`TextStyle`][] to the widget.

In this example, apply the RobotoMono font to a single `Text` widget.
Once again, the `fontFamily` must match the `family` name declared in the
`pubspec.yaml`.

<!-- skip -->
```dart
Text(
  'Roboto Mono sample',
  style: TextStyle(fontFamily: 'RobotoMono'),
);
```

### TextStyle

If a [`TextStyle`][] object specifies a weight
or style for which there is no exact font file,
the engine uses one of the more generic files
for the font and attempts to extrapolate outlines
for the requested weight and style.

## Complete example

### Fonts

The Raleway and RobotoMono fonts were downloaded from
[Google Fonts][].

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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Fonts',
      // Set Raleway as the default app font.
      theme: ThemeData(fontFamily: 'Raleway'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar uses the app-default Raleway font.
      appBar: AppBar(title: Text('Custom Fonts')),
      body: Center(
        // This Text widget uses the RobotoMono font.
        child: Text(
          'Roboto Mono sample',
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
    );
  }
}
```

![Custom Fonts Demo](/images/cookbook/fonts.png){:.site-mobile-screenshot}


[Export fonts from a package]:  /docs/cookbook/design/package-fonts
[`fontFamily`]: {{site.api}}/flutter/painting/TextStyle/fontFamily.html
[`fontStyle`]: {{site.api}}/flutter/painting/TextStyle/fontStyle.html
[`FontStyle`]: {{site.api}}/flutter/dart-ui/FontStyle-class.html
[`fontWeight`]: {{site.api}}/flutter/painting/TextStyle/fontWeight.html
[`FontWeight`]: {{site.api}}/flutter/dart-ui/FontWeight-class.html
[Google Fonts]: https://fonts.google.com
[google_fonts]: {{site.pub-pkg}}/google_fonts
[`TextStyle`]: {{site.api}}/flutter/painting/TextStyle-class.html
[Using Themes to share colors and font styles]: /docs/cookbook/design/themes
