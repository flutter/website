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
First declare them in your `pubspec.yaml`, to ensure that they are included in the app. Second use the font with a [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) property.

### Declaring in the font asset

To include your font in the app, declare it like in the `pubspec.yaml` example below.
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

```dart
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
### Fonts in package dependencies {#from-packages}

To use a font family defined in a package, the `package` argument must be provided. For instance, suppose the font
declaration above is in the `pubspec.yaml` of a package named `my_package` which the app depends on. Then creating the
TextStyle is done as follows:

```dart
const textStyle = const TextStyle(
  fontFamily: 'Raleway',
  package: 'my_package',
);
```

If the package internally uses the font it defines, it should still specify
the `package` argument when creating the text style as in the example above.

A package can also provide font files without declaring a font in its `pubspec.yaml`. These files
should then be in the `lib/` folder of the package. The font files will not
automatically be bundled in the app, instead the app can use these
selectively when declaring a font. Suppose a package named `my_package` has:

```
lib/fonts/Raleway-Medium.ttf
```

Then the app can declare a font like in the example below:

```yaml
 flutter:
   fonts:
     - family: Raleway
       fonts:
         - asset: assets/fonts/Raleway-Regular.ttf
         - asset: packages/my_package/fonts/Raleway-Medium.ttf
           weight: 500
```

The `lib/` is implied, so it should not be included in the asset path.

In this case, since the app locally defines the font, the TextStyle is created
without the `package` argument:

```dart
const textStyle = const TextStyle(
  fontFamily: 'Raleway',
);
```

## Using the Material Design icon font

When you want to use the Material Design icon font,
it can be simply included by adding a dependency on the  `material_icons_font` package to the `pubspec.yaml` file.

```yaml
dependencies:
  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the Icons class.
  material_icons_font: ^0.1.1
```

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


## Example
Here is an example delcaring and using the fonts in a simple application.

| iOS | Android |
|------|------|
| <img style="width: 200px;" src="/images/fonts-example-ios.png" alt="Display of the fonts on ios." /> | <img style="width: 200px;" src="/images/fonts-example-android.png" alt="Display of the fonts on android." /> |


Declaring the fonts in the pubsec.yaml.

```yaml
name: my_application
description: A new Flutter project.

dependencies:
  flutter:
    sdk: flutter
  # Include the Material Design fonts.
  material_icons_font: ^0.1.1

flutter:
  fonts:
    - family: Rock Salt
      fonts:
        # https://fonts.google.com/specimen/Rock+Salt
        - asset: fonts/RockSalt.ttf
    - family: VT323
      fonts:
        # https://fonts.google.com/specimen/VT323
        - asset: fonts/VT323-Regular.ttf
    - family: Ewert
      fonts:
        # https://fonts.google.com/specimen/Ewert
        - asset: fonts/Ewert-Regular.ttf
```

Implementing the fonts in the application source code.

```dart
import 'package:flutter/material.dart';

const String words1 = "Almost before we knew it, we had left the ground.";
const String words2 = "A shining crescent far beneath the flying vessel.";
const String words3 = "A red flair silhouetted the jagged edge of a wing.";
const String words4 = "Mist enveloped the ship three hours out from port.";

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Fonts',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FontsPage(),
    );
  }
}

class FontsPage extends StatefulWidget {
  @override
  _FontsPageState createState() => new _FontsPageState();
}

class _FontsPageState extends State<FontsPage> {
  @override
  Widget build(BuildContext context) {
    // Rock Salt - https://fonts.google.com/specimen/Rock+Salt
    var rockSaltContainer = new Container(
      child: new Column(
        children: <Widget>[
          new Text(
            "Rock Salt",
          ),
          new Text(
            words2,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "Rock Salt",
              fontSize: 17.0,
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
    );

    // VT323 - https://fonts.google.com/specimen/VT323
    var v2t323Container = new Container(
      child: new Column(
        children: <Widget>[
          new Text(
            "VT323",
          ),
          new Text(
            words3,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "VT323",
              fontSize: 25.0,
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
    );

    // https://fonts.google.com/specimen/Ewert
    var ewertContainer = new Container(
      child: new Column(
        children: <Widget>[
          new Text(
            "Ewert",
          ),
          new Text(
            words4,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "Ewert",
              fontSize: 25.0,
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
    );

    // Material Icons font - included with Material Design
    String icons = "";

    // https://material.io/icons/#ic_accessible
    // accessible: &#xE914; or 0xE914 or E914
    icons += "\u{E914}";

    // https://material.io/icons/#ic_error
    // error: &#xE000; or 0xE000 or E000
    icons += "\u{E000}";

    // https://material.io/icons/#ic_fingerprint
    // fingerprint: &#xE90D; or 0xE90D or E90D
    icons += "\u{E90D}";

    // https://material.io/icons/#ic_camera
    // camera: &#xE3AF; or 0xE3AF or E3AF
    icons += "\u{E3AF}";

    // https://material.io/icons/#ic_palette
    // palette: &#xE40A; or 0xE40A or E40A
    icons += "\u{E40A}";

    // https://material.io/icons/#ic_tag_faces
    // tag faces: &#xE420; or 0xE420 or E420
    icons += "\u{E420}";

    // https://material.io/icons/#ic_directions_bike
    // directions bike: &#xE52F; or 0xE52F or E52F
    icons += "\u{E52F}";

    // https://material.io/icons/#ic_airline_seat_recline_extra
    // airline seat recline extra: &#xE636; or 0xE636 or E636
    icons += "\u{E636}";

    // https://material.io/icons/#ic_beach_access
    // beach access: &#xEB3E; or 0xEB3E or EB3E
    icons += "\u{EB3E}";

    // https://material.io/icons/#ic_public
    // public: &#xE80B; or 0xE80B or E80B
    icons += "\u{E80B}";

    // https://material.io/icons/#ic_star
    // star: &#xE838; or 0xE838 or E838
    icons += "\u{E838}";

    var materialIconsContainer = new Container(
      child: new Column(
        children: <Widget>[
          new Text(
            "Material Icons",
          ),
          new Text(
            icons,
            textAlign: TextAlign.center,
            style: new TextStyle(
              inherit: false,
              fontFamily: "MaterialIcons",
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Fonts"),
      ),
      body: new ListView(
        children: <Widget>[
          rockSaltContainer,
          v2t323Container,
          ewertContainer,
          materialIconsContainer,
        ],
      ),
    );
  }
}
```
