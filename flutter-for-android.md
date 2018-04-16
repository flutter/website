---
layout: page
title: Flutter for Android Developers
permalink: /flutter-for-android/
---
This document is meant for Android developers looking to apply their
existing Android knowledge to build mobile apps with Flutter. If you understand
the fundamentals of the Android framework then you can use this document as a
jump start to Flutter development.

Your Android knowledge and skill set are highly valuable when building with
Flutter, because Flutter relies on the mobile operating system for numerous
capabilities and configurations. Flutter is a new way to build UIs for mobile,
but it has a plugin system to communicate with Android (and iOS) for non-UI
tasks. If you're an expert with Android, you don't have to relearn everything
to use Flutter.

This document can be used as a cookbook by jumping around and finding questions
that are most relevant to your needs.

* TOC Placeholder
{:toc}

# Views

## What is the equivalent of a `View` in Flutter?

In Android, the `View` is the foundation of everything that shows up on the
screen. Buttons, toolbars, and inputs, everything is a View. In Flutter
the equivalent of a view is `Widget`. Widgets, however, have a few differences
when compared with a view. To start, widgets only exist for one frame, and on
every new frame, Flutter's framework creates a new tree of widget instances. In
comparison, an Android view is drawn once and does not redraw until invalidate
is called.

Unlike Android’s view hierarchy system where the framework mutate views,
widgets in Flutter are immutable. This allows Flutter widgets to be very
lightweight.

## How do I update `Widget`s?

In Android you update your views by directly mutating them. However,
in Flutter `Widget`s are immutable and are not updated directly, instead
you have to work with the widget's state.

This is where the concept of Stateful vs Stateless widgets comes from. A
`StatelessWidget` is just what it sounds like, a widget with no state
information.

`StatelessWidgets` are useful when the part of the user interface
you are describing does not depend on anything other than the configuration
information in the object.

For example, in Android, this would be similar to just placing an `ImageView`
with your logo. The logo is not going to change during runtime and because
of that you would use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received
after making an HTTP call or user interaction then you have to work
with `StatefulWidget` and tell the Flutter framework that the widget’s `State`
has been updated so it can update that widget.

The important thing to note here is at the core both stateless and stateful
widgets behave the same. They rebuild every frame, the difference is the
`StatefulWidget` has a `State` object which stores state data across frames
and restores it.

If you are in doubt, then always remember this rule: if a widget changes (e.g.,
because of user interactions) it’s stateful. However, if a widget is reacting
to change, the containing parent widget can still be stateless if it doesn't
itself react to change.

Let's take a look at how you would use a `StatelessWidget`. A common
`StatelessWidget` is the `Text` widget. If you look at the implementation of the
`Text` widget you'll find it subclasses a `StatelessWidget`.

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

This can be achieved by wrapping the `Text` widget in a `StatefulWidget` and
updating it when the button is clicked.

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

## How do I layout my Widgets? Where is my XML layout file?

In Android, you write layouts via XML, but in Flutter you write your layouts
with a widget tree.

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
        child: new MaterialButton(
          onPressed: () {},
          child: new Text('Hello'),
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
        ),
      ),
    );
  }
{% endprettify %}

You can view all the layouts that Flutter has to offer in the
[widget catalog](https://flutter.io/widgets/layout/).

## How do I add or remove a component from my layout?

In Android, you would call `addChild()` or `removeChild()` on a parent to dynamically
add or remove child views. In Flutter, because widgets are immutable there is no direct
equivalent to `addChild()`. Instead, you can pass in a function that returns a widget
to the parent and control that child's creation via a boolean flag.

For example, here is how you can toggle between two widgets when you click on a
`FloatingActionButton`:

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
      return new MaterialButton(onPressed: () {}, child: new Text('Toggle Two'));
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

## In Android, I can animate a view by calling `animate()`; how do I animate a Widget?

In Android you would either create animations via XML or call the `animate()`
method on a view. In Flutter, animating widgets can be done via the animation
library by wrapping widgets inside an animated widget.

Similarly to Android's `Animator`s, in Flutter you have an `AnimationController`
which is an `Animation<double>` that can pause, seek, stop and reverse. It
requires a `Ticker` which signals when vsync happens, and produces a linear
interpolation between 0 and 1 on each frame while it's running.

You then create one or more `Animation`s and attach them to the controller; for
example, you could have a `CurvedAnimation` to have an animation which uses a
curve to interpolate another animation. In this sense, the controller is the
"master" source of the animation progress and the `CurvedAnimation` is tasked
to modify the controller's linear output to a curve. Like widgets, animations in
Flutter work with composition.

When building the widget tree you then assign the `Animation` to an animated
property of a widget, such as the opacity of a `FadeTransition`, and tell the
controller to start the animation.

Let's take a look at how to write a `FadeTransition` that will fade in a logo
when you press a `FloatingActionButton`:

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

See [https://flutter.io/widgets/animation/](https://flutter.io/widgets/animation/) and [https://flutter.io/tutorials/animation](https://flutter.io/tutorials/animation) for
more specific details.

## How do I use a `Canvas` to draw/paint?

In Android, you would use the `Canvas` and `Drawable`s to draw images and shapes
to the screen. Flutter has a very similar `Canvas` API as well, since it is based
on the same low-level rendering engine, Skia. As a result, painting to a canvas in
Flutter is a very familiar task for Android developers.

Flutter has two classes that help you draw to the canvas: `CustomPaint`
and `CustomPainter`, the latter of which implements your algorithm to draw to
the canvas.

In this [popular StackOverFlow answer](https://stackoverflow.com/questions/46241071/create-signature-area-for-mobile-app-in-dart-flutter)
you can see how to implement a signature painter in Flutter.

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';
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
class DemoApp extends StatelessWidget {
  Widget build(BuildContext context) => new Scaffold(body: new Signature());
}
void main() => runApp(new MaterialApp(home: new DemoApp()));
{% endprettify %}

## How do I build custom widgets?

In Android, you would typically subclass from `View` or a pre-existing
view to override and implement methods in order to obtain the desired behavior.

In Flutter building a custom widget is often accomplished by not extending but
composing smaller widgets. It is somewhat similar to implementing a custom
`ViewGroup` in Android, where all the building blocks are already existing, but
you provide a different behavior — for example, custom layout logic.

Let's take a look at how to build a `CustomButton` that takes in a label in the
constructor. This is achieved by composing it with `RaisedButton`, rather than
extending `RaisedButton` and overriding and implementing new methods:

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

# Intents

## What is the equivalent of an `Intent` in Flutter?

In Android, there are two main use cases for `Intent`s: navigating between
Activities, and communicating with components. Flutter on the other hand does
not have the concept of intents, although you can still start intents
through native integrations (via [a plugin](https://pub.dartlang.org/packages/android_intent)).

Flutter doesn't really have a direct equivalent to activities and fragments;
rather, in Flutter you navigate between screens, using a `Navigator` and
`Route`s, all within the same `Activity`.

A `Route` is an abstraction for a “screen” or “page” of an app, and a
`Navigator` is a widget that manages routes. A route roughly maps to an
`Activity`, but it does not carry the same meaning. A navigator can push
and pop routes to move from screen to screen. Navigators work like a stack
on which you can `push()` new routes you want to navigate to, and from
which you can `pop()` routes when you want to "go back".

Similarly to Android, where you declare your activities inside the app's
`AndroidManifest.xml`, in Flutter you can pass in a `Map` of named routes
to the top level `MaterialApp` instance to declare all your routes:

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

Then you can navigate to a route by getting an hold of the `Navigator` and
`push`ing one of the named routes.

<!-- skip -->
{% prettify dart %}
Navigator.of(context).pushNamed('/b');
{% endprettify %}

The other popular use-case for `Intent`s is to call external components such
as a Camera or File picker. For this, you would need to create a native platform
integration (or use an [existing plugin](https://pub.dartlang.org/flutter/)).

See [Flutter Plugins] to learn how to build a native platform integration.

## How do I handle incoming intents from external applications in Flutter?

Flutter can handle incoming intents from Android by directly talking to the
Android layer and requesting the data that was shared.

In this example we are registering a text share intent filter on the native
activity that runs our Flutter code, so other apps can share text to our
Flutter app.

The basic flow implies that we first handle the shared text data on the
Android native side (in our `Activity`), and then wait until Flutter requests
for the data to provide it via a `MethodChannel`.

First we register the intent filter for the intents that we want to handle in
our `AndroidManifest.xml`:

<!-- skip -->
{% prettify xml %}
<activity
  android:name=".MainActivity"
  android:launchMode="singleTop"
  android:theme="@style/LaunchTheme"
  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection"
  android:hardwareAccelerated="true"
  android:windowSoftInputMode="adjustResize">
  <!-- ... -->
  <intent-filter>
    <action android:name="android.intent.action.SEND" />
    <category android:name="android.intent.category.DEFAULT" />
    <data android:mimeType="text/plain" />
  </intent-filter>
</activity>
{% endprettify %}

Then in `MainActivity` you can handle the intent, extract the text that was
shared from the intent, and hold onto it. When Flutter is ready to process
the data it will request it via a platform channel, and we can then send it
across from the native side:

<!-- skip -->
{% prettify java %}
package com.yourcompany.shared;

import android.content.Intent;
import android.os.Bundle;

import java.nio.ByteBuffer;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.ActivityLifecycleListener;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private String sharedText;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Intent intent = getIntent();
    String action = intent.getAction();
    String type = intent.getType();

    if (Intent.ACTION_SEND.equals(action) && type != null) {
      if ("text/plain".equals(type)) {
        handleSendText(intent); // Handle text being sent
      }
    }

    new MethodChannel(getFlutterView(), "app.channel.shared.data")
      .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
          if (methodCall.method.contentEquals("getSharedText")) {
            result.success(sharedText);
            sharedText = null;
          }
        }
      });
  }

  void handleSendText(Intent intent) {
    sharedText = intent.getStringExtra(Intent.EXTRA_TEXT);
  }
}
{% endprettify %}

Lastly, you can request the data from the Flutter side when the widget is
rendered:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample Shared App Handler',
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
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared = "No data";

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Center(child: new Text(dataShared)));
  }

  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData;
      });
    }
  }
}
{% endprettify %}

## What is the equivalent of `startActivityForResult()`?

The `Navigator` class which handles all routing in Flutter can be used to get a
result back from a route that you have pushed on the stack. This can be done by
`await`ing on the `Future` returned by `push()`.

For example, if you were to start a location route which lets the user select
their location, you could do:

<!-- skip -->
{% prettify dart %}
Map coordinates = await Navigator.of(context).pushNamed('/location');
{% endprettify %}

And then, inside your location route, once the user has selected their location
you can `pop` the stack with the result:

<!-- skip -->
{% prettify dart %}
Navigator.of(context).pop({"lat":43.821757,"long":-79.226392});
{% endprettify %}

# Async UI

## What is the equivalent of `runOnUiThread()` in Flutter?

Dart has a single-threaded execution model, with support for `Isolate`s
(a way to run Dart code on another thread), an event loop, and
asynchronous programming. Unless you spawn an `Isolate`, your Dart code
runs in the main UI thread and is driven by an event loop. Flutter's event
loop is equivalent to Android's main `Looper` — that is, the `Looper` that
is attached to the main thread.

Dart's single-threaded model doesn't mean you need to run everything as a
blocking operation that will cause the UI to freeze. Unlike Android, which
requires you to keep the main thread free at all times, in Flutter you just
use the asynchronous facilities that the Dart language provides, such as
`async`/`await`, to perform asynchronous work. You may be familiar with
the `async`/`await` paradigm if you've used it in C#, Javascript, or if you
have used Kotlin's coroutines.

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

Once the `await`ed network call is done, you update the UI calling
`setState()`, which triggers a rebuild of the widget tree and updates the
data.

Next, here's an example of loading data asynchronously and displaying it 
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

Refer to the next section for more information on doing work in
background in Flutter and how it differs from Android.

## How do you move work to a background thread?

In Android, when you want to access a network resource you would typically
move to a background thread and do the work, as to not block the main thread,
and avoid ANRs. For example, you may be using an `AsyncTask`, a `LiveData`,
an `IntentService`, a `JobScheduler` job, or an RxJava pipeline with a
scheduler that works on background threads.

Since Flutter is single threaded and runs an event loop (like Node.js), you
don't have to worry about thread management or spawing background threads. If
you're doing I/O-bound work, such as a disk access or a network call, then
you can safely just use `async`/`await` and you're all set. If, on the other
hand, you need to do computationally intensive work that keeps the CPU busy,
you want to move it to an `Isolate` as to avoid blocking the event loop, like
you would want to keep _any_ sort of work out of the main thread in Android.

For I/O bound work, you can declare the function as an `async` function
and `await` on long running tasks in the function:

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

On Android, when you extend `AsyncTask`, you typically override 3 methods,
`onPreExecute()`, `doInBackground()` and `onPostExecute()`. There is no 
equivalent to this since you would just await on a long running function and
Dart's event loop will take care of the rest.

However, there are times where you may be processing a large amount of data and
your UI could hang. In this case, like on Android, in Flutter it is possible to
take advantage of multiple CPU cores to do long running or computationally
intensive tasks. This is done by using `Isolate`s.

Isolates are a separate execution thread that runs and do not share any memory
with the main execution memory heap. This means you can’t access variables from
the main thread or update your UI by calling `setState()`. Isolates are true to
their name; unlike on Android threads, isolates cannot share memory (e.g., in
the form of static fields).

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
JSON, or doing computationally intensive math such as crypto or signal processing.

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

## What is the equivalent of OkHttp on Flutter?

Making a network call in Flutter is easy when you use the popular [`http` package](https://pub.dartlang.org/packages/http).

While the http package does not have all the features OkHttp has implemented,
it abstracts away a lot of the networking that you would normally implement
yourself, making it a simple way to make network calls.

You can use it by adding it to your dependencies in `pubspec.yaml`:

<!-- skip -->
{% prettify yaml %}
dependencies:
  ...
  http: '>=0.11.3+16'
{% endprettify %}

Then to make a network call, you just `await` on the `async` function `http.get()`:

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

## How do I show the progress for a long-running task in Flutter?

In Android you would typically show a `ProgressBar` view in your UI while you
execute a long running task on a background thread.

In Flutter this can be done by using a `ProgressIndicator` widget. You can
show the progress UI programmatically by controlling when it's rendered
through a boolean flag, and telling Flutter to update its state before your
long running task starts, and hiding it after it ends.

In the example below, we break up the build function into three different
functions. If `showLoadingDialog()` is `true` (when `widgets.length == 0`)
then we render the `ProgressIndicator`, else we render the `ListView` with
the data.

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

## Where do I store my resolution dependent image files?

While Android has resources as a distinct notion from assets, Flutter apps have
only assets. All your resources which would be living in the `res/drawable-*`
folders on Android should be instead put in an assets folder.

Flutter follows a simple density-based format like iOS. Assets can be `1.0x`,
`2.0x`, `3.0x`, or any other multiplier. Flutter doesn't have `dp`s but there
are logical pixels, which are basically the same as device-independent pixels.
The so-called [`devicePixelRatio`](https://docs.flutter.io/flutter/dart-ui/Window/devicePixelRatio.html)
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

Assets on Flutter can be located in any arbitrary folder; there is no predefined
folder structure. You then declare where the assets are located in the pubspec
file, and Flutter will pick them up.

Note that before Flutter beta 2, assets
defined in Flutter are not accessible from the native side, and vice versa,
native assets and resources aren't available from Flutter as they live in
separate folders.

Starting from Flutter beta 2, Flutter assets are stored in
the native asset folder, and can be accessed on the native side via the Android
`AssetManager`:

<!-- skip -->
{% prettify kotlin %}
val flutterAssetStream = assetManager.open("flutter_assets/assets/my_flutter_asset.png")
{% endprettify %}

As of Flutter beta 2, Flutter still cannot access native resources, nor it can
access native assets

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

## Where do I store strings? How do I handle localization?

Flutter currently doesn't have a dedicated resources-like system for strings.
At the moment, the best practice is to hold your copy text in a class as
static fields and accessing them from there. For example:

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

Flutter has basic support for accessibility on Android, though this feature is
a work in progress.

Flutter developers are encouraged to use the [intl
package](https://pub.dartlang.org/packages/intl) for internationalization and
localization.

## What is the equivalent of a Gradle file? How do I add dependencies?

In Android, you add dependencies by adding to your Gradle build script. Flutter
uses Dart's own build system, and the Pub package manager, delegating then the
building of the native Android and iOS wrapper apps to the respective build
systems.

While there are Gradle files under the `android` folder in your Flutter project,
you would only use these if you were adding native dependencies needed for
per-platform integration. In general, you can use `pubspec.yaml` to declare
external dependencies to use in Flutter.

A good place to find great packages for flutter is [Pub](https://pub.dartlang.org/flutter/packages/).

# Activities and Fragments

## What are the equivalent of activities and fragments in Flutter?

In Android, an `Activity` represents a single focused thing the user can do. A
`Fragment` represents a behavior or a portion of user interface. Fragments
are a way to modularize your code, compose sophisticated user interfaces for
larger screens, and help scale your application UI. In Flutter both of these
concepts fall under the umbrella of `Widget`s.

As mentioned in the [Intents](#what-is-the-equivalent-of-an-intent-in-flutter)
section, screens in Flutter are represented by `Widget`s since everything is
a widget in Flutter. You use a `Navigator` to move between different `Route`s
which represent different screens or pages, or maybe just different states or
renderings of the same data.

## How do I listen to Android activity lifecycle events?

In Android, you can override methods from the `Activity` to capture lifecycle
methods for the activity itself, or register `ActivityLifecycleCallbacks` on
the `Application`. In Flutter you have neither concept, but you can instead
listen to lifecycle events by hooking into the `WidgetsBinding` observer and
listening to the `didChangeAppLifecycleState()` change event.

The lifecycle events you can observe are:

* `inactive` — The application is in an inactive state and is not receiving user
  input. This event only works on iOS, as there is no equivalent event to map to
  on Android
* `paused` — The application is not currently visible to the user, not responding
  to user input, and running in the background. This is equivalent to `onPause()`
  in Android
* `resumed` — The application is visible and responding to user input. This is
  equivalent to `onPostResume()` in Android
* `suspending` — The application will be suspended momentarily. This is equivalent
  to `onStop` in Android; it is not triggered on iOS as there is no equivalent
  event to map to on iOS

For more details on the meaning of these states, you can check the
[`AppLifecycleStatus` documentation](https://docs.flutter.io/flutter/dart-ui/AppLifecycleState-class.html).

As you might have noticed, only a small minority of the Activity lifecycle events
are available; while `FlutterActivity` does capture almost all the activity lifecycle
events internally and send them over to the Flutter engine, they're mostly shielded
away from you. Flutter takes care of starting and stopping the engine for you, and
there is little reason for needing to observe the activity lifecycle on the Flutter
side in most cases. If you need to observe the lifecycle to acquire or release any
native resources, you should likely be doing it from the native side, at any rate.

Here's an example of how to observe the lifecycle status of the containing activity:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/widgets.dart';

class LifecycleWatcher extends StatefulWidget {
  @override
  _LifecycleWatcherState createState() => new _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver {
  AppLifecycleState _lastLifecyleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecyleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_lastLifecyleState == null)
      return new Text('This widget has not observed any lifecycle changes.', textDirection: TextDirection.ltr);

    return new Text('The most recent lifecycle state this widget observed was: $_lastLifecyleState.',
        textDirection: TextDirection.ltr);
  }
}

void main() {
  runApp(new Center(child: new LifecycleWatcher()));
}
{% endprettify %}

# Layouts

## What is the equivalent of a LinearLayout

In Android, a LinearLayout is used to lay your widgets out linearly
-horizontally or vertically. In Flutter, you can use the Row widget or Column
widget to achieve the same result.

If you notice the two code samples are identical with the exception of the
"Row" and "Column" widget. The children are the same and this feature can be
exploited to develop rich layouts that can change overtime with the same
children.

<!-- skip -->
{% prettify dart %}
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text('Row One'),
        new Text('Row Two'),
        new Text('Row Three'),
        new Text('Row Four'),
      ],
    );
  }
{% endprettify %}

<!-- skip -->
{% prettify dart %}
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text('Column One'),
        new Text('Column Two'),
        new Text('Column Three'),
        new Text('Column Four'),
      ],
    );
  }
{% endprettify %}

## What is the equivalent of a RelativeLayout

A RelativeLayout is used to lay your widgets out relative to each other. In
Flutter there are a few ways to achieve the same result.

You can achieve the result of a RelativeLayout by using a combination of
Column, Row, and Stack widgets. You can specify rules for the widgets
constructors on how the children are laid out relative to the parent.

A good example of building a RelativeLayout in Flutter is on StackOverflow
[https://stackoverflow.com/questions/44396075/equivalent-of-relativelayout-in
-flutter](https://stackoverflow.com/questions/44396075/equivalent-of-relativelayout-in-flutter)

## What is the equivalent of a ScrollView

In Android a ScrollView lets you lay your widgets such that if the users'
device has a smaller screen than your content, they can scroll.

In Flutter the easiest way to do this is using the ListView widget. This might
seem like overkill coming from Android, but in Flutter a ListView widget is
both a ScrollView and an Android ListView.

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

# Gesture Detection and Touch Event Handling

## How do I add an onClick listener to a widget in Flutter

In Android, you can attach onClick to views such as button by calling
the method 'setOnClickListener'.

In Flutter there are two ways of adding touch listeners

1. If the Widget has support for event detection you can just pass in a
  function to it and handle it. For example, the RaisedButton has an onPressed
  parameter

   <!-- skip -->
  {% prettify dart %}
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
        onPressed: () {
          print("click");
        },
        child: new Text("Button"));
  }
   {% endprettify %}

2. If the Widget does not have support for event detection, you can wrap up the
  widget in a GestureDetector and pass in a function to the onTap parameter.

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
    ));
  }
}
   {% endprettify %}

## How do I handle other gestures on widgets

Using the GestureDetector we can listen to a wide range of Gestures such as

- Tap

  - `onTapDown` A pointer that might cause a tap has contacted the screen at a
    particular location.
  - `onTapUp` A pointer that will trigger a tap has stopped contacting the
    screen at a particular location.
  - `onTap` A tap has occurred.
  - `onTapCancel` The pointer that previously triggered the `onTapDown` will
    not end up causing a tap.

- Double tap

  - `onDoubleTap` The user has tapped the screen at the same location twice in
    quick succession.

- Long press

  - `onLongPress` A pointer has remained in contact with the screen at the same
    location for a long period of time.

- Vertical drag

  - `onVerticalDragStart` A pointer has contacted the screen and might begin to
    move vertically.
  - `onVerticalDragUpdate` A pointer that is in contact with the screen and
    moving vertically has moved in the vertical direction.
  - `onVerticalDragEnd` A pointer that was previously in contact with the
    screen and moving vertically is no longer in contact with the screen and was
    moving at a specific velocity when it stopped contacting the screen.

- Horizontal drag

  - `onHorizontalDragStart` A pointer has contacted the screen and might begin
    to move horizontally.
  - `onHorizontalDragUpdate` A pointer that is in contact with the screen and
    moving horizontally has moved in the horizontal direction.
  - `onHorizontalDragEnd` A pointer that was previously in contact with the
    screen and moving horizontally is no longer in contact with the screen and was
    moving at a specific velocity when it stopped contacting the screen.



For example here is a GestureDetector for double tap on the FlutterLogo that
will make it rotate

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
    ));
  }
}
{% endprettify %}

# Listviews & Adapters

## What is the alternative to a ListView in Flutter

The equivalent to a ListView in Flutter is … a ListView!

In an Android ListView, you create an adapter that you can then pass into the
ListView which will render each row with what your adapter returns. However you
have to make sure you recycle your rows , otherwise, you get all sorts of crazy
visual glitches and memory issues.

In Flutter, due to Flutters immutable widget pattern, you pass in a List of
Widgets to your ListView and Flutter will take care of making sure they are
scrolling fast and smooth.

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

## How do I know which list item is clicked on

In Android, the ListView has a method to find out which item was clicked
'onItemClickListener'. Flutter makes it easier by letting you just use the
touch handling that the widgets you passed in have.

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
            child: new Text("Row $i")),
        onTap: () {
          print('row tapped');
        },
      ));
    }
    return widgets;
  }
}
{% endprettify %}

## How do I update ListView's dynamically

On Android, you would update the adapter and call notifyDataSetChanged. In
Flutter if you were to update the list of widgets inside a setState(), you
would quickly see that your data did not change visually.

This is because when setState is called, the Flutter rendering engine will go
through all the widgets to see if they have changed. When it gets to your
ListView it will do a `==operator` and see that the two ListViews are the same
and nothing has changed, hence no update to the data.

To update your ListView then is to create a new List() inside of setState and
copy over all the old data to the new list. This is a simple way to achieve an
update.

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
          child: new Text("Row $i")),
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
ListView.Builder. This method is great when you have a dynamic
List or a List with very large amounts of data. This is essentially
the equivalent of using RecyclerView on Android which automatically
recycles list elements for you:

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
            }));
  }

  Widget getRow(int i) {
    return new GestureDetector(
      child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Text("Row $i")),
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

Instead of creating a "new ListView" we create a new ListView.builder which
takes two key parameters, the initial length of the list and an ItemBuilder
function.

The ItemBuilder function is a lot like the getView function in an Android
adapter, it takes in a position and you return the row you want rendered for
that position.

Lastly, but most important, if you notice the onTap function, we don't recreate
the List anymore and instead just .add to it.



# Working with Text

## How do I set custom fonts on my Text widgets

In Android SDK (as of Android O), you would create a Font resource file and
pass it into the FontFamily param for your TextView.

In Flutter first you need to take your font file and place in folder in your
project (best practice is to create a folder called assets).

Next in your pubspec.yaml file you would declare the fonts

<!-- skip -->
{% prettify yaml %}
fonts:
   - family: MyCustomFont
     fonts:
       - asset: fonts/MyCustomFont.ttf
       - style: italic
           {% endprettify %}

and lastly you would assign the font to your Text widget

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

## How do I style my Text widgets

Along with customizing fonts you can customize a lot of different styles on a
Text widget.

The style parameter of a Text widget takes a TextStyle object, where you can
customize many parameters such as

- color
- decoration
- decorationColor
- decorationStyle
- fontFamily
- fontSize
- fontStyle
- fontWeight
- hashCode
- height
- inherit
- letterSpacing
- textBaseline
- wordSpacing

# Form Input

## What is the equivalent of a "hint" on an Input

In Flutter you can easily show a "hint" or a placeholder text for your input by
adding an InputDecoration object to the decoration constructor parameter for
the Text Widget

<!-- skip -->
{% prettify dart %}
body: new Center(
  child: new TextField(
    decoration: new InputDecoration(hintText: "This is a hint"),
  )
)
{% endprettify %}

## How do I show validation errors

Just like how you would with a "hint", you can pass in a InputDecoration object
to the decoration constructor for the Text widget.

However, you would not want to start off with showing an error and typically
would want to show it when the user has entered some invalid data. This can be
done by updating the state and passing in a new InputDecoration object.

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


# Flutter Plugins

## How do I access the GPS sensor

To access the GPS sensor you can use the community plugin
[https://pub.dartlang.org/packages/location](https://pub.dartlang.org/packages/location)

## How do I access the Camera

A popular community plugin to access the camera is
[https://pub.dartlang.org/packages/image_picker](https://pub.dartlang.org/packages/image_picker)

## How do I log in with Facebook

To Login with Facebook you can use
[https://pub.dartlang.org/packages/flutter_facebook_login](https://pub.dartlang.org/packages/flutter_facebook_login) .

## How do I build my own custom native integrations

If there is platform specific functionality that Flutter or its community
Plugins are missing then you can build your own following this tutorial
[https://flutter.io/developing-packages/](https://flutter.io/developing-packages/) .

Flutter's plugin architecture in a nutshell is a lot like using an Event bus in
Android: you fire off a message and let the receiver process and emit a result
back to you, in this case the receiver would be iOS or Android.

## How do I use the NDK in my Flutter application

If you use the NDK in your current Android application and want your Flutter
application to take advantage of your native libraries then it's possible by
building a custom plugin.

Your custom plugin would first talk to your Android app, where you would be
able to call your `native` marked functions. Once a response is ready, you
would be able to send a message back to Flutter and render the result.

# Themes

## How do I theme my Material-styled app

Flutter out of the box comes with a beautiful implementation of Material
Design, which takes care of a lot of styling and theming needs that you would
typically do. Unlike Android where you declare themes in XML and then assign it
to your application via AndroidManifest.xml, in Flutter you can declare themes
via the top level widget.

To take full advantage of Material Components in your app, you can declare a top
level widget `MaterialApp` as the entry point to your application. MaterialApp
is a convenience widget that wraps a number of widgets that are commonly
required for applications implementing Material Design. It builds upon a WidgetsApp by
adding Material specific functionality.

If you don't want to use Material Components, then you can declare a top level
widget `WidgetsApp` which is a convenience class that wraps a number of widgets
that are commonly required for an application

To customize the colors and styles of Material Components you can pass in a
ThemeData object to the MaterialApp widget, for example in the code below you
can see the primary swatch is set to blue and all text selection color should
be red.

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


# Databases and local storage

## How do I access Shared Preferences in Flutter?
In Android, you can store a small collection of key-value pairs by using
the SharedPreferences API.

In Flutter, you can access this functionality by using the
Shared Preferences plugin [Shared_Preferences](https://pub.dartlang.org/packages/shared_preferences)

This plugin wraps the functionality of both Shared Preferences and 
NSUserDefaults (the iOS equivalent).

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new RaisedButton(
            onPressed: _incrementCounter,
            child: new Text('Increment Counter'),
          ),
        ),
      ),
    ),
  );
}

_incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $counter times.');
  prefs.setInt('counter', counter);
}

{% endprettify %}

## How do I access SQLite in Flutter?
In Android, you would use SQLite to store structured data that you can query 
via SQL.

In Flutter, you can access this functionality by using the SQFlite plugin 
[SQFlite](https://pub.dartlang.org/packages/sqflite)

# Notifications

## How do I setup Push Notifications 
In Android, you would use Firebase Cloud Messaging to setup push 
notifications for your app.

In Flutter, you can access this functionality by using the Firebase_Messaging
plugin [Firebase_Messaging](https://github.com/flutter/plugins/tree/master/packages/firebase_messaging)
