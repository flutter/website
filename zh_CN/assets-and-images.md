---
layout: page
title: 资源与图像

permalink: /assets-and-images/
---

* TOC Placeholder
{:toc}

## 介绍

Flutter 应用程序是由代码和资源构建而成的。资源是应用程序需要用到的文件。静态文本文件（如: JSON 文件）、配置文件、图标和图像（包括 JPEG 、 WebP 、 GIF 、 动画、 WebP/GIF 、 PNG 、 BMP 、 和 WBMP ）都可以作为资源使用。

## 具体说明

Flutter 应用程序使用项目根目录下的 [`pubspec.yaml`](https://www.dartlang.org/tools/pub/pubspec) 文件，来定义 APP 需要使用的资源。

如下所示：

```yaml
flutter:
  assets:
    - assets/my_icon.png
    - assets/background.png
```

`flutter` 下的 `assets` 部分指定了 APP 所需的资源。每个资源都由一条路径（ `pubspec.yaml` 文件的相对路径）来指定它所在的位置。资源的声明顺序无关紧要。实际使用的目录（在本例中是 `assets` 目录）可自定义。

在 APP 的构建过程中， Flutter 会把资源放进 _资源包_ 中，供 APP 在运行时使用。

### 资源变体

APP 的构建支持资源变体的概念：不同版本的资源可以用在不同的上下文中。当在 `pubspec.yaml` 文件的 `assets` 中指定了一个资源后， Flutter 会在构建过程中查找指定目录下的所有子目录中的同名文件，然后， Flutter 会将所有的同名文件都放进 _资源包_ 中。

举个例子，如果项目目录下有如下文件：

* .../pubspec.yaml
* .../graphics/my_icon.png
* .../graphics/background.png
* .../graphics/dark/background.png
* ...

 `pubspec.yaml` 部分内容如下：

```yaml
flutter:
  assets:
    - graphics/background.png
```

这样的话，`graphics/background.png` 和 `graphics/dark/background.png` 都会被放进资源包中，前者被称为主资源，而后者则称为资源变体。

Flutter 在选择分辨率合适的图像时会考虑使用资源变体，这在下文有讲解。将来，这种机制会扩展到其他地方。

## 资源加载

APP 可以使用 [`AssetBundle`](https://docs.flutter.io/flutter/services/AssetBundle-class.html) 对象来加载资源。

这个对象主要通过两个方法（ `loadString` 和 `load` ）来加载资源。 `loadString` 用来加载文本资源（ string/text ）。 `load` 用来加载二进制资源（ image/binary ）。这两个方法通过在 `pubspec.yaml` 文件中指定的路径来寻找资源。

### 加载文本资源

为了更容易地访问主资源包， Flutter 提供了一个 [`rootBundle`](https://docs.flutter.io/flutter/services/rootBundle.html) 对象，可以通过引入 `package:flutter/services.dart` 来使用这个对象。

不过，还是建议在当前构建上下文中使用 [`DefaultAssetBundle`](https://docs.flutter.io/flutter/widgets/DefaultAssetBundle-class.html) 来获取  `AssetBundle` 对象。与获取默认构建包相比，这种方式可以让父组件在运行时替换资源包。这对于本地开发和测试场景是非常重要的。

通常来说，应该使用 `DefaultAssetBundle.of()` 代替 `rootBundle` 来间接加载资源。

{% comment %}

  应该使用一个例子来展示从当前构建上下文中，使用 `DefaultAssetBundle.of` 来获取 `AssetBundle` 对象。

{% endcomment %}

如果在组件的上下文之外，或者当 `AssetBundle` 不可获得时，可以使用 `rootBundle` 来直接获取资源，例如：

```dart
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}
```

### 加载图像

Flutter 可以根据当前的设备像素比来加载分辨率合适的图像。

#### 声名带有分辨率的图像资源 {#resolution-aware}

[`AssetImage`](https://docs.flutter.io/flutter/painting/AssetImage-class.html) 对象知道怎样根据当前的 [`device pixel ratio`](https://docs.flutter.io/flutter/dart-ui/Window/devicePixelRatio.html) 来匹配最合适的图像。为了让这个对象自动找到合适的图像，应该使用特定的目录结构来分配资源：

* .../image.png
* .../Mx/image.png
* .../Nx/image.png
* ...etc.

_M_ 和 _N_ 用来标识图像的设备像素比。

主资源被默认为 1.0 的设备像素比，举个例子，下面的目录结构列出了多个名为 `my_icon.png` 的图像:

* .../my_icon.png
* .../2.0x/my_icon.png
* .../3.0x/my_icon.png

对于设备像素比为 1.8 的设备来说，将匹配到 `.../2.0x/my_icon.png`。对于设备像素比为 2.7 的设备，将匹配到 `.../3.0x/my_icon.png`。

如果 image 组件没有指定宽度和高度，默认会选用最高分辨率的图片来占据整个组件空间。即，如果 `.../my_icon.png` 是 72px * 72px，`.../3.0x/my_icon.png` 应该是 216px * 216px，但是如果在长宽都没指定的条件下，它们都会被渲染成 72px * 72px。

除了主资源（即默认为 1.0x 的资源）之外，`pubspec.yaml` 中的每项资源都应该对应真实的文件，如果主资源没有对应真实文件，则会使用其他资源变体。尽管如此，这项主资源仍然应该写在 `pubspec.yaml` 文件中。

#### 加载图像

可以在 build 方法中使用 [`AssetImage`](https://docs.flutter.io/flutter/painting/AssetImage-class.html) 组件来加载图像

举个例子，可以通过以下方法来加载一张背景图片：

```dart
Widget build(BuildContext context) {
  // ...
  return new DecoratedBox(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('graphics/background.png'),
        // ...
      ),
      // ...
    ),
  );
  // ...
}
```

任何使用默认资源包的组件都会根据分辨率来加载图像。如果你使用一些底层的类，如 [`ImageStream`](https://docs.flutter.io/flutter/painting/ImageStream-class.html) 或 [`ImageCache`](https://docs.flutter.io/flutter/painting/ImageCache-class.html) ，你会注意到与 scale 相关的参数。

### 依赖包中的图像资源 {#from-packages}

为了从依赖包（ [package](https://flutter.io/using-packages/) ） 中加载图片资源，必须为 [`AssetImage`](https://docs.flutter.io/flutter/painting/AssetImage-class.html) 组件指定 `package` 参数。

例如，你的 APP 依赖于一个名为 `my_icons` 的包，假如这个包的目录结构如下：

* .../pubspec.yaml
* .../icons/heart.png
* .../icons/1.5x/heart.png
* .../icons/2.0x/heart.png
* ...etc.

那么，可以使用以下代码来加载图片：

<!-- skip -->
```dart
 new AssetImage('icons/heart.png', package: 'my_icons')
```

加载包本身时也需要像上面一样使用  `package` 参数。

#### 绑定资源包

如果所需的资源在包的 `pubspec.yaml` 文件中指定了，那么会自动与应用程序绑定。另外，包本身使用的资源必须在其 `pubspec.yaml` 中指定。

资源包也可以选择使用 `lib/` 文件夹下的资源，但是，`lib/` 不能出现在 `pubspec.yaml` 文件中，在这种情况下，仍可以在 `pubspec.yaml` 文件中指定所用到的资源。例如，一个名为 `fancy_backgrounds` 的包可以包含以下文件：

* .../lib/backgrounds/background1.png
* .../lib/backgrounds/background2.png
* .../lib/backgrounds/background3.png

为了使用第一张图片，可以在 `pubspec.yaml` 中的 `assets` 节点下添加如下资源路径：

```yaml
flutter:
  assets:
    - packages/fancy_backgrounds/backgrounds/background1.png
```

不需要在资源路径中包含 `lib/` 目录。

## 使用资源

可以直接在项目中使用资源，下面是 Flutter 框架加载和运行 APP 之前使用资源的两个常见情况。

### 更换 APP 图标

更新 Flutter 应用程序的图标与更新原生 Android 或 IOS 应用程序的图标是一样的。

![Launch icon](/images/assets-and-images/icon.png)

#### Android

在 Flutter 项目的根目录下，找到 `.../android/app/src/main/res` ，这个目录中有各种位图资源文件夹，比如说 `mipmap-hdpi` ，这些文件夹下默认存放着名为 `ic_launcher.png` 的图标。如果你想使用自己的图标，只需参照每个屏幕密度推荐的图标大小，然后替换掉默认的图标。详细信息请参考： [Android Developer Guide](https://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher.html#size) 。

![Android icon location](/images/assets-and-images/android-icon-path.png)

<aside class="alert alert-info" markdown="1">
 **Note:** 如果想重命名图片名，那么也必须修改 `AndroidManifest.xml` 文件 `<application>` 节点中的 `android:icon` 属性。
</aside>

#### iOS

在 Flutter 项目的根目录下，找到 `.../ios/Runner` ，这个目录下的 `Assets.xcassets/AppIcon.appiconset` 文件已经包含了一些默认的图标。按照图标名显示的大小替换它们，来修改 APP 的图标。需要注意的是不要修改文件名。具体请参考苹果开发者官网： [Human Interface Guidelines](https://developer.apple.com/ios/human-interface-guidelines/graphics/app-icon) 。

![iOS icon location](/images/assets-and-images/ios-icon-path.png)

### 更换启动界面

<p align="center">
  <img src="/images/assets-and-images/launch-screen.png" alt="Launch screen" />
</p>

在应用程序加载时， Flutter 采用了和原生平台一样的绘制启动界面机制。启动界面一直持续到 Flutter 渲染完第一个界面。

<aside class="alert alert-info" markdown="1">
**Note:** 这意味着如果不在 `void main()` 中调用 [runApp](https://docs.flutter.io/flutter/widgets/runApp.html) （准确来说是，如果不在    [`window.onDrawFrame`](https://docs.flutter.io/flutter/dart-ui/Window/onDrawFrame.html) 响应之后调用 [`window.render`](https://docs.flutter.io/flutter/dart-ui/Window/render.html) ），则 APP 会一直显示启动界面。
</aside>

#### Android

在项目根路径下，找到 `.../android/app/src/main` 目录中的 `res/drawable/launch_background.xml` 文件，可以通过修改这个 XML 文件来定制应用程序的启动界面。书写这个 XML 文件的规则请见： [layer list drawable](https://developer.android.com/guide/topics/resources/drawable-resource.html#LayerList) 。现有的模板在注释中提供了一个示例，示例代码的功能是启动时，向屏幕中间渲染一张图片。可以取消注释或者使用其他的 [可绘制对象](https://developer.android.com/guide/topics/resources/drawable-resource.html) 来达到预期的效果。

#### iOS

在项目根路径下，找到 `.../ios/Runner` 目录中的 `Assets.xcassets/LaunchImage.imageset` 文件夹，替换掉三个名为 `LaunchImage.png`、`LaunchImage@2x.png`、 `LaunchImage@3x.png` 的图片。若图片使用了另外一个文件名，那也必须更改同目录下 `Contents.json` 文件中的图片名。

也可以定制开机动画，在 Xcode 中打开 .../ios/Runner.xcworkspace ，然后在项目导航栏中找到 `Runner/Runner` 目录，打开 `Assets.xcassets` 来替换图像，或者使用界面构建工具 `LaunchScreen.storyboard` 来做其他的定制。

![Adding launch icons in Xcode](/images/assets-and-images/ios-launchscreen-xcode.png)
