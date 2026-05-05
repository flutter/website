## Performance

Platform views in Flutter come with performance trade-offs.

In a typical Flutter app, the Flutter UI is composed on a dedicated raster thread,
while platform code runs on the UI/platform thread.
This separation keeps Flutter rendering fast and fluid.

However, when a platform view is rendered on Android using **Hybrid
Composition**, Flutter merges the raster and UI threads into a single thread to
ensure correct synchronization between the native Android views and the Flutter canvas.
Because of this thread merging, rendering complex Flutter widgets
alongside a platform view can compete with OS messages and plugin interactions,
potentially causing lower application FPS and frame drops.

**Hybrid Composition++ (HCPP)** minimizes this overhead by using native
transaction synchronization on supported devices (Android API 34+ with Vulkan),
allowing superior performance without the heavy costs of original hybrid
composition.

**Virtual display** (used by the texture layer mode), on the other hand,
avoids thread merging but forces every pixel of the native Android view to flow
through additional intermediate graphic buffers, which increases graphic memory
usage and can cause jank during high-frequency updates like fast scrolling.

For complex cases, there are some techniques that
can be used to mitigate these issues.

For example, you could use a placeholder texture
while an animation is happening in Dart.
In other words, if an animation is slow while a
platform view is rendered,
then consider taking a screenshot of the
native view and rendering it as a texture.

For more information, visit:

* [`TextureLayer`][]
* [`TextureRegistry`][]
* [`FlutterTextureRegistry`][]
* [`FlutterImageView`][]

[`FlutterImageView`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterImageView.html
[`FlutterTextureRegistry`]: {{site.api}}/ios-embedder/protocol_flutter_texture_registry-p.html
[`TextureLayer`]: {{site.api}}/flutter/rendering/TextureLayer-class.html
[`TextureRegistry`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.html
