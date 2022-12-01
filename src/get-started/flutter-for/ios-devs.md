---
title: Flutter for iOS developers
description: Learn how to apply iOS developer knowledge when building Flutter apps.
---

<?code-excerpt path-base="get-started/flutter-for/ios_devs"?>

{% assign sample_path = "get-started/flutter-for/ios_devs" %}

This document is for iOS developers looking to apply
their existing iOS knowledge to build mobile apps with Flutter.
If you understand the fundamentals of the iOS framework
then you can use this document as a
way to get started learning Flutter development.

{{site.alert.note}}
  To integrate Flutter code into your **existing** iOS app, see
  [Add Flutter to existing app][].
{{site.alert.end}}

<!-- Add this blurb once published -->
<!-- Flutter is a framework for building cross-platform applications
that uses the Dart programming language. 
To understand some differences between programming with Dart
and programming with Swift, see [Learning Dart as a Swift Developer][] 
and [Comparing Dart Concurrency with Swift][]. -->


Your iOS knowledge and skill set
are highly valuable when building with Flutter, 
because Flutter relies on the mobile operating system
for numerous capabilities and configurations.
Flutter is a new way to build UIs for mobile,
but it has a plugin system to communicate
with iOS (and Android) for non-UI tasks.
<!-- Add this sentence once published -->
<!-- Learn more at [iOS and Apple hardware interactions with Flutter][] -->

Flutter also already makes a number of adaptations
in the framework for you when running on iOS.
For a list, see [Platform adaptations][].

This document can be used as a cookbook by jumping around
and finding questions that are most relevant to your needs.
This guide embeds sample code. 
You can test full working examples on DartPad or view them on GitHub.

<!-- Embed intro to iOS video when published -->

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="editor-setup" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="swiftui-tab" href="#swiftui" role="tab" aria-controls="swiftui" aria-selected="true">SwiftUI</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="uikit-tab" href="#uikit" role="tab" aria-controls="uikit" aria-selected="false">UIKit</a>
  </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="swiftui" role="tabpanel" aria-labelledby="swiftui-tab" markdown="1">


## SwiftUI Overview

This section gives an overview of the core similarities 
and differences between SwiftUI and Flutter.

### Views vs. Widgets

Flutter and SwiftUI code describes how the UI looks and works. 
Developers call this type of code a _declarative framework_.

In SwiftUI, you use **_views_** 
to represent parts of your app's UI, 
and you can provide modifiers that are used to configure those views. 

<img src="/assets/images/docs/get-started/ios/swiftui-modifiers.png" alt="SwiftUI Text view uses a padding modifier">

Flutter is similar in that it uses **_widgets_** 
to represent parts of your app's UI. Both views and widgets are immutable, 
meaning they only exist until they need to be changed. 
Additionally, both SwiftUI and Flutter are designed to use composition 
rather than inheritance. However, Flutter uses individual widget classes 
for many aspects of the UI. This means that properties 
that might normally be represented as modifiers in SwiftUI 
are instead represented as separate widgets in Flutter. 

<img src="/assets/images/docs/get-started/ios/flutter-widgets.png" alt="Flutter Text Widget is encapsulated by a Padding widget">

In both SwiftUI and Flutter, 
layouts are composed by nesting views or widgets, 
respectively, within one another.

### Layout process

SwiftUI lays out views using the following process:

1. The parent view proposes some size to the child view.
1. The child decides the size it requires by going through 
this same process with its own list of children. 
It passes down the proposed size and 
asks its child what size it wishes to be. 
It then returns the size it requires to its parent.
1. The parent lays out the child, respecting the size that the child requested.

Flutter differs somewhat with its process:

1. The parent widget passes constraints down to its children 
(maximum height and width, and minimum height and width). 
1. The child attempts to decide its size 
by going through this same process with its own list of children. 
It tells its child what its constraints are, 
and asks it what size it wishes to be. 
1. The parent lays out the child, ensuring that it’s within the original constraints.

Flutter differs in how the parent widget asserts its size and
can overrule the child’s desired size. 
To force a child to be a specific size, the parent can use tight 
constraints. Consider a constraint tight when its minimum value
equals its maximum value.

In SwiftUI, views can choose to expand to the space that the parent 
has said is available, or choose to be the size of its content. 
Flutter widgets behave similarly. 
However, parents can offer unbounded constraints, where one or both 
of the maximum values is infinity. 
In these cases, if the child is expanding, 
you will get an overflow warning, as shown below:


```dart
UnconstrainedBox(
  child: Container(color: red, width: 4000, height: 50),
)
```

<img src="/assets/images/docs/ui/layout/layout-14.png" alt="When parents pass unbounded constraints to children, and the children are expanding, then there is an overflow warning">

To learn how constraints work in Flutter, 
see [Understanding constraints][]. 


### Design system

As Flutter targets multiple platforms, your app doesn’t need to conform to any design system. 
Though many examples in this documentation feature [Material][] widgets, your Flutter app can use many different design systems. Your app can use:

- Custom Material widgets
- Community built widgets
- Your own custom widgets
- [Cupertino widgets][] that follow Apple’s Human Interface Guidelines

<iframe width="560" height="315" src="{{site.youtube-site}}/embed/3PdUaidHc-E?rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

If you're looking for a great reference app that features a custom design system, check out [Wonderous][].

## UI Basics

This section covers how basic UI components in Flutter compare to those in SwiftUI. 
This includes how to start your app, display static text, 
create buttons, react to on-press events, display lists, grids, and more.


### Getting started

Usually, when you implement your SwiftUI app, you begin with **App:**

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
    }
}
```

The body is usually created in a struct that conforms to the **View** protocol as follows:

```swift
struct HomePage: View {
  var body: some View {
    Text("Hello, World!")
  }
}
```

To start your Flutter app, pass in an instance of your app to the `runApp` function. 

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=d3d38ae68f7d6444421d0485a1fd02db">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/get_started.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/get_started.dart (main)"?>
```dart
void main() {
  runApp(const MyApp());
}
```

`App` is itself a widget, and the build method describes the part of the user interface it represents.
It’s common to begin your app with a [`WidgetApp`][] class, like [`CupertinoApp`][].

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=d3d38ae68f7d6444421d0485a1fd02db">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/get_started.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/get_started.dart (myapp)"?>
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns a CupertinoApp that, by default,
    // has the look and feel of an iOS app.
    return const CupertinoApp(
      home: HomePage(),
    );
  }
}
```

The widget used in `home` might begin with the `Scaffold` class 
that accepts a widget as its body:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=d3d38ae68f7d6444421d0485a1fd02db">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/get_started.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/get_started.dart (homepage)"?>
```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, World!',
        ),
      ),
    );
  }
}
```

One thing to note is the use of the [`Center`][] widget. In SwiftUI, 
a view's contents are rendered in its center by default, 
but in Flutter that’s not always the case. In the example, 
the `Scaffold` widget implements a basic layout structure for an app.
However, `Scaffold` doesn’t render its `body` widget at the center of the screen. 
So, to center the text, you have to wrap it with a `Center` widget. 
You can learn more about the different widgets and their default behaviors 
by looking through the [Widget catalog][].


### Adding Buttons

In SwiftUI, you create a button using the `Button` struct, as shown here:

```swift
Button("Do something") {
  // this closure gets called when your
  // button is tapped
}
```

To achieve the same  you can use the `CupertinoButton` class, as follows:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=b776dfe43c91e580c66b2b93368745eb">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/text_button.dart">View on GitHub</a>
  </li>
</ul>
</nav>


<?code-excerpt "lib/text_button.dart (textbutton)"?>
```dart
        CupertinoButton(
  onPressed: () {
    // This closure is called when your button is tapped.
  },
  child: const Text('Do something'),
)
```

In SwiftUI if you want a button, then you must use the `Button` struct. 
But with Flutter you have access to a variety of buttons with predefined styles. 
The [`CupertinoButton`][] class comes from the Cupertino library 
that was previously referenced, and exhibits Apple's styling.

### Aligning components horizontally

In SwiftUI, stack views play a big part in designing your layouts. 
That's why there are two separate structures that allow you to create stacks:

1. `HStack` for horizontal stack views

2. `VStack` for vertical stack views

The following SwiftUI view adds a globe image and a text to a horizontal stack view:


```swift
HStack {
  Image(systemName: "globe")
  Text("Hello, world!")
}
```

The equivalent of `HStack` in Flutter is [`Row`][],
which lays out its children horizontally:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=5715d4f269f629d274ef1b0e9546853b">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/row.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/row.dart (row)"?>
```dart
    Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    Icon(CupertinoIcons.globe),
    Text('Hello, world!'),
  ],
),
```

In Flutter, the `Row` widget explicitly requires the 
`children` parameter, 
and expects a `List<Widget>`.The `mainAxisAlignment` 
property tells Flutter how to position children 
with extra space. `MainAxisAlignment.center` means that 
children are positioned in the middle of the main axis. 
For `Row` the main axis is the horizontal axis.

### Aligning components vertically

The following example builds on the previous, 
but this time arranging the components vertically using `VStack`:

```swift
VStack {
  Image(systemName: "globe")
  Text("Hello, world!")
}
```

In Flutter– all your Dart code stays the same as the previous example, 
except for changing `Row` to [`Column`][]:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=5e85473354959c0712f05e86d111c584">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/column.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/column.dart (column)"?>
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    Icon(CupertinoIcons.globe),
    Text('Hello, world!'),
  ],
),
```


### Displaying a list view

In SwiftUI, the base component for displaying lists is `List`. 
Many times, you have a list of model objects you want to display to the user. 
In those cases, you need to ensure that your model objects 
are identifiable using the `Identifiable` protocol as follows:

```swift
struct Person: Identifiable {
  var name: String
}

var persons = [
  Person(name: "Person 1"),
  Person(name: "Person 2"),
  Person(name: "Person 3"),
]

struct ListWithPersons: View {
  let persons: [Person]
  var body: some View {
    List {
      ForEach(persons) { person in
        Text(person.name)
      }
    }
  }
}
```

This is similar to how Flutter prefers to build its list widgets, 
although Flutter doesn't need the list items to be identifiable. 
All you have to do is specify the number of items to display 
and build a widget for each item.

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=66e6728e204021e3b9e0190be50d014b">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/list.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/list.dart (SimpleList)"?>
```dart
class Person {
  String name;
  Person(this.name);
}

var items = [
  Person('Person 1'),
  Person('Person 2'),
  Person('Person 3'),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
          );
        },
      ),
    );
  }
}
```

There are a few things to note about this example in Flutter:

* The [`ListView`] widget has a builder method, 
this operates in a similar way 
to the ForEach inside of SwiftUI's `List` struct

* The `itemCount` parameter of the `ListView` 
dictates how many items need to be displayed and 
rendered by the `ListView`.

* The `itemBuilder` gets called with an index from 
(and including) 0, up to (and excluding) the item 
count—and must return a `Widget` instance per item.

In this example, a [`ListTile`][] is returned for each item. 
The `ListTile` widget has some intrinsic properties 
like height and font-size that might be helpful 
in building a list. However, you're able to return 
almost any widget that represents your data.


### Displaying a grid

In SwiftUI, when constructing non-conditional 
grids, you use `Grid` with `GridRow`. 

```swift
Grid {
  GridRow {
    Text("Row 1")
    Image(systemName: "square.and.arrow.down")
    Image(systemName: "square.and.arrow.up")
  }
  GridRow {
    Text("Row 2")
    Image(systemName: "square.and.arrow.down")
    Image(systemName: "square.and.arrow.up")
  }
}
```

To display grids in Flutter, you use the [`GridView`] widget. 
This widget has various constructors, 
each of which achieves more or less the same goal 
but with different input parameters. 
This example uses the `.builder()` initializer:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=4ac2d2433390042d25c97f1e819ec337">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/grid.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/grid.dart (GridExample)"?>
```dart
const widgets = [
  Text('Row 1'),
  Icon(CupertinoIcons.arrow_down_square),
  Icon(CupertinoIcons.arrow_up_square),
  Text('Row 2'),
  Icon(CupertinoIcons.arrow_down_square),
  Icon(CupertinoIcons.arrow_up_square),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 40.0,
        ),
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index],
      ),
    );
  }
}
```

The `SliverGridDelegateWithFixedCrossAxisCount` 
delegate determines various parameters that the grid  
uses to lay out its components, 
such as `crossAxisCount`, which is the number of items 
per row that is displayed horizontally, and `mainAxisExtent`, 
which dictates the number of pixels each row must have.

One distinction between SwiftUI's `Grid` and Flutter's `GridView` 
is that in SwiftUI the `Grid` is fed with instances of `GridRow`, 
but in Flutter `GridView` uses the delegate to decide 
how the grid should lay out its components.


### Creating a scroll view

In SwiftUI, to create custom scrolling components, 
you would use `ScrollView`. 
The following example displays a series of `PersonView` 
instances on the screen in a vertically scrollable fashion:

```swift
ScrollView {
  VStack(alignment: .leading) {
    ForEach(persons) { person in
      PersonView(person: person)
    }
  }
}
```

The closest equivalent of `ScrollView` in Flutter is 
[`SingleChildScrollView`][]. 
In the following example, the function `mockPerson` mocks up instances 
of the defined `Person` class to 
create the custom `PersonView` widget:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=63039c5371995ae53d971d613a936f7b">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/scroll.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/scroll.dart (ScrollExample)"?>
```dart
    SingleChildScrollView(
  child: Column(
    children: mockPersons
        .map(
          (person) => PersonView(
            person: person,
          ),
        )
        .toList(),
  ),
),
```

### Responsive and adaptive design

In SwiftUI, you often use `GeometryReader` to create relative view sizes. 
For example by setting the _width _to `geometry.size.width` multiplied by 
some factor, or using it as a breakpoint to change the design of your app. 
Alternatively, you can use environments such as `horizontalSizeClass` 
that tell you if the size class is `.regular` or `.compact`.

In Flutter, you can take a similar approach 
using the [`LayoutBuilder`][] class to get the `BoxConstraints` object, 
or the [`MediaQuery.of()`][] in your build functions to get the size and 
orientation of your current app. For more information, check out 
[Creating responsive and adaptive apps][]. 


### Managing state

In SwiftUI, the `@State` property wrapper is used to represent the 
internal state of a SwiftUI view, as follows: 

```swift
struct ContentView: View {
  @State private var counter = 0;
  var body: some View {
    VStack{
      Button("+") { counter+=1 }
      Text(String(counter))
    }
  }}
```

SwiftUI also has several options for more complex state management. 
For example, the `ObservableObject` protocol. 

Flutter manages local state using a [`StatefulWidget`][]. 
A stateful widget is implemented by two classes: 
a subclass of `StatefulWidget` 
and a subclass of `State`, 
with the state of the widget stored in the `State` object. 
When a widget’s state changes, the state object calls `setState()`, 
telling the framework to redraw the widget. 
The following example shows components of a similar 
counter app to the one created previously:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=c5fcf5897c21456c518ea954c2587ada">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/state.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/state.dart (State)"?>
```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter'),
            TextButton(
              onPressed: () => setState(() {
                _counter++;
              }),
              child: const Text('+'),
            ),
          ],
        ),
      ),
    );
  }
}
```

For information on other ways to manage state, see [State management][].

### Animations

There are two main types of UI animations. Implicit, 
which have a current and new value to animate to. And explicit, 
which animate when explicitly asked to.

In SwiftUI implicit animations are handled by the `animate()` modifier, 
as follows:

```swift
Button(“Tap me!”){
   angle += 45
}
.rotationEffect(.degrees(angle))
.animation(.easeIn(duration: 1))
```

In Flutter, there are built-in widgets that make it easy to 
implicitly animate commonly used widgets. These are named `AnimatedFoo`. 
For example, to rotate a button you can use the 
[`AnimatedRotation`][] class, which animates the 
`Transform.rotate` widget.

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=4b9cfedfe9ca09baeb83456fdf7cbe32">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/simple_animation.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/simple_animation.dart (AnimatedButton)"?>
```dart
AnimatedRotation(
  duration: const Duration(seconds: 1),
  turns: turns,
  curve: Curves.easeIn,
  child: TextButton(
      onPressed: () {
        setState(() {
          turns += .125;
        });
      },
      child: const Text('Tap me!')),
),
```

SwiftUI and Flutter take a similar approach, 
where you can specify parameters like `duration`, and `curve`. 
If there's no built-in widget for what you're trying to do, 
you can use the [`TweenAnimationBuilder`][] to easily 
compose an animated widget.

When it comes to explicit animations, 
SwiftUI uses the `withAnimation{}` closure. Flutter, 
on the other hand, 
has built in explicitly animated widgets called `FooTransition`. 
For example, the [`RotationTransition`][] class. 
If there's no built-in widget for what you're trying to do,
you can use an `AnimatedWidget` for a standalone widget, 
or `AnimatedBuilder` in another widget’s build method

To learn more about animations in Flutter, see [Animations overview][].

### Drawing on the Screen

On iOS, you use `CoreGraphics` to draw lines and shapes to the
screen. Flutter has a different API based on the `Canvas` class,
with two other classes that help you draw. [`CustomPaint`][], which requires a painter:


<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=fccb26fc4bca4c08ca37931089a837e7">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/canvas.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/canvas.dart (CustomPaint)"?>
```dart
CustomPaint(
  painter: SignaturePainter(_points),
  size: Size.infinite,
),
```

And [`CustomPainter`][], which implements your algorithm to draw to the canvas.

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=fccb26fc4bca4c08ca37931089a837e7">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/canvas.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/canvas.dart (CustomPainter)"?>
```dart
class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
```

## Navigation

This section of the document discusses navigation 
between pages of an app, the push and pop mechanism, and more.

### Navigating between pages
iOS and macOS apps are usually built with different pages or navigation routes. 
In SwiftUI, this stack of pages is represented by the `NavigationStack` struct,
and contains `NavigationLink` structs. 

The next example creates an application that displays a list of persons, 
and tapping each person displays that person's details in a new navigation link. 


```swift
NavigationStack(path: $path) {
      List {
        ForEach(persons) { person in
          NavigationLink(
            person.name,
            value: person
          )
        }
      }
      .navigationDestination(for: Person.self) { person in
        PersonView(person: person)
      }
    }
```

In Flutter, small applications without complex deep linking can use [`Navigator`][] 
with named routes, as shown below. After defining your navigation routes, 
you can call upon your navigation routes using their names. 

First, name each route in the class passed to the 
`runApp()` function, in this case `App`:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=5ae0624689958c4775b064d39d108d9e">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/navigation.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/navigation.dart (Routes)"?>
```dart
// Defines the route name as a constant
// so that it's reusable.
const detailsPageRouteName = '/details';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const HomePage(),
      // The [routes] property defines the available named routes
      // and the widgets to build when navigating to those routes.
      routes: {
        detailsPageRouteName: (context) => const DetailsPage(),
      },
    );
  }
}
```

The following sample generates a list of persons 
mocked using `mockPersons()`.
Once the user taps on any person, `pushNamed()` pushes the person's detail page 
to the `Navigator`.

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=5ae0624689958c4775b064d39d108d9e">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/navigation.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/navigation.dart (ListView)"?>
```dart
ListView.builder(
  itemCount: mockPersons.length,
  itemBuilder: (context, index) {
    final person = mockPersons.elementAt(index);
    final age = '${person.age} years old';
    return ListTile(
      title: Text(person.name),
      subtitle: Text(age),
      trailing: const Icon(
        Icons.arrow_forward_ios,
      ),
      onTap: () {
        // When a [ListTile] that represents a person is
        // tapped, push the detailsPageRouteName route
        // to the Navigator and pass the person's instance
        // to the route.
        Navigator.of(context).pushNamed(
          detailsPageRouteName,
          arguments: person,
        );
      },
    );
  },
),
```

Next, define the `DetailsPage` widget responsible for 
displaying the details of each person. In Flutter, arguments can be 
dynamically passed into the widget, when navigating to the new route, 
and extracted using `ModalRoute.of()`:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=5ae0624689958c4775b064d39d108d9e">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/navigation.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/navigation.dart (DetailsPage)"?>
```dart
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the person instance from the arguments.
    final Person person = ModalRoute.of(
      context,
    )?.settings.arguments as Person;
    // Extract the age.
    final age = '${person.age} years old';
    return Scaffold(
      // Display name and age.
      body: Column(children: [Text(person.name), Text(age)]),
    );
  }
}
```

For more advanced navigation and routing requirements, 
you should use a routing package such as [go_router][]. 
You can find more details at Navigation in Flutter.  

### Manually pop back

In SwiftUI, for situations where a view needs 
to perform a manual pop-back to the previous screen,
use the `dismiss` environment value as follows:

```swift
Button("Pop back") {
        dismiss()
      }
```

In Flutter, to achieve the same effect, use the `pop()` 
function of the `Navigator` class as follows:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=0cf352feaeaea2eb107f784d879e480d">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/popback.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/popback.dart (PopBackExample)"?>
```dart
TextButton(
  onPressed: () {
    // This code allows the
    // view to pop back to its presenter.
    Navigator.of(context).pop();
  },
  child: const Text('Pop back'),
),
```

### Navigating to another app

In SwiftUI, to open a URL to another application,
use the `openURL` environment variable, as follows:

```swift
@Environment(\.openURL) private var openUrl

// View code goes here

 Button("Open website") {
      openUrl(
        URL(
          string: "https://google.com"
        )!
      )
    }
```

To achieve the same results in Flutter use the [`url_launcher`][] plugin. 

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/openapp.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/openapp.dart (OpenAppExample)"?>
```dart
    CupertinoButton(
  onPressed: () async {
    await launchUrl(
      Uri.parse('https://google.com'),
    );
  },
  child: const Text(
    'Open website',
  ),
),
```

## Themes, styles, and media
Flutter applications are easy to style; you can switch 
between light and dark themes, 
change the style of your text and UI components, 
and more. This section covers aspects of styling your Flutter apps 
and compares how you might do the same in SwiftUI.

### Using dark mode
In SwiftUI, if you want to use dark mode for your views, 
you can call the `preferredColorScheme()` function that is implemented 
on a `View`.
    
In Flutter, you control light and dark mode at the app-level 
using the `theme` property of your `App` class as follows:


<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
 <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=c446775c3224787e51fb18b054a08a1c">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/cupertino_themes.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/cupertino_themes.dart (Theme)"?>
```dart
    CupertinoApp(
  theme: CupertinoThemeData(
    brightness: Brightness.dark,
  ),
  home: HomePage(),
);
```

### Styling text
In SwiftUI, you use modifier functions to style text. 
For example, you can change the font of a `Text` string 
using the `font()` modifier with different parameters.

```swift
Text("Hello, world!")
  .font(.system(size: 30, weight: .heavy))
  .foregroundColor(.yellow)
```

In Flutter, you style text with the `style` 
parameter of the `Text` widget as follows:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
 <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=c446775c3224787e51fb18b054a08a1c">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/cupertino_themes.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/cupertino_themes.dart (StylingTextExample)"?>
```dart
Text(
  'Hello, world!',
  style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: CupertinoColors.systemYellow,
  ),
),
```

### Styling buttons
In SwiftUI, you also use modifier functions to style buttons:

```swift
Button("Do something") {
    // do something when button is tapped
  }
  .font(.system(size: 30, weight: .bold))
  .background(Color.yellow)
  .foregroundColor(Color.blue)
}
```

You can achieve the same effect in Flutter 
by using any button widget, for example `CupertinoButton`, 
and setting the style of its child, 
or modifying properties on the button itself –  like background color.

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
 <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.dartpad}}/?id=8ffd244574c98f510c29712f6e6c2204">Test in DartPad</a>
  </li>
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/stylingbutton.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/stylingbutton.dart (StylingButtonExample)"?>
```dart
child: CupertinoButton(
  color: CupertinoColors.systemYellow,
  onPressed: () {},
  padding: const EdgeInsets.all(16),
  child: const Text(
    'Do something',
    style: TextStyle(
      color: CupertinoColors.systemBlue,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ),
),
```

One thing to note here is that in SwiftUI, 
you set the title of a button as a `String` object. 
But in Flutter, because everything is a widget, 
the title of the button itself is a widget. 
So, you assign a `Text` widget to the `child` property of your button 
and that becomes the title, 
which you can style separately. 
This means that the knowledge you have about styling a `Text` widget 
from the previous section comes in handy when styling a `CupertinoButton`.

### Using Custom Fonts
In SwiftUI, to use a custom font in your application, 
you need to add the font to your project and use 
the `.font()` modifier 
to apply it to your UI components as follows:

```swift
Text("Hello")
  .font(
    Font.custom(
      "BungeeSpice-Regular",
      size: 40
    )
  )
```

In Flutter, you control your resources with a file 
named `pubspec.yaml`, which is platform agnostic. 
To add a custom font to your project, follow these steps:

1. Create a folder called `fonts` in the project's root directory 
(this is an optional step but helps to organize your fonts) .
2. Add your .ttf, .otf or .ttc font file(s) into the `fonts` folder.
3. Open the `pubspec.yaml` file within the project and find the `flutter` section, 
add your custom font(s) under the `fonts` section as follows:

```
flutter:
  fonts:
    - family: BungeeSpice
      fonts:
        - asset: fonts/BungeeSpice-Regular.ttf
```

After this, you can start using your font just like in the SwiftUI example, 
but this time in Flutter:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/stylingbutton.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/stylingbutton.dart (CustomFont)"?>
```dart
Text(
  'Cupertino',
  style: TextStyle(
    fontSize: 40,
    fontFamily: 'BungeeSpice',
  ),
)
```


{{site.alert.note}}
  Check out [Google Fonts](https://fonts.google.com) to download custom fonts that you can use in your apps.
{{site.alert.end}}

### Bundling images in apps
In SwiftUI, to add images to your application, 
add the files to `Assets.xcassets` 
and then display them using the `Image` view. 

In Flutter, you add images similar to how you add custom fonts. 
Begin by adding an `images` folder to the root directory. 
Next, you’ll need to add this asset to the `pubspec.yaml` file as follows:

```
flutter:
  assets:
    - images/Blueberries.jpg
```

After defining your image, you can display it on the screen using 
the `Image` widget's `.asset()` constructor. 
This constructor instantiates the given image using the provided path, 
reads the image from the assets that are bundled with your app, 
and displays the image on the screen. See the [`Image`][] docs for a complete example. 


### Bundling videos in apps
To play a local video file bundled within your app in SwiftUI, 
you need to import the `AVKit` framework and 
create an instance of the `VideoPlayer` view.


In Flutter, to do the same thing, you'll need to add the [video_player][] 
plugin to your project. 
This plugin allows you to create a video player that works on 
Android, iOS, and on the web from the same codebase. 
You'll need to add the plugin to your app and, similar to above,
add the video file to your project, 
and add the asset to your `pubspec.yaml` file. Once these steps are complete, 
you can use the `VideoPlayerController` 
class to load and play your video file. See the [video_player example][]
for a complete walkthrough. 

</div>
<div class="tab-pane" id="uikit" role="tabpanel" aria-labelledby="uikit-tab" markdown="1">


## UIKit Overview

This section gives an overview of the core similarities 
and differences between UIKit and Flutter.

### Views vs. Widgets

{{site.alert.secondary}}
  How is react-style, or _declarative_,
  programming different from the
  traditional imperative style?
  For a comparison, see [Introduction to declarative UI][].
{{site.alert.end}}

In UIKit, most of what you create in the UI is done using view objects,
which are instances of the `UIView` class.
These can act as containers for other `UIView` classes,
which form your layout.

In Flutter, the rough equivalent to a `UIView` is a `Widget`.
Widgets don't map exactly to iOS views,
but while you're getting acquainted with how Flutter works
you can think of them as "the way you declare and construct UI".

However, these have a few differences to a `UIView`.
To start, widgets have a different lifespan: they are immutable
and only exist until they need to be changed.
Whenever widgets or their state change,
Flutter’s framework creates a new tree of widget instances.
In comparison, a UIKit view is not recreated when it changes,
but rather it's a mutable entity that is drawn once
and doesn't redraw until it is invalidated using `setNeedsDisplay()`.

Furthermore, unlike `UIView`, Flutter’s widgets are lightweight,
in part due to their immutability.
Because they aren't views themselves,
and aren't directly drawing anything,
but rather are a description of the UI and its semantics
that get "inflated" into actual view objects under the hood.

Flutter includes the [Material Components][] library.
These are widgets that implement the
[Material Design guidelines][].
Material Design is a flexible design system
[optimized for all platforms][], including iOS.

But Flutter is flexible and expressive enough
to implement any design language.
On iOS, you can use the [Cupertino widgets][]
to produce an interface that looks like
[Apple's iOS design language][].

### Updating Widgets

To update your views in UIKit, you directly mutate them.
In Flutter, widgets are immutable and not updated directly.
Instead, you have to manipulate the widget’s state.

This is where the concept of Stateful vs Stateless widgets
comes in. A `StatelessWidget` is just what it sounds
like&mdash;a widget with no state attached.

`StatelessWidgets` are useful when the part of the user interface you are
describing does not depend on anything other than the initial configuration
information in the widget.

For example, with UIKit, this is similar to placing a `UIImageView`
with your logo as the `image`. If the logo is not changing during runtime,
use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received
after making an HTTP call, use a `StatefulWidget`.
After the HTTP call has completed, tell the Flutter framework
that the widget’s `State` is updated, so it can update the UI.

The important difference between stateless and
stateful widgets is that `StatefulWidget`s have a `State` object
that stores state data and carries it over across tree rebuilds,
so it's not lost.

If you are in doubt, remember this rule:
if a widget changes outside of the `build` method
(because of runtime user interactions, for example),
it’s stateful.
If the widget never changes, once built, it's stateless.
However, even if a widget is stateful, the containing parent widget
can still be stateless if it isn’t itself reacting to those changes
(or other inputs).

The following example shows how to use a `StatelessWidget`.
A common`StatelessWidget` is the `Text` widget.
If you look at the implementation of the `Text` widget,
you'll find it subclasses `StatelessWidget`.

<?code-excerpt "lib/text_widget.dart (TextWidget)" replace="/return const //g"?>
```dart
Text(
  'I like Flutter!',
  style: TextStyle(fontWeight: FontWeight.bold),
);
```

If you look at the code above, you might notice that the `Text` widget
carries no explicit state with it. It renders what is passed in its
constructors and nothing more.

But, what if you want to make "I Like Flutter" change dynamically,
for example when clicking a `FloatingActionButton`?

To achieve this, wrap the `Text` widget in a `StatefulWidget` and
update it when the user clicks the button.

For example:

<?code-excerpt "lib/text_widget.dart (StatefulWidget)"?>
```dart

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default placeholder text
  String textToShow = 'I Like Flutter';

  void _updateText() {
    setState(() {
      // Update the text
      textToShow = 'Flutter is Awesome!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
```

### Widget layout

In UIKit, you might use a Storyboard file
to organize your views and set constraints,
or you might set your constraints programmatically in your view controllers.
In Flutter, declare your layout in code by composing a widget tree.

The following example shows how to display a simple widget with padding:

<?code-excerpt "lib/layout.dart (SimpleWidget)"?>
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Sample App')),
    body: Center(
      child: CupertinoButton(
        onPressed: () {},
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: const Text('Hello'),
      ),
    ),
  );
}
```

You can add padding to any widget,
which mimics the functionality of constraints in iOS.

You can view the layouts that Flutter has to offer
in the [widget catalog][].

### Removing Widgets

In UIKit, you call `addSubview()` on the parent,
or `removeFromSuperview()` on a child view
to dynamically add or remove child views.
In Flutter, because widgets are immutable,
there is no direct equivalent to `addSubview()`.
Instead, you can pass a function to the parent
that returns a widget, and control that child's creation
with a boolean flag.

The following example shows how to toggle between two widgets
when the user clicks the `FloatingActionButton`:

<?code-excerpt "lib/layout.dart (ToggleWidget)"?>
```dart
class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default value for toggle.
  bool toggle = true;

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  Widget _getToggleChild() {
    if (toggle) {
      return const Text('Toggle One');
    }

    return CupertinoButton(
      onPressed: () {},
      child: const Text('Toggle Two'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
```

### Animations

In UIKit, you create an animation by calling the
`animate(withDuration:animations:)` method on a view.
In Flutter, use the animation library
to wrap widgets inside an animated widget.

In Flutter, use an `AnimationController`, which is an `Animation<double>`
that can pause, seek, stop, and reverse the animation.
It requires a `Ticker` that signals when vsync happens
and produces a linear interpolation
between 0 and 1 on each frame while it's running.
You then create one or more
`Animation`s and attach them to the controller.

For example, you might use `CurvedAnimation`
to implement an animation along an interpolated curve.
In this sense, the controller is the "master" source
of the animation progress
and the `CurvedAnimation` computes the curve
that replaces the controller's default linear motion.
Like widgets, animations in Flutter work with composition.

When building the widget tree you assign the `Animation` to an animated
property of a widget, such as the opacity of a `FadeTransition`,
and tell the controller to start the animation.

The following example shows how to write a `FadeTransition` that
fades the widget into a logo when you press the `FloatingActionButton`:

<?code-excerpt "lib/animation.dart"?>
```dart
import 'package:flutter/material.dart';

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fade Demo',
      home: MyFadeTest(title: 'Fade Demo'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  const MyFadeTest({super.key, required this.title});

  final String title;

  @override
  State<MyFadeTest> createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FadeTransition(
          opacity: curve,
          child: const FlutterLogo(size: 100.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        tooltip: 'Fade',
        child: const Icon(Icons.brush),
      ),
    );
  }
}
```

For more information, see [Animation & Motion widgets][],
the [Animations tutorial][], and the [Animations overview][].

### Drawing on the screen

In UIKit, you use `CoreGraphics` to draw lines and shapes to the
screen. Flutter has a different API based on the `Canvas` class,
with two other classes that help you draw: `CustomPaint` and `CustomPainter`,
the latter of which implements your algorithm to draw to the canvas.

To learn how to implement a signature painter in Flutter,
see Collin's answer on [StackOverflow][].

[StackOverflow]: {{site.so}}/questions/46241071/create-signature-area-for-mobile-app-in-dart-flutter

<?code-excerpt "lib/canvas.dart"?>
```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoApp()));

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: Signature());
}

class Signature extends StatefulWidget {
  const Signature({super.key});

  @override
  State<Signature> createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset?>[];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox? referenceBox = context.findRenderObject() as RenderBox;
          Offset localPosition =
              referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (details) => _points.add(null),
      child:
      CustomPaint(
        painter: SignaturePainter(_points),
        size: Size.infinite,
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
```

### Widget opacity

In UIKit, everything has `.opacity` or `.alpha`.
In Flutter, most of the time you need to
wrap a widget in an `Opacity` widget to accomplish this.

### Custom Widgets

In UIKit, you typically subclass `UIView`, or use a pre-existing view,
to override and implement methods that achieve the desired behavior.
In Flutter, build a custom widget by [composing][] smaller widgets
(instead of extending them).

For example, how do you build a `CustomButton`
that takes a label in the constructor?
Create a CustomButton that composes a `ElevatedButton` with a label,
rather than by extending `ElevatedButton`:

<?code-excerpt "lib/custom.dart (CustomButton)"?>
```dart
class CustomButton extends StatelessWidget {
  const CustomButton(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}
```

Then use `CustomButton`,
just as you'd use any other Flutter widget:

<?code-excerpt "lib/custom.dart (UseCustomButton)"?>
```dart
@override
Widget build(BuildContext context) {
  return const Center(
    child: CustomButton('Hello'),
  );
}
```

## Navigation

This section of the document discusses navigation 
between pages of an app, the push and pop mechanism, and more.

### Navigating between pages

In UIKit, to travel between view controllers, you can use a
`UINavigationController` that manages the stack of view controllers
to display.

Flutter has a similar implementation,
using a `Navigator` and `Routes`.
A `Route` is an abstraction for a “screen” or “page” of an app,
and a `Navigator` is a [widget][]
that manages routes. A route roughly maps to a
`UIViewController`. The navigator works in a similar way to the iOS
`UINavigationController`, in that it can `push()` and `pop()`
routes depending on whether you want to navigate to, or back from, a view.

To navigate between pages, you have a couple options:

* Specify a `Map` of route names.
* Directly navigate to a route.

The following example builds a `Map.`

<?code-excerpt "lib/intent.dart (Map)"?>
```dart
void main() {
  runApp(
    CupertinoApp(
      home: const MyAppHome(), // becomes the route named '/'
      routes: <String, WidgetBuilder>{
        '/a': (context) => const MyPage(title: 'page A'),
        '/b': (context) => const MyPage(title: 'page B'),
        '/c': (context) => const MyPage(title: 'page C'),
      },
    ),
  );
}
```

Navigate to a route by `push`ing its name to the `Navigator`.

<?code-excerpt "lib/intent.dart (Push)"?>
```dart
Navigator.of(context).pushNamed('/b');
```

The `Navigator` class handles routing in Flutter and is used to get
a result back from a route that you have pushed on the stack.
This is done by `await`ing on the `Future` returned by `push()`.

For example, to start a `location` route that lets the user select their
location, you might do the following:

<?code-excerpt "lib/intent.dart (PushAwait)"?>
```dart
Object? coordinates = await Navigator.of(context).pushNamed('/location');
```

And then, inside your `location` route, once the user has selected their
location, `pop()` the stack with the result:

<?code-excerpt "lib/intent.dart (Pop)"?>
```dart
Navigator.of(context).pop({'lat': 43.821757, 'long': -79.226392});
```

### Navigating to another app

In UIKit, to send the user to another application,
you use a specific URL scheme.
For the system level apps, the scheme depends on the app.
To implement this functionality in Flutter,
create a native platform integration, or use an
[existing plugin][], such as [`url_launcher`][].

### Manually pop back

Calling `SystemNavigator.pop()` from your Dart code
invokes the following iOS code:

```objc
UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
if ([viewController isKindOfClass:[UINavigationController class]]) {
  [((UINavigationController*)viewController) popViewControllerAnimated:NO];
}
```

If that doesn't do what you want, you can create your own
[platform channel][] to invoke arbitrary iOS code.

### Handling localization

Unlike iOS, which has the `Localizable.strings` file,
Flutter doesn't currently have a dedicated system for handling strings.
At the moment, the best practice is to declare your copy text
in a class as static fields and access them from there. For example:

<?code-excerpt "lib/string_examples.dart (Strings)"?>
```dart
class Strings {
  static const String welcomeMessage = 'Welcome To Flutter';
}
```

You can access your strings as such:

<?code-excerpt "lib/string_examples.dart (AccessString)" replace="/const //g"?>
```dart
Text(Strings.welcomeMessage);
```

By default, Flutter only supports US English for its strings.
If you need to add support for other languages,
include the `flutter_localizations` package.
You might also need to add Dart's [`intl`][]
package to use i10n machinery, such as date/time formatting.

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: '^0.17.0'
```

To use the `flutter_localizations` package,
specify the `localizationsDelegates` and
`supportedLocales` on the app widget:

<?code-excerpt "lib/localizations_example.dart"?>
```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        // Add app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        Locale('en', 'US'), // English
        Locale('he', 'IL'), // Hebrew
        // ... other locales the app supports
      ],
    );
  }
}
```

The delegates contain the actual localized values,
while the `supportedLocales` defines which locales the app supports.
The above example uses a `MaterialApp`,
so it has both a `GlobalWidgetsLocalizations`
for the base widgets localized values,
and a `MaterialWidgetsLocalizations` for the Material widgets localizations.
If you use `WidgetsApp` for your app, you don't need the latter.
Note that these two delegates contain "default" values,
but you'll need to provide one or more delegates
for your own app's localizable copy,
if you want those to be localized too.

When initialized, the `WidgetsApp` (or `MaterialApp`)
creates a [`Localizations`][] widget for you,
with the delegates you specify.
The current locale for the device is always accessible
from the `Localizations` widget from the current context
(in the form of a `Locale` object), or using the [`Window.locale`][].

To access localized resources, use the `Localizations.of()` method
to access a specific localizations class that is provided by a given delegate.
Use the [`intl_translation`][] package to extract translatable copy
to [arb][] files for translating, and importing them back into the app
for using them with `intl`.

For further details on internationalization and localization in Flutter,
see the [internationalization guide][], which has sample code
with and without the `intl` package.

### Managing dependencies

In iOS, you add dependencies with CocoaPods by adding to your `Podfile`.
Flutter uses Dart’s build system and the Pub package manager
to handle dependencies. The tools delegate the building of the
native Android and iOS wrapper apps to the
respective build systems.

While there is a Podfile in the iOS folder in your
Flutter project, only use this if you are adding native
dependencies needed for per-platform integration.
In general, use `pubspec.yaml` to declare external dependencies in Flutter.
A good place to find great packages for Flutter is on [pub.dev][].

## ViewControllers

This section of the document discusses the equivalent 
of ViewController in Flutter and how to listen to 
lifecycle events.

### Equivalent of ViewController in Flutter

In UIKit, a `ViewController` represents a portion of user interface,
most commonly used for a screen or section.
These are composed together to build complex user interfaces,
and help scale your application's UI.
In Flutter, this job falls to Widgets.
As mentioned in the Navigation section,
screens in Flutter are represented by Widgets since
"everything is a widget!"
Use a `Navigator` to move between different `Route`s
that represent different screens or pages,
or maybe different states or renderings of the same data.

### Listening to lifecycle events

In UIKit, you can override methods to the `ViewController`
to capture lifecycle methods for the view itself,
or register lifecycle callbacks in the `AppDelegate`.
In Flutter, you have neither concept, but you can instead
listen to lifecycle events by hooking into
the `WidgetsBinding` observer and listening to
the `didChangeAppLifecycleState()` change event.

The observable lifecycle events are:

**`inactive`**
: The application is in an inactive state and is not receiving
  user input. This event only works on iOS,
  as there is no equivalent event on Android.

**`paused`**
: The application is not currently visible to the user,
  is not responding to user input, but is running in the background.

**`resumed`**
: The application is visible and responding to user input.

**`suspending`**
: The application is suspended momentarily.
  The iOS platform has no equivalent event.

For more details on the meaning of these states, see
[`AppLifecycleState` documentation][].

## Layouts

This section discusses different layouts in Flutter 
and how they compare with UIKit.

### Displaying a list view

In UIKit, you might show a list in
either a `UITableView` or a `UICollectionView`.
In Flutter, you have a similar implementation using a `ListView`.
In UIKit, these views have delegate methods
for deciding the number of rows,
the cell for each index path, and the size of the cells.

Due to Flutter’s immutable widget pattern,
you pass a list of widgets to your `ListView`,
and Flutter takes care of making sure that
scrolling is fast and smooth.

<?code-excerpt "lib/listview.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> _getListData() {
    final List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Row $i'),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView(children: _getListData()),
    );
  }
}
```

### Detecting what was clicked

In UIKit, you implement the delegate method,
`tableView:didSelectRowAtIndexPath:`.
In Flutter, use the touch handling provided by the passed-in widgets.

<?code-excerpt "lib/list_item_tapped.dart"?>
```dart
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(
        GestureDetector(
          onTap: () {
            developer.log('row tapped');
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Row $i'),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView(children: _getListData()),
    );
  }
}
```

### Dynamically updating ListView

In UIKit, you update the data for the list view,
and notify the table or collection view using the
`reloadData` method.

In Flutter, if you update the list of widgets inside a `setState()`,
you quickly see that your data doesn't change visually.
This is because when `setState()` is called,
the Flutter rendering engine looks at the widget tree
to see if anything has changed.
When it gets to your `ListView`, it performs an `==` check,
and determines that the two `ListView`s are the same.
Nothing has changed, so no update is required.

For a simple way to update your `ListView`,
create a new `List` inside of `setState()`,
and copy the data from the old list to the new list.
While this approach is simple,
it is not recommended for large data sets,
as shown in the next example.

<?code-excerpt "lib/listview_dynamic.dart"?>
```dart
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets = List.from(widgets);
          widgets.add(getRow(widgets.length));
          developer.log('row $i');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Row $i'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView(children: widgets),
    );
  }
}
```

The recommended, efficient,
and effective way to build a list uses a `ListView.Builder`.
This method is great when you have a dynamic
list or a list with very large amounts of data.

<?code-excerpt "lib/listview_builder.dart"?>
```dart
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length));
          developer.log('row $i');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Row $i'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) {
          return getRow(position);
        },
      ),
    );
  }
}
```

Instead of creating a `ListView`, create a `ListView.builder`
that takes two key parameters: the initial length of the list,
and an `ItemBuilder` function.

The `ItemBuilder` function is similar to the `cellForItemAt`
delegate method in an iOS table or collection view,
as it takes a position, and returns the
cell you want rendered at that position.

Finally, but most importantly, notice that the `onTap()` function
doesn't recreate the list anymore, but instead `.add`s to it.

### Creating a scroll view

In UIKit, you wrap your views in a `ScrollView` that
allows a user to scroll your content if needed.

In Flutter the easiest way to do this is using the `ListView` widget.
This acts as both a `ScrollView` and an iOS `TableView`,
as you can layout widgets in a vertical format.

<?code-excerpt "lib/layout.dart (ListView)"?>
```dart
@override
Widget build(BuildContext context) {
  return ListView(
    children: const <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}
```

For more detailed docs on how to lay out widgets in Flutter,
see the [layout tutorial][].

## Gesture detection and touch event handling

This section discusses how to detect gestures 
and handle different events in Flutter, 
and how they compare with UIKit.

### Adding a click listener

In UIKit, you attach a `GestureRecognizer` to a view to
handle click events.
In Flutter, there are two ways of adding touch listeners:

1. If the widget supports event detection, pass a function to it,
   and handle the event in the function. For example, the
   `ElevatedButton` widget has an `onPressed` parameter:

  <?code-excerpt "lib/events.dart (onPressed)"?>
   ```dart
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        developer.log('click');
      },
      child: const Text('Button'),
    );
  }
   ```

2. If the Widget doesn't support event detection,
   wrap the widget in a GestureDetector and pass a function
   to the `onTap` parameter.

  <?code-excerpt "lib/events.dart (onTap)"?>
   ```dart
  class SampleTapApp extends StatelessWidget {
    const SampleTapApp({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              developer.log('tap');
            },
            child: const FlutterLogo(
              size: 200.0,
            ),
          ),
        ),
      );
    }
  }
   ```

### Handling other gestures

Using `GestureDetector` you can listen
to a wide range of gestures such as:

* **Tapping**

  **`onTapDown`**
  : A pointer that might cause a tap has contacted the
    screen at a particular location.

  **`onTapUp`**
  : A pointer that triggers a tap has stopped contacting the
    screen at a particular location.

  **`onTap`**
  : A tap has occurred.

  **`onTapCancel`**
  : The pointer that previously triggered the `onTapDown`
    won't cause a tap.

* **Double tapping**

  **`onDoubleTap`**
  : The user tapped the screen at the same location twice in
    quick succession.

* **Long pressing**

  **`onLongPress`**
  : A pointer has remained in contact with the screen
    at the same location for a long period of time.

* **Vertical dragging**

  **`onVerticalDragStart`**
  : A pointer has contacted the screen and might begin to
    move vertically.

  **`onVerticalDragUpdate`**
  : A pointer in contact with the screen
    has moved further in the vertical direction.

  **`onVerticalDragEnd`**
  : A pointer that was previously in contact with the
    screen and moving vertically is no longer in contact
    with the screen and was moving at a specific velocity
    when it stopped contacting the screen.

* **Horizontal dragging**

  **`onHorizontalDragStart`**
  : A pointer has contacted the screen and might begin
    to move horizontally.

  **`onHorizontalDragUpdate`**
  : A pointer in contact with the screen
    has moved further in the horizontal direction.

  **`onHorizontalDragEnd`**
  : A pointer that was previously in contact with the
    screen and moving horizontally is no longer in
    contact with the screen.

The following example shows a `GestureDetector`
that rotates the Flutter logo on a double tap:

<?code-excerpt "lib/events.dart (SampleApp)"?>
```dart
class SampleApp extends StatefulWidget {
  const SampleApp({super.key});

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: RotationTransition(
            turns: curve,
            child: const FlutterLogo(
              size: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
```

## Themes, styles, and media

Flutter applications are easy to style; you can switch 
between light and dark themes, 
change the style of your text and UI components, 
and more. This section covers aspects of styling your Flutter apps 
and compares how you might do the same in UIKit.

### Using a theme

Out of the box, Flutter comes with a beautiful implementation
of Material Design, which takes care of a lot of styling and
theming needs that you would typically do.

To take full advantage of Material Components in your app,
declare a top-level widget, `MaterialApp`,
as the entry point to your application.
`MaterialApp` is a convenience widget that wraps a number
of widgets that are commonly required for applications
implementing Material Design.
It builds upon a `WidgetsApp` by adding Material specific functionality.

But Flutter is flexible and expressive enough to implement
any design language. On iOS, you can use the
[Cupertino library][] to produce an interface that adheres to the
[Human Interface Guidelines][].
For the full set of these widgets,
see the [Cupertino widgets][] gallery.

You can also use a `WidgetsApp` as your app widget,
which provides some of the same functionality,
but is not as rich as `MaterialApp`.

To customize the colors and styles of any child components,
pass a `ThemeData` object to the `MaterialApp` widget.
For example, in the code below,
the primary swatch is set to blue and divider color is grey.

<?code-excerpt "lib/theme.dart (Theme)"?>
```dart
import 'package:flutter/material.dart';

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        dividerColor: Colors.grey,
      ),
      home: const SampleAppPage(),
    );
  }
}
```

### Using custom fonts

In UIKit, you import any `ttf` font files into your project
and create a reference in the `info.plist` file.
In Flutter, place the font file in a folder
and reference it in the `pubspec.yaml` file,
similar to how you import images.

```yaml
fonts:
  - family: MyCustomFont
    fonts:
      - asset: fonts/MyCustomFont.ttf
      - style: italic
```

Then assign the font to your `Text` widget:

<?code-excerpt "lib/text.dart (CustomFont)"?>
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Sample App'),
    ),
    body: const Center(
      child: Text(
        'This is a custom font text',
        style: TextStyle(fontFamily: 'MyCustomFont'),
      ),
    ),
  );
}
```

### Styling text

Along with fonts, you can customize other styling elements on a `Text` widget.
The style parameter of a `Text` widget takes a `TextStyle` object,
where you can customize many parameters, such as:

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

### Bundling images in apps

While iOS treats images and assets as distinct items,
Flutter apps have only assets. Resources that are
placed in the `Images.xcasset` folder on iOS,
are placed in an assets' folder for Flutter.
As with iOS, assets are any type of file, not just images.
For example, you might have a JSON file located in the `my-assets` folder:

```
my-assets/data.json
```

Declare the asset in the `pubspec.yaml` file:

```yaml
assets:
 - my-assets/data.json
```

And then access it from code using an [`AssetBundle`][]:

<?code-excerpt "lib/asset_bundle.dart"?>
```dart
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('my-assets/data.json');
}
```

For images, Flutter follows a simple density-based format like iOS.
Image assets might be `1.0x`, `2.0x`, `3.0x`, or any other multiplier.
The so-called [`devicePixelRatio`][]
expresses the ratio of physical pixels in a single logical pixel.

Assets are located in any arbitrary folder&mdash;
Flutter has no predefined folder structure.
You declare the assets (with location) in
the `pubspec.yaml` file, and Flutter picks them up.

For example, to add an image called `my_icon.png` to your Flutter
project, you might decide to store it in a folder arbitrarily called `images`.
Place the base image (1.0x) in the `images` folder, and the
other variants in sub-folders named after the appropriate ratio multiplier:

```
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image
```

Next, declare these images in the `pubspec.yaml` file:

```yaml
assets:
 - images/my_icon.png
```

You can now access your images using `AssetImage`:

<?code-excerpt "lib/images.dart (AssetImage)"?>
```dart
AssetImage('images/a_dot_burr.jpeg')
```

or directly in an `Image` widget:

<?code-excerpt "lib/images.dart (Imageasset)"?>
```dart
@override
Widget build(BuildContext context) {
  return Image.asset('images/my_image.png');
}
```

For more details, see
[Adding Assets and Images in Flutter][].

## Form input

This section discusses how to use forms in Flutter 
and how they compare with UIKit.

### Retrieving user input

Given how Flutter uses immutable widgets with a separate state,
you might be wondering how user input fits into the picture.
In UIKit, you usually query the widgets for their current values
when it's time to submit the user input, or action on it.
How does that work in Flutter?

In practice forms are handled, like everything in Flutter,
by specialized widgets. If you have a `TextField` or a
`TextFormField`, you can supply a [`TextEditingController`][]
to retrieve user input:

<?code-excerpt "lib/form.dart (MyFormState)"?>
```dart
class _MyFormState extends State<MyForm> {
  // Create a text controller and use it to retrieve the current value.
  // of the TextField!
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when disposing of the Widget.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(controller: myController),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has typed in using our
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
```

You can find more information and the full code listing in
[Retrieve the value of a text field][],
from the [Flutter cookbook][].

### Placeholder in a text field

In Flutter, you can easily show a "hint" or a placeholder text
for your field by adding an `InputDecoration` object
to the decoration constructor parameter for the `Text` widget:

<?code-excerpt "lib/form.dart (InputHint)" replace="/return const //g;/;//g"?>
```dart
Center(
  child: TextField(
    decoration: InputDecoration(hintText: 'This is a hint'),
  ),
)
```

### Showing validation errors

Just as you would with a "hint", pass an `InputDecoration` object
to the decoration constructor for the `Text` widget.

However, you don't want to start off by showing an error.
Instead, when the user has entered invalid data,
update the state, and pass a new `InputDecoration` object.

<?code-excerpt "lib/validation_errors.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  String? _errorText;

  bool isEmail(String em) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|'
        r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
        r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailRegexp);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Center(
        child: TextField(
          onSubmitted: (text) {
            setState(() {
              if (!isEmail(text)) {
                _errorText = 'Error: This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
          decoration: InputDecoration(
            hintText: 'This is a hint',
            errorText: _errorText,
          ),
        ),
      ),
    );
  }
}
```

## Threading & asynchronicity

This section discusses concurrency in Flutter and 
how it compares with UIKit.

### Writing asynchronous code

Dart has a single-threaded execution model,
with support for `Isolate`s
(a way to run Dart code on another thread),
an event loop, and asynchronous programming.
Unless you spawn an `Isolate`,
your Dart code runs in the main UI thread and is
driven by an event loop. Flutter’s event loop is
equivalent to the iOS main loop&mdash;that is,
the `Looper` that is attached to the main thread.

Dart's single-threaded model doesn't mean you are
required to run everything as a blocking operation
that causes the UI to freeze. Instead,
use the asynchronous facilities that the Dart language provides,
such as `async`/`await`, to perform asynchronous work.

For example, you can run network code without causing the
UI to hang by using `async`/`await` and letting Dart do
the heavy lifting:

<?code-excerpt "lib/async.dart (loadData)"?>
```dart
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = jsonDecode(response.body);
  });
}
```

Once the `await`ed network call is done,
update the UI by calling `setState()`,
which triggers a rebuild of the widget sub-tree
and updates the data.

The following example loads data asynchronously and
displays it in a `ListView`:

<?code-excerpt "lib/async.dart"?>
```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, dynamic>> data = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = jsonDecode(response.body);
    });
  }

  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('Row ${data[index]['title']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getRow(index);
        },
      ),
    );
  }
}
```

Refer to the next section for more information on doing work
in the background, and how Flutter differs from iOS.

### Moving to the background thread

Since Flutter is single threaded and runs an event loop
(like Node.js), you don't have to worry about
thread management or spawning background threads.
If you're doing I/O-bound work,
such as disk access or a network call,
then you can safely use `async`/`await` and you're done.
If, on the other hand, you need to do computationally intensive
work that keeps the CPU busy, you want to move it to an
`Isolate` to avoid blocking the event loop.

For I/O-bound work, declare the function as an `async` function,
and `await` on long-running tasks inside the function:

<?code-excerpt "lib/async.dart (loadData)"?>
```dart
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = jsonDecode(response.body);
  });
}
```

This is how you typically do network or database calls,
which are both I/O operations.

However, there are times when you might be processing
a large amount of data and your UI hangs.
In Flutter, use `Isolate`s to take advantage of
multiple CPU cores to do long-running or
computationally intensive tasks.

Isolates are separate execution threads that do not share
any memory with the main execution memory heap.
This means you can’t access variables from the main thread,
or update your UI by calling `setState()`.
Isolates are true to their name, and cannot share memory
(in the form of static fields, for example).

The following example shows, in a simple isolate,
how to share data back to the main thread to update the UI.

<?code-excerpt "lib/isolates.dart (loadData)"?>
```dart
Future<void> loadData() async {
  final ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);

  // The 'echo' isolate sends its SendPort as the first message.
  final SendPort sendPort = await receivePort.first as SendPort;

  final List<Map<String, dynamic>> msg = await sendReceive(
    sendPort,
    'https://jsonplaceholder.typicode.com/posts',
  );

  setState(() {
    data = msg;
  });
}

// The entry point for the isolate.
static Future<void> dataLoader(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  final ReceivePort port = ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);

  await for (final dynamic msg in port) {
    final String url = msg[0] as String;
    final SendPort replyTo = msg[1] as SendPort;

    final Uri dataURL = Uri.parse(url);
    final http.Response response = await http.get(dataURL);
    // Lots of JSON to parse
    replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
  }
}

Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
  final ReceivePort response = ReceivePort();
  port.send(<dynamic>[msg, response.sendPort]);
  return response.first as Future<List<Map<String, dynamic>>>;
}
```

Here, `dataLoader()` is the `Isolate` that runs in
its own separate execution thread.
In the isolate, you can perform more CPU intensive
processing (parsing a big JSON, for example),
or perform computationally intensive math,
such as encryption or signal processing.

You can run the full example below:

<?code-excerpt "lib/isolates.dart"?>
```dart
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, dynamic>> data = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message.
    final SendPort sendPort = await receivePort.first as SendPort;

    final List<Map<String, dynamic>> msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );

    setState(() {
      data = msg;
    });
  }

  // The entry point for the isolate.
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    final ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (final dynamic msg in port) {
      final String url = msg[0] as String;
      final SendPort replyTo = msg[1] as SendPort;

      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
    }
  }

  Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
    final ReceivePort response = ReceivePort();
    port.send(<dynamic>[msg, response.sendPort]);
    return response.first as Future<List<Map<String, dynamic>>>;
  }

  Widget getBody() {
    bool showLoadingDialog = data.isEmpty;

    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("Row ${data[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: getBody(),
    );
  }
}
```

### Making network requests

Making a network call in Flutter is easy when you
use the popular [`http` package][]. This abstracts
away a lot of the networking that you might normally
implement yourself, making it simple to make network calls.

To use the `http` package, add it to your dependencies in `pubspec.yaml`:

```yaml
dependencies:
  http: ^0.13.4
```

To make a network call,
call `await` on the `async` function `http.get()`:

<?code-excerpt "lib/progress.dart (loadData)"?>
```dart
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = jsonDecode(response.body);
  });
}
```

### Showing the progress on long running tasks

In UIKit, you typically use a `UIProgressView`
while executing a long-running task in the background.

In Flutter, use a `ProgressIndicator` widget.
Show the progress programmatically by controlling
when it's rendered through a boolean flag.
Tell Flutter to update its state before your long-running task starts,
and hide it after it ends.

In the example below, the build function is separated into three different
functions. If `showLoadingDialog` is `true`
(when `widgets.length == 0`), then render the `ProgressIndicator`.
Otherwise, render the `ListView` with the data returned from a network call.

<?code-excerpt "lib/progress.dart"?>
```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sample App',
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, dynamic>> data = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = jsonDecode(response.body);
    });
  }

  Widget getBody() {
    if (showLoadingDialog) {
      return getProgressDialog();
    }

    return getListView();
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return getRow(index);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("Row ${data[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: getBody(),
    );
  }
}
```


</div>
</div>{% comment %} End: Tab panes. {% endcomment -%}

[Add Flutter to existing app]: {{site.url}}/development/add-to-app
[Adding Assets and Images in Flutter]: {{site.url}}/development/ui/assets-and-images
[Animation & Motion widgets]: {{site.url}}/development/ui/widgets/animation
[Animations overview]: {{site.url}}/development/ui/animations
[Animations tutorial]: {{site.url}}/development/ui/animations/tutorial
[Apple's iOS design language]: {{site.apple-dev}}/design/resources
[`AppLifecycleState` documentation]: {{site.api}}/flutter/dart-ui/AppLifecycleState.html
[arb]: {{site.github}}/googlei18n/app-resource-bundle
[`AssetBundle`]: {{site.api}}/flutter/services/AssetBundle-class.html
[`cloud_firestore`]: {{site.pub-pkg}}/cloud_firestore
[composing]: {{site.url}}/resources/architectural-overview#composition
[Cupertino library]: {{site.api}}/flutter/cupertino/cupertino-library.html
[Cupertino widgets]: {{site.url}}/development/ui/widgets/cupertino
[developing packages and plugins]: {{site.url}}/development/packages-and-plugins/developing-packages
[`devicePixelRatio`]: {{site.api}}/flutter/dart-ui/FlutterView/devicePixelRatio.html
[DevTools]: {{site.url}}/development/tools/devtools
[existing plugin]: {{site.pub}}/flutter
[`firebase_admob`]: {{site.pub-pkg}}/firebase_admob
[`firebase_analytics`]: {{site.pub-pkg}}/firebase_analytics
[`firebase_auth`]: {{site.pub-pkg}}/firebase_auth
[`firebase_core`]: {{site.pub-pkg}}/firebase_core
[`firebase_database`]: {{site.pub-pkg}}/firebase_database
[`firebase_messaging`]: {{site.pub-pkg}}/firebase_messaging
[`firebase_storage`]: {{site.pub-pkg}}/firebase_storage
[first party plugins]: {{site.pub}}/flutter/packages?q=firebase
[`flutter_facebook_login`]: {{site.pub-pkg}}/flutter_facebook_login
[Flutter cookbook]: {{site.url}}/cookbook
[Flutter Youtube channel]: {{site.social.youtube}}
[`geolocator`]: {{site.pub-pkg}}/geolocator
[`http` package]: {{site.pub-pkg}}/http
[Human Interface Guidelines]: {{site.apple-dev}}/ios/human-interface-guidelines/overview/themes/
[`camera`]: {{site.pub-pkg}}/camera
[internationalization guide]: {{site.url}}/development/accessibility-and-localization/internationalization
[`intl`]: {{site.pub-pkg}}/intl
[`intl_translation`]: {{site.pub-pkg}}/intl_translation
[Introduction to declarative UI]: {{site.url}}/get-started/flutter-for/declarative
[layout tutorial]: {{site.url}}/development/ui/widgets/layout
[`Localizations`]: {{site.api}}/flutter/widgets/Localizations-class.html
[Material Components]: {{site.material}}/develop/flutter/
[Material Design guidelines]: {{site.material}}/design/
[optimized for all platforms]: {{site.material}}/design/platform-guidance/cross-platform-adaptation.html#cross-platform-guidelines
[Platform adaptations]: {{site.url}}/resources/platform-adaptations
[platform channel]: {{site.url}}/development/platform-integration/platform-channels
[plugins]: {{site.url}}/development/packages-and-plugins/using-packages
[pub.dev]: {{site.pub}}/flutter/packages
[publish it on pub.dev]: {{site.url}}/development/packages-and-plugins/developing-packages#publish
[Retrieve the value of a text field]: {{site.url}}/cookbook/forms/retrieve-input
[Shared Preferences plugin]: {{site.pub-pkg}}/shared_preferences
[SQFlite]: {{site.pub-pkg}}/sqflite
[`TextEditingController`]: {{site.api}}/flutter/widgets/TextEditingController-class.html
[`url_launcher`]: {{site.pub-pkg}}/url_launcher
[widget]: {{site.url}}/resources/architectural-overview#widgets
[widget catalog]: {{site.url}}/development/ui/widgets/layout
[`Window.locale`]: {{site.api}}/flutter/dart-ui/Window/locale.html
[write your own]: {{site.url}}/development/packages-and-plugins/developing-packages
[Understanding constraints]: {{site.url}}/development/ui/layout/constraints
[`WidgetApp`]: {{site.api}}/flutter/widgets/WidgetsApp-class.html
[`CupertinoApp`]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[`Center`]: {{site.api}}/flutter/widgets/Center-class.html
[`CupertinoButton`]: {{site.api}}/flutter/cupertino/CupertinoButton-class.html
[`Row`]: {{site.api}}/flutter/widgets/Row-class.html
[`Column`]: {{site.api}}/flutter/widgets/Column-class.html
[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html
[`ListTile`]: {{site.api}}/flutter/widgets/ListTitle-class.html
[`GridView`]: {{site.api}}/flutter/widgets/GridView-class.html
[`SingleChildScrollView`]: {{site.api}}/flutter/widgets/SingleChildScrollView-class.html
[`LayoutBuilder`]: {{site.api}}/flutter/widgets/LayoutBuilder-class.html
[`AnimatedRotation`]: {{site.api}}/flutter/widgets/AnimatedRotation-class.html
[`TweenAnimationBuilder`]: {{site.api}}/flutter/widgets/TweenAnimationBuilder-class.html
[`RotationTransition`]: {{site.api}}/flutter/widgets/RotationTransition-class.html
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`StatefulWidget`]: {{site.api}}/flutter/widgets/StatefulWidget-class.html
[State management]:  {{site.url}}/development/data-and-backend/state-mgmt
[Wonderous]: https://flutter.gskinner.com/wonderous/?utm_source=flutterdocs&utm_medium=docs&utm_campaign=iosdevs
[video_player]: {{site.pub-pkg}}/video_player
[video_player example]: {{site.pub-pkg}}/video_player/example 
[Creating responsive and adaptive apps]: {{site.url}}/development/ui/layout/adaptive-responsive
[`MediaQuery.of()`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`CustomPaint`]: {{site.api}}/flutter/widgets/CustomPaint-class.html
[`CustomPainter`]: {{site.api}}/flutter/rendering/CustomPainter-class.html
[`Image`]: {{site.api}}/flutter/widgets/Image-class.html
[go_router]:{{site.pub-pkg}}/go_router