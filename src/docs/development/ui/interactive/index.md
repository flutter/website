---
title: Adding Interactivity to Your Flutter App
short-title: Adding Interactivity
---

{{site.alert.secondary}}
  <h4 class="no_toc">What you’ll learn</h4>

  * How to respond to taps.
  * How to create a custom widget.
  * The difference between stateless and stateful widgets.
{{site.alert.end}}

How do you modify your app to make it react to user input?
In this tutorial, you'll add interactivity to an app that contains only
non-interactive widgets.  Specifically, you'll modify an icon to make
it tappable by creating a custom stateful widget
that manages two stateless widgets.

## Getting ready

If you've already built the layout in
[Building Layouts in Flutter](/docs/development/ui/layout),
skip to the next section.

* Make sure you've [set up](/docs/get-started/install) your environment.
* [Create a basic Flutter app.](/docs/get-started/test-drive/#create-app)
* Replace the `lib/main.dart` file with
  [`main.dart`](https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/main.dart)
  from GitHub.
* Replace the `pubspec.yaml` file with
  [`pubspec.yaml`](https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/pubspec.yaml)
  from GitHub.
* Create an `images` directory in your project, and add
  [`lake.jpg`.](https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg)

Once you have a connected and enabled device, or you've launched the [iOS
simulator](/docs/get-started/install/macos#set-up-the-ios-simulator)
(part of the Flutter install),
you are good to go!

[Building Layouts for Flutter](/docs/development/ui/layout)
showed how to create the layout for the following screenshot.

<img src="/docs/development/ui/interactive/images/lakes.jpg" style="border:1px solid black" alt="The starting Lakes app that we will modify">

When the app first launches, the star is solid red, indicating that this lake
has previously been favorited. The number next to the star indicates that
41 people have favorited this lake.  After completing this tutorial,
tapping the star removes its favorited status, replacing
the solid star with an outline and decreasing the count. Tapping
again favorites the lake, drawing a solid star and increasing the count.

<img src="/docs/development/ui/interactive/images/favorited-not-favorited.png" alt="the custom widget you'll create">

To accomplish this, you'll create a single custom widget that includes both the
star and the count, which are themselves widgets. Because tapping the star
changes state for both widgets, so the same widget should manage both.

You can get right to touching the code in
[Step 2: Subclass StatefulWidget](#step-2).
If you want to try different ways of managing state, skip to
[Managing state](#managing-state).

<a name="stateful-stateless"></a>
## Stateful and stateless widgets

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What's the point?</b>

* Some widgets are stateful, and some are stateless.
* If a widget changes&mdash;the user interacts with it,
  for example&mdash;it's _stateful_.
* A widget's state consists of values that can change, like a slider's
  current value or whether a checkbox is checked.
* A widget's state is stored in a State object, separating the widget's
  state from its appearance.
* When the widget's state changes, the state object calls
  `setState()`, telling the framework to redraw the widget.

</div>

A _stateless_ widget has no internal state to manage.
[Icon](https://docs.flutter.io/flutter/widgets/Icon-class.html),
[IconButton](https://docs.flutter.io/flutter/material/IconButton-class.html),
and [Text](https://docs.flutter.io/flutter/widgets/Text-class.html) are
examples of stateless widgets, which subclass
[StatelessWidget](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html).

A _stateful_ widget is dynamic. The user can interact with a stateful widget
(by typing into a form, or moving a slider, for example),
or it changes over time (perhaps a data feed causes the UI to update).
[Checkbox](https://docs.flutter.io/flutter/material/Checkbox-class.html),
[Radio](https://docs.flutter.io/flutter/material/Radio-class.html),
[Slider](https://docs.flutter.io/flutter/material/Slider-class.html),
[InkWell](https://docs.flutter.io/flutter/material/InkWell-class.html),
[Form](https://docs.flutter.io/flutter/widgets/Form-class.html), and
[TextField](https://docs.flutter.io/flutter/material/TextField-class.html)
are examples of stateful widgets, which subclass
[StatefulWidget](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html).

<a name="creating-stateful-widget"></a>
## Creating a stateful widget

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What's the point?</b>

* To create a custom stateful widget, subclass two classes:
  StatefulWidget and State.
* The state object contains the widget's state and the widget's `build()`
  method.
* When the widget's state changes, the state object calls
  `setState()`, telling the framework to redraw the widget.

</div>

In this section, you'll create a custom stateful widget.
You'll replace two stateless widgets&mdash;the solid red star and the
numeric count next to it&mdash;with a single custom
stateful widget that manages a row with two children widgets: an IconButton
and Text.

Implementing a custom stateful widget requires creating two classes:

* A subclass of StatefulWidget that defines the widget.
* A subclass of State that contains the state for that widget and defines
  the widget's `build()` method.

This section shows how to build a StatefulWidget, called FavoriteWidget,
for the Lakes app. The first step is choosing how FavoriteWidget's state
is managed.

<a name="step-1"></a>
### Step 1: Decide which object manages the widget's state

A widget's state can be managed in several ways, but in our example
the widget itself, FavoriteWidget, will manage its own state.
In this example, toggling the star is an isolated action that doesn't
affect the parent widget or the rest of the UI,
so the widget can handle its state internally.

Learn more about the separation of widget and state,
and how state might be managed, in [Managing state](#managing-state).

<a name="step-2"></a>
### Step 2: Subclass StatefulWidget

The FavoriteWidget class manages its own state, so it overrides
`createState()` to create the State object.
The framework calls `createState()` when it wants to build the widget.
In this example, `createState()` creates an instance of _FavoriteWidgetState,
which you'll implement in the next step.

<!-- code/layout/lakes-interactive/main.dart -->
<!-- skip -->
{% prettify dart %}
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**
Members or classes that start with an underscore (_) are private.
For more information, see [Libraries and
visibility,](https://www.dartlang.org/guides/language/language-tour#libraries-and-visibility)
a section in the
[Dart language tour.](https://www.dartlang.org/guides/language/language-tour)
</aside>

<a name="step-3"></a>
### Step 3: Subclass State

The custom State class stores the mutable information&mdash;the logic and
internal state that can change over the lifetime of the widget.
When the app first launches, the UI displays a solid red star,
indicating that the lake has "favorite" status, and has 41 “likes”.
The state object stores this information in the
`_isFavorited` and `_favoriteCount` variables.

The state object also defines the `build` method. This `build` method
creates a row containing a red IconButton, and Text.  The widget uses
[IconButton](https://docs.flutter.io/flutter/material/IconButton-class.html),
(instead of Icon), because it has an `onPressed` property that
defines the callback method for handling a tap.
IconButton also has an `icon` property that holds the Icon.

The `_toggleFavorite()` method, which is called when the IconButton is pressed,
calls `setState()`. Calling `setState()` is critical, because this tells
the framework that the widget’s state has changed and the widget
should redraw. The `_toggleFavorite` function swaps the UI between
1) a star icon and the number ‘41’, and
2) a star_border icon and the number ‘40’.

<!-- code/layout/lakes-interactive/main.dart -->
<!-- skip -->
{% prettify dart %}
class _FavoriteWidgetState extends State<FavoriteWidget> {
  [[highlight]]bool _isFavorited = true;[[/highlight]]
  [[highlight]]int _favoriteCount = 41;[[/highlight]]

  [[highlight]]void _toggleFavorite()[[/highlight]] {
    [[highlight]]setState(()[[/highlight]] {
      // If the lake is currently favorited, unfavorite it.
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
        // Otherwise, favorite it.
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0.0),
          child: IconButton(
            [[highlight]]icon: (_isFavorited[[/highlight]]
                [[highlight]]? Icon(Icons.star)[[/highlight]]
                [[highlight]]: Icon(Icons.star_border)),[[/highlight]]
            color: Colors.red[500],
            [[highlight]]onPressed: _toggleFavorite,[[/highlight]]
          ),
        ),
        SizedBox(
          width: 18.0,
          child: Container(
            [[highlight]]child: Text('$_favoriteCount'),[[/highlight]]
          ),
        ),
      ],
    );
  }
}
{% endprettify %}

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
Placing the Text in a SizedBox and setting its width prevents a discernible
"jump" when the text changes between the values of 40 and 41&mdash;this
would otherwise occur because those values have different widths.
</aside>

<a name="step-4"></a>
### Step 4: Plug the stateful widget into the widget tree

Add your custom stateful widget to the widget tree in the app's
build method. First, locate the code that creates the Icon and Text, and delete it:

<!-- code/layout/lakes/main.dart -->
<!-- skip -->
{% prettify dart %}
// ...
[[strike]]Icon([[/strike]]
  [[strike]]Icons.star,[[/strike]]
  [[strike]]color: Colors.red[500],[[/strike]]
[[strike]]),[[/strike]]
[[strike]]Text('41')[[/strike]]
// ...
{% endprettify %}

In the same location, create the stateful widget:

<!-- code/layout/lakes-interactive/main.dart -->
<!-- skip -->
{% prettify dart %}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      // ...
      child: Row(
        children: [
          Expanded(
            child: Column(
              // ...
          ),
          [[highlight]]FavoriteWidget()[[/highlight]],
        ],
      ),
    );

    return MaterialApp(
      // ...
    );
  }
}
{% endprettify %}

<br>That's it! When you hot reload the app, the star icon should now respond to taps.

### Problems?

If you can't get your code to run, look in your IDE for possible errors.
[Debugging Flutter Apps](/docs/testing/debugging) might help.
If you still can't find the problem,
check your code against the interactive Lakes example on GitHub.

* [`lib/main.dart`](https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes-interactive/main.dart)
* [`pubspec.yaml`](https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes-interactive/pubspec.yaml)&mdash;no changes to this file
* [`lakes.jpg`](https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes-interactive/images/lake.jpg)&mdash;no changes to this file

If you still have questions, refer to [Get support.](/community)

---

The rest of this page covers several ways a widget's state can be managed,
and lists other available interactive widgets.

<a name="managing-state"></a>
## Managing state

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What's the point?</b>

* There are different approaches for managing state.
* You, as the widget designer, choose which approach to use.
* If in doubt, start by managing state in the parent widget.

</div>

Who manages the stateful widget's state? The widget itself? The parent widget?
Both? Another object? The answer is... it depends.
There are several valid ways to make your widget interactive.
You, as the widget designer, make the decision based on how you expect your
widget to be used. Here are the most common ways to manage state:

* [The widget manages its own state](#self-managed)
* [The parent manages the widget's state](#parent-managed)
* [A mix-and-match approach](#mix-and-match)

{% comment %}
NOTE: Commenting this out for now. The example needs some updates.

First, fix TapboxD, add it back to the repo, and then restore this note.
<aside class="alert alert-info" markdown="1">
**Note:** You can also manage state by exporting the state to a model class
that notifies widgets when state changes have occurred. This approach is
particularly useful when you want multiple widgets to listen and respond to the
same state information.

Explaining this approach is beyond the scope of this tutorial,
but you can try it out using the TapboxD example on GitHub.
The only file you need is
[lib/main.dart]().
[PENDING: Add a link once it's up on the site.]
</aside>
{% endcomment %}

How do you decide which approach to use? The following principles should help
you decide:

* If the state in question is user data,
  for example the checked or unchecked mode of a checkbox,
  or the position of a slider,
  then the state is best managed by the parent widget.

* If the state in question is aesthetic, for example an animation,
  then the state is best managed by the widget itself.

If in doubt, start by managing state in the parent widget.

We'll give examples of the different ways of managing state by creating three
simple examples: TapboxA, TapboxB, and TapboxC.
The examples all work similarly&mdash;each creates a container that,
when tapped, toggles between a green or grey box.
The `_active` boolean determines the color: green for active or
grey for inactive.

<img src="/docs/development/ui/interactive/images/tapbox-active-state.png" style="border:1px solid black" alt="a large green box with the text, 'Active'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/docs/development/ui/interactive/images/tapbox-inactive-state.png" style="border:1px solid black" alt="a large grey box with the text, 'Inactive'">

These examples use
[GestureDetector](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html)
to capture activity on the Container.

<a name="self-managed"></a>
### The widget manages its own state

Sometimes it makes the most sense for the widget to manage its state internally.
For example,
[ListView](https://docs.flutter.io/flutter/widgets/ListView-class.html)
automatically scrolls when its content exceeds the render box. Most
developers using ListView don't want to manage ListView's
scrolling behavior, so ListView itself manages its scroll offset.

The `_TapboxAState` class:

* Manages state for `TapboxA`.
* Defines the `_active` boolean which determines the box's current color.
* Defines the `_handleTap()` function, which updates `_active` when the box is
  tapped and calls the `setState()` function to update the UI.
* Implements all interactive behavior for the widget.

<!-- skip -->
{% prettify dart %}
// TapboxA manages its own state.

//------------------------- TapboxA ----------------------------------

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//------------------------- MyApp ----------------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: TapboxA(),
        ),
      ),
    );
  }
}
{% endprettify %}

<hr>

<a name="parent-managed"></a>
### The parent widget manages the widget's state

Often it makes the most sense for the parent widget to manage the state
and tell its child widget when to update. For example,
[IconButton](https://docs.flutter.io/flutter/material/IconButton-class.html)
allows you to treat an icon as a tappable button.
IconButton is a stateless widget because we decided that
the parent widget needs to know whether the button has been tapped,
so it can take appropriate action.

In the following example, TapboxB exports its state to its parent
through a callback. Because TapboxB doesn't manage any state, it
subclasses StatelessWidget.

The ParentWidgetState class:

* Manages the `_active` state for TapboxB.
* Implements `_handleTapboxChanged()`, the method called when the box is tapped.
* When the state changes, calls `setState()` to update the UI.

The TapboxB class:

* Extends StatelessWidget because all state is handled by its parent.
* When a tap is detected, it notifies the parent.

<!-- skip -->
{% prettify dart %}
// ParentWidget manages the state for TapboxB.

//------------------------ ParentWidget --------------------------------

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
{% endprettify %}

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
When creating API, consider using the `@required` annotation for
any parameters that your code relies on.
To use `@required`, import the [foundation
library](https://docs.flutter.io/flutter/foundation/foundation-library.html)
(which re-exports Dart's
[meta.dart](https://pub.dartlang.org/packages/meta) library):

<pre>
import 'package:flutter/foundation.dart';
</pre>
</aside>

<hr>

<a name="mix-and-match"></a>
### A mix-and-match approach

For some widgets, a mix-and-match approach makes the most sense.
In this scenario, the stateful widget manages some of the state,
and the parent widget manages other aspects of the state.

In the TapboxC example, on tap down, a dark green border appears around the box.
On tap up, the border disappears and the box's color changes.
TapboxC exports its `_active` state to its parent but
manages its `_highlight` state internally.
This example has two State objects, _ParentWidgetState and _TapboxCState.

The _ParentWidgetState object:

* Manages the `_active` state.
* Implements `_handleTapboxChanged()`, the method called when the box is tapped.
* Calls `setState()` to update the UI when a tap occurs and the `_active`
  state changes.

The _TapboxCState object:

* Manages the `_highlight` state.
* The GestureDetector listens to all tap events.
  As the user taps down, it adds the highlight
  (implemented as a dark green border).
  As the user releases the tap, it removes the highlight.
* Calls `setState()` to update the UI on tap down, tap up, or tap cancel, and
  the `_highlight` state changes.
* On a tap event, passes that state change to the parent widget to take
  appropriate action using the
  [widget](https://docs.flutter.io/flutter/widgets/State/widget.html)
  property.

<!-- skip -->
{% prettify dart %}
//---------------------------- ParentWidget ----------------------------

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  Widget build(BuildContext context) {
    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return GestureDetector(
      onTapDown: _handleTapDown, // Handle the tap events in the order that
      onTapUp: _handleTapUp, // they occur: down, up, tap, cancel
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(widget.active ? 'Active' : 'Inactive',
              style: TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color:
              widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(
                  color: Colors.teal[700],
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}
{% endprettify %}

An alternate implementation might have exported the highlight state to the
parent while keeping the active state internal,
but if you asked someone to use that tap box, they'd probably complain that
it doesn't make much sense. The developer cares whether the box is active.
The developer probably doesn't care how the highlighting is managed,
and prefers that the tap box handles those details.

<hr>

<a name="other-interactive-widgets"></a>
## Other interactive widgets

Flutter offers a variety of buttons and similar interactive widgets.
Most of these widgets implement the [Material Design
guidelines,](https://material.io/guidelines/) which define a set of
components with an opinionated UI.

If you prefer, you can use
[GestureDetector](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html)
to build interactivity into any custom widget. You can find examples of
GestureDetector in [Managing state](#managing-state), and in the
[Flutter
Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery).

<aside class="alert alert-info" markdown="1">
**Note:**
Flutter also provides a set of iOS-style widgets called
[Cupertino](https://docs.flutter.io/flutter/cupertino/cupertino-library.html).
</aside>

When you need interactivity,
it's easiest to use one of the prefabricated widgets. Here's a partial list:

### Standard widgets:

* [Form](https://docs.flutter.io/flutter/widgets/Form-class.html)
* [FormField](https://docs.flutter.io/flutter/widgets/FormField-class.html)

### Material Components:

* [Checkbox](https://docs.flutter.io/flutter/material/Checkbox-class.html)
* [DropdownButton](https://docs.flutter.io/flutter/material/DropdownButton-class.html)
* [FlatButton](https://docs.flutter.io/flutter/material/FlatButton-class.html)
* [FloatingActionButton](https://docs.flutter.io/flutter/material/FloatingActionButton-class.html)
* [IconButton](https://docs.flutter.io/flutter/material/IconButton-class.html)
* [Radio](https://docs.flutter.io/flutter/material/Radio-class.html)
* [RaisedButton](https://docs.flutter.io/flutter/material/RaisedButton-class.html)
* [Slider](https://docs.flutter.io/flutter/material/Slider-class.html)
* [Switch](https://docs.flutter.io/flutter/material/Switch-class.html)
* [TextField](https://docs.flutter.io/flutter/material/TextField-class.html)

## Resources

The following resources may help when adding interactivity to your app.

* [Gestures](/docs/development/ui/widgets-intro#handling-gestures),
  a section in [A Tour of the Flutter Widget
  Framework](/docs/development/ui/widgets-intro)<br>
  How to create a button and make it respond to input.
* [Gestures in Flutter](/docs/development/ui/advanced/gestures)<br>
  A description of Flutter's gesture mechanism.
* [Flutter API documentation](https://docs.flutter.io)<br>
  Reference documentation for all of the Flutter libraries.
* [Flutter
  Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)<br>
  Demo app showcasing many Material Components and other Flutter features.
* [Flutter's Layered
   Design (video)](https://www.youtube.com/watch?v=dkyY9WCGMi0)<br>
   This video includes information about state and stateless widgets.
   Presented by Google engineer, Ian Hickson.
