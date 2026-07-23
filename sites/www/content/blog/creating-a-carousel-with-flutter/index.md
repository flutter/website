---
title: "Creating a Carousel with Flutter"
description: >-
  As a mobile developer, you may find yourself with a design that
  calls for sliding, animated, background-image carousels.
publishDate: 2018-04-09
author: ezra-sandzer-bell
image: images/0-y8UdKzHXj8SEouz.jpg
category: tutorial
layout: blog
---

<DashImage figure src="images/0-y8UdKzHXj8SEouz.jpg" alt="Creating Background Image Carousels with Flutter" caption="Creating Background Image Carousels with Flutter" />

As a mobile developer, you may find yourself with a design that calls for sliding, animated, background-image carousels. In this article, I will review some of the existing documentation for implementing a carousel in Flutter, and fill you in on the information gaps so that you have everything you need to get started!

If you are brand new to Flutter, please begin with the setup process: [https://flutter.io/get-started/](https://flutter.io/get-started/)

The Carousel plugin we will be working with was published January 21, 2018 by Gabriel Valério: [https://pub.dartlang.org/packages/carousel](https://pub.dartlang.org/packages/carousel)

You can follow along with this article to create the project from scratch, but if you want the fast-track, I’ve posted the complete project on github: [https://github.com/ezrasandzerbell/FLUTTER-carousel-demo](https://github.com/ezrasandzerbell/FLUTTER-carousel-demo)

I will be using Android Studio for this walkthrough. Your first step will be to create a new Flutter Project. When the project has been created, navigate to the **pubspec.yaml** file located at the top level of your project directory:

```yaml
name: carousel_demo
description: Carousel_Demo

dependencies:
  flutter:
    sdk: flutter
  carousel: ^0.1.0
```

As shown above, you will need to add “**carousel: ^0.1.0**” directly under the flutter SDK dependency. This communicates to the app that you want to add carousel version 0.1.0. The caret (^) prefix indicates that minor patch updates to the specified version are permitted. You can read about the caret prefix [here](https://bytearcher.com/articles/semver-explained-why-theres-a-caret-in-my-package-json/).

<DashImage figure src="images/1my7PRln0pZA7N9WytaYIog.webp" alt="Click “Packages get” after declaring the carousel dependency in your pubspec" caption="Click “Packages get” after declaring the carousel dependency in your pubspec" />

Next, run **flutter packages get.** If you are in Android Studio, you can do this by clicking the hyperlink that sits directly above the pubspec.yaml file. Note that you must be viewing this file specifically to run **packages get.**

Once the package has been installed, navigate to your **main.dart** file where your landing page code currently lives. Delete everything that’s there and replace it with this barebones Hello World script. Notice that we are **importing carousel.dart** at the top of the file:

```dart
import 'package:flutter/material.dart';
import 'package:carousel/carousel.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Carousel',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Carousel Demo'),
        ),
        body: new Center(
          child: new Text('Hello World'),
        ),
      ),
    );
  }
}
```

You can go ahead and run the app at this point to ensure that everything is working as expected. In Android Studio, this is done by clicking the green play button. Once you have started the app, you can press **command+shift+s** to reload the app at any time.

<DashImage figure src="images/13fBpctMQDW1Grz94Brr4jg.webp" alt="Click the Green Play button to run the app. In this example we are using the iOS Simulator." caption="Click the Green Play button to run the app. In this example we are using the iOS Simulator." />

<DashImage figure src="images/1Tqu0lBJy5DfrmgsxjixEwg.webp" alt="This is what you should see upon loading the app." caption="This is what you should see upon loading the app." />

Let’s begin implementing the carousel feature. Your body value will be replaced with a Stack that has two children: a **PageView** and a **ListView**.

The **PageView** will handle our background image, while the ListView holds our “Hello World” text.

```dart
body: new Stack (
    children: <Widget>[
      new PageView(
        children: [testBGCarousel],
      ),
      new ListView(
        children: [
          new Text('This text displays on top of the carousel'),
        ],
      ),
    ]
),
```

Of course, testBGCarousel does not yet exist. In order to load an image into the background, we will have to create a new asset folder. Right click on the project folder and select New > Directory. You can name the directory “images” or something comparable.

<DashImage figure src="images/1_CXIYvhlix6kCN5PaySSdw.webp" />

You can grab three background images at random for the purposes of testing. I like to format them ahead of time so they sit well in the app. Consider using 1000x1472 px with 72 dpi .jpg format. Place these images into the **images** folder that you created.

<DashImage figure src="images/1Q5zBvfcEWWWcHUOlnl7tZw.webp" />

Just to make this extra simple, here are three full-size color templates you can download and use to run this code sample:

<DashImage figure src="images/1XUFqw8TZ281xRUTvp6EERg.webp" />

<DashImage figure src="images/14936vpzIKoyCsk1z0_Xk4w.webp" />

<DashImage figure src="images/1BRF6ceZiW5XXgx78k1L3eQ.webp" alt="Download these three images and use them to test the carousel." caption="Download these three images and use them to test the carousel." />

```dart
      new ListView(
        children: [
          new Text('This text displays on top of the carousel'),
        ],
      ),
```

The aforementioned **ListView** is set up with a single child argument of new Text. I am featuring the ListView here as a placeholder, simply to demonstrate where you would place your list of widgets that sit on top of the PageView. ListViews can hold any variety of children, including Images, form fields, buttons, and so forth.

Next, in your **pubspec.yaml** file, declare these assets like this:

```yaml
name: carousel_demo
description: Carousel_Demo

dependencies:
  flutter:
    sdk: flutter
  carousel: ^0.1.0
  cupertino_icons: ^0.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:
      - images/img1.jpg
      - images/img2.jpg
      - images/img3.jpg
```

This makes the image assets available to your app. Back in the **main.dart** file, add this carousel code to introduce the images:

```dart
class MyApp extends StatelessWidget {
  @override

  Widget testBGCarousel = new Container(
    child: new Carousel(
      children: [
        new AssetImage('images/img1.jpg'),
        new AssetImage('images/img2.jpg'),
        new AssetImage('images/img3.jpg'),
      ].map((bgImg) => new Image(image: bgImg, width: 1500.0, height: 1500.0, fit: BoxFit.cover)).toList(),
      displayDuration: const Duration(seconds: 1),
    ),
  );


  Widget build(BuildContext context) {
    return new MaterialApp( ... )}
```

I have abbreviated the Widget build to keep the code snippet short. All you need to add in is the testBGCarousel widget. Keep reading for a breakdown on how it works:

**The Children List:** You can add as many AssetImages as you want, provided you keep the correct format. Follow the syntax shown above to access the .jpg files in the image folder you created. Note that *arrays are called [lists](https://api.dartlang.org/stable/1.24.3/dart-core/List-class.html) in Dart*.

**The Map Method:** Mapping is similar to a forEach loop; it takes each element of a list and performs some action. You can read up on Dart’s map method [here](https://api.dartlang.org/stable/1.24.3/dart-core/Iterable/map.html).

```dart
.map((bgImg) => new Image(image: bgImg, width: 1500.0, height: 1500.0, fit: BoxFit.cover)).toList()
```

We are mapping over the list of AssetImages one at a time. The first argument (bgImg) holds the value of the current AssetImage. Next, the fat arrow (`=>`) executes a function where the value of *bgImg* is positioned within a new context. That context is the new Image(…).toList() statement.

**Each New Image:** The first property, *image,* receives the mapped element *bgImg* as a value. Additional properties are assigned. Note that I am using **fit: BoxFit.cover** to automatically fit the images within the box. The large width and height values ensure image scales into a large enough space. Once the new Image is created, the .toList() method pushes that image to a new version of the Carousel’s children List.

```dart
displayDuration: const Duration(seconds: 1),
```

Below the children, the Carousel receives an additional, optional argument on the property **displayDuration** that changes the speed at which the carousel changes images. I added this for easy reference in case you want to do further customization. For additional properties that live on this Carousel widget, check out the **carousel.dart** file by holding the **command** key and left-clicking on the word Carousel within your file:

<DashImage figure src="images/1cO4d8OZCrc3jwJnIWw4Lmw.webp" alt="Command + Click the word Carousel to view carousel.dart" caption="Command + Click the word Carousel to view carousel.dart" />

```dart
Carousel({
  this.children,
  this.animationCurve = Curves.ease,
  this.animationDuration = const Duration(milliseconds: 250),
  this.displayDuration = const Duration(seconds: 2)
}) :
```

To customize animation duration and curve, command + click on the property names to view your options. When you know what you want, you can add the new properties following the *displayDuration* format shown in the testBGCarousel example.

Reload your app and voila, you have a working carousel. Here is the complete code:

```dart
import 'package:flutter/material.dart';
import 'package:carousel/carousel.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override

Widget testBGCarousel = new Container(
    child: new Carousel(
      children: [
        new AssetImage('images/img1.jpg'),
        new AssetImage('images/img2.jpg'),
        new AssetImage('images/img3.jpg'),
      ].map((bgImg) => new Image(image: bgImg, width: 1500.0, height: 1500.0, fit: BoxFit.cover)).toList(),
      displayDuration: const Duration(seconds: 1),
    ),
  );

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Carousel',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Carousel Demo'),
        ),
        body: new Stack (
           children: <Widget>[
             new PageView(
               children: [testBGCarousel],
             ),
             new ListView(
             children: [
                 new Text('Text on top of the carousel'),
               ],
             ),
           ]
        ),
      ),
    );
  }
}
```
