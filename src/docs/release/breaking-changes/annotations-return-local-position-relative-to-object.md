---
title: AnnotatedRegionLayers return local position relative to clipping region
description: Provide annotation searches with reliable and meaningful local positions.
---

## Summary

The local position returned by `AnnotatedRegionLayers` in an
annotation search has been changed to be relative to the clipping
region instead of the layer. This makes the local position more
meaningful and reliable, but breaks code that directly performs
annotation searches and uses the local position.

## Context

Annotations are metadata that are assigned during the
rendering phase to regions on the screen.
Searching the annotations with a location gives the
contextual information that contains that location.
They are used to detect mouse events and the theme of app bars.

When `localPosition` was first added to the search result,
it was defined as relative to the layer that owned the annotation,
which turned out to be a design mistake.
The offset from the layer is meaningless and unreliable.
For example, a `Transform` widget draws on the same layer
with an offset if the transform matrix is a simple translation,
or push a dedicated `TransformLayer` if the matrix is non-trivial.
The former case keeps the previous coordinate origin
(for example, the top left corner of the app),
while the latter case moves the position origin since
it's on a new layer. The two cases might not produce noticeable
visual differences, since the extra layer might just be a scale of
99%, despite that the annotation search returns different results.
In order to make this local position reliable, we have to choose
one of the results to stick to.

## Description of change

The `localPosition` returned by an `AnnotatedRegionLayer`
is now the local position it received subtracted by `offset`,
where `offset` is the location of the clipping area relative
to the layer.

<!-- skip -->
```dart
class AnnotatedRegionLayer<T> extends ContainerLayer {
  @override
  bool findAnnotations<S>(AnnotationResult<S> result, Offset localPosition, { @required bool onlyFirst }) {
    ...
    if (/* shouldAddAnnotation */) {
      result.add(AnnotationEntry<S>(
        annotation: typedValue,
        // Used to be:
        // localPosition: localPosition,
        localPosition: localPosition - offset,
      ));
    }
    ...
  }
}
```

Conceptually, this has changed how `AnnotatedRegionLayer.offset`
and `size` are defined. They used to mean
"the clipping rectangle that restricts the annotation search",
while they now jointly represent
"the region of the annotation object".

## Migration guide

Code that is actively using this local position is probably
directly interacting with layers, since using render objects or
widgets have already made this result unreliable. In order to
preserve the previous behavior, you can reimplement
`AnnotatedRegionLayer` to return a local position without
subtracting the offset.


## Timeline

Landed in version: 1.15.2<br>
In stable release: 1.17

## References

API documentation:
* [`AnnotatedRegionLayer`][]
* [`AnnotationEntry`][]

Relevant issues:
* [Issue #49568][]

Relevant PRs:
* [Make Annotation's localPosition relative to object][]

[`AnnotatedRegionLayer`]: {{site.api}}/flutter/rendering/AnnotatedRegionLayer-class.html
[`AnnotationEntry`]: {{site.api}}/flutter/rendering/AnnotationEntry-class.html
[Issue #49568]: {{site.github}}/flutter/flutter/issues/49568
[Make Annotation's localPosition relative to object]: {{site.github}}/flutter/flutter/pull/50157
