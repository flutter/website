---
title: New APIs for Android plugins that render to a Surface
description: >
  Adds a new API, `SurfaceProducer`, to the Android embedding API, which
  opaquely handles the creation and management of a `Surface` for plugins. For
  Impeller, use of this API is required.
---

## Summary

The Android embedder for Flutter introduces a new API, [`SurfaceProducer`][],
which allows plugins to render to a `Surface` without needing to manage what
the backing implementation is. Plugins using the older
[`createSurfaceTexture`][] API will not work with [Impeller][].

## Background

An Android [`SurfaceTexture`][] is a backing implementation for a [`Surface`][]
that uses an [OpenGLES][] texture as the backing store.

For example, a plugin might display frames from a _camera_ plugin:

![Flowchart](https://camo.githubusercontent.com/cdb52c5d371b4f1d5573b650a0eddb0871e5e8be1012d290e008f41bc71b2580/68747470733a2f2f736f757263652e616e64726f69642e636f6d2f7374617469632f646f63732f636f72652f67726170686963732f696d616765732f636f6e74696e756f75735f636170747572655f61637469766974792e706e67)

In newer versions of the Android API (>= 29), Android introduced a
backend-agnostic [`HardwareBuffer`][], which coincides with the minimum version
that Flutter will attempt to use the [Vulkan][] renderer. In order to support
this, the Android embedding API needed to be updated to support a more generic
`Surface` creation API that doesn't rely on OpenGLES.

## Migration guide

If you are using the older [`createSurfaceTexture`][] API, you should migrate to
the new [`createSurfaceProducer`][] API. The new API is more flexible and allows
the Flutter engine to opaquely pick the best implementation for the current
platform and API level.

1. Instead of creating a `SurfaceTextureEntry`, create a `SurfaceProducer`:

   ```diff
   - TextureRegistry.SurfaceTextureEntry entry = textureRegistry.createSurfaceTexture();
   + TextureRegistry.SurfaceProducer producer = textureRegistry.createSurfaceProducer();
   ```

1. Instead of creating a `new Surface(...)`, call [`getSurface()`][] on the
   `SurfaceProducer`:

   ```diff
   - Surface surface = new Surface(entry.surfaceTexture());
   + Surface surface = producer.getSurface();
   ```

Otherwise, the API is the same as before.

## Timeline

Landed in version: 3.22.0-12.0.pre-56

:::note
This feature landed in the _previous_ version of the SDK but was non-functional;
plugins that migrate to this API should set `3.22` as a minimum version constraint.
:::

In stable release: 3.22.0

## References

API documentation:

- [`SurfaceProducer`][]
- [`createSurfaceProducer`][]
- [`createSurfaceTexture`][]

Relevant issues:

- [Issue 139702][]
- [Issue 145930][]

Relevant PRs:

- [PR 51061][], where we test the new API in the engine tests.
- [PR 6456][], where we migrate the `video_player` plugin to use the new API.
- [PR 6461][], where we migrate the `camera_android` plugin to use the new API.

[Impeller]: /perf/impeller
[OpenGLES]: https://www.khronos.org/opengles/
[Vulkan]: https://source.android.com/docs/core/graphics/arch-vulkan
[`HardwareBuffer`]: https://developer.android.com/reference/android/hardware/HardwareBuffer
[`Surface`]: https://developer.android.com/reference/android/view/Surface
[`SurfaceProducer`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.SurfaceProducer.html
[`SurfaceTexture`]: https://source.android.com/docs/core/graphics/arch-st
[`createSurfaceProducer`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.html#createSurfaceProducer()
[`createSurfaceTexture`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.html#createSurfaceTexture()
[`getSurface()`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.SurfaceProducer.html#getSurface()
[Issue 139702]: {{site.repo.flutter}}/issues/139702
[Issue 145930]: {{site.repo.flutter}}/issues/145930
[PR 51061]: {{site.repo.engine}}/pull/51061
[PR 6456]: {{site.repo.packages}}/pull/6456
[PR 6461]: {{site.repo.packages}}/pull/6461
