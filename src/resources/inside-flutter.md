---
title: Inside Flutter
---

# Overview

This document describes the inner workings of the Flutter toolkit that make
Flutter’s API possible. Because Flutter widgets are built using aggressive
composition, user interfaces built with Flutter have a large number of widgets.
To support this workload, Flutter uses sublinear algorithms for layout
and building widgets as well as data structures that make tree surgery
efficient and that have a number of constant-factor optimizations.
With some additional details, this design also makes it easy for developers
to create infinite scrolling lists using callbacks that build exactly those
widgets that are visible to the user.

# Aggressive Composability

One of the most distinctive aspects of Flutter is its _aggressive
composability_. Widgets are built by composing other widgets,
which are themselves built out of progressively more basic widgets.
For example, `Padding` is a widget rather than a property of other widgets.
As a result, user interfaces built with Flutter consist of many, many widgets.

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

## Sublinear layout

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
Notice that the child's layout cannot depend on the child's position
because the child's position is not determined until after the child
returns from layout. As a result, the parent is free to reposition
the child without needing to recompute the child's layout.

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
irty nodes, only those nodes and a limited part of the subtree around
them are visited during layout.

## Sublinear widget building

Similar to the layout algorithm, Flutter's widget building algorithm
is sublinear. After being built, the widgets are held by the _element_
tree, which retains the logical structure of the user interface.
The element tree is necessary because the widgets themselves are
_immutable_, which means (among other things), they cannot remember their
parent or child relationships with other widgets. The element tree also
holds the _state_ objects associated with stateful widgets.

In response to user input (or other stimuli), an element can become dirty,
for example if the developer calls `setState()` on the associated state object.
The framework keeps a list of dirty elements and jumps directly to them
during the _build_ phase, skipping over clean elements. During the build
phase, information flows _unidirectionally_ down the element tree,
which means each element is visited at most once during the build phase.
Once cleaned, an element cannot become dirty again because, by induction,
all its ancestor elements are also clean<sup><a href="#a4">4</a></sup>.

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
a hash table of InheritedWidgets at each element. Typically, many
elements will reference the same hash table, which changes only at
elements that introduce a new InheritedWidget.

## Linear reconciliation

Contrary to popular belief, Flutter does not employ a tree-diffing
algorithm. Instead, the framework decides whether to reuse elements by
examining the child list for each element independently using an O(N)
algorithm. The child list reconciliation algorithm optimizes for the
following cases:

* The old child list is empty.
* The two lists are identical.
* There is an insertion or removal of one or more widgets in exactly
  one place in the list.
* If each list contains a widget with the same key, the two widgets are matched.

The general approach is to match up the beginning and end of both child
lists by comparing the runtime type and key of each widget,
potentially finding a non-empty range in the middle of each list
that contains all the unmatched children. The framework then places
the children in the range in the old child list into a hash table
based on their keys. Next, the framework walks the range in the new
child list and queries the hash table by key for matches. Unmatched
children are discarded and rebuilt from scratch whereas matched children
are rebuilt with their new widgets.

## Tree surgery

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

## Constant-factor optimizations

In addition to these algorithmic optimizations, achieving aggressive
composability also relies on several important constant-factor
optimizations. These optimizations are most important at the leaves of
the major algorithms discussed above.

* **Child-model agnostic.** Unlike most toolkits, which use child lists,
  Flutter’s render tree does not commit to a specific child model.
  For example, the `RenderBox` class has an abstract `visitChildren()`
  method rather than a concrete _firstChild_ and _nextSibling_ interface.
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
  For example, _Animations_ notify an observer list when their value changes.
  Flutter hands off these observable objects from the widget tree to the
  render tree, which observes them directly and invalidates only the
  appropriate stage of the pipeline when they change. For example,
  a change to an _Animation<Color>_ might trigger only the paint phase
  rather than both the build and paint phases.

Taken together and summed over the large trees created by aggressive
composition, these optimizations have a substantial effect on performance.

# Infinite scrolling

Infinite scrolling lists are notoriously difficult for toolkits.
Flutter supports infinite scrolling lists with a simple interface
based on the _builder_ pattern, in which a `ListView` uses a callback
to build widgets on demand as they become visible to the user during
scrolling. Supporting this feature requires _viewport-aware layout_
and _building widgets on demand__.

## Viewport-aware layout

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
to the header, the list, or the grid.

## Building widgets on demand

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

# Conclusion

Flutter’s slogan, "everything is a widget," revolves around building
user interfaces by composing widgets that are, in turn, composed of
progressively more basic widgets. The result of this aggressive
composition is a large number of widgets that require carefully
designed algorithms and data structures to process efficiently.
With some additional design, these data structures also make it
easy for developers to create infinite scrolling lists that build
widgets on demand when they become visible.

---

<sup><a name="a1">1</a></sup> For layout, at least. It may be revisited
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
  the reconciliation algorithm. (PENDING: This isn't linked to.)

<sup><a name="a6">6</a></sup>  For accessibility, and to give applications
  a few extra milliseconds between when a widget is built and when it
  appears on the screen, the viewport creates (but does not paint)
  widgets for a few hundred pixels before and after the visible widgets.
  (PENDING: This isn't linked to.)
