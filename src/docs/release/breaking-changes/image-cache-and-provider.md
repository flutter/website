---
title: ImageCache and ImageProvider changes
description: ImageCache requires implementers to override containsKey, and ImageProvider has marked resolve as @nonVirtual.
---

## Summary

`ImageCache` now has a method called `containsKey`.
`ImageProvider` subclasses should not override `resolve`,
but instead should implement new methods on `ImageProvider`.
These changes were submitted as a single commit to the framework.

## Description of change

The sections below describe the changes to `containsKey`
and `ImageProvider`.

### containsKey change

Clients of the `ImageCache`, such as a custom `ImageProvider`,
may want to know if the cache is already tracking an image.
Adding the `containsKey` method allows callers to discover
this without calling a method like `putIfAbsent`,
which can trigger an undesired call to `ImageProvider.load`.

The default implementation checks both pending and cached
image buckets.

<!-- skip -->
```dart
  bool containsKey(Object key) {
    return _pendingImages[key] != null || _cache[key] != null;
  }
```

### ImageProvider changes

The `ImageProvider.resolve` method does some complicated
error handling work that should not normally be overridden.
It also previously did work to load the image into the
image cache, by way of `ImageProvider.obtainKey` and
`ImageProvider.load`. Subclasses had no opportunity to
override this behavior without overriding `resolve`,
and the ability to compose `ImageProvider`s is limited
if multiple `ImageProvider`s expect to override `resolve`.

To solve this issue, `resolve` is now marked as non-virtual,
and two new protected methods have been added: `createStream()`
and `resolveStreamForKey()`.
These methods allow subclasses to control most of the behavior
of `resolve`, without having to duplicate all the error handling work.
It also allows subclasses that compose `ImageProvider`s
to be more confident that there is only one public entrypoint
to the various chained providers.

## Migration guide

### ImageCache change

Before migration, the code would not have an override of `containsKey`.

Code after migration:

<!-- skip -->
```dart
class MyImageCache implements ImageCache {
  @override
  bool containsKey(Object key) {
    // Check if your custom cache is tracking this key.
  }

  ...
}
```

### ImageProvider change

Code before the migration:

<!-- skip -->
```dart
class MyImageProvider extends ImageProvider<Object> {
  @override
  ImageStream resolve(ImageConfiguration configuration) {
    // create stream
    // set up error handling
    // interact with ImageCache
    // call obtainKey/load, etc.
  }
  ...
}
```

Code after the migration:

<!-- skip -->
```dart
class MyImageProvider extends ImageProvider<Object> {
  @override
  ImageStream createStream(ImageConfiguration configuration) {
    // Return stream, or use super.createStream(),
    // which returns a new ImageStream.
  }

  @override
  void resolveStreamForKey(
    ImageConfiguration configuration,
    ImageStream stream,
    Object key,
    ImageErrorListener handleError,
  ) {
    // Interact with the cache, use the key, potentially call `load`,
    // and report any errors back through `handleError`.
  }
  ...
}

```

## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

## References

API documentation:

* [`ImageCache`][]
* [`ImageProvider`][]
* [`ScrollAwareImageProvider`][]

Relevant issues:

* [Issue #32143][]
* [Issue #44510][]
* [Issue #48305][]
* [Issue #48775][]

Relevant PRs:

* [Defer image decoding when scrolling fast #49389][]

[Stopped increasing the cache size to accomodate large images]: {{site.github}}/flutter/flutter/pull/47387
[`ImageCache`]: {{site.api}}/flutter/painting/ImageCache-class.html
[`ImageProvider`]: {{site.api}}/flutter/painting/ImageProvider-class.html
[`ScrollAwareImageProvider`]: {{site.api}}/flutter/widgets/ScrollAwareImageProvider-class.html
[Issue #32143]: {{site.github}}/flutter/flutter/issues/32143
[Issue #44510]: {{site.github}}/flutter/flutter/issues/44510
[Issue #48305]: {{site.github}}/flutter/flutter/issues/48305
[Issue #48775]: {{site.github}}/flutter/flutter/issues/48775
[Defer image decoding when scrolling fast #49389]: {{site.github}}/flutter/flutter/pull/49389
