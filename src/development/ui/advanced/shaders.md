---
title: Writing and using Fragment Shaders
description: How to author and use fragment shaders.
short-title: Fragment Shaders
---

{{site.alert.secondary}}
Note: The HTML backend does not support the FragmentProgram API. The CanvasKit
backend will support this API in a future release.
{{site.alert.end}}

A shader is a program that is executed by the GPU, usually authored in a small,
dart-like language such as GLSL. User authored shaders can be incorporated into
Flutter applications and packages via the FragmentProgram API. These can be
used to provide rich graphical effects beyond those provided by the Flutter SDK.

## Adding Shaders to an Application

Shaders must be declared in the new `shaders` section of your application or
package pubspec.yaml file. This allows the Flutter command line tool to compile
the shader to the appropriate backend format, as well as generate the necessary
runtime metadata. When running in debug mode, changes to a shader program will
trigger a recompilation and update of the shader during hot reload or hot
restart.

```yaml
flutter:
  shaders:
    - shaders/myshader.frag
```

Shaders from packages can be included using the same technique as other assets.

#### Loading shaders at runtime

FragmentPrograms can be loaded at runtime using the [FragmentProgram.fromAsset]
constructor. The key should be the file path specified in the pubspec.yaml
above.

```dart
void loadMyShader() async {
  var program = await FragmentProgram.fromAsset('shaders/myshader.frag');
}
```

The FragmentProgram object can be used to create one or more FragmentShader
instances. A FragmentShader represents a particular combination of a
program and bound uniforms.

```dart
void updateShader(Canvas canvas, Rect rect, FragmentProgram program) {
  var shader = program.createShader();
  shader.setFloat(0, 42.0);
  canvas.drawRect(rect, Paint()..shader = shader);
}
```

## Canvas API

Fragment shaders can be used with most Canvas APIs that accept either solid
colors or gradients via a [Paint] object. And will cover an area determined
by the geometry of the canvas API used. For example, with a call to
[Canvas.drawRect] the shader will be evaluated for all fragments within
the rectangle. For an API like [Canvas.drawPath] with a stroked path, the
shader will be evaluated for all fragments within the stroked line. Some
APIs such as drawImage ignore the value of the shader.

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

## Authoring Shaders

Shaders are authored as GLSL source files. Any version from 460 down to 100
is supported, though some available features are restricted. For the rest
of the examples in this document `460 core` will be used.

* UBOs and SSBOs are unsupported.
* `sampler2D` is the only supported sampler type
* Only the two argument version of `texture` (sampler and uv) is supported.
* No varyings may be declared.
  * Note: A position varying is available for each shader
* All precision hints are ignored when targeting Skia.
* Unsigned integers and booleans are unsupported.

#### Uniforms

A fragment program is configured by defining uniform values in the shader
source and then setting these values per fragment shader instance.

Uniforms are set using [FragmentShader.setFloat] or
[FragmentShader.setImageSampler], depending on the type of uniform. Float values
includes floats and vec2, vec3, and vec4. Sampler values are only `sampler2D`.

The correct index for each uniform is determined by the order of the uniforms
as defined in the fragment program. For data types that are composed of
multiple floats such as a vec4, more than one call to [FragmentShader.setFloat]
is required.

For example, given the following uniforms in a fragment program:

```glsl
uniform float uScale;
uniform sampler2D uTexture;
uniform vec2 uMagnitude;
uniform vec4 uColor;
```

The corresponding Dart code to correctly initialize these uniforms is:

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

  // initialize sampler uniform.
  shader.setImageSampler(0, image);
 }
 ```

Note how the indexes used does not count the `sampler2D` uniform. This uniform
will be set separately with [FragmentShader.setImageSampler], with the
index starting over at 0.

Any float uniforms that are left uninitialized will default to `0`.

#### Current Position

The shader has access to a varying which contains the local coordinates for
the particular fragment that is being evaluated. This can be used to compute
effects that depend on the position. This position can be accessed by
importing the `flutter/runtime_effect.glsl` library and calling the
`FlutterFragCoord` function like below.

```glsl
#include <flutter/runtime_effect.glsl>

void main() {
  vec2 currentPos = FlutterFragCoord().xy;
}
```

The value returned from `FlutterFragCoord` is distinct from `gl_FragCoord`.
`gl_FragCoord` provides the screen space coordinates and should generally be
avoided to ensure shaders are consistent across backends. When targeting a
Skia backend the calls to gl_FragCoord are rewritten to access local
coordinates but this rewriting is not possible with Impeller.

#### Colors

There is no built-in data type for colors. Instead they are commonly
represented as a `vec4` with each component corresponding to one of the RGBA
color channels.

The single output `fragColor` expects that the color value is normalized colors
to be in the range of `0.0` to `1.0` and that it has premultiplied alpha. This
is different than typical Flutter colors which use a `0-255` value encoding and
have unpremultipled alpha.

#### Samplers

A sampler provides access to a dart:ui Image object. This image can be acquired
either from a decoded image or from part of the application using
[Scene.toImageSync] or [Picture.toImageSync].

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

By default, the image uses a clamping address mode. Currently customization of
the addressing mode is not supported and needs to be emulated in the shader.

### Performance Considerations

When targeting the Skia backend loading the shader may be expensive, since it
must be compiled to the appropriate platform specific shader at runtime. If you
intend to use one or more shaders during an animation, prefer to precache the
fragment program objects before starting the animation.

The FragmentShader object can be reused across frames, and this will be more
efficient than creating a new FragmentShader per-frame.

For a more detailed guide on writing performant shaders, see
[shader_optimization.md] from the flutter/engine.

### Other resources

For more information, here are a few resources.

* https://thebookofshaders.com/
* https://www.shadertoy.com/

[shader_optimization.md]: https://github.com/flutter/engine/blob/main/impeller/docs/shader_optimization.md
[`Canvas`]: {{site.api}}/flutter/dart-ui/Canvas-class.html
[`Scene`]: {{site.api}}/flutter/dart-ui/Scene-class.html
[`FragmentProgram`]: {{site.api}}/flutter/dart-ui/FragmentProgram-class.html
[`FragmentShader`]: {{site.api}}/flutter/dart-ui/FragmentShader-class.html
