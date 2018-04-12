---
layout: page
title: Taps, drags, and other gestures in Flutter

permalink: /gestures/
---

* TOC Placeholder
{:toc}

# Introduction

This document explains how to listen for, and respond to,
_gestures_ in Flutter. Examples of gestures include
taps, drags, and scaling.

The gesture system in Flutter has two separate layers.  The first layer has raw
pointer events, which describe the location and movement of pointers (e.g.,
touches, mice, and styli) across the screen. The second layer has _gestures_,
which describe semantic actions that consist of one or more pointer movements.

# Pointers

Pointers represent raw data about the user's interaction with the device's
screen.  There are four types of pointer events:

- [`PointerDownEvent`](https://docs.flutter.io/flutter/gestures/PointerDownEvent-class.html)
  The pointer has contacted the screen at a particular location.
- [`PointerMoveEvent`](https://docs.flutter.io/flutter/gestures/PointerMoveEvent-class.html)
  The pointer has moved from one location on the screen to another.
- [`PointerUpEvent`](https://docs.flutter.io/flutter/gestures/PointerUpEvent-class.html)
  The pointer has stopped contacting the screen.
- [`PointerCancelEvent`](https://docs.flutter.io/flutter/gestures/PointerCancelEvent-class.html)
  Input from this pointer is no longer directed towards this app.

On pointer down, the framework does a _hit test_ on your app to determine what
widgets exists at the location where the pointer contacted the screen. The
pointer down event (and subsequent events for that pointer) are then dispatched
to the innermost widget found by the hit test. From there, the events bubble up
the tree and are dispatched to all the widgets on the path from the innermost
widget to the root of the tree. There is no mechanism for canceling or stopping
pointer events from being dispatched further.

To listen to pointer events directly from the widgets layer, use a
[`Listener`](https://docs.flutter.io/flutter/widgets/Listener-class.html)
widget. However, generally, consider using gestures (as discussed
below) instead.

# Gestures

Gestures represent semantic actions (e.g., tap, drag, and scale) that are
recognized from multiple individual pointer events, potentially even multiple
individual pointers. Gestures can dispatch multiple events, corresponding to the
lifecycle of the gesture (e.g., drag start, drag update, and drag end):

- Tap
  - `onTapDown` A pointer that might cause a tap has contacted the screen at a
    particular location.
  - `onTapUp` A pointer that will trigger a tap has stopped contacting the screen
    at a particular location.
  - `onTap` A tap has occurred.
  - `onTapCancel` The pointer that previously triggered the `onTapDown` will not
    end up causing a tap.
- Double tap
  - `onDoubleTap` The user has tapped the screen at the same location twice in
    quick succession.
- Long press
  - `onLongPress` A pointer has remained in contact with the screen at the same
    location for a long period of time.
- Vertical drag
  - `onVerticalDragStart` A pointer has contacted the screen and might begin to
    move vertically.
  - `onVerticalDragUpdate` A pointer that is in contact with the screen and
    moving vertically has moved in the vertical direction.
  - `onVerticalDragEnd` A pointer that was previously in contact with the screen
    and moving vertically is no longer in contact with the screen and was moving
    at a specific velocity when it stopped contacting the screen.
- Horizontal drag
  - `onHorizontalDragStart` A pointer has contacted the screen and might begin to
    move horizontally.
  - `onHorizontalDragUpdate` A pointer that is in contact with the screen and
    moving horizontally has moved in the horizontal direction.
  - `onHorizontalDragEnd` A pointer that was previously in contact with the
    screen and moving horizontally is no longer in contact with the screen and
    was moving at a specific velocity when it stopped contacting the screen.

To listen to gestures from the widgets layer, use a
[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html).

If you're using Material Components, many of those widgets already respond
to taps or gestures.
For example,
[IconButton](https://docs.flutter.io/flutter/material/IconButton-class.html) and
[FlatButton](https://docs.flutter.io/flutter/material/FlatButton-class.html)
respond to presses (taps), and
[`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html)
responds to swipes to trigger scrolling.
If you are not using those widgets, but you want the "ink splash" effect on a
tap, you can use
[`InkWell`](https://docs.flutter.io/flutter/material/InkWell-class.html).

## Gesture disambiguation

At a given location on screen, there might be multiple gesture detectors. All
of these gesture detectors listen to the stream of pointer events as they flow
past and attempt to recognize specific gestures. The
[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html)
widget decides which gestures to attempt to recognize based on which of its
callbacks are non-null.

When there is more than one gesture recognizer for a given pointer on the
screen, the framework disambiguates which gesture the user intends by having
each recognizer join the _gesture arena_. The gesture arena determines which
gesture wins using the following rules:

- At any time, a recognizer can declare defeat and leave the arena.  If there's
  only one recognizer left in the arena, that recognizer is the winner.

- At any time, a recognizer can declare victory, which causes it to win and all
  the remaining recognizers to lose.

For example, when disambiguating horizontal and vertical dragging, both
recognizers enter the arena when they receive the pointer down event.  The
recognizers observe the pointer move events.  If the user moves the pointer more
than a certain number of logical pixels horizontally, the horizontal recognizer
will declare victory and the gesture will be interpreted as a horizontal drag.
Similarly, if the user moves more than a certain number of logical pixels
vertically, the vertical recognizer will declare victory.

The gesture arena is beneficial when there is only a horizontal (or vertical)
drag recognizer.  In that case, there will be only one recognizer in the arena
and the horizontal drag will be recognized immediately, which means the first
pixel of horizontal movement can be treated as a drag and the user will not need
to wait for further gesture disambiguation.
