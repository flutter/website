---
title: Technical Overview
---

## What is Flutter?

Flutter is a mobile app SDK for building high-performance, high-fidelity,
apps for iOS and Android, from a single codebase.

The goal is to enable developers to deliver high-performance apps that feel
natural on different platforms. We embrace differences in scrolling behaviors,
typography, icons, and more.

<object type="image/svg+xml" data="/images/whatisflutter/hero-shrine.svg" style="width: 100%; height: 100%;"></object>

This is a demo app from the
[Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery/lib/demo),
a collection of Flutter sample apps you can run after installing Flutter
and setting up your environment. Shrine has high-quality scrolling images,
interactive cards, buttons, dropdown lists, and a shopping cart page.
To look at the single codebase for this and more examples,
[visit our GitHub
repository](https://github.com/flutter/flutter/tree/master/examples).

No mobile development experience is required to get started. Apps are written
in [Dart](https://www.dartlang.org), which looks familiar if you've used a
language like Java or JavaScript. Experience with object-oriented languages
is definitely helpful, but even non-programmers have made Flutter apps!

## Why use Flutter?

What are some advantages of Flutter? It helps you:

*   Be highly productive
    *   Develop for iOS and Android from a single codebase
    *   Do more with less code, even on a single OS, with a modern, expressive
        language and a declarative approach
    *   Prototype and iterate easily
        *   Experiment by changing code and reloading as your app runs (with
            hot reload)
        *   Fix crashes and continue debugging from where the app left off
*   Create beautiful, highly-customized user experiences
    *   Benefit from a rich set of Material Design and Cupertino (iOS-flavor)
        widgets built using Flutter's own framework
    *   Realize custom, beautiful, brand-driven designs, without the
        limitations of OEM widget sets

## Core principles

Flutter includes a modern react-style framework, a 2D rendering engine,
ready-made widgets, and development tools. These components work together to help
you design, build, test, and debug apps. Everything is organized around a few core
principles.

### Everything's a Widget

Widgets are the basic building blocks of a Flutter app's user interface. Each widget is an
immutable declaration of part of the user interface.  Unlike other frameworks that
separate views, view controllers, layouts, and other properties, Flutter has a
consistent, unified object model: the widget.

A widget can define:

*   a structural element (like a button or menu)
*   a stylistic element (like a font or color scheme)
*   an aspect of layout (like padding)
*   and so on...

Widgets form a hierarchy based on composition.  Each widget nests inside, and
inherits properties from, its parent.  There is no separate "application" object.
Instead, the root widget serves this role.

You can respond to events, like user interaction, by telling the framework to
replace a widget in the hierarchy with another widget.  The framework then
compares the new and old widgets and efficiently updates the user interface.

#### Composition > inheritance

Widgets are themselves often composed of many small, single-purpose widgets that
combine to produce powerful effects.  For example, [Container](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/container.dart),
a commonly-used widget, is made up of several widgets responsible for layout,
painting, positioning, and sizing. Specifically, Container is made up of
[LimitedBox](https://docs.flutter.io/flutter/widgets/LimitedBox-class.html),
[ConstrainedBox](https://docs.flutter.io/flutter/widgets/ConstrainedBox-class.html),
[Align](https://docs.flutter.io/flutter/widgets/Align-class.html),
[Padding](https://docs.flutter.io/flutter/widgets/Padding-class.html),
[DecoratedBox](https://docs.flutter.io/flutter/widgets/DecoratedBox-class.html),
and [Transform](https://docs.flutter.io/flutter/widgets/Transform-class.html)
widgets.  Rather than subclassing Container to produce a customized effect, you
can compose these, and other, simple widgets in novel ways.

The class hierarchy is shallow and broad to maximize the possible number of
combinations.

<object type="image/svg+xml" data="/images/whatisflutter/diagram-widgetclass.svg" style="width: 100%; height: 100%;"></object>

You can also control the *layout* of a widget by composing it with other widgets.
For example, to center a widget, you wrap it in a Center widget. There are
widgets for padding, alignment, row, columns, and grids. These layout widgets
do not have a visual representation of their own. Instead, their sole purpose is to
control some aspect of another widget's layout. To understand why a widget
renders in a certain way, it's often helpful to inspect the neighboring widgets.

#### Layer cakes are delicious

The Flutter framework is organized into a series of layers, with each layer
building upon the previous layer.

<object type="image/svg+xml" data="/images/whatisflutter/diagram-layercake.svg" style="width: 85%; height: 85%"></object>

The upper layers of the framework are used more frequently than the lower
layers. For the complete set of libraries that make up
the Flutter's layered framework, see our
[API documentation](https://docs.flutter.io).

The goal of this design is to help you do more with less code.  For example,
the Material layer is built by composing basic widgets from the widgets layer,
and the widgets layer itself is built by orchestrating lower-level objects from
the rendering layer.

The layers offer many options for building apps. Choose a customized approach to
unlock the full expressive power of the framework, or use building blocks from
the widgets layer, or mix and match. You can compose the ready-made widgets
Flutter provides, or create your own custom widgets using the same tools and
techniques that the Flutter team used to build the framework.

Nothing is hidden from you.  You reap the productivity benefits of a high-level,
unified widget concept, without sacrificing the ability to dive as deeply as you
wish into the lower layers.

### Building widgets

You define the unique characteristics of a widget by implementing a
[build](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html)
function that returns a tree (or hierarchy) of widgets. This tree represents
the widget's part of the user interface in more concrete terms.
For example, a toolbar widget might have a build function that returns
a [horizontal layout](https://docs.flutter.io/flutter/widgets/Row-class.html)
of some [text](https://docs.flutter.io/flutter/widgets/Text-class.html) and
[various](https://docs.flutter.io/flutter/material/IconButton-class.html)
[buttons](https://docs.flutter.io/flutter/material/PopupMenuButton-class.html).
The framework then recursively asks each of these widgets to build until the
process bottoms out in [fully concrete
widgets](https://docs.flutter.io/flutter/widgets/RenderObjectWidget-class.html),
which the framework then stitches together into a tree.

A widget's build function should be free of side effects.  Whenever it is asked
to build, the widget should return a new tree of widgets regardless of what the
widget previously returned. The framework does the heavily lifting of comparing
the previous build with the current build and determining what modifications
need to be made to the user interface.

This automated comparison is quite effective, enabling high-performance,
interactive apps. And the design of the build function simplifies your code by
focusing on declaring what a widget is made of, rather than the complexities of
updating the user interface from one state to another.

### Handling user interaction

If the unique characteristics of a widget need to change based on user
interaction or other factors, that widget is *stateful*. For example, if a
widget has a counter that increments whenever the user taps a button, the value
of the counter is the state for that widget. When that value changes, the widget
needs to be rebuilt to update the UI.

These widgets subclass
[StatefulWidget](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html)
(rather than
[StatelessWidget](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html))
and store their mutable state in a subclass of
[State](https://docs.flutter.io/flutter/widgets/State-class.html).

<object type="image/svg+xml" data="/images/whatisflutter/diagram-state.svg" style="width: 85%; height: 85%"></object>

Whenever you mutate a State object (e.g., increment the counter), you must call
[setState](https://docs.flutter.io/flutter/widgets/State/setState.html)() to
signal the framework to update the user interface by calling the State's build
method again. For an example of managing state, see the
[MyApp template](https://github.com/flutter/flutter/blob/master/packages/flutter_tools/templates/app/lib/main.dart.tmpl)
that's created with each new Flutter project.

Having separate state and widget objects lets other widgets treat stateless and
stateful widgets in the same way, without being concerned about losing state.
Rather than needing to hold on to a child to preserve its state, the parent is
free to create a new instance of the child without losing the child's persistent
state. The framework does all the work of finding and reusing existing state
objects when appropriate.

## Try it!

Now that you're familiar with the basic structure and principles of the Flutter
framework, along with how to build apps and make them interactive, you're ready
to start developing and iterating.

Next steps:

1.  [Follow the Flutter Getting Started guide](/docs/get-started).
1.  Try [Building Layouts in Flutter](/docs/development/ui/layout) and
    [Adding Interactivity to Your Flutter App](/docs/development/ui/interactive).
1.  Follow a detailed example in [Tour of the Widget
    Framework](/docs/development/ui/widgets-intro).

## Get support

Track the Flutter project and join the conversation in a variety of ways.
We're open source and would love to hear from you.

- [Ask HOWTO questions that can be answered with specific solutions][so]
- [Live chat with Flutter engineers and users][gitter]
- [Discuss Flutter, best practices, app design, and more on our mailing list][mailinglist]
- [Report bugs, request features and docs][issues]
- [Follow us on Twitter: @flutterio](https://twitter.com/flutterio/)


[issues]: https://github.com/flutter/flutter/issues
[apidocs]: https://docs.flutter.io
[so]: https://stackoverflow.com/tags/flutter
[mailinglist]: https://groups.google.com/d/forum/flutter-dev
[gitter]: https://gitter.im/flutter/flutter
