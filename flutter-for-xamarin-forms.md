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

In Xamarin.Forms, you navigate between pages normally through a, you can use a
`NavigationPage` that manages the stack of pages to display.

Flutter has a similar implementation, using a `Navigator` and
`Routes`. A `Route` is an abstraction for a `Page` of an app, and
a `Navigator` is a [widget](technical-overview/#everythings-a-widget)
that manages routes. 

A route roughly maps to a `Page`. The navigator works in a similar way to the 
Xamarin.Forms `NavigationPage`, in that it can `push()` and `pop()` routes 
depending on whether you want to navigate to, or back from, a view.

To navigate between pages, you have a couple options:

* Specify a `Map` of route names. (MaterialApp)
* Directly navigate to a route. (WidgetApp)

The following example builds a Map.

<!-- skip -->
{% prettify dart %}
void main() {
  runApp(new MaterialApp(
    home: new MyAppHome(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => new MyPage(title: 'page A'),
      '/b': (BuildContext context) => new MyPage(title: 'page B'),
      '/c': (BuildContext context) => new MyPage(title: 'page C'),
    },
  ));
}
{% endprettify %}

Navigate to a route by `push`ing its name to the `Navigator`.

<!-- skip -->
{% prettify dart %}
Navigator.of(context).pushNamed('/b');
{% endprettify %}

The `Navigator` class handles routing in Flutter and is used to get
a result back from a route that you have pushed on the stack. This is done
by `await`ing on the `Future` returned by `push()`.

For example, to start a ‘location’ route that lets the user select their
location, you might do the following:

<!-- skip -->
{% prettify dart %}
Map coordinates = await Navigator.of(context).pushNamed('/location');
{% endprettify %}

And then, inside your ‘location’ route, once the user has selected their
location, `pop()` the stack with the result:

<!-- skip -->
{% prettify dart %}
Navigator.of(context).pop({"lat":43.821757,"long":-79.226392});
{% endprettify %}

## How do I navigate to another app?

In Xamarin.Forms, to send the user to another application, you use a
specific URI scheme, using `Device.OpenUrl("mailto://")` 

To implement this functionality in Flutter, create a native platform integration, 
or use an existing [plugin](#plugins), such as
[`url_launcher`](https://pub.dartlang.org/packages/url_launcher).

# Async UI

## What is the equivalent of `Device.BeginOnMainThread()` in Flutter?

Dart has a single-threaded execution model, with support for `Isolate`s
(a way to run Dart code on another thread), an event loop, and
asynchronous programming. Unless you spawn an `Isolate`, your Dart code
runs in the main UI thread and is driven by an event loop.

Dart's single-threaded model doesn't mean you need to run everything as a
blocking operation that causes the UI to freeze. Much like Xamarin.Forms, you 
need to keep the UI thread free. You would use `async`/`await` to perform
tasks, where you must wait for the response.

In Flutter, use the asynchronous facilities that the Dart language provides, also
named `async`/`await`, to perform asynchronous work. This is very similar to
C# and should be very easy to use for any Xamarin.Forms developer.

For example, you can run network code without causing the UI to hang by
using `async`/`await` and letting Dart do the heavy lifting:

<!-- skip -->
{% prettify dart %}
loadData() async {
  String dataURL = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(dataURL);
  setState(() {
    widgets = json.decode(response.body);
  });
}
{% endprettify %}

Once the `await`ed network call is done, update the UI by calling `setState()`,
which triggers a rebuild of the widget sub-tree and updates the data.

The following example loads data asynchronously and displays it in a `ListView`:

<!-- skip -->
{% prettify dart %}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
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
  List widgets = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          }));
  }

  Widget getRow(int i) {
    return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Text("Row ${widgets[i]["title"]}")
    );
  }

  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
{% endprettify %}

Refer to the next section for more information on doing work in the
background, and how Flutter differs from Android.

## How do you move work to a background thread?

Since Flutter is single threaded and runs an event loop, you
don't have to worry about thread management or spawning background threads. 
This is very similar to Xamarin.Forms. If you're doing I/O-bound work, such as disk 
access or a network call, then you can safely use `async`/`await` and you're all set. 

If, on the other hand, you need to do computationally intensive work that keeps the 
CPU busy, you want to move it to an `Isolate` to avoid blocking the event loop, like
you would keep _any_ sort of work out of the main thread. This is similar to when you 
move things to a different thread via `Task.Run()` in Xamarin.Forms.

For I/O-bound work, declare the function as an `async` function,
and `await` on long-running tasks inside the function:

<!-- skip -->
{% prettify dart %}
loadData() async {
  String dataURL = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(dataURL);
  setState(() {
    widgets = json.decode(response.body);
  });
}
{% endprettify %}

This is how you would typically do network or database calls, which are both
I/O operations.

However, there are times when you might be processing a large amount of data and
your UI hangs. In Flutter, use `Isolate`s to take advantage of
multiple CPU cores to do long-running or computationally intensive tasks.

Isolates are separate execution threads that do not share any memory
with the main execution memory heap. THis is a difference between `Task.Run()`. This
means you can’t access variables from the main thread, or update your UI by calling 
`setState()`.

The following example shows, in a simple isolate, how to share data back to
the main thread to update the UI.

<!-- skip -->
{% prettify dart %}
loadData() async {
  ReceivePort receivePort = new ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);

  // The 'echo' isolate sends its SendPort as the first message
  SendPort sendPort = await receivePort.first;

  List msg = await sendReceive(sendPort, "https://jsonplaceholder.typicode.com/posts");

  setState(() {
    widgets = msg;
  });
}

// The entry point for the isolate
static dataLoader(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  ReceivePort port = new ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);

  await for (var msg in port) {
    String data = msg[0];
    SendPort replyTo = msg[1];

    String dataURL = data;
    http.Response response = await http.get(dataURL);
    // Lots of JSON to parse
    replyTo.send(json.decode(response.body));
  }
}

Future sendReceive(SendPort port, msg) {
  ReceivePort response = new ReceivePort();
  port.send([msg, response.sendPort]);
  return response.first;
}
{% endprettify %}

Here, `dataLoader()` is the `Isolate` that runs in its own separate execution thread.
In the isolate you can perform more CPU intensive processing (parsing a big JSON, for
example), or perform computationally intensive math, such as encryption or signal processing.

You can run the full example below:

{% prettify dart %}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:isolate';

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
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
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    }

    return false;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Sample App"),
        ),
        body: getBody());
  }

  ListView getListView() => new ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return new Padding(padding: new EdgeInsets.all(10.0), child: new Text("Row ${widgets[i]["title"]}"));
  }

  loadData() async {
    ReceivePort receivePort = new ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message
    SendPort sendPort = await receivePort.first;

    List msg = await sendReceive(sendPort, "https://jsonplaceholder.typicode.com/posts");

    setState(() {
      widgets = msg;
    });
  }

  // the entry point for the isolate
  static dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    ReceivePort port = new ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;
      http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      replyTo.send(json.decode(response.body));
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = new ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
}
{% endprettify %}

## How do I make network requests?

In Xamarin.Forms you would use `HttpClient`. Making a network call in Flutter
is easy when you use the popular [`http` package](https://pub.dartlang.org/packages/http). 
This abstracts away a lot of the networking that you might normally implement yourself,
making it simple to make network calls.

To use the `http` package, add it to your dependencies in `pubspec.yaml`:

<!-- skip -->
{% prettify yaml %}
dependencies:
  ...
  http: ^0.11.3+16
{% endprettify %}

To make a network call, call `await` on the `async` function `http.get()`:

<!-- skip -->
{% prettify dart %}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
[...]
  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
{% endprettify %}

## How do I show the progress for a long-running task?

In Xamarin.Forms you would typically create a loading indicator, either
directly in XAML or through a 3rd party plugin such as AcrDialogs.

In Flutter, use a `ProgressIndicator` widget. Show the progress programmatically 
by controlling when it's rendered through a boolean flag. Tell Flutter to update 
its state before your long-running task starts, and hide it after it ends.

In the following example, the build function is separated into three different
functions. If `showLoadingDialog()` is `true` (when `widgets.length == 0`),
then render the `ProgressIndicator`. Otherwise, render the
`ListView` with the data returned from a network call.

<!-- skip -->
{% prettify dart %}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
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
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    return widgets.length == 0;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Sample App"),
        ),
        body: getBody());
  }

  ListView getListView() => new ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return new Padding(padding: new EdgeInsets.all(10.0), child: new Text("Row ${widgets[i]["title"]}"));
  }

  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
{% endprettify %}

# Project structure & resources

## Where do I store my image files?

Xamarin.Forms has no platform independent way of storing images, you had to place
images in the iOS `xcasset` folder or on Android, in the various `drawable` folders.

While Android and iOS treat resources and assets as distinct items, Flutter apps have
only assets. All resources that would live in the `Resources/drawable-*`
folders on Android, are placed in an assets folder for Flutter.

Flutter follows a simple density-based format like iOS. Assets might be `1.0x`,
`2.0x`, `3.0x`, or any other multiplier. Flutter doesn't have `dp`s but there
are logical pixels, which are basically the same as device-independent pixels.
The so-called
[`devicePixelRatio`](https://docs.flutter.io/flutter/dart-ui/Window/devicePixelRatio.html)
expresses the ratio of physical pixels in a single logical pixel.

The equivalent to Android's density buckets are:

 Android density qualifier | Flutter pixel ratio
 --- | ---
 `ldpi` | `0.75x`
 `mdpi` | `1.0x`
 `hdpi` | `1.5x`
 `xhdpi` | `2.0x`
 `xxhdpi` | `3.0x`
 `xxxhdpi` | `4.0x`

Assets are located in any arbitrary folder&mdash;Flutter has no
predefined folder structure. You declare the assets (with location) in
the `pubspec.yaml` file, and Flutter picks them up.

Note that before Flutter 1.0 beta 2, assets defined in Flutter were not
accessible from the native side, and vice versa, native assets and resources
weren’t available to Flutter, as they lived in separate folders.

As of Flutter beta 2, assets are stored in the native asset folder,
and are accessed on the native side using Android's `AssetManager`:

As of Flutter beta 2, Flutter still cannot access native resources, nor it can
access native assets.

To add a new image asset called `my_icon.png` to our Flutter project, for example,
and deciding that it should live in a folder we arbitrarily called `images`, you
would put the base image (1.0x) in the `images` folder, and all the other
variants in sub-folders called with the appropriate ratio multiplier:

```
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image
```

Next, you'll need to declare these images in your `pubspec.yaml` file:

<!-- skip -->
{% prettify yaml %}
assets:
 - images/my_icon.jpeg
{% endprettify %}

You can then access your images using `AssetImage`:

<!-- skip -->
{% prettify dart %}
return new AssetImage("images/a_dot_burr.jpeg");
{% endprettify %}

or directly in an `Image` widget:

<!-- skip -->
{% prettify dart %}
@override
Widget build(BuildContext context) {
  return new Image.asset("images/my_image.png");
}
{% endprettify %}

More detailed information can be found in 
[Adding Assets and Images in Flutter](https://flutter.io/assets-and-images/).

## Where do I store strings? How do I handle localization?

Unlike .NET which has `resx` files, Flutter currently doesn't have a dedicated 
resources-like system for strings. At the moment, the best practice is to hold your 
copy text in a class as static fields and accessing them from there. For example:

<!-- skip -->
{% prettify dart %}
class Strings {
  static String welcomeMessage = "Welcome To Flutter";
}
{% endprettify %}

Then in your code, you can access your strings as such:

<!-- skip -->
{% prettify dart %}
new Text(Strings.welcomeMessage)
{% endprettify %}

By default, Flutter only supports US English for its strings. If you need to
add support for other languages, include the `flutter_localizations`
package. You might also need to add Dart's [`intl`](https://pub.dartlang.org/packages/intl)
package to use i10n machinery, such as date/time formatting.

<!-- skip -->
{% prettify yaml %}
dependencies:
  # ...
  flutter_localizations:
    sdk: flutter
  intl: "^0.15.6"
{% endprettify %}

To use the `flutter_localizations` package,
specify the `localizationsDelegates` and `supportedLocales` on the app widget:

<!-- skip -->
{% prettify dart %}
import 'package:flutter_localizations/flutter_localizations.dart';

new MaterialApp(
 localizationsDelegates: [
   // Add app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en', 'US'), // English
    const Locale('he', 'IL'), // Hebrew
    // ... other locales the app supports
  ],
  // ...
)
{% endprettify %}

The delegates contain the actual localized values, while the `supportedLocales`
defines which locales the app supports. The above example uses a `MaterialApp`,
so it has both a `GlobalWidgetsLocalizations` for the base
widgets localized values, and a `MaterialWidgetsLocalizations` for the Material
widgets localizations. If you use `WidgetsApp` for your app, you don't
need the latter. Note that these two delegates contain "default"
values, but you'll need to provide one or more delegates for your own app's
localizable copy, if you want those to be localized too.

When initialized, the `WidgetsApp` (or `MaterialApp`) creates a
[`Localizations`](https://docs.flutter.io/flutter/widgets/Localizations-class.html)
widget for you, with the delegates you specify.
The current locale for the device is always accessible from the `Localizations`
widget from the current context (in the form of a `Locale` object), or using the
[`Window.locale`](https://docs.flutter.io/flutter/dart-ui/Window/locale.html).

To access localized resources, use the `Localizations.of()` method to
access a specific localizations class that is provided by a given delegate.
Use the [`intl_translation`](https://pub.dartlang.org/packages/intl_translation)
package to extract translatable copy to
[arb](https://code.google.com/p/arb/wiki/ApplicationResourceBundleSpecification)
files for translating, and importing them back into the app for using them
with `intl`.

For further details on internationalization and localization in Flutter, see the
[internationalization guide](/tutorials/internationalization),
which has sample code with and without the `intl` package.

## Where is my project file?

In Xamarin.Forms you will have a `csproj` file. Flutter doesn't have a project file.
Most similar to this, is pubspec.yaml, which contains package dependencies and 
various project details.

## What is the equivalent of Nuget? How do I add dependencies?

In the .NET eco-system, native Xamarin projects and Xamarin.Forms projects had access
to Nuget and the inbuilt package management system. Flutter apps contain a native 
Android app, native iOS app and Flutter app.

In Android, you add dependencies by adding to your Gradle build script. In iOS, you add 
dependencies by adding to your `Podfile`.

Flutter uses Dart's own build system, and the Pub package manager.
The tools delegate the building of the native Android and iOS wrapper apps to the
respective build systems.

In general, use `pubspec.yaml` to declare external dependencies to use in Flutter. A good 
place to find Flutter packages is [Pub](https://pub.dartlang.org/flutter/packages/).

# Application Lifecycle

## How do I listen to application lifecycle events?

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