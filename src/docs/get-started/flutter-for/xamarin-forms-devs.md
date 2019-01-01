---
title: Flutter for Xamarin.Forms developers
description: Learn how to apply Xamarin.Forms developer knowledge when building Flutter apps.
---

This document is meant for Xamarin.Forms developers looking to apply their
existing knowledge to build mobile apps with Flutter. If you understand
the fundamentals of the Xamarin.Forms framework then you can use this
document as a jump start to Flutter development.

Your Android and iOS knowledge and skill set are valuable when building with
Flutter, because Flutter relies on the native operating system configurations,
similar to how you would configure your native Xamarin.Forms projects.
The Flutter Frameworks is also similar to how you create a single UI,
that is used on multiple platforms.

This document can be used as a cookbook by jumping around and finding questions
that are most relevant to your needs.

## Project Setup

### How does the app start?

For each platform in Xamarin.Forms, you call the `LoadApplication` method,
which creates a new Application and starts your app.

<!-- skip -->
{% prettify csharp %}
LoadApplication(new App());
{% endprettify %}

In Flutter, the default main entry point is `main` where you load your
Flutter app.

{% prettify dart %}
void main() {
  runApp(new MyApp());
}
{% endprettify %}

In Xamarin.Forms, you assign a `Page` to the `MainPage` property in the
`Application` class.

<!-- skip -->
{% prettify csharp %}
public class App: Application
{
    public App()
    {
      MainPage = new ContentPage()
                 {
                   new Label()
                   {
                     Text="Hello World",
                     HorizontalOptions = LayoutOptions.Center,
                     VerticalOptions = LayoutOptions.Center
                   }
                 };
    }
}
{% endprettify %}

In Flutter, "everything is a widget", even the application itself.
The following example shows `MyApp`, a simple application `Widget`.

{% prettify dart %}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: Text("Hello World!", textDirection: TextDirection.ltr));
  }
}
{% endprettify %}

### How do you create a Page?

Xamarin.Forms has many different types of pages; `ContentPage` is the most
common.

In Flutter, you specify an application widget that holds your root page.
You can use a
[MaterialApp](https://docs.flutter.io/flutter/material/MaterialApp-class.html)
widget, which supports [Material
Design](https://material.io/design/), or you can use the lower level
[WidgetsApp](https://docs.flutter.io/flutter/widgets/WidgetsApp-class.html),
which you can customize in any way you want.

The following code defines the home page, a stateful widget. In Flutter,
all widgets are immutable, but two types of widgets are supported:
stateful and stateless. Examples of a stateless widget are titles,
icons, or images.

The following example uses MaterialApp, which holds its root page in the
`home` property.

{% prettify dart %}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      [[highlight]]home: new MyHomePage(title: 'Flutter Demo Home Page'),[[/highlight]]
    );
  }
}
{% endprettify %}

From here, your actual first page is another `Widget`, in which you create your state.

A stateful widget, such as MyHomePage below, consists of two parts.
The first part, which is itself immutable, creates a State object
that holds the state of the object. The State object persists over
the life of the widget.

{% prettify dart %}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
{% endprettify %}

The `state` object implements the `build` method for the stateful widget.

When the state of the widget tree changes, call `setState()`, which triggers
a build of that portion of the UI.  Make sure to call `setState()` only
when necessary, and only on the part of the widget tree that has changed, or
it can result in poor UI performance.

{% prettify dart %}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
{% endprettify %}

The UI, also known as widget tree, in Flutter is immutable, meaning you
can not change its state once it is built. You change fields in your
`State` class, then call `setState` to rebuild the entire widget tree again.

This way of generating UI is different than Xamarin.Forms, but there are
many benefits to this approach.

## Views

### What is the equivalent of a `Page` or `Element` in Flutter?

{{site.alert.secondary}}
How is react-style, or _declarative_, programming different than the
traditional imperative style?
For a comparison, see [Introduction to declarative
UI](/docs/get-started/flutter-for/declarative).
{{site.alert.end}}

A `ContentPage`, `TabbedPage`, `MasterDetailPage` are all types of pages you
could use in a Xamarin.Forms application. These pages would then hold
`Element`s to display the various controls. In Xamarin.Forms an `Entry`
or `Button` are examples of an `Element`.

In Flutter, almost everything is a widget. A `Page`, called a `Route` in
Flutter, is a widget.  Buttons, progress bars, animation controllers are all
widgets. When building a route, you create a widget tree.

Flutter includes the [Material Components](/docs/development/ui/widgets/material)
library. These are widgets that implement the
[Material Design guidelines](https://material.io/design/). Material Design is a
flexible design system [optimized for all
platforms](https://material.io/design/platform-guidance/cross-platform-adaptation.html#cross-platform-guidelines),
including iOS.

But Flutter is flexible and expressive enough to implement any design language.
For example, on iOS, you can use the [Cupertino
widgets](/docs/development/ui/widgets/cupertino)
to produce an interface that looks like
[Apple's iOS design language](https://developer.apple.com/design/resources/).

### How do I update `Widget`s?

In Xamarin.Forms, each `Page` or `Element` is a stateful class, that has
properties and methods. You update your `Element` by updating a property, and this is propagated down to the native control.

In Flutter, `Widget`s are immutable and you can not directly update them
by changing a property, instead you have to work with the widget's state.

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

### How do I lay out my widgets? What is the equivalent of a XAML file?

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
catalog](/docs/development/ui/widgets/layout).

### How do I add or remove an Element from my layout?

In Xamarin.Forms, if you had to remove or add an `Element`, you had to do so in
code. This would involve either setting the `Content` property or calling
`Add()` or `Remove()` if it was a list.

In Flutter, because widgets are immutable there is no direct equivalent.
Instead, you can pass a function to the parent that returns a widget, and
control that child's creation with a boolean flag.

The following example shows how to toggle between two widgets when the user
clicks the `FloatingActionButton`:

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

### How do I animate a widget?

In Xamarin.Forms, you create simple animations using ViewExtensions that include
methods such as `FadeTo` and `TranslateTo`. You would use these methods on a view
to perform the required animations.

<!-- skip -->
{% prettify xml %}
<Image Source="{Binding MyImage}" x:Name="myImage" />
{% endprettify %}

Then in code behind, or a behavior, this would fade in the image, over a 1 second period.

<!-- skip -->
{% prettify csharp %}
myImage.FadeTo(0, 1000);
{% endprettify %}

In Flutter, you animate widgets using the animation library by wrapping widgets
inside an animated widget. Use an `AnimationController` which is an `Animation<double>`
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
[Animation & Motion widgets](/docs/development/ui/widgets/animation),
the [Animations tutorial](/docs/development/ui/animations/tutorial),
and the [Animations overview](/docs/development/ui/animations).

### How do I draw/paint on the screen?

Xamarin.Forms never had any built in way to draw directly on the screen.
Many would use SkiaSharp, if they needed a custom image drawn. In Flutter,
you have direct access to the Skia Canvas and can easily draw on screen.

Flutter has two classes that help you draw to the canvas: `CustomPaint`
and `CustomPainter`, the latter of which implements your algorithm to draw to
the canvas.

To learn how to implement a signature painter in Flutter, see Collin's answer on
[StackOverflow][].

[StackOverflow]: https://stackoverflow.com/questions/46241071/create-signature-area-for-mobile-app-in-dart-flutter

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

### Where is the widget's opacity?

On Xamarin.Forms, all `VisualElement`s have an Opacity. In Flutter, you need to
wrap a widget in an [Opacity widget](https://docs.flutter.io/flutter/widgets/Opacity-class.html)
to accomplish this.

### How do I build custom widgets?

In Xamarin.Forms, you typically subclass `VisualElement`, or use a pre-existing
`VisualElement`, to override and implement methods that achieve the desired behavior.

In Flutter, build a custom widget by
[composing](/docs/resources/technical-overview#everythings-a-widget) smaller widgets
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

## Navigation

### How do I navigate between pages?

In Xamarin.Forms, you navigate between pages normally through a, you can use a
`NavigationPage` that manages the stack of pages to display.

Flutter has a similar implementation, using a `Navigator` and
`Routes`. A `Route` is an abstraction for a `Page` of an app, and
a `Navigator` is a [widget](/docs/resources/technical-overview#everythings-a-widget)
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

The Navigator is a stack that manages your app's routes. Pushing a route to the stack
moves to that route. Popping a route from the stack, returns to the previous route. This
is done by `await`ing on the `Future` returned by `push()`.

`Async`/`await` is very similar to the .NET implementation and is explained in more detail
in [Async UI](#async-ui).

For example, to start a `location` route that lets the user select their
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

### How do I navigate to another app?

In Xamarin.Forms, to send the user to another application, you use a
specific URI scheme, using `Device.OpenUrl("mailto://")`

To implement this functionality in Flutter, create a native platform integration,
or use an [existing plugin](https://pub.dartlang.org/flutter/), such as
[`url_launcher`](https://pub.dartlang.org/packages/url_launcher), available with
many other packages on the [Package site](https://pub.dartlang.org/flutter).

## Async UI

### What is the equivalent of `Device.BeginOnMainThread()` in Flutter?

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

### How do you move work to a background thread?

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
with the main execution memory heap. This is a difference between `Task.Run()`. This
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

### How do I make network requests?

In Xamarin.Forms you would use `HttpClient`. Making a network call in Flutter
is easy when you use the popular
[`http` package](https://pub.dartlang.org/packages/http).
This abstracts away a lot of the networking that you might normally implement yourself,
making it simple to make network calls.

To use the `http` package, add it to your dependencies in `pubspec.yaml`:

<!-- skip -->
{% prettify yaml %}
dependencies:
  ...
  http: ^0.11.3+16
{% endprettify %}

To make a network request, call `await` on the `async` function `http.get()`:

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

### How do I show the progress for a long-running task?

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

## Project structure & resources

### Where do I store my image files?

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
[Adding Assets and Images in Flutter](/docs/development/ui/assets-and-images).

### Where do I store strings? How do I handle localization?

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
[internationalization guide](/docs/development/accessibility-and-localization/internationalization),
which has sample code with and without the `intl` package.

### Where is my project file?

In Xamarin.Forms you will have a `csproj` file. The closest equivalent in Flutter is pubspec.yaml,
which contains package dependencies and various project details. Similar to .NET Standard,
files within the same directory are considered part of the project.

### What is the equivalent of Nuget? How do I add dependencies?

In the .NET eco-system, native Xamarin projects and Xamarin.Forms projects had access
to Nuget and the inbuilt package management system. Flutter apps contain a native
Android app, native iOS app and Flutter app.

In Android, you add dependencies by adding to your Gradle build script. In iOS, you add
dependencies by adding to your `Podfile`.

Flutter uses Dart's own build system, and the Pub package manager.
The tools delegate the building of the native Android and iOS wrapper apps to the
respective build systems.

In general, use `pubspec.yaml` to declare external dependencies to use in Flutter. A good
place to find Flutter packages is [Pub](https://pub.dartlang.org/flutter).

## Application Lifecycle

### How do I listen to application lifecycle events?

In Xamarin.Forms, you have an `Application` that contains `OnStart`, `OnResume` and
`OnSleep`. In Flutter you can instead listen to similar lifecycle events by hooking into
the `WidgetsBinding` observer and listening to the `didChangeAppLifecycleState()` change event.

The observable lifecycle events are:

* `inactive` — The application is in an inactive state and is not receiving
user input. This event is iOS only.
* `paused` — The application is not currently visible to
the user, is not responding to user input, but is running in the background.
* `resumed` — The application is visible and responding to user input.
* `suspending` — The application is suspended momentarily. This event is Android
only.

For more details on the meaning of these states, see [`AppLifecycleStatus`
documentation][].

[`AppLifecycleStatus` documentation]: https://docs.flutter.io/flutter/dart-ui/AppLifecycleState-class.html

## Layouts

### What is the equivalent of a StackLayout?

In Xamarin.Forms you can create a `StackLayout` with an `Orientation` of Horizontal or Vertical.
Flutter has a similar approach, however you would use the `Row` or `Column` widgets.

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

### What is the equivalent of a Grid?

The closest equivalent of a `Grid` would be to use a `GridView`. This is much more powerful
than what you are used to in Xamarin.Forms. A `GridView` provides automatic scrolling when the
content exceeds the its viewable space.

<!-- skip -->
{% prettify dart %}
  GridView.count(
    // Create a grid with 2 columns. If you change the scrollDirection to
    // horizontal, this would produce 2 rows.
    crossAxisCount: 2,
    // Generate 100 Widgets that display their index in the List
    children: List.generate(100, (index) {
      return Center(
        child: Text(
          'Item $index',
          style: Theme.of(context).textTheme.headline,
        ),
      );
    }),
  );
{% endprettify %}

You may have used a `Grid` in Xamarin.Forms to implement widgets that overlay other widgets.
In Flutter, you accomplish this with the `Stack` widget.

This sample creates two icons that overlap each other.

<!-- skip -->
{% prettify dart %}
  child: new Stack(
    children: <Widget>[
      new Icon(Icons.add_box, size: 24.0, color: const Color.fromRGBO(0,0,0,1.0)),
      new Positioned(
        left: 10.0,
        child: new Icon(Icons.add_circle, size: 24.0, color: const Color.fromRGBO(0,0,0,1.0)),
      ),
    ],
  ),
{% endprettify %}

### What is the equivalent of a ScrollView?

In Xamarin.Forms, a `ScrollView` wraps around a `VisualElement` and, if the content is larger than
the device screen, it scrolls.

In Flutter, the closest match is the `SingleChildScrollView` widget. You simply fill the
Widget with the content that you want to be scrollable.

<!-- skip -->
{% prettify dart %}
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Text('Long Content'),
    );
  }
{% endprettify %}

If you have many items you want to wrap in a scroll, even of different `Widget` types, you might want
to use a `ListView`. This might seem like overkill, but in Flutter this is far more optimized
and less intensive than a Xamarin.Forms `ListView` which is backing on to platform specific controls.

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

### How do I handle landscape transitions in Flutter?

Landscape transitions can be handled automatically by setting the `configChanges`
property in the AndroidManifest.xml:

{% prettify yaml %}
android:configChanges="orientation|screenSize"
{% endprettify %}

## Gesture detection and touch event handling

### How do I add GestureRecognizers to a widget in Flutter?

In Xamarin.Forms, `Element`s may contain a Click event you can attach to. Many elements
also contain a `Command` that is tied to this event. Alternatively you would use the
`TapGestureRecognizer`. In Flutter there are two very similar ways:

 1. If the Widget supports event detection, pass a function to it and handle it
    in the function. For example, the RaisedButton has an `onPressed` parameter:

    <!-- skip -->
    ```dart
    @override
    Widget build(BuildContext context) {
      return new RaisedButton(
          onPressed: () {
            print("click");
          },
          child: new Text("Button"));
    }
    ```

 2. If the Widget doesn't support event detection, wrap the
    widget in a GestureDetector and pass a function to the `onTap` parameter.

    <!-- skip -->
    ```dart
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
    ```

### How do I handle other gestures on widgets?

In Xamarin.Forms you would add a `GestureRecognizer` to the `VisualElement`. You
would normally be limited to `TapGestureRecognizer`, `PinchGestureRecognizer` and
`PanGestureRecognizer`, unless you built your own.

In Flutter, using the GestureDetector, you can listen to a wide range of Gestures such as:

* Tap

  * `onTapDown` - A pointer that might cause a tap has contacted the screen at a
     particular location.
  * `onTapUp` - A pointer that triggers a tap has stopped contacting the
     screen at a particular location.
  * `onTap` - A tap has occurred.
  * `onTapCancel` - The pointer that previously triggered the `onTapDown` won't
     cause a tap.

* Double tap

  * `onDoubleTap` - The user tapped the screen at the same location twice in
     quick succession.

* Long press

  * `onLongPress` - A pointer has remained in contact with the screen at the same
    location for a long period of time.

* Vertical drag

  * `onVerticalDragStart` - A pointer has contacted the screen and might begin to
    move vertically.
  * `onVerticalDragUpdate` - A pointer in contact with the screen
    has moved further in the vertical direction.
  * `onVerticalDragEnd` - A pointer that was previously in contact with the
    screen and moving vertically is no longer in contact with the screen and was
    moving at a specific velocity when it stopped contacting the screen.

* Horizontal drag

  * `onHorizontalDragStart` - A pointer has contacted the screen and might begin
    to move horizontally.
  * `onHorizontalDragUpdate` - A pointer in contact with the screen
    has moved further in the horizontal direction.
  * `onHorizontalDragEnd` - A pointer that was previously in contact with the
    screen and moving horizontally is no longer in contact with the screen and was
    moving at a specific velocity when it stopped contacting the screen.

The following example shows a `GestureDetector` that rotates the Flutter logo
on a double tap:

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

## Listviews & adapters

### What is the alternative to a ListView in Flutter?

The equivalent to a `ListView` in Flutter is … a `ListView`!

In a Xamarin.Forms `ListView`, you create a `ViewCell` and possibly a `DataTemplateSelector`
and pass it into the `ListView`, which renders each row with what your `DataTemplateSelector`
or `ViewCell` returns. However, you often have have to make sure you turn on Cell Recycling
otherwise you will run into memory issues and slow scrolling speeds.

Due to Flutter's immutable widget pattern, you pass a List of
Widgets to your `ListView`, and Flutter takes care of making sure
that scrolling is fast and smooth.

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

### How do I know which list item is clicked on?

In Xamarin.Forms, the ListView has a method to find out which item was clicked
`ItemTapped`. There are many other techniques you may have used such as checking
when `SelectedItem` or adding an `EventToCommand` behavior changes.

In Flutter, use the touch handling provided by the passed-in widgets.

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

### How do I update ListView's dynamically?

In Xamarin.Forms, if you bound the `ItemsSource` property to an `ObservableCollection`
you would just update the list in your ViewModel. Alternative you could assign
a new `List` to property `ItemsSource` is bound to to change all items.

In Flutter, things work a little differently. if you were to update the list of widgets
inside a `setState()`, you would quickly see that your data did not change visually.
This is because when `setState()` is called, the Flutter rendering engine
looks at the widget tree to see if anything has changed. When it gets to your
`ListView`, it performs a `==` check, and determines that the two `ListView`s are the
same. Nothing has changed, so no update is required.

For a simple way to update your `ListView`, create a new `List` inside of
`setState()`, and copy the data from the old list to the new list.
While this approach is simple, it is not recommended for large data sets,
as shown in the next example.

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

The recommended, efficient, and effective way to build a list uses a
ListView.Builder. This method is great when you have a dynamic
List or a List with very large amounts of data. This is essentially
the equivalent of RecyclerView on Android, which automatically
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

Instead of creating a "ListView", create a ListView.builder that
takes two key parameters: the initial length of the list, and an ItemBuilder
function.

The ItemBuilder function is similar to the `getView` function in an Android
adapter; it takes a position, and returns the row you want rendered at
that position.

Finally, but most importantly, notice that the `onTap()` function
doesn't recreate the list anymore, but instead `.add`s to it.

For more information, please visit
[Write your first Flutter app,
part 1](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1)
and [Write your first Flutter app,
part 2](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2)

## Working with text

### How do I set custom fonts on my Text widgets?

In Xamarin.Forms, you would have to add a custom font in each native project. Then
in your `Element` you would assign this font name to the `FontFamily` attribute
using `filename#fontname` and just `fontname` for iOS.

In Flutter, place the font file in a folder and reference it in the
`pubspec.yaml` file, similar to how you import images.

<!-- skip -->
{% prettify yaml %}
fonts:
   - family: MyCustomFont
     fonts:
       - asset: fonts/MyCustomFont.ttf
       - style: italic
{% endprettify %}

Then assign the font to your `Text` widget:

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

### How do I style my Text widgets?

Along with fonts, you can customize other styling elements on a `Text` widget.
The style parameter of a `Text` widget takes a `TextStyle` object, where you can
customize many parameters, such as:

* `color`
* `decoration`
* `decorationColor`
* `decorationStyle`
* `fontFamily`
* `fontSize`
* `fontStyle`
* `fontWeight`
* `hashCode`
* `height`
* `inherit`
* `letterSpacing`
* `textBaseline`
* `wordSpacing`

## Form input

### How do I retrieve user input?

Xamarin.Forms `element`s allow you to directly query the `element` to determine
the state of any of its properties, or it is bound to a property in a `ViewModel`.

Retrieving information in Flutter is handled by specialized widgets and is different
than how you are used to. If you have a `TextField` or a `TextFormField`, you can supply a
[`TextEditingController`](https://docs.flutter.io/flutter/widgets/TextEditingController-class.html)
to retrieve user input:

<!-- skip -->
{% prettify dart %}
class _MyFormState extends State<MyForm> {
  // Create a text controller and use it to retrieve the current value.
  // of the TextField!
  final myController = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when disposing of the Widget.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Retrieve Text Input'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                // Retrieve the text the user has typed in using our
                // TextEditingController
                content: new Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: new Icon(Icons.text_fields),
      ),
    );
  }
}
{% endprettify %}

You can find more information and the full code listing in
[Retrieve the value of a text field](/docs/cookbook/forms/retrieve-input),
from the [Flutter Cookbook](/docs/cookbook).

### What is the equivalent of a "Placeholder" on an Entry?

In Xamarin.Forms, some `Elements` support a `Placeholder` property, you would
assign a value to. e.g.

<!-- skip -->
{% prettify xml %}
  <Entry Placeholder="This is a hint">
{% endprettify %}

In Flutter, you can easily show a "hint" or a placeholder text for your input by
adding an InputDecoration object to the decoration constructor parameter for
the Text Widget.

<!-- skip -->
{% prettify dart %}
body: new Center(
  child: new TextField(
    decoration: new InputDecoration(hintText: "This is a hint"),
  )
)
{% endprettify %}

### How do I show validation errors?

With Xamarin.Forms, if you wished to provide a visual hint of a
validation error, you would need to create new properties and `VisualElement`s
surrounding the `Element`s that had validation errors.

In Flutter we pass through an InputDecoration object to the decoration
constructor for the Text widget.

However, you don't want to start off by showing an error.
Instead, when the user has entered invalid data,
update the state, and pass a new `InputDecoration` object.

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

    RegExp regExp = new RegExp(emailRegexp);

    return regExp.hasMatch(em);
  }
}
{% endprettify %}

## Flutter plugins

## Interacting with hardware, third party services and the platform

### How do I interact with the platform, and with platform native code?

Flutter doesn't run code directly on the underlying platform; rather, the Dart code
that makes up a Flutter app is run natively on the device, "sidestepping" the SDK
provided by the platform. That means, for example, when you perform a network request
in Dart, it runs directly in the Dart context. You don't use the Android or iOS
APIs you normally take advantage of when writing native apps. Your Flutter
app is still hosted in a native app's `ViewController` or `Activity` as a view,
but you don't have direct access to this, or the native framework.

This doesn't mean Flutter apps cannot interact with those native APIs, or with any
native code you have. Flutter provides [platform channels](/docs/development/platform-integration/platform-channels),
that communicate and exchange data with the `ViewController` or `Activity` that
hosts your Flutter view. Platform channels are essentially an asynchronous messaging
mechanism that bridge the Dart code with the host `ViewController` or `Activity` and
the iOS or Android framework it runs on. You can use platform channels to execute a method on
the native side, or to retrieve some data from the device's sensors, for example.

In addition to directly using platform channels, you can use a variety of pre-made
[plugins](/docs/development/packages-and-plugins/using-packages) that encapsulate
the native and
Dart code for a specific goal. For example, you can use a plugin to access
the camera roll and the device camera directly from Flutter, without having to
write your own integration. Plugins are found [on Pub](https://pub.dartlang.org/),
Dart and Flutter's open source package repository. Some packages might
support native integrations on iOS, or Android, or both.

If you can't find a plugin on Pub that fits your needs, you can
[write your own](/docs/development/packages-and-plugins/developing-packages)
and [publish it on Pub](/docs/development/packages-and-plugins/developing-packages#publish).

### How do I access the GPS sensor?

Use the [`geolocator`](https://pub.dartlang.org/packages/geolocator) community plugin.

### How do I access the camera?

The [`image_picker`](https://pub.dartlang.org/packages/image_picker) plugin is popular
for accessing the camera.

### How do I log in with Facebook?

To Log in with Facebook, use the
[`flutter_facebook_login`](https://pub.dartlang.org/packages/flutter_facebook_login) community plugin.

### How do I use Firebase features?

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

### How do I build my own custom native integrations?

If there is platform-specific functionality that Flutter or its community
Plugins are missing, you can build your own following the
[developing packages and plugins](/docs/development/packages-and-plugins/developing-packages) page.

Flutter's plugin architecture, in a nutshell, is much like using an Event bus in
Android: you fire off a message and let the receiver process and emit a result
back to you. In this case, the receiver is code running on the native side
on Android or iOS.

## Themes (Styles)

### How do I theme my app?

Out of the box, Flutter comes with a beautiful implementation of Material
Design, which takes care of a lot of styling and theming needs that you would
typically do.

Xamarin.Forms does have a global `ResourceDictionary` where you can share styles
across your app. Alternatively there is Theme support currently in preview.

In Flutter you declare themes in the top level widget.

To take full advantage of Material Components in your app, you can declare a top
level widget `MaterialApp` as the entry point to your application. MaterialApp
is a convenience widget that wraps a number of widgets that are commonly
required for applications implementing Material Design. It builds upon a WidgetsApp by
adding Material specific functionality.

You can also use a `WidgetApp` as your app widget, which provides some of the
same functionality, but is not as rich as `MaterialApp`.

To customize the colors and styles of any child components, pass a
`ThemeData` object to the `MaterialApp` widget. For example, in the code below,
the primary swatch is set to blue and text selection color is red.

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

## Databases and local storage

### How do I access Shared Preferences or UserDefaults?

Xamarin.Forms developers will likely be familar with the `Xam.Plugins.Settings` plugin.

In Flutter, access equivalent functionality using the
[Shared Preferences plugin](https://pub.dartlang.org/packages/shared_preferences).
This plugin wraps the functionality of both `UserDefaults` and the Android
equivalent, `SharedPreferences`.

### How do I access SQLite in Flutter?

In Xamarin.Forms most applications would use the `sqlite-net-pcl` plugin to access
SQLite databases.

In Flutter, access this functionality using the
[SQFlite](https://pub.dartlang.org/packages/sqflite) plugin.

## Notifications

### How do I set up push notifications?

In Android, you use Firebase Cloud Messaging to setup push
notifications for your app.

In Flutter, access this functionality using the
[Firebase_Messaging](https://github.com/flutter/plugins/tree/master/packages/firebase_messaging)
plugin.
For more information on using the Firebase Cloud Messaging API, see the
[`firebase_messaging`](https://pub.dartlang.org/packages/firebase_messaging)
plugin documentation.
