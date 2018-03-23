---
layout: page
title: "Exporting fonts from a package"
permalink: /cookbook/design/package-fonts/
---

Rather than declaring a font as part of our app, we can declare a font as part
of a separate package. This is a convenient way to share the same font across 
several different projects or for coders publishing their packages to the 
[pub website](https://pub.dartlang.org/).  

## Directions

  1. Add a font to a package
  2. Add the package and font to our app
  3. Use the font
  
## 1. Add fonts to a package

To export a font from a package, we need to import the font files into the `lib`
folder of our package project. We can place font files directly in the `lib` 
folder or in a subdirectory, such as `lib/fonts`. 

In this example, we'll assume we've got a Flutter library called 
`awesome_package` with fonts living in a `lib/fonts` folder.

```
awesome_package/
  lib/
    awesome_package.dart
    fonts/
      Raleway-Regular.ttf
      Raleway-Italic.ttf
```

## 2. Add the package and fonts to our app

We can now consume the package and use the fonts it provides. This involves 
updating the `pubspec.yaml` in our *app's* root directory. 

### Add the package to the project

```yaml
dependencies:
  awesome_package: <latest_version>
```

### Declare the font assets

Now that we've imported the package, we need to tell Flutter where to find the 
fonts from our `awesome_package`.

To declare package fonts, we must must prefix the path to the font with 
`packages/awesome_package`. This will tell Flutter to look in the `lib` folder
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

We can use a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
to change the appearance of text. To use package fonts, we need to not only 
declare which font we'd like to use, we need to declare the `package` the font
belongs to. 

```dart
new Text(
  'Using the Raleway font from the awesome_package',
  style: new TextStyle(
    fontFamily: 'Raleway',
    package: 'awesome_package',
  ),
);
```

## Complete Example

### Fonts

The Raleway and RobotoMono fonts were downloaded from [Google Fonts](https://fonts.google.com/).

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

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Package Fonts',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // The AppBar will use the app-default Raleway font
      appBar: new AppBar(title: new Text('Package Fonts')),
      body: new Center(
        // This Text Widget will use the RobotoMono font 
        child: new Text(
          'Using the Raleway font from the awesome_package',
          style: new TextStyle(
            fontFamily: 'Raleway',
            package: 'awesome_package',
          ),
        ),
      ),
    );
  }
}
```

![Package Fonts Demo](/images/cookbook/package-fonts.png)

