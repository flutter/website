---
title: Deprecated `cacheExtent` and `cacheExtentStyle`
description: >-
  The `cacheExtent` and `cacheExtentStyle` properties are deprecated.
  They are replaced by `scrollCacheExtent` with a `ScrollCacheExtent` object.
---

{% render "docs/breaking-changes.md" %}

## Summary

Two properties, `cacheExtent` and `cacheExtentStyle`, are deprecated in scrolling
related widgets (like `ListView`, `GridView`, `CustomScrollView`, `Viewport`)
and their corresponding RenderObjects (like `RenderViewport`).
A new property, `scrollCacheExtent`, has been introduced that encapsulates
both the value and the caching strategy (pixels or viewport).

## Background

Previously, `cacheExtent` was a `double` and `cacheExtentStyle` determined how
that `double` was interpreted (either as pixels or as a fraction of the
viewport).
It also separated the value from its unit, which could be confusing.

The new `scrollCacheExtent` property uses a `ScrollCacheExtent` object that
explicitly encapsulates both the value and the caching strategy (pixels or
viewport), ensuring type safety and clearer intent.

## Migration guide

### Widget Layer

#### cacheExtent (Pixels)

If you were using `cacheExtent` (which defaults to pixels), use `scrollCacheExtent`
with `ScrollCacheExtent.pixels`.

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

#### cacheExtentStyle (Viewport)

If you were using `cacheExtent` with `CacheExtentStyle.viewport` (commonly used
in `Viewport`), use `scrollCacheExtent` with `ScrollCacheExtent.viewport`.
 
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

### RenderObject Layer

If you were manually setting properties on `RenderViewport` or similar, update to use `scrollCacheExtent`.

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

Landed in version: 3.41.0-0.0.pre
In stable release: TBD

## References

API documentation:

* [`ScrollCacheExtent`][]
* [`ScrollView.scrollCacheExtent`][]
* [`RenderViewportBase.scrollCacheExtent`][]

Relevant PRs:

* [Introduce ScrollCacheExtent][]

[`ScrollCacheExtent`]: {{site.api}}/flutter/rendering/ScrollCacheExtent-class.html
[`ScrollView.scrollCacheExtent`]: {{site.api}}/flutter/widgets/ScrollView/scrollCacheExtent.html
[`RenderViewportBase.scrollCacheExtent`]: {{site.api}}/flutter/rendering/RenderViewportBase/scrollCacheExtent.html

[Introduce ScrollCacheExtent]: {{site.repo.flutter}}/pull/181092
