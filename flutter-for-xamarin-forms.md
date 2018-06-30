---
layout: page
title: Flutter for Xamarin.Forms Developers
permalink: /flutter-for-xamarin-forms/
---
This document is meant for Xamarin.Forms developers looking to apply their
existing knowledge to build mobile apps with Flutter. If you understand
the fundamentals of the Xamarin.Forms framework then you can use this document as a
jump start to Flutter development.

Your Android (and iOS) knowledge and skill set are highly valuable when building with
Flutter, because Flutter relies on the mobile operating system for numerous
capabilities and configurations. Flutter is a new way to build UIs for mobile,
and is similar to how you create a single UI in Xamarin.Forms, that is used on multiple
platforms. 

This document can be used as a cookbook by jumping around and finding questions
that are most relevant to your needs.

* TOC Placeholder
{:toc}

# Views

## What is the equivalent of a `Page` or `Element` in Flutter?

A `ContentPage`, `TabbedPage`, `MasterDetailPage` are all types of pages you could 
use in a Xamarin.Forms application. These pages would then hold `Element`s to display
the various controls.

In Xamarin.Forms an `Entry` or `Button` are examples of an `Element`. In Flutter, there 
is no difference between a `Page` or `Element`, everything is a `Widget`. The root of
a page in Flutter is a `Widget`. A `Widget` can contain more `Widget`s to build out your
page.

Flutter includes the [Material Components](https://material.io/develop/flutter/)
library. These are widgets that implement the
[Material Design guidelines](https://material.io/design/). Material Design is a
flexible design system [optimized for all
platforms](https://material.io/design/platform-guidance/cross-platform-adaptation.html#cross-platform-guidelines),
including iOS.

But Flutter is flexible and expressive enough to implement any design language.
For example, on iOS, you can use the [Cupertino widgets](https://flutter.io/widgets/cupertino/)
to produce an interface that looks like
[Apple's iOS design language](https://developer.apple.com/design/resources/).

## How do I update `Widget`s?

In Xamarin.Forms, each `Page` or `Element` is a stateful class, that has properties and
methods. You update your `Element` by updating a property, and this is propagated down
to the native control. 

In Flutter, `Widget`s are immutable and you can not directly update them by changing a
property, instead you have to work with the widget's state.

This is where the concept of Stateful vs Stateless widgets comes from. A
`StatelessWidget` is just what it sounds like&mdash;a widget with no state
information.

`StatelessWidgets` are useful when the part of the user interface
you are describing does not depend on anything other than the configuration
information in the object.

For example, in Xamarin.Forms, this is similar to placing an `Image`
with your logo. The logo is not going to change during runtime, so
use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received
after making an HTTP call or user interaction then you have to work
with `StatefulWidget` and tell the Flutter framework that the widget’s `State`
has been updated so it can update that widget.

The important thing to note here is at the core both stateless and stateful
widgets behave the same. They rebuild every frame, the difference is the
`StatefulWidget` has a `State` object that stores state data across frames
and restores it.

If you are in doubt, then always remember this rule: if a widget changes
(because of user interactions, for example) it’s stateful.
However, if a widget reacts to change, the containing parent widget can
still be stateless if it doesn't itself react to change.

The following example shows how to use a `StatelessWidget`. A common
`StatelessWidget` is the `Text` widget. If you look at the implementation of
the `Text` widget you'll find it subclasses `StatelessWidget`.

<!-- skip -->
{% prettify dart %}
new Text(
  'I like Flutter!',
  style: new TextStyle(fontWeight: FontWeight.bold),
);
{% endprettify %}

As you can see, the `Text` Widget has no state information associated with it,
it renders what is passed in its constructors and nothing more.

But, what if you want to make "I Like Flutter" change dynamically, for
example when clicking a `FloatingActionButton`?

To achieve this, wrap the `Text` widget in a `StatefulWidget` and
update it when the user clicks the button.

For example:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => new _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default placeholder text
  String textToShow = "I Like Flutter";

  void _updateText() {
    setState(() {
      // update the text
      textToShow = "Flutter is Awesome!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new Center(child: new Text(textToShow)),
      floatingActionButton: new FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: new Icon(Icons.update),
      ),
    );
  }
}
{% endprettify %}

## How do I lay out my widgets? What is the equivalent of a XAML file?

In Xamarin.Forms, most developers write layouts in XAML, though sometimes in C#.
In Flutter you write your layouts with a widget tree in code.

The following example shows how to display a simple widget with padding:

<!-- skip -->
{% prettify dart %}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new Center(
        child: new MaterialButton(
          onPressed: () {},
          child: new Text('Hello'),
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
        ),
      ),
    );
  }
{% endprettify %}

You can view the layouts that Flutter has to offer in the [widget
catalog](/widgets/layout/).

## How do I add or remove an Element from my layout?

In Xamarin.Forms, if you had to remove or add an `Element`, you had to do so in
code. This would involve either setting the `Content` property or calling
`Add()` or `Remove` if it was a list. 

In Flutter, because widgets are immutable there is no direct equivalent.
Instead, you can pass a function to the parent that returns a widget, and
control that child's creation with a boolean flag.

The following example shows how to toggle between two widgets when the user clicks
the `FloatingActionButton`:

<!-- skip -->
{% prettify dart %}
class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => new _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default value for toggle
  bool toggle = true;
  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  _getToggleChild() {
    if (toggle) {
      return new Text('Toggle One');
    } else {
      return new CupertinoButton(
        onPressed: () {},
        child: new Text('Toggle Two'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: new Icon(Icons.update),
      ),
    );
  }
}
{% endprettify %}

## How do I animate a widget?

In Xamarin.Forms, you create simple animations using ViewExtensions that include
methods such as `FadeTo` and `TranslateTo`. You would use these methods on a view
to perform the required animations. In Flutter, you animate widgets using the 
animation library by wrapping widgets inside an animated widget.

In Flutter, use an `AnimationController` which is an `Animation<double>`
that can pause, seek, stop and reverse the animation. It requires a `Ticker`
that signals when vsync happens, and produces a linear interpolation between
0 and 1 on each frame while it's running. You then create one or more
`Animation`s and attach them to the controller.

For example, you might use `CurvedAnimation` to implement an animation
along an interpolated curve. In this sense, the controller
is the "master" source of the animation progress and the `CurvedAnimation`
computes the curve that replaces the controller's default linear motion.
Like widgets, animations in Flutter work with composition.

When building the widget tree you assign the `Animation` to an animated
property of a widget, such as the opacity of a `FadeTransition`, and tell the
controller to start the animation.

The following example shows how to write a `FadeTransition` that fades the widget
into a logo when you press the `FloatingActionButton`:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';

void main() {
  runApp(new FadeAppTest());
}

class FadeAppTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fade Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyFadeTest(title: 'Fade Demo'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyFadeTest createState() => new _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
          child: new Container(
              child: new FadeTransition(
                  opacity: curve,
                  child: new FlutterLogo(
                    size: 100.0,
                  )))),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Fade',
        child: new Icon(Icons.brush),
        onPressed: () {
          controller.forward();
        },
      ),
    );
  }
}
{% endprettify %}

For more information, see
[Animation & Motion widgets](/widgets/animation/),
the [Animations tutorial](/tutorials/animation),
and the [Animations overview](/animations/).

## How do I draw/paint on the screen?

Xamarin.Forms never had any built in way to draw directly on the screen.
Many would use SkiaSharp, if they needed a custom image drawn. In Flutter,
you have direct access to the Skia Canvas and can easily draw on screen.

Flutter has two classes that help you draw to the canvas: `CustomPaint`
and `CustomPainter`, the latter of which implements your algorithm to draw to
the canvas.

To learn how to implement a signature painter in Flutter, see Collin's answer on
[StackOverflow](https://stackoverflow.com/questions/46241071/create-signature-area-
for-mobile-app-in-dart-flutter).

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(home: new DemoApp()));

class DemoApp extends StatelessWidget {
  Widget build(BuildContext context) => new Scaffold(body: new Signature());
}

class Signature extends StatefulWidget {
  SignatureState createState() => new SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];
  Widget build(BuildContext context) {
    return new GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox referenceBox = context.findRenderObject();
          Offset localPosition =
          referenceBox.globalToLocal(details.globalPosition);
          _points = new List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: new CustomPaint(painter: new SignaturePainter(_points), size: Size.infinite),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);
  final List<Offset> points;
  void paint(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }
  bool shouldRepaint(SignaturePainter other) => other.points != points;
}
{% endprettify %}

## Where is the widget's opacity?

On Xamarin.Forms, all `VisualElement`s have an Opacity. In Flutter, you need to
wrap a widget in an [Opacity widget](https://docs.flutter.io/flutter/widgets/Opacity-class.html) 
to accomplish this.

## How do I build custom widgets?

In Xamarin.Forms, you typically subclass `VisualElement`, or use a pre-existing 
`VisualElement`, to override and implement methods that achieve the desired behavior.

In Flutter, build a custom widget by
[composing](/technical-overview/#everythings-a-widget) smaller widgets
(instead of extending them).
It is somewhat similar to implementing a custom control based off a `Grid` with
numerous `VisualElement`s added in, while extending with custom logic.

For example, how do you build a `CustomButton` that takes a label in
the constructor? Create a CustomButton that composes a `RaisedButton` with a label,
rather than by extending `RaisedButton`:

<!-- skip -->
{% prettify dart %}
class CustomButton extends StatelessWidget {
  final String label;

  CustomButton(this.label);

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(onPressed: () {}, child: new Text(label));
  }
}
{% endprettify %}

Then use `CustomButton`, just as you'd use any other Flutter widget:

<!-- skip -->
{% prettify dart %}
@override
Widget build(BuildContext context) {
  return new Center(
    child: new CustomButton("Hello"),
  );
}
{% endprettify %}

# Navigation

## How do I navigate between pages?

TODO

## How do I navigate to another app?

TODO

# Async UI

## What is the equivalent of `Device.BeginOnMainThread()` in Flutter?


TODO

## How do you move work to a background thread?

TODO

## How do I make network requests?

TODO

## What is the equivalent of HttpClient on Flutter?

TODO

## How do I show the progress for a long-running task?

TODO

# Project structure & resources

## Where do I store my resolution-dependent image files?

TODO: iOS and Android specific references here

## Where do I store strings? How do I handle localization?

TODO

## What is the equivalent of Nuget? How do I add dependencies?

TODO

# Activities and fragments (XF Equivalent)

## How do I listen to Android activity lifecycle events? (XF Equiv)

TODO

# Layouts

## What is the equivalent of a LinearLayout?

## What is the equivalent of a RelativeLayout?

## What is the equivalent of a ScrollView?

## How do I handle landscape transitions in Flutter?

# Gesture detection and touch event handling

## How do I add GestureRecognizers to a widget in Flutter?

# Listviews & adapters

## What is the alternative to a ListView in Flutter?

## How do I know which list item is clicked on?

## How do I update ListView's dynamically?

# Working with text

## How do I set custom fonts on my Text widgets?

## How do I style my Text widgets?

# Form input

## What is the equivalent of a "Placeholder" on an Input?

## How do I show validation errors?

# Flutter plugins

## How do I access the GPS sensor?

Use the [`location`](https://pub.dartlang.org/packages/location) community plugin.

## How do I access the camera?

The [`image_picker`](https://pub.dartlang.org/packages/image_picker) plugin is popular
for accessing the camera.

## How do I log in with Facebook?

To Log in with Facebook, use the
[`flutter_facebook_login`](https://pub.dartlang.org/packages/flutter_facebook_login) community plugin.

## How do I use Firebase features?

Most Firebase functions are covered by
[first party plugins](https://pub.dartlang.org/flutter/packages?q=firebase).
These plugins are first-party integrations, maintained by the Flutter team:

 * [`firebase_admob`](https://pub.dartlang.org/packages/firebase_admob) for Firebase AdMob
 * [`firebase_analytics`](https://pub.dartlang.org/packages/firebase_analytics) for Firebase Analytics
 * [`firebase_auth`](https://pub.dartlang.org/packages/firebase_auth) for Firebase Auth
 * [`firebase_database`](https://pub.dartlang.org/packages/firebase_database) for Firebase RTDB
 * [`firebase_storage`](https://pub.dartlang.org/packages/firebase_storage) for Firebase Cloud Storage
 * [`firebase_messaging`](https://pub.dartlang.org/packages/firebase_messaging) for Firebase Messaging (FCM)
 * [`flutter_firebase_ui`](https://pub.dartlang.org/packages/flutter_firebase_ui) for quick Firebase Auth integrations (Facebook, Google, Twitter and email)
 * [`cloud_firestore`](https://pub.dartlang.org/packages/cloud_firestore) for Firebase Cloud Firestore

You can also find some third-party Firebase plugins on Pub that cover areas
not directly covered by the first-party plugins.

## How do I build my own custom native integrations?

If there is platform-specific functionality that Flutter or its community
Plugins are missing, you can build your own following the
[developing packages and plugins](/developing-packages/) page.

Flutter's plugin architecture, in a nutshell, is much like using an Event bus in
Android: you fire off a message and let the receiver process and emit a result
back to you. In this case, the receiver is code running on the native side
on Android or iOS.

## How do I use the NDK in my Flutter application?

TODO

# Themes (Styles)

## How do I theme my app?


# Databases and local storage

## How do I access Shared Preferences?


## How do I access SQLite in Flutter?

In Android, you use SQLite to store structured data that you can query
using SQL.

In Flutter, access this functionality using the
[SQFlite](https://pub.dartlang.org/packages/sqflite) plugin.

# Notifications

## How do I set up push notifications?