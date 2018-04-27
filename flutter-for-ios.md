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

### How do I update `Widget`s?

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
0 and 1 on each frame while it's running.You then create one or more
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
