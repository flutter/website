---
title: Flutter for Jetpack Compose Developers
description: Learn how to apply Jetpack Compose developer knowledge when building Flutter apps.
---

<?code-excerpt path-base="get-started/flutter-for/compose_devs"?>

{% assign sample_path = "blob/main/examples/get-started/flutter-for/compose_devs" %}

:::note
If you instead have experience building apps for Android with Views (XML),
see [Flutter for Android developers][].
:::

Flutter is a framework for building cross-platform applications
that uses the Dart programming language.

Your Jetpack Compose knowledge and experience
are highly valuable when building with Flutter.

:::tip
To integrate Flutter code into an **existing** Android app,
check out [Add Flutter to existing app][].
:::

This document can be used as a cookbook by jumping around
and finding questions that are most relevant to your needs.
This guide embeds sample code.
By using the "Open in DartPad" button that appears on hover or focus,
you can open and run some of the examples on DartPad.

## Overview

Flutter and Jetpack Compose code describe how the UI looks and works.
Developers call this type of code a _declarative framework_.

While there are key differences especially when it comes to 
interacting with legacy Android code, there are many commonalities
between the two frameworks.

### Composables vs. Widgets

**Jetpack Compose** represents UI components as _composable functions_,
later noted in this document as _composables_. Composables can be
altered or decorated through the use of _Modifier_ objects.

``` kotlin
Text("Hello, World!", 
   modifier: Modifier.padding(10.dp)
)
Text("Hello, World!",
    modifier = Modifier.padding(10.dp))
```

**Flutter** represents UI components as _widgets_.

Both composables and widgets only exist until they need to be changed.
These languages call this property _immutability_.
Jetpack Compose modifies UI component properties using an optional
_modifier_ property backed by a Modifier object.
By contrast, Flutter uses widgets for both UI components and
their properties.

```dart
Padding(                         // <-- This is a Widget
  padding: EdgeInsets.all(10.0), // <-- So is this
  child: Text("Hello, World!"),  // <-- This, too
)));
```

To compose layouts, both Jetpack Compose and Flutter nest UI components
within one another.
Jetpack Compose nests Composables while Flutter nests Widgets.

### Layout process

Jetpack Compose and Flutter handle layout in similar ways. Both of them
layout in a single pass and parent elements pass layout constraints 
down to their children. More specifically,

1. The parent measures itself and its children recursively providing 
   any constraints from the parent to the child.
2. The children try to size themselves using the above methods and 
provide their own children both their constraints and any that
may apply from their ancestor nodes.
3. Upon reacting a leaf node (a node with no children), the size
and properties are determined based on the provided constraints 
and the element is placed in the UI.
4. With all the children sized and placed, the root nodes can 
determine their measurement, size, and placement.

In both Jetpack Compose and Flutter, the parent component can override
or constrain the child's desired size. The widget cannot have any size it wants.
It also cannot _usually_ know or decide its position on screen as its parent
makes that decision.

To force a child widget to render at a specific size,
the parent must set tight constraints.
A constraint becomes tight when its constraint's minimum size value
equals its maximum size value.

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

If you're looking for a great reference app that features a
custom design system, check out [Wonderous][].

## UI Basics

This section covers the basics of UI development in
Flutter and how it compares to Jetpack Compose.
This includes how to start developing your app, display static text,
create buttons, react to on-press events, display lists, grids, and more.

### Getting started

For **Compose** apps, your main entry point will 
be _Activity_ or one of its descendants, 
generally _ComponentActivity_. 

```kotlin
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            SampleTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Greeting(
                        name = "Android",
                        modifier = Modifier.padding(innerPadding)
                    )
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}
```

To start your **Flutter** app, pass in an instance of your app to
the `runApp` function.

<?code-excerpt "../ios_devs/lib/get_started.dart (main)"?>
```dart dartpad="42cf3026e1460ef618257684ee5af6a2"
void main() {
  runApp(const MyApp());
}
```

`App` is a widget. The build method describes the part of the
user interface it represents.
It's common to begin your app with a [`WidgetApp`][] class,
like [`MaterialApp`][].

<?code-excerpt "../ios_devs/lib/get_started.dart (myapp)"?>
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns a CupertinoApp that, by default,
    // has the look and feel of an iOS app.
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
```

The widget used in `HomePage` might begin with the `Scaffold` class.
`Scaffold` implements a basic layout structure for an app.

<?code-excerpt "../ios_devs/lib/get_started.dart (homepage)"?>
```dart dartpad="42cf3026e1460ef618257684ee5af6a2"
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

Compose has a number of defaults from its ancestor Android Views.
Unless otherwise specified, most components "wrap" their size to
content meaning they only tak up as much space as needed to be 
drawn.
That's not always the case with Flutter.

To center the text, wrap it in a `Center` widget.
To learn about different widgets and their default behaviors, check out
the [Widget catalog][].

### Adding Buttons

In **Compose**, you use the `Button` composable or one of variants
to create a button. Button is an alias for FilledTonalButton
when using a Material theme.

```kotlin
Button(onClick = {}) {
    Text("Do something")
}
```

To achieve the same result in **Flutter**,
use the `FilledButton` class:

<?code-excerpt "../ios_devs/lib/text_button.dart (text-button)" replace="/child: //g;"?>
```dart dartpad="3c9b9a4de431b86725197a7fc2c84158"
FilledButton(
  onPressed: () {
    // This closure is called when your button is tapped.
  },
  const Text('Do something'),
),
```

**Flutter** gives you access to a variety of buttons with predefined styles.


### Aligning components horizontally
Jetpack Compose and Flutter handle horizontal and vertical collections of
items similarly.

The following Compose snippet adds a globe image and
text to a horizontal stack view:

```kotlin
Row(horizontalArrangement = Arrangement.Center) {
   Image(Icons.Default.Public, contentDescription = "")
   Text("Hello, world!")
}
```

**Flutter** uses [`Row`][] as well but the means of specifying
constraints and supplying child nodes differ somewhat:

<?code-excerpt "../ios_devs/lib/row.dart (row)" replace="/child: //g;"?>
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(Icons.public),
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

Likewise to both using [`Row`][] for horizontal arrangement,
Jetpack Compose and Flutter use [`Column`][] for vertical 
arrangement of components.

```kotlin
Column(verticalArrangement = Arrangement.Center) {
   Image(Icons.Default.Public, contentDescription = "")
   Text("Hello, world!")
}
```

<?code-excerpt "../ios_devs/lib/column.dart (column)" replace="/child: //g;"?>
```dart dartpad="d9a288be0c2a353296fc8825680b84b8"
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(MaterialIcons.globe),
    Text('Hello, world!'),
  ],
),
```

::: note
Whereas Flutter's `Row` and `Column` have `MainAxisAlignment` 
and `CrossAxisAlignment` to control how items are placed, the properties that
control placement in Jetpack Compose are one vertical and horizontal property
from the following: `verticalArrangement`, `verticalAlignment`,
`horizontalAlignment`, and `horizontalArrangement`. The trick to determine
which is the `MainAxis` is to look for the property that ends in `arrangement`. 
The `CrossAxis` will be the property that ends in `alightment`.
:::

### Displaying a list view

In **Compose**, you have a couple ways to create a list based on
the size of the list you need to display. For a small number of items 
that can all be displayed at once, you can iterate over a collection 
inside a `Column` or `Row`.

For a list with a large number of items, `LazyList` has better 
performance. It only lays out the components that will be visible
versus all of them.

```kotlin
data class Person(val name: String)

val people = arrayOf(
   Person(name = "Person 1"),
   Person(name = "Person 2"),
   Person(name = "Person 3")
)

@Composable
fun ListDemo(people: List<Person>) {
   Column {
      people.forEach {
         Text(it.name)
      }
   }
}

@Composable
fun ListDemo2(people: List<Person>) {
   LazyColumn {
      items(people) { person ->
         Text(person.name)
      }
   }
}
```

`ListView` in **Flutter** closely resembles LazyList
This resembles how **Flutter** prefers to build its list widgets.

<?code-excerpt "../ios_devs/lib/list.dart (simple-list)"?>
```dart dartpad="67426fd4f9c38c0c1db96b1af65598f2"
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
  This works like the `item` closure inside a Compose `LazyList`.

- The `itemCount` parameter of the `ListView` sets how many items
  the `ListView` displays.

- The `itemBuilder` has an index parameter that will be between zero
  and one less than itemCount.

The previous example returned a [`ListTile`][] widget for each item.
The `ListTile` widget includes properties like `height` and `font-size`.
These properties help build a list. However, Flutter allows you to return
almost any widget that represents your data.

### Displaying a grid

Constructing a grid in **Compose** is similar to a 
LazyList (`LazyColumn` or `LazyRow`). You may use the
same `items` closure. There are properties on each 
grid type to specify how the items will be arranged,
whether or not to use adaptive or fixed layout, 
amongst others.


```kotlin
val widgets = arrayOf(
        "Row 1",
        Icons.Filled.ArrowDownward,
        Icons.Filled.ArrowUpward,
        "Row 2",
        Icons.Filled.ArrowDownward,
        Icons.Filled.ArrowUpward
    )

    LazyVerticalGrid (
        columns = GridCells.Fixed(3),
        contentPadding = PaddingValues(8.dp)
    ) {
        items(widgets) { i ->
            if (i is String) {
                Text(i)
            } else {
                Image(i as ImageVector, "")
            }
        }
    }
```

To display grids in **Flutter**, use the [`GridView`] widget.
This widget has various constructors. Each constructor has
a similar goal, but uses different input parameters.
The following example uses the `.builder()` initializer:

<?code-excerpt "../ios_devs/lib/grid.dart (grid-example)"?>
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

Jetpack Compose's `Lazy___Grid` and Flutter's `GridView` are somewhat 
similar. `GridView` uses a delegate to decide how the grid  how the
grid should lay out its components. The `rows`, `columns`, and other
associated properties on `Lazy___Grid` serve the same purpose.

### Creating a scroll view

`LazyColumn` and `LazyRow` in **Jetpack Compose** have built-in 
support for scrolling.

To create a scrolling view, **Flutter** uses [`SingleChildScrollView`][].
In the following example, the function `mockPerson` mocks instances
of the `Person` class to create the custom `PersonView` widget.

<?code-excerpt "../ios_devs/lib/scroll.dart (scroll-example)" replace="/body: //g;"?>
```dart dartpad="a75740320989ed04020d95502a0de34e"
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

Adaptive Design in **Compose** is a complex topic with many 
viable solutions:
* Using a custom layout
* Using `WindowSizeClass` alone
* Using `BoxWithConstraints` to control what is shown based on
available space
* Using the Material 3 adaptive library that uses `WindowSizeClass`
along with specialized composable layouts for common layouts

For that reason, you are encouraged to look into the **Flutter**
options directly and see what fits your requirements versus 
attempting to find something that is a one to one translation.

To create relative views in **Flutter**, you can use one of two options:

- Get the `BoxConstraints` object in the [`LayoutBuilder`][] class.
- Use the [`MediaQuery.of()`][] in your build functions
  to get the size and orientation of your current app.

To learn more, check out [Creating responsive and adaptive apps][].

### Managing state

**Compose** stores state with the `remember` API and descendants
of the `MutableState` interface.

```kotlin
Scaffold(
   content = { padding ->
      var _counter = remember {  mutableIntStateOf(0) }
      Column(horizontalAlignment = Alignment.CenterHorizontally,
         verticalArrangement = Arrangement.Center,
         modifier = Modifier.fillMaxSize().padding(padding)) {
            Text(_counter.value.toString())
            Spacer(modifier = Modifier.height(16.dp))
            FilledIconButton (onClick = { -> _counter.intValue += 1 }) {
               Text("+")
            }
      }
   }
)
```


**Flutter** manages local state using a [`StatefulWidget`][].
Implement a stateful widget with the following two classes:

- a subclass of `StatefulWidget`
- a subclass of `State`

The `State` object stores the widget's state.
To change a widget's state, call `setState()` from the `State` subclass
to tell the framework to redraw the widget.

The following example shows a part of a counter app:

<?code-excerpt "../ios_devs/lib/state.dart (state)"?>
```dart dartpad="34815ab7d6ee0c5a45c82597df444450"
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


### Drawing on the Screen

In **Compose**, you use the `Canvas` composable to draw 
shapes, images, and text to the screen.

**Flutter** has an API based on the `Canvas` class,
with two classes that help you draw:

1. [`CustomPaint`][] that requires a painter:

    <?code-excerpt "../ios_devs/lib/canvas.dart (custom-paint)" replace="/child: //g;"?>
    ```dart dartpad="978d64ee66d54177fb639f8a9f801039"
    CustomPaint(
      painter: SignaturePainter(_points),
      size: Size.infinite,
    ),
    ```

2. [`CustomPainter`][] that implements your algorithm to draw to the canvas.

    <?code-excerpt "../ios_devs/lib/canvas.dart (custom-painter)"?>
    ```dart dartpad="978d64ee66d54177fb639f8a9f801039"
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

## Themes, styles, and media

You can style Flutter apps with little effort.
Styling includes switching between light and dark themes,
changing the design of your text and UI components,
and more. This section covers how to style your apps.

### Using dark mode

In **Compose**, you can control light and dark at any 
arbitrary level by wrapping a component with 
a Theme composable.

In **Flutter**, you can control light and dark mode at the app-level.
To control the brightness mode, use the `theme` property
of the `App` class:

```dart
const MaterialApp(
  theme: ThemeData(
    brightness: Brightness.dark,
  ),
  home: HomePage(),
);
```

### Styling text

In **Compose**, you use the properties on `Text` for one or two
attributes or construct `TextStyle` object to set many at once.

```kotlin
Text("Hello, world!", color = Color.Green,
        fontWeight = FontWeight.Bold, fontSize = 30.sp)
```
```kotlin
Text("Hello, world!", 
   style = TextStyle(
      color = Color.Green, 
      fontSize = 30.sp, 
      fontWeight = FontWeight.Bold
   ),
)
```

To style text in **Flutter**, add a `TextStyle` widget as the value
of the `style` parameter of the `Text` widget.

<?code-excerpt "lib/cupertino_themes.dart (styling-text)" replace="/child: //g;"?>
```dart dartpad="18790cfaa8441085994373a4bc4f46b0"
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

In **Compose**, you modify the colors of a button using 
the `colors` property. If left unmodified, they will
use the defaults from the current theme.

```kotlin
Button(onClick = {},
   colors = ButtonDefaults.buttonColors().copy(
      containerColor = Color.Yellow, contentColor = Color.Blue,
       )) {
    Text("Do something", fontSize = 30.sp, fontWeight = FontWeight.Bold)
}
```

To style button widgets in **Flutter**, you similarly 
set the style of its child, or modify properties on the button itself.

<?code-excerpt "lib/stylingbutton.dart (styling-button)"?>
```dart
FilledButton(
  onPressed: (){},
  style: FilledButton.styleFrom(backgroundColor: Colors.amberAccent),
  child: const Text(
    'Do something',
    style: TextStyle(
      color: Colors.blue,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    )
  )
)
```

### Using custom fonts

In **Compose**, you have two options for using fonts in your app.
You can use the downloadable fonts API to retrieve them at runtime 
from a service like Google Fonts. Alternatively, you can bundle 
them in you app by including them in the _res/fonts_
directory and creating an object to reference them in code.

You can then modify properties on composables that have related
properties or accept a `TextStyle`.

```kotlin
// Font files bunded with app
val firaSansFamily = FontFamily(
   Font(R.font.firasans_light, FontWeight.Light),
   Font(R.font.firasans_regular, FontWeight.Normal),
   Font(R.font.firasans_italic, FontWeight.Normal, FontStyle.Italic),
   Font(R.font.firasans_medium, FontWeight.Medium),
   Font(R.font.firasans_bold, FontWeight.Bold)
)

// Using Google Fonts
val provider = GoogleFont.Provider(
    providerAuthority = "com.google.android.gms.fonts",
    providerPackage = "com.google.android.gms",
    certificates = R.array.com_google_android_gms_fonts_certs
)

val bodyFontFamily = FontFamily(
    Font(
        googleFont = GoogleFont("Acme"),
        fontProvider = provider,
    )
)

val displayFontFamily = FontFamily(
    Font(
        googleFont = GoogleFont("Aboreto"),
        fontProvider = provider,
    )
)

// Usage
Text(text = "text", fontFamily = firaSansFamily, fontWeight = FontWeight.Light)
Text(text = "text", fontFamily = bodyFontFamily, fontWeight = FontWeight.Medium)
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

<?code-excerpt "lib/stylingbutton.dart (custom-font)" replace="/middle: //g;"?>
```dart
Text(
  'Flutter',
  style: TextStyle(
    fontSize: 40,
    fontFamily: 'BungeeSpice',
  ),
),
```

:::note
To download custom fonts to use in your apps,
check out [Google Fonts](https://fonts.google.com).
:::

### Bundling images in apps

In **Compose**, you first add the image files to the drawable directory
in resources `/res/drawable`, then use the `Image` composable to display
the images. Assets are referenced by using the resource locator
in the style of `R.drawable.<file name>` without the file extension.

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


[Flutter for Android developers]: /get-started/flutter-for/android-devs
[Add Flutter to existing app]: /add-to-app
[Material]: {{site.material}}/develop/flutter/
[Platform adaptations]: /platform-integration/platform-adaptations
[widget catalog]: /ui/widgets/layout
[Understanding constraints]: /ui/layout/constraints
[`WidgetApp`]: {{site.api}}/flutter/widgets/WidgetsApp-class.html
[`Center`]: {{site.api}}/flutter/widgets/Center-class.html
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
