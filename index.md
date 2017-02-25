---
title: Welcome to Flutter
sidebar: home_sidebar
layout: page
---

Flutter is a new project to help developers build high-performance, high-fidelity, mobile apps for
iOS and Android from a single codebase.

{% include note.html content="_Flutter is an early-stage open-source project_. We hope you try Flutter out and send us [feedback](mailto:flutter-dev@googlegroups.com)." %}

## What is Flutter?

Flutter provides an easy and productive way to build and deploy high-performance 
mobile apps for Android and iOS. The goal is to deliver apps that feel natural 
on different platforms, and we embrace differences like scrolling behavior, 
overscroll behaviors, and more. 

![Shrine, iOS left and Android right](/images/whatisflutter/shrine_both.png)

This is an online marketplace app from the [Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery/lib/demo), 
a showcase of Flutter apps to download and run on a phone. Shrine has 
high-quality scrolling images, interactive cards, buttons and dropdown lists, 
and a shopping cart page. Run Shrine on an iPhone or Android phone, then check
out the single codebase for this and more examples [here](https://github.com/flutter/flutter/tree/master/examples) 
in our github repository.

No mobile development experience is required to get started. Apps are written 
in [Dart](https://dartlang.org), which will look familiar if you've used a 
language like Java or JavaScript. Experience with object-oriented languages 
is definitely helpful, but even non-programmers have made Flutter apps!

## Why use Flutter?

What are some advantages of Flutter? It helps you:

*   Be highly productive
    *   Develop for iOS and Android from a single codebase
    *   Do more with less code, even on a single OS, with a modern, expressive 
language and a declarative approach
*   Prototype and iterate quickly
    *   Experiment by changing code and reloading as your app runs
    *   Fix crashes and continue debugging from where the app left off
*   Create beautiful, highly-customized user experiences
    *   Leverage a complete set of self-referential Material Design widgets
    *   Realize whatever visual design you have in mind, without the limitations 
of OEM widget sets

## Core principles

Flutter includes a functional-reactive framework, a 2D rendering engine, ready-
made widgets, and development tools. The components work together to help you 
design, build, test, and debug apps. Everything is organized around a few core 
principles. 

### Everything's a Widget

Widgets are the basic building blocks of every Flutter app. Each widget is an 
immutable declaration of part of a user interface.  Unlike other frameworks that 
separate views, controllers, layouts, and other properties, Flutter has a 
consistent, unified object model: the widget.

A widget can define:

*   a structural element (like a button or menu)
*   a stylistic element (like a font or color scheme)
*   an aspect of layout (like padding)
*   some business logic 
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

![Widget class hierarchy](/images/whatisflutter/Widget_class_hierarchy.png){:style="max-width: 900px"}

You can also control the *layout* of a widget by composing it with other widgets.
For example, to center a widget, you wrap it in a Center widget. There are
widgets for padding, alignment, row, columns, and grids. These layout widgets
do not show themselves in an app's UI.  Instead, their sole purpose is to
control some aspect of another widget's layout. To understand why a widget
renders in a certain way, it's often helpful to inspect the neighboring widgets.

#### Layer cakes are fun and functional

The Flutter framework is organized into a series of layers, with each layer
building upon the previous layer.

{% include layer-cake.html %}

The diagram shows the upper layers of the framework, which are used more 
frequently than the lower layers. For the complete set of libraries, see 
Flutter's [API documentation](https://docs.flutter.io).

The goal of this design is to help you do more with less code.  For example,
the material layer is built by composing basic widgets from the widgets layer,
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
function that returns a tree of widgets. This tree represents the widget's part 
of the user interface in concrete terms.  For example, a toolbar widget might 
have a build function that returns a [horizontal layout](https://docs.flutter.io/flutter/widgets/Row-class.html)
of some [text](https://docs.flutter.io/flutter/widgets/Text-class.html) and
[various](https://docs.flutter.io/flutter/material/IconButton-class.html)
[buttons](https://docs.flutter.io/flutter/material/PopupMenuButton-class.html). 
The framework then recursively asks each of these widgets to build until the
process bottoms out in [fully concrete widgets](https://docs.flutter.io/flutter/widgets/RenderObjectWidget-class.html),
which framework then stitches together into a tree.

A widget's build function should be free of side effects.  Whenever it is asked 
to build, the widget should return a new tree of widgets regardless of what the 
widget previously returned. The framework does the heavily lifting of comparing 
the previous build with the current build and determining what modifications 
need to be made to the user interface. 

This automated comparison is surprisingly effective, enabling high-performance,
interactive apps. And the design of the build function simplifies your code by
focusing on declaring what a widget is made of, rather than the complexities of
updating the user interface from one state to another.

### Handling user interaction

If the unique characteristics of a widget need to change based on user 
interaction or other factors, that widget is *stateful*. For example, if a 
widget has a counter that increments whenever the user taps a button, the value 
of the counter is the state for that widget. When that value changes, the widget 
needs to be rebuilt to update the UI.

These widgets subclass [StatefulWidget](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html)
(rather than [StatelessWidget](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html))
and store their mutable state in a subclass of [State](https://docs.flutter.io/flutter/widgets/State-class.html).

![Separate state and widget objects](/images/whatisflutter/state.png)

Whenever you mutate a State object (e.g., increment the counter), you must call
[setState](https://docs.flutter.io/flutter/widgets/State/setState.html)() to 
signal the framework to update the user interface by calling the State build 
method again. For an example of managing state, see the [MyApp template](https://github.com/flutter/flutter/blob/fa2caa737bdde4d72525d9d4260abb0ba5548c01/packages/flutter_tools/templates/create/lib/main.dart.tmpl) that's created with each new Flutter project.

Having separate state and widget objects lets other widgets treat stateless and 
stateful widgets in the same way, without being concerned about losing state. 
Rather than needing to hold on to the child to preserve its state, the parent is
free to create a new instances of the child without losing the child's persistent
state. The framework does all the work of finding and reusing existing state 
objects when appropriate.

## Try it!

Now that you're familiar with the basic structure and principles of the Flutter
framework, along with how to build apps and make them interactive, you're ready
to start developing and iterating. 

Next steps:

1.  [Install the Flutter SDK](https://flutter.io/setup/) and [set up IntelliJ](https://flutter.io/intellij-setup/) (optional).
1.  [Get started](https://flutter.io/getting-started/) with the development cycle in a few simple steps.
1.  Follow a detailed example in [Tour of the Widget Framework](https://flutter.io/widgets-intro/).

## Get support

Track the Flutter project and join the conversation in a variety of ways.
We're open source and would love to hear from you.

- [Ask HOWTO questions that can be answered with specific solutions][so]
- [Live chat with Flutter engineers and users][gitter]
- [Discuss Flutter, best practices, app design, and more on our mailing list][mailinglist]
- [Report bugs, request features and docs][issues]
- [Follow us on Twitter: @flutterio](https://twitter.com/flutterio)


[issues]: https://github.com/flutter/flutter/issues
[apidocs]: https://docs.flutter.io
[so]: https://stackoverflow.com/tags/flutter
[mailinglist]: https://groups.google.com/d/forum/flutter-dev
[gitter]: https://gitter.im/flutter/flutter
