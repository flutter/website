---
title: Writing and using fragment shaders
description: How to author and use fragment shaders to create custom visual effects in your Flutter app.
short-title: Fragment shaders
---

{{site.alert.note}}
  The `CanvasKit` backend supports this feature on the `beta` branch
  and should support this API in the next stable release.
  There are no current plans to support this feature in the HTML backend.
{{site.alert.end}}

Custom shaders can be used to provide rich graphical effects
beyond those provided by the Flutter SDK.
A shader is a program authored in a small, Dart-like language,
known as GLSL,
and executed on the user's GPU.

Custom shaders are added to a Flutter project
by listing them in the `pubspec.yaml` file,
and obtained using the [`FragmentProgram`][] API.

[`FragmentProgram`]: {{site.api}}/flutter/dart-ui/FragmentProgram-class.html

## Adding shaders to an application

Shaders, in the form of GLSL files with the `.frag` extension,
must be declared in the `shaders` section of your project's `pubspec.yaml` file.
The Flutter command-line tool compiles the shader to its appropriate backend format,
and generates its necessary runtime metadata.
The compiled shader is then included in the application just like an asset.

```yaml
flutter:
  shaders:
    - shaders/myshader.frag
```

When running in debug mode,
changes to a shader program trigger recompilation
and update the shader during hot reload or hot restart.

Shaders from packages are added to a project
with `packages/$pkgname` prefixed to the shader program's name
(where `$pkgname` is the name of the package).

### Loading shaders at runtime

To load a shader into a `FragmentProgram` object at runtime,
use the [`FragmentProgram.fromAsset`][] constructor.
The asset's name is the same as the path to the shader given in the `pubspec.yaml` file.

[`FragmentProgram.fromAsset`]: {{site.api}}/flutter/dart-ui/FragmentProgram/fromAsset.html

```dart
void loadMyShader() async {
  var program = await FragmentProgram.fromAsset('shaders/myshader.frag');
}
```

The `FragmentProgram` object can be used to create one or more [`FragmentShader`][] instances.
A `FragmentShader` object represents a fragment program
along with a particular set of _uniforms_ (configuration parameters).
The available uniforms depends on how the shader was defined.

[`FragmentShader`]: {{site.api}}/flutter/dart-ui/FragmentShader-class.html

```dart
void updateShader(Canvas canvas, Rect rect, FragmentProgram program) {
  var shader = program.fragmentShader();
  shader.setFloat(0, 42.0);
  canvas.drawRect(rect, Paint()..shader = shader);
}
```

### Canvas API

Fragment shaders can be used with most Canvas APIs by setting [`Paint.shader`][].
For example, when using [`Canvas.drawRect`][] the shader is evaluated for all
fragments within the rectangle. For an API like [`Canvas.drawPath`][] with a
stroked path, the shader is evaluated for all fragments within the stroked
line. Some APIs, such as [`Canvas.drawImage`][], ignore the value of the shader.

[`Canvas.drawImage`]:  {{site.api}}/flutter/dart-ui/Canvas/drawImage.html
[`Canvas.drawRect`]:    {{site.api}}/flutter/dart-ui/Canvas/drawRect.html
[`Canvas.drawPath`]:    {{site.api}}/flutter/dart-ui/Canvas/drawPath.html
[`Paint.shader`]:          {{site.api}}/flutter/dart-ui/Paint/shader.html

```dart
void paint(Canvas canvas, Size size, FragmentShader shader) {
  // Draws a rectangle with the shader used as a color source.
  canvas.drawRect(
    Rect.fromLTWH(0, 0, size.width, size.height),
    Paint()..shader = shader,
  );

  // Draws a stroked rectangle with the shader only applied to the fragments
  // that lie within the stroke.
  canvas.drawRect(
    Rect.fromLTWH(0, 0, size.width, size.height),
    Paint()
      ..style = PaintingStyle.stroke
      ..shader = shader,
  )
}

```

## Authoring shaders

Fragment shaders are authored as GLSL source files.
By convention, these files have the `.frag` extension.
(Flutter does not support vertex shaders, which would have the `.vert` extension.)

Any GLSL version from 460 down to 100 is supported,
though some available features are restricted.
The rest of the examples in this document use version `460 core`.

Shaders are subject to the following limitations when used with Flutter:

* UBOs and SSBOs aren't supported.
* `sampler2D` is the only supported sampler type.
* Only the two-argument version of `texture` (sampler and uv) is supported.
* No additional varying inputs may be declared.
* All precision hints are ignored when targeting Skia.
* Unsigned integers and booleans aren't supported.

### Uniforms

A fragment program can be configured by defining `uniform` values in the GLSL shader source
and then setting these values in Dart for each fragment shader instance.

Floating point uniforms with the GLSL types
`float`, `vec2`, `vec3`, and `vec4`
are set using the [`FragmentShader.setFloat`][] method.
GLSL sampler values, which use the `sampler2D` type,
are set using the [`FragmentShader.setImageSampler`][] method.

The correct index for each `uniform` value is determined by the order
that the uniform values are defined in the fragment program.
For data types composed of multiple floats, such as a `vec4`,
you must call [`FragmentShader.setFloat`][] once for each value.

[`FragmentShader.setFloat`]: https://master-api.flutter.dev/flutter/dart-ui/FragmentShader/setFloat.html
[`FragmentShader.setImageSampler`]: https://master-api.flutter.dev/flutter/dart-ui/FragmentShader/setImageSampler.html

For example, given the following uniforms declarations in a GLSL fragment program:

```glsl
uniform float uScale;
uniform sampler2D uTexture;
uniform vec2 uMagnitude;
uniform vec4 uColor;
```

The corresponding Dart code to initialize these `uniform` values is as follows:

```dart
void updateShader(FragmentShader shader, Color color, Image image) {
  shader.setFloat(0, 23);  // uScale
  shader.setFloat(1, 114); // uMagnitude x
  shader.setFloat(2, 83);  // uMagnitude y

  // Convert color to premultiplied opacity.
  shader.setFloat(3, color.red / 255 * color.opacity);   // uColor r
  shader.setFloat(4, color.green / 255 * color.opacity); // uColor g
  shader.setFloat(5, color.blue / 255 * color.opacity);  // uColor b
  shader.setFloat(6, color.opacity);                     // uColor a

  // Initialize sampler uniform.
  shader.setImageSampler(0, image);
 }
 ```

Observe that the indices used with [`FragmentShader.setFloat`][]
do not count the `sampler2D` uniform.
This uniform is set separately with [`FragmentShader.setImageSampler`][],
with the index starting over at 0.

Any float uniforms that are left uninitialized will default to `0.0`.

#### Current position

The shader has access to a `varying` value that contains the local coordinates for
the particular fragment being evaluated. Use this feature to compute
effects that depend on the current position, which can be accessed by
importing the `flutter/runtime_effect.glsl` library and calling the
`FlutterFragCoord` function. For example:

```glsl
#include <flutter/runtime_effect.glsl>

void main() {
  vec2 currentPos = FlutterFragCoord().xy;
}
```

The value returned from `FlutterFragCoord` is distinct from `gl_FragCoord`.
`gl_FragCoord` provides the screen space coordinates and should generally be
avoided to ensure that shaders are consistent across backends. When targeting a
Skia backend, the calls to `gl_FragCoord` are rewritten to access local
coordinates but this rewriting isn't possible with Impeller.

#### Colors

There isn't a built-in data type for colors. Instead they are commonly
represented as a `vec4` with each component corresponding to one of the RGBA
color channels.

The single output `fragColor` expects that the color value is normalized to be
in the range of `0.0` to `1.0` and that it has premultiplied alpha. This is
different than typical Flutter colors which use a `0-255` value encoding and
have unpremultipled alpha.

#### Samplers

A sampler provides access to a `dart:ui` `Image` object.
This image can be acquired either from a decoded image
or from part of the application using
[`Scene.toImageSync`][] or [`Picture.toImageSync`][].

[`Picture.toImageSync`]: https://master-api.flutter.dev/flutter/dart-ui/Picture/toImageSync.html
[`Scene.toImageSync`]: https://master-api.flutter.dev/flutter/dart-ui/Scene/toImageSync.html

```glsl
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
  vec2 uv = FlutterFragCoord().xy / uSize;
  fragColor = texture(uTexture, uv);
}
```

By default, the image uses [`TileMode.clamp`][] to determine how values outside
of the range of `[0, 1]` behave. Customization of the tile mode is not
supported and needs to be emulated in the shader.

[`TileMode.clamp`]: https://master-api.flutter.dev/flutter/dart-ui/TileMode.html

### Performance considerations

When targeting the Skia backend, loading the shader might be expensive since it
must be compiled to the appropriate platform-specific shader at runtime. If you
intend to use one or more shaders during an animation, consider precaching the
fragment program objects before starting the animation.

You can reuse a `FragmentShader` object across frames;
this is more efficient than creating a new `FragmentShader` for each frame.

For a more detailed guide on writing performant shaders,
check out [Writing efficient shaders][] on GitHub.

[Shader compilation jank]: {{site.url}}/perf/shader
[Writing efficient shaders]: {{site.github}}/flutter/engine/blob/main/impeller/docs/shader_optimization.md

### Other resources

For more information, here are a few resources.

* [The Book of Shaders][] by Patricio Gonzalez Vivo and Jen Lowe
* [Shader toy][], a collaborative shader playground
* [`simple_shader`], a simple Flutter fragment shaders sample project

[Shader toy]: https://www.shadertoy.com/
[The Book of Shaders]: https://thebookofshaders.com/
[`simple_shader`]: {{site.repo.organization}}/samples/tree/main/simple_shader

