---
title: Use a custom font
description: How to use custom fonts.
---

<?code-excerpt path-base="cookbook/design/fonts/"?>

:::secondary What you'll learn
* How to choose a font.
* How to import font files.
* How to set a font as a default.
* How to use a font in a given widget.
:::

Although Android and iOS offer high quality system fonts,
designers want support for custom fonts.
You might have a custom-built font from a designer,
or perhaps you downloaded a font from [Google Fonts][].

A typeface is the collection of glyphs or shapes that comprise
a given style of lettering.
A font is one representation of that typeface at a given weight or variation.
Roboto is a typeface and Roboto Bold is a font.

Flutter lets you apply a custom font across an entire app or to individual widgets.
This recipe creates an app that uses custom fonts with the following steps.

1. Choose your fonts.
1. Import the font files.
1. Declare the font in the pubspec.
1. Set a font as the default.
1. Use a font in a specific widget.

You don't need to follow each step as you go. 
The guide offers completed example files at the end.

:::note
This guide makes the following presumptions:

1. You've [set up your Flutter environment][].
1. You've [created a new Flutter app][new-flutter-app] named `custom_fonts`.
   If you haven't completed these steps yet, do so before continuing
   with this guide.
1. You're performing the provided commands in a macOS or Linux shell
   and using `vi`. You can substitute any text editor for `vi`.
   Windows users should use the appropriate commands and paths when
   performing the steps.
1. You're adding the Raleway and RobotoMono fonts to your Flutter app.
:::

[set up your Flutter environment]: /get-started/install
[new-flutter-app]: /get-started/test-drive

## Choose a font

Your choice of font should be more than a preference.
Consider which file formats work with Flutter and
how the font could affect design options and app performance.

#### Pick a supported font format

Flutter supports the following font formats:

* OpenType font collections: `.ttc`
* TrueType fonts: `.ttf`
* OpenType fonts: `.otf`

Flutter does not support fonts in the Web Open Font Format,
`.woff` and `.woff2`, on desktop platforms.

#### Choose fonts for their specific benefits

Few sources agree on what a font file type is or which uses less space.
The key difference between font file types involves how the format 
encodes the glyphs in the file.
Most TrueType and OpenType font files have similar capabilities as they
borrowed from each other as the formats and fonts improved over time.

Which font you should use depends on the following considerations.

* How much variation you need for fonts in your app?
* How much file size you can accept fonts using in your app?
* How many languages you need to support in your app?

Research what options a given font offers,
like more than one weight or style per font file,
[variable font capability][variable-fonts],
the availability of multiple font files for a multiple font weights,
or more than one width per font.

Choose the typeface or font family that meets the design needs of your app.

:::secondary
To learn how to get direct access to over 1,000 open-sourced font families,
check out the [google_fonts][] package.

<iframe class="full-width" src="{{site.yt.embed}}/8Vzv2CdbEY0" title="Learn about the google_fonts Flutter Package" {{site.yt.set}}></iframe>

To learn about another approach to using custom fonts that allows you to
re-use one font over multiple projects,
check out [Export fonts from a package][].
:::

## Import the font files

To work with a font, import its font files into your Flutter project.

To import font files, perform the following steps.

1. If necessary, to match the remaining steps in this guide,
   change the name of your Flutter app to `custom_fonts`.

   ```console
   $ mv /path/to/my_app /path/to/custom_fonts
   ```

1. Navigate to the root of your Flutter project.

   ```console
   $ cd /path/to/custom_fonts
   ```

1. Create a `fonts` directory at the root of your Flutter project.

   ```console
   $ mkdir fonts
   ```

1. Move or copy the font files in a `fonts` or `assets`
   folder at the root of your Flutter project.

   ```console
   $ cp ~/Downloads/*.ttf ./fonts
   ```

The resulting folder structure should resemble the following:

```plaintext
custom_fonts/
|- fonts/
  |- Raleway-Regular.ttf
  |- Raleway-Italic.ttf
  |- RobotoMono-Regular.ttf
  |- RobotoMono-Bold.ttf
```

## Declare the font in the pubspec.yaml file

After you've downloaded a font,
include a font definition in the `pubspec.yaml` file.
This font definition also specifies which font file should be used to
render a given weight or style in your app.

### Define fonts in the `pubspec.yaml` file

To add font files to your Flutter app, complete the following steps.

1. Open the `pubspec.yaml` file at the root of your Flutter project.

   ```console
   $ vi pubspec.yaml
   ```

1. Paste the following YAML block after the `flutter` declaration.

   ```yaml
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

This `pubspec.yaml` file defines the italic style for the
`Raleway` font family as the `Raleway-Italic.ttf` font file.
When you set `style: TextStyle(fontStyle: FontStyle.italic)`,
Flutter swaps `Raleway-Regular` with `Raleway-Italic`.

The `family` value sets the name of the typeface.
You use this name in the [`fontFamily`][] property of a [`TextStyle`][] object.

The value of an `asset` is a relative path from the `pubspec.yaml` file
to the font file.
These files contain the outlines for the glyphs in the font.
When building the app,
Flutter includes these files in the app's asset bundle.

### Include font files for each font

Different typefaces implement font files in different ways.
If you need a typeface with a variety of font weights and styles,
choose and import font files that represent that variety. 

When you import a font file that doesn't include either multiple fonts
within it or variable font capabilities,
don't use the `style` or `weight` property to adjust how they display.
If you do use those properties on a regular font file,
Flutter attempts to _simulate_ the look.
The visual result will look quite different from using the correct font file. 

### Set styles and weights with font files

When you declare which font files represent styles or weights of a font,
you can apply the `style` or `weight` properties.

#### Set font weight

The `weight` property specifies the weight of the outlines in
the file as an integer multiple of 100, between 100 and 900.
These values correspond to the [`FontWeight`][] and can be used in the
[`fontWeight`][fontWeight property] property of a [`TextStyle`][] object.

In the `pubspec.yaml` shown in this guide,
you defined `RobotoMono-Bold` as the `700` weight of the font family.
To use the `RobotoMono-Bold` font that you added to your app, 
set `fontWeight` to `FontWeight.w700` in your `TextStyle` widget.

If you hadn't added `RobotoMono-Bold` to your app,
Flutter attempts to make the font look bold.
The text then might appear to be somewhat darker.

You can't use the `weight` property to override the weight of the font.
You can't set `RobotoMono-Bold` to any other weight than `700`.
If you set `TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.w900)`,
the displayed font would still render as however bold `RobotoMono-Bold` looks.

#### Set font style

The `style` property specifies whether the glyphs in the font file display as
either `italic` or `normal`.
These values correspond to the [`FontStyle`][].
You can use these styles in the [`fontStyle`][fontStyle property] property
of a [`TextStyle`][] object.

In the `pubspec.yaml` shown in this guide,
you defined `Raleway-Italic` as being in the `italic` style. 
To use the `Raleway-Italic` font that you added to your app, 
set `style: TextStyle(fontStyle: FontStyle.italic)`.
Flutter swaps `Raleway-Regular` with `Raleway-Italic` when rendering.

If hadn't added `Raleway-Italic` to your app,
Flutter attempts to make the font _look_ italic.
The text then might appear to be leaning to the right.

You can't use the `style` property to override the glyphs of a font.
If you set `TextStyle(fontFamily: 'Raleway', fontStyle: FontStyle.normal)`,
the displayed font would still render as italic.
The `regular` style of an italic font _is_ italic.

## Set a font as the default

To apply a font to text, you can set the font as the app's default font
in its `theme`.

To set a default font, set the `fontFamily` property in the app's `theme`.
Match the `fontFamily` value to the `family` name declared in the
`pubspec.yaml` file.

The result would resemble the following code.

<?code-excerpt "lib/main.dart (MaterialApp)"?>
```dart
return MaterialApp(
  title: 'Custom Fonts',
  // Set Raleway as the default app font.
  theme: ThemeData(fontFamily: 'Raleway'),
  home: const MyHomePage(),
);
```

To learn more about themes,
check out the [Using Themes to share colors and font styles][] recipe.

## Set the font in a specific widget

To apply the font to a specific widget like a `Text` widget,
provide a [`TextStyle`][] to the widget.

For this guide, 
try to apply the `RobotoMono` font to a single `Text` widget.
Match the `fontFamily` value to the `family` name declared in the
`pubspec.yaml` file.

The result would resemble the following code.

<?code-excerpt "lib/main.dart (Text)"?>
```dart
child: Text(
  'Roboto Mono sample',
  style: TextStyle(fontFamily: 'RobotoMono'),
),
```

:::important
If a [`TextStyle`][] object specifies a weight or style without a
corresponding font file, the engine uses a generic file for the font
and attempts to extrapolate outlines for the requested weight and style.

Avoid relying on this capability. Import the proper font file instead.
:::

## Try the complete example

### Download fonts

Download the Raleway and RobotoMono font files from [Google Fonts][].

### Update the `pubspec.yaml` file

1. Open the `pubspec.yaml` file at the root of your Flutter project.

   ```console
   $ vi pubspec.yaml
   ```

1. Replace its contents with the following YAML.

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

### Use this `main.dart` file

1. Open the `main.dart` file in the `lib/` directory of your Flutter project.

   ```console
   $ vi lib/main.dart
   ```

1. Replace its contents with the following Dart code.

   <?code-excerpt "lib/main.dart"?>
   ```dart
   import 'package:flutter/material.dart';
   
   void main() => runApp(const MyApp());
   
   class MyApp extends StatelessWidget {
     const MyApp({super.key});
   
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Custom Fonts',
         // Set Raleway as the default app font.
         theme: ThemeData(fontFamily: 'Raleway'),
         home: const MyHomePage(),
       );
     }
   }
   
   class MyHomePage extends StatelessWidget {
     const MyHomePage({super.key});
   
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         // The AppBar uses the app-default Raleway font.
         appBar: AppBar(title: const Text('Custom Fonts')),
         body: const Center(
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

The resulting Flutter app should display the following screen.

![Custom Fonts Demo](/assets/images/docs/cookbook/fonts.png){:.site-mobile-screenshot}

[variable-fonts]: https://fonts.google.com/knowledge/introducing_type/introducing_variable_fonts
[Export fonts from a package]: /cookbook/design/package-fonts
[`fontFamily`]: {{site.api}}/flutter/painting/TextStyle/fontFamily.html
[fontStyle property]: {{site.api}}/flutter/painting/TextStyle/fontStyle.html
[`FontStyle`]: {{site.api}}/flutter/dart-ui/FontStyle.html
[fontWeight property]: {{site.api}}/flutter/painting/TextStyle/fontWeight.html
[`FontWeight`]: {{site.api}}/flutter/dart-ui/FontWeight-class.html
[Google Fonts]: https://fonts.google.com
[google_fonts]: {{site.pub-pkg}}/google_fonts
[`TextStyle`]: {{site.api}}/flutter/painting/TextStyle-class.html
[Using Themes to share colors and font styles]: /cookbook/design/themes
