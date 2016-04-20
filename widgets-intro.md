---
layout: page
title: Introduction to Flutter's Widget Framework
permalink: /widgets-intro/
---

Flutter widgets are built using a functional-reactive framework, which takes
inspiration from [React](http://facebook.github.io/react/). The central idea is
that you build your UI out of widgets. Widgets describe what their view
should look like given their current configuration and state. When a widget's
state changes, the widget rebuilds its description, which the framework diffs
against the previous description in order to determine the minimal changes
needed in the underlying render tree to transition from one state to the next.

* TOC Placeholder
{:toc}

Hello World
-----------

The minimal Flutter app simply calls the
[`runApp`](http://docs.flutter.io/flutter/material/runApp.html) function
with a widget:

```dart
import 'package:flutter/material.dart';
void main() => runApp(new Center(child: new Text('Hello, world!')));
```

The [`runApp`](http://docs.flutter.io/flutter/material/runApp.html) function
takes the given
[`Widget`](http://docs.flutter.io/flutter/material/Widget-class.html) and
makes it the root of the widget tree. In this example, the widget tree consists
of two widgets, the
[`Center`](http://docs.flutter.io/flutter/material/Center-class.html) widget
and its child, the
[`Text`](http://docs.flutter.io/flutter/material/Text-class.html) widget.
The framework forces the root widget to cover the screen, which means the text
"Hello, world" ends up centered on screen.

When writing an app, you'll commonly author new widgets that are subclasses of
either
[`StatelessWidget`](http://docs.flutter.io/flutter/material/StatelessWidget-class.html)
or
[`StatefulWidget`](http://docs.flutter.io/flutter/material/StatefulWidget-class.html),
depending on whether your widget manages any state. A widget's main job is
to implement a
[`build`](http://docs.flutter.io/flutter/material/StatelessWidget/build.html)
function, which describes the widget in terms of other, lower-level widgets.
The framework will build those widgets in turn until the process bottoms out
in widgets that represent the underlying render object.

Basic widgets
-------------

Flutter comes with a suite of powerful basic widgets, of which the following are
very commonly used:

 * [`Text`](http://docs.flutter.io/flutter/material/Text-class.html): The
   [`Text`](http://docs.flutter.io/flutter/material/Text-class.html) widget
   lets you create a run of styled text within your application.

 * [`Row`](http://docs.flutter.io/flutter/material/Row-class.html),
   [`Column`](http://docs.flutter.io/flutter/material/Column-class.html):
   These flex widgets let you create flexible layouts in both the horizontal
   ([`Row`](http://docs.flutter.io/flutter/material/Row-class.html)) and
   vertical
   ([`Column`](http://docs.flutter.io/flutter/material/Column-class.html))
   directions. Its design is based on the web's flexbox layout model.

 * [`Stack`](http://docs.flutter.io/flutter/material/Stack-class.html):
   Instead of being linearly oriented (either horizontally or vertically), a
   [`Stack`](http://docs.flutter.io/flutter/material/Stack-class.html)
   widget lets you stack widgets on top of each other in paint order. You can
   then use the
   [`Positioned`](http://docs.flutter.io/flutter/material/Positioned-class.html)
   widget on children of a
   [`Stack`](http://docs.flutter.io/flutter/material/Stack-class.html) to
   position them relative to the top, right, bottom, or left edge of the stack.
   Stacks are based on the web's absolute positioning layout model.

 * [`Container`](http://docs.flutter.io/flutter/material/Container-class.html):
   The [`Container`](http://docs.flutter.io/flutter/material/Container-class.html)
   widget lets you create rectangular visual element. A container can be
   decorated with a
   [`BoxDecoration`](http://docs.flutter.io/flutter/material/BoxDecoration-class.html),
   such as a background, a border, or a shadow. A
   [`Container`](http://docs.flutter.io/flutter/material/Container-class.html)
   can also have margins, padding, and constraints applied to its size. In
   addition, a
   [`Container`](http://docs.flutter.io/flutter/material/Container-class.html)
   can be transformed in three dimensional space using a matrix.

Below are some simple widgets that combine these and other widgets:

```dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({ this.title });

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(
        backgroundColor: Colors.blue[500]
      ),
      child: new Row(
        children: <Widget>[
          new IconButton(icon: Icons.menu, tooltip: 'Navigation menu'),
          new Flexible(child: title),
          new IconButton(icon: Icons.search, tooltip: 'Search'),
        ]
      )
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text('Example title', style: Typography.white.title)
          ),
          new Flexible(
            child: new Center(
              child: new Text('Hello, world!')
            )
          )
        ]
      )
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'My app',
    home: new MyScaffold()
  ));
}
```

Be sure to have a `uses-material-design: true` entry in your `flutter.yaml`
file. It allows to use the predefined set of
[material icons](https://design.google.com/icons/).

```yaml
name: my_app
uses-material-design: true
```

Many widgets need to be inside of a
[`MaterialApp`](http://docs.flutter.io/flutter/material/MaterialApp-class.html)
to display properly, in order to inherit theme data. Therefore, we run the
application with a
[`MaterialApp`](http://docs.flutter.io/flutter/material/MaterialApp-class.html).

The `MyAppBar` widget creates a
[`Container`](http://docs.flutter.io/flutter/material/Container-class.html)
with a height of 56 device-independent pixels with an internal padding of 8
pixels, both on the left and the right. Inside the container, `MyAppBar` uses a
[`Row`](http://docs.flutter.io/flutter/material/Row-class.html) layout to
organize its children. The middle child, the `title` widget, is marked as
[`Flexible`](http://docs.flutter.io/flutter/material/Flexible-class.html),
which means it expands to fill any remaining available space that hasn't been
consumed by the inflexible children. You can have multiple
[`Flexible`](http://docs.flutter.io/flutter/material/Flexible-class.html)
children and determine the ratio in which they consume the available space using
the
[`flex`](http://docs.flutter.io/flutter/material/Flexible-class.html#flex)
argument to
[`Flexible`](http://docs.flutter.io/flutter/material/Flexible-class.html).

The `MyScaffold` widget organizes its children in a vertical column. At the
top of the column it places an instance of `MyAppBar`, passing the app bar a
[`Text`](http://docs.flutter.io/flutter/material/Text-class.html) widget to
use as its title. Passing widgets as arguments to other widgets is a powerful
technique that lets you create generic widgets that can be reused in a wide
variety of ways. Finally, `MyScaffold` uses a
[`Flexible`](http://docs.flutter.io/flutter/material/Flexible-class.html) to
fill the remaining space with its body, which consists a centered message.

Using material design
---------------------

Flutter provides a number of widgets that help you build apps that follow
Material Design. A Material Design app start with the
[`MaterialApp`](http://docs.flutter.io/flutter/material/MaterialApp-class.html)
widget, which builds a number of useful widgets at the root of your app,
including a
[`Navigator`](http://docs.flutter.io/flutter/material/Navigator-class.html),
which manages a stack of widgets identified by strings, also known as "routes".
The
[`Navigator`](http://docs.flutter.io/flutter/material/Navigator-class.html)
lets you transition smoothly between screens of your application. Using the
[`MaterialApp`](http://docs.flutter.io/flutter/material/MaterialApp-class.html)
widget is entirely optional but a good practice.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Flutter Tutorial',
      home: new TutorialHome()
    )
  );
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(icon: Icons.menu, tooltip: 'Navigation menu'),
        title: new Text('Example title'),
        actions: <Widget>[ new IconButton(icon: Icons.search, tooltip: 'Search') ]
      ),
      body: new Center(
        child: new Text('Hello, world!')
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add',
        child: new Icon(icon: Icons.add)
      )
    );
  }
}
```

Now that we've switched from `MyAppBar` and `MyScaffold` to the
[`AppBar`](http://docs.flutter.io/flutter/material/AppBar-class.html) and
[`Scaffold`](http://docs.flutter.io/flutter/material/Scaffold-class.html)
widgets from `material.dart`, our app is starting to look at bit more like
Material Design. For example, the app bar has a shadow and the title text
inherits the correct styling automatically. We've also added a floating action
button for good measure.

Notice that we're again passing widgets as arguments to other widgets. The
[`Scaffold`](http://docs.flutter.io/flutter/material/Scaffold-class.html)
widget takes a number of different widgets as named arguments, each of which are
placed in the Scaffold layout in the appropriate place. Similarly, the
[`AppBar`](http://docs.flutter.io/flutter/material/AppBar-class.html)
widget lets us pass in widgets for the
[`leading`](http://docs.flutter.io/flutter/material/AppBar-class.html#leading)
and the
[`actions`](http://docs.flutter.io/flutter/material/AppBar-class.html#actions)
of the
[`title`](http://docs.flutter.io/flutter/material/AppBar-class.html#title)
widget. This pattern recurs throughout the framework and is something you might
consider when designing your own widgets.

Handling gestures
-----------------

In addition to being stunningly beautiful, most applications react to user
input. The first step in building an interactive application is to detect
input gestures. Let's see how that works by creating a simple button:

```dart
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: new Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
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

The
[`GestureDetector`](http://docs.flutter.io/flutter/material/GestureDetector-class.html)
widget doesn't have an visual representation but instead detects gestures made
by the user. When the user taps the
[`Container`](http://docs.flutter.io/flutter/material/Container-class.html),
the
[`GestureDetector`](http://docs.flutter.io/flutter/material/GestureDetector-class.html)
will call its
[`onTap`](http://docs.flutter.io/flutter/material/GestureDetector-class.html#onTap)
callback, in this case printing a message to the console. You can use
[`GestureDetector`](http://docs.flutter.io/flutter/material/GestureDetector-class.html)
to detect a variety of input gestures, including taps, drags, and scales.

Many widgets use a
[`GestureDetector`](http://docs.flutter.io/flutter/material/GestureDetector-class.html)
to provide optional callbacks for other widgets. For example, the
[`IconButton`](http://docs.flutter.io/flutter/material/IconButton-class.html),
[`RaisedButton`](http://docs.flutter.io/flutter/material/RaisedButton-class.html),
and
[`FloatingActionButton`](http://docs.flutter.io/flutter/material/FloatingActionButton-class.html)
widgets have
[`onPressed`](http://docs.flutter.io/flutter/material/RaisedButton-class.html#onPressed)
callbacks that are triggered when the user taps the widget.

Managing state
--------------

Thus far, we've used only stateless widgets. Stateless widgets receive
arguments from their parent widget, which they store in
[`final`](https://www.dartlang.org/docs/dart-up-and-running/ch02.html#final-and-const)
member variables. When a widget is asked to
[`build`](http://docs.flutter.io/flutter/material/StatelessWidget/build.html),
it uses these stored values to derive new arguments for the widgets it creates.

In order to build more complex experiences - for example, to react in more
interesting ways to user input - applications will typically carry some state.
Flutter uses StatefulWidgets to capture this idea. StatefulWidgets are
special widgets that know how to generate State objects, which are then used to
hold state. Consider this basic example, using the
[`RaisedButton`](http://docs.flutter.io/flutter/material/RaisedButton-class.html)
mentioned earlier:

```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() { _count += 1; });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: _increment,
          child: new Text('Increment')
        ),
        new Text('Count: $_count')
      ]
    );
  }
}
```

You might wonder why StatefulWidget and State are separate objects. In
Flutter, these two types of objects have different life cycles. Widgets are
temporary objects, used to construct a presentation of the application in its
current state. State objects on the other hand are persistent between calls to
[`build()`](http://docs.flutter.io/flutter/material/State/build.html),
allowing them to remember information.

The example above accepts user input and directly uses the result in its
build method.  In more complex applications, different parts of the widget
hierarchy might be responsible for different concerns; for example, one
widget might present a complex user interface with the goal of gathering
specific information, such as a date or location, while another widget might
use that information to change the overall presentation.

In Flutter, change notifications flow "up" the widget hierarchy by way of
callbacks, while current state flows "down" to the stateless widgets that do
presentation. The common parent that redirects this flow is the State. Let's
see how that works in practice, with this slightly more complex example:


```dart
class CounterDisplay extends StatelessWidget {
  CounterDisplay({ this.count });
  final int count;
  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({ this.onPressed });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment')
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() { ++_count; });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new CounterIncrementor(
          onPressed: _increment
        ),
        new CounterDisplay(count: _count)
      ]
    );
  }
}
```

Notice how we created two new stateless widgets, cleanly separating
the concerns of _displaying_ the counter (CounterDisplay) and _changing_
the counter (CounterIncrementor).
Although the net result is the same as the previous example, the separation of
responsibility allows greater complexity to be encapsulated in the individual
widgets, while maintaining simplicity in the parent.

Bringing it all together
------------------------

Let's consider a more complete example that brings together the concepts
introduced above. We'll work with a hypothetical shopping application, which
displays various products offered for sale and maintains a shopping cart for
intended purchases. Let's start by defining our presentation class,
`ShoppingListItem`:

```dart
class Product {
  const Product({ this.name });
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({ Product product, this.inCart, this.onCartChanged })
    : product = product, super(key: new ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (inCart) {
      return DefaultTextStyle.of(context).copyWith(
          color: Colors.black54, decoration: TextDecoration.lineThrough);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      onTap: () => onCartChanged(product, !inCart),
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0])
      ),
      title: new Text(product.name, style: _getTextStyle(context))
    );
  }
}
```

The `ShoppingListItem` widget follows a common pattern for stateless
widgets. It stores the values it receives in its constructor in
[`final`](https://www.dartlang.org/docs/dart-up-and-running/ch02.html#final-and-const)
member variables, which it then uses during its
[`build`](http://docs.flutter.io/flutter/material/StatelessWidget/build.html)
function. For example, the `inCart` boolean to toggle between two visual
appearances: one that uses the primary color from the current theme and another
that uses gray.

When the user taps the list item, the widget doesn't modify its `inCart`
value directly. Instead, the widget calls the `onCartChanged` function it
received from its parent widget. This pattern lets you store state higher in
the widget hierarchy, which causes the state to persist for longer periods of
time. In the extreme, the state stored on the widget passed to
[`runApp`](http://docs.flutter.io/flutter/material/runApp.html) persists for
the lifetime of the application.

When the parent receives the `onCartChanged` callback, the parent will update
its internal state, which will trigger the parent to rebuild and create a new
instance of `ShoppingListItem` with the new `inCart` value. Although the parent
creates a new instance of `ShoppingListItem` when it rebuilds, that operation is
cheap because the framework compares the newly built widgets with the previously
built widgets and applies only the differences to the underlying render objects.

Let's look at an example parent widget that stores mutable state:

<!--
class Product {
  const Product({ this.name });
  final String name;
}

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({ Product product, bool inCart, Function onCartChanged });
  @override
  Widget build(BuildContext context) => null;
}
-->
```dart
class ShoppingList extends StatefulWidget {
  ShoppingList({ Key key, this.products }) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context)  {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List')
      ),
      body: new MaterialList(
        type: MaterialListType.oneLineWithAvatar,
        children: config.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged
          );
        })
      )
    );
  }
}

final List<Product> _kProducts = <Product>[
  new Product(name: 'Eggs'),
  new Product(name: 'Flour'),
  new Product(name: 'Chocolate chips'),
];

void main() {
  runApp(new MaterialApp(
    title: 'Shopping List',
    home: new ShoppingList(products: _kProducts)
  ));
}
```

The `ShoppingList` class extends
[`StatefulWidget`](http://docs.flutter.io/flutter/material/StatefulWidget-class.html),
which means this widget stores mutable state. When the `ShoppingList`
widget is first inserted into the tree, the framework calls the
[`createState`](http://docs.flutter.io/flutter/material/StatefulWidget-class.html#createState)
function to create a fresh instance of `_ShoppingListState` to associate with
that location in the tree. (Notice that we typically name subclasses of
[`State`](http://docs.flutter.io/flutter/material/State-class.html) with
leading underscores to indicate that they are private implementation details.)
When this widget's parent rebuilds, the parent will create a new instance of
`ShoppingList`, but the framework will reuse the `_ShoppingListState` instance
that is already in the tree rather than calling
[`createState`](http://docs.flutter.io/flutter/material/StatefulWidget-class.html#createState)
again.

To access properties of the current `ShoppingList`, the `_ShoppingListState` can
use its
[`config`](http://docs.flutter.io/flutter/material/State-class.html#config)
property. If the parent rebuilds and creates a new `ShoppingList`, the
`_ShoppingListState` will also rebuild with the new
[`config`](http://docs.flutter.io/flutter/material/State-class.html#config)
value. If you wish to be notified when the
[`config`](http://docs.flutter.io/flutter/material/State-class.html#config)
property changes, you can override the
[`didUpdateConfig`](http://docs.flutter.io/flutter/material/State-class.html#didUpdateConfig)
function, which is passed the `oldConfig` to let you compare the old
configuration with the current
[`config`](http://docs.flutter.io/flutter/material/State-class.html#config).

When handling the `onCartChanged` callback, the `_ShoppingListState` mutates its
internal state by either adding or removing a product from `_shoppingCart`. To
signal to the framework that it changes its internal state, it wraps those calls
in a
[`setState`](http://docs.flutter.io/flutter/material/State-class.html#setState)
call. Calling
[`setState`](http://docs.flutter.io/flutter/material/State-class.html#setState)
marks this widget as dirty and schedules it to be rebuilt the next time your
app needs to update the screen. If you forget to call
[`setState`](http://docs.flutter.io/flutter/material/State-class.html#setState)
when modifying the internal state of a widget, the framework won't know your
widget is dirty and might not call the widget's
[`build`](http://docs.flutter.io/flutter/material/StatelessWidget/build.html)
function, which means the user interface might not update to reflect the changed
state.

By managing state in this way, you don't need to write separate code for
creating and updating child widgets. Instead, you simply implement the build
function, which handles both situations.

Responding to widget lifecycle events
-------------------------------------

After calling
[`createState`](http://docs.flutter.io/flutter/material/StatefulWidget-class.html#createState)
on the StatefulWidget, the framework inserts the new state object into the
tree and then calls
[`initState`](http://docs.flutter.io/flutter/material/State-class.html#initState)
on the state object. A subclass of
[`State`](http://docs.flutter.io/flutter/material/State-class.html) can
override
[`initState`](http://docs.flutter.io/flutter/material/State-class.html#initState)
to do work that needs to happen just once. For example, you can override
[`initState`](http://docs.flutter.io/flutter/material/State-class.html#initState)
to configure animations or to subscribe to platform services. Implementations of
[`initState`](http://docs.flutter.io/flutter/material/State-class.html#initState)
are required to start by calling
[`super.initState`](http://docs.flutter.io/flutter/material/State-class.html#initState).

When a state object is no longer needed, the framework calls
[`dispose`](http://docs.flutter.io/flutter/material/State-class.html#dispose)
on the state object. You can override the
[`dispose`](http://docs.flutter.io/flutter/material/State-class.html#dispose)
function to do cleanup work. For example, you can override
[`dispose`](http://docs.flutter.io/flutter/material/State-class.html#dispose)
to cancel timers or to unsubscribe from platform services. Implementations of
[`dispose`](http://docs.flutter.io/flutter/material/State-class.html#dispose)
typically end by calling
[`super.dispose`](http://docs.flutter.io/flutter/material/State-class.html#dispose).

Keys
----

You can use keys to control which widgets the framework will match up with which
other widgets when a widget rebuilds. By default, the framework matches
widgets in the current and previous build according to their
[`runtimeType`](http://docs.flutter.io/flutter/material/Widget-class.html#runtimeType)
and the order in which they appear. With keys, the framework requires that the
two widgets have the same
[`key`](http://docs.flutter.io/flutter/material/Widget-class.html#key) as
well as the same
[`runtimeType`](http://docs.flutter.io/flutter/material/Widget-class.html#runtimeType).

Keys are most useful in widgets that build many instances of the same type of
widget. For example, the `ShoppingList` widget, which builds just enough
`ShoppingListItem` instances to fill its visible region:

 * Without keys, the first entry in the current build would always sync with the
   first entry in the previous build, even if, semantically, the first entry in
   the list just scrolled off screen and is no longer visible in the viewport.

 * By assigning each entry in the list a "semantic" key, the infinite list can
   be more efficient because the framework will sync entries with matching
   semantic keys and therefore similar (or identical) visual appearances.
   Moreover, syncing the entries semantically means that state retained in
   stateful child widgets will remain attached to the same semantic entry rather
   than the entry in the same numerical position in the viewport.

Global Keys
-----------

You can use global keys to uniquely identify child widgets. Global keys must be
globally unique across the entire widget hierarchy, unlike local keys which need
only be unique among siblings. Because they are globally unique, a global key
can be used to retrieve the state associated with a widget.

Some widgets, such as
[`Input`](http://docs.flutter.io/flutter/material/Input-class.html) require
global keys because they can hold focus, which means they receive any text the
user enters into the app. The
[`Focus`](http://docs.flutter.io/flutter/material/Focus-class.html) widget
keeps track of which
[`InputState`](http://docs.flutter.io/flutter/material/InputState-class.html)
object is focused by remembering its
[`GlobalKey`](http://docs.flutter.io/flutter/material/GlobalKey-class.html).
That way the same
[`Input`](http://docs.flutter.io/flutter/material/Input-class.html) widget
remains focused even if it moves around in the widget tree.
