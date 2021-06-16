---
title: Flutter architectural overview
description: A high-level overview of the architecture of Flutter, including the core principles and concepts that form its design.
---

<?code-excerpt path-base="../null_safety_examples/resources/architectural_overview/"?>

This article is intended to provide a high-level overview of the architecture of
Flutter, including the core principles and concepts that form its design.

Flutter is a cross-platform UI toolkit that is designed to allow code reuse
across operating systems such as iOS and Android, while also allowing
applications to interface directly with underlying platform services. The goal
is to enable developers to deliver high-performance apps that feel natural on
different platforms, embracing differences where they exist while sharing as
much code as possible.

During development, Flutter apps run in a VM that offers stateful hot reload of
changes without needing a full recompile. For release, Flutter apps are compiled
directly to machine code, whether Intel x64 or ARM instructions, or to
JavaScript if targeting the web. The framework is open source, with a permissive
BSD license, and has a thriving ecosystem of third-party packages that
supplement the core library functionality.

This overview is divided into a number of sections:

1. The **layer model**: The pieces from which Flutter is constructed.
1. **Reactive user interfaces**: A core concept for Flutter user interface
   development.
1. An introduction to **widgets**: The fundamental building blocks of Flutter user
   interfaces.
1. The **rendering process**: How Flutter turns UI code into pixels.
1. An overview of the **platform embedders**: The code that lets mobile and
   desktop OSes execute Flutter apps.
1. **Integrating Flutter with other code**: Information about different techniques
   available to Flutter apps.
1. **Support for the web**: Concluding remarks about the characteristics of
   Flutter in a browser environment.

## Architectural layers

Flutter is designed as an extensible, layered system. It exists as a series of
independent libraries that each depend on the underlying layer. No layer has
privileged access to the layer below, and every part of the framework level is
designed to be optional and replaceable.

{% comment %}
The PNG diagrams in this document were created using draw.io. The draw.io
metadata is embedded in the PNG file itself, so you can open the PNG directly
from draw.io to edit the individual components.

The following settings were used:

 - Select all (to avoid exporting the canvas itself)
 - Export as PNG, zoom 300% (for a reasonable sized output)
 - Enable _Transparent Background_
 - Enable _Selection Only_, _Crop_
 - Enable _Include a copy of my diagram_

{% endcomment %}

![Architectural
diagram](/images/arch-overview/archdiagram.png){:width="100%"}

To the underlying operating system, Flutter applications are packaged in the
same way as any other native application. A platform-specific embedder provides
an entrypoint; coordinates with the underlying operating system for access to
services like rendering surfaces, accessibility, and input; and manages the
message event loop. The embedder is written in a language that is appropriate
for the platform: currently Java and C++ for Android, Objective-C/Objective-C++
for iOS and macOS, and C++ for Windows and Linux. Using the embedder, Flutter
code can be integrated into an existing application as a module, or the code may
be the entire content of the application. Flutter includes a number of embedders
for common target platforms, but [other embedders also
exist](https://hover.build/blog/one-year-in/).

At the core of Flutter is the **Flutter engine**, which is mostly written in C++
and supports the primitives necessary to support all Flutter applications. The
engine is responsible for rasterizing composited scenes whenever a new frame
needs to be painted. It provides the low-level implementation of Flutter's core
API, including graphics (through [Skia](https://skia.org/)), text layout, file
and network I/O, accessibility support, plugin architecture, and a Dart runtime
and compile toolchain.

The engine is exposed to the Flutter framework through
[`dart:ui`]({{site.github}}/flutter/engine/tree/master/lib/ui),
which wraps the underlying C++ code in Dart classes. This library
exposes the lowest-level primitives, such as classes for driving input,
graphics, and text rendering subsystems.

Typically, developers interact with Flutter through the **Flutter framework**,
which provides a modern, reactive framework written in the Dart language. It
includes a rich set of platform, layout, and foundational libraries, composed of
a series of layers. Working from the bottom to the top, we have:

- Basic **[foundational]({{site.api}}/flutter/foundation/foundation-library.html)**
  classes, and building block services such as
  **[animation]({{site.api}}/flutter/animation/animation-library.html),
  [painting]({{site.api}}/flutter/painting/painting-library.html), and
  [gestures]({{site.api}}/flutter/gestures/gestures-library.html)** that offer
  commonly used abstractions over the underlying foundation.
- The **[rendering
  layer]({{site.api}}/flutter/rendering/rendering-library.html)** provides an
  abstraction for dealing with layout. With this layer, you can build a tree of
  renderable objects. You can manipulate these objects dynamically, with the
  tree automatically updating the layout to reflect your changes.
- The **[widgets layer]({{site.api}}/flutter/widgets/widgets-library.html)** is
  a composition abstraction. Each render object in the rendering layer has a
  corresponding class in the widgets layer. In addition, the widgets layer
  allows you to define combinations of classes that you can reuse. This is the
  layer at which the reactive programming model is introduced.
- The
  **[Material]({{site.api}}/flutter/material/material-library.html)**
  and
  **[Cupertino]({{site.api}}/flutter/cupertino/cupertino-library.html)**
  libraries offer comprehensive sets of controls that use the widget layer's
  composition primitives to implement the Material or iOS design languages.

The Flutter framework is relatively small; many higher-level features that
developers might use are implemented as packages, including platform plugins
like [camera]({{site.pub}}/packages/camera) and
[webview]({{site.pub}}/packages/webview_flutter), as well as platform-agnostic
features like [characters]({{site.pub}}/packages/characters),
[http]({{site.pub}}/packages/http), and
[animations]({{site.pub}}/packages/animations) that build upon the core Dart and
Flutter libraries. Some of these packages come from the broader ecosystem,
covering services like [in-app
payments]({{site.pub}}/packages/square_in_app_payments), [Apple
authentication]({{site.pub}}/packages/sign_in_with_apple), and
[animations]({{site.pub}}/packages/lottie).

The rest of this overview broadly navigates down the layers, starting with the
reactive paradigm of UI development. Then, we describe how widgets are composed
together and converted into objects that can be rendered as part of an
application. We describe how Flutter interoperates with other code at a platform
level, before giving a brief summary of how Flutter’s web support differs from
other targets.

## Reactive user interfaces

On the surface, Flutter is [a reactive, pseudo-declarative UI
framework](/docs/resources/faq#what-programming-paradigm-does-flutters-framework-use),
in which the developer provides a mapping from application state to interface
state, and the framework takes on the task of updating the interface at runtime
when the application state changes. This model is inspired by [work that came
from Facebook for their own React
framework]({{site.youtube-site}}/watch?time_continue=2&v=x7cQ3mrcKaY&feature=emb_logo),
which includes a rethinking of many traditional design principles.

In most traditional UI frameworks, the user interface's initial state is
described once and then separately updated by user code at runtime, in response
to events. One challenge of this approach is that, as the application grows in
complexity, the developer needs to be aware of how state changes cascade
throughout the entire UI. For example, consider the following UI:

![Color picker dialog](/images/arch-overview/color-picker.png){:width="66%"}

There are many places where the state can be changed: the color box, the hue
slider, the radio buttons. As the user interacts with the UI, changes must be
reflected in every other place. Worse, unless care is taken, a minor change to
one part of the user interface can cause ripple effects to seemingly unrelated
pieces of code.

One solution to this is an approach like MVC, where you push data changes to the
model via the controller, and then the model pushes the new state to the view
via the controller. However, this also is problematic, since creating and
updating UI elements are two separate steps that can easily get out of sync.

Flutter, along with other reactive frameworks, takes an alternative approach to
this problem, by explicitly decoupling the user interface from its underlying
state. With React-style APIs, you only create the UI description, and the
framework takes care of using that one configuration to both create and/or
update the user interface as appropriate.

In Flutter, widgets (akin to components in React) are represented by immutable
classes that are used to configure a tree of objects. These widgets are used to
manage a separate tree of objects for layout, which is then used to manage a
separate tree of objects for compositing. Flutter is, at its core, a series of
mechanisms for efficiently walking the modified parts of trees, converting trees
of objects into lower-level trees of objects, and propagating changes across
these trees.

A widget declares its user interface by overriding the `build()` method, which
is a function that converts state to UI:

```none
UI = f(state)
```

The `build()` method is by design fast to execute and should be free of side
effects, allowing it to be called by the framework whenever needed (potentially
as often as once per rendered frame).

This approach relies on certain characteristics of a language runtime (in
particular, fast object instantiation and deletion). Fortunately, [Dart is
particularly well suited for this
task](https://medium.com/flutter/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30).

## Widgets

As mentioned, Flutter emphasizes widgets as a unit of composition. Widgets are
the building blocks of a Flutter app’s user interface, and each widget is an
immutable declaration of part of the user interface.

Widgets form a hierarchy based on composition. Each widget nests inside its
parent and can receive context from the parent. This structure carries all the
way up to the root widget (the container that hosts the Flutter app, typically
`MaterialApp` or `CupertinoApp`), as this trivial example shows:

<?code-excerpt "lib/main.dart (Main)"?>
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My Home Page')),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Text('Hello World'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Click!');
                    },
                    child: Text('A button'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
```

In the preceding code, all instantiated classes are widgets.

Apps update their user interface in response to events (such as a user
interaction) by telling the framework to replace a widget in the hierarchy with
another widget. The framework then compares the new and old widgets, and
efficiently updates the user interface.

Flutter has its own implementations of each UI control, rather than deferring to
those provided by the system: for example, there is a pure [Dart
implementation]({{site.api}}/flutter/material/Switch-class.html) of both the
[iOS Switch
control](https://developer.apple.com/design/human-interface-guidelines/ios/controls/switches/)
and the [one for](https://material.io/develop/android/components/switches) the
[Android equivalent](https://material.io/develop/android/components/switches).

This approach provides several benefits:

- Provides for unlimited extensibility. A developer who wants a variant of the
  Switch control can create one in any arbitrary way, and is not limited to the
  extension points provided by the OS.
- Avoids a significant performance bottleneck by allowing Flutter to composite
  the entire scene at once, without transitioning back and forth between Flutter
  code and platform code.
- Decouples the application behavior from any operating system dependencies. The
  application looks and feels the same on all versions of the OS, even if the OS
  changed the implementations of its controls.

### Composition

Widgets are typically composed of many other small, single-purpose widgets that
combine to produce powerful effects.

Where possible, the number of design concepts is kept to a minimum while
allowing the total vocabulary to be large. For example, in the widgets layer,
Flutter uses the same core concept (a `Widget`) to represent drawing to the
screen, layout (positioning and sizing), user interactivity, state management,
theming, animations, and navigation. In the animation layer, a pair of concepts,
`Animation`s and `Tween`s, cover most of the design space. In the rendering
layer, `RenderObject`s are used to describe layout, painting, hit testing, and
accessibility. In each of these cases, the corresponding vocabulary ends up
being large: there are hundreds of widgets and render objects, and dozens of
animation and tween types.

The class hierarchy is deliberately shallow and broad to maximize the possible
number of combinations, focusing on small, composable widgets that each do one
thing well. Core features are abstract, with even basic features like padding
and alignment being implemented as separate components rather than being built
into the core. (This also contrasts with more traditional APIs where features
like padding are built in to the common core of every layout component.) So, for
example, to center a widget, rather than adjusting a notional `Align` property,
you wrap it in a [`Center`]({{site.api}}/flutter/widgets/Center-class.html)
widget.

There are widgets for padding, alignment, rows, columns, and grids. These layout
widgets do not have a visual representation of their own. Instead, their sole
purpose is to control some aspect of another widget’s layout. Flutter also
includes utility widgets that take advantage of this compositional approach.

For example, [`Container`]({{site.api}}/flutter/widgets/Container-class.html), a
commonly used widget, is made up of several widgets responsible for layout,
painting, positioning, and sizing. Specifically, Container is made up of the
[`LimitedBox`]({{site.api}}/flutter/widgets/LimitedBox-class.html),
[`ConstrainedBox`]({{site.api}}/flutter/widgets/ConstrainedBox-class.html),
[`Align`]({{site.api}}/flutter/widgets/Align-class.html),
[`Padding`]({{site.api}}/flutter/widgets/Padding-class.html),
[`DecoratedBox`]({{site.api}}/flutter/widgets/DecoratedBox-class.html), and
[`Transform`]({{site.api}}/flutter/widgets/Transform-class.html) widgets, as you
can see by reading its source code. A defining characteristic of Flutter is that
you can drill down into the source for any widget and examine it. So, rather
than subclassing `Container` to produce a customized effect, you can compose it
and other simple widgets in novel ways, or just create a new widget using
`Container` as inspiration.

### Building widgets

As mentioned earlier, you determine the visual representation of a widget by
overriding the
[`build()`]({{site.api}}/flutter/widgets/StatelessWidget/build.html) function to
return a new element tree. This tree represents the widget’s part of the user
interface in more concrete terms. For example, a toolbar widget might have a
build function that returns a [horizontal
layout]({{site.api}}/flutter/widgets/Row-class.html) of some
[text]({{site.api}}/flutter/widgets/Text-class.html) and
[various]({{site.api}}/flutter/material/IconButton-class.html)
[buttons]({{site.api}}/flutter/material/PopupMenuButton-class.html). As needed,
the framework recursively asks each widget to build until the tree is entirely
described by [concrete renderable
objects]({{site.api}}/flutter/widgets/RenderObjectWidget-class.html). The
framework then stitches together the renderable objects into a renderable object
tree.

A widget’s build function should be free of side effects. Whenever the function
is asked to build, the widget should return a new tree of widgets<sup><a
href="#a1">1</a></sup>, regardless of what the widget previously returned. The
framework does the heavy lifting work to determine which build methods need to
be called based on the render object tree (described in more detail later). More
information about this process can be found in the [Inside Flutter
topic](/docs/resources/inside-flutter#linear-reconciliation).

On each rendered frame, Flutter can recreate just the parts of the UI where the
state has changed by calling that widget’s `build()` method. Therefore it is
important that build methods should return quickly, and heavy computational work
should be done in some asynchronous manner and then stored as part of the state
to be used by a build method.

While relatively naïve in approach, this automated comparison is quite
effective, enabling high-performance, interactive apps. And, the design of the
build function simplifies your code by focusing on declaring what a widget is
made of, rather than the complexities of updating the user interface from one
state to another.

### Widget state

The framework introduces two major classes of widget: _stateful_ and _stateless_
widgets.

Many widgets have no mutable state: they don’t have any properties that change
over time (for example, an icon or a label). These widgets subclass
[`StatelessWidget`]({{site.api}}/flutter/widgets/StatelessWidget-class.html).

However, if the unique characteristics of a widget need to change based on user
interaction or other factors, that widget is _stateful_. For example, if a
widget has a counter that increments whenever the user taps a button, then the
value of the counter is the state for that widget. When that value changes, the
widget needs to be rebuilt to update its part of the UI. These widgets subclass
[`StatefulWidget`]({{site.api}}/flutter/widgets/StatefulWidget-class.html), and
(because the widget itself is immutable) they store mutable state in a separate
class that subclasses [`State`]({{site.api}}/flutter/widgets/State-class.html).
`StatefulWidget`s don’t have a build method; instead, their user interface is
built through their `State` object.

Whenever you mutate a `State` object (for example, by incrementing the counter),
you must call [`setState()`]({{site.api}}/flutter/widgets/State/setState.html)
to signal the framework to update the user interface by calling the `State`’s
build method again.

Having separate state and widget objects lets other widgets treat both stateless
and stateful widgets in exactly the same way, without being concerned about
losing state. Instead of needing to hold on to a child to preserve its state,
the parent can create a new instance of the child at any time without losing the
child’s persistent state. The framework does all the work of finding and reusing
existing state objects when appropriate.

### State management

So, if many widgets can contain state, how is state managed and passed around
the system?

As with any other class, you can use a constructor in a widget to initialize its
data, so a `build()` method can ensure that any child widget is instantiated
with the data it needs:

<!-- skip -->
```dart
@override
Widget build(BuildContext context) {
   return ContentWidget(importantState);
}
```

As widget trees get deeper, however, passing state information up and down the
tree hierarchy becomes cumbersome. So, a third widget type,
[`InheritedWidget`]({{site.api}}/flutter/widgets/InheritedWidget-class.html),
provides an easy way to grab data from a shared ancestor. You can use
`InheritedWidget` to create a state widget that wraps a common ancestor in the
widget tree, as shown in this example:

![Inherited widgets](/images/arch-overview/inherited-widget.png){:width="50%"}

Whenever one of the `ExamWidget` or `GradeWidget` objects needs data from
`StudentState`, it can now access it with a command such as:

<!-- skip -->
```dart
final studentState = StudentState.of(context);
```

The `of(context)` call takes the build context (a handle to the current widget
location), and returns [the nearest ancestor in the
tree]({{site.api}}/flutter/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html)
that matches the `StudentState` type. `InheritedWidget`s also offer an
`updateShouldNotify()` method, which Flutter calls to determine whether a state
change should trigger a rebuild of child widgets that use it.

Flutter itself uses `InheritedWidget` extensively as part of the framework for
shared state, such as the application’s _visual theme_, which includes
[properties like color and type
styles]({{site.api}}/flutter/material/ThemeData-class.html) that are
pervasive throughout an application. The `MaterialApp` `build()` method inserts
a theme in the tree when it builds, and then deeper in the hierarchy a widget
can use the `.of()` method to look up the relevant theme data, for example:

<?code-excerpt "lib/main.dart (Container)"?>
```dart
Container(
  color: Theme.of(context).secondaryHeaderColor,
  child: Text(
    'Text with a background color',
    style: Theme.of(context).textTheme.headline6,
  ),
);
```

This approach is also used for
[Navigator]({{site.api}}/flutter/widgets/Navigator-class.html), which provides
page routing; and
[MediaQuery]({{site.api}}/flutter/widgets/MediaQuery-class.html), which provides
access to screen metrics such as orientation, dimensions, and brightness.

As applications grow, more advanced state management approaches that reduce the
ceremony of creating and using stateful widgets become more attractive. Many
Flutter apps use utility packages like
[provider]({{site.pub}}/packages/provider), which provides a wrapper around
`InheritedWidget`. Flutter’s layered architecture also enables alternative
approaches to implement the transformation of state into UI, such as the
[flutter_hooks]({{site.pub}}/packages/flutter_hooks) package.

## Rendering and layout

This section describes the rendering pipeline, which is the series of steps that
Flutter takes to convert a hierarchy of widgets into the actual pixels painted
onto a screen.

### Flutter’s rendering model

You may be wondering: if Flutter is a cross-platform framework, then how can it
offer comparable performance to single-platform frameworks?

It’s useful to start by thinking about how traditional Android apps work. When
drawing, you first call the Java code of the Android framework. The Android
system libraries provide the components responsible for drawing themselves to a
Canvas object, which Android can then render with [Skia](https://skia.org/), a
graphics engine written in C/C++ that calls the CPU or GPU to complete the
drawing on the device.

Cross-platform frameworks _typically_ work by creating an abstraction layer over
the underlying native Android and iOS UI libraries, attempting to smooth out the
inconsistencies of each platform representation. App code is often written in an
interpreted language like JavaScript, which must in turn interact with the
Java-based Android or Objective-C-based iOS system libraries to display UI. All
this adds overhead that can be significant, particularly where there is a lot of
interaction between the UI and the app logic.

By contrast, Flutter minimizes those abstractions, bypassing the system UI
widget libraries in favor of its own widget set. The Dart code that paints
Flutter’s visuals is compiled into native code, which uses Skia for rendering.
Flutter also embeds its own copy of Skia as part of the engine, allowing the
developer to upgrade their app to stay updated with the latest performance
improvements even if the phone hasn’t been updated with a new Android version.
The same is true for Flutter on other native platforms, such as iOS, Windows, or
macOS.

### From user input to the GPU

The overriding principle that Flutter applies to its rendering pipeline is that
**simple is fast**. Flutter has a straightforward pipeline for how data flows to
the system, as shown in the following sequencing diagram:

![Render pipeline sequencing
diagram](/images/arch-overview/render-pipeline.png){:width="100%"}

Let’s take a look at some of these phases in greater detail.

### Build: from Widget to Element

Consider this simple code fragment that demonstrates a simple widget hierarchy:

<?code-excerpt "lib/main.dart (Container2)"?>
```dart
Container(
  color: Colors.blue,
  child: Row(
    children: [
      Image.network('https://www.example.com/1.png'),
      Text('A'),
    ],
  ),
);
```

When Flutter needs to render this fragment, it calls the `build()` method, which
returns a subtree of widgets that renders UI based on the current app state.
During this process, the `build()` method can introduce new widgets, as
necessary, based on its state. As a simple example, in the preceding code
fragment, `Container` has `color` and `child` properties. From looking at the
[source
code]({{site.github}}/flutter/flutter/blob/02efffc134ab4ce4ff50a9ddd86c832efdb80462/packages/flutter/lib/src/widgets/container.dart#L401)
for `Container`, you can see that if the color is not null, it inserts a
`ColoredBox` representing the color:

<!-- skip -->
```dart
if (color != null)
  current = ColoredBox(color: color!, child: current);
```

Correspondingly, the `Image` and `Text` widgets might insert child widgets such
as `RawImage` and `RichText` during the build process. The eventual widget
hierarchy may therefore be deeper than what the code represents, as in this
case<sup><a href="#a2">2</a></sup>:

![Render pipeline sequencing
diagram](/images/arch-overview/widgets.png){:width="35%"}

This explains why, when you examine the tree through a debug tool such as the
[Flutter inspector](/docs/development/tools/devtools/inspector), part of the
Dart DevTools, you might see a structure that is considerably deeper than what
is in your original code.

During the build phase, Flutter translates the widgets expressed in code into a
corresponding **element tree**, with one element for every widget. Each element
represents a specific instance of a widget in a given location of the tree
hierarchy. There are two basic types of elements:

- `ComponentElement`, a host for other elements.
- `RenderObjectElement`, an element that participates in the layout or paint
  phases.

![Render pipeline sequencing
diagram](/images/arch-overview/widget-element.png){:width="85%"}

`RenderObjectElement`s are an intermediary between their widget analog and the
underlying `RenderObject`, which we’ll come to later.

The element for any widget can be referenced through its `BuildContext`, which
is a handle to the location of a widget in the tree. This is the `context` in a
function call such as `Theme.of(context)`, and is supplied to the `build()`
method as a parameter.

Because widgets are immutable, including the parent/child relationship between
nodes, any change to the widget tree (such as changing `Text('A')` to
`Text('B')` in the preceding example) causes a new set of widget objects to be
returned. But that doesn’t mean the underlying representation must be rebuilt.
The element tree is persistent from frame to frame, and therefore plays a
critical performance role, allowing Flutter to act as if the widget hierarchy is
fully disposable while caching its underlying representation. By only walking
through the widgets that changed, Flutter can rebuild just the parts of the
element tree that require reconfiguration.

### Layout and rendering

It would be a rare application that drew only a single widget. An important part
of any UI framework is therefore the ability to efficiently lay out a hierarchy
of widgets, determining the size and position of each element before they are
rendered on the screen.

The base class for every node in the render tree is
[`RenderObject`]({{site.api}}/flutter/rendering/RenderObject-class.html), which
defines an abstract model for layout and painting. This is extremely general: it
does not commit to a fixed number of dimensions or even a Cartesian coordinate
system (demonstrated by [this example of a polar coordinate
system](https://dartpad.dev/0f020197a5d4c980342d5c7d9e935cee)). Each
`RenderObject` knows its parent, but knows little about its children other than
how to _visit_ them and their constraints. This provides `RenderObject` with
sufficient abstraction to be able to handle a variety of use cases.

During the build phase, Flutter creates or updates an object that inherits from
`RenderObject` for each `RenderObjectElement` in the element tree.
`RenderObject`s are primitives:
[`RenderParagraph`]({{site.api}}/flutter/rendering/RenderParagraph-class.html)
renders text,
[`RenderImage`]({{site.api}}/flutter/rendering/RenderImage-class.html) renders
an image, and
[`RenderTransform`]({{site.api}}/flutter/rendering/RenderTransform-class.html)
applies a transformation before painting its child.

![Differences between the widgets hierarchy and the element and render
trees](/images/arch-overview/trees.png){:width="100%"}

Most Flutter widgets are rendered by an object that inherits from the
`RenderBox` subclass, which represents a `RenderObject` of fixed size in a 2D
Cartesian space. `RenderBox` provides the basis of a _box constraint model_,
establishing a minimum and maximum width and height for each widget to be
rendered.

To perform layout, Flutter walks the render tree in a depth-first traversal and
**passes down size constraints** from parent to child. In determining its size,
the child _must_ respect the constraints given to it by its parent. Children
respond by **passing up a size** to their parent object within the constraints
the parent established.

![Constraints go down, sizes go
up](/images/arch-overview/constraints-sizes.png){:width="80%"}

At the end of this single walk through the tree, every object has a defined size
within its parent’s constraints and is ready to be painted by calling the
[`paint()`]({{site.api}}/flutter/rendering/RenderObject/paint.html)
method.

The box constraint model is very powerful as a way to layout objects in _O(n)_
time:

- Parents can dictate the size of a child object by setting maximum and minimum
  constraints to the same value. For example, the topmost render object in a
  phone app constrains its child to be the size of the screen. (Children can
  choose how to use that space. For example, they might just center what they
  want to render within the dictated constraints.)
- A parent can dictate the child’s width but give the child flexibility over
  height (or dictate height but offer flexible over width). A real-world example
  is flow text, which might have to fit a horizontal constraint but vary
  vertically depending on the quantity of text.

This model works even when a child object needs to know how much space it has
available to decide how it will render its content. By using a
[`LayoutBuilder`]({{site.api}}/flutter/widgets/LayoutBuilder-class.html) widget,
the child object can examine the passed-down constraints and use those to
determine how it will use them, for example:

<?code-excerpt "lib/main.dart (LayoutBuilder)"?>
```dart
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return OneColumnLayout();
      } else {
        return TwoColumnLayout();
      }
    },
  );
}
```

More information about the constraint and layout system, along with worked
examples, can be found in the [Understanding
constraints](/docs/development/ui/layout/constraints) topic.

The root of all `RenderObject`s is the `RenderView`, which represents the total
output of the render tree. When the platform demands a new frame to be rendered
(for example, because of a
[vsync](https://source.android.com/devices/graphics/implement-vsync) or because
a texture decompression/upload is complete), a call is made to the
`compositeFrame()` method, which is part of the `RenderView` object at the root
of the render tree. This creates a `SceneBuilder` to trigger an update of the
scene. When the scene is complete, the `RenderView` object passes the composited
scene to the `Window.render()` method in `dart:ui`, which passes control to the
GPU to render it.

Further details of the composition and rasterization stages of the pipeline are
beyond the scope of this high-level article, but more information can be found
[in this talk on the Flutter rendering
pipeline]({{site.youtube-site}}/watch?v=UUfXWzp0-DU).

## Platform embedding

As we’ve seen, rather than being translated into the equivalent OS widgets,
Flutter user interfaces are built, laid out, composited, and painted by Flutter
itself. The mechanism for obtaining the texture and participating in the app
lifecycle of the underlying operating system inevitably varies depending on the
unique concerns of that platform. The engine is platform-agnostic, presenting a
[stable ABI (Application Binary
Interface)]({{site.github}}/flutter/engine/blob/master/shell/platform/embedder/embedder.h)
that provides a _platform embedder_ with a way to set up and use Flutter.

The platform embedder is the native OS application that hosts all Flutter
content, and acts as the glue between the host operating system and Flutter.
When you start a Flutter app, the embedder provides the entrypoint, initializes
the Flutter engine, obtains threads for UI and rastering, and creates a texture
that Flutter can write to. The embedder is also responsible for the app
lifecycle, including input gestures (such as mouse, keyboard, touch), window
sizing, thread management, and platform messages. Flutter includes platform
embedders for Android, iOS, Windows, macOS, and Linux; you can also create a
custom platform embedder, as in [this worked
example]({{site.github}}/chinmaygarde/fluttercast) that supports remoting
Flutter sessions through a VNC-style framebuffer or [this worked example for
Raspberry Pi]({{site.github}}/ardera/flutter-pi).

Each platform has its own set of APIs and constraints. Some brief
platform-specific notes:

- On iOS and macOS, Flutter is loaded into the embedder as a `UIViewController`
  or `NSViewController`, respectively. The platform embedder creates a
  `FlutterEngine`, which serves as a host to the Dart VM and your Flutter
  runtime, and a `FlutterViewController`, which attaches to the `FlutterEngine`
  to pass UIKit or Cocoa input events into Flutter and to display frames
  rendered by the `FlutterEngine` using Metal or OpenGL.
- On Android, Flutter is, by default, loaded into the embedder as an `Activity`.
  The view is controlled by a
  [`FlutterView`]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html),
  which renders Flutter content either as a view or a texture, depending on the
  composition and z-ordering requirements of the Flutter content.
- On Windows, Flutter is hosted in a traditional Win32 app, and content is
  rendered using
  [ANGLE](https://chromium.googlesource.com/angle/angle/+/master/README.md), a
  library that translates OpenGL API calls to the DirectX 11 equivalents.
  Efforts are currently underway to also offer a Windows embedder using the UWP
  app model, as well as to replace ANGLE with a more direct path to the GPU via
  DirectX 12.

## Integrating with other code

Flutter provides a variety of interoperability mechanisms, whether you’re
accessing code or APIs written in a language like Kotlin or Swift, calling a
native C-based API, embedding native controls in a Flutter app, or embedding
Flutter in an existing application.

### Platform channels

For mobile and desktop apps, Flutter allows you to call into custom code through
a _platform channel_, which is a simple mechanism for communicating between your
Dart code and the platform-specific code of your host app. By creating a common
channel (encapsulating a name and a codec), you can send and receive messages
between Dart and a platform component written in a language like Kotlin or
Swift. Data is serialized from a Dart type like `Map` into a standard format,
and then deserialized into an equivalent representation in Kotlin (such as
`HashMap`) or Swift (such as `Dictionary`).

![How platform channels allow Flutter to communicate with host
code](/images/arch-overview/platform-channels.png){:width="70%"}

The following is a simple platform channel example of a Dart call to a receiving
event handler in Kotlin (Android) or Swift (iOS):

<?code-excerpt "lib/main.dart (MethodChannel)"?>
```dart
// Dart side
const channel = MethodChannel('foo');
final String greeting = await channel.invokeMethod('bar', 'world');
print(greeting);
```

```kotlin
// Android (Kotlin)
val channel = MethodChannel(flutterView, "foo")
channel.setMethodCallHandler { call, result ->
  when (call.method) {
    "bar" -> result.success("Hello, ${call.arguments}")
    else -> result.notImplemented()
  }
}
```

```swift
// iOS (Swift)
let channel = FlutterMethodChannel(name: "foo", binaryMessenger: flutterView)
channel.setMethodCallHandler {
  (call: FlutterMethodCall, result: FlutterResult) -> Void in
  switch (call.method) {
    case "bar": result("Hello, \(call.arguments as! String)")
    default: result(FlutterMethodNotImplemented)
  }
}
```

Further examples of using platform channels, including examples for macOS, can
be found in the [flutter/plugins]({{site.github}}/flutter/plugins)
repository<sup><a href="#a3">3</a></sup>. There are also [thousands of plugins
already available]({{site.pub}}/flutter) for Flutter that cover many common
scenarios, ranging from Firebase to ads to device hardware like camera and
Bluetooth.

### Foreign Function Interface

For C-based APIs, including those that can be generated for code written in
modern languages like Rust or Go, Dart provides a direct mechanism for binding
to native code using the `dart:ffi` library. The foreign function interface
(FFI) model can be considerably faster than platform channels, because no
serialization is required to pass data. Instead, the Dart runtime provides the
ability to allocate memory on the heap that is backed by a Dart object and make
calls to statically or dynamically linked libraries. FFI is available for all
platforms other than web, where the [js package]({{site.pub}}/packages/js)
serves an equivalent purpose.

To use FFI, you create a `typedef` for each of the Dart and unmanaged method
signatures, and instruct the Dart VM to map between them. As a simple example,
here’s a fragment of code to call the traditional Win32 `MessageBox()` API:

<?code-excerpt "lib/main.dart (FFI)"?>
```dart
typedef MessageBoxNative = Int32 Function(
  IntPtr hWnd,
  Pointer<Utf16> lpText,
  Pointer<Utf16> lpCaption,
  Int32 uType,
);

typedef MessageBoxDart = int Function(
  int hWnd,
  Pointer<Utf16> lpText,
  Pointer<Utf16> lpCaption,
  int uType,
);

void exampleFfi() {
  final user32 = DynamicLibrary.open('user32.dll');
  final MessageBox =
      user32.lookupFunction<MessageBoxNative, MessageBoxDart>('MessageBoxW');

  final result = MessageBox(
    0, // No owner window
    'Test message'.toNativeUtf16(), // Message
    'Window caption'.toNativeUtf16(), // Window title
    0, // OK button only
  );
}
```

### Rendering native controls in a Flutter app

Because Flutter content is drawn to a texture and its widget tree is entirely
internal, there's no place for something like an Android view to exist within
Flutter's internal model or render interleaved within Flutter widgets. That’s a
problem for developers that would like to include existing platform components
in their Flutter apps, such as a browser control.

Flutter solves this by introducing platform view widgets
([`AndroidView`]({{site.api}}/flutter/widgets/AndroidView-class.html)
and [`UiKitView`]({{site.api}}/flutter/widgets/UiKitView-class.html))
that let you embed this kind of content on each platform. Platform views can be
integrated with other Flutter content<sup><a href="#a4">4</a></sup>. Each of
these widgets acts as an intermediary to the underlying operating system. For
example, on Android, `AndroidView` serves three primary functions:

- Making a copy of the graphics texture rendered by the native view and
  presenting it to Flutter for composition as part of a Flutter-rendered surface
  each time the frame is painted.
- Responding to hit testing and input gestures, and translating those into the
  equivalent native input.
- Creating an analog of the accessibility tree, and passing commands and
  responses between the native and Flutter layers.

Inevitably, there is a certain amount of overhead associated with this
synchronization. In general, therefore, this approach is best suited for complex
controls like Google Maps where reimplementing in Flutter isn’t practical.

Typically, a Flutter app instantiates these widgets in a `build()` method based
on a platform test. As an example, from the
[google_maps_flutter]({{site.pub}}/packages/google_maps_flutter) plugin:

<!-- skip -->
```dart
if (defaultTargetPlatform == TargetPlatform.android) {
  return AndroidView(
    viewType: 'plugins.flutter.io/google_maps',
    onPlatformViewCreated: onPlatformViewCreated,
    gestureRecognizers: gestureRecognizers,
    creationParams: creationParams,
    creationParamsCodec: const StandardMessageCodec(),
  );
} else if (defaultTargetPlatform == TargetPlatform.iOS) {
  return UiKitView(
    viewType: 'plugins.flutter.io/google_maps',
    onPlatformViewCreated: onPlatformViewCreated,
    gestureRecognizers: gestureRecognizers,
    creationParams: creationParams,
    creationParamsCodec: const StandardMessageCodec(),
  );
}
return Text(
    '$defaultTargetPlatform is not yet supported by the maps plugin');
```

Communicating with the native code underlying the `AndroidView` or `UiKitView`
typically occurs using the platform channels mechanism, as previously described.

At present, platform views aren’t available for desktop platforms, but this is
not an architectural limitation; support might be added in the future.

### Hosting Flutter content in a parent app

The converse of the preceding scenario is embedding a Flutter widget in an
existing Android or iOS app. As described in an earlier section, a newly created
Flutter app running on a mobile device is hosted in an Android activity or iOS
`UIViewController`. Flutter content can be embedded into an existing Android or
iOS app using the same embedding API.

The Flutter module template is designed for easy embedding; you can either embed
it as a source dependency into an existing Gradle or Xcode build definition, or
you can compile it into an Android Archive or iOS Framework binary for use
without requiring every developer to have Flutter installed.

The Flutter engine takes a short while to initialize, because it needs to load
Flutter shared libraries, initialize the Dart runtime, create and run a Dart
isolate, and attach a rendering surface to the UI. To minimize any UI delays
when presenting Flutter content, it’s best to initialize the Flutter engine
during the overall app initialization sequence, or at least ahead of the first
Flutter screen, so that users don’t experience a sudden pause while the first
Flutter code is loaded. In addition, separating the Flutter engine allows it to
be reused across multiple Flutter screens and share the memory overhead involved
with loading the necessary libraries.

More information about how Flutter is loaded into an existing Android or iOS app
can be found at the [Load sequence, performance and memory
topic](/docs/development/add-to-app/performance).

## Flutter web support

While the general architectural concepts apply to all platforms that Flutter
supports, there are some unique characteristics of Flutter’s web support that
are worthy of comment.

Dart has been compiling to JavaScript for as long as the language has existed,
with a toolchain optimized for both development and production purposes. Many
important apps compile from Dart to JavaScript and run in production today,
including the [advertiser tooling for Google Ads](https://ads.google.com/home/).
Because the Flutter framework is written in Dart, compiling it to JavaScript was
relatively straightforward.

However, the Flutter engine, written in C++, is designed to interface with the
underlying operating system rather than a web browser. A different approach is
therefore required. On the web, Flutter provides a reimplementation of the
engine on top of standard browser APIs. We currently have two options for
rendering Flutter content on the web: HTML and WebGL. In HTML mode, Flutter uses
HTML, CSS, Canvas, and SVG. To render to WebGL, Flutter uses a version of Skia
compiled to WebAssembly called
[CanvasKit](https://skia.org/user/modules/canvaskit). While HTML mode offers the
best code size characteristics, CanvasKit provides the fastest path to the
browser's graphics stack, and offers somewhat higher graphical fidelity with the
native mobile targets<sup><a href="#a5">5</a></sup>.

The web version of the architectural layer diagram is as follows:

![Flutter web
architecture](/images/arch-overview/web-arch.png){:width="100%"}

Perhaps the most notable difference compared to other platforms on which Flutter
runs is that there is no need for Flutter to provide a Dart runtime. Instead,
the Flutter framework (along with any code you write) is compiled to JavaScript.
It’s also worthy to note that Dart has very few language semantic differences
across all its modes (JIT versus AOT, native versus web compilation), and most
developers will never write a line of code that runs into such a difference.

During development time, Flutter web uses
[`dartdevc`]({{site.dart-site}}/tools/dartdevc), a compiler that supports
incremental compilation and therefore allows hot restart (although not currently
hot reload) for apps. Conversely, when you are ready to create a production app
for the web, [`dart2js`]({{site.dart-site}}/tools/dart2js), Dart’s
highly-optimized production JavaScript compiler is used, packaging the Flutter
core and framework along with your application into a minified source file that
can be deployed to any web server. Code can be offered in a single file or split
into multiple files through [deferred
imports]({{site.dart-site}}/guides/language/language-tour#lazily-loading-a-library).

## Further information

For those interested in more information about the internals of Flutter, the
[Inside Flutter](/docs/resources/inside-flutter) whitepaper
provides a useful guide to the framework’s design philosophy.

---

**Footnotes:**

<sup><a name="a1">1</a></sup> While the `build` function returns a fresh tree,
you only need to return something _different_ if there's some new
configuration to incorporate. If the configuration is in fact the same, you can
just return the same widget.

<sup><a name="a2">2</a></sup> This is a slight simplification for ease of
reading. In practice, the tree might be more complex.

<sup><a name="a3">3</a></sup> While work is underway on Linux and Windows,
examples for those platforms can be found in the [Flutter desktop embedding
repository]({{site.github}}/google/flutter-desktop-embedding/tree/master/plugins).
As development on those platforms reaches maturity, this content will be
gradually migrated into the main Flutter repository.

<sup><a name="a4">4</a></sup> There are some limitations with this approach, for
example, transparency doesn’t composite the same way for a platform view as it
would for other Flutter widgets.

<sup><a name="a5">5</a></sup> One example is shadows, which have to be
approximated with DOM-equivalent primitives at the cost of some fidelity.
