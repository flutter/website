---
title: Flutter for SwiftUI Developers
description: Learn how to apply SwiftUI developer knowledge when building Flutter apps.
---

<?code-excerpt path-base="get-started/flutter-for/ios_devs"?>

{% assign sample_path = "blob/main/examples/get-started/flutter-for/ios_devs" %}

SwiftUI developers who want to write mobile apps using Flutter
should review this guide.
It explains how to apply existing SwiftUI knowledge to Flutter.

:::note
If you instead have experience building apps for iOS with UIKit,
see [Flutter for UIKit developers][].
:::

Flutter is a framework for building cross-platform applications
that uses the Dart programming language.
To understand some differences between programming with Dart
and programming with Swift, see [Learning Dart as a Swift Developer][]
and [Flutter concurrency for Swift developers][].

Your SwiftUI knowledge and experience
are highly valuable when building with Flutter.
{% comment %}
  TODO: Add talk about plugin system for interacting with OS and hardware
  when [iOS and Apple hardware interactions with Flutter][] is released.
{% endcomment %}

Flutter also makes a number of adaptations
to app behavior when running on iOS and macOS.
To learn how, see [Platform adaptations][].

:::tip
To integrate Flutter code into an **existing** iOS app,
check out [Add Flutter to existing app][].
:::

This document can be used as a cookbook by jumping around
and finding questions that are most relevant to your needs.
This guide embeds sample code.
You can test full working examples on DartPad or view them on GitHub.

## Overview

As an introduction, watch the following video.
It outlines how Flutter works on iOS and how to use Flutter to build iOS apps.

<iframe class="full-width" src="{{site.yt.embed}}/ceMsPBbcEGg" title="Learn how to develop with Flutter as an iOS developer" {{site.yt.set}}></iframe>

Flutter and SwiftUI code describes how the UI looks and works.
Developers call this type of code a _declarative framework_.

### Views vs. Widgets

**SwiftUI** represents UI components as _views_.
You configure views using _modifiers_.

```swift
Text("Hello, World!") // <-- This is a View
  .padding(10)        // <-- This is a modifier of that View
```

**Flutter** represents UI components as _widgets_.

Both views and widgets only exist until they need to be changed.
These languages call this property _immutability_.
SwiftUI represents a UI component property as a View modifier.
By contrast, Flutter uses widgets for both UI components and
their properties.

```dart
Padding(                         // <-- This is a Widget
  padding: EdgeInsets.all(10.0), // <-- So is this
  child: Text("Hello, World!"),  // <-- This, too
)));
```

To compose layouts, both SwiftUI and Flutter nest UI components
within one another.
SwiftUI nests Views while Flutter nests Widgets.

### Layout process

**SwiftUI** lays out views using the following process:

1. The parent view proposes a size to its child view.
1. All subsequent child views:
    - propose a size to _their_ child's view
    - ask that child what size it wants
1. Each parent view renders its child view at the returned size.

**Flutter** differs somewhat with its process:

1. The parent widget passes constraints down to its children.
   Constraints include minimum and maximum values for height and width.
1. The child tries to decide its size. It repeats the same process with its own
   list of children:
    - It informs its child of the child's constraints.
    - It asks its child what size it wishes to be.

1. The parent lays out the child.
    - If the requested size fits in the constraints,
      the parent uses that size.
    - If the requested size doesn't fit in the constraints,
      the parent limits the height, width, or both to fit in
      its constraints.

Flutter differs from SwiftUI because the parent component can override
the child's desired size. The widget cannot have any size it wants.
It also cannot know or decide its position on screen as its parent
makes that decision.

To force a child widget to render at a specific size,
the parent must set tight constraints.
A constraint becomes tight when its constraint's minimum size value
equals its maximum size value.

In **SwiftUI**, views might expand to the available space or
limit their size to that of its content.
**Flutter** widgets behave in similar manner.

However, in Flutter parent widgets can offer unbounded constraints.
Unbounded constraints set their maximum values to infinity.

```dart
UnboundedBox(
  child: Container(
      width: double.infinity, height: double.infinity, color: red),
)
```

If the child expands and it has unbounded constraints,
Flutter returns an overflow warning:

```dart
UnconstrainedBox(
  child: Container(color: red, width: 4000, height: 50),
)
```

<img src="/assets/images/docs/ui/layout/layout-14.png" alt="When parents pass unbounded constraints to children, and the children are expanding, then there is an overflow warning.">

To learn how constraints work in Flutter,
see [Understanding constraints][].

### Design system

Because Flutter targets multiple platforms, your app doesn't need
to conform to any design system.
Though this guide features [Material][] widgets,
your Flutter app can use many different design systems:

- Custom Material widgets
- Community built widgets
- Your own custom widgets
- [Cupertino widgets][] that follow Apple's Human Interface Guidelines

<iframe width="560" height="315" src="{{site.yt.embed}}/3PdUaidHc-E?rel=0" title="Learn about the Cupertino Flutter Package" {{site.yt.set}}></iframe>

If you're looking for a great reference app that features a
custom design system, check out [Wonderous][].

## UI Basics

This section covers the basics of UI development in
Flutter and how it compares to SwiftUI.
This includes how to start developing your app, display static text,
create buttons, react to on-press events, display lists, grids, and more.

### Getting started

In **SwiftUI**, you use `App` to start your app.

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

Another common SwiftUI practice places the app body within a `struct`
that conforms to the `View` protocol as follows:

```swift
struct HomePage: View {
  var body: some View {
    Text("Hello, World!")
  }
}
```

To start your **Flutter** app, pass in an instance of your app to
the `runApp` function.

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

`App` is a widget. The build method describes the part of the
user interface it represents.
It's common to begin your app with a [`WidgetApp`][] class,
like [`CupertinoApp`][].

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

The widget used in `HomePage` might begin with the `Scaffold` class.
`Scaffold` implements a basic layout structure for an app.

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

Note how Flutter uses the [`Center`][] widget.
SwiftUI renders a view's contents in its center by default.
That's not always the case with Flutter.
`Scaffold` doesn't render its `body` widget at the center of the screen.
To center the text, wrap it in a `Center` widget.
To learn about different widgets and their default behaviors, check out
the [Widget catalog][].

### Adding Buttons

In **SwiftUI**, you use the `Button` struct to create a button.

```swift
Button("Do something") {
  // this closure gets called when your
  // button is tapped
}
```

To achieve the same result in **Flutter**,
use the `CupertinoButton` class:

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

<?code-excerpt "lib/text_button.dart (text-button)"?>
```dart
        CupertinoButton(
  onPressed: () {
    // This closure is called when your button is tapped.
  },
  child: const Text('Do something'),
)
```

**Flutter** gives you access to a variety of buttons with predefined styles.
The [`CupertinoButton`][] class comes from the Cupertino library.
Widgets in the Cupertino library use Apple's design system.

### Aligning components horizontally

In **SwiftUI**, stack views play a big part in designing your layouts.
Two separate structures allow you to create stacks:

1. `HStack` for horizontal stack views

2. `VStack` for vertical stack views

The following SwiftUI view adds a globe image and
text to a horizontal stack view:

```swift
HStack {
  Image(systemName: "globe")
  Text("Hello, world!")
}
```

**Flutter** uses [`Row`][] rather than `HStack`:

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
  children: [
    Icon(CupertinoIcons.globe),
    Text('Hello, world!'),
  ],
),
```

The `Row` widget requires a `List<Widget>` in the `children` parameter.
The `mainAxisAlignment` property tells Flutter how to position children
with extra space. `MainAxisAlignment.center` positions children in the
center of the main axis. For `Row`, the main axis is the horizontal
axis.

### Aligning components vertically

The following examples build on those in the previous section.

In **SwiftUI**, you use `VStack` to arrange the components into a
vertical pillar.

```swift
VStack {
  Image(systemName: "globe")
  Text("Hello, world!")
}
```

**Flutter** uses the same Dart code from the previous example,
except it swaps [`Column`][] for `Row`:

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
  children: [
    Icon(CupertinoIcons.globe),
    Text('Hello, world!'),
  ],
),
```

### Displaying a list view

In **SwiftUI**, you use the `List` base component to display sequences
of items.
To display a sequence of model objects, make sure that the user can
identify your model objects.
To make an object identifiable, use the `Identifiable` protocol.

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

This resembles how **Flutter** prefers to build its list widgets.
Flutter doesn't need the list items to be identifiable.
You set the number of items to display then build a widget for each item.

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

<?code-excerpt "lib/list.dart (simple-list)"?>
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

Flutter has some caveats for lists:

- The [`ListView`] widget has a builder method.
  This works like the `ForEach` within SwiftUI's `List` struct.

- The `itemCount` parameter of the `ListView` sets how many items
  the `ListView` displays.

- The `itemBuilder` has an index parameter that will be between zero
  and one less than itemCount.

The previous example returned a [`ListTile`][] widget for each item.
The `ListTile` widget includes properties like `height` and `font-size`.
These properties help build a list. However, Flutter allows you to return
almost any widget that represents your data.

### Displaying a grid

When constructing non-conditional grids in **SwiftUI**,
you use `Grid` with `GridRow`.

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

To display grids in **Flutter**, use the [`GridView`] widget.
This widget has various constructors. Each constructor has
a similar goal, but uses different input parameters.
The following example uses the `.builder()` initializer:

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

<?code-excerpt "lib/grid.dart (grid-example)"?>
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
          mainAxisExtent: 40,
        ),
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index],
      ),
    );
  }
}
```

The `SliverGridDelegateWithFixedCrossAxisCount` delegate determines
various parameters that the grid uses to lay out its components.
This includes `crossAxisCount` that dictates the number of items
displayed on each row.

How SwiftUI's `Grid` and Flutter's `GridView` differ in that `Grid`
requires `GridRow`. `GridView` uses the delegate to decide how the
grid should lay out its components.

### Creating a scroll view

In **SwiftUI**, you use `ScrollView` to create custom scrolling
components.
The following example displays a series of `PersonView` instances
in a scrollable fashion.

```swift
ScrollView {
  VStack(alignment: .leading) {
    ForEach(persons) { person in
      PersonView(person: person)
    }
  }
}
```

To create a scrolling view, **Flutter** uses [`SingleChildScrollView`][].
In the following example, the function `mockPerson` mocks instances
of the `Person` class to create the custom `PersonView` widget.

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

<?code-excerpt "lib/scroll.dart (scroll-example)"?>
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

In **SwiftUI**, you use `GeometryReader` to create relative view sizes.

For example, you could:

- Multiply `geometry.size.width` by some factor to set the _width_.
- Use `GeometryReader` as a breakpoint to change the design of your app.

You can also see if the size class has `.regular` or `.compact`
using `horizontalSizeClass`.

To create relative views in **Flutter**, you can use one of two options:

- Get the `BoxConstraints` object in the [`LayoutBuilder`][] class.
- Use the [`MediaQuery.of()`][] in your build functions
  to get the size and orientation of your current app.

To learn more, check out [Creating responsive and adaptive apps][].

### Managing state

In **SwiftUI**, you use the `@State` property wrapper to represent the
internal state of a SwiftUI view.

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

**SwiftUI** also includes several options for more complex state
management such as the `ObservableObject` protocol.

**Flutter** manages local state using a [`StatefulWidget`][].
Implement a stateful widget with the following two classes:

- a subclass of `StatefulWidget`
- a subclass of `State`

The `State` object stores the widget's state.
To change a widget's state, call `setState()` from the `State` subclass
to tell the framework to redraw the widget.

The following example shows a part of a counter app:

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

<?code-excerpt "lib/state.dart (state)"?>
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

To learn more ways to manage state, check out [State management][].

### Animations

Two main types of UI animations exist.

- Implicit that animated from a current value to a new target.
- Explicit that animates when asked.

#### Implicit Animation

SwiftUI and Flutter take a similar approach to animation.
In both frameworks, you specify parameters like `duration`, and `curve`.

In **SwiftUI**, you use the `animate()` modifier to handle implicit
animation.

```swift
Button("Tap me!"){
   angle += 45
}
.rotationEffect(.degrees(angle))
.animation(.easeIn(duration: 1))
```

**Flutter** includes widgets for implicit animation.
This simplifies animating common widgets.
Flutter names these widgets with the following format: `AnimatedFoo`.

For example: To rotate a button, use the [`AnimatedRotation`][] class.
This animates the `Transform.rotate` widget.

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

<?code-excerpt "lib/simple_animation.dart (animated-button)"?>
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

Flutter allows you to create custom implicit animations.
To compose a new animated widget, use the [`TweenAnimationBuilder`][].

#### Explicit Animation

For explicit animations, **SwiftUI** uses the `withAnimation()` function.

**Flutter** includes explicitly animated widgets with names formatted
like `FooTransition`.
One example would be the [`RotationTransition`][] class.

Flutter also allows you to create a custom explicit animation using
`AnimatedWidget` or `AnimatedBuilder`.

To learn more about animations in Flutter, see [Animations overview][].

### Drawing on the Screen

In **SwiftUI**, you use `CoreGraphics` to draw lines and shapes to the
screen.

**Flutter** has an API based on the `Canvas` class,
with two classes that help you draw:

1. [`CustomPaint`][] that requires a painter:

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

    <?code-excerpt "lib/canvas.dart (custom-paint)"?>
    ```dart
        CustomPaint(
      painter: SignaturePainter(_points),
      size: Size.infinite,
    ),
    ```

2. [`CustomPainter`][] that implements your algorithm to draw to the canvas.

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

    <?code-excerpt "lib/canvas.dart (custom-painter)"?>
    ```dart
    class SignaturePainter extends CustomPainter {
      SignaturePainter(this.points);
    
      final List<Offset?> points;
    
      @override
      void paint(Canvas canvas, Size size) {
        final Paint paint = Paint()
          ..color = Colors.black
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5;
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

This section explains how to navigate between pages of an app,
the push and pop mechanism, and more.

### Navigating between pages

Developers build iOS and macOS apps with different pages called
_navigation routes_.

In **SwiftUI**, the `NavigationStack` represents this stack of pages.

The following example creates an app that displays a list of persons.
To display a person's details in a new navigation link,
tap on that person.

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

If you have a small **Flutter** app without complex linking,
use [`Navigator`][] with named routes.
After defining your navigation routes,
call your navigation routes using their names.

1. Name each route in the class passed to the `runApp()` function.
   The following example uses `App`:

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

    <?code-excerpt "lib/navigation.dart (routes)"?>
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

   The following sample generates a list of persons using
   `mockPersons()`. Tapping a person pushes the person's detail page
   to the `Navigator` using `pushNamed()`.

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

    <?code-excerpt "lib/navigation.dart (list-view)"?>
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

1. Define the `DetailsPage` widget that displays the details of
   each person. In Flutter, you can pass arguments into the
   widget when navigating to the new route.
   Extract the arguments using `ModalRoute.of()`:

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

    <?code-excerpt "lib/navigation.dart (details-page)"?>
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

To create more advanced navigation and routing requirements,
use a routing package such as [go_router][].

To learn more, check out [Navigation and routing][].

### Manually pop back

In **SwiftUI**, you use the `dismiss` environment value to pop-back to
the previous screen.

```swift
Button("Pop back") {
        dismiss()
      }
```

In **Flutter**, use the `pop()` function of the `Navigator` class:

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

<?code-excerpt "lib/popback.dart (pop-back)"?>
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

In **SwiftUI**, you use the `openURL` environment variable to open a
URL to another application.

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

In **Flutter**, use the [`url_launcher`][] plugin.

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/openapp.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/openapp.dart (open-app-example)"?>
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

You can style Flutter apps with little effort.
Styling includes switching between light and dark themes,
changing the design of your text and UI components,
and more. This section covers how to style your apps.

### Using dark mode

In **SwiftUI**, you call the `preferredColorScheme()`
function on a `View` to use dark mode.

In **Flutter**, you can control light and dark mode at the app-level.
To control the brightness mode, use the `theme` property
of the `App` class:

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

<?code-excerpt "lib/cupertino_themes.dart (theme)"?>
```dart
    CupertinoApp(
  theme: CupertinoThemeData(
    brightness: Brightness.dark,
  ),
  home: HomePage(),
);
```

### Styling text

In **SwiftUI**, you use modifier functions to style text.
For example, to change the font of a `Text` string,
use the `font()` modifier:

```swift
Text("Hello, world!")
  .font(.system(size: 30, weight: .heavy))
  .foregroundColor(.yellow)
```

To style text in **Flutter**, add a `TextStyle` widget as the value
of the `style` parameter of the `Text` widget.

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

<?code-excerpt "lib/cupertino_themes.dart (styling-text)"?>
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

In **SwiftUI**, you use modifier functions to style buttons.

```swift
Button("Do something") {
    // do something when button is tapped
  }
  .font(.system(size: 30, weight: .bold))
  .background(Color.yellow)
  .foregroundColor(Color.blue)
}
```

To style button widgets in **Flutter**, set the style of its child,
or modify properties on the button itself.

In the following example:

- The `color` property of `CupertinoButton` sets its `color`.
- The `color` property of the child `Text` widget sets the button
  text color.

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

<?code-excerpt "lib/stylingbutton.dart (styling-button)"?>
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

### Using custom fonts

In **SwiftUI**, you can use a custom font in your app in two steps.
First, add the font file to your SwiftUI project. After adding the file,
use the `.font()` modifier to apply it to your UI components.

```swift
Text("Hello")
  .font(
    Font.custom(
      "BungeeSpice-Regular",
      size: 40
    )
  )
```

In **Flutter**, you control your resources with a file
named `pubspec.yaml`. This file is platform agnostic.
To add a custom font to your project, follow these steps:

1. Create a folder called `fonts` in the project's root directory.
   This optional step helps to organize your fonts.
1. Add your `.ttf`, `.otf`, or `.ttc` font file into the `fonts` folder.
1. Open the `pubspec.yaml` file within the project.
1. Find the `flutter` section.
1. Add your custom font(s) under the `fonts` section.

    ```yaml
    flutter:
      fonts:
        - family: BungeeSpice
          fonts:
            - asset: fonts/BungeeSpice-Regular.ttf
    ```

After you add the font to your project, you can use it as in the
following example:

<nav class="navbar bg-primary">
 <ul class="navbar-nav navbar-code ml-auto">
  <li class="nav-item">
    <a class="btn btn-navbar-code" href="{{site.repo.this}}/{{sample_path}}/lib/stylingbutton.dart">View on GitHub</a>
  </li>
</ul>
</nav>

<?code-excerpt "lib/stylingbutton.dart (custom-font)"?>
```dart
        Text(
  'Cupertino',
  style: TextStyle(
    fontSize: 40,
    fontFamily: 'BungeeSpice',
  ),
)
```

:::note
To download custom fonts to use in your apps,
check out [Google Fonts](https://fonts.google.com).
:::

### Bundling images in apps

In **SwiftUI**, you first add the image files to `Assets.xcassets`,
then use the `Image` view to display the images.

To add images in **Flutter**, follow a method similar to how you added
custom fonts.

1. Add an `images` folder to the root directory.
1. Add this asset to the `pubspec.yaml` file.

    ```yaml
    flutter:
      assets:
        - images/Blueberries.jpg
    ```

After adding your image, display it using the `Image` widget's
`.asset()` constructor. This constructor:

1. Instantiates the given image using the provided path.
1. Reads the image from the assets bundled with your app.
1. Displays the image on the screen.

To review a complete example, check out the [`Image`][] docs.

### Bundling videos in apps

In **SwiftUI**, you bundle a local video file with your app in two
steps.
First, you import the `AVKit` framework, then you instantiate a
`VideoPlayer` view.

In **Flutter**, add the [video_player][] plugin to your project.
This plugin allows you to create a video player that works on
Android, iOS, and on the web from the same codebase.

1. Add the plugin to your app and add the video file to your project.
1. Add the asset to your `pubspec.yaml` file.
1. Use the `VideoPlayerController` class to load and play your video
   file.

To review a complete walkthrough, check out the [video_player example][].

[Flutter for UIKit developers]: /get-started/flutter-for/uikit-devs
[Add Flutter to existing app]: /add-to-app
[Animations overview]: /ui/animations
[Cupertino widgets]: /ui/widgets/cupertino
[Flutter concurrency for Swift developers]: /get-started/flutter-for/dart-swift-concurrency
[Navigation and routing]: /ui/navigation
[Material]: {{site.material}}/develop/flutter/
[Platform adaptations]: /platform-integration/platform-adaptations
[`url_launcher`]: {{site.pub-pkg}}/url_launcher
[widget catalog]: /ui/widgets/layout
[Understanding constraints]: /ui/layout/constraints
[`WidgetApp`]: {{site.api}}/flutter/widgets/WidgetsApp-class.html
[`CupertinoApp`]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[`Center`]: {{site.api}}/flutter/widgets/Center-class.html
[`CupertinoButton`]: {{site.api}}/flutter/cupertino/CupertinoButton-class.html
[`Row`]: {{site.api}}/flutter/widgets/Row-class.html
[`Column`]: {{site.api}}/flutter/widgets/Column-class.html
[Learning Dart as a Swift Developer]: {{site.dart-site}}/guides/language/coming-from/swift-to-dart
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
[State management]:  /data-and-backend/state-mgmt
[Wonderous]: https://flutter.gskinner.com/wonderous/?utm_source=flutterdocs&utm_medium=docs&utm_campaign=iosdevs
[video_player]: {{site.pub-pkg}}/video_player
[video_player example]: {{site.pub-pkg}}/video_player/example
[Creating responsive and adaptive apps]: /ui/adaptive-responsive
[`MediaQuery.of()`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`CustomPaint`]: {{site.api}}/flutter/widgets/CustomPaint-class.html
[`CustomPainter`]: {{site.api}}/flutter/rendering/CustomPainter-class.html
[`Image`]: {{site.api}}/flutter/widgets/Image-class.html
[go_router]: {{site.pub-pkg}}/go_router
