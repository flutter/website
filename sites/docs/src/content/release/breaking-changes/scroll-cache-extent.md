---
title: Deprecated `cacheExtent` and `cacheExtentStyle`
description: >-
  The `cacheExtent` and `cacheExtentStyle` properties are deprecated.
  They are replaced by `scrollCacheExtent` with a `ScrollCacheExtent` object.
---

{% render "docs/breaking-changes.md" %}

## Summary

Flutter 3.44 deprecates `cacheExtent` and `cacheExtentStyle`
in scrolling-related widgets, such as
`ListView`, `GridView`, `CustomScrollView`, and `Viewport`,
and their corresponding render objects, such as `RenderViewport`.
The new `scrollCacheExtent` property encapsulates
both the value and the caching strategy (pixels or viewport).

## Background

Previously, `cacheExtent` was a `double` and
`cacheExtentStyle` determined how that `double` was interpreted
(either as pixels or as a fraction of the viewport).
This split made the setting harder to understand.

The new `scrollCacheExtent` property uses a `ScrollCacheExtent` object that
explicitly encapsulates both the value and
the caching strategy (pixels or viewport),
which provides type safety and clearer intent.

## Migration guide

### Widget layer

#### `cacheExtent` (pixels)

If your code uses `cacheExtent`,
which defaults to pixels,
use `scrollCacheExtent` with `ScrollCacheExtent.pixels`.

**Before:**

```dart
ListView(
  cacheExtent: 500.0,
  children: // ...
)
```

**After:**

```dart
ListView(
  scrollCacheExtent: const ScrollCacheExtent.pixels(500.0),
  children: // ...
)
```

#### `cacheExtentStyle` (viewport)

If your code uses `cacheExtent` with `CacheExtentStyle.viewport`,
which is common in `Viewport`,
use `scrollCacheExtent` with `ScrollCacheExtent.viewport`.

**Before:**

```dart
Viewport(
  cacheExtent: 0.5,
  cacheExtentStyle: CacheExtentStyle.viewport,
  slivers: // ...
)
```

**After:**

```dart
Viewport(
  scrollCacheExtent: const ScrollCacheExtent.viewport(0.5),
  slivers: // ...
)
```

### Render object layer

If your code manually sets properties on
`RenderViewport` or a similar render object,
use `scrollCacheExtent`.

**Before:**

```dart
renderViewport.cacheExtent = 500.0;
renderViewport.cacheExtentStyle = CacheExtentStyle.pixel;
```

**After:**

```dart
renderViewport.scrollCacheExtent = const ScrollCacheExtent.pixels(500.0);
```

## Timeline

Landed in version: 3.41.0-0.0.pre<br>
In stable release: 3.44

## References

API documentation:

* [`ScrollCacheExtent`][]
* [`ScrollView.scrollCacheExtent`][]
* [`RenderViewportBase.scrollCacheExtent`][]

Relevant PRs:

* [Introduce ScrollCacheExtent][pr-181092]

[`ScrollCacheExtent`]: {{site.api}}/flutter/rendering/ScrollCacheExtent-class.html
[`ScrollView.scrollCacheExtent`]: {{site.api}}/flutter/widgets/ScrollView/scrollCacheExtent.html
[`RenderViewportBase.scrollCacheExtent`]: {{site.api}}/flutter/rendering/RenderViewportBase/scrollCacheExtent.html

[pr-181092]: {{site.repo.flutter}}/pull/181092
