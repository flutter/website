---
title: Introduction to widgets
---

{% comment %} This page needs more cleanup. API references should be accumulated
at the end of the page to avoid repeating links. {% endcomment -%}

{% assign api = site.api | append: '/flutter' -%}

Flutter widgets are built using a modern react-style framework, which takes
inspiration from [React](http://facebook.github.io/react). The central idea is
that you build your UI out of widgets. Widgets describe what their view
should look like given their current configuration and state. When a widget's
state changes, the widget rebuilds its description, which the framework diffs
against the previous description in order to determine the minimal changes
needed in the underlying render tree to transition from one state to the next.

<aside id="note" class="alert alert-info" markdown="1">
**Note:** If you would like to become better acquainted with Flutter by diving
into some code, check out
[Building Layouts in Flutter](/docs/development/ui/layout) and
[Adding Interactivity to Your Flutter App](/docs/development/ui/interactive).
</aside>

## Hello World

The minimal Flutter app simply calls the [runApp()][] function with a widget:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
```

The [runApp()][] function takes the given
[Widget]({{api}}/widgets/Widget-class.html) and makes it the root of the
widget tree. In this example, the widget tree consists of two widgets, the
[Center]({{api}}/widgets/Center-class.html) widget and its child, the
[Text]({{api}}/widgets/Text-class.html) widget. The framework forces the root
widget to cover the screen, which means the text "Hello, world" ends up centered
on screen. The text direction needs to be specified in this instance; when the
MaterialApp widget is used, this is taken care of for you, as demonstrated
later.

When writing an app, you'll commonly author new widgets that are subclasses of
either [StatelessWidget]({{api}}/widgets/StatelessWidget-class.html) or
[StatefulWidget]({{api}}/widgets/StatefulWidget-class.html), depending on
whether your widget manages any state. A widget's main job is to implement a
[build]({{api}}/widgets/StatelessWidget/build.html) function, which describes
the widget in terms of other, lower-level widgets. The framework builds those
widgets in turn until the process bottoms out in widgets that represent the
underlying [RenderObject]({{api}}/rendering/RenderObject-class.html), which
computes and describes the geometry of the widget.

## Basic widgets

Flutter comes with a suite of powerful basic widgets, of which the following are
very commonly used:

 * [Text]({{api}}/widgets/Text-class.html): The
   [Text]({{api}}/widgets/Text-class.html) widget lets you create a run of
   styled text within your application.

 * [Row]({{api}}/widgets/Row-class.html),
   [Column]({{api}}/widgets/Column-class.html): These flex widgets let you
   create flexible layouts in both the horizontal
   ([Row]({{api}}/widgets/Row-class.html)) and vertical
   ([Column]({{api}}/widgets/Column-class.html)) directions. Its design is
   based on the web's flexbox layout model.

 * [Stack]({{api}}/widgets/Stack-class.html): Instead of being linearly
   oriented (either horizontally or vertically), a
   [Stack]({{api}}/widgets/Stack-class.html) widget lets you stack widgets on
   top of each other in paint order. You can then use the
   [Positioned]({{api}}/widgets/Positioned-class.html) widget on children of a
   [Stack]({{api}}/widgets/Stack-class.html) to position them relative to the
   top, right, bottom, or left edge of the stack. Stacks are based on the web's
   absolute positioning layout model.

 * [Container]({{api}}/widgets/Container-class.html): The
   [Container]({{api}}/widgets/Container-class.html) widget lets you create a
   rectangular visual element. A container can be decorated with a
   [BoxDecoration]({{api}}/painting/BoxDecoration-class.html), such as a
   background, a border, or a shadow. A
   [Container]({{api}}/widgets/Container-class.html) can also have margins,
   padding, and constraints applied to its size. In addition, a
   [Container]({{api}}/widgets/Container-class.html) can be transformed in
   three dimensional space using a matrix.

Below are some simple widgets that combine these and other widgets:

```dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        // <Widget> is the type of items in the list.
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child to fill the available space.
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: MyScaffold(),
  ));
}
```

Be sure to have a `uses-material-design: true` entry in the `flutter`
section of your `pubspec.yaml` file. It allows you to use the predefined
set of [Material icons](https://design.google.com/icons/).

```yaml
name: my_app
flutter:
  uses-material-design: true
```

Many widgets need to be inside of a
[MaterialApp]({{api}}/material/MaterialApp-class.html) to display properly, in
order to inherit theme data. Therefore, we run the application with a
[MaterialApp]({{api}}/material/MaterialApp-class.html).

The `MyAppBar` widget creates a
[Container]({{api}}/widgets/Container-class.html) with a height of 56
device-independent pixels with an internal padding of 8 pixels, both on the left
and the right. Inside the container, `MyAppBar` uses a
[Row]({{api}}/widgets/Row-class.html) layout to organize its children. The
middle child, the `title` widget, is marked as
[Expanded]({{api}}/widgets/Expanded-class.html), which means it expands to
fill any remaining available space that hasn't been consumed by the other
children. You can have multiple
[Expanded]({{api}}/widgets/Expanded-class.html) children and determine the
ratio in which they consume the available space using the
[flex]({{api}}/widgets/Expanded-class.html#flex) argument to
[Expanded]({{api}}/widgets/Expanded-class.html).

The `MyScaffold` widget organizes its children in a vertical column. At the top
of the column it places an instance of `MyAppBar`, passing the app bar a
[Text]({{api}}/widgets/Text-class.html) widget to use as its title. Passing
widgets as arguments to other widgets is a powerful technique that lets you
create generic widgets that can be reused in a wide variety of ways. Finally,
`MyScaffold` uses an [Expanded]({{api}}/widgets/Expanded-class.html) to fill
the remaining space with its body, which consists of a centered message.

More information: [Layouts](/docs/development/ui/widgets/layout)

## Using Material Components

Flutter provides a number of widgets that help you build apps that follow
Material Design. A Material app starts with the
[MaterialApp]({{api}}/material/MaterialApp-class.html) widget, which builds a
number of useful widgets at the root of your app, including a
[Navigator]({{api}}/widgets/Navigator-class.html), which manages a stack of
widgets identified by strings, also known as "routes". The
[Navigator]({{api}}/widgets/Navigator-class.html) lets you transition smoothly
between screens of your application. Using the
[MaterialApp]({{api}}/material/MaterialApp-class.html) widget is entirely
optional but a good practice.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: TutorialHome(),
  ));
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('Example title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
```

Now that we've switched from `MyAppBar` and `MyScaffold` to the
[AppBar]({{api}}/material/AppBar-class.html) and
[Scaffold]({{api}}/material/Scaffold-class.html) widgets from `material.dart`,
our app is starting to look at bit more Material. For example, the app bar has a
shadow and the title text inherits the correct styling automatically. We've also
added a floating action button for good measure.

Notice that we're again passing widgets as arguments to other widgets. The
[Scaffold]({{api}}/material/Scaffold-class.html) widget takes a number of
different widgets as named arguments, each of which are placed in the Scaffold
layout in the appropriate place. Similarly, the
[AppBar]({{api}}/material/AppBar-class.html) widget lets us pass in widgets
for the [leading]({{api}}/material/AppBar-class.html#leading) and the
[actions]({{api}}/material/AppBar-class.html#actions) of the
[title]({{api}}/material/AppBar-class.html#title) widget. This pattern recurs
throughout the framework and is something you might consider when designing your
own widgets.

More information: [Material components](/docs/development/ui/widgets/material)

## Handling gestures

Most applications include some form of user interaction with the system. The
first step in building an interactive application is to detect
input gestures. Let's see how that works by creating a simple button:

```dart
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}
```

The [GestureDetector]({{api}}/widgets/GestureDetector-class.html) widget
doesn't have a visual representation but instead detects gestures made by the
user. When the user taps the
[Container]({{api}}/widgets/Container-class.html), the
[GestureDetector]({{api}}/widgets/GestureDetector-class.html) calls its
[onTap]({{api}}/widgets/GestureDetector-class.html#onTap) callback, in this
case printing a message to the console. You can use
[GestureDetector]({{api}}/widgets/GestureDetector-class.html) to detect a
variety of input gestures, including taps, drags, and scales.

Many widgets use a
[GestureDetector]({{api}}/widgets/GestureDetector-class.html) to provide
optional callbacks for other widgets. For example, the
[IconButton]({{api}}/material/IconButton-class.html),
[RaisedButton]({{api}}/material/RaisedButton-class.html), and
[FloatingActionButton]({{api}}/material/FloatingActionButton-class.html)
widgets have [onPressed]({{api}}/material/RaisedButton-class.html#onPressed)
callbacks that are triggered when the user taps the widget.

More information: [Gestures in Flutter](/docs/development/ui/advanced/gestures)

## Changing widgets in response to input

Thus far, we've used only stateless widgets. Stateless widgets receive arguments
from their parent widget, which they store in
[final](https://www.dartlang.org/guides/language/language-tour#final-and-const)
member variables. When a widget is asked to
[build]({{api}}/widgets/StatelessWidget/build.html), it uses these stored
values to derive new arguments for the widgets it creates.

In order to build more complex experiences&mdash;for example, to react in more
interesting ways to user input&mdash;applications typically carry some state.
Flutter uses StatefulWidgets to capture this idea. StatefulWidgets are special
widgets that know how to generate State objects, which are then used to hold
state. Consider this basic example, using the
[RaisedButton]({{api}}/material/RaisedButton-class.html) mentioned earlier:

```dart
class Counter extends StatefulWidget {
  // This class is the configuration for the state. It holds the
  // values (in this case nothing) provided by the parent and used by the build
  // method of the State. Fields in a Widget subclass are always marked "final".

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If we changed _counter without calling
      // setState(), then the build method would not be called again,
      // and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance
    // as done by the _increment method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return Row(
      children: <Widget>[
        RaisedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
        Text('Count: $_counter'),
      ],
    );
  }
}
```

You might wonder why StatefulWidget and State are separate objects. In Flutter,
these two types of objects have different life cycles. Widgets are temporary
objects, used to construct a presentation of the application in its current
state. State objects on the other hand are persistent between calls to
[build()]({{api}}/widgets/State/build.html), allowing them to remember
information.

The example above accepts user input and directly uses the result in its
build method.  In more complex applications, different parts of the widget
hierarchy might be responsible for different concerns; for example, one
widget might present a complex user interface with the goal of gathering
specific information, such as a date or location, while another widget might
use that information to change the overall presentation.

In Flutter, change notifications flow "up" the widget hierarchy by way of
callbacks, while current state flows "down" to the stateless widgets that do
presentation. The common parent that redirects this flow is the State.
The following slightly more complex example shows how this works in practice:


```dart
class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      CounterIncrementor(onPressed: _increment),
      CounterDisplay(count: _counter),
    ]);
  }
}
```

Notice how we created two new stateless widgets, cleanly separating
the concerns of _displaying_ the counter (CounterDisplay) and _changing_
the counter (CounterIncrementor).
Although the net result is the same as the previous example, the separation of
responsibility allows greater complexity to be encapsulated in the individual
widgets, while maintaining simplicity in the parent.

More information:

- [StatefulWidget]({{api}}/widgets/StatefulWidget-class.html)
- [State.setState]({{api}}/widgets/State/setState.html)

## Bringing it all together

What follows is a more complete example that brings together the concepts
introduced above: A hypothetical shopping application displays various
products offered for sale, and maintains a shopping cart for
intended purchases. Start by defining the presentation class,
`ShoppingListItem`:

```dart
class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}
```

The `ShoppingListItem` widget follows a common pattern for stateless widgets. It
stores the values it receives in its constructor in
[final](https://www.dartlang.org/guides/language/language-tour#final-and-const)
member variables, which it then uses during its
[build]({{api}}/widgets/StatelessWidget/build.html) function. For example, the
`inCart` boolean toggles between two visual appearances: one that uses the
primary color from the current theme, and another that uses gray.

When the user taps the list item, the widget doesn't modify its `inCart` value
directly. Instead, the widget calls the `onCartChanged` function it received
from its parent widget. This pattern lets you store state higher in the widget
hierarchy, which causes the state to persist for longer periods of time. In the
extreme, the state stored on the widget passed to
[runApp()][] persists for the lifetime of the
application.

When the parent receives the `onCartChanged` callback, the parent updates its
internal state, which triggers the parent to rebuild and create a new instance
of `ShoppingListItem` with the new `inCart` value. Although the parent creates a
new instance of `ShoppingListItem` when it rebuilds, that operation is cheap
because the framework compares the newly built widgets with the previously built
widgets and applies only the differences to the underlying
[RenderObject]({{api}}/rendering/RenderObject-class.html).

Here's an example parent widget that stores mutable state:

<!--
class Product {
  const Product({this.name});
  final String name;
}

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, bool inCart, Function onCartChanged});
  @override
  Widget build(BuildContext context) => null;
}
-->
```dart
class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  // The framework calls createState the first time a widget appears at a given
  // location in the tree. If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses the State object
  // instead of creating a new State object.

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When a user changes what's in the cart, we need to change _shoppingCart
      // inside a setState call to trigger a rebuild. The framework then calls
      // build, below, which updates the visual appearance of the app.

      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Shopping App',
    home: ShoppingList(
      products: <Product>[
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    ),
  ));
}
```

The `ShoppingList` class extends
[StatefulWidget]({{api}}/widgets/StatefulWidget-class.html), which means this
widget stores mutable state. When the `ShoppingList` widget is first inserted
into the tree, the framework calls the
[createState]({{api}}/widgets/StatefulWidget-class.html#createState) function
to create a fresh instance of `_ShoppingListState` to associate with that
location in the tree. (Notice that subclasses of
[State]({{api}}/widgets/State-class.html) are typically named with leading
underscores to indicate that they are private implementation details.) When this
widget's parent rebuilds, the parent creates a new instance of `ShoppingList`,
but the framework reuses the `_ShoppingListState` instance that is already in
the tree rather than calling
[createState]({{api}}/widgets/StatefulWidget-class.html#createState) again.

To access properties of the current `ShoppingList`, the `_ShoppingListState` can
use its [widget]({{api}}/widgets/State-class.html#widget) property. If the
parent rebuilds and creates a new `ShoppingList`, the `_ShoppingListState`
rebuilds with the new [widget]({{api}}/widgets/State-class.html#widget) value.
If you wish to be notified when the
[widget]({{api}}/widgets/State-class.html#widget) property changes, you can
override the
[didUpdateWidget]({{api}}/widgets/State-class.html#didUpdateWidget) function,
which is passed `oldWidget` to let you compare the old widget with the current
[widget]({{api}}/widgets/State-class.html#widget).

When handling the `onCartChanged` callback, the `_ShoppingListState` mutates its
internal state by either adding or removing a product from `_shoppingCart`. To
signal to the framework that it changed its internal state, it wraps those calls
in a [setState]({{api}}/widgets/State-class.html#setState) call. Calling
[setState]({{api}}/widgets/State-class.html#setState) marks this widget as
dirty and schedules it to be rebuilt the next time your app needs to update the
screen. If you forget to call
[setState]({{api}}/widgets/State-class.html#setState) when modifying the
internal state of a widget, the framework won't know your widget is dirty and
might not call the widget's
[build]({{api}}/widgets/StatelessWidget/build.html) function, which means the
user interface might not update to reflect the changed state.

By managing state in this way, you don't need to write separate code for
creating and updating child widgets. Instead, you simply implement the build
function, which handles both situations.

## Responding to widget lifecycle events

After calling
[createState]({{api}}/widgets/StatefulWidget-class.html#createState) on the
StatefulWidget, the framework inserts the new state object into the tree and
then calls [initState]({{api}}/widgets/State-class.html#initState) on the
state object. A subclass of [State]({{api}}/widgets/State-class.html) can
override [initState]({{api}}/widgets/State-class.html#initState) to do work
that needs to happen just once. For example, you can override
[initState]({{api}}/widgets/State-class.html#initState) to configure
animations or to subscribe to platform services. Implementations of
[initState]({{api}}/widgets/State-class.html#initState) are required to start
by calling [super.initState]({{api}}/widgets/State-class.html#initState).

When a state object is no longer needed, the framework calls
[dispose]({{api}}/widgets/State-class.html#dispose) on the state object. You
can override the [dispose]({{api}}/widgets/State-class.html#dispose) function
to do cleanup work. For example, you can override
[dispose]({{api}}/widgets/State-class.html#dispose) to cancel timers or to
unsubscribe from platform services. Implementations of
[dispose]({{api}}/widgets/State-class.html#dispose) typically end by calling
[super.dispose]({{api}}/widgets/State-class.html#dispose).

More information: [State]({{api}}/widgets/State-class.html)

## Keys

You can use keys to control which widgets the framework matches up with other
widgets when a widget rebuilds. By default, the framework matches widgets in the
current and previous build according to their
[runtimeType]({{api}}/widgets/Widget-class.html#runtimeType) and the order in
which they appear. With keys, the framework requires that the two widgets have
the same [key]({{api}}/widgets/Widget-class.html#key) as well as the same
[runtimeType]({{api}}/widgets/Widget-class.html#runtimeType).

Keys are most useful in widgets that build many instances of the same type of
widget. For example, the `ShoppingList` widget, which builds just enough
`ShoppingListItem` instances to fill its visible region:

 * Without keys, the first entry in the current build would always sync with the
   first entry in the previous build, even if, semantically, the first entry in
   the list just scrolled off screen and is no longer visible in the viewport.

 * By assigning each entry in the list a "semantic" key, the infinite list can
   be more efficient because the framework syncs entries with matching
   semantic keys and therefore similar (or identical) visual appearances.
   Moreover, syncing the entries semantically means that state retained in
   stateful child widgets remains attached to the same semantic entry rather
   than the entry in the same numerical position in the viewport.

More information: [Key API]({{api}}/foundation/Key-class.html)

## Global Keys

You can use global keys to uniquely identify child widgets. Global keys must be
globally unique across the entire widget hierarchy, unlike local keys which need
only be unique among siblings. Because they are globally unique, a global key
can be used to retrieve the state associated with a widget.

More information: [GlobalKey API]({{api}}/widgets/GlobalKey-class.html)

[runApp()]: {{api}}/widgets/runApp.html