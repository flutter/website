---
layout: page
title: 自定义体

permalink: /custom-fonts/
---

## 前言

你可以在你 Flutter 应用中使用不同的字体。比如，你可以使用你们设计师设计的字体库，或者使用来自[谷歌字体库](https://fonts.google.com/)的字体。

这篇文章将指导你怎样定义你的 Flutter 应用的字体，并且在渲染文本时使用这种字体。

## 更换字体

在你的应用中更换字体需要两个步骤。

首先，需要在 `pubspec.yaml` 文件中声明，确保他们在应用中被引用。然后在 [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 属性中使用他们。

### 在字体库中声明

为了使你的字体被应用引入，你需要在 `pubspec.yaml` 中声明他，如下面例子。然后把字体文件复制到你的 `pubspec.yaml` 文件声明的对应文件夹下。

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

### 使用字体

第二步，通过创建 [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 以使用该字体。
然后把 [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 的 `fontFamily` 属性设置为在 `pubsec.yaml` 文件中定义的字体。

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
### 使用依赖包中的字体 {#from-packages}

使用依赖包中定义的字体，必须提供`依赖包`相关的参数。举个例子，假设上面在 `pubspec.yaml` 文件中声明的字体是一个名字是 `my_package` 的应用依赖包。然后可以像下面一样创建 TextStyle 。

```dart
const textStyle = const TextStyle(
  fontFamily: 'Raleway',
  package: 'my_package',
);
```

在上面的例子中，如果这个依赖包内部使用的是它自己定义的字体，在创建 TextStyle 的时候仍然要明确指明`依赖包`参数。

依赖包也可以在直接提供字体文件，而不必在 `pubspec.yaml` 文件中声明。这些字体文件必须放在 `/lib` 文件夹下。字体文件不会被应用自动的引入，应用可以在定义字体时选择性的使用某些字体。假设 `my_package` 依赖包中有如下字体文件：

```
lib/fonts/Raleway-Medium.ttf
```

然后应用就可以像以下例子一样声明一种字体：
```yaml
 flutter:
   fonts:
     - family: Raleway
       fonts:
         - asset: assets/fonts/Raleway-Regular.ttf
         - asset: packages/my_package/fonts/Raleway-Medium.ttf
           weight: 500
```

由于声明了是 `lib/` 文件夹，所以字体文件不必包含在asset路径中。

在这个例子中，由于应用局部定义了字体，在创建TextStyle的时候不需要`依赖包`的参数：
```dart
const textStyle = const TextStyle(
  fontFamily: 'Raleway',
);
```

## 使用Material Design图标字体

如果你想使用Material Design图标字体，只需要把 `pubsec.yaml` 文件中添加一行 `uses-material-design: true` 。
```yaml
flutter:
  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the Icons class.
  uses-material-design: true
```

## pubspec.yaml可选定义

`falimy` 定义了在 [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html) 或者 [`RichText`](https://docs.flutter.io/flutter/widgets/RichText-class.html) 组件中的 [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 对象的 [`fontFamily`](https://docs.flutter.io/flutter/painting/TextStyle/fontFamily.html) 属性中可以使用的字体名称。

`asset` 是一个相对于 `pubspec.yaml` 文件位置的相对路径。

这些文件会被包含在你应用的资源包中。

一种字体可以引入不同的轮廓线粗细和样式的文件。

  * `weight` 属性可以定义轮廓线的粗细，这个值应该是一个在100-900之间的100的整数倍的数字。这个值和 [`FontWeight`](https://docs.flutter.io/flutter/dart-ui/FontWeight-class.html) 属性一样，并且可以在 [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 对象的 [`fontWeight`](https://docs.flutter.io/flutter/painting/TextStyle/fontWeight.html) 属性中使用该值。

  * `style` 属性定义了文件中的字体是 `italic` 或者 `normal` 。这个值和 [`FontStyle`](https://docs.flutter.io/flutter/dart-ui/FontStyle-class.html) 属性一样，并且可以在 [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 对象中的 [`FontStyle`](https://docs.flutter.io/flutter/dart-ui/FontStyle-class.html) 属性中使用。

## TextStyle

如果 [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 对象对不存在的字体文件定义了粗细和样式，引擎会使用另一种字体文件，并且会尝试将定义的粗细和样式运用在这种字体上。

## 举例来说

这个例子中，应用声明和使用了一种字体。

| iOS | Android |
|------|------|
| <img style="width: 200px;" src="/images/fonts-example-ios.png" alt="Display of the fonts on ios." /> | <img style="width: 200px;" src="/images/fonts-example-android.png" alt="Display of the fonts on android." /> |

在 pubsec.yaml 文件中声明了字体。

```yaml
name: my_application
description: A new Flutter project.

dependencies:
  flutter:
    sdk: flutter

flutter:
  # Include the Material Design fonts.
  uses-material-design: true

  fonts:
    - family: Rock Salt
      fonts:
        # https://fonts.google.com/specimen/Rock+Salt
        - asset: fonts/RockSalt-Regular.ttf
    - family: VT323
      fonts:
        # https://fonts.google.com/specimen/VT323
        - asset: fonts/VT323-Regular.ttf
    - family: Ewert
      fonts:
        # https://fonts.google.com/specimen/Ewert
        - asset: fonts/Ewert-Regular.ttf
```

在应用代码中使字体生效。

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
