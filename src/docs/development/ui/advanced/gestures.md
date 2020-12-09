---
title: Taps, drags, and other gestures
description: How gestures, such as taps and drags, work in Flutter.
---

This document explains how to listen for, and respond to,
_gestures_ in Flutter. Examples of gestures include
taps, drags, and scaling.

The gesture system in Flutter has two separate layers.
The first layer has raw pointer events that describe
the location and movement of pointers (for example,
touches, mice, and styli) across the screen.
The second layer has _gestures_ that describe semantic
actions that consist of one or more pointer movements.

## Pointers

Pointers represent raw data about the user's interaction
with the device's screen.
There are four types of pointer events:

[`PointerDownEvent`][]
: The pointer has contacted the screen at a particular location.

[`PointerMoveEvent`][]
: The pointer has moved from one location on the screen to another.

[`PointerUpEvent`][]
: The pointer has stopped contacting the screen.

[`PointerCancelEvent`][]
: Input from this pointer is no longer directed towards this app.

On pointer down, the framework does a _hit test_ on your app
to determine which widget exists at the location where the
pointer contacted the screen. The pointer down event
(and subsequent events for that pointer) are then dispatched
to the innermost widget found by the hit test.
From there, the events bubble up the tree and are dispatched
to all the widgets on the path from the innermost
widget to the root of the tree. There is no mechanism for
canceling or stopping pointer events from being dispatched further.

To listen to pointer events directly from the widgets layer, use a
[`Listener`][] widget. However, generally,
consider using gestures (as discussed below) instead.

## Gestures

Gestures represent semantic actions (for example, tap, drag,
and scale) that are recognized from multiple individual pointer
events, potentially even multiple individual pointers.
Gestures can dispatch multiple events, corresponding to the
lifecycle of the gesture (for example, drag start,
drag update, and drag end):

**Tap**

`onTapDown`
: A pointer that might cause a tap has contacted
  the screen at a particular location.

`onTapUp`
: A pointer that will trigger a tap has stopped contacting
  the screen at a particular location.

`onTap`
: The pointer that previously triggered the `onTapDown`
  has also triggered `onTapUp` which ends up causing a tap.

`onTapCancel`
: The pointer that previously triggered the `onTapDown`
  will not end up causing a tap.

**Double tap**

`onDoubleTap`
: The user has tapped the screen at the same location twice in
  quick succession.

**Long press**

`onLongPress`
: A pointer has remained in contact with the
  screen at the same location for a long period of time.

**Vertical drag**

`onVerticalDragStart`
: A pointer has contacted the screen and might begin to
  move vertically.

`onVerticalDragUpdate`
: A pointer that is in contact with the screen and
    moving vertically has moved in the vertical direction.

`onVerticalDragEnd`
: A pointer that was previously in contact with the screen
    and moving vertically is no longer in contact with the
    screen and was moving at a specific velocity when it
    stopped contacting the screen.

**Horizontal drag**

`onHorizontalDragStart`
: A pointer has contacted the screen and might begin to
  move horizontally.

`onHorizontalDragUpdate`
: A pointer that is in contact with the screen and
  moving horizontally has moved in the horizontal direction.

`onHorizontalDragEnd`
: A pointer that was previously in contact with the
  screen and moving horizontally is no longer in contact
  with the screen and was moving at a specific velocity
  when it stopped contacting the screen.

**Pan**

`onPanStart`
: A pointer has contacted the screen and might begin to move
  horizontally or vertically. This callback causes a crash if
  `onHorizontalDragStart` or `onVerticalDragStart` is set.

`onPanUpdate`
: A pointer that is in contact with the screen and is moving
  in the vertical or horizontal direction. This callback causes
  a crash if `onHorizontalDragUpdate` or `onVerticalDragUpdate`
  is set.

`onPanEnd`
: A pointer that was previously in contact with screen
  is no longer in contact with the screen and is moving
  at a specific velocity when it stopped contacting the screen.
  This callback causes a crash if `onHorizontalDragEnd` or
  `onVerticalDragEnd` is set.

### Adding gesture detection to widgets

To listen to gestures from the widgets layer, use a
[`GestureDetector`][].

If you're using Material Components,
many of those widgets already respond to taps or gestures.
For example, [`IconButton`][] and [`TextButton`][]
respond to presses (taps), and [`ListView`][]
responds to swipes to trigger scrolling.
If you are not using those widgets, but you want the
"ink splash" effect on a tap, you can use [`InkWell`][].

### Gesture disambiguation

At a given location on screen, there might be multiple gesture
detectors. All of these gesture detectors listen to the stream
of pointer events as they flow past and attempt to recognize
specific gestures. The [`GestureDetector`] widget decides
which gestures to attempt to recognize based on which of its
callbacks are non-null.

When there is more than one gesture recognizer for a given
pointer on the screen, the framework disambiguates which
gesture the user intends by having each recognizer join
the _gesture arena_. The gesture arena determines which
gesture wins using the following rules:

* At any time, a recognizer can declare defeat and leave the
  arena.  If there's only one recognizer left in the arena,
  that recognizer is the winner.

* At any time, a recognizer can declare victory, which causes
  it to win and all the remaining recognizers to lose.

For example, when disambiguating horizontal and vertical dragging,
both recognizers enter the arena when they receive the pointer
down event.  The recognizers observe the pointer move events.
If the user moves the pointer more than a certain number of
logical pixels horizontally, the horizontal recognizer
declares victory and the gesture is interpreted as a horizontal
drag.  Similarly, if the user moves more than a certain number
of logical pixels vertically, the vertical recognizer declares victory.

The gesture arena is beneficial when there is only a horizontal
(or vertical) drag recognizer.  In that case, there is only one
recognizer in the arena and the horizontal drag is recognized
immediately, which means the first pixel of horizontal movement
can be treated as a drag and the user won't need to wait for
further gesture disambiguation.


[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html
[`GestureDetector`]: {{site.api}}/flutter/widgets/GestureDetector-class.html
[`IconButton`]: {{site.api}}/flutter/material/IconButton-class.html
[`InkWell`]: {{site.api}}/flutter/material/InkWell-class.html
[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html
[`Listener`]: {{site.api}}/flutter/widgets/Listener-class.html
[`PointerCancelEvent`]: {{site.api}}/flutter/gestures/PointerCancelEvent-class.html
[`PointerDownEvent`]: {{site.api}}/flutter/gestures/PointerDownEvent-class.html
[`PointerMoveEvent`]: {{site.api}}/flutter/gestures/PointerMoveEvent-class.html
[`PointerUpEvent`]: {{site.api}}/flutter/gestures/PointerUpEvent-class.html
