---
title: Export fonts from a package
description: How to export fonts from a package.
---

<?code-excerpt path-base="cookbook/design/package_fonts"?>

Rather than declaring a font as part of an app,
you can declare a font as part of a separate package.
This is a convenient way to share the same font across
several different projects,
or for coders publishing their packages to [pub.dev][].
This recipe uses the following steps:

  1. Add a font to a package.
  2. Add the package and font to the app.
  3. Use the font.

:::note
Check out the [google_fonts][] package for direct access
to almost 1000 open-sourced font families.
:::

## 1. Add a font to a package

To export a font from a package, you need to import the font files into the
`lib` folder of the package project. You can place font files directly in the
`lib` folder or in a subdirectory, such as `lib/fonts`.

In this example, assume you've got a Flutter library called
`awesome_package` with fonts living in a `lib/fonts` folder.

```plaintext
awesome_package/
  lib/
    awesome_package.dart
    fonts/
      Raleway-Regular.ttf
      Raleway-Italic.ttf
```

## 2. Add the package and fonts to the app

Now you can use the fonts in the package by
updating the `pubspec.yaml` in the *app's* root directory.

### Add the package to the app

To add the `awesome_package` package as a dependency,
run `flutter pub add`:

```console
$ flutter pub add awesome_package
```

### Declare the font assets

Now that you've imported the package, tell Flutter where to
find the fonts from the `awesome_package`.

To declare package fonts, prefix the path to the font with
`packages/awesome_package`.
This tells Flutter to look in the `lib` folder
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

<a id="use" aria-hidden="true"></a>

## 3. Use the font

Use a [`TextStyle`][] to change the appearance of text.
To use package fonts, declare which font you'd like to use and
which package the font belongs to.

<?code-excerpt "lib/main.dart (TextStyle)"?>
```dart
child: Text(
  'Using the Raleway font from the awesome_package',
  style: TextStyle(fontFamily: 'Raleway'),
),
```

## Complete example

### Fonts

The Raleway and RobotoMono fonts were downloaded from
[Google Fonts][].

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

<?code-excerpt "lib/main.dart"?>
```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Package Fonts', home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar uses the app-default font.
      appBar: AppBar(title: const Text('Package Fonts')),
      body: const Center(
        // This Text widget uses the Raleway font.
        child: Text(
          'Using the Raleway font from the awesome_package',
          style: TextStyle(fontFamily: 'Raleway'),
        ),
      ),
    );
  }
}
```

![Package Fonts Demo](/assets/images/docs/cookbook/package-fonts.png){:.site-mobile-screenshot}

[Google Fonts]: https://fonts.google.com
[google_fonts]: {{site.pub-pkg}}/google_fonts
[pub.dev]: {{site.pub}}
[`TextStyle`]: {{site.api}}/flutter/painting/TextStyle-class.html
