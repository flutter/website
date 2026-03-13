---
title: "Dot shorthands in Flutter"
description: "Learn how to use Dart's dot shorthands to write cleaner, concise Flutter code."
---

The **dot shorthands** feature allows you to omit the explicit type when
accessing static members, constructors, or enum values, provided the compiler
can infer the type from the surrounding context.

:::note
For n technical overview of this feature, refer to the
[Dot Shorthands guide](https://dart.dev/language/dot-shorthand) in the Dart
documentation.
:::

## Why dot shorthands matter

Building layouts in Flutter often involves deeply nested widget trees.
Historically, this meant repeatedly typing explicit class and enum names for
properties like colors, typography, and alignment. Dot shorthands reduce this
boilerplate, making your code easier to read and faster to write.

Here is a side-by-side comparison of building a simple `Container`:

### Without dot shorthands
```dart
Container(
  color: Colors.blue,
  alignment: Alignment.center,
  padding: const EdgeInsets.all(16.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Hello World',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
);
```

### With dot shorthands
```dart
Container(
  color: .blue, // Instead of Colors.blue
  alignment: .center, // Instead of Alignment.center
  padding: const .all(16.0), // Instead of EdgeInsets.all(16.0)
  child: Column(
    mainAxisAlignment: .center, // Instead of MainAxisAlignment.center
    crossAxisAlignment: .start, // Instead of CrossAxisAlignment.start
    children: [
      Text(
        'Hello World',
        style: TextStyle(
          fontWeight: .bold, // Instead of FontWeight.bold
        ),
      ),
    ],
  ),
);
```

## Where to use dot shorthands

Dot shorthands work anywhere the Dart compiler has a clear "context type",
meaning it knows exactly what type it expects. In Flutter, this is almost
everywhere inside a widget's property list. 

The most common targets for dot shorthands in Flutter are:

*   **Enums**: `MainAxisAlignment`, `CrossAxisAlignment`, `BoxFit`, `TextDirection`.
*   **Static properties and methods**: `Colors`, `Icons`, `Alignment`. 
*   **Constructors**: `EdgeInsets.all()`, `BorderRadius.circular()`.

### Example: enums

When a property expects an enum, such as `mainAxisAlignment`, you can omit the
enum's name and just provide the value preceded by a dot (`.`):

```dart
Row(
  mainAxisAlignment: .spaceEvenly, // Infers MainAxisAlignment.spaceEvenly
  children: [ /* ... */ ],
)
```

### Example: static properties

`Colors.green` and `Alignment.bottomRight` are static properties on their
respective classes. Since `color` expects a `Color` object, you can just write
`.green`:

```dart
DecoratedBox(
  decoration: BoxDecoration(
    color: .green, // Infers Colors.green
  ),
  child: Align(
    alignment: .bottomRight, // Infers Alignment.bottomRight
    child: FlutterLogo(),
  ),
)
```

### Example: constructors

You can also use dot shorthands for named constructors. A common case is
`EdgeInsets`:

```dart
Padding(
  padding: .symmetric(horizontal: 16.0, vertical: 8.0), // Infers EdgeInsets.symmetric
  child: Text('Spaced out text'),
)
```

You can even use `.new` to call an unnamed constructor, though this is less
common in standard widget trees:

```dart
class _MyState extends State<MyWidget> {
  final ScrollController _scrollController = .new(); // Infers ScrollController()
  // ...
}
```
