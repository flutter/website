---
title: ImageCache large images
description: Stop increasing the ImageCache maxByteSize to accommodate large images.
---

## Summary

Stop increasing the `ImageCache maxByteSize` value
to accommodate large images.

## Context

Previously, when loading images into the `ImageCache`
that had larger byte sizes than the `ImageCache`'s `maxByteSize`,
Flutter permanently increased the `maxByteSize` value
to accommodate those images.
This logic sometimes led to bloated `maxByteSize` values that
made working in memory-limited systems more difficult.

## Description of change

The following "before" and "after" pseudocode demonstrates
the changes made to the `ImageCache` algorithm:

<!-- skip -->
```dart
// Old Logic Pseudocode
void onLoadImage(Image image) {
  if (image.byteSize > _cache.maxByteSize) {
    _cache.maxByteSize = image.byteSize + 1000;
  }
  _cache.add(image);
  while (_cache.count > _cache.maxCount
      || _cache.byteSize > _cache.maxByteSize) {
    _cache.discardOldestImage();
  }
}
```

```dart
// New Logic Pseudocode
void onLoadImage(Image image) {
  if (image.byteSize < _cache.maxByteSize) {
    _cache.add(image);
    while (_cache.count > _cache.maxCount
        || _cache.byteSize > cache.maxByteSize) {
      cache.discardOldestImage();
    }
  }
}
```

## Migration guide

There might be situations where the `ImageCache`
is thrashing with the new logic where it wasn't previously,
specifically if you load images that are larger than your
`cache.maxByteSize` value.
This can be remedied by one of the following approaches:

1. Increase the `ImageCache.maxByteSize` value
   to accommodate larger images.
1. Adjust your image loading logic to guarantee that
   the images fit nicely into the `ImageCache.maxByteSize`
   value of your choosing.
1. Subclass `ImageCache`, implement your desired logic,
   and create a new binding that serves up your subclass
   of `ImageCache` (see the [`image_cache.dart`] source).

## Timeline

The old algorithm is no longer supported.
As of Dec 2019, this is the updated behavior.
TBD: replace this with a version number.

## References

API documentation:
* [`ImageCache`]

Relevant issue:
* [Issue 45643]

Relevant PR:
* [Stopped increasing the cache size to accomodate large images]

Other:
* [`ImageCache` source]


[Stopped increasing the cache size to accomodate large images]: {{site.github}}/flutter/flutter/pull/47387
[`ImageCache`]: {{site.api}}/flutter/painting/ImageCache-class.html
[`image_cache.dart`]: {{site.github}}/flutter/flutter/blob/72a3d914ee5db0033332711224e728b8a5281d89/packages/flutter/lib/src/painting/image_cache.dart#L34
[`ImageCache` source]: {{site.github}}/flutter/flutter/blob/master/packages/flutter/lib/src/painting/image_cache.dart)
[Issue 45643]: {{site.github}}/flutter/flutter/issues/45643

