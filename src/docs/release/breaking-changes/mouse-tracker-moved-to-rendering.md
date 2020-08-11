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

Prior to this change [`MouseTracker`][] was part of the
`gestures` package. This brought troubles when we found out
that code related to [`MouseTracker`][] often wanted to
import from the `rendering` package.

Since [`MouseTracker`][] turned out to be more connected to
`rendering` than `gestures`, we have moved it and its
related code to `rendering`. 

## Description of change

The file `mouse_tracking.dart` has been moved from the
`gestures` package to `rendering`. All symbols in the said
file have been moved without keeping backward compatibility.

## Migration guide

If you see error of "Undefined class" or "Undefined name" of
the following symbols:

  * [`MouseDetectorAnnotationFinder`][]
  * [`MouseTracker`][]
  * [`MouseTrackerAnnotation`][]
  * [`PointerEnterEventListener`][]
  * [`PointerExitEventListener`][]
  * [`PointerHoverEventListener`][]

You should add the following import:

```dart
import 'package:flutter/rendering.dart';
```

## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

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

Relevant PR:
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
