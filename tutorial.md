---
layout: page
title: Flutter Tutorial
nav_title: Tutorial
permalink: /tutorial/
---

Flutter widgets are built using a functional-reactive framework, which takes
inspiration from [React](http://facebook.github.io/react/). The central idea is
that you build your UI out of components. Components describe what their view
should look like given their current configuration and state. When a component's
state changes, the component rebuilds its description, which the framework diffs
against the previous description in order to determine the minimal changes
needed in the underlying render tree to transition from one state to the next.

Hello World
-----------

To build an application, simply call the `runApp` function with a widget:

```dart
import 'package:flutter/material.dart';
void main() => runApp(new Center(child: new Text('Hello, world!')));
```

An app is comprised of a tree of widgets. The most commonly authored
widgets are subclasses of either `StatelessComponent` or `StatefulComponent`,
depending on whether the component manages any state. A component's main job is
to implement `Widget build(BuildContext context)` by returning instances of
other widgets. If a component builds other components, the framework will build
those components in turn until the process bottoms out in widgets that
represent the underlying render object. In the example above, we use the
`Center` and `Text` widgets to display a string of text in the center of the
screen.

Basic Widgets
-------------

Flutter comes with a suite of powerful basic widgets, of which the following are
very commonly used:

 * `Text`: The `Text` widget lets you create a run of styled text within your
   application.

 * `Row`, `Column`: These flex widgets let you create flexible layouts in both
   the horizontal (`Row`) and vertical (`Column`) directions. Its design is
   based on the web's flexbox layout model.

 * `Container`: The `Container` widget lets you create rectangular visual
   element. A container can be decorated with a `BoxDecoration`, such as a
   background, a border, or a shadow. A `Container` can also have margins,
   padding, and constraints applied to its size. In addition, a `Container` can
   be transformed in three dimensional space using a matrix.

 * `NetworkImage`: The `NetworkImage` widget lets you display an image,
   referenced using a URL. The underlying image is cached, which means if
   several `NetworkImage` widgets refer to the same URL, they'll share the
   underlying image resource.

Below is a simple toolbar example that shows how to combine these widgets:

```dart
import 'package:flutter/material.dart';

class MyToolBar extends StatelessComponent {
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      padding: const EdgeDims.symmetric(horizontal: 8.0),
      child: new Material(
        child: new Row([
          new NetworkImage(src: 'menu.png', width: 25.0, height: 25.0),
          new Flexible(child: new Text('My awesome toolbar')),
          new NetworkImage(src: 'search.png', width: 25.0, height: 25.0),
        ])
      )
    );
  }
}
```

The `MyToolBar` component creates a `Container` with a height of 56
device-independent pixels with an internal padding of 8 pixels, both on the left
and the right. Inside the container, `MyToolBar` uses `Material` to paint a
Material Design themed background and a `Row` layout to organize its children.
The middle child, the `Text` widget, is marked as `Flexible`, which means it
expands to fill any remaining available space that hasn't been consumed by the
inflexible children. You can have multiple `Flexible` children and determine the
ratio in which they consume the available space using the `flex` argument to
`Flexible`.

To use this component, we simply create an instance of `MyToolBar` in a `build`
function:

<!-- skip -->
```dart
import 'package:flutter/material.dart';

import 'my_tool_bar.dart';

class DemoHome extends StatelessComponent {
  Widget build() {
    return new Center(child: new MyToolBar());
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'Tutorial app',
    routes: {
      '/', (NavigatorState navigator, Route route) => new DemoHome();
    }
  ));
}
```

Notice that we've passed an instance of the `MaterialApp` widget to `runApp`.
The `MaterialApp` widget builds a number of useful components at the root of
your application, including a `Navigator`, which manages a stack of widgets
identified by strings, also know as "routes". The `Navigator` lets you
transition smoothly between screens of your application. Using the `MaterialApp`
widget is entirely optional but a good practice.

Here, we've used the `Center` widget to center the toolbar within the view, both
vertically and horizontally. If we didn't center the toolbar, it would fill the
view, both vertically and horizontally, because the root widget is sized to fill
the view.

Detecting user input
--------------------

In addition to being stunningly beautiful, most applications react to user
input. The first step in building an interactive application is to detect
input gestures. Let's see how that works by creating a simple button:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

final BoxDecoration _decoration = new BoxDecoration(
  borderRadius: 5.0,
  gradient: new LinearGradient(
    begin: Point.origin,
    end: const Point(0.0, 36.0),
    colors: [ const Color(0xFFEEEEEE), const Color(0xFFCCCCCC) ]
  )
);

class MyButton extends StatelessComponent {
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: new Container(
        height: 36.0,
        padding: const EdgeDims.all(8.0),
        margin: const EdgeDims.symmetric(horizontal: 8.0),
        decoration: _decoration,
        child: new Center(
          child: new Text('Engage')
        )
      )
    );
  }
}
```

The `GestureDetector` widget doesn't have an visual representation but instead
detects gestures made by the user. When the user taps the `Container`, the
`GestureDetector` will call its `onTap` callback, in this case printing a
message to the console. You can use `GestureDetector` to detect a variety of
input gestures, including taps, drags, and scales.

Generic Components
------------------

One of the most powerful features of components is the ability to pass around
references to already-built widgets and reuse them in your `build` function. For
example, we wouldn't want to define a new button component every time we wanted
a button with a novel label:

```dart
class MyButton extends StatelessComponent {
  MyButton({ this.child, this.onPressed });

  final Widget child;
  final Function onPressed;

  BoxDecoration _decoration;

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Container(
        height: 36.0,
        padding: const EdgeDims.all(8.0),
        margin: const EdgeDims.symmetric(horizontal: 8.0),
        decoration: _decoration,
        child: new Center(child: child)
      )
    );
  }
}
```

Rather than providing the button's label as a `String`, we've let the code that
uses `MyButton` provide an arbitrary `Widget` to put inside the button. For
example, we can put an elaborate layout involving text and an image inside the
button:

<!--
class MyButton extends FloatingActionButton {
  MyButton({Widget child}) : super(child: child);
}
-->
```dart
  Widget build(BuildContext context) {
    return new MyButton(
      child: new IntrinsicWidth(
        child: new Row([
          new NetworkImage(src: 'thumbs-up.png', width: 25.0, height: 25.0),
          new Container(
            padding: const EdgeDims.only(left: 10.0),
            child: new Text('Thumbs up')
          )
        ])
      )
    );
  }
```

State
-----

Thus far, we've used mostly stateless components. Stateless components receive
arguments from their parent component, which they store in `final` member
variables. When a component is asked to `build`, it uses these stored values to
derive new arguments for the widgets it creates. For example, the generic
version of `MyButton` above follows this pattern. In this way, state naturally
flows "down" the component hierarchy.

Some components, however, have mutable state that represents the transient state
of that part of the user interface. For example, consider a dialog widget with
a checkbox. While the dialog is open, the user might check and uncheck the
checkbox several times before closing the dialog and committing the final value
of the checkbox to the underlying application data model.

<!--
import 'package:flutter/gestures.dart';

class MyButton extends FloatingActionButton {
  MyButton({
    Widget child,
    GestureTapCallback onPressed
  }) : super(child: child, onPressed: onPressed);
}
-->
```dart
class MyCheckbox extends StatelessComponent {
  MyCheckbox({ this.value, this.onChanged });

  final bool value;
  final Function onChanged;

  Widget build(BuildContext context) {
    Color color = value ? const Color(0xFF00FF00) : const Color(0xFF0000FF);
    return new GestureDetector(
      onTap: () { onChanged(!value); },
      child: new Container(
        height: 25.0,
        width: 25.0,
        decoration: new BoxDecoration(backgroundColor: color)
      )
    );
  }
}

class MyDialog extends StatefulComponent {
  MyDialog({ this.onDismissed });

  final Function onDismissed;

  MyDialogState createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  bool _checkboxValue = false;

  void _handleCheckboxValueChanged(bool value) {
    setState(() {
      _checkboxValue = value;
    });
  }

  Widget build(BuildContext context) {
    return new Row([
      new MyCheckbox(
        value: _checkboxValue,
        onChanged: _handleCheckboxValueChanged
      ),
      new MyButton(
        onPressed: () => config.onDismissed(_checkboxValue),
        child: new Text("Save")
      ),
    ],
    justifyContent: FlexJustifyContent.center);
  }
}
```

The `MyCheckbox` component follows the pattern for stateless components. It
stores the values it receives in its constructor in `final` member variables,
which it then uses during its `build` function. Notice that when the user taps
on the checkbox, the checkbox itself doesn't modify its `value` field. Instead,
the checkbox calls a function it received from its parent component. This
pattern lets you store state higher in the component hierarchy, which causes the
state to persist for longer periods of time. In the extreme, the state stored on
the component passed to `runApp` persists for the lifetime of the application.

The `MyDialog` component is more complicated because it is a stateful component.
Let's walk through the differences in `MyDialog` caused by its being stateful:

 * `MyDialog` extends `StatefulComponent` instead of `StatelessComponent`.

 * `MyDialog` implements the `createState` function to create an instance of the
   `MyDialogState` class that will hold its state.

 * `MyDialogState` has private, mutable member variables. Whenever `MyDialog`
   modifies its transient state, the dialog does so inside a `setState`
   callback. Using `setState` is important because it marks the component as
   dirty and schedules it to be rebuilt. If a component modifies its transient
   state outside of a `setState` callback, the framework won't know that the
   component has changed state and might not call the component's `build`
   function, which means the user interface might not update to reflect the
   changed state.

 * To access member variables from `MyDialog`, the `MyDialogState` object uses
   its `config` property. If the parent component rebuilds and creates a new
   instance of `MyDialog` in its build function, the framework will reuse the
   existing `MyDialogState` rather than calling `createState` again. In this way
   the state for the dialog persists. When that happens, the framework will
   update the `config` property to point to the new `MyDialog` instance, call
   the `didUpdateConfig` function (which you can override), and then call the
   `build` function.

By managing state in this way, you don't need to write separate code for
creating and updating subcomponents. Instead, you simply implement the build
function, which handles both situations.

Finally, when the user taps on the "Save" button, `MyDialog` follows the same
pattern as `MyCheckbox` and calls a function passed in by its parent component
to return the final value of the checkbox up the hierarchy.

initState and dispose
---------------------

When creating state for a `StatefulComponent`, the framework calls `initState`
on the state object. You can override the `initState` function to do work needs
to happen just once. For example, you can override `initState` to configure
animations or to subscribe to platform services. Implementations of `initState`
typically start by calling `super.initState`.

When a state object is no longer needed, the framework calls `dispose` on the
state object. You can override the `dispose` function to do cleanup work. For
example, you can override `dispose` to cancel timers or to unsubscribe from
platform services. Implementations of `dispose` typically end by calling
`super.dispose`.

Keys
----

You can use keys to control which widgets the framework with match up with which
other widgets when a component rebuilds. By default, the framework matches
widgets in the current and previous build according to their `runtimeType` and
the order in which they appear. With keys, the framework requires that the two
widgets have the same `key` as well as the same `runtimeType`.

Keys are most useful in components that build many instances of the same type of
widget. For example, consider an infinite list component that builds just enough
copies of a particular widget to fill its visible region:

 * Without keys, the first entry in the current build would always sync with the
   first entry in the previous build, even if, semantically, the first entry in
   the list just scrolled off screen and is no longer visible in the viewport.

 * By assigning each entry in the list a "semantic" key, the infinite list can
   be more efficient because the framework will sync entries with matching
   semantic keys and therefore similar (or identical) visual appearances.
   Moreover, syncing the entries semantically means that state retained in
   stateful subcomponents will remain attached to the same semantic entry rather
   than the entry in the same numerical position in the viewport.

Global Keys
-----------

You can use global keys to uniquely identify child widgets. Global keys must be
globally unique across the entire widget hierarchy, unlike local keys which need
only be unique among siblings. Because they are globally unique, a global key
can be used to retrieve the state associated with a widget. Consider the
following example:

<!--
import 'package:flutter/gestures.dart';

class MyDialog extends StatefulComponent {
  State createState() => null;
}

class MyButton extends FloatingActionButton {
  MyButton({
    Widget child,
    GestureTapCallback onPressed
  }) : super(child: child, onPressed: onPressed);
}
-->
```dart
class MyComponentState extends State<MyDialog> {
  GlobalKey _scrollable = new GlobalKey();

  Widget build(BuildContext context) {
    return new Column([
      new MyButton(
        onPressed: () {
          (_scrollable.currentState as ScrollableState).scrollBy(10.0);
        },
        child: new Text('Scroll down')
      ),
      new ScrollableList<int>(
        items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
        itemExtent: 100.0,
        itemBuilder: (BuildContext context, int i) {
          return new Container(
            height: 100.0,
            child: new Center(child: new Text('$i'))
          );
        }
      )
    ]);
  }
}
```

When `MyButton` is pressed, the `onPressed` callback finds the `ScrollableState`
object that corresponds to the `_scrollable` global key and mutates its state.

Some widgets, such as `Input` require global keys because they can hold focus,
which means they receive any text the user enters into the app. The `Focus`
widget keeps track of which `InputState` object is focused by remembering its
`GlobalKey`. That way the same `Input` widget remains focused even if it moves
around in the widget tree.

Useful debugging tools
----------------------

This is a quick way to dump the entire widget tree to the console. This can be
quite useful in figuring out exactly what is going on when working with the
widgets system.

```
debugDumpApp();
```
