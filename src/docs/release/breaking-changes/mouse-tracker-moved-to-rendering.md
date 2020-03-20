---
title: MouseTracker moved to rendering
description: MouseTracker and related symbols moved to the rendering package.
---

## Summary

[`MouseTracker`][] and related symbols are moved from the
`gestures` package, resulting in error messages such as
undefined classes or methods. Import them from `rendering`
package instead.

## Context

Gestures are roughly defined as aggregations of pointer
events. When a pointer event arrives, multiple gesture
recognizers, each representing one kind of gesture, join a
gesture arena and decide one winner through the event
sequence.

[`MouseTracker`][] is a (usually) singleton class that
dispatches pointer events that are specifically for a mouse
(i.e. enter, exit, and, move) directly to interested
objects.

This shows that [`MouseTracker`][] is not really part of
gestures, but is rather a supporting system to dispatch
these events. [`MouseTracker`][] were not connected with the
rest of the package either in terms of code. On the other
hand, its existence in the gestures packages had brought
many troubles, because code related to [`MouseTracker`][] often
wants to import from the `rendering` package. This shows
that `rendering` is where it really belongs.

## Description of change

The file `mouse_tracking.dart` has been moved from the
`gestures` package to `rendering`.

All symbols in the said file have be moved without keeping
backward compatibility. Following is the full list:

  * [`PointerEnterEventListener`][]
  * [`PointerExitEventListener`][]
  * [`PointerHoverEventListener`][]
  * [`MouseTrackerAnnotation`][]
  * [`MouseDetectorAnnotationFinder`][]
  * [`MouseTracker`][]

## Migration guide

If the affected symbols are reported undefined,
add the following import:

```dart
import 'package:flutter/rendering.dart';
```

## Timeline

Changes since 1.2.22.

## References

API documentation:
* [`MouseDetectorAnnotationFinder`][]
* [`MouseTracker`][]
* [`MouseTrackerAnnotation`][]
* [`PointerEnterEventListener`][]
* [`PointerExitEventListener`][]
* [`PointerHoverEventListener`][]

Relevant issues:
* [Transform mouse events to the local coordinate system][]
* [Move annotations to a separate tree][]

Relevant PRs:
* [Move mouse_tracking.dart to rendering][]

[Move annotations to a separate tree]: {{site.github}}/flutter/flutter/issues/49568
[Move mouse_tracking.dart to rendering]: {{site.github}}/flutter/flutter/pull/52781 
[Transform mouse events to the local coordinate system]: {{site.github}}/flutter/flutter/issues/33675
[`MouseDetectorAnnotationFinder`]: {{site.api}}/flutter/gestures/MouseDetectorAnnotationFinder.html
[`MouseTracker`]: {{site.api}}/flutter/gestures/MouseTracker-class.html
[`MouseTrackerAnnotation`]: {{site.api}}/flutter/gestures/MouseTrackerAnnotation-class.html 
[`PointerEnterEventListener`]: {{site.api}}/flutter/gestures/PointerEnterEventListener.html 
[`PointerExitEventListener`]: {{site.api}}/flutter/gestures/PointerExitEventListener.html 
[`PointerHoverEventListener`]: {{site.api}}/flutter/gestures/PointerHoverEventListener.html 
