---
title: Impeller rendering engine
description: What is Impeller and how to enable it?
---

## What is Impeller?

Impeller provides a new rendering runtime for Flutter.
The Flutter team's believes this solves Flutter's
[early-onset jank][] issue.
Impeller precompiles a [smaller, simpler set of shaders][]
at Engine build time so they don't compile at runtime.

[early-onset jank]: {{site.github}}/flutter/flutter/projects/188
[smaller, simpler set of shaders]: {{site.github}}/flutter/flutter/issues/77412

For a video introduction to Impeller, check out the following
talk from Google I/O 2023.

<iframe width="560" height="315" src="https://www.youtube.com/embed/vd5NqS01rlA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
[Introducing Impeller - Flutter's new rendering engine](https://www.youtube.com/watch?v=vd5NqS01rlA)

Impeller has the following objectives:

* **Predictable performance**:
  Impeller compiles all shaders and reflection offline at build time.
  It builds all pipeline state objects upfront.
  The engine controls caching and caches explicitly.
* **Instrumentable**:
  Impeller tags and labels all graphics resources like textures,
  and buffers.
  It can capture and persist animations to disk without affecting
  per-frame rendering performance.
* **Portable**:
  Flutter doesn't tie Impeller to a specific client rendering API.
  You can author shaders once and convert them to backend-specific
  formats as necessary.
* **Leverages modern graphics APIs**:
  Impeller uses, but doesn’t depend on, features available in
  modern APIs like Metal and Vulkan.
* **Leverages concurrency**:
  Impeller can distribute single-frame workloads across multiple
  threads if necessary.

## Availability

Where can you use Impeller?

### iOS

Flutter enables Impeller by default on iOS.

* To _disable_ Impeller on iOS when debugging,
  pass `--no-enable-impeller` to the `flutter run` command.

  ```terminal
  $ flutter run --no-enable-impeller
  ```

* To _disable_ Impeller on iOS when deploying your app,
  add the following tags under the top-level `<dict>` tag in your
  app's `Info.plist` file.

  ```xml
    <key>FLTEnableImpeller</key>
    <false />
  ```

The team continues to improve iOS support.
If you encounter performance or fidelity issues
with Impeller on iOS, file an issue in the [GitHub tracker][file-issue].
Prefix the issue title with `[Impeller]` and
include a small reproducible test case.

[file-issue]: {{site.github}}/flutter/flutter/issues/new/choose

### Android

Android development continues but it's not ready for preview.
Impeller on Android might not work on the `master` channel.
To see what direction Android support will take,
experiment with Impeller in the 3.7 or later stable release.

To enable Impeller on Android, take one of the following actions:

* Pass `--enable-impeller` to the `flutter run` command.

  ```terminal
  $ flutter run --enable-impeller
  ```

* Add the following tag to your `AndroidManifest.xml` file
  under the `<application>` tag.

  ```xml
    <meta-data
      android:name="io.flutter.embedding.android.EnableImpeller"
      android:value="true" />
  ```

## Architecture

To learn more details about Impeller's design and architecture,
check out the [README.md][] file in the source tree.

[README.md]: {{site.github}}/flutter/engine/blob/main/impeller/README.md

## Additional Information

* [Frequently asked questions]({{site.github}}/flutter/engine/blob/main/impeller/docs/faq.md)
* [Impeller's coordinate system]({{site.github}}/flutter/engine/blob/main/impeller/docs/coordinate_system.md)
* [How to set up Xcode for GPU frame captures with metal]({{site.github}}/flutter/engine/blob/main/impeller/docs/xcode_frame_capture.md)
* [Learning to read GPU frame captures]({{site.github}}/flutter/engine/blob/main/impeller/docs/read_frame_captures.md)
* [How to enable metal validation for command line apps]({{site.github}}/flutter/engine/blob/main/impeller/docs/metal_validation.md)
* [How Impeller works around the lack of uniform buffers in Open GL ES 2.0]({{site.github}}/flutter/engine/blob/main/impeller/docs/ubo_gles2.md)
* [Guidance for writing efficient shaders]({{site.github}}/flutter/engine/blob/main/impeller/docs/shader_optimization.md)
* [How color blending works in Impeller]({{site.github}}/flutter/engine/blob/main/impeller/docs/blending.md)

