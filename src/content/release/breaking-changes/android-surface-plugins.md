---
title: New APIs for Android plugins that render to a Surface
description: >-
  Adds a new API, SurfaceProducer, to the Android embedding API, which
  opaquely handles the creation and management of a `Surface` for plugins.
  For Impeller, use of this API is recommended.
---

## Summary

The Android embedder for Flutter introduces a new API, [`SurfaceProducer`][],
which allows plugins to render to a `Surface` without needing to manage what
the backing implementation is. Plugins using the older
[`createSurfaceTexture`][] API will continue to work with [Impeller][] after the
_next_ stable release, but are recommended to migrate to the new API.

## Background

An Android [`SurfaceTexture`][] is a backing implementation for a [`Surface`][]
that uses an [OpenGLES][] texture as the backing store.

For example, a plugin might display frames from a _camera_ plugin:

![Flowchart](https://camo.githubusercontent.com/cdb52c5d371b4f1d5573b650a0eddb0871e5e8be1012d290e008f41bc71b2580/68747470733a2f2f736f757263652e616e64726f69642e636f6d2f7374617469632f646f63732f636f72652f67726170686963732f696d616765732f636f6e74696e756f75735f636170747572655f61637469766974792e706e67)

In newer versions of the Android API (>= 29), Android introduced a
backend-agnostic [`HardwareBuffer`][], which coincides with the minimum version
that Flutter will attempt to use the [Vulkan][] renderer. The Android embedding
API needed to be updated to support a more generic `Surface` creation API that
doesn't rely on OpenGLES.

## Migration guide

If you are using the older [`createSurfaceTexture`][] API, you should migrate to
the new [`createSurfaceProducer`][] API. The new API is more flexible and allows
the Flutter engine to opaquely pick the best implementation for the current
platform and API level.

1. Instead of creating a `SurfaceTextureEntry`, create a `SurfaceProducer`:

   ```java diff
   - TextureRegistry.SurfaceTextureEntry entry = textureRegistry.createSurfaceTexture();
   + TextureRegistry.SurfaceProducer producer = textureRegistry.createSurfaceProducer();
   ```

1. Instead of creating a `new Surface(...)`, call [`getSurface()`][] on the
   `SurfaceProducer`:

   ```java diff
   - Surface surface = new Surface(entry.surfaceTexture());
   + Surface surface = producer.getSurface();
   ```

In order to conserve memory when the application is suspended in the background,
Android and Flutter _may_ destroy a surface when it is no longer visible. To
ensure that the surface is recreated when the application is resumed, you should
use the provided [`setCallback`][] method to listen to surface lifecycle events:

```java
surfaceProducer.setCallback(
   new TextureRegistry.SurfaceProducer.Callback() {
      @Override
      public void onSurfaceAvailable() {
         // Do surface initialization here, and draw the current frame.
      }

      @Override
      public void onSurfaceDestroyed() {
         // Do surface cleanup here, and stop drawing frames.
      }
   }
);
```

A full example of using this new API can be found in [PR 6989][] for the
`video_player_android` plugin.

:::note
In early versions of this API, the callback was named `onSurfaceCreated`, and
was invoked even if the original surface was not destroyed. This has been fixed
in the latest (pending 3.27) version of the API.
:::

## Note on camera previews

If your plugin implements a camera preview, your migration might also require
fixing the rotation of that preview. This is because `Surface`s produced by the
`SurfaceProducer` might not contain the transformation information that Android
libraries need to correctly rotate the preview automatically.

In order to correct the rotation, you need to rotate the preview with
respect to the camera sensor orientation and the device orientation according
to the equation:

```plaintext
rotation = (sensorOrientationDegrees - deviceOrientationDegrees * sign + 360) % 360
```

where `deviceOrientationDegrees` is counterclockwise degrees and `sign` is 1 for
front-facing cameras and -1 for back-facing cameras.

To calculate this rotation,

- Use [`SurfaceProducer.handlesCropAndRotation`][] to check if the underlying
  `Surface` handles rotation (if `false`, you may need to handle the rotation).
- Retrieve the sensor orientation degrees by retrieving the value of
  [`CameraCharacteristics.SENSOR_ORIENTATION`][].
- Retrieve the device orientation degrees in one of the ways that the
  [Android orientation calculation documentation][] details.

To apply this rotation, you can use a [`RotatedBox`][] widget.

For more information on this calculation, check out the
[Android orientation calculation documentation][]. For a full example of making
this fix, check out [this `camera_android_camerax` PR][].

## Timeline

Landed in version: 3.22

:::note
This feature landed in the _previous_ version of the SDK but was non-functional;
plugins that migrate to this API should set `3.24` as a minimum version constraint.
:::

In stable release: 3.24

In the upcoming stable release, 3.27, `onSurfaceCreated` is deprecated, and
`onSurfaceAvailable` and `handlesCropAndRotation` are added.

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
- [PR 6989][], where we add a full example of using the new API in the `video_player_android` plugin.

[Impeller]: /perf/impeller
[OpenGLES]: https://www.khronos.org/opengles/
[Vulkan]: https://source.android.com/docs/core/graphics/arch-vulkan
[`HardwareBuffer`]: https://developer.android.com/reference/android/hardware/HardwareBuffer
[`Surface`]: https://developer.android.com/reference/android/view/Surface
[`SurfaceProducer`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.SurfaceProducer.html
[`SurfaceProducer.handlesCropAndRotation`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.SurfaceProducer.html#handlesCropAndRotation()
[`SurfaceTexture`]: https://source.android.com/docs/core/graphics/arch-st
[`createSurfaceProducer`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.html#createSurfaceProducer()
[`createSurfaceTexture`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.html#createSurfaceTexture()
[`getSurface()`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.SurfaceProducer.html#getSurface()
[`setCallback`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.SurfaceProducer.html#setCallback(io.flutter.view.TextureRegistry.SurfaceProducer.Callback)
[`CameraCharacteristics.SENSOR_ORIENTATION`]: {{site.android-dev}}/reference/android/hardware/camera2/CameraCharacteristics#SENSOR_ORIENTATION
[`RotatedBox`]: {{site.api}}/flutter/widgets/RotatedBox-class.html
[Android orientation calculation documentation]: {{site.android-dev}}/media/camera/camera2/camera-preview#orientation_calculation
[this `camera_android_camerax` PR]: {{site.repo.packages}}/pull/7044
[Issue 139702]: {{site.repo.flutter}}/issues/139702
[Issue 145930]: {{site.repo.flutter}}/issues/145930
[PR 51061]: {{site.repo.engine}}/pull/51061
[PR 6456]: {{site.repo.packages}}/pull/6456
[PR 6461]: {{site.repo.packages}}/pull/6461
[PR 6989]: {{site.repo.packages}}/pull/6989
