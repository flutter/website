---
title: Default cache extent changed
description: >-
  The default `cacheExtent` for scrolling widgets changed from 250 pixels to 0.8 times the viewport size.
---

{% render "docs/breaking-changes.md" %}

## Summary

The default cache extent for scrolling widgets (`ListView`, `GridView`, `CustomScrollView`, and `Scrollable`) changed from a fixed value of `250.0` pixels to `0.8` times the viewport's dimension along the main axis.

## Context

Previously, the default cache extent was `250.0` pixels. A fixed pixel cache extent is too small on large monitors and unnecessarily large on very small screens. Furthermore, the fixed 250-pixel cache extent can be too small to accommodate accessibility scrolling, which is based on the viewport size. This sometimes causes iOS VoiceOver to lose its current focus because the currently focused item scrolls outside of the cache extent.

The new default cache extent is `0.8` times the viewport extent. The cache region extends 80% of the viewport's main axis dimension both before and after the visible area. This preloads an appropriate amount of content for any screen size.

## Description of change

Any scrolling widget that relies on the default cache extent will now have a cache extent relative to its viewport size instead of a fixed `250.0` pixels.

For example, on a device with a scroll view height of 1000 pixels:

*   Old behavior: The cache area is 250 pixels above and below the visible area.
*   New behavior: The cache area is `1000 * 0.8 = 800` pixels above and below the visible area.

This change does not affect widgets where the cache extent is explicitly provided (such as `ListView(cacheExtent: 500)` or `ListView(scrollCacheExtent: ScrollCacheExtent.pixels(500))`).

## Migration guide

Most applications do not require modifications. If your application relies on the 250-pixel default, you can restore the previous behavior by explicitly setting the cache extent property.

### Restoring the previous behavior

**Before:**

```dart
ListView(
  children: // ...
)
```

**After:**

```dart
ListView(
  scrollCacheExtent: const ScrollCacheExtent.pixels(250.0),
  children: // ...
)
```

### Affected classes

*   [`ScrollView`][]
*   [`ListView`][]
*   [`GridView`][]
*   [`CustomScrollView`][]
*   [`Scrollable`][]
*   [`RenderViewport`][]
*   [`RenderViewportBase`][]

## Timeline

Landed in version: TBD<br>
In stable release: TBD

## References

API documentation:

* [`ScrollCacheExtent`][]
* [`ScrollView.scrollCacheExtent`][]
* [`RenderViewportBase.scrollCacheExtent`][]

Relevant issue:

* [Issue 98572: Consider changing default cacheExtent to be based on viewport dimension][]

Relevant PR:

* [Change default cache extent][]

[`ScrollView`]: {{site.api}}/flutter/widgets/ScrollView-class.html
[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html
[`GridView`]: {{site.api}}/flutter/widgets/GridView-class.html
[`CustomScrollView`]: {{site.api}}/flutter/widgets/CustomScrollView-class.html
[`Scrollable`]: {{site.api}}/flutter/widgets/Scrollable-class.html
[`RenderViewport`]: {{site.api}}/flutter/rendering/RenderViewport-class.html
[`RenderViewportBase`]: {{site.api}}/flutter/rendering/RenderViewportBase-class.html
[`ScrollCacheExtent`]: {{site.api}}/flutter/rendering/ScrollCacheExtent-class.html
[`ScrollView.scrollCacheExtent`]: {{site.api}}/flutter/widgets/ScrollView/scrollCacheExtent.html
[`RenderViewportBase.scrollCacheExtent`]: {{site.api}}/flutter/rendering/RenderViewportBase/scrollCacheExtent.html

[Issue 98572: Consider changing default cacheExtent to be based on viewport dimension]: {{site.github}}/flutter/flutter/issues/98572
[Change default cache extent]: {{site.repo.flutter}}/pull/182905
