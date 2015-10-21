Flutter widgets are built using a functional-reactive framework, which takes
inspiration from [React](http://facebook.github.io/react/). The central idea is
that you build your UI out of components. Components describe what their view
should look like given their current configuration and state. When a component's
state changes, the component rebuilds its description, which the framework diffs
against the previous description in order to determine the minimal changes
needed in the underlying render tree to transition from one state to the next.

Hello World
-----------

The minimal Flutter app simply calls `runApp` function with a widget:

```dart
import 'package:flutter/material.dart';
void main() => runApp(new Center(child: new Text('Hello, world!')));
```

The `runApp` function takes the given `Widget` and makes it the root of the
widget tree. In this example, the widget tree consists of two widgets, the
`Center` widget and its child, the `Text` widget. The framework forces the root
widget to cover the screen, which means the text "Hello, world" ends up centered
on screen.

When writing an app, you'll commonly author new widgets that are subclasses of
either `StatelessComponent` or `StatefulComponent`, depending on whether your
component manages any state. A component's main job is to implement a `build`
function, which describes the component in terms of other, lower-level widgets.
The framework will build those components in turn until the process bottoms out
in widgets that represent the underlying render object.

Basic Widgets
-------------

Flutter comes with a suite of powerful basic widgets, of which the following are
very commonly used:

 * `Text`: The `Text` widget lets you create a run of styled text within your
   application.

 * `Row`, `Column`: These flex widgets let you create flexible layouts in both
   the horizontal (`Row`) and vertical (`Column`) directions. Its design is
   based on the web's flexbox layout model.

 * `Stack`: Instead of being linearly oriented (either horizontally or
   vertically), a `Stack` widget lets you stack widgets on top of each other in
   paint order. You can then use the `Positioned` widget on children of a
   `Stack` to position them relative to the top, right, bottom, or left edge of
   the stack. Stacks are based on the web's absolute positioning layout model.

 * `Container`: The `Container` widget lets you create rectangular visual
   element. A container can be decorated with a `BoxDecoration`, such as a
   background, a border, or a shadow. A `Container` can also have margins,
   padding, and constraints applied to its size. In addition, a `Container` can
   be transformed in three dimensional space using a matrix.

Below are some simple component that combines these and other widgets:

```dart
import 'package:flutter/material.dart';

class MyToolBar extends StatelessComponent {
  MyToolBar({ this.title });

  final Widget title;

  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      padding: const EdgeDims.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(
        backgroundColor: Colors.blue[500]
      ),
      child: new Row([
        new IconButton(icon: 'navigation/menu'),
        new Flexible(child: title),
        new IconButton(icon: 'action/search'),
      ])
    );
  }
}

class MyScaffold extends StatelessComponent {
  Widget build(BuildContext context) {
    return new Material(
      child: new Column([
        new MyToolBar(
          title: new Text('Example title', style: Typography.white.title)
        ),
        new Flexible(
          child: new Center(
            child: new Text('Hello, world!')
          )
        )
      ])
    );
  }
}

void main() => runApp(new MyScaffold());
```

The `MyToolBar` component creates a `Container` with a height of 56
device-independent pixels with an internal padding of 8 pixels, both on the left
and the right. Inside the container, `MyToolBar` uses a `Row` layout to organize
its children. The middle child, the `title` widget, is marked as `Flexible`,
which means it expands to fill any remaining available space that hasn't been
consumed by the inflexible children. You can have multiple `Flexible` children
and determine the ratio in which they consume the available space using the
`flex` argument to `Flexible`.

The `MyScaffold` component organizes its children in a vertical column. At the
top of the column it places an instance of `MyToolBar`, passing the tool bar a
`Text` widget to use as its title. Passing widgets as arguments to other widgets
is a powerful technique that lets you create generic widgets that can be reused
in a wide variety of ways. Finally, `MyScaffold` uses a `Flexible` to fill the
remaining space with its body, which consists a centered message.

Material Apps
-------------

Flutter provides a number of widgets that help you build apps that follow
Material Design. A Material Design app start with the `MaterialApp` widget,
which builds a number of useful widgets at the root of your app, including a
`Navigator`, which manages a stack of widgets identified by strings, also know
as "routes". The `Navigator` lets you transition smoothly between screens of
your application. Using the `MaterialApp` widget is entirely optional but a good
practice.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Flutter Tutorial',
      routes: {
        '/': (RouteArguments args) => new TutorialHome()
      }
    )
  );
}

class TutorialHome extends StatelessComponent {
  Widget build(BuildContext context)  {
    return new Scaffold(
      toolBar: new ToolBar(
        left: new IconButton(icon: "navigation/menu"),
        center: new Text('Example title'),
        right: [ new IconButton(icon: "action/search") ]
      ),
      body: new Center(
        child: new Text('Hello, world!')
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(type: 'content/add', size: 24)
      )
    );
  }
}
```

Now that we've switched from `MyToolBar` and `MyScaffold` to the `ToolBar` and
`Scaffold` widgets from `material.dart`, our app is starting to look at bit more
like Material Design. For example, the tool bar has a shadow and the title text
inherits the correct styling automatically. We've also added a floating action
button for good measure.

Notice that we're again passing widgets as arguments to other widgets. The
`Scaffold` widget takes a number of different named widget arguments, each of
which is places in its layout in the appropriate place. Similarly, the `ToolBar`
widget lets us pass in widgets for the `left` and the `right` of the `center`
widget. This pattern recurs throughout the framework and is something you might
consider when designing your own components.

User input
----------

In addition to being stunningly beautiful, most applications react to user
input. The first step in building an interactive application is to detect
input gestures. Let's see how that works by creating a simple button:

```dart
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
        decoration: new BoxDecoration(
          borderRadius: 5.0,
          backgroundColor: Colors.lightGreen[500]
        ),
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

Many components use a `GestureDetector` to provide optional callbacks for other
components. For example, the `IconButton` and `FloatingActionButton` components
have `onPressed` callbacks that are triggered when the user taps the widget.

State
-----

Thus far, we've used mostly stateless components. Stateless components receive
arguments from their parent component, which they store in `final` member
variables. When a component is asked to `build`, it uses these stored values to
derive new arguments for the widgets it creates. In this way, state naturally
flows "down" the component hierarchy.

Some components, however, have mutable state that represents the transient state
of that part of the user interface. For example, consider a dialog widget with
a checkbox. While the dialog is open, the user might check and uncheck the
checkbox several times before closing the dialog and committing the final value
of the checkbox to the underlying application data model.
