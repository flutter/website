---
title: Inside Flutter
description: Learn about Flutter's inner workings from one of the founding engineers.
---

This document describes the inner workings of the Flutter toolkit that make
Flutter’s API possible. Because Flutter widgets are built using aggressive
composition, user interfaces built with Flutter have a large number of
widgets.  To support this workload, Flutter uses sublinear algorithms for
layout and building widgets as well as data structures that make tree
surgery efficient and that have a number of constant-factor optimizations.
With some additional details, this design also makes it easy for developers
to create infinite scrolling lists using callbacks that build exactly those
widgets that are visible to the user.

## Aggressive composability

One of the most distinctive aspects of Flutter is its _aggressive
composability_. Widgets are built by composing other widgets,
which are themselves built out of progressively more basic widgets.
For example, `Padding` is a widget rather than a property of other widgets.
As a result, user interfaces built with Flutter consist of many,
many widgets.

The widget building recursion bottoms out in `RenderObjectWidgets`,
which are widgets that create nodes in the underlying _render_ tree.
The render tree is a data structure that stores the geometry of the user
interface, which is computed during _layout_ and used during _painting_ and
_hit testing_. Most Flutter developers do not author render objects directly
but instead manipulate the render tree using widgets.

In order to support aggressive composability at the widget layer,
Flutter uses a number of efficient algorithms and optimizations at
both the widget and render tree layers, which are described in the
following subsections.

### Sublinear layout

With a large number of widgets and render objects, the key to good
performance is efficient algorithms. Of paramount importance is the
performance of _layout_, which is the algorithm that determines the
geometry (for example, the size and position) of the render objects.
Some other toolkits use layout algorithms that are O(N²) or worse
(for example, fixed-point iteration in some constraint domain).
Flutter aims for linear performance for initial layout, and _sublinear
layout performance_ in the common case of subsequently updating an
existing layout. Typically, the amount of time spent in layout should
scale more slowly than the number of render objects.

Flutter performs one layout per frame, and the layout algorithm works
in a single pass. _Constraints_ are passed down the tree by parent
objects calling the layout method on each of their children.
The children recursively perform their own layout and then return
_geometry_ up the tree by returning from their layout method. Importantly,
once a render object has returned from its layout method, that render
object will not be visited again<sup><a href="#a1">1</a></sup>
until the layout for the next frame. This approach combines what might
otherwise be separate measure and layout passes into a single pass and,
as a result, each render object is visited _at most
twice_<sup><a href="#a2">2</a></sup> during layout: once on the way
down the tree, and once on the way up the tree.

Flutter has several specializations of this general protocol.
The most common specialization is `RenderBox`, which operates in
two-dimensional, cartesian coordinates. In box layout, the constraints
are a min and max width and a min and max height. During layout,
the child determines its geometry by choosing a size within these bounds.
After the child returns from layout, the parent decides the child's
position in the parent's coordinate system<sup><a href="#a3">3</a></sup>.
Note that the child's layout cannot depend on its position,
as the position is not determined until after the child
returns from the layout. As a result, the parent is free to reposition
the child without needing to recompute its layout.

More generally, during layout, the _only_ information that flows from
parent to child are the constraints and the _only_ information that
flows from child to parent is the geometry. These invariants can reduce
the amount of work required during layout:

* If the child has not marked its own layout as dirty, the child can
  return immediately from layout, cutting off the walk, as long as the
  parent gives the child the same constraints as the child received
  during the previous layout.

* Whenever a parent calls a child's layout method, the parent indicates
  whether it uses the size information returned from the child. If,
  as often happens, the parent does not use the size information,
  then the parent need not recompute its layout if the child selects
  a new size because the parent is guaranteed that the new size will
  conform to the existing constraints.

* _Tight_ constraints are those that can be satisfied by exactly one
  valid geometry. For example, if the min and max widths are equal to
  each other and the min and max heights are equal to each other,
  the only size that satisfies those constraints is one with that
  width and height. If the parent provides tight constraints,
  then the parent need not recompute its layout whenever the child
  recomputes its layout, even if the parent uses the child's size
  in its layout, because the child cannot change size without new
  constraints from its parent.

* A render object can declare that it uses the constraints provided
  by the parent only to determine its geometry. Such a declaration
  informs the framework that the parent of that render object does
  not need to recompute its layout when the child recomputes its layout
  _even if the constraints are not tight_ and _even if the parent's
  layout depends on the child's size_, because the child cannot change
  size without new constraints from its parent.

As a result of these optimizations, when the render object tree contains
dirty nodes, only those nodes and a limited part of the subtree around
them are visited during layout.

### Sublinear widget building

Similar to the layout algorithm, Flutter's widget building algorithm
is sublinear. After being built, the widgets are held by the _element
tree_, which retains the logical structure of the user interface.
The element tree is necessary because the widgets themselves are
_immutable_, which means (among other things), they cannot remember their
parent or child relationships with other widgets. The element tree also
holds the _state_ objects associated with stateful widgets.

In response to user input (or other stimuli), an element can become dirty,
for example if the developer calls `setState()` on the associated state
object. The framework keeps a list of dirty elements and jumps directly
to them during the _build_ phase, skipping over clean elements. During
the build phase, information flows _unidirectionally_ down the element
tree, which means each element is visited at most once during the build
phase.  Once cleaned, an element cannot become dirty again because,
by induction, all its ancestor elements are also
clean<sup><a href="#a4">4</a></sup>.

Because widgets are _immutable_, if an element has not marked itself as
dirty, the element can return immediately from build, cutting off the walk,
if the parent rebuilds the element with an identical widget. Moreover,
the element need only compare the object identity of the two widget
references in order to establish that the new widget is the same as
the old widget. Developers exploit this optimization to implement the
_reprojection_ pattern, in which a widget includes a prebuilt child
widget stored as a member variable in its build.

During build, Flutter also avoids walking the parent chain using
`InheritedWidgets`. If widgets commonly walked their parent chain,
for example to determine the current theme color, the build phase
would become O(N²) in the depth of the tree, which can be quite
large due to aggressive composition. To avoid these parent walks,
the framework pushes information down the element tree by maintaining
a hash table of `InheritedWidget`s at each element. Typically, many
elements will reference the same hash table, which changes only at
elements that introduce a new `InheritedWidget`.

### Linear reconciliation

Contrary to popular belief, Flutter does not employ a tree-diffing
algorithm. Instead, the framework decides whether to reuse elements by
examining the child list for each element independently using an O(N)
algorithm. The child list reconciliation algorithm optimizes for the
following cases:

* The old child list is empty.
* The two lists are identical.
* There is an insertion or removal of one or more widgets in exactly
  one place in the list.
* If each list contains a widget with the same
  key<sup><a href="#a5">5</a></sup>, the two widgets are matched.

The general approach is to match up the beginning and end of both child
lists by comparing the runtime type and key of each widget,
potentially finding a non-empty range in the middle of each list
that contains all the unmatched children. The framework then places
the children in the range in the old child list into a hash table
based on their keys. Next, the framework walks the range in the new
child list and queries the hash table by key for matches. Unmatched
children are discarded and rebuilt from scratch whereas matched children
are rebuilt with their new widgets.

### Tree surgery

Reusing elements is important for performance because elements own
two critical pieces of data: the state for stateful widgets and the
underlying render objects. When the framework is able to reuse an element,
the state for that logical part of the user interface is preserved
and the layout information computed previously can be reused,
often avoiding entire subtree walks. In fact, reusing elements is
so valuable that Flutter supports _non-local_ tree mutations that
preserve state and layout information.

Developers can perform a non-local tree mutation by associating a `GlobalKey`
with one of their widgets. Each global key is unique throughout the
entire application and is registered with a thread-specific hash table.
During the build phase, the developer can move a widget with a global
key to an arbitrary location in the element tree. Rather than building
a fresh element at that location, the framework will check the hash
table and reparent the existing element from its previous location to
its new location, preserving the entire subtree.

The render objects in the reparented subtree are able to preserve
their layout information because the layout constraints are the only
information that flows from parent to child in the render tree.
The new parent is marked dirty for layout because its child list has
changed, but if the new parent passes the child the same layout
constraints the child received from its old parent, the child can
return immediately from layout, cutting off the walk.

Global keys and non-local tree mutations are used extensively by
developers to achieve effects such as hero transitions and navigation.

### Constant-factor optimizations

In addition to these algorithmic optimizations, achieving aggressive
composability also relies on several important constant-factor
optimizations. These optimizations are most important at the leaves of
the major algorithms discussed above.

* **Child-model agnostic.** Unlike most toolkits, which use child lists,
  Flutter’s render tree does not commit to a specific child model.
  For example, the `RenderBox` class has an abstract `visitChildren()`
  method rather than a concrete `firstChild` and `nextSibling` interface.
  Many subclasses support only a single child, held directly as a member
  variable, rather than a list of children. For example, `RenderPadding`
  supports only a single child and, as a result, has a simpler layout
  method that takes less time to execute.

* **Visual render tree, logical widget tree.** In Flutter, the render
  tree operates in a device-independent, visual coordinate system,
  which means smaller values in the x coordinate are always towards
  the left, even if the current reading direction is right-to-left.
  The widget tree typically operates in logical coordinates, meaning
  with _start_ and _end_ values whose visual interpretation depends
  on the reading direction. The transformation from logical to visual
  coordinates is done in the handoff between the widget tree and the
  render tree. This approach is more efficient because layout and
  painting calculations in the render tree happen more often than the
  widget-to-render tree handoff and can avoid repeated coordinate conversions.

* **Text handled by a specialized render object.** The vast majority
  of render objects are ignorant of the complexities of text. Instead,
  text is handled by a specialized render object, `RenderParagraph`,
  which is a leaf in the render tree. Rather than subclassing a
  text-aware render object, developers incorporate text into their
  user interface using composition. This pattern means `RenderParagraph`
  can avoid recomputing its text layout as long as its parent supplies
  the same layout constraints, which is common, even during tree surgery.

* **Observable objects.** Flutter uses both the model-observation and
  the reactive paradigms. Obviously, the reactive paradigm is dominant,
  but Flutter uses observable model objects for some leaf data structures.
  For example, `Animation`s notify an observer list when their value changes.
  Flutter hands off these observable objects from the widget tree to the
  render tree, which observes them directly and invalidates only the
  appropriate stage of the pipeline when they change. For example,
  a change to an `Animation<Color>` might trigger only the paint phase
  rather than both the build and paint phases.

Taken together and summed over the large trees created by aggressive
composition, these optimizations have a substantial effect on performance.

### Separation of the Element and RenderObject trees

The `RenderObject` and `Element` (Widget) trees in Flutter are isomorphic
(strictly speaking, the `RenderObject` tree is a subset of the `Element`
tree). An obvious simplification would be to combine these trees into
one tree. However, in practice there are a number of benefits to having
these trees be separate:

* **Performance.** When the layout changes, only the relevant parts of
  the layout tree need to be walked. Due to composition, the element
  tree frequently has many additional nodes that would have to be skipped.

* **Clarity.** The clearer separation of concerns allows the widget
  protocol and the render object protocol to each be specialized to
  their specific needs, simplifying the API surface and thus lowering
  the risk of bugs and the testing burden.

* **Type safety.** The render object tree can be more type safe since it
  can guarantee at runtime that children will be of the appropriate type
  (each coordinate system, e.g. has its own type of render object).
  Composition widgets can be agnostic about the coordinate system used
  during layout (for example, the same widget exposing a part of the app
  model could be used in both a box layout and a sliver layout), and thus
  in the element tree, verifying the type of render objects would require
  a tree walk.

## Infinite scrolling

Infinite scrolling lists are notoriously difficult for toolkits.
Flutter supports infinite scrolling lists with a simple interface
based on the _builder_ pattern, in which a `ListView` uses a callback
to build widgets on demand as they become visible to the user during
scrolling. Supporting this feature requires _viewport-aware layout_
and _building widgets on demand_.

### Viewport-aware layout

Like most things in Flutter, scrollable widgets are built using
composition. The outside of a scrollable widget is a `Viewport`,
which is a box that is "bigger on the inside," meaning its children
can extend beyond the bounds of the viewport and can be scrolled into
view. However, rather than having `RenderBox` children, a viewport has
`RenderSliver` children, known as _slivers_, which have a viewport-aware
layout protocol.

The sliver layout protocol matches the structure of the box layout
protocol in that parents pass constraints down to their children and
receive geometry in return. However, the constraint and geometry data
differs between the two protocols. In the sliver protocol, children
are given information about the viewport, including the amount of
visible space remaining. The geometry data they return enables a
variety of scroll-linked effects, including collapsible headers and
parallax.

Different slivers fill the space available in the viewport in different
ways. For example, a sliver that produces a linear list of children lays
out  each child in order until the sliver either runs out of children or
runs out of space. Similarly, a sliver that produces a two-dimensional
grid of children fills only the portion of its grid that is visible.
Because they are aware of how much space is visible, slivers can produce
a finite number of children even if they have the potential to produce
an unbounded number of children.

Slivers can be composed to create bespoke scrollable layouts and effects.
For example, a single viewport can have a collapsible header followed
by a linear list and then a grid. All three slivers will cooperate through
the sliver layout protocol to produce only those children that are actually
visible through the viewport, regardless of whether those children belong
to the header, the list, or the grid<sup><a href="#a6">6</a></sup>.

### Building widgets on demand

If Flutter had a strict _build-then-layout-then-paint_ pipeline,
the foregoing would be insufficient to implement an infinite scrolling
list because the information about how much space is visible through
the viewport is available only during the layout phase. Without
additional machinery, the layout phase is too late to build the
widgets necessary to fill the space. Flutter solves this problem
by interleaving the build and layout phases of the pipeline. At any
point in the layout phase, the framework can start building new
widgets on demand _as long as those widgets are descendants of the
render object currently performing layout_.

Interleaving build and layout is possible only because of the strict
controls on information propagation in the build and layout algorithms.
Specifically, during the build phase, information can propagate only
down the tree. When a render object is performing layout, the layout
walk has not visited the subtree below that render object, which means
writes generated by building in that subtree cannot invalidate any
information that has entered the layout calculation thus far. Similarly,
once layout has returned from a render object, that render object will
never be visited again during this layout, which means any writes
generated by subsequent layout calculations cannot invalidate the
information used to build the render object’s subtree.

Additionally, linear reconciliation and tree surgery are essential
for efficiently updating elements during scrolling and for modifying
the render tree when elements are scrolled into and out of view at
the edge of the viewport.

## API Ergonomics

Being fast only matters if the framework can actually be used effectively.
To guide Flutter's API design towards greater usability, Flutter has been
repeatedly tested in extensive UX studies with developers. These studies
sometimes confirmed pre-existing design decisions, sometimes helped guide
the prioritization of features, and sometimes changed the direction of the
API design. For instance, Flutter's APIs are heavily documented; UX
studies confirmed the value of such documentation, but also highlighted
the need specifically for sample code and illustrative diagrams.

This section discusses some of the decisions made in Flutter's API design
in aid of usability.

### Specializing APIs to match the developer's mindset

The base class for nodes in Flutter's `Widget`, `Element`, and `RenderObject`
trees does not define a child model. This allows each node to be
specialized for the child model that is applicable to that node.

Most `Widget` objects have a single child `Widget`, and therefore only expose
a single `child` parameter. Some widgets support an arbitrary number of
children, and expose a `children` parameter that takes a list.
Some widgets don't have any children at all and reserve no memory,
and have no parameters for them. Similarly, `RenderObjects` expose APIs
specific to their child model. `RenderImage` is a leaf node, and has no
concept of children. `RenderPadding` takes a single child, so it has storage
for a single pointer to a single child. `RenderFlex` takes an arbitrary
number of children and manages it as a linked list.

In some rare cases, more complicated child models are used. The
`RenderTable` render object's constructor takes an array of arrays of
children, the class exposes getters and setters that control the number
of rows and columns, and there are specific methods to replace
individual children by x,y coordinate, to add a row, to provide a
new array of arrays of children, and to replace the entire child list
with a single array and a column count. In the implementation,
the object does not use a linked list like most render objects but
instead uses an indexable array.

The `Chip` widgets and `InputDecoration` objects have fields that match
the slots that exist on the relevant controls. Where a one-size-fits-all
child model would force semantics to be layered on top of a list of
children, for example, defining the first child to be the prefix value
and the second to be the suffix, the dedicated child model allows for
dedicated named properties to be used instead.

This flexibility allows each node in these trees to be manipulated in
the way most idiomatic for its role. It's rare to want to insert a cell
in a table, causing all the other cells to wrap around; similarly,
it's rare to want to remove a child from a flex row by index instead
of by reference.

The `RenderParagraph` object is the most extreme case: it has a child of
an entirely different type, `TextSpan`. At the `RenderParagraph` boundary,
the `RenderObject` tree transitions into being a `TextSpan` tree.

The overall approach of specializing APIs to meet the developer's
expectations is applied to more than just child models.

Some rather trivial widgets exist specifically so that developers
will find them when looking for a solution to a problem. Adding a
space to a row or column is easily done once one knows how, using
the `Expanded` widget and a zero-sized `SizedBox` child, but discovering
that pattern is unnecessary because searching for `space`
uncovers the `Spacer` widget, which uses `Expanded` and `SizedBox` directly
to achieve the effect.

Similarly, hiding a widget subtree is easily done by not including the
widget subtree in the build at all. However, developers typically expect
there to be a widget to do this, and so the `Visibility` widget exists
to wrap this pattern in a trivial reusable widget.

### Explicit arguments

UI frameworks tend to have many properties, such that a developer is
rarely able to remember the semantic meaning of each constructor
argument of each class. As Flutter uses the reactive paradigm,
it is common for build methods in Flutter to have many calls to
constructors. By leveraging Dart's support for named arguments,
Flutter's API is able to keep such build methods clear and understandable.

This pattern is extended to any method with multiple arguments,
and in particular is extended to any boolean argument, so that isolated
`true` or `false` literals in method calls are always self-documenting.
Furthermore, to avoid confusion commonly caused by double negatives
in APIs, boolean arguments and properties are always named in the
positive form (for example, `enabled: true` rather than `disabled: false`).

### Paving over pitfalls

A technique used in a number of places in the Flutter framework is to
define the API such that error conditions don't exist. This removes
entire classes of errors from consideration.

For example, interpolation functions allow one or both ends of the
interpolation to be null, instead of defining that as an error case:
interpolating between two null values is always null, and interpolating
from a null value or to a null value is the equivalent of interpolating
to the zero analog for the given type. This means that developers
who accidentally pass null to an interpolation function will not hit
an error case, but will instead get a reasonable result.

A more subtle example is in the `Flex` layout algorithm. The concept of
this layout is that the space given to the flex render object is
divided among its children, so the size of the flex should be the
entirety of the available space. In the original design, providing
infinite space would fail: it would imply that the flex should be
infinitely sized, a useless layout configuration. Instead, the API
was adjusted so that when infinite space is allocated to the flex
render object, the render object sizes itself to fit the desired
size of the children, reducing the possible number of error cases.

The approach is also used to avoid having constructors that allow
inconsistent data to be created. For instance, the `PointerDownEvent`
constructor does not allow the `down` property of `PointerEvent` to
be set to `false` (a situation that would be self-contradictory);
instead, the constructor does not have a parameter for the `down`
field and always sets it to `true`.

In general, the approach is to define valid interpretations for all
values in the input domain. The simplest example is the `Color` constructor.
Instead of taking four integers, one for red, one for green,
one for blue, and one for alpha, each of which could be out of range,
the default constructor takes a single integer value, and defines
the meaning of each bit (for example, the bottom eight bits define the
red component), so that any input value is a valid color value.

A more elaborate example is the `paintImage()` function. This function
takes eleven arguments, some with quite wide input domains, but they
have been carefully designed to be mostly orthogonal to each other,
such that there are very few invalid combinations.

### Reporting error cases aggressively

Not all error conditions can be designed out. For those that remain,
in debug builds, Flutter generally attempts to catch the errors very
early and immediately reports them. Asserts are widely used.
Constructor arguments are sanity checked in detail. Lifecycles are
monitored and when inconsistencies are detected they immediately
cause an exception to be thrown.

In some cases, this is taken to extremes: for example, when running
unit tests, regardless of what else the test is doing, every `RenderBox`
subclass that is laid out aggressively inspects whether its intrinsic
sizing methods fulfill the intrinsic sizing contract. This helps catch
errors in APIs that might otherwise not be exercised.

When exceptions are thrown, they include as much information as
is available. Some of Flutter's error messages proactively probe the
associated stack trace to determine the most likely location of the
actual bug. Others walk the relevant trees to determine the source
of bad data. The most common errors include detailed instructions
including in some cases sample code for avoiding the error, or links
to further documentation.

### Reactive paradigm

Mutable tree-based APIs suffer from a dichotomous access pattern:
creating the tree's original state typically uses a very different
set of operations than subsequent updates. Flutter's rendering layer
uses this paradigm, as it is an effective way to maintain a persistent tree,
which is key for efficient layout and painting. However, it means
that direct interaction with the rendering layer is awkward at best
and bug-prone at worst.

Flutter's widget layer introduces a composition mechanism using the
reactive paradigm<sup><a href="#a7">7</a></sup> to manipulate the
underlying rendering tree.
This API abstracts out the tree manipulation by combining the tree
creation and tree mutation steps into a single tree description (build)
step, where, after each change to the system state, the new configuration
of the user interface is described by the developer and the framework
computes the series of tree mutations necessary to reflect this new
configuration.

### Interpolation

Since Flutter's framework encourages developers to describe the interface
configuration matching the current application state, a mechanism exists
to implicitly animate between these configurations.

For example, suppose that in state S<sub>1</sub> the interface consists
of a circle, but in state S<sub>2</sub> it consists of a square.
Without an animation mechanism, the state change would have a jarring
interface change. An implicit animation allows the circle to be smoothly
squared over several frames.

Each feature that can be implicitly animated has a stateful widget that
keeps a record of the current value of the input, and begins an animation
sequence whenever the input value changes, transitioning from the current
value to the new value over a specified duration.

This is implemented using `lerp` (linear interpolation) functions using
immutable objects. Each state (circle and square, in this case)
is represented as an immutable object that is configured with
appropriate settings (color, stroke width, etc) and knows how to paint
itself. When it is time to draw the intermediate steps during the animation,
the start and end values are passed to the appropriate `lerp` function
along with a _t_ value representing the point along the animation,
where 0.0 represents the `start` and 1.0 represents the
`end`<sup><a href="#a8">8</a></sup>,
and the function returns a third immutable object representing the
intermediate stage.

For the circle-to-square transition, the `lerp` function would return
an object representing a "rounded square" with a radius described as
a fraction derived from the _t_ value, a color interpolated using the
`lerp` function for colors, and a stroke width interpolated using the
`lerp` function for doubles. That object, which implements the
same interface as circles and squares, would then be able to paint
itself when requested to.

This technique allows the state machinery, the mapping of states to
configurations, the animation machinery, the interpolation machinery,
and the specific logic relating to how to paint each frame to be
entirely separated from each other.

This approach is broadly applicable. In Flutter, basic types like
`Color` and `Shape` can be interpolated, but so can much more elaborate
types such as `Decoration`, `TextStyle`, or `Theme`. These are
typically constructed from components that can themselves be interpolated,
and interpolating the more complicated objects is often as simple as
recursively interpolating all the values that describe the complicated
objects.

Some interpolatable objects are defined by class hierarchies. For example,
shapes are represented by the `ShapeBorder` interface, and there exists a
variety of shapes, including `BeveledRectangleBorder`, `BoxBorder`,
`CircleBorder`, `RoundedRectangleBorder`, and `StadiumBorder`. A single
`lerp` function cannot have a priori knowledge of all the possible types,
and therefore the interface instead defines `lerpFrom` and `lerpTo` methods,
which the static `lerp` method defers to. When told to interpolate from
a shape A to a shape B, first B is asked if it can `lerpFrom` A, then,
if it cannot, A is instead asked if it can `lerpTo` B. (If neither is
possible, then the function returns A from values of `t` less than 0.5,
and returns B otherwise.)

This allows the class hierarchy to be arbitrarily extended, with later
additions being able to interpolate between previously-known values
and themselves.

In some cases, the interpolation itself cannot be described by any of
the available classes, and a private class is defined to describe the
intermediate stage. This is the case, for instance, when interpolating
between a `CircleBorder` and a `RoundedRectangleBorder`.

This mechanism has one further added advantage: it can handle interpolation
from intermediate stages to new values. For example, half-way through
a circle-to-square transition, the shape could be changed once more,
causing the animation to need to interpolate to a triangle. So long as
the triangle class can `lerpFrom` the rounded-square intermediate class,
the transition can be seamlessly performed.

## Conclusion

Flutter’s slogan, "everything is a widget," revolves around building
user interfaces by composing widgets that are, in turn, composed of
progressively more basic widgets. The result of this aggressive
composition is a large number of widgets that require carefully
designed algorithms and data structures to process efficiently.
With some additional design, these data structures also make it
easy for developers to create infinite scrolling lists that build
widgets on demand when they become visible.

---
**Footnotes:**

<sup><a name="a1">1</a></sup> For layout, at least. It might be revisited
  for painting, for building the accessibility tree if necessary,
  and for hit testing if necessary.

<sup><a name="a2">2</a></sup> Reality, of course, is a bit more
  complicated. Some layouts involve intrinsic dimensions or baseline
  measurements, which do involve an additional walk of the relevant subtree
  (aggressive caching is used to mitigate the potential for quadratic
  performance in the worst case). These cases, however, are surprisingly
  rare. In particular, intrinsic dimensions are not required for the
  common case of shrink-wrapping.

<sup><a name="a3">3</a></sup> Technically, the child's position is not
  part of its RenderBox geometry and therefore need not actually be
  calculated during layout. Many render objects implicitly position
  their single child at 0,0 relative to their own origin, which
  requires no computation or storage at all. Some render objects
  avoid computing the position of their children until the last
  possible moment (for example, during the paint phase), to avoid
  the computation entirely if they are not subsequently painted.

<sup><a name="a4">4</a></sup>  There exists one exception to this rule.
  As discussed in the [Building widgets on demand](#building-widgets-on-demand)
  section, some widgets can be rebuilt as a result of a change in layout
  constraints. If a widget marked itself dirty for unrelated reasons in
  the same frame that it also is affected by a change in layout constraints,
  it will be updated twice. This redundant build is limited to the
  widget itself and does not impact its descendants.

<sup><a name="a5">5</a></sup> A key is an opaque object optionally
  associated with a widget whose equality operator is used to influence
  the reconciliation algorithm.

<sup><a name="a6">6</a></sup>  For accessibility, and to give applications
  a few extra milliseconds between when a widget is built and when it
  appears on the screen, the viewport creates (but does not paint)
  widgets for a few hundred pixels before and after the visible widgets.

<sup><a name="a7">7</a></sup>  This approach was first made popular by
  Facebook's React library.

<sup><a name="a8">8</a></sup>  In practice, the _t_ value is allowed
  to extend past the 0.0-1.0 range, and does so for some curves. For
  example, the "elastic" curves overshoot briefly in order to represent
  a bouncing effect. The interpolation logic typically can extrapolate
  past the start or end as appropriate. For some types, for example,
  when interpolating colors, the _t_ value is effectively clamped to
  the 0.0-1.0 range.
