---
title: DevTools
description: Learn to use the Dart DevTools when developing Flutter apps.
permalink: /tutorial/devtools/
sitemap: false
---

{%- comment %} TODO(ewindmill) embed video {%- endcomment %}

As your Flutter app grows in complexity, it becomes more important
to understand how each of the widgets properties affect the UI.
[Dart's DevTools][] assists you with two particularly useful features: the
**widget inspector** and the **property editor**.

First, launch DevTools by running the following commands while your app is running in debug mode:

```shell
$ flutter pub global activate devtools  # You only need to run this once
$ devtools
```

:::note Run in your IDE

You can also run DevTools directly inside [VS Code][] and [IntelliJ][],
provided you have the Flutter plugin installed. The screenshots in this lesson
are from VS Code.

:::

## The widget inspector

The widget inspector allows you to visualize and explore your widget tree. It
helps you understand the layout of your UI and identifies which widgets are
responsible for different parts of the screen. Running against the app you've
built so far, the inspector looks like this:

<img src='/assets/images/docs/tutorial/widget_inspector.png' alt="A screenshot of the Flutter widget inspector tool.">

Consider the `GamePage` widget you created in this section:

```dart
class GamePage extends StatelessWidget {
  const GamePage({super.key});

  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 5.0,
        children: [
          for (var guess in _game.guesses)
            Row(
              spacing: 5.0,
              children: [
              for (var letter in guess) Tile(letter, )
              ]
            ),
        ],
      ),
    );
  }
}
```

And how it's used in `MainApp`:

```dart
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: GamePage()),
      ),
    );
  }
}
```

In the widget inspector, you should see a tree of exactly the same
widgets that are in your code: `MaterialApp` as the root, with
`Scaffold` as its `home` and an `AppBar` as its `appBar`, and so on
down the entire tree to the `Row` widgets with `Tile` children. You
can select any widget in the tree to see its properties and even jump
to its source code in your IDE.

## Debugging layout issues

The widget inspector is perhaps most useful for debugging layout issues.

In certain situations, a widget's [constraints][] are unbounded, or
infinite. This means that either the maximum width or the maximum
height is set to [`double.infinity`][]. A widget that tries to be as
big as possible won't function usefully when given an unbounded
constraint and, in debug mode, throws an exception.

The most common case where a render box ends up with an unbounded
constraint is within a flex box widget ([`Row`][] or [`Column`][]),
and within a scrollable region (such as [`ListView`][] and other
[`ScrollView`][] subclasses). `ListView`, for example, tries to expand
to fit the space available in its cross-direction (perhaps it's a
vertically-scrolling block and tries to be as wide as its parent). If
you nest a vertically scrolling `ListView` inside a horizontally
scrolling `ListView`, the inner list tries to be as wide as possible,
which is infinitely wide, since the outer one is scrollable in that
direction.

Perhaps the most common error you'll run into while building a Flutter
application is due to incorrectly using layout widgets, and is
referred to as the "unbounded constraints" error.

Watch the following video to get an understanding of how to spot and
resolve this issue.

<YouTubeEmbed id="jckqXR5CrPI" title="Decoding Flutter: Unbounded height and width"></YouTubeEmbed>

## The property editor

When you select a widget in the widget inspector, the property editor
displays all the properties of that selected widget. This is a
powerful tool for understanding why a widget looks the way it does and
for experimenting with property value changes in real-time.

<img src='/assets/images/docs/tutorial/property_editor.png' alt="A screenshot of the Flutter property editor tool.">

Look at the `Tile` widget's `build` method from earlier:

```dart
class Tile extends StatelessWidget {
  const Tile(required this.letter, required hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.partial => Colors.yellow,
          HitType.miss => Colors.grey,
          _ => Colors.white,
        },
      ),
    );
  }
}
```

If you select a `Tile` widget in the Widget Inspector, the Property
Editor would show you its `width` (60), `height` (60), and the
`decoration` property. You could then expand the `BoxDecoration` to
see the `border` and `color` properties.

For many properties, you can even modify their values directly within the
property editor. For example, to quickly test how a different
`width` or `height` would look for your `Container` in the `Tile` widget,
 change the numerical value in the Property Editor and see the update
instantly on your running app without needing to recompile or even hot reload.
This allows for rapid iteration on UI design.

[Dart's DevTools]: /tools/devtools
[constraints]: /ui/layout/constraints
[`double.infinity`]:{{site.api}}/flutter/dart-core/double/infinity-constant.html
[`Column`]: {{site.api}}/flutter/widgets/Column-class.html
[`Row`]: {{site.api}}/flutter/widgets/Row-class.html
[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html
[`ScrollView`]: {{site.api}}/flutter/widgets/ScrollView-class.html
[VS Code]: /tools/vs-code
[IntelliJ]: /tools/android-studio
