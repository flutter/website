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
        left: new IconButton(icon: 'navigation/menu'),
        center: new Text('Example title'),
        right: [ new IconButton(icon: 'action/search') ]
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

Change notifications, in contrast, flow "up" the component hierarchy by way of
callbacks. For example, consider the `ShoppingListItem` widget below:

```dart
class Product {
  const Product({ this.name });
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessComponent {
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
          color: Colors.black54, decoration: lineThrough);
    }
    return null;
  }

  Widget build(BuildContext context) {
    return new ListItem(
      onTap: () => onCartChanged(product, !inCart),
      left: new CircleAvatar(
        backgroundColor: _getColor(context),
        label: product.name[0]
      ),
      center: new Text(product.name, style: _getTextStyle(context))
    );
  }
}
```

The `ShoppingListItem` component follows a common pattern for stateless
components. It stores the values it receives in its constructor in `final`
member variables, which it then uses during its `build` function. For example,
the `inCart` boolean to toggle between two visual appearances: one that uses the
primary color from the current theme and another that uses gray.

When the user taps the list item, the component doesn't modify its `inCart`
value directly. Instead, the component calls the `onCartChanged` function it
received from its parent component. This pattern lets you store state higher in
the component hierarchy, which causes the state to persist for longer periods of
time. In the extreme, the state stored on the component passed to `runApp`
persists for the lifetime of the application.

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

class ShoppingListItem extends StatelessComponent {
  ShoppingListItem({ Product product, bool inCart, Function onCartChanged });
  Widget build(BuildContext context) => null;
}
-->
```dart
class ShoppingList extends StatefulComponent {
  ShoppingList({ Key key, this.products }) : super(key: key);

  final List<Product> products;

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

  Widget build(BuildContext context)  {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text('Shopping List')
      ),
      body: new MaterialList<Product>(
        type: MaterialListType.oneLineWithAvatar,
        items: config.products,
        itemBuilder: (BuildContext context, Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged
          );
        }
      )
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'Shopping List',
    routes: {
      '/': (RouteArguments args) => new ShoppingList(
        products: [
          new Product(name: 'Eggs'),
          new Product(name: 'Flour'),
          new Product(name: 'Chocolate chips'),
        ]
      )
    }
  ));
}
```

The `ShoppingList` class extends `StatefulComponent`, which means this component
stores mutable state. When the `ShoppingList` component is first inserted into
the tree, the framework calls the `createState` function to create a fresh
instance of `_ShoppingListState` to associate with that location in the tree.
(Notice that we typically name subclasses of `State` with leading underscores to
indicate that they are private implementation details.) When this component's
parent rebuilds, the parent will create a new instance of `ShoppingList`, but
the framework will reuse the `_ShoppingListState` instance that is already in
the tree rather than calling `createState` again.

To access properties of the current `ShoppingList`, the `_ShoppingListState` can
use its `config` property. If the parent rebuilds and creates a new
`ShoppingList`, the `_ShoppingListState` will also rebuild with the new `config`
value. If you wish to be notified when the `config` property changes, you can
override the `didUpdateConfig` function, which is passed the `oldConfig` to let
you compare the old configuration with the current `config`.

When handling the `onCartChanged` callback, the `_ShoppingListState` mutates its
internal state by either adding or removing a product from `_shoppingCart`. To
signal to the framework that it changes its internal state, it wraps those calls
in a `setState` call. Calling `setState` marks this component as dirty and
schedules it to be rebuilt the next time your app needs to update the screen. If
you forget to call `setState` when modifying the internal state of a component,
the framework won't know your component is dirty and might not call the
component's `build` function, which means the user interface might not update to
reflect the changed state.

By managing state in this way, you don't need to write separate code for
creating and updating subcomponents. Instead, you simply implement the build
function, which handles both situations.

initState and dispose
---------------------

After calling `createState` on the StatefulComponent, the framework inserts the
new state object into the tree and then calls `initState` on the state object.
A subclass of `State` can override `initState` to do work that needs to happen
just once. For example, you can override `initState` to configure animations or
to subscribe to platform services. Implementations of `initState` are required
to start by calling `super.initState`.

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
widget. For example, the `ShoppingList` component, which builds just enough
`ShoppingListItem` instances to fill its visible region:

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
can be used to retrieve the state associated with a widget.

Some widgets, such as `Input` require global keys because they can hold focus,
which means they receive any text the user enters into the app. The `Focus`
widget keeps track of which `InputState` object is focused by remembering its
`GlobalKey`. That way the same `Input` widget remains focused even if it moves
around in the widget tree.
