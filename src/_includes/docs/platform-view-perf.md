## Performance

Platform views in Flutter come with performance trade-offs.

For example, in a typical Flutter app, the Flutter UI is composed
on a dedicated raster thread. This allows Flutter apps to be fast,
as the main platform thread is rarely blocked.

While a platform view is rendered with Hybrid composition,
the Flutter UI is composed from the platform thread,
which competes with other tasks like handling OS or plugin messages.

Prior to Android 10, Hybrid composition copied each Flutter frame
out of the graphic memory into main memory, and then copied it back
to a GPU texture. In Android 10 or above, the graphics memory is
copied twice. As this copy happens per frame, the performance of
the entire Flutter UI may be impacted.

Virtual display, on the other hand,
makes each pixel of the native view
flow through additional intermediate graphic buffers,
which cost graphic memory and drawing performance.

For complex cases, there are some techniques that
can be used to mitigate these issues.

For example, you could use a placeholder texture
while an animation is happening in Dart.
In other words, if an animation is slow while a
platform view is rendered,
then consider taking a screenshot of the
native view and rendering it as a texture.

For more information, see:

* [`TextureLayer`][]
* [`TextureRegistry`][]
* [`FlutterTextureRegistry`][]

[`FlutterTextureRegistry`]: {{site.api}}/objcdoc/Protocols/FlutterTextureRegistry.html
[`TextureLayer`]: {{site.api}}/flutter/rendering/TextureLayer-class.html
[`TextureRegistry`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.html
