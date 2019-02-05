---
title: Dealing with box constraints
short-title: Box constraints
---

{{site.alert.note}}
  You may be directed to this page if the framework detects a problem involving
  box constraints.
{{site.alert.end}}

In Flutter, widgets are rendered by their underlying
[`RenderBox`]({{site.api}}/flutter/rendering/RenderBox-class.html)
objects. Render boxes are given
constraints by their parent, and size themselves within those
constraints. Constraints consist of minimum and maximum widths and
heights; sizes consist of a specific width and height.

Generally, there are three kinds of boxes, in terms of how they handle
their constraints:

- Those that try to be as big as possible.
  For example, the boxes used by [`Center`]({{site.api}}/flutter/widgets/Center-class.html) and [`ListView`]({{site.api}}/flutter/widgets/ListView-class.html).
- Those that try to be the same size as their children.
  For example, the boxes used by [`Transform`]({{site.api}}/flutter/widgets/Transform-class.html) and [`Opacity`]({{site.api}}/flutter/widgets/Opacity-class.html).
- Those that try to be a particular size.
  For example, the boxes used by [`Image`]({{site.api}}/flutter/dart-ui/Image-class.html) and [`Text`]({{site.api}}/flutter/widgets/Text-class.html).

Some widgets, for example [`Container`]({{site.api}}/flutter/widgets/Container-class.html), vary from type to type based on
their constructor arguments. In the case of [`Container`]({{site.api}}/flutter/widgets/Container-class.html), it defaults
to trying to be as big as possible, but if you give it a `width`, for
instance, it tries to honor that and be that particular size.

Others, for example [`Row`]({{site.api}}/flutter/widgets/Row-class.html) and [`Column`]({{site.api}}/flutter/widgets/Column-class.html) (flex boxes) vary based on the
constraints they are given, as described below in the "Flex" section.

The constraints are sometimes "tight", meaning that they leave no room
for the render box to decide on a size (e.g. if the minimum and
maximum width are the same, it is said to have a tight width). The
main example of this is the `App` widget, which is contained by the
[`RenderView`]({{site.api}}/flutter/rendering/RenderView-class.html)
class: the box used by the child returned by the
application's [`build`]({{site.api}}/flutter/widgets/State/build.html)
function is given a constraint that forces it to
exactly fill the application's content area (typically, the entire
screen). Many of the boxes in Flutter, especially those that just take a
single child, pass their constraint on to their children. This
means that if you nest a bunch of boxes inside each other at the root
of your application's render tree, they'll all exactly fit in each
other, forced by these tight constraints.

Some boxes _loosen_ the constraints, meaning the maximum is maintained
but the minimum is removed. For example,
[`Center`]({{site.api}}/flutter/widgets/Center-class.html).

Unbounded constraints
---------------------

In certain situations, the constraint that is given to a box is
_unbounded_, or infinite. This means that either the maximum width or
the maximum height is set to `double.INFINITY`.

A box that tries to be as big as possible won't function usefully when
given an unbounded constraint and, in debug mode, such a combination
throws an exception that points to this file.

The most common cases where a render box finds itself with unbounded
constraints are within flex boxes
([`Row`]({{site.api}}/flutter/widgets/Row-class.html)
and [`Column`]({{site.api}}/flutter/widgets/Column-class.html)),
and **within scrollable regions**
([`ListView`]({{site.api}}/flutter/widgets/ListView-class.html)
and other [`ScrollView`]({{site.api}}/flutter/widgets/ScrollView-class.html) subclasses).

In particular, [`ListView`]({{site.api}}/flutter/widgets/ListView-class.html)
tries to expand to fit the space available
in its cross-direction (for example, if it's a vertically-scrolling block,
it tries to be as wide as its parent). If you nest a vertically
scrolling [`ListView`]({{site.api}}/flutter/widgets/ListView-class.html)
inside a horizontally scrolling [`ListView`]({{site.api}}/flutter/widgets/ListView-class.html),
the inner one tries to be as wide as possible, which is infinitely
wide, since the outer one is scrollable in that direction.

Flex
----

Flex boxes themselves
([`Row`]({{site.api}}/flutter/widgets/Row-class.html)
and [`Column`]({{site.api}}/flutter/widgets/Column-class.html))
behave differently based on
whether they are in a bounded constraints or unbounded constraints in
their given direction.

In bounded constraints, they try to be as big as possible in that
direction.

In unbounded constraints, they try to fit their children in that
direction. In this case, you cannot set `flex` on the children to
anything other than 0 (the default). In the widget library, this
means that you cannot use [`Expanded`]({{site.api}}/flutter/widgets/Expanded-class.html)
when the flex box is inside
another flex box or inside a scrollable. If you do, you'll get an
exception message pointing you at this document.

In the _cross_ direction, i.e. in their width for
[`Column`]({{site.api}}/flutter/widgets/Column-class.html)
(vertical flex) and in their height for
[`Row`]({{site.api}}/flutter/widgets/Row-class.html)
(horizontal flex), they must never be unbounded,
otherwise they would not be able to reasonably align their children.
