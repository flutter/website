---
title: Technical overview
---

## What is Flutter?

Flutter is an app SDK for building high-performance,
high-fidelity apps for iOS, Android, and web
([early access][]) from a single codebase.

The goal is to enable developers to deliver high-performance
apps that feel natural on different platforms.
We embrace differences in scrolling behaviors, typography,
icons, and more.

<object type="image/svg+xml" data="/images/whatisflutter/hero-shrine.svg" style="width: 100%; height: 100%;"></object>

This is a demo app from the [Flutter Gallery][],
a collection of Flutter sample apps you can run after
installing Flutter and setting up your environment.
Shrine has high-quality scrolling images,
interactive cards, buttons, dropdown lists, and a shopping cart page.
To look at the single codebase for this and more examples,
[visit our GitHub repository][].

No mobile development experience is required to get started.
Apps are written in [Dart][], which looks familiar if you've used a
language like Java or JavaScript.
Experience with object-oriented languages is definitely helpful,
but even non-programmers have made Flutter apps!

## Why use Flutter?

What are some advantages of Flutter? It helps you:

*   Be highly productive
    *   Develop for iOS and Android from a single codebase
    *   Do more with less code, even on a single OS, with a modern, expressive
        language and a declarative approach
    *   Prototype and iterate easily
        *   Experiment by changing code and reloading as your app runs
            (with hot reload)
        *   Fix crashes and continue debugging from where the app left off
*   Create beautiful, highly-customized user experiences
    *   Benefit from a rich set of Material Design and Cupertino (iOS-flavor)
        widgets built using Flutter's own framework
    *   Realize custom, beautiful, brand-driven designs, without the
        limitations of OEM widget sets

## Core principles

Flutter includes a modern react-style framework,
a 2D rendering engine, ready-made widgets, and development tools.
These components work together to help you design, build, test,
and debug apps. Everything is organized around a few core principles.

### Everything's a widget

Widgets are the basic building blocks of a Flutter app's
user interface. Each widget is an immutable declaration
of part of the user interface. Unlike other frameworks that
separate views, view controllers, layouts, and other properties,
Flutter has a consistent, unified object model: the widget.

A widget can define:

*   a structural element (like a button or menu)
*   a stylistic element (like a font or color scheme)
*   an aspect of layout (like padding)
*   and so on...

Widgets form a hierarchy based on composition.
Each widget nests inside, and inherits properties from,
its parent.  There is no separate "application" object.
Instead, the root widget serves this role.

You can respond to events, like user interaction,
by telling the framework to replace a widget in the
hierarchy with another widget. The framework then
compares the new and old widgets and efficiently updates
the user interface.

#### Composition > inheritance

Widgets are themselves often composed of many small,
single-purpose widgets that combine to produce powerful effects.
For example, [`Container`][], a commonly-used widget,
is made up of several widgets responsible for layout,
painting, positioning, and sizing.
Specifically, `Container` is made up of [`LimitedBox`][],
[`ConstrainedBox`][], [`Align`][], [`Padding`][],
[`DecoratedBox`][], and [`Transform`][] widgets.
Rather than subclassing `Container` to produce a customized
effect, you can compose these, and other,
simple widgets in novel ways.

The class hierarchy is shallow and broad to maximize the
possible number of combinations.

<object type="image/svg+xml" data="/images/whatisflutter/diagram-widgetclass.svg" style="width: 100%; height: 100%;"></object>

You can also control the *layout* of a widget by composing
it with other widgets.  For example, to center a widget,
you wrap it in a `Center` widget. There are widgets for padding,
alignment, row, columns, and grids. These layout widgets
do not have a visual representation of their own.
Instead, their sole purpose is to control some aspect of
another widget's layout. To understand why a widget renders
in a certain way, it's often helpful to inspect the neighboring widgets.

#### Layer cakes are delicious

The Flutter framework is organized into a series of layers,
with each layer building upon the previous layer.

<object type="image/svg+xml" data="/images/whatisflutter/diagram-layercake.svg" style="width: 85%; height: 85%"></object>

The upper layers of the framework are used more frequently
than the lower layers. For the complete set of libraries that make up
the Flutter's layered framework, see our [API documentation][].

The goal of this design is to help you do more with less code.
For example, the Material layer is built by composing basic
widgets from the widgets layer, and the widgets layer itself
is built by orchestrating lower-level objects from the rendering layer.

The layers offer many options for building apps.
Choose a customized approach to unlock the full expressive
power of the framework, or use building blocks from
the widgets layer, or mix and match.
You can compose the ready-made widgets Flutter provides,
or create your own custom widgets using the same tools and
techniques that the Flutter team used to build the framework.

Nothing is hidden from you.
You reap the productivity benefits of a high-level,
unified widget concept, without sacrificing the ability
to dive as deeply as you wish into the lower layers.

### Building widgets

You define the unique characteristics of a widget by
implementing a [`build()`][] function that returns
a tree (or hierarchy) of widgets. This tree represents
the widget's part of the user interface in more concrete terms.
For example, a toolbar widget might have a build function that returns
a [horizontal layout][] of some [text][] and [various][] [buttons][].
The framework then recursively asks each of these widgets to build until the
process bottoms out in [fully concrete widgets][],
which the framework then stitches together into a tree.

A widget's build function should be free of side effects.
Whenever it is asked to build, the widget should return a
new tree of widgets regardless of what the widget previously
returned. The framework does the heavily lifting of comparing
the previous build with the current build and determining
what modifications need to be made to the user interface.

This automated comparison is quite effective,
enabling high-performance, interactive apps.
And the design of the build function simplifies your code by
focusing on declaring what a widget is made of,
rather than the complexities of updating the user
interface from one state to another.

### Handling user interaction

If the unique characteristics of a widget need to change
based on user interaction or other factors,
that widget is *stateful*. For example, if a widget has
a counter that increments whenever the user taps a button,
the value of the counter is the state for that widget.
When that value changes,
the widget needs to be rebuilt to update the UI.

These widgets subclass
[`StatefulWidget`][] (rather than [`StatelessWidget`][])
and store their mutable state in a subclass of [`State`][].

<object type="image/svg+xml" data="/images/whatisflutter/diagram-state.svg" style="width: 85%; height: 85%"></object>

Whenever you mutate a `State` object
(for example, by incrementing the counter), you must call
[`setState()`] to signal the framework to update the user
interface by calling the `State`'s build method again.
For an example of managing state, see the [MyApp template][]
that's created with each new Flutter project.

Having separate state and widget objects lets other widgets
treat stateless and stateful widgets in the same way,
without being concerned about losing state.
Rather than needing to hold on to a child to preserve its state,
the parent is free to create a new instance of the child
without losing the child's persistent state.
The framework does all the work of finding and reusing
existing state objects when appropriate.

## Try it!

Now that you're familiar with the basic structure and
principles of the Flutter framework,
along with how to build apps and make them interactive,
you're ready to start developing and iterating.

Next steps:

1. Try the [layout codelab][].
   (It doesn't require downloading Flutter or Dart!)
1. [Install Flutter][].
1. Check out the Flutter [cookbook][].
1. Check out the Flutter [examples][].
1. Try another of the Flutter [codelabs][].
1. Try the [Flutter tutorials][].
1. Follow a detailed example in the
   [tour of the widget framework][].
1. Check out Flutter's [technical videos][].

## Get support

Track the Flutter project and join the conversation in a variety of ways.
Flutter is open source and encourages dialog, so long as it follows
Flutter's [code of conduct][].

* Ask how-to questions that can be answered with specific solutions
  on [Stack Overflow][].
* Live chat with Flutter engineers and users on [Discord][] (preferred)
  or [gitter][].
* Discuss Flutter, best practices, app design,
  and more on the [flutter-dev][] mailing list.
* Subscribe to the [flutter-announce][] mailing list
  to be notified of changes to the framework.
* Report bugs, request features and docs on [GitHub][].
* Follow us on Twitter [@flutterdev][].


[`Align`]: {{site.api}}/flutter/widgets/Align-class.html
[API documentation]: {{site.api}}
[`build()`]: {{site.api}}/flutter/widgets/StatelessWidget/build.html
[buttons]: {{site.api}}/flutter/material/PopupMenuButton-class.html
[code of conduct]: {{site.github}}/flutter/blob/master/CODE_OF_CONDUCT
[codelabs]: /docs/codelabs
[`ConstrainedBox`]: {{site.api}}/flutter/widgets/ConstrainedBox-class.html
[`Container`]: {{site.api}}/flutter/widgets/Container-class.html
[cookbook]: /docs/cookbook
[Dart]: {{site.dart-site}}
[`DecoratedBox`]: {{site.api}}/flutter/widgets/DecoratedBox-class.html
[Discord]: https://discord.gg/N7Yshp4
[early access]: /web
[examples]: {{site.github}}/flutter/samples/blob/master/INDEX.md
[@flutterdev]: https://twitter.com/flutterdev
[fully concrete widgets]: {{site.api}}/flutter/widgets/RenderObjectWidget-class.html
[Flutter tutorials]: /docs/reference/tutorials
[Flutter Gallery]: {{site.github}}/flutter/flutter/tree/master/examples/flutter_gallery/lib/demo
[flutter-announce]: {{site.groups}}/forum/#!forum/flutter-announce
[flutter-dev]: {{site.groups}}/d/forum/flutter-dev
[GitHub]: {{site.github}}/flutter/flutter/issues
[gitter]: https://gitter.im/flutter/flutter
[horizontal layout]: {{site.api}}/flutter/widgets/Row-class.html
[Install Flutter]: /docs/get-started/install
[layout codelab]: /docs/codelabs/layout-basics
[`LimitedBox`]: {{site.api}}/flutter/widgets/LimitedBox-class.html
[`Padding`]: {{site.api}}/flutter/widgets/Padding-class.html
[MyApp template]: {{site.github}}/flutter/flutter/blob/master/packages/flutter_tools/templates/app/lib/main.dart.tmpl
[`setState()`]: {{site.api}}/flutter/widgets/State/setState.html
[Stack Overflow]: {{site.so}}/tags/flutter
[`State`]: {{site.api}}/flutter/widgets/State-class.html
[`StatefulWidget`]: {{site.api}}/flutter/widgets/StatefulWidget-class.html
[`StatelessWidget`]: {{site.api}}/flutter/widgets/StatelessWidget-class.html
[technical videos]: /docs/resources/videos
[text]: {{site.api}}/flutter/widgets/Text-class.html
[tour of the widget framework]: /docs/development/ui/widgets-intro
[`Transform`]: {{site.api}}/flutter/widgets/Transform-class.html
[various]: {{site.api}}/flutter/material/IconButton-class.html
[visit our GitHub repository]: {{site.github}}/flutter/flutter/tree/master/examples
