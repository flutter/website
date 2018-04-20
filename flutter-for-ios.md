---
layout: page
title: Flutter for iOS Developers
permalink: /flutter-for-ios/
---

# This document is a work in progress
We're working on this document right now. Please do not rely on its completeness
and accuracy until it's finished and it's shown in the sidebar as a link.

---

This document is meant for iOS developers looking to apply their
existing iOS knowledge to build mobile apps with Flutter. If you understand
the fundamentals of the iOS framework then you can use this document as a
jump start to Flutter development.

Your iOS knowledge and skill set are highly valuable when building with
Flutter, because Flutter relies on the mobile operating system for numerous
capabilities and configurations. Flutter is a new way to build UIs for mobile,
but it has a plugin system to communicate with iOS (and Android) for non-UI
tasks. If you're an expert in iOS development, you don't have to relearn everything
to use Flutter.

This document can be used as a cookbook by jumping around and finding questions
that are most relevant to your needs.

* TOC Placeholder
{:toc}

# Views

## What is the equivalent of a `UIView` in Flutter?

On iOS, the majority of anything you may want to create in the UI is done using
view objects, which are instances of the `UIView` class.  These can act as
containers for other `UIView` classes, which form your layout.

In Flutter, the equivalent to this is a `Widget`. However, these have a few
differences to a  `UIView`. To start, widgets only exist for one frame, and on
every new frame, Flutter’s framework creates a new tree of widget instances.
In comparison, an iOS view is drawn once and does not redraw until it is
invalidated using `setNeedsDisplay()`.

Furthermore, unlike `UIView`, Flutter’s widgets are immutable, which allows
them to be very lightweight. By default, Flutter’s widgets are styled as
‘Material’ (i.e. Android themed), however you can use [Cupertino
widgets](https://flutter.io/widgets/cupertino/) to specify an iOS theme if you
require.

## How do I update `Widget`s?

To update your views on iOS you directly mutate them. In Flutter, widgets are
immutable and not updated directly. Instead, you have to manipulate the
widget’s state. This is where the concept of Stateful vs Stateless widgets
comes in. A `StatelessWidget` is just what it sounds like - a widget with no
state attached.

`StatelessWidgets` are useful when the part of the user interface you are
describing does not depend on anything other than the initial configuration
information in the widget.

For example, in iOS, this would be similar to placing a `UIImageView` with
your logo as the `image`. If the logo is not going to change during runtime,
you would use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received after making an
HTTP call then you would use a `StatefulWidget`. After the HTTP call had
complete, you would tell the Flutter framework that the widget’s `State` has
been updated so it could update the widget.

The important thing to note here is at the core both stateless and stateful
widgets behave the same i.e. they rebuild every frame. The difference is that
the `StatefulWidget` has a `State` object which stores state data across
frames and restores it after being rebuilt.

If you are in doubt, then always remember this rule: if a widget changes (e.g.
because of runtime user interactions) it’s stateful. If the only time data
changes is at instantiation, it’s stateless. However, if a widget is reacting
to change, then the containing parent widget can still be stateless if it
isn’t itself reacting to change.

Let's take a look at how you would use a `StatelessWidget`. A common
`StatelessWidget` is the `Text` widget. If you look at the implementation of
the `Text` widget you'll find it subclasses `StatelessWidget`.

<!-- skip -->
{% prettify dart %}
new Text(
  'I like Flutter!',
  style: new TextStyle(fontWeight: FontWeight.bold),
);
{% endprettify %}

"If you look at the code above, you might notice that the `Text` widget
"carries no explicit state with it. It renders what is passed in its
"constructors and nothing more.

But, what if you want to make "I Like Flutter" change dynamically, for example
when clicking a `FloatingActionButton`?

This can be achieved by wrapping the `Text` widget in a `StatefulWidget` and
updating it when the button is clicked.

For example:

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

## How do I layout my widgets? Where is my Storyboard? 

In iOS, you may use a Storyboard file to organise your views and set
constraints, or set your constraints programmatically within your view
controllers. In Flutter, you declare your layouts within code, by composing
the layout tree.

Here is an example of how you would display a simple widget on the screen and
add some padding to it.

<!-- skip -->
{% prettify dart %}
@override
Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Sample App"),
    ),
    body: new Center(
      child: new CupertinoButton(
        onPressed: () {
          setState(() { _pressedCount += 1; });
        },
        child: new Text('Hello'),
        padding: new EdgeInsets.only(left: 10.0, right: 10.0),
      ),
    ),
  );
}
{% endprettify %}

You can add padding to any widget, which mimics the functionality of
constraints in iOS.

You can view all the layouts that Flutter has to offer in the [widget
catalog](https://flutter.io/widgets/layout/).

## How do I add or remove a component from my layout?

In iOS, you would call `addSubview()` on the parent or `removeFromSuperview()`
on a child view to dynamically add or remove child views. In Flutter, because
widgets are immutable there is no direct equivalent to `addSubview()`.
Instead, you can pass in a function to the parent that returns a widget and
control that child's creation via a boolean flag.

For example, here is how you can toggle between two widgets when you click on
a `FloatingActionButton`:

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

## How do I animate a Widget?

In iOS, you would create an animation by calling the
`animate(withDuration:animations:)` method on a view. In Flutter, animating
widgets can be done via the animation library by wrapping widgets inside an
animated widget.

In Flutter you use an `AnimationController` which is an `Animation<double>`
that can pause, seek, stop and reverse the animation. It requires a `Ticker`
which signals when vsync happens and produces a linear interpolation between
0 and 1 on each frame while it's running. You then create one or more
`Animation`s and attach them to the controller.

For example, you could have a `CurvedAnimation` to have an animation which
uses a curve to interpolate another animation. In this sense, the controller
is the "master" source of the animation progress and the `CurvedAnimation` is
tasked to modify the controller's linear output to a curve. Like widgets,
animations in Flutter work with composition.

When building the widget tree you then assign the `Animation` to an animated
property of a widget, such as the opacity of a `FadeTransition`, and tell the
controller to start the animation.

Let's take a look at how to write a `FadeTransition` that will fade in a logo
when you press a `FloatingActionButton`:

<!-- skip -->
{% prettify dart %}
class SampleApp extends StatelessWidget {
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
            )
          )
        )
      ),
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


See
[https://flutter.io/widgets/animation/](https://flutter.io/widgets/animation/)
and [https://flutter.io/tutorials/animation](https://flutter.io/tutorials/animation)
for more specific details.

## How do I draw to the screen?

On iOS, you would use `CoreGraphics` in order to draw lines and shapes to the
screen. Flutter has a different API based on the `Canvas` class, with two
other classes that help you draw: `CustomPaint` and `CustomPainter`, the
latter of which implements your algorithm to draw to the canvas.

In this [popular StackOverflow
answer](https://stackoverflow.com/questions/46241071/create-signature-area-
for-mobile-app-in-dart-flutter) you can see how to implement a signature
painter in Flutter.

<!-- skip -->
{% prettify dart %}
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
{% endprettify %}

## How do I build custom widgets?

In iOS, you would typically subclass from `UIView` or a pre-existing view to
override and implement methods in order to obtain the desired behavior. In
Flutter building a custom widget is often accomplished not by extending but by
[composing](https://flutter.io/technical-overview/#everythings-a-widget)
smaller widgets.

Let's take a look at how to build a `CustomButton` that takes in a label in
the constructor. This is achieved by composing it with `RaisedButton`, rather
than extending `RaisedButton` and overriding and implementing new methods:

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

Then you can use this `CustomButton` just like you would with any other widget:

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

In iOS, to travel between view controllers, you can use a
`UINavigationController` that manages the stack of view controllers to
display.

Flutter has a relatively similar implementation, using a `Navigator` and
`Routes`. A `Route` is an abstraction for a “screen” or “page” of an app, and
a `Navigator` is a [widget](https://flutter.io/technical-
overview/#everythings-a-widget) that manages routes. A route roughly maps to a
`UIViewController`. The navigator works in a similar way to the iOS
`UINavigationController`, in that it can `push()` and `pop()` routes depending
on whether you want to navigate to, or back from, a view.

Unlike iOS, you will need to pass in a `Map` of names of routes to the top
level `App` instance to declare all of your routes:

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
 
You can then navigate to a route by getting hold of the `Navigator` and
`push`ing one of the named routes.

<!-- skip -->
{% prettify dart %}
Navigator.of(context).pushNamed('/b');
{% endprettify %}

The `Navigator` class which handles all routing in Flutter can be used to get
a result back from a route that you have pushed on the stack. This can be done
by `await`ing on the `Future` returned by `push()`. For example, if you were
to start a ‘location’ route which lets the user select their location, you
could do:

<!-- skip -->
{% prettify dart %}
Map coordinates = await Navigator.of(context).pushNamed('/location');
{% endprettify %}

And then, inside your ‘location’ route, once the user has selected their
location you can `pop()` the stack with the result:

<!-- skip -->
{% prettify dart %}
Navigator.of(context).pop({"lat":43.821757,"long":-79.226392});
{% endprettify %}

## Navigating to other apps

In iOS, in order to send the user to another application, you would use a
specific URL scheme. For the system level apps, there are specific schemes you
would use. In order to implement this functionality in Flutter, you would need
to create a native platform integration, or use an existing
[plugin](#plugins), such as
[`url_launcher`](https://pub.dartlang.org/packages/url_launcher).

# Threading & Asynchronicity

## Asynchronous UI

Dart has a single-threaded execution model, with support for `Isolate`s (a way
to run Dart code on another thread), an event loop, and asynchronous programming.
Unless you spawn an `Isolate`, your Dart code runs in the main UI thread and is
driven by an event loop. Flutter’s event loop is equivalent to the iOS main loop
— that is, the `Looper` that is attached to the main thread.

Dart’s single-threaded model doesn’t mean you are required to run everything as
a blocking operation that will cause the UI to freeze. Instead, in Flutter you
use the asynchronous facilities that the Dart language provides, such as
`async`/`await`, to perform asynchronous work. 

For example, you can run network code without causing the UI to hang by using
`async`/`await` and letting Dart do the heavy lifting:

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


Once the `await`ed network call is done, you update the UI calling
`setState()`, which triggers a rebuild of the widget tree and updates the
data.

Here's an example of loading data asynchronously and displaying it 
in a `ListView`:

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
background in Flutter and how it differs from iOS.

## How do you move work to a background thread?

Since Flutter is single threaded and runs an event loop (like Node.js), you
don't have to worry about thread management or spawning background threads. If
you're doing I/O-bound work, such as a disk access or a network call, then
you can safely just use `async`/`await` and you're all set. If, on the other
hand, you need to do computationally intensive work that keeps the CPU busy,
you want to move it to an `Isolate` as to avoid blocking the event loop.

For I/O-bound work, you can declare the function as an `async` function
and `await` on long-running tasks in the function:

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

However, there are times where you may be processing a large amount of data and
your UI could hang. In Flutter it is possible to take advantage of multiple CPU
cores to do long-running or computationally intensive tasks. This is done by
using `Isolate`s.

Isolates are separate execution threads that run and do not share any memory
with the main execution memory heap. This means you can’t access variables from
the main thread or update your UI by calling `setState()`. Isolates are true to
their name, and cannot share memory (e.g. in the form of static fields).

Let's see an example of a simple isolate and how you can communicate and share
data back to the main thread to update your UI.

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
In this isolate you can do more CPU intensive processing, for example parsing a big
JSON, or doing computationally intensive math such as encryption or signal processing.

A full example that you can run is below.

<!-- skip -->
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

Making a network call in Flutter is easy when you use the popular
[`http` package](https://pub.dartlang.org/packages/http). This abstracts
away a lot of the networking that you would normally implement yourself,
making it a simple way to make network calls.

You can use it by adding it to your dependencies in `pubspec.yaml`:

<!-- skip -->
{% prettify yaml %}
dependencies:
  ...
  http: '>=0.11.3+16'
{% endprettify %}

Then to make a network call, you `await` on the `async` function `http.get()`:

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

## How do I show the progress of a long-running task in Flutter?

In iOS, you would typically use a `UIProgressView` while executing a
long-running task in the background. 

In Flutter this can be done by using a `ProgressIndicator` widget. You can
show the progress UI programmatically by controlling when it's rendered
through a boolean flag, and telling Flutter to update its state before your
long-running task starts, and hiding it after it ends.

In the example below, we break up the build function into three different
functions. If `showLoadingDialog()` is `true` (when `widgets.length == 0`)
then we render the `ProgressIndicator`. Alternatively, we render the
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

# Project Structure & Resources

## How do I include image assets for Flutter? What about multiple resolutions?

While iOS treats images and assets as distinct items, Flutter apps have only
assets. All your resources which would be placed in the `Images.xcasset`
folder on iOS should be instead put in an assets folder.

Flutter follows a simple density-based format like iOS. Assets can be `1.0x`,
`2.0x`, `3.0x`, or any other multiplier. The so-called
[`devicePixelRatio`](https://docs.flutter.io/flutter/dart-
ui/Window/devicePixelRatio.html) expresses the ratio of physical pixels in a
single logical pixel.

Assets on Flutter can be located in any arbitrary folder; there is no
predefined folder structure. You then declare where the assets are located in
the `pubspec.yaml` file and Flutter will pick them up.

For example, to add a new image asset called `my_icon.png` to your Flutter
project, you may decide to store it in a folder we arbitrarily called `images`.
You would then put the base image (1.0x) in the `images` folder, and all the
other variants in sub-folders named after the appropriate ratio multiplier:
 
```
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image
```

Next, you will need to declare these images in our `pubspec.yaml` file:

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

## Where do I store strings? How do I handle localization?

Unlike iOS, which has the `Localizable.strings` file, Flutter does not
currently have a dedicated system for handling strings. At the moment, the
best practice is to declare your copy text in a class as static fields and
access them from there. For example:

<!-- skip -->
{% prettify dart %}
class Strings {
  static String welcomeMessage = "Welcome To Flutter";
}
{% endprettify %}

You can access your strings as such:

<!-- skip -->
{% prettify dart %}
new Text(Strings.welcomeMessage)
{% endprettify %}


While there's no functionality built into Flutter to handle
internationalization or localization, Flutter developers are encouraged to use
the [intl package](https://pub.dartlang.org/packages/intl) for those needs.

Note that before Flutter 1.0 beta 2, assets defined in Flutter were not
accessible from the native side, and vice versa, native assets and resources
weren’t available from Flutter as they lived in separate folders.

## What is the equivalent of Cocoapods? How do I add dependencies?

In iOS, you add dependencies by adding to your `Podfile`. Flutter uses Dart’s
own build system and the Pub package manager to handle dependencies. They then
delegate the building of the native Android and iOS wrapper apps to the
respective build systems. While there is a Podfile in the iOS folder in your
Flutter project, you should only use this if you are adding native
dependencies needed for per-platform integration. In general, you can use
`pubspec.yaml` to declare external dependencies in Flutter. A good place to
find great packages for Flutter is
[Pub](https://pub.dartlang.org/flutter/packages/).

# ViewControllers

## What is the equivalent to `ViewController`s in Flutter?

In iOS, a `ViewController` represents a portion of user interface, most
commonly used for a screen or section. These can be composed together to build
complex user interfaces, and help scale your application UI. In Flutter this
concept falls under the umbrella of `Widget`s. As mentioned in the Navigation
section, screens in Flutter are represented by `Widget`s since everything is a
widget in Flutter. You use a `Navigator` to move between different `Route`s
which represent different screens or pages, or maybe just different states or
renderings of the same data.

## How do I listen to iOS lifecycle events?

In iOS, you can override methods to the `ViewController` to capture lifecycle
methods for the view itself, or register lifecycle callbacks in the
`AppDelegate`. In Flutter you have neither concept, but you can instead listen
to lifecycle events by hooking into the `WidgetsBinding` observer and
listening to the `didChangeAppLifecycleState()` change event.

The lifecycle events you can observe are:

* `inactive` — The application is in an inactive state and is not receiving
user   input. This event only works on iOS, as there is no equivalent event to
map to   on Android * `paused` — The application is not currently visible to
the user, not responding   to user input, and running in the background. *
`resumed` — The application is visible and responding to user input. *
`suspending` — The application will be suspended momentarily. It is not
triggered on iOS as there is no equivalent   event to map to on iOS

For more details on the meaning of these states, you can check the
[`AppLifecycleStatus` documentation](https://docs.flutter.io/flutter/dart-ui
/AppLifecycleState-class.html).

# Layouts

## What is the equivalent of a `UITableView` or `UICollectionView` in Flutter?

In iOS, you might show a list in either a `UITableView` or a
`UICollectionView`. In Flutter, you can have a similar implementation using a
`ListView`.

In iOS, these views have delegate methods for deciding the number of rows, the
cell for each index path, and the size of the cells. In Flutter, due to
Flutter’s immutable widget pattern, you pass in a list of widgets to your
`ListView`, and Flutter will take care of making sure they are scrolling fast
and smooth.

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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new ListView(children: _getListData()),
    );
  }

  _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(new Padding(padding: new EdgeInsets.all(10.0), child: new Text("Row $i")));
    }
    return widgets;
  }
}
{% endprettify %}

## How do I know which list item is clicked?

In iOS, you would implement the delegate method `tableView:didSelectRowAtIndexPath:`. Flutter makes it even easier by letting you just use the touch handling that the widgets you passed in have.

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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new ListView(children: _getListData()),
    );
  }

  _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(new GestureDetector(
        child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Text("Row $i"),
        ),
        onTap: () {
          print('row tapped');
        },
      ));
    }
    return widgets;
  }
}
{% endprettify %}

## How do I update `ListView`s dynamically?

In iOS, you would update the data for the list view, and notify the table or
collection view using the `reloadData` method. In Flutter if you were to update
the list of widgets inside a `setState()`, you would quickly see that your
data did not change visually.

This is because when `setState()` is called, the Flutter rendering engine will
go through all the widgets to see if they have changed. When it gets to your
`ListView` it will do a `==` check and see that the two `ListView`s are the
same and nothing has changed, hence no update to the data.

To update your `ListView` then you need to create a new `List` inside of
`setState()` and copy over all the old data to the new list. This is a simple
way to achieve an update.

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
  List widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new ListView(children: widgets),
    );
  }

  Widget getRow(int i) {
    return new GestureDetector(
      child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Text("Row $i"),
      ),
      onTap: () {
        setState(() {
          widgets = new List.from(widgets);
          widgets.add(getRow(widgets.length + 1));
          print('row $i');
        });
      },
    );
  }
}
{% endprettify %}

However the recommended, efficient, and effective way is to use a
`ListView.Builder`. This method is great when you have a dynamic
list or a list with very large amounts of data.

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
  List widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
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
        },
      ),
    );
  }

  Widget getRow(int i) {
    return new GestureDetector(
      child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Text("Row $i"),
      ),
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length + 1));
          print('row $i');
        });
      },
    );
  }
}
{% endprettify %}

Instead of creating a "new ListView", we create a new `ListView.builder` which
takes two key parameters, the initial length of the list and an `ItemBuilder`
function.

The `ItemBuilder` function is similar to the `cellForItemAt` delegate method
in an iOS table or collection view, as it takes a position and returns the
cell that you want to be rendered for that position.

Lastly, but most importantly, you can notice that in the `onTap()` function we
don't recreate the list anymore but instead just `.add` to it.

## What is the equivalent of a `ScrollView` in Flutter?

In iOS, you wrap your views in a `ScrollView` which allows a user to scroll
your content if needed.

In Flutter the easiest way to do this is using the `ListView` widget. This
acts as both a `ScrollView` and an iOS `TableView`, as you can layout widgets
in a vertical format.
  
<!-- skip -->
{% prettify dart %}  
@override  
Widget build(BuildContext context) {  
  return new ListView(  
    children: <Widget>[  
      new Text('Row One'),  
      new Text('Row Two'),  
      new Text('Row Three'),  
      new Text('Row Four'),  
    ],  
  );  
}  
{% endprettify %}

For a more detailed view at the different layout widgets available on Flutter,
see the documentation [here](https://flutter.io/widgets/layout/).

# Gesture Detection and Touch Event Handling

## How do I add a click listener to a widget in Flutter?

In iOS, you can attach a `GestureRecognizer` to a view in order to handle
click events. In Flutter there are two ways of adding touch listeners:

1. If the widget has support for event detection you can just pass in a
   function to it and handle the event in the function. For example, the
   `RaisedButton` has an `onPressed` parameter:

   <!-- skip -->
   {% prettify dart %}
   @override
   Widget build(BuildContext context) {
     return new RaisedButton(
       onPressed: () {
         print("click");
       },
       child: new Text("Button"),
     );
   }
   {% endprettify %}

2. If the widget does not have support for event detection, you can wrap up the
   widget in a `GestureDetector` and pass in a function to the `onTap` parameter.

   <!-- skip -->
   {% prettify dart %}
   class SampleApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return new Scaffold(
         body: new Center(
           child: new GestureDetector(
             child: new FlutterLogo(
               size: 200.0,
             ),
             onTap: () {
               print("tap");
             },
           ),
         ),
       );
     }
   }
   {% endprettify %}

## How do I handle other gestures on widgets?

Using the `GestureDetector` we can listen to a wide range of gestures such as:

- Tapping

  - `onTapDown` — A pointer that might cause a tap has contacted the screen at a
    particular location.
  - `onTapUp` — A pointer that will trigger a tap has stopped contacting the
    screen at a particular location.
  - `onTap` — A tap has occurred.
  - `onTapCancel` — The pointer that previously triggered the `onTapDown` will
    not end up causing a tap.

- Double tapping

  - `onDoubleTap` — The user has tapped the screen at the same location twice in
    quick succession.

- Long pressing

  - `onLongPress` — A pointer has remained in contact with the screen at the same
    location for a long period of time.

- Vertical dragging

  - `onVerticalDragStart` — A pointer has contacted the screen and might begin to
    move vertically.
  - `onVerticalDragUpdate` — A pointer that is in contact with the screen and
    moving vertically has moved in the vertical direction.
  - `onVerticalDragEnd` — A pointer that was previously in contact with the
    screen and moving vertically is no longer in contact with the screen and was
    moving at a specific velocity when it stopped contacting the screen.

- Horizontal dragging

  - `onHorizontalDragStart` — A pointer has contacted the screen and might begin
    to move horizontally.
  - `onHorizontalDragUpdate` — A pointer that is in contact with the screen and
    moving horizontally has moved more in the horizontal direction.
  - `onHorizontalDragEnd` — A pointer that was previously in contact with the
    screen and moving horizontally is no longer in contact with the screen.

For example here is a `GestureDetector` for double tapping on the Flutter logo that
will make it rotate:

<!-- skip -->
{% prettify dart %}
AnimationController controller;
CurvedAnimation curve;

@override
void initState() {
  controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
  curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new GestureDetector(
          child: new RotationTransition(
            turns: curve,
            child: new FlutterLogo(
              size: 200.0,
            )),
          onDoubleTap: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
        ),
      ),
    );
  }
}
{% endprettify %}

# Theming and text

## How do I theme an app?

You may have noticed a lot of the examples in this document use a `MaterialApp`
as their app widget. This provides a base of themed widgets to use in your app.
However these are more themed to an Android device, so in order to use more iOS
focused widgets you will need to implement these as needed. You can find the
full set [here](https://flutter.io/widgets/cupertino/).

You could also use a `WidgetApp` as your app widget, which provides some of the
same functionality, but is not yet as broad as `MaterialApp`.

To customize the colors and styles of any child components you can pass in a
`ThemeData` object to the `MaterialApp` widget. For example, in the code below
you can see the primary swatch is set to blue and all text selection color
should be red.

<!-- skip -->
{% prettify dart %}
class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        textSelectionColor: Colors.red
      ),
      home: new SampleAppPage(),
    );
  }
}
{% endprettify %}

## How do I set custom fonts on my `Text` widgets?

In iOS, you would import any `ttf` font files into your project and create a
reference in the `info.plist` file. In Flutter you need to place the font file
in a folder and reference it in the `pubspec.yaml`, similar to how you import
images.

<!-- skip -->
{% prettify yaml %}
fonts:
   - family: MyCustomFont
     fonts:
       - asset: fonts/MyCustomFont.ttf
       - style: italic
{% endprettify %}

Then you would assign the font to your `Text` widget:

<!-- skip -->
{% prettify dart %}
@override
Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Sample App"),
    ),
    body: new Center(
      child: new Text(
        'This is a custom font text',
        style: new TextStyle(fontFamily: 'MyCustomFont'),
      ),
    ),
  );
}
{% endprettify %}

## How do I style my `Text` widgets?

Along with fonts, you can customize other styling elements on a `Text` widget.
The style parameter of a `Text` widget takes a `TextStyle` object, where you can
customize many parameters, such as:

- `color`
- `decoration`
- `decorationColor`
- `decorationStyle`
- `fontFamily`
- `fontSize`
- `fontStyle`
- `fontWeight`
- `hashCode`
- `height`
- `inherit`
- `letterSpacing`
- `textBaseline`
- `wordSpacing`

# Form Input

## What is the equivalent of a placeholder in a text field?

In Flutter you can easily show a "hint" or a placeholder text for your field by
adding an `InputDecoration` object to the decoration constructor parameter for
the `Text` widget:

<!-- skip -->
{% prettify dart %}
body: new Center(
  child: new TextField(
    decoration: new InputDecoration(hintText: "This is a hint"),
  ),
)
{% endprettify %}

## How do I show validation errors?

Just as you would with a "hint", you can pass in an `InputDecoration` object
to the decoration constructor for the `Text` widget.

However, you would not want to start off with showing an error and typically
would want to show it when the user has entered some invalid data. This can be
done by updating the state and passing in a new `InputDecoration` object.

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
  String _errorText;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new Center(
        child: new TextField(
          onSubmitted: (String text) {
            setState(() {
              if (!isEmail(text)) {
                _errorText = 'Error: This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
          decoration: new InputDecoration(hintText: "This is a hint", errorText: _getErrorText()),
        ),
      ),
    );
  }

  _getErrorText() {
    return _errorText;
  }

  bool isEmail(String em) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
{% endprettify %}
