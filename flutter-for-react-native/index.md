---
layout: page
title: Flutter for React Native Developers
permalink: /flutter-for-react-native/
---
>> This is an edit-in-progress.


>> Document purpose:  To provide React Native developers information to quickly come up to speed using Flutter.
This document describes fundamental differences and similarities between using Flutter and React Native to create mobile apps. Basic concepts are described to provide React developers what they need to know to user Flutter.  You can find the full Flutter documentation at [Flutter.io](https://flutter.io/)  

If you've been creating apps in React Native, you'll find helpful information in this document to help you come up to speed fast and create your first Flutter app.

#### Audience
This document is for the following audience.
* React Native developers who want to apply their existing React Native experience to quickly build Flutter mobile apps.
* Developers with a fundamental knowledge of the React Native framework who would like to jump start their Flutter mobile app development.

*****  

* TOC Placeholder
{:toc}
*****

## Introduction to Dart for JavaScript Developers

Like React Native, Flutter provides reactive-style views — however, Flutter takes a different approach to avoid performance problems caused by the need for a JavaScript bridge by using a compiled programming language, [Dart](https://www.dartlang.org/). Dart is compiled “ahead of time” (AOT) into native code for multiple platforms which allows Flutter to communicate with the platform without going through a JavaScript bridge.  

Dart is an easy language to learn and offers the following features:
* Provides an open-source, scalable programming language for building web, server, and mobile apps.
* Provides an object-oriented, single inheritance language that uses a C-style syntax that is AOT-compiled into native.
* Transcompiles optionally into JavaScript.
* Supports interfaces and abstract classes.

A few examples of the differences between JavaScript and Dart are described below.

### Entry point

While JavaScript doesn't have a pre-defined entry function, Dart uses a pre-defined entry function called `main()`.

<!-- skip -->
```JavaScript
// JavaScript
function main() {
  // Can be used as entry point
}
```
In Dart, every app must have a top-level `main()` function, which serves as the entry point to the app.

<!-- skip -->
```Dart
// Dart
main() {
}
```



Try it out in [DartPad](https://dartpad.dartlang.org/0df636e00f348bdec2bc1c8ebc7daeb1).

### Printing to the console

To print to the console in Dart, use `print`.

<!-- skip -->
```JavaScript
// JavaScript
console.log("Hello world");
```

<!-- skip -->
```Dart
// Dart
print('Hello world');
```

Try it out in [DartPad](https://dartpad.dartlang.org/cf9e652f77636224d3e37d96dcf238e5).


### Variables

Dart is type safe: it uses a combination of static type checking and runtime checks to ensure that a variable’s value always matches the variable’s static type. Although types are mandatory, type annotations are optional because Dart performs type inference.

#### Creating and assigning variables

In JavaScript, variables cannot be typed.

In [Dart](https://www.dartlang.org/dart-2), variables must either be explicitly typed or the type system must infer the proper type automatically.

<!-- skip -->
```JavaScript
// JavaScript
var name = "JavaScript";
```

<!-- skip -->
```Dart
// Dart
String name = 'dart';
var otherName = 'Dart'; // Also inferred to be a String.
// Both are acceptable in Dart.
```

Try it out in [DartPad](https://dartpad.dartlang.org/3f4625c16e05eec396d6046883739612).

For more information, see [Dart's Type System](https://www.dartlang.org/guides/language/sound-dart)

#### Default value

In JavaScript, uninitialized variables are `undefined`.

In Dart, uninitialized variables have an initial value of `null`. Because numbers are objects in Dart, even variables with numeric types are initially `null`.

<!-- skip -->
```JavaScript
// JavaScript
var name; // == undefined
```

<!-- skip -->
```Dart
// Dart
var name; // == null
int x; // == null
```

Try it out in the [DartPad](https://dartpad.dartlang.org/57ec21faa8b6fe2326ffd74e9781a2c7).

For more information, see the documentation on [variables](https://www.dartlang.org/resources/dart-tips/dart-tips-ep-3).

### Checking for null or zero

In JavaScript, values of 1 or any non-null objects are treated as true.

<!-- skip -->
```JavaScript
// JavaScript
var myNull = null;
if (!myNull) {
  console.log("null is treated as false");
}
var zero = 0;
if (!zero) {
  console.log("0 is treated as false");
}
```
In Dart, only the boolean value `true` is treated as true.

<!-- skip -->
```Dart
// Dart
var myNull = null;
if (myNull == null) {
  print('use "== null" to check null');
}
var zero = 0;
if (zero == 0) {
  print('use "== 0" to check zero');
}
```

Try it out in [DartPad](https://dartpad.dartlang.org/c85038ad677963cb6dc943eb1a0b72e6).

### Functions

Dart and JavaScript functions are generally similar. The primary difference is the declaration.

<!-- skip -->
```JavaScript
// JavaScript
function fn() {
  return true;
}
```

<!-- skip -->
```Dart
// Dart
fn() {
  return true;
}
// can also be written as
bool fn() {
  return true;
}
```

Try it out in [DartPad](https://dartpad.dartlang.org/5454e8bfadf3000179d19b9bc6be9918).

For more information, see the documentation on [functions](https://www.dartlang.org/resources/dart-tips/dart-tips-ep-6).

### Asynchronous programming
#### Futures

JavaScript and Dart support single-threaded execution.  

In JavaScript, the `Promise` object represents the eventual completion or failure of an asynchronous operation and the resulting value.

In Dart, the [`Future`](https://www.dartlang.org/tutorials/language/futures) object  represents the eventual completion or failure of an asynchronous operation and the resulting value.

<!-- skip -->
```JavaScript
// JavaScript
_getIPAddress = () => {
  const url="https://httpbin.org/ip";
  return fetch(url)
    .then(response => response.json())
    .then(responseJson => {
      console.log(responseJson.origin);
    })
    .catch(error => {
      console.error(error);
    });
};
```



<!-- skip -->
```Dart
// Dart
_getIPAddress() {
  final url = 'https://httpbin.org/ip';
  HttpRequest.request(url).then((value) {
      print(json.decode(value.responseText)['origin']);
  }).catchError((error) => print(error));
}
```

Try it out in [DartPad](https://dartpad.dartlang.org/b68eb981456c5eec03daa3c05ee59486).

For more information, see the documentation on [Futures](https://www.dartlang.org/tutorials/language/futures).  

#### `async` and `await`

The `async` function declaration defines an asynchronous function.  

In JavaScript, the `async` function returns a `Promise`. The `await` operator is used to wait for a `Promise`.

<!-- skip -->
```JavaScript
// JavaScript
async _getIPAddress() {
  const url="https://httpbin.org/ip";
  const response = await fetch(url);
  const json = await response.json();
  const data = await json.origin;
  console.log(data);
}
```

In Dart, an `async` function returns a `Future`, and the body of the function is scheduled for execution later. The `await` operator is used to wait for a `Future`.

<!-- skip -->
```Dart
// Dart
_getIPAddress() async {
  final url = 'https://httpbin.org/ip';
  var request = await HttpRequest.request(url);
  String ip = json.decode(request.responseText)['origin'];
  print(ip);
}
```

Try it out in [DartPad](https://dartpad.dartlang.org/96e845a844d8f8d91c6f5b826ef38951).

For more information, see the [`async` and `await`](https://www.dartlang.org/guides/language/language-tour#asynchrony-support) documentation.

## The Basics
### How do I create a Flutter app?

To create an app using React Native, you would run `create-react-native-app` from the command line.

<!-- skip -->
```JavaScript
$ create-react-native-app {projectname}
```

To create a app using Flutter, use the `flutter create` command from the command line. Run the command from the directory that includes the Flutter SDK.

<!-- skip -->
```
$ flutter create {projectname}
```
For more information, see the [Get Started: Overview](https://flutter.io/get-started/) tutorial that walks you through creating a button-click counter app. The tutorial includes all the files that you need to run the app on both Android and iOS devices.


### How do I run my app?

To run an app in React Native, from the project directory, the
`npm run ios/android` or `yarn run ios/android` commands are used.

```JavaScript
// React Native
$ npm run ios/android

//or

$ yarn run ios/android
```


In Flutter, if you're using the terminal,  from the project root directory, use `flutter run`.  

```Dart
//
flutter run
```

If you're using an IDE like IntelliJ, Android Studio, or VS Code with the Flutter plugin installed, then use the IDE tools to run the app. Your app will run on a connected device or simulator.  

Most IDEs identify a Flutter app as a *project*.

For more information, see the Flutter [Getting Started](https://flutter.io/get-started/) documentation.

### How do I use import statements?

In React Native, you need to import each required component.

<!-- skip -->
```JavaScript
//React Native
import React from "react";
import { StyleSheet, Text, View } from "react-native";
```
<!-- skip -->
In Flutter, you only need to import `material.dart`.

```Flutter
import 'package:flutter/material.dart';
```




The `material.dart` package allows you to use any Material Design widget without explicitly importing them. Dart automatically imports only the widgets that are actually used in your app.

Flutter includes additional pre-defined visual, structural, platform, and interactive widgets that you can import — such as the `cupertino` widgets for the current iOS design language. You can import the basic pre-defined `widgets` or your own custom widget library as shown below.

<!-- skip -->
```Dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/my_widgets.dart';
```

For more information, see the [Flutter Widgets Catalog](https://flutter.io/widgets/).

### What is the equivalent of the React Native Hello world! app in Flutter?

In React Native, the `HelloWorldApp` class extends `React.Component` and implements the render method by returning a view component.

<!-- skip -->
```JavaScript
// React Native
import React from "react";
import { StyleSheet, Text, View } from "react-native";

export default class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Hello world!</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center"
  }
});
```
In Flutter, to create an identical Hello world! app, use the entry point `main` function to call the [`runApp()`](https://docs.flutter.io/flutter/widgets/runApp.html) function. The basic Flutter app simply calls the `runApp()` function with a `Center` widget. The `runApp()` function takes the `Center` widget and makes it the root of the widget tree. The widget tree in this example includes the `Center` root widget and the `Text` child widget.




<!-- skip -->
```Dart
// Flutter
import 'package:flutter/material.dart';

void main() {
  runApp(
    new Center(
      child: new Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}

```

#### Preview  

The following image shows the Android and iOS UI for the basic Flutter Hello, world! app.  

|Android |iOS |
|:---:|:--:|
|<img src="/flutter-for-react-native/images/hello_world_basic_android.png?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/hello_world_basic_iOS.png?raw=true" style="width:300px;" alt="Loading">|  

<br>
Now that you’ve created a basic app using Flutter, the next section describes how you can enhance the UI using Flutter widgets.  
### How do I use widgets and nest them to form a widget tree?  

In Flutter, almost everything is a widget.

Widgets are the basic building blocks of a Flutter app’s user interface and they form a hierarchy based on composition. Each widget nests inside, and inherits properties from its parent. There is no separate “application” object. Instead, the root widget serves this role.

A widget can define:

* A structural element — like a button or menu  
* A stylistic element — like a font or color scheme  
* An aspect of layout — like padding or alignment  

The example below shows a modified Flutter Hello world! app that includes an enhanced UI using pre-defined Flutter widgets. In this example, the widget tree is nested inside the `MaterialApp` root widget.


<!-- skip -->
```Dart
// Flutter
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new Text('Hello World'),
        ),
      ),
    );
  }
}

```
#### Preview

The following image shows the Hello world! app UI that was enhanced using the Flutter Material Design widgets.

|Android |iOS |
|:---:|:--:|
|<img src="/flutter-for-react-native/images/6b18b6e158b15685.png?raw=true" style="width:275px;" alt="Loading">|<img src="/flutter-for-react-native/images/2e973d40d6e82114.png?raw=true" style="width:300px;" alt="Loading">|  

<br>
When writing an app, you commonly author new widgets that are subclasses of either a  [StatelessWidget](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html) or [StatefulWidget](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html), depending on whether your widget manages state changes.

In the above Hello world! example, the `MyApp` class extends a StatelessWidget and overrides a pre-defined `build` function that returns a tree or hierarchy of widgets.

The widget tree consists of the following five widgets: the [MaterialApp](https://docs.flutter.io/flutter/material/MaterialApp-class.html) root widget, [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html), [AppBar](https://docs.flutter.io/flutter/material/AppBar-class.html), [Center](https://docs.flutter.io/flutter/widgets/Center-class.html), and [Text](https://docs.flutter.io/flutter/widgets/Text-class.html) widgets.

The `MaterialApp` widget wraps a number of widgets that are commonly required for Material Design applications and the `Scaffold` widget implements the basic Material Design visual layout structure.

When you are creating an app that uses Material Design, use the [MaterialApp](https://docs.flutter.io/flutter/material/MaterialApp-class.html) class as the root and define a theme that can be accessed across the app. And when you create a screen, use the [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget which creates a visual scaffold for Material Design widgets.

In simple or basic apps it's easy to nest widgets, but as the code base gets larger and the app becomes complex, you should break deeply nested widgets into functions that return the widget or smaller classes. Creating separate functions and widgets allows you to reuse the components within the app.  

### How do I create reusable components?

In React Native, you define a class to create a reusable component and then use `props` to access the passed variables and functions. In the example below, the `CustomCard` class is defined and then used inside a parent class.

<!-- skip -->
```JavaScript
// React Native
class CustomCard extends React.Component {
  render() {
    return (
      <View>
        <Text > Card {this.props.index} </Text>
        <Button
          title="Press"
          onPress={() => this.props.onPress(this.props.index)}
        />
      </View>
    );
  }
}

// Usage
<CustomCard onPress={this.onPress} index={item.key} />
```

In Flutter, you define a class to create a custom widget and then reuse the widget.
You can also define and call a function that returns a reusable widget as shown in the `build` function in the following example.

<!-- skip -->
{% prettify dart %}

// Flutter
class CustomCard extends StatelessWidget {
  [[highlight]]CustomCard({@requiredthis.index, @required this.onPress});[[/highlight]]

  final index;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Text('Card $index'),
          new FlatButton(
            child: const Text('Press'),
            onPressed: this.onPress,
          ),
        ],
      )
    );
  }
}
    ...
// Usage
new CustomCard(
  [[highlight]]index: index,
  onPress: () [[/highlight]]{
    print('Card $index');
  },
)
    ...

{% endprettify %}

In the example above, the constructor for the `CustomCard` class shows a Dart feature. In Dart, a parameter wrapped by curly braces `{ }` is a named optional parameter.

To make these fields required, remove the curly braces from the constructor, or add `@required` to the constructor. The parameter names in the `CustomCard` class are required and the `// Usage` section in the example above shows their use.


#### Preview
The following Android and iOS UI shows the reusable widgets in the Modular Widgets app.

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/android.png?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/iOS.png?raw=true" style="width:300px;" alt="Loading">|

<br>


## Project Structure & Resources
### Where do I start writing the code?

Start with the `main.dart` file. It's created automatically when you create a Flutter app.

```dart
// Dart
void main(){
 print("Hello, this is the main function.");
}
```
If you've used `create-react-native-app`, then you wrote your code inside `App.js`.  

In Flutter, the entry point file is `’projectname’/lib/main.dart` and execution starts from the `main` function.



### How are files structured in a Flutter app?
When you create a new Flutter project, the following default directory structure is built.  You can customize it later, but this is where you’ll start.
<pre>
┬
└ projectname
  ┬
  ├ android      - Contains Android-specific files.
  ├ build        - Stores iOS and Android build files.
  ├ ios          - Contains iOS-specific files.
  ├ lib          - Contains externally accessible Dart source files.
    ┬
    └ src        - Contains additional source files.
    └ main.dart  - The Flutter entry point and the start of a new app.
                   This is created automatically when you create a Flutter project.
                   It's where you start writing your Dart code.
  ├ test         - Contains automated test files.
  └ pubspec.yaml - Contains the metadata for the Flutter app.
                   This is equivalent to the package.json file in React Native.
</pre>

### Where do I put my resources and assets and how do I use them?

A Flutter resource or asset is a file that is bundled and deployed with your app and is accessible at runtime. Flutter apps can include the following asset types:
* Static data such as JSON files  
* Configuration files  
* Icons and images (JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, and WBMP)

Flutter uses the `pubspec.yaml` file, located at the root of your project, to identify assets required by an app.

```yaml
flutter:
  assets:
    - assets/my_icon.png
    - assets/background.png
```

The `assets` subsection specifies files that should be included with the app. Each asset is identified by an explicit path relative to the `pubspec.yaml` file, where the asset file is located. The order in which the assets are declared does not matter. The actual directory used (`assets` in this case) does not matter. However, while assets can be placed in any app directory, it's a best practice to place them in the `assets` directory.

During a build, Flutter places assets into a special archive called the asset bundle, which apps read from at runtime.
When an asset’s path is specified in the assets section of `pubspec.yaml`, the build process looks for any files with the same name in adjacent subdirectories. These files are also included in the asset bundle along with the specified asset. Flutter uses asset variants when choosing resolution appropriate images for your app.

In React Native, to add a static image to your app, place the image file in a source code directory and reference it.

<!-- skip -->
```JavaScript
<Image source={require("./my-icon.png")} />
```

In Flutter, to add a static image to your app, use the `AssetImage` class in a widget’s build method.

<!-- skip -->
```Dart
image: new AssetImage('assets/background.png'),
```

For more information, see [Adding Assets and Images in Flutter](https://flutter.io/assets-and-images/).

### How do I load images over a network?

In React Native, you specify the `uri` in the `source` prop of the `Image` component and also provide the size if needed.

In Flutter, use the `new Image.network` constructor to include an image from a URL.

<!-- skip -->
```Dart
// Flutter
body: new Image.network(
          'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
```

### How do I install packages and package plugins?
Flutter supports using shared packages contributed by other developers to the Flutter and Dart ecosystems. This allows you to quickly build your app without having to develop everything from scratch. Packages that contain platform-specific code are known as package plugins.

In React Native, you use `yarn add {package-name}` or `npm install --save {package-name}` to install packages from the command line.

In Flutter, to install a package:

1. Add the package name and version to the `pubspec.yaml` dependencies section.  
The example below shows how to add the `google_sign_in` Dart package to the `pubspec.yaml` file. Remember to check your spaces when working in the YAML file.  
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_sign_in: "^3.0.3"
```

2. Install the package from the command line by running `flutter packages get`.
3. Import the package into your app code as shown below:
<!-- skip -->
```Dart
import 'package:google_sign_in/google_sign_in.dart';
```

For more information, see [Using Packages](https://flutter.io/using-packages/) and [Developing Packages & Plugins](https://flutter.io/developing-packages/).

For a list of top Flutter packages and their descriptions, see [Flutter Packages](https://pub.dartlang.org/flutter/).

## Flutter widgets

In Flutter, you build your UI out of widgets that describe what their view should look like given their current configuration and state.

Widgets are often composed of many small, single-purpose widgets that combine to produce powerful effects. For example, the Container widget consists of several widgets responsible for layout, painting, positioning, and sizing. Specifically, the `Container` widget includes the `LimitedBox`, `ConstrainedBox`, `Align`, `Padding`, `DecoratedBox`, and `Transform` widgets. Rather than subclassing `Container` to produce a customized effect, you can compose these and other simple widgets in new and unique ways.

The `Center` widget is another example of how you can control the layout. To center a widget, you can wrap it in a `Center` widget and then use layout widgets for alignment, row, columns, and grids. These layout widgets do not have a visual representation of their own. Instead, their sole purpose is to control some aspect of another widget’s layout. To understand why a widget renders in a certain way, it’s often helpful to inspect the neighboring widgets.

For more information, see the [Flutter Technical Overview](https://flutter.io/technical-overview/).

For specific information about pre-defined Flutter widgets, see [Flutter Basic Widgets](https://flutter.io/widgets/basics/), the [Flutter Widget Catalog](https://flutter.io/widgets/), or the [Flutter Widget Index](https://flutter.io/widgets/widgetindex/).

### Views
### What is the equivalent of the `View` container?

In React Native, `View` is a container that supports layout with **`Flexbox`**, style, touch handling, and accessibility controls.

In Flutter, you can draw from a  library of pre-defined layout widgets such as the [Container](https://docs.flutter.io/flutter/widgets/Container-class.html), [Column](https://docs.flutter.io/flutter/widgets/Column-class.html), [Row](https://docs.flutter.io/flutter/widgets/Row-class.html), and [Center](https://docs.flutter.io/flutter/widgets/Center-class.html) widgets.

 You can also use higher-level widgets like the [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget, which provides options for showing drawers, snack bars, and bottom sheets. Higher-level widgets are built from lower-level widgets using composition instead of inheritance.

For more information, see the [Layout Widgets](https://flutter.io/widgets/layout/) catalog.

### What is the equivalent of `FlatList` or `SectionList`?

A `List` is a scrollable list of components arranged vertically.

In React Native, `FlatList` or `SectionList` are used to render simple or sectioned lists.

<!-- skip -->
```JavaScript
// React Native
<FlatList
  data={[ ... ]}
  renderItem={({ item }) => <Text>{item.key}</Text>}
/>
```

In Flutter, [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html) is Flutter's most commonly used scrolling widget. The default constructor takes an explicit list of children. It is appropriate to use [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html) for a small number of widgets. The `ListView.builder` constructor takes an `IndexedWidgetBuilder`, which builds the children on demand. This constructor is appropriate for list views with a large or infinite number of children because the builder is called only for those children that are actually visible.

<!-- skip -->
```Dart
// Flutter
var data = [ ... ];
new ListView.builder(
  itemCount: data.length,
  itemBuilder: (context, int index) {
    return new Text(
      data[index],
    );
  },
)
```

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/flatlist_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/flatlist_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

<br>

### How do I use a Canvas to draw or paint?

In React Native, canvas components aren't present so third party libraries like `react-native-canvas` are used.

<!-- skip -->
```JavaScript
// React Native
handleCanvas = canvas => {
  const ctx = canvas.getContext("2d");
  ctx.fillStyle = "skyblue";
  ctx.beginPath();
  ctx.arc(75, 75, 50, 0, 2 * Math.PI);
  ctx.fillRect(150, 100, 300, 300);
  ctx.stroke();
};

render() {
  return (
    <View>
      <Canvas ref={this.handleCanvas} />
    </View>
  );
}
```
In Flutter, you can use the [`CustomPaint`](https://docs.flutter.io/flutter/widgets/CustomPaint-class.html)  and [`CustomPainter`](https://docs.flutter.io/flutter/rendering/CustomPainter-class.html) classes to draw to the canvas.

The example below shows how you would use the `CustomPaint` widget to draw during the paint phase. It also shows how you would implement the abstract class `CustomPainter`and pass it to the painter property in the `CustomPaint` widget. `CustomPaint` subclasses must implement the `paint` and `shouldRepaint` methods.

<!-- skip -->
```Dart
// Flutter
class MyCanvasPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.amber;
    canvas.drawCircle(new Offset(100.0, 200.0), 40.0, paint);
    Paint paintRect = new Paint();
    paintRect.color = Colors.lightBlue;
    Rect rect = new Rect.fromPoints(new Offset(150.0, 300.0), new Offset(300.0, 400.0));
    canvas.drawRect(rect, paintRect);
  }

  bool shouldRepaint(MyCanvasPainter oldDelegate) => false;
  bool shouldRebuildSemantics(MyCanvasPainter oldDelegate) => false;
}
class _MyCanvasState extends State<MyCanvas> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomPaint(
        painter: new MyCanvasPainter(),
      ),
    );
  }
}
```

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/canvas_android.png?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/canvas_iOS.png?raw=true" style="width:300px;" alt="Loading">|

<br>

### Layouts
### How do I use widgets to define layout properties?

In React Native, most of the layout can be done with the props that are passed to a specific component. For example, you could use the `style` prop on the `View` component in order to specify the flexbox properties. To arrange your components in a column,
you would specify a prop such as: `flexDirection: “column”`.

<!-- skip -->
```JavaScript
// React Native
<View
  style={%raw%}{{
    flex: 1,
    flexDirection: "column",
    justifyContent: "space-between",
    alignItems: "center"
  }}{%endraw%}
>
```

In Flutter the layout is primarily defined by widgets that are specifically designed to provide layout — and the combination of the type of widget that you choose and its layout and style properties.

For example, the [Column](https://docs.flutter.io/flutter/widgets/Column-class.html) and [Row](https://docs.flutter.io/flutter/widgets/Row-class.html) widgets take an array of children and align them vertically and horizontally respectively. A [Container](https://docs.flutter.io/flutter/widgets/Container-class.html) widget takes a combination of layout and styling properties, and a  [`Center`](https://docs.flutter.io/flutter/widgets/Center-class.html) widget centers its child widgets.


<!-- skip -->
```Dart
// Flutter
new Center(
  child: new Column(
    children: <Widget>[
      new Container(
        color: Colors.red,
        width: 100.0,
        height: 100.0,
      ),
      new Container(
        color: Colors.blue,
        width: 100.0,
        height: 100.0,
      ),
      new Container(
        color: Colors.green,
        width: 100.0,
        height: 100.0,
      ),
    ],
  ),
)
```
Flutter provides a library of pre-defined layout widgets such as  [`Padding`](https://docs.flutter.io/flutter/widgets/Padding-class.html), [`Align`](https://docs.flutter.io/flutter/widgets/Align-class.html), [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html).

For more information, see [Layout Widgets](https://flutter.io/widgets/layout/).

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/basic_layout_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/basic_layout_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

<br>

### How do I layer widgets?

In React Native, components can be layered using `absolute` positioning.

Flutter uses the [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html) widget to arrange children widgets in layers one over another. The widgets can entirely or partially overlap the base widget.

The `Stack` widget positions its children relative to the edges of its box. This class is useful if you simply want to overlap several children.

<!-- skip -->
```Dart
// Flutter
new Stack(
  alignment: const Alignment(0.6, 0.6),
  children: <Widget>[
    new CircleAvatar(
      backgroundImage: new NetworkImage(
        "https://avatars3.githubusercontent.com/u/14101776?v=4"),
    ),
    new Container(
      decoration: new BoxDecoration(
          color: Colors.black45,
      ),
      child: new Text('Flutter'),
    ),
  ],
)
```

The above example uses `Stack` to overlay a Container (that displays its `Text` on a translucent black background) on top of a `CircleAvatar`. The Stack offsets the text using the alignment property and Alignment coordinates.

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/stack_android.png?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/stack_iOS.png?raw=true" style="width:300px;" alt="Loading">|

<br/>

For more information, see the [Stack](https://docs.flutter.io/flutter/widgets/Stack-class.html) class documentation.
### Styling
### How do I custom style my components?

In React Native, inline styling and `stylesheets.create` are used to custom style components.

<!-- skip -->
```JavaScript
// React Native
<View style={styles.container}>
  <Text style={%raw%}{{ fontSize: 32, color: "cyan", fontWeight: "600" }}{%endraw%}>
    This is a sample text
  </Text>
</View>

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center"
  }
});
```

In Flutter, widgets are highly customizable and layout specific components like [`Padding`](https://docs.flutter.io/flutter/widgets/Padding-class.html), [`Center`](https://docs.flutter.io/flutter/widgets/Center-class.html), [`Card`](https://docs.flutter.io/flutter/material/Card-class.html), [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html) etc. can be used. A `Text` widget can take a `TextStyle` class for its style property. If you want to use the same text style in multiple places, you can create a [`TextStyle`](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) class and use it for multiple `Text` widgets.

<!-- skip -->
```Dart
// Flutter
var textStyle = new TextStyle(fontSize: 32.0, color: Colors.cyan, fontWeight: FontWeight.w600);
	...
new Center(
  child: new Column(
    children: <Widget>[
      new Text(
        'Sample text',
        style: textStyle,
      ),
      new Padding(
        padding: new EdgeInsets.all(20.0),
        child: new Icon(Icons.lightbulb_outline,
          size: 48.0, color: Colors.redAccent)
      ),
    ],
  ),
)
```

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/flutterstyling_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/flutterstyling_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

<br>

### How do I use `Icons` and `Colors`?

React Native doesn't include support for icons so third party libraries are used.

In Flutter, to use any Material Design widget including the Material Design icons, import the `material.dart` package then use the [`Icons`](https://docs.flutter.io/flutter/material/Icons-class.html) class with the [Icon](https://docs.flutter.io/flutter/widgets/Icon-class.html) class to show specific icons.

<!-- skip -->
```Dart
new Icon(Icons.lightbulb_outline, color: Colors.redAccent)
```

When you use the `Icons` class, make sure you set `uses-material-design: true` in your project's `pubspec.yaml` file in the `flutter` section. This ensures that the `MaterialIcons` font is included in your application. This font is used to display the icons.
{% prettify dart %}
name: my_awesome_application
flutter:
  [[highlight]]uses-material-design: true[[/highlight]]
{% endprettify %}

Flutter also includes a pre-defined [Cupertino (iOS-style)](https://flutter.io/widgets/cupertino/) widget that provides beautiful and high-resolution widgets for the current iOS design language. To include the `CupertinoIcons` font in your app, add a dependency for `cupertino_icons` in your project's `pubspec.yaml` file.
<!-- skip -->
```yaml
name: my_awesome_application
dependencies:
  cupertino_icons: ^0.1.0
```

For more information and to view the available icons, see [`Icons`](https://docs.flutter.io/flutter/material/Icons-class.html).

To customize the colors and styles of Material Components you can pass in a `ThemeData` object to the `MaterialApp` widget then use the  [`Colors`](https://docs.flutter.io/flutter/material/Colors-class.html) class which uses the Material Design [color palette](https://material.io/guidelines/style/color.html).


 The example below shows the primary swatch is set to `blue` and all text selection color is set to `red`.
<!-- skip -->
{% prettify dart %}
class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        [[highlight]]primarySwatch: Colors.blue,[[/highlight]]
        [[highlight]]textSelectionColor: Colors.red[[/highlight]]
      ),
      home: new SampleAppPage(),
    );
  }
}
{% endprettify %}



### How do I add style themes?

In React Native, common themes are defined for components in stylesheets and then used in components.

In Flutter you can add uniform styling for almost everything by defining the styling in the [`ThemeData`](https://docs.flutter.io/flutter/material/ThemeData-class.html) class and passing it to the theme property in the [`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html) widget. The `MaterialApp` widget wraps the other widgets and acts as the app root widget.

<!-- skip -->
```Dart
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.cyan,
        brightness: Brightness.dark,
      ),
      home: new StylingPage(),
    );
  }
```

A `Theme` can be applied even without using the `MaterialApp` widget. The [`Theme`](https://docs.flutter.io/flutter/material/Theme-class.html) widget takes a `ThemeData` in its `data` parameter and applies the `ThemeData` to all of its children widgets as shown below:

<!-- skip -->
```Dart
 @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        primaryColor: Colors.cyan,
        brightness: brightness,
      ),
      child: new Scaffold(
         backgroundColor: Theme.of(context).primaryColor,
              ...
              ...
      ),
    );
  }
```

## State Management
### What are Stateful and Stateless widgets and how do I use them?

In React Native, state-specific components don't exist, but you can call `setState` in any component provided that it manages that state.

<!-- skip -->
```JavaScript
// React Native
export default class BlinkApp extends Component {

  constructor(props) {
    super(props);
    this.state = {
      buttonText: "blink",
      showText: true,
      text: "I love blinking"
    };
    this.toggleBlinkState = this.toggleBlinkState.bind(this);
    var handle;
  }

  toggleBlinkState() {
    if (this.state.buttonText == "blink") {
      handle = setInterval(() => {
        this.setState(previousState => {
          return { showText: !previousState.showText };
        });
      }, 1000);
      this.setState({
        buttonText: "Stop blinking"
      });
    } else {
      clearInterval(handle);
      this.setState({ buttonText: "blink", showText: true });
    }
  }

  render() {
    let display = this.state.showText ? this.state.text : " ";
    return (
      <View style={%raw%}{{ flex: 1, justifyContent: "center", alignItems: "center" }}{%endraw%}>
        <StatusBar hidden={true} />
        <Text>{display} </Text>
        <Button onPress={this.toggleBlinkState} title={this.state.buttonText} />
      </View>
    );
  }
}
```

In Flutter, two of the most common widgets that you'll use are the [StatefulWidget](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html) and the [StatelessWidget](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html).


#### The StatelessWidget

A `StatelessWidget` is widget that doesn't require a state change — it has no internal state to manage.

 Stateless widgets are useful when the part of the user interface you are describing does not depend on anything other than the configuration information in the object itself and the [`BuildContext`](https://docs.flutter.io/flutter/widgets/BuildContext-class.html) in which the widget is inflated.

 [Icons](https://docs.flutter.io/flutter/material/Icons-class.html), [IconButton](https://docs.flutter.io/flutter/material/IconButton-class.html), and [Text](https://docs.flutter.io/flutter/widgets/Text-class.html) are examples of stateless widgets, which subclass [StatelessWidget](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html).


<!-- skip -->
```Dart
// Flutter
import 'package:flutter/material.dart';

void main() => runApp(new MyStatelessWidget(text: "StatelessWidget Example to show immutable data"));

class MyStatelessWidget extends StatelessWidget {
  final String text;
  MyStatelessWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        text,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
```

In the above example, you use the constructor of the `MyStatelessWidget` class to pass the `text`, which is marked as `final`. Because this class extends `StatelessWidget`, it can have immutable data.

The `build` method of a stateless widget is typically only called in three situations:
* When the widget is inserted into the tree
* When the widget's parent changes its configuration
* When an [`InheritedWidget`](https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html) it depends on changes

#### The StatefulWidget

A [StatefulWidget](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html) is a widget that changes state. Use the `setState` method to manage the state changes for a `StatefulWidget`. A call to `setState` tells the Flutter framework that something has changed in a state, which causes an app to rerun the `build` method so that the app can reflect the change.

State is information that can be read synchronously when a widget is built and might change during the lifetime of the widget. It's the responsibility of the widget implementer to ensure that the state is promptly notified when the state changes. You use `StatefulWidget` when a part of the user interface you are describing can change dynamically.

The state of the widget changes when a user interacts with a `StatefulWidget` by typing into a form, or moving a slider for example, or  when it changes over time — perhaps a data feed causes the UI to update.

 [Checkbox](https://docs.flutter.io/flutter/material/Checkbox-class.html), [Radio](https://docs.flutter.io/flutter/material/Radio-class.html), [Slider](https://docs.flutter.io/flutter/material/Slider-class.html), [InkWell](https://docs.flutter.io/flutter/material/InkWell-class.html), [Form](https://docs.flutter.io/flutter/widgets/Form-class.html), and [TextField](https://docs.flutter.io/flutter/material/TextField-class.html) are examples of stateful widgets, which subclass [StatefulWidget](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html).

The example below shows how to define a `StatefulWidget` and use `createState` to create a state of the `MyStatefulWidget`.

<!-- skip -->
```Dart
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyStatefulWidgetState createState() => new _MyStatefulWidgetState();
}
```

The following example shows how the state implements the `build` function and also how the `setState` function is used to rebuild — or call the build function of the stateful `_MyStatefulWidgetState` widget. A `Timer` is used to periodically call `toggleShowText()` that uses a `setState()` method to set `showText` and rebuild.

<!-- skip -->
```Dart
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool showtext=true;
  bool toggleState=true;
  Timer t2;

  void toggleBlinkState(){
    setState((){
      toggleState=!toggleState;
    });
    var twenty = const Duration(milliseconds: 1000);
    if(toggleState==false) {
      t2 = new Timer.periodic(twenty, (Timer t) {
        toggleShowText();
      });
    } else {
      t2.cancel();
    }
  }

  void toggleShowText(){
    setState((){
      showtext=!showtext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            (showtext
              ?(new Text('This execution will be done before you can blink.'))
              :(new Container())
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 70.0),
              child: new RaisedButton(
                onPressed: toggleBlinkState,
                child: (toggleState
                  ?( new Text("Blink"))
                  :(new Text("Stop Blinking"))
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
```

### What are the Stateful and Stateless widget best practices?

#### 1. Determine whether a widget should be Stateful or Stateless


In Flutter, widgets are either Stateful or Stateless — depending on whether they depend on a state change.
* If a widget changes — the user interacts with it or a data feed interrupts the UI, then it’s Stateful.

* If a widget is final or immutable, then it's Stateless.

#### 2. For Stateful widgets, determine which object manages the widget’s state.

In Flutter, there are three main ways to manage state:
* The widget manages its own state
* The parent widget manages the widget’s state
* A mix-and-match approach

When deciding which approach to use, consider the following principles:
* If the state in question is user data, for example the checked or unchecked mode of a checkbox, or the position of a slider, then the state is best managed by the parent widget.
* If the state in question is aesthetic, for example an animation, then the widget itself best manages the state.
* When in doubt, let the parent widget manage the child widget's state.

#### 3. Subclass the StatefulWidget and State.

The `MyStatefulWidget` class manages its own state — it extends `StatefulWidget`, it overrides the `createState()` method to create the State object, and the framework calls `createState()` to build the widget. In this example, `createState()` creates an instance of `_MyStatefulWidgetState` , which is implemented in the next best practice.

<!-- skip -->
```Dart
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyStatefulWidgetState createState() => new _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override
  Widget build(BuildContext context) {
    ...
  }
}
```

#### 4. Add the StatefulWidget into the widget tree.

Add your custom `StatefulWidget` to the widget tree in the app’s build method.

<!-- skip -->
```Dart
class MyStatelessWidget extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyStatefulWidget(title: 'State Change Demo'),
    );
  }
}
```

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/state_change_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/state_change_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

<br>

### Props

In React Native, most components can be customized when they are created with different parameters. These creation parameters are called props. These parameters can be used in a child component using `this.props`.

<!-- skip -->
```JavaScript
// React Native
class CustomCard extends React.Component {
  render() {
    return (
      <View>
        <Text> Card {this.props.index} </Text>
        <Button
          title="Press"
          onPress={() => this.props.onPress(this.props.index)}
        />
      </View>
    );
  }
}
class App extends React.Component {

  onPress = index => {
    console.log("Card ", index);
  };

  render() {
    return (
      <View>
        <FlatList
          data={[ ... ]}
          renderItem={({ item }) => (
            <CustomCard onPress={this.onPress} index={item.key} />
          )}
        />
      </View>
    );
  }
}
```

In Flutter, you assign a local variable or function marked `final` with the prop received in the parameterised constructor and use it in the subsequent code.

<!-- skip -->
```Dart
// Flutter
class CustomCard extends StatelessWidget {

  CustomCard({@required this.index, @required this.onPress});
  final index;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
  return new Card(
    child: new Column(
      children: <Widget>[
        new Text('Card $index'),
        new FlatButton(
          child: const Text('Press'),
          onPressed: this.onPress,
        ),
      ],
    ));
  }
}
    ...
//Usage
new CustomCard(
  index: index,
  onPress: () {
    print('Card $index');
  },
)
```


#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/modular_android.png?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/modular_iOS.png?raw=true" style="width:300px;" alt="Loading">|

<br>

### Local Storage
#### How do I store persistent key-value pairs that are global to the app?

In React Native, you use the `setItem` and `getItem` functions of the `AsyncStorage` component to store and retrieve data that is persistent and global to the whole app.

<!-- skip -->
```JavaScript
// React Native
await AsyncStorage.setItem( "counterkey", json.stringify(++this.state.counter));
AsyncStorage.getItem("counterkey").then(value => {
  if (value != null) {
    this.setState({ counter: value });
  }
});
```

In Flutter, use [`shared_preferences`](https://github.com/flutter/plugins/tree/master/packages/shared_preferences) to store and retrieve data that is persistent and global to the whole app. It is first given as a dependency in the `pubspec.yaml` as shown below:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: "^0.3.0"
```
It's then imported in the file where the instance of the `shared_preference` resides.

<!-- skip -->
```Dart
import 'package:shared_preferences/shared_preferences.dart';
```

An instance is obtained and used to perform operations such as storing and retrieving data.

<!-- skip -->
```Dart
SharedPreferences prefs = await SharedPreferences.getInstance();
_counter=prefs.getInt('counter');
prefs.setInt('counter',++_counter);
setState(() {
  _counter=_counter;
});
```

## Routing
### How do I navigate between screens?

In React Native, there are three main navigators if you are using react-navigation: StackNavigator, TabNavigator, and DrawerNavigator. Each of these provides a way to configure and define the screens. The example below shows the definition of each of the navigators:

<!-- skip -->
```JavaScript
// React Native
const MyApp = TabNavigator(
  { Home: { screen: HomeScreen }, Notifications: { screen: tabNavScreen } },
  { tabBarOptions: { activeTintColor: "#e91e63" } }
);
const SimpleApp = StackNavigator({
  Home: { screen: MyApp },
  stackScreen: { screen: StackScreen }
});
export default (MyApp1 = DrawerNavigator({
  Home: {
    screen: SimpleApp
  },
  Screen2: {
    screen: drawerScreen
  }
}));
```

In Flutter, there are two main concepts to understand:
* A [Route](https://docs.flutter.io/flutter/widgets/Route-class.html) is an abstraction for a “screen” or “page” of an app.
* A [Navigator](https://docs.flutter.io/flutter/widgets/Navigator-class.html) is a widget that manages routes.

A `Navigator` is defined as a widget that manages a set of child widgets with a stack discipline. The navigator manages a stack of `Route` objects and provides methods for managing the stack, like [`Navigator.push`](https://docs.flutter.io/flutter/widgets/Navigator/push.html) and [`Navigator.pop`](https://docs.flutter.io/flutter/widgets/Navigator/pop.html).
Initially, the definition of the routes is provided as a parameter, or routes, to the [`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html) widget.

<!-- skip -->
```Dart
// Flutter
class NavigationApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
            ...
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => new usualNavscreen(),
        '/b': (BuildContext context) => new drawerNavscreen(),
      }
            ...
  );
  }
}
```

To navigate to a named route, the `of` method of the `Navigator` widget is used to specify the `BuildContext` (a handle to the location of a widget in the widget tree) and the name of the route is passed to `pushNamed` function to navigate to the specifed route as shown below:

<!-- skip -->
```Dart
Navigator.of(context).pushNamed('/a');
```

You can also use the push method of `Navigator` which adds the given [`route`](https://docs.flutter.io/flutter/widgets/Route-class.html) to the history of the navigator that most tightly encloses the given [`context`](https://docs.flutter.io/flutter/widgets/BuildContext-class.html), and transitions to it. In the following example, the  [`MaterialPageRoute`](https://docs.flutter.io/flutter/material/MaterialPageRoute-class.html) widget is a modal route that replaces the entire screen with a platform-adaptive transition. It takes a [`WidgetBuilder`](https://docs.flutter.io/flutter/widgets/WidgetBuilder.html) as a required parameter.

<!-- skip -->
```Dart
Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new UsualNavscreen()));
```

### How do I use Tab Navigation and Drawer Navigation?

In React Native, you define Tab and Drawer navigators and use them to show tabs and drawers, and navigate.

In Flutter, several lower-level widgets are used for example: [`Drawer`](https://docs.flutter.io/flutter/material/Drawer-class.html) which is basically a Material Design panel that slides in horizontally and [`TabBar`](https://docs.flutter.io/flutter/material/TabBar-class.html) and  [`TabBarView`](https://docs.flutter.io/flutter/material/TabBarView-class.html) that show and navigate among Tabs.

These lower-level widgets are used in combination with the higher-level [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget which implements them internally. The [`drawer`](https://docs.flutter.io/flutter/material/Drawer-class.html) and [`bottomNavigationBar`](https://docs.flutter.io/flutter/material/TabBar-class.html) parameters of the [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget are provided with the lower-level widgets mentioned above.

#### Tab Navigation

In React Native, you can use `TabNavigation`.

<!-- skip -->
```JavaScript
// React Native
const MyApp = TabNavigator(
  { Home: { screen: HomeScreen }, Notifications: { screen: tabNavScreen } },
  { tabBarOptions: { activeTintColor: "#e91e63" } }
);
```

In Flutter, use two main widgets: [TabBar](https://docs.flutter.io/flutter/material/TabBar-class.html) and [TabBarView](https://docs.flutter.io/flutter/material/TabBarView-class.html).

A TabBar Widget is used to create a TabBar and [`Tab`](https://docs.flutter.io/flutter/material/Tab-class.html) widgets are passed as children to the TabBar widget as shown below:

<!-- skip -->
```Dart
// Flutter
TabController controller=new TabController(length: 2, vsync: this);

new TabBar(
  tabs: <Tab>[
    new Tab(icon: new Icon(Icons.person),),
    new Tab(icon: new Icon(Icons.email),),
  ],
  controller: controller,
),

```

Also, a [`TabController`](https://docs.flutter.io/flutter/material/TabController-class.html) must be passed. A `TabController` coordinates the tab selection between a [`TabBar`](https://docs.flutter.io/flutter/material/TabBar-class.html) and a [`TabBarView`](https://docs.flutter.io/flutter/material/TabBarView-class.html).
The `length` argument of the `TabController`'s constructor is the total number of tabs. Typically greater than one.
`vsync` is the [`TickerProvider`](https://docs.flutter.io/flutter/scheduler/TickerProvider-class.html) that can be used.

`TickerProvider` is an interface implemented by classes that can vend [`Ticker`](https://docs.flutter.io/flutter/scheduler/Ticker-class.html) objects. Tickers can be used by any object that wants to be notified whenever a frame triggers, but they're most commonly used indirectly via an [`AnimationController`](https://docs.flutter.io/flutter/animation/AnimationController-class.html). `AnimationControllers` need a `TickerProvider` to obtain their `Ticker`. If you are creating an AnimationController from a State, then you can use the [`TickerProviderStateMixin`](https://docs.flutter.io/flutter/widgets/TickerProviderStateMixin-class.html) or [`SingleTickerProviderStateMixin`](https://docs.flutter.io/flutter/widgets/SingleTickerProviderStateMixin-class.html) classes to obtain a suitable `TickerProvider`.

`TabBarView` widget is passed as the `body` parameter of the [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget. All the screens corresponding to the `TabBar` widget’s tabs are given as children to `TabBarView` widget along with the same `TabController` as shown:

<!-- skip -->
```Dart
// Flutter

class _NavigationHomePageState extends State<NavigationHomePage> with SingleTickerProviderStateMixin {
  TabController controller=new TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material (
        child: new TabBar(
          tabs: <Tab> [
            new Tab(icon: new Icon(Icons.person),)
            new Tab(icon: new Icon(Icons.email),),
          ],
          controller: controller,
        ),
        color: Colors.blue,
      ),
      body: new TabBarView(
        children: <Widget> [
          new home.homeScreen(),
          new tabScreen.tabScreen()
        ],
        controller: controller,
      )
    );
  }
}
```

#### Drawer navigation

In React Native,  `DrawerNavigation` is used.

<!-- skip -->
```JavaScript
// React Native
export default (MyApp1 = DrawerNavigator({
  Home: {
    screen: SimpleApp
  },
  Screen2: {
    screen: drawerScreen
  }
}));
```

In Flutter, use a [`Drawer`]() widget.

The `Drawer` widget is a Material Design panel that slides in horizontally from the edge of a `Scaffold` to show navigation links in an application. You can provide a [`Button`](https://docs.flutter.io/flutter/material/RaisedButton-class.html), a [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html) widget or a List of items to display as the child to the `Drawer` widget. In the following example, the  [`ListTile`](https://docs.flutter.io/flutter/material/ListTile-class.html)widget provides the navigation on tap.

<!-- skip -->
```Dart
// Flutter
new Drawer(
  child:new ListTile(
    leading: new Icon(Icons.change_history),
    title: new Text('Screen2'),
    onTap: () {
      Navigator.of(context).pushNamed("/b");
    },
  ),
  elevation: 20.0,
),
```

Drawers are typically used with the `Scaffold.drawer` property. The `AppBar` automatically displays an appropriate IconButton to show the `Drawer` when a Drawer is available in the `Scaffold`. The `Scaffold` automatically handles the edge-swipe gesture to show the `Drawer`.

<!-- skip -->
```Dart
// Flutter
@override
Widget build(BuildContext context) {
  return new Scaffold(
    drawer: new Drawer(
      child: new ListTile(
        leading: new Icon(Icons.change_history),
        title: new Text('Screen2'),
        onTap: () {
          Navigator.of(context).pushNamed("/b");
        },
      ),
      elevation: 20.0,
    ),
    appBar: new AppBar(
      title: new Text("Home"),
    ),
    body: new Container(),
  );
}
```

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/navigation_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/navigation_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

<br>

## Gesture Detection and Touch Event Handling
### How do I add a click or press listeners to a widget?

In React Native,  listeners are added to components using the `Touchables` component or you can use `PanResponder`.

<!-- skip -->
```JavaScript
// React Native
<TouchableOpacity
  onPress={() => {
    console.log("Press");
  }}
  onLongPress={() => {
    console.log("Long Press");
  }}
>
  <Text>Tap or Long Press</Text>
</TouchableOpacity>
```

For more complex gestures and combining several touches into a single gesture, [`PanResponders`](https://facebook.github.io/react-native/docs/panresponder.html) are used in React Native.

<!-- skip -->
```JavaScript
// React Native
class App extends Component {

  componentWillMount() {
    this._panResponder = PanResponder.create({
      onMoveShouldSetPanResponder: (event, gestureState) =>
        !!getDirection(gestureState),
      onPanResponderMove: (event, gestureState) => true,
      onPanResponderRelease: (event, gestureState) => {
        const drag = getDirection(gestureState);
      },
      onPanResponderTerminationRequest: (event, gestureState) => true
    });
  }

  render() {
    return (
      <View style={styles.container} {...this._panResponder.panHandlers}>
        <View style={styles.center}>
          <Text>Swipe Horizontally or Vertically</Text>
        </View>
      </View>
    );
  }
}
```

In Flutter, to add a click or press listeners to a widget, you can use buttons or touchable widgets which have `onPress` parameters. Or, you can wrap widgets in a [`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) widget that can add event detection to any widget by passing the function in the respective callback.

<!-- skip -->
```Dart
// Flutter
new GestureDetector(
  child: new Scaffold(
    appBar: new AppBar(
      title: new Text("Gestures"),
    ),
    body: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('Tap, Long Press, Swipe Horizontally or Vertically '),
        ],
      )
    ),
  ),
  onTap: () {
    print('Tapped');
  },
  onLongPress: () {
    print('Long Pressed');
  },
  onVerticalDragEnd: (DragEndDetails value) {
    print('Swiped Vertically');
  },
  onHorizontalDragEnd: (DragEndDetails value) {
    print('Swiped Horizontally');
  },
);
```
For more information, including a list of Flutter `GestureDetector` callbacks, see the [GestureDetector class](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html#Properties).

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/flutter_gestures_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/flutter_gestures_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

<br>

## Making HTTP Networking Requests
### How do I fetch data from API calls?

React Native provides the Fetch API for networking — you make a fetch request and then receive the response to get the data.

<!-- skip -->
```JavaScript
// React Native
_getIPAddress = () => {
  fetch("https://httpbin.org/ip")
    .then(response => response.json())
    .then(responseJson => {
      this.setState({ _ipAddress: responseJson.origin });
    })
    .catch(error => {
      console.error(error);
    });
};
```

In Flutter you use the [`dart:io`](https://docs.flutter.io/flutter/dart-io/dart-io-library.html) core HTTP support client. To create an HTTP Client, import `dart:io`.

<!-- skip -->
```Dart
import 'dart:io';
```

The client supports the following HTTP operations: GET, POST, PUT, and DELETE.

<!-- skip -->
```Dart
// Flutter
final url = new Uri.https('httpbin.org', 'ip');
final httpClient = new HttpClient();
_getIPAddress() async {
  var request = await httpClient.getUrl(url);
  var response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();
  String ip = json.decode(responseBody)['origin'];
  setState(() {
    _ipAddress = ip;
  });
}
```

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/api_calls_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/api_calls_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

## Form Input
### How do I use the `TextField` widget?

In React Native, to enter text you use a `TextInput` component to show a text input box and then use the callback to store the value in a variable.

<!-- skip -->
```JavaScript
// React Native
<TextInput
  placeholder="Enter your Password"
  onChangeText={password => this.setState({ password })}
 />
<Button title="Submit" onPress={this.validate} />
```

In Flutter, use the [`TextEditingController`](https://docs.flutter.io/flutter/widgets/TextEditingController-class.html) class to manage a [TextField](https://docs.flutter.io/flutter/material/TextField-class.html) widget. Whenever the text field is modified, the controller notifies its listeners.

Listeners read the text and selection properties to learn what the user typed into the field. You can access the text in `TextField` by the `text` property of the controller.

<!-- skip -->
```Dart
// Flutter
final TextEditingController _controller = new TextEditingController();
      ...
new TextField(
  controller: _controller,
  decoration: new InputDecoration(
    hintText: 'Type something', labelText: "Text Field "
  ),
),
new RaisedButton(
  child: new Text('Submit'),
  onPressed: () {
    showDialog(
      context: context,
        child: new AlertDialog(
          title: new Text('Alert'),
          content: new Text('You typed ${_controller.text}'),
        ),
     );
   },
 ),
)
```

In this example, when a user clicks on the submit button an alert dialog displays the current text entered in the text field. This is achieved using an [`alertDialog`](https://docs.flutter.io/flutter/material/AlertDialog-class.html) widget that displays the alert message, and the text from the `TextField` is accessed by the `text` property of the [TextEditingController](https://docs.flutter.io/flutter/widgets/TextEditingController-class.html).

### How do I use `Forms`?

In Flutter, use the [`Form`](https://docs.flutter.io/flutter/widgets/Form-class.html) widget — where [`TextFormField`](https://docs.flutter.io/flutter/material/TextFormField-class.html) widgets along with the submit button are passed as children. The `TextFormField` widget has a parameter called [`onSaved`](https://docs.flutter.io/flutter/widgets/FormField/onSaved.html) which takes a callback and executes when the form is saved.
A `FormState` object is used to save, reset, or validate each `FormField` that is a descendant of this `Form`. To obtain the `FormState`, you can use `Form.of` with a context whose ancestor is the Form, or pass a `GlobalKey` to the Form constructor and call `GlobalKey.currentState`.

<!-- skip -->
```Dart
final formKey = new GlobalKey<FormState>();

...

new Form(
  key:formKey,
  child: new Column(
    children: <Widget>[
      new TextFormField(
        validator: (value) => !value.contains('@') ? 'Not a valid email.' : null,
        onSaved: (val) => _email = val,
        decoration: const InputDecoration(
          hintText: 'Enter your email',
          labelText: 'Email',
        ),
      ),
      new RaisedButton(
        onPressed: _submit,
        child: new Text('Login'),
      ),
    ],
  ),
)
```

The following example shows how `Form.save()` and `formKey` (which is a `GlobalKey`) are used to save the form on submit.

<!-- skip -->
```Dart
void _submit() {
  final form = formKey.currentState;
  if (form.validate()) {
    form.save();
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Alert'),
        content: new Text('Email: $_email, password: $_password'),
      )
    );
  }
}
```


#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/input_fields_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/input_fields_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

<br>

## Platform-specific code

When building a cross-platform app, you'll want to re-use as much code as possible across platforms. However, scenarios may arise where it makes sense for the code to be different depending on the OS. This requires a separate implementation by declaring a specific platform.

In React Native, the following implementation would be used:

<!-- skip -->
```JavaScript
// React Native
if (Platform.OS === "ios") {
  return "iOS";
} else if (Platform.OS === "android") {
  return "android";
} else {
  return "not recognised";
}
```
In Flutter, use the following implementation:

```Dart
// Flutter
if (Theme.of(context).platform == TargetPlatform.iOS) {
  return "iOS";
} else if (Theme.of(context).platform == TargetPlatform.android) {
  return "android";
} else if (Theme.of(context).platform == TargetPlatform.fuchsia) {
  return "fuchsia";
} else {
  return "not recognised ";
}
```

## Debugging
### How do I access the In-App Developer Menu?

In React Native, the developer menu can be accessed by shaking your device: ⌘D for the iOS Simulator or ⌘M for Android emulator.

In Flutter, if you are using an IDE, you can use the IDE tools. If you start your application using `flutter run` you can also access the menu by typing `h` in the terminal window, or type the following shortcuts:

| Action| Terminal Shortcut| Debug functions/ properties|
| :------- | :------: | :------ |
| Widget hierarchy of the app| `w`| debugDumpApp()|
| Rendering tree of the app | `t`| debugDumpRenderTree()|
| Layers| `L`| debugDumpLayerTree()|
| Accessibility | `S` (traversal order) or `U` (inverse hit test order)|debugDumpSemantics()|
| To toggle the widget inspector | `i` | WidgetsApp. showWidgetInspectorOverride|
| To toggle the display of construction lines| `p` | debugPaintSizeEnabled|
| To simulate different operating systems| `o` | defaultTargetPlatform|
| To display the performance overlay | `P` | WidgetsApp. showPerformanceOverlay|
| To save a screenshot to flutter. png| `s` ||
| To quit| `q` ||

### How do I perform hot reload?

Flutter’s hot reload feature helps you quickly and easily experiment, build UIs, add features, and fix bugs. Instead of recompiling your app every time you make a change, you can reload your app instantly.
The app is updated to reflect your change, and the current state of the app is preserved.

In React Native, the shortcut is ⌘R for the iOS Simulator and tapping R twice on Android emulators.

In Flutter, If you are using IntelliJ IDE or Android Studio, you can select Save All (⌘s/ctrl-s), or click the Hot Reload button on the toolbar.
If you are running the app at the command line using `flutter run`, type `r` in the Terminal window.
You can also perform a full restart by typing `R` in the Terminal window.

### Is there anything like Chrome Developer Tools in Flutter?

There are several options and tools you can use when you need to debug your Flutter app.

The [`Dart Observatory`](https://dart-lang.github.io/observatory/) is a tool used to profile and debug your Dart applications. If you started your application using `flutter run` in Terminal, you can open the web page at the Observatory URL printed to the terminal window, for example:  `http://127.0.0.1:8100/`.

The Observatory supports profiling, examining the heap, observing executed lines of code, debugging memory leaks and memory fragmentation, etc. For more information, see the [Observatory’s documentation](https://dart-lang.github.io/observatory/).  Observatory is included for free when you download and install the Dart SDK.



If you're using an IDE, you can debug your application using the IDE debugger.

If you're using IntelliJ and Android Studio, you can use the Flutter Inspector. The Flutter Inspector makes it much easier to understand why your application is rendering the way it does. It allows you to:
* View the UI structure of your app as a tree of widgets
* Select a point on your device or simulator and find the corresponding widget that rendered those pixels
* View properties for individual widgets
* Quickly identify layout issues and determine their cause

The Flutter Inspector view can be opened from View > Tool Windows > Flutter Inspector. Content is shown only when an app is running.

To inspect a specific widget, select the ‘Toggle inspect mode’ action in the toolbar, then click on the desired widget on an attached phone or simulator. The widget is highlighted in your app’s UI. You’ll see the widget in the widget hierarchy in IntelliJ and the individual properties for that widget.

For more information, see  [Debugging Flutter Apps](https://flutter.io/debugging/).

## Animation

Well-designed animation makes a UI feel intuitive, contributes to the look and feel of a polished app, and improves the user experience. Flutter’s animation support makes it easy to implement simple and complex animations. the Flutter SDK includes many pre-defined Material Design widgets that include standard motion effects and you can easily customize these effects to personalize your app.

In React Native, Animated APIs are used to create animations.

In Flutter, use the [`Animation`](https://docs.flutter.io/flutter/animation/Animation-class.html) class and the [`AnimationController`](https://docs.flutter.io/flutter/animation/AnimationController-class.html) class. `Animation` is an abstract class that understands its current value and its state (completed or dismissed). The `AnimationController` class lets you play an animation forward or in reverse, or stop animation and set the animation to a specific value to customize the motion.

### How do I add a simple fade-in animation?

In the React Native example below, an animated component, `FadeInView` is created using the Animated API. The initial opacity state, final state, and the duration over which the transition occurs are defined. The animation component is added inside the `Animated` component, the opacity state `fadeAnim` is mapped to the opacity of the Text component that we want to animate, and then, `start()` is called to start the animation.

<!-- skip -->
```JavaScript
// React Native
class FadeInView extends React.Component {
  state = {
    fadeAnim: new Animated.Value(0) // Initial value for opacity: 0
  };
  componentDidMount() {
    Animated.timing(this.state.fadeAnim, {
      toValue: 1,
      duration: 10000
    }).start();
  }
  render() {
    return (
      <Animated.View style={%raw%}{{...this.props.style, opacity: this.state.fadeAnim }}{%endraw%} >
        {this.props.children}
      </Animated.View>
    );
  }
}
    ...
<FadeInView>
  <Text> Fading in </Text>
</FadeInView>
    ...
```

To create the same animation in Flutter, create an [`AnimationController`](https://docs.flutter.io/flutter/animation/AnimationController-class.html) object named `controller` and specify the duration. By default, an `AnimationController` linearly produces values that range from 0.0 to 1.0, during a given duration. The animation controller generates a new value whenever the device running your app is ready to display a new frame. Typically, this rate is around 60 values per second.

When defining an `AnimationController`, you must pass in a `vsync` object. The presence of `vsync` prevents offscreen animations from consuming unnecessary resources. You can use your stateful object as the `vsync` by adding `TickerProviderStateMixin` to the class definition. An `AnimationController` needs a TickerProvider, which is configured using the `vsync` argument on the constructor.

This example animation is defined as a [`Tween`](https://docs.flutter.io/flutter/animation/Tween-class.html) which describes the interpolation between a beginning and ending value or the mapping from an input range to an output range. To use a `Tween` object with an animation, call the `Tween` object's `animate` method and pass it the `Animation` object that you want to modify.

For this example, a [`FadeTransition`](https://docs.flutter.io/flutter/widgets/FadeTransition-class.html) widget is used and the `opacity` property is mapped to the `animation` object.

To start the animation, use `controller.forward()`. Other operations can also be performed using the controller such as `fling()` or `repeat()`. For this example, the [`FlutterLogo`](https://docs.flutter.io/flutter/material/FlutterLogo-class.html) (a Flutter logo widget) is used inside the `FadeTransition` widget.

<!-- skip -->
```Dart

// Flutter
import 'package:flutter/material.dart';

void main() {
  runApp(new Center(child: new LogoFade()));
}

class LogoFade extends StatefulWidget {
  _LogoFadeState createState() => new _LogoFadeState();
}

class _LogoFadeState extends State<LogoFade> with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    final CurvedAnimation curve =
    new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Tween(begin: 0.0, end: 1.0).animate(curve);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity: animation,
      child: new Container(
        height: 300.0,
        width: 300.0,
        child: new FlutterLogo(),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/flutter_fade_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/flutter_fade_iOS.gif?raw=true" style="width:300px;" alt="Loading">|

<br>

### How do I add swipe animation to Cards?

In React Native, either the PanResponder or third-party libraries are used for swipe animation.

In Flutter, to add a swipe animation, use the [`Dismissible`](https://docs.flutter.io/flutter/widgets/Dismissible-class.html) widget and nest the child widgets.

<!-- skip -->
```Dart
child: new Dismissible(
  key: key,
  onDismissed: (DismissDirection dir) {
    cards.removeLast();
  },
  child: new Container(
    ...
  ),
),
```

#### Preview

|Android|iOS|
|:---:|:--:|
|<img src="/flutter-for-react-native/images/card_swipe_android.gif?raw=true" style="width:300px;" alt="Loading">|<img src="/flutter-for-react-native/images/card_swipe_iOS.gif?raw=true" style="width:300px;" alt="Loading">|  

<br>

## React Native Component to Flutter Widget Reference List

The following table lists commonly-used React Native components mapped to the corresponding Flutter widget and common widget properties.

| React Native Component                                                                    | Flutter Widget                                                                                             | Description                                                                                                                            |
| ----------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| [Button](https://facebook.github.io/react-native/docs/button.html)                        | [Raised Button](https://docs.flutter.io/flutter/material/RaisedButton-class.html)                           | A basic raised button.                                                                              |
|                                                                                           |  onPressed [required]                                                                                        | The callback when the button is tapped or otherwise activated.                                                          |
|                                                                                           | Child  (A Text widget)                                                                             | The button's label.                                                                                                      |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [Button](https://facebook.github.io/react-native/docs/button.html)                        | [Flat Button](https://docs.flutter.io/flutter/material/FlatButton-class.html)                               | A basic flat button.                                                                                                         |
|                                                                                           |  onPressed [required]                                                                                        | The callback when the button is tapped or otherwise activated.                                                            |
|                                                                                           | Child  (a Text widget)                                                                             | The button's label.                                                                                                      |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [ScrollView](https://facebook.github.io/react-native/docs/scrollview.html)                | [ListView](https://docs.flutter.io/flutter/widgets/ListView-class.html)                                    | A scrollable list of widgets arranged linearly.|
||        children                                                                              |( \<Widget> []) List of child widgets to display.
||controller |[ [Scroll Controller](https://docs.flutter.io/flutter/widgets/ScrollController-class.html) ] An object that can be used to control a scrollable widget.
||itemExtent|[ double ] If non-null, forces the children to have the given extent in the scroll direction.
||scroll Direction|[ [Axis](https://docs.flutter.io/flutter/painting/Axis-class.html) ] The axis along which the scroll view scrolls.
||                                                                                                            |                                                                                                                                        |
| [FlatList](https://facebook.github.io/react-native/docs/flatlist.html)                    | [ListView. builder()](https://docs.flutter.io/flutter/widgets/ListView/ListView.builder.html)               | The constructor for a linear array of widgets that are created on demand.
||itemBuilder [required] |[[ Indexed Widget Builder](https://docs.flutter.io/flutter/widgets/IndexedWidgetBuilder.html)] helps in building the children on demand. This callback is called only with indices greater than or equal to zero and less than the itemCount.
||itemCount |[ int ] improves the ability of the ListView to estimate the maximum scroll extent.
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [Image](https://docs.flutter.io/flutter/widgets/Image-class.html)                         | [Image](https://facebook.github.io/react-native/docs/image.html)                                           | A widget that displays an image.                                                                                                       |
|                                                                                           |  image [required]                                                                                          | The image to display.                                                                                                                  |
|                                                                                           | Image. asset                                                                                                | Several constructors are provided for the various ways that an image can be specified.                                                 |
|                                                                                           | width, height, color, alignment                                                                            | The style and layout for the image.                                                                                                         |
|                                                                                           | fit                                                                                                        | Inscribing the image into the space allocated during layout.                                                                           |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [Modal](https://facebook.github.io/react-native/docs/modal.html)                          | [ModalRoute](https://docs.flutter.io/flutter/widgets/ModalRoute-class.html)                                | A route that blocks interaction with previous routes.                                                                                  |
|                                                                                           | animation                                                                                                  | The animation that drives the route's transition and the previous route's forward transition.                                          |
|                                                                                           |                                                                                                            |                                                                                                                                        |
|  [Activity Indicator](https://facebook.github.io/react-native/docs/activityindicator.html) | [Circular Progress Indicator](https://docs.flutter.io/flutter/material/CircularProgressIndicator-class.html) | A widget that shows progress along a circle.                                                                                           |
|                                                                                           | strokeWidth                                                                                                | The width of the line used to draw the circle.                                                                                         |
|                                                                                           | backgroundColor                                                                                            | The progress indicator's background color. The current theme's `ThemeData.backgroundColor` by default.                                   |
|                                                                                           |                                                                                                            |                                                                                                                                        |
|  [Activity Indicator](https://facebook.github.io/react-native/docs/activityindicator.html) | [Linear Progress Indicator](https://docs.flutter.io/flutter/material/LinearProgressIndicator-class.html)     | A widget that shows progress along a circle.                                                                                           |
|                                                                                           | value                                                                                                      | The value of this progress indicator.                                                                                                   |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [Refresh Control](https://facebook.github.io/react-native/docs/refreshcontrol.html)        | [Refresh Indicator](https://docs.flutter.io/flutter/material/RefreshIndicator-class.html)                   | A widget that supports the Material "swipe to refresh" idiom.                                                                          |
|                                                                                           | color                                                                                                      | The progress indicator's foreground color.                                                                                             |
|                                                                                           | onRefresh                                                                                                  | A function that's called when a user drags the refresh indicator far enough to demonstrate that they want the app to refresh.  |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [View](https://facebook.github.io/react-native/docs/view.html)                            | [Container](https://docs.flutter.io/flutter/widgets/Container-class.html)                                  | A widget that surrounds a child widget.                                                                                                                |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [View](https://facebook.github.io/react-native/docs/view.html)                            | [Column](https://docs.flutter.io/flutter/widgets/Column-class.html)                                        | A widget that displays its children in a vertical array.                                                                                              |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [View](https://facebook.github.io/react-native/docs/view.html)                            | [Row](https://docs.flutter.io/flutter/widgets/Row-class.html)                                              | A widget that displays its children in a horizontal array.                                                                                            |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [View](https://facebook.github.io/react-native/docs/view.html)                            | [Center](https://docs.flutter.io/flutter/widgets/Center-class.html)                                        | A widget that centers its child within itself.                                                                                                       |
|                                                                                           |                                                                                                            |                                                                                                                                        |
| [View](https://facebook.github.io/react-native/docs/view.html)                            | [Padding](https://docs.flutter.io/flutter/widgets/Padding-class.html)                                      | A widget that insets its child by the given padding.                                                                                                 |
|                                                                                           | padding [required]                                                                                         | [ EdgeInsets ] The amount of space to inset the child.
|||
| [Touchable Opacity](https://facebook.github.io/react-native/docs/touchableopacity.html)    | [Gesture Detector](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html)                      | A widget that detects gestures.                                                                                                                       |
|                                                                                           | onTap                                                                                                      | A callback when a tap occurs.                                                                                                               |
|                                                                                           | onDoubleTap                                                                                                | A callback when a tap occurs at the same location twice in quick succession.
|||
| [Text Input](https://docs.flutter.io/flutter/services/TextInput-class.html)                | [Text Input](https://facebook.github.io/react-native/docs/textinput.html)                                   | The interface to the system's text input control.                                                                                           |
|                                                                                           | controller                                                                                                 | [ The [Text Editing Controller](https://docs.flutter.io/flutter/widgets/TextEditingController-class.html) ] used to access and modify text.
|||
| [Text](https://facebook.github.io/react-native/docs/text.html)                          | [Text](https://docs.flutter.io/flutter/widgets/Text-class.html)                                            | The Text widget that displays a string of text with a single style.                                                                                                                                                                           |
|                                                                                         | data                                                                                                      | [ String ] The text to display.                                                                                                                                                                              |
|                                                                                         | textDirection                                                                                             | [ [Text Align]( https://docs.flutter.io/flutter/dart-ui/TextAlign-class.html) ] The direction in which the text flows.                                                                                     |
|                                                                                         |                                                                                                           |                                                                                                                                                                                                              |
| [Switch](https://facebook.github.io/react-native/docs/switch.html)                      | [Switch](https://docs.flutter.io/flutter/material/Switch-class.html)                                      | A material design switch.                                                                                                                                                                                    |
|                                                                                         | value [required]                                                                                          | [ boolean ] Whether this switch is on or off.                                                                                                                                                                 |
|                                                                                         | onChanged [required]                                                                                      | [ callback ] Called when the user toggles the switch on or off.                                                                                                                                               |
|                                                                                         |                                                                                                           |                                                                                                                                                                                                              |
| [Slider](https://facebook.github.io/react-native/docs/slider.html)                      | [Slider](https://docs.flutter.io/flutter/material/Slider-class.html)                                      | Used to select from a range of values.                                                                                                                                                                       |
|                                                                                         | value [required]                                                                                          | [ double ] The current value of the slider.                                                                                                                                                                           |
|                                                                                         | onChanged [required]                                                                                      | Called when the user selects a new value for the slider.                                                                                                                                                      |
