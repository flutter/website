---
title: Revert ImageCache algorithm for large image
description: Stop increasing the ImageCache maxByteSize to accomodate large
images.
---

# Revert ImageCache algorithm for large image

## Context

When loading images into the ImageCache whose byte size is larger than the
ImageCache's maxByteSize we previously would permanently increase the
maxByteSize to accommodate them.  This logic can lead to creeping maxByteSize
which makes working in memory limited systems more difficult.

## Description of change

The following changes were made to the ImageCache algorithm:

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

There may be situations where the ImageCache is thrashing with the new logic
where it wasn't previously, specifically if you are loading images that are
larger than your cache.maxByteSize.  These can be remedied by one of the
following:

  1) Increase the ImageCache.maxByteSize to accommodate the large images.
  1) Adjust your image loading logic to guarantee that the images will fit
     nicely into the ImageCache.maxByteSize of your choosing.
  1) Subclass ImageCache, implement your desired logic, create a new bindings
     that will serve up your subclass of ImageCache (see also
     [ImageCache docs](https://github.com/flutter/flutter/blob/72a3d914ee5db0033332711224e728b8a5281d89/packages/flutter/lib/src/painting/image_cache.dart#L34)).

## Timeline

The old algorithm will not be supported explicitly in the future.  Once this PR
is landed in Dec 2019 this will be the behavior going forward.

## References

- [The PR](https://github.com/flutter/flutter/pull/47387)
- [The Issue](https://github.com/flutter/flutter/issues/45643)
- [The ImageCache source](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/painting/image_cache.dart)
