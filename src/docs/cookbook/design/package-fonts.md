---
title: Exporting fonts from a package
prev:
  title: Displaying SnackBars
  path: /docs/cookbook/design/snackbars
next:
  title: Updating the UI based on orientation
  path: /docs/cookbook/design/orientation
---

Rather than declaring a font as part of an app, you can declare a font as part
of a separate package. This is a convenient way to share the same font across
several different projects, or for coders publishing their packages to the
[Pub site][].

## Directions

  1. Add a font to a package
  2. Add the package and font to the app
  3. Use the font

## 1. Add fonts to a package

To export a font from a package, you need to import the font files into the
`lib` folder of the package project. You can place font files directly in the
`lib` folder or in a subdirectory, such as `lib/fonts`.

In this example, assume you've got a Flutter library called
`awesome_package` with fonts living in a `lib/fonts` folder.

```
awesome_package/
  lib/
    awesome_package.dart
    fonts/
      Raleway-Regular.ttf
      Raleway-Italic.ttf
```

## 2. Add the package and fonts to the app

You can now consume the package and use the fonts it provides.
This involves updating the `pubspec.yaml` in the *app's* root directory.

### Add the package to the project

```yaml
dependencies:
  awesome_package: <latest_version>
```

### Declare the font assets

Now that you've imported the package, you need to tell Flutter where to
find the fonts from the `awesome_package`.

To declare package fonts, you must must prefix the path to the font with
`packages/awesome_package`. This tells Flutter to look in the `lib` folder
of the package for the font.

```yaml
flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: packages/awesome_package/fonts/Raleway-Regular.ttf
        - asset: packages/awesome_package/fonts/Raleway-Italic.ttf
          style: italic
```

## 3. Use the font

You can use a [`TextStyle`][] to change the appearance of text.
To use package fonts, you need to not only declare which font you'd like to use,
you need to declare the `package` the font belongs to.

<!-- skip -->
```dart
Text(
  'Using the Raleway font from the awesome_package',
  style: TextStyle(
    fontFamily: 'Raleway',
    package: 'awesome_package',
  ),
);
```

## Complete example

### Fonts

The Raleway and RobotoMono fonts were downloaded from
[Google Fonts](https://fonts.google.com).

### `pubspec.yaml`

```yaml
name: package_fonts
description: An example of how to use package fonts with Flutter

dependencies:
  awesome_package:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: packages/awesome_package/fonts/Raleway-Regular.ttf
        - asset: packages/awesome_package/fonts/Raleway-Italic.ttf
          style: italic
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
      title: 'Package Fonts',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar uses the app-default Raleway font.
      appBar: AppBar(title: Text('Package Fonts')),
      body: Center(
        // This Text Widget uses the RobotoMono font.
        child: Text(
          'Using the Raleway font from the awesome_package',
          style: TextStyle(
            fontFamily: 'Raleway',
            package: 'awesome_package',
          ),
        ),
      ),
    );
  }
}
```

![Package Fonts Demo](/images/cookbook/package-fonts.png){:.site-mobile-screenshot}

[Pub site]: {{site.pub}} 
[`TextStyle`]: {{site.api}}/flutter/painting/TextStyle-class.html
