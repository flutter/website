---
title: "Getting started with Flutter GPU"
description: >-
  Build custom renderers and render 3D scenes in Flutter.
publishDate: 2024-08-06
author: bdero
image: images/1jfeUgpEP9AgAz94yVxVW1g.webp
category: tutorial
layout: blog
---

The Flutter 3.24 release introduces a new low-level graphics API called [Flutter GPU](https://github.com/flutter/engine/blob/main/docs/impeller/Flutter-GPU.md). There is also a 3D rendering library powered by Flutter GPU called [Flutter Scene](https://pub.dev/packages/flutter_scene) (package: `flutter_scene`). Both Flutter GPU and Flutter Scene are currently in preview, only available on Flutter’s [main channel](https://docs.flutter.dev/release/upgrade#other-channels) (due to reliance on experimental features), require [Impeller to be enabled](https://docs.flutter.dev/perf/impeller#availability), and might occasionally introduce breaking changes.

This article contains two “getting started” guides for these packages:

1. 🔺 **Advanced:** [Getting started with Flutter GPU](/blog/getting-started-with-flutter-gpu#getting-started-with-flutter-gpu)
   If you’re an experienced graphics programmer or you’re interested in low level graphics and want to build renderers from scratch in Flutter, then this guide will get you set up to start tinkering with Flutter GPU. You’ll draw your first triangle from scratch… in Flutter!

1. 💚 **Intermediate:** [3D rendering with Flutter Scene](/blog/getting-started-with-flutter-gpu#3d-rendering-with-flutter-scene)
   If you’re a Flutter developer that wants to add 3D functionality to your apps, or you want to create 3D games using Dart and Flutter, then this is a guide for you! You’ll set up a project that imports and renders 3D assets in Flutter.

## Getting started with Flutter GPU

⚠️ Warning! ⚠️ Flutter GPU is ultimately a low-level API. It’s overwhelmingly likely that the vast majority of Flutter devs who will benefit from Flutter GPU’s existence will do so by consuming higher level rendering libraries published on pub.dev, such as the Flutter Scene rendering package. If you’re not interested in the Flutter GPU API itself and you’re just interested in 3D rendering, skip ahead to [3D rendering with Flutter Scene](/blog/getting-started-with-flutter-gpu#3d-rendering-with-flutter-scene).

<DashImage figure src="images/0hAqIOVkaI1IWnOHE.webp" alt="Ooh shiny. This is a ray-marched signed distance field. You could render this using Flutter GPU, but it’s perfectly possible to do so with a [custom fragment shader](https://docs.flutter.dev/ui/design/graphics/fragment-shaders) as well." caption="Ooh shiny. This is a ray-marched signed distance field. You could render this using Flutter GPU, but it’s perfectly possible to do so with a [custom fragment shader](https://docs.flutter.dev/ui/design/graphics/fragment-shaders) as well." />

Flutter GPU is Flutter’s built-in low-level graphics API. It allows you to build and integrate custom renderers in Flutter by writing Dart code and GLSL shaders. No native platform code required.

Currently, Flutter GPU is in early preview and offers a basic rasterization API, but more functionality will continue to be added and refined, as the API approaches stable.

Flutter GPU also requires [Impeller to be enabled](https://docs.flutter.dev/perf/impeller#availability). This means it can only be used when targeting platforms that are supported by Impeller. At the time of writing, Impeller supports:

* iOS (on by default)

* macOS (opt-in preview)

* Android (opt-in preview)

Our aim with Flutter GPU is to eventually support all of Flutter’s platform targets. The ultimate goal is to foster an ecosystem of cross-platform rendering solutions in Flutter that are easy to maintain for package authors and easy to install for users.

3D rendering is just one possible use case. Flutter GPU can also be used to build specialized 2D renderers, or to do something more unorthodox, like render 3D slices of a 4D space, or project non-euclidean spaces.

One example of a great use case for a custom 2D renderer powered by Flutter GPU would be 2D character animation formats that rely on skeletal mesh deformation. Spine 2D is a good example of this. Such skeletal mesh solutions usually have animation clips that manipulate translation, rotation, and scale properties of bones in a hierarchy, and each vertex has a few associated “bone weights” that determine what bones should influence the vertex and by how much.’

With a Canvas solution like `drawVertices`, bone weight transforms would need to be applied for each vertex on the CPU. With Flutter GPU, the bone transforms could be fed to a vertex shader in the form of a uniform array or even a texture sampler, allowing the final position for each vertex to be calculated in parallel on the GPU based on the state of the skeleton and the per-vertex bone weights.

With that out of the way, let’s get started with Flutter GPU by way of a gentle introduction: Drawing your first triangle!

<DashImage figure src="images/0JEI3fLDGcRHWKruT.webp" />

## Add Flutter GPU to your project

First, note that Flutter GPU is currently in an early preview state and might be prone to API breakages. Quite a lot is already possible with the current API, but experienced graphics engineers might notice some missing common functionality. Much is planned for Flutter GPU over the coming months.

For these reasons, it’s strongly recommended that, for now, you operate against the tip of the [main channel](https://docs.flutter.dev/release/upgrade#other-channels) when developing packages against Flutter GPU. If you happen to run into any unexpected behavior, bugs, or have feature requests, please file issues using the standard [Flutter issue templates](https://github.com/flutter/flutter/issues/new/choose) on GitHub. All tracked issues related to Flutter GPU are given the [flutter-gpu label](https://github.com/flutter/flutter/labels/flutter-gpu).

So before experimenting with Flutter GPU, switch Flutter over to the main channel by running the following commands.

```bash
flutter channel main
flutter upgrade
```

Now create a fresh Flutter project.

```bash
flutter create my_cool_renderer
cd my_cool_renderer
```

Next, add the flutter_gpu SDK package to your pubspec.

```bash
flutter pub add flutter_gpu --sdk=flutter
```

## Build and import shader bundles.

In order to render anything with Flutter GPU, you’ll need to author some GLSL shaders. Flutter GPU’s shaders have different semantics than those consumed by Flutter’s [fragment shader](https://docs.flutter.dev/ui/design/graphics/fragment-shaders) feature, particularly when it comes to uniform bindings. You’ll also define a vertex shader to go alongside the fragment shader.

Start with defining the simplest possible shaders. You can place shaders anywhere in your project, but for this example, create a `shaders` directory and populate it with two shaders: `simple.vert` and `simple.frag` .

```glsl
// Copy into: shaders/simple.vert

in vec2 position;

void main() {
  gl_Position = vec4(position, 0.0, 1.0);
}
```

When drawing the triangle, you’ll have a list of data that defines each vertex. In this case, it merely lists 2D positions. For each of these vertices, a simple vertex shader assigns these 2D positions to the clip space output intrinsic `gl_Position`.

```glsl
// Copy into: shaders/simple.frag

out vec4 frag_color;

void main() {
  frag_color = vec4(0, 1, 0, 1);
}
```

The fragment shader is even simpler; it outputs an RGBA color with a range of `(0, 0, 0, 0)` to `(1, 1, 1, 1)`. So everything will be shaded as green.

Okay, so now that you have your shaders, compile them using Flutter's ahead of time (AOT) shader compiler . To set up automated builds for shader bundles, we recommend using the [flutter_gpu_shaders](https://pub.dev/packages/flutter_gpu_shaders) package.

Use pub to add `flutter_gpu_shaders` as a regular dependency in your project.

```bash
flutter pub add flutter_gpu_shaders
```

Flutter GPU shaders are bundled into `.shaderbundle` files, which can be added to your project's asset bundle as regular assets. Shader bundles contain the compiled shader sources for the platform target(s).

Next, create a shader bundle manifest file that describes the contents of the shader bundle. Add the following to `my_renderer.shaderbundle.json` in the root directory of your project.

```json
{
    "SimpleVertex": {
        "type": "vertex",
        "file": "shaders/simple.vert"
    },
    "SimpleFragment": {
        "type": "fragment",
        "file": "shaders/simple.frag"
    }
}
```

Each entry in the shader bundle can have an arbitrary name. In this case, the names are "SimpleVertex" and "SimpleFragment". These names are used to look up the shaders in your app.

Next, use the `flutter_gpu_shaders` package to build the shaderbundle. You can add a hook that automatically triggers a build by enabling the experimental "native assets" feature. Use the following commands to enable native assets and install the `native_assets_cli` package.

```bash
flutter config --enable-native-assets
flutter pub add native_assets_cli
```

With the native assets feature enabled, add a `build.dart` script under the `hook` directory that will trigger building the shader bundle automatically.

```dart
// Copy into: hook/build.dart

import 'package:native_assets_cli/native_assets_cli.dart';
import 'package:flutter_gpu_shaders/build.dart';

void main(List<String> args) async {
  await build(args, (config, output) async {
    await buildShaderBundleJson(
        buildConfig: config,
        buildOutput: output,
        manifestFileName: 'my_renderer.shaderbundle.json');
  });
}
```

After this change, when the Flutter tool is building the project, `buildShaderBundleJson` builds the shader bundle and outputs the result to `build/shaderbundles/my_renderer.shaderbundle` under the package root.

The shader bundle format itself is tied to the specific version of Flutter you're using and might change over time. If you're authoring a package that builds shader bundles, do **not** check the generated `.shaderbundle` files into your source tree. Instead, use a build hook to automate the build process (as previously explained).

This way, developers that use your library will always build fresh shader bundles with the correct format!

Now that you're automatically building your shader bundle, import it like a regular asset. Add an asset entry to your project's `pubspec.yaml`:

```yaml
flutter:
  assets:
    - build/shaderbundles/
```

In the future, the native assets feature will allow build hooks to append data assets to the bundle. Once this happens, it will no longer be necessary to add an asset import rule alongside the build hook.

Next, add some code to load up the shaders at runtime. Create `lib/shaders.dart` and add the following code.

```dart
// Copy into: lib/shaders.dart

import 'package:flutter_gpu/gpu.dart' as gpu;

const String _kShaderBundlePath =
    'build/shaderbundles/my_renderer.shaderbundle';
// NOTE: If you're building a library, the path must be prefixed
//       with a package name. For example:
//      'packages/my_cool_renderer/build/shaderbundles/my_renderer.shaderbundle'

gpu.ShaderLibrary? _shaderLibrary;
gpu.ShaderLibrary get shaderLibrary {
  if (_shaderLibrary != null) {
    return _shaderLibrary!;
  }
  _shaderLibrary = gpu.ShaderLibrary.fromAsset(_kShaderBundlePath);
  if (_shaderLibrary != null) {
    return _shaderLibrary!;
  }

  throw Exception("Failed to load shader bundle! ($_kShaderBundlePath)");
}
```

This code creates a singleton getter for the Flutter GPU shader runtime library. The first time `shaderLibrary` is accessed, the runtime shader library is initialized using the built asset bundle with `gpu.ShaderLibrary.fromAsset(shader_bundle_path)`.

The project is now set up to use Flutter GPU shaders. It’s time to render that triangle!

## Drawing your first triangle

For this guide, you’ll create an RGBA Flutter GPU `Texture` and a `RenderPass` that attaches the Texture as a color output. Then, you’ll render the `Texture` in a widget using [`Canvas.drawImage`](https://api.flutter.dev/flutter/dart-ui/Canvas/drawImage.html).

For the sake of brevity, you’ll forego best practice and just rebuild all of the resources for each frame.

As long as you mark your `Texture` as "shader readable" when allocating it, you’ll be able to convert it to a `dart:ui.Image`. To display the rendered results in the widget tree, draw it to a `dart:ui.Canvas`!

You can access a `Canvas` by scaffolding the widget tree with a custom painter. Replace the contents of `lib/main.dart` with the following:

```dart
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gpu/gpu.dart' as gpu;

// NOTE: We made this earlier while setting up shader bundle imports!
import 'shaders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GPU Triangle Example',
      home: CustomPaint(
        painter: TrianglePainter(),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Attempt to access `gpu.gpuContext`.
    // If Flutter GPU isn't supported, an exception will be thrown.
    print('Default color format: ' +
        gpu.gpuContext.defaultColorFormat.toString());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```

Now, run the app. As a reminder, Flutter GPU currently requires [Impeller to be enabled](https://docs.flutter.dev/perf/impeller#availability). So you must use an Impeller-supported platform. For this guide, I'll be targeting macOS.

```bash
flutter run -d macos --enable-impeller
```

<DashImage figure src="images/0lKTtaX2ih6dFpSMQ.webp" />

If Flutter GPU is working, then you should see the default color format printed to the console.

```plaintext
flutter: Default color format: PixelFormat.b8g8r8a8UNormInt
```

If Impeller isn't enabled, an exception is thrown when attempting to access `gpu.gpuContext`.

```plaintext
Exception: Flutter GPU requires the Impeller rendering backend to be enabled.

The relevant error-causing widget was:
  CustomPaint
```

For the sake of simplicity, you’ll only modify the `paint` method from here onwards.

To start off, create a Flutter GPU `Texture`, clear it, and then display it by drawing it to the `Canvas`.

Create a `Texture` the size of the `Canvas`. A `StorageMode` must be chosen. In this case, you’ll mark the `Texture` as `devicePrivate`, because you'll only be using instructions that accesses the texture's memory from the device (GPU).

```dart
final texture = gpu.gpuContext.createTexture(gpu.StorageMode.devicePrivate,
    size.width.toInt(), size.height.toInt())!;
```

If overwriting the texture's data by uploading it from the host (CPU), then use `StorageMode.hostVisible` instead.

The third available option is `StorageMode.deviceTransient`, which is useful for attachments that don't need to exceed the lifetime of a single `RenderPass` (so they can just exist in tile memory and don't need to be backed by a VRAM allocation). Oftentimes, depth/stencil textures fit this criteria.

Next, define a `RenderTarget`. Render targets contain a collection of "attachments" that describe a per-fragment memory layout and its setup/teardown behavior at the beginning and end of a `RenderPass`.

Essentially, a `RenderTarget` is a reusable descriptor for a `RenderPass`.

For now, define a very simple `RenderTarget` consisting of only one color attachment.

```dart
final renderTarget = gpu.RenderTarget.singleColor(
gpu.ColorAttachment(texture: texture, clearValue: Colors.lightBlue));
```

Notice that this code sets the `clearValue` to light blue. Each attachment has a `LoadAction` and a `StoreAction` that determines what should happen to the attachment's ephemeral tile memory at the beginning and end of the pass, respectively.

By default, color attachments are set to `LoadAction.clear` (which initializes the tile memory to a given color), and `StoreAction.store` (which saves the results to the attached texture's VRAM allocation).

Now, create a `CommandBuffer`, spawn a `RenderPass` from it using the `RenderTarget` from earlier, and then immediately submit the `CommandBuffer` to clear the texture.

```dart
final commandBuffer = gpu.gpuContext.createCommandBuffer();
final renderPass = commandBuffer.createRenderPass(renderTarget);
// ... draw calls will go here!
commandBuffer.submit();
```

All that's left is to draw the initialized texture to the Canvas!

```dart
final image = texture.asImage();
canvas.drawImage(image, Offset.zero, Paint());
```

<DashImage figure src="images/0ebUDtzQOuIGmdlop.webp" />

Now that you have a `RenderPass` hooked up with results displayed to the screen, you’re ready to start drawing the triangle. To do this, set up the following:

1. A `RenderPipeline` created from our shaders, and

1. A GPU-accessible buffer containing our geometry (three vertex positions).

Creating the `RenderPipeline` is easy. You just need to combine a vertex and fragment shader from your library.

```dart
final vert = shaderLibrary['SimpleVertex']!;
final frag = shaderLibrary['SimpleFragment']!;
final pipeline = gpu.gpuContext.createRenderPipeline(vert, frag);
```

Now for the geometry. Recall that the "SimpleVertex" shader only has one input: `in vec2 position`. So, to draw the three vertices, you need three sets of two floating point numbers.

```dart
final vertices = Float32List.fromList([
  -0.5, -0.5, // First vertex
   0.5, -0.5, // Second vertex
   0.0,  0.5, // Third vertex
]);
final verticesDeviceBuffer = gpu.gpuContext
    .createDeviceBufferWithCopy(ByteData.sublistView(vertices))!;
```

All that's remaining is to bind the new resources and call `renderPass.draw()` to finish recording the draw call.

```dart
renderPass.bindPipeline(pipeline);

final verticesView = gpu.BufferView(
  verticesDeviceBuffer,
  offsetInBytes: 0,
  lengthInBytes: verticesDeviceBuffer.sizeInBytes,
);
renderPass.bindVertexBuffer(verticesView, 3);

renderPass.draw();
```

If you launch your app, you should now see a green triangle!

<DashImage figure src="images/0LWnGU5WPT_Eom0wJ.webp" />

Yay, you built a renderer from scratch with Flutter, Dart, and a little bit of GLSL!

Whether this is your first time rendering a triangle or you're a seasoned graphics veteran, I hope you'll continue playing with Flutter GPU and check out the packages that we're working on, like Flutter Scene.

In the future, we hope to publish beginner-friendly codelabs that dive deeper into Flutter GPU's default behavior and best practices. We still haven't talked about the vertex attribute layout, texture binding, uniforms and alignment requirements, pipeline blending, depth and stencil attachments, perspective correction, and so much more!

Until then, I'd recommend exploring [Flutter Scene](https://github.com/bdero/flutter_scene) as a more comprehensive example of how to use Flutter GPU.

## 3D rendering with Flutter Scene

Flutter Scene (package `flutter_scene`) is a new 3D scene graph package powered by Flutter GPU that enables Flutter developers to import animated glTF models and render realtime 3D scenes.

The intent is to provide a package that makes building interactive 3D apps and games easy in Flutter.

<DashImage figure src="images/0tC68CbPLef2rJp1e.webp" />

This package started life as a `dart:ui` extension for a 3D renderer written in C++ and built directly into Flutter's native runtime, but it's been rewritten against Flutter GPU with a more flexible interface.

As with the Flutter GPU API itself, Flutter Scene is currently in an early preview state and requires [Impeller to be enabled](https://docs.flutter.dev/perf/impeller#availability). Flutter Scene generally keeps up to date with breaking changes to Flutter GPU's API, and so it's strongly recommended to use the [main channel](https://docs.flutter.dev/release/upgrade#other-channels) when experimenting with Flutter Scene.

Next, make an app with Flutter Scene!

## Set up a Flutter Scene project

Since it's strongly recommended to use Flutter Scene against the [main channel](https://docs.flutter.dev/release/upgrade#other-channels), start off by switching to it.

```bash
flutter channel main
flutter upgrade
```

Next, create a fresh Flutter project.

```bash
flutter create my_3d_app
cd my_3d_app
```

Flutter Scene relies on the experimental "native assets" feature for automatically building shaders. You’ll use native assets in a moment to set up automatic importing of 3D models for Flutter Scene.

Enable native assets with the following command.

```bash
flutter config --enable-native-assets
```

And finally, add Flutter Scene as a project dependency.

You’ll also need to use several `vector_math` constructs while interacting with Flutter Scene's API, so add the `vector_math` package as well.

```bash
flutter pub add flutter_scene vector_math
```

Next, import a 3D model!

## Import a 3D model

First, you need a 3D model to render. For this guide, you’ll use a common [glTF](https://en.wikipedia.org/wiki/GlTF) sample asset: [DamagedHelmet.glb](https://github.com/KhronosGroup/glTF-Sample-Assets/tree/main/Models/DamagedHelmet). Here's what it looks like.

<DashImage figure src="images/0vVWRLxJ348tCxv7T.webp" alt="The original Damaged Helmet model was created by theblueturtle_ in 2016 (license: [CC BY-NC 4.0 International](https://creativecommons.org/licenses/by-nc/4.0/legalcode)). The converted glTF version was created by ctxwing in 2018 (license: [CC BY 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode))" caption="The original Damaged Helmet model was created by theblueturtle_ in 2016 (license: [CC BY-NC 4.0 International](https://creativecommons.org/licenses/by-nc/4.0/legalcode)). The converted glTF version was created by ctxwing in 2018 (license: [CC BY 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode))" />

You can grab it from the [glTF sample assets repository](https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Assets/main/Models/DamagedHelmet/glTF-Binary/DamagedHelmet.glb) hosted on GitHub. Place DamagedHelmet.glb in your project root.

```bash
curl -O https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/main/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb
```

Like most real-time 3D renderers, Flutter Scene uses a specialized 3D model format internally. You can convert standard glTF binaries (.glb files) to this format using Flutter Scene's offline importer tool.

Add the `flutter_scene_importer` package to the project as a regular dependency.

```bash
flutter pub add flutter_scene_importer
```

**Note:** The importer will automatically build itself using CMake when invoked. So be sure to [install CMake](https://cmake.org/download/). Otherwise, you will run into “***ProcessException: No such file or directory”*** errors.

Adding this package makes it possible to invoke the importer manually using `dart run`.

```bash
dart --enable-experiment=native-assets \
     run flutter_scene_importer:import \
     --input "path/to/my/source_model.glb" \
     --output "path/to/my/imported_model.model"
```

You can automatically run the importer by using a native assets build hook. To do this, first install `native_assets_cli` as a regular project dependency.

```bash
flutter pub add native_assets_cli
```

You can now write the build hook. Create `hook/build.dart` with the following contents.

```dart
import 'package:native_assets_cli/native_assets_cli.dart';
import 'package:flutter_scene_importer/build_hooks.dart';

void main(List<String> args) {
  build(args, (config, output) async {
    buildModels(buildConfig: config, inputFilePaths: [
      'DamagedHelmet.glb',
    ]);
  });
}
```

Using the `buildModels` utility from `flutter_scene_importer`, supply a list of models to build. The paths are relative to the build root of the project.

When the Flutter tool is building the project, `buildModels` now builds the shader bundle and outputs the result to `build/models/DamagedModel.model` under the package root.

The imported model format itself is tied to the specific version of Flutter Scene you're using and will change over time. When authoring an app or library that uses Flutter Scene, do not check the generated `.model` files into your source tree. Instead, use a build hook to generate them from your source models (as previously explained).

This way, you'll always build fresh .model files with the correct format as you upgrade Flutter Scene over time!

Next, import the model like a regular asset. Add an asset entry to your project's `pubspec.yaml`.

```yaml
flutter:
  assets:
    - build/models/
```

In the future, the native assets feature will allow build hooks to append data assets to the bundle. Once this happens, it will no longer be necessary to add an asset import rule alongside the build hook.

## Rendering a 3D scene

Now for the app's code.

First, create a stateful widget to persist a `Scene` across frames.

You’ll be animating based on time, so add the `SingleTickerProviderStateMixin` to the state along with an `elapsedSeconds` member.

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_scene/camera.dart';
import 'package:flutter_scene/node.dart';
import 'package:flutter_scene/scene.dart';
import 'package:vector_math/vector_math.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  double elapsedSeconds = 0;
  Scene scene = Scene();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My 3D app',
      home: Placeholder(),
    );
  }
}
```

Run the app as a smoke test to ensure there are no errors. And remember to [enable Impeller](https://docs.flutter.dev/perf/impeller#availability)!

```bash
flutter run -d macos --enable-impeller
```

<DashImage figure src="images/074qs6ytcTjyVHwML.webp" />

Before continuing, set up the ticker for the animation. Override `initState` in `MyAppState` to call `createTicker`.

```dart
  @override
  void initState() {
    createTicker((elapsed) {
      setState(() {
        elapsedSeconds = elapsed.inMilliseconds.toDouble() / 1000;
      });
    }).start();

    super.initState();
  }
```

As long as the widget is visible, the ticker callback is invoked for every frame. Calling `setState` triggers this widget to rebuild every frame.

Next, load up the 3D model that you placed in the project earlier and add it to the Scene.

Use `Node.fromAsset` to load the model from the asset bundle. Place the following code in `initState`.

```dart
    Node.fromAsset('build/models/DamagedHelmet.model').then((model) {
      model.name = 'Helmet';
      scene.add(model);
    });
```

`Node.fromAsset` asynchronously deserializes the model from the asset bundle and resolves the returned `Future<Node>` once it's ready to be added to the scene.

The `MyAppState.initState` should now look as follows:

```dart
  @override
  void initState() {
    createTicker((elapsed) {
      setState(() {
        elapsedSeconds = elapsed.inMilliseconds.toDouble() / 1000;
      });
    }).start();

    Node.fromAsset('build/models/DamagedHelmet.model').then((model) {
      model.name = 'Helmet';
      scene.add(model);
    });

    super.initState();
  }
```

However, you’re still not actually rendering the 3D Scene yet! To do this, use `Scene.render`, which takes a UI `Canvas`, a Flutter Scene `Camera`, and a size.

One way to access a Canvas is to create a `CustomPainter`:

```dart
class ScenePainter extends CustomPainter {
  ScenePainter({required this.scene, required this.camera});
  Scene scene;
  Camera camera;

  @override
  void paint(Canvas canvas, Size size) {
    scene.render(camera, canvas, viewport: Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```

Don't forget to set the `shouldRepaint` override to return true so that the custom painter will repaint whenever a rebuild occurs.

Lastly, add the `CustomPainter` to the source tree.

```dart
  @override
  Widget build(BuildContext context) {
    final painter = ScenePainter(
      scene: scene,
      camera: PerspectiveCamera(
        position: Vector3(sin(elapsedSeconds) * 3, 2, cos(elapsedSeconds) * 3),
        target: Vector3(0, 0, 0),
      ),
    );

    return MaterialApp(
      title: 'My 3D app',
      home: CustomPaint(painter: painter),
    );
  }
```

This code instructs the camera to move in a continuous circle, but always facing towards the origin.

Finally, start the app!

```bash
flutter run -d macos --enable-impeller
```

<DashImage figure src="images/0_-OFc0vhBHAhrPrO.webp" />

Here's the full source we put together.

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scene/camera.dart';
import 'package:flutter_scene/node.dart';
import 'package:flutter_scene/scene.dart';
import 'package:vector_math/vector_math.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  double elapsedSeconds = 0;
  Scene scene = Scene();

  @override
  void initState() {
    createTicker((elapsed) {
      setState(() {
        elapsedSeconds = elapsed.inMilliseconds.toDouble() / 1000;
      });
    }).start();

    Node.fromAsset('build/models/DamagedHelmet.model').then((model) {
      model.name = 'Helmet';
      scene.add(model);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final painter = ScenePainter(
      scene: scene,
      camera: PerspectiveCamera(
        position: Vector3(sin(elapsedSeconds) * 3, 2, cos(elapsedSeconds) * 3),
        target: Vector3(0, 0, 0),
      ),
    );

    return MaterialApp(
      title: 'My 3D app',
      home: CustomPaint(painter: painter),
    );
  }
}

class ScenePainter extends CustomPainter {
  ScenePainter({required this.scene, required this.camera});
  Scene scene;
  Camera camera;

  @override
  void paint(Canvas canvas, Size size) {
    scene.render(camera, canvas, viewport: Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```

## Flutter’s great future ahead

If you were able to successfully follow one of these guides and get something up and running: Woohoo, congrats!

Both Flutter GPU and Flutter Scene are very young efforts with limited platform support. But I think someday we'll look back fondly at these humble beginnings.

With the Impeller effort, the Flutter team took full ownership over the rendering stack because we needed to specialize the renderer towards Flutter's use case. And now we're starting a new chapter in Flutter's history. One where YOU collectively take control over the rendering!

Flutter Scene started as a C++ component in Impeller alongside the 2D Canvas renderer with a slim `dart:ui` extension. By the time I was building it, I was already aware that Flutter Engine wouldn't be its final destination.

The sea of architecture decisions for 3D renderers is vast, and no single generic 3D renderer can solve every use case well. "Generic" and "high performance" are generally antithetical goals.

At best, adequacy at everything all but guarantees excellence at nothing.

In the world of rendering performance, the situation is even worse. Specializing for one use case often means degrading the performance of another.

In short, it's just not possible to ship a generic 3D renderer that can solve every use case for everyone. But, by surfacing the low level APIs necessary for you to build your own solutions (Flutter GPU), and building a useful generic 3D renderer on top of it that's easy for the Flutter community to inspect and modify (Flutter Scene), we’re carving out the space for Flutter developers to enjoy low-risk for obsolescence and a high reward.

<DashImage figure src="images/1jfeUgpEP9AgAz94yVxVW1g.webp" />

I can't wait to see what you'll make with these new capabilities. Stay tuned for future releases of Flutter Scene. There's a lot on the way.

In the meantime, I’m heading back to work.

See you soon. :)
