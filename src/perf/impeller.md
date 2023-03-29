---
title: Impeller preview
description: What is Impeller and how to enable it.
---

## Overview

What is Impeller?

Impeller is a new rendering runtime for Flutter and
is the Flutter team's solution to Flutter's
[early-onset jank][] issue.
Impeller precompiles a [smaller, simpler set of shaders][]
at Engine build time so that
they won't be compiled while an app is running.

[early-onset jank]: {{site.github}}/flutter/flutter/projects/188
[smaller, simpler set of shaders]: {{site.github}}/flutter/flutter/issues/77412

For a video introduction to Impeller, check out the following
talk from the Flutter Foward 2023 conference:

<iframe width="560" height="315" src="https://www.youtube.com/embed/gKrYWC_SDxQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
[What is Impeller?](https://www.youtube.com/watch?v=gKrYWC_SDxQ)

Overall, Impeller has the following objectives:

* **Predictable performance**:
  All shader compilation and reflection is performed
  offline at build time. All pipeline state objects
  are built upfront. Caching is explicit and under
  the control of the engine.
* **Instrumentable**: All graphics resources
  (textures, buffers, pipeline state objects, and so on)
  are tagged and labeled. Animations can be captured
  and persisted to disk without affecting per-frame
  rendering performance.
* **Portable**: Not tied to a specific client rendering API.
  Shaders are authored once and converted to
  backend-specific formats as necessary.
* **Uses modern graphics APIs effectively**:
  Makes heavy use of (but doesn’t depend on)
  features available in Modern APIs like Metal and Vulkan.
* **Makes effective use of concurrency**:
  Can distribute single-frame workloads across
  multiple threads if necessary.

## Availability

Where can you currently use Impeller?

### iOS

Impeller is currently available for preview on iOS.
You can enable it by passing `--enable-impeller`
to the `flutter run` tool command or add the
following under the top-level `<dict>` tag in an
application's `Info.plist` file:

```
  <key>FLTEnableImpeller</key>
  <true/>
```

The team continues to make improvements to iOS support,
and if you encounter any slow frames or rendering
fidelity issues with Impeller on iOS,
please file an issue in the [GitHub tracker][]
with a small reproducible test case, and include
`[Impeller]` in the title.

[GitHub tracker]: {{site.github}}/flutter/flutter/issues

### Android

Android support is under active development,
and isn't yet ready for preview. On the master channel,
it might not work at the tip-of-tree. (QUESTION: What is tip of tree?)
However, you can get an indication of the direction
that support is headed by experimenting with it in the
3.7 stable release. To enable Impeller on Android,
either pass `--enable-impeller` to the `flutter run`
command or add the following to your
`AndroidManifest.xml` file under the `<application>` tag:

```
  <meta-data
    android:name="io.flutter.embedding.android.EnableImpeller"
    android:value="true" />
```

## Status

You can track the up-to-date status and future plans
of Impeller by following along on the [GitHub project board][].
However, here is a summary of recent progress.

[GitHub project board]: {{site.github}}/orgs/flutter/projects/21

The team is increasingly confident that Impeller on iOS
will meet the rendering needs of nearly all
existing Flutter apps. As of the 3.7 release,
Impeller on iOS supports all but a few features.
The remaining gaps are as follows:

* Setting `Paint.isAntiAlias` to false is not yet implemented
  ([docs]({{site.api}}/flutter/dart-ui/Paint/isAntiAlias.html)).
  ([#104721]({{site.github}}/flutter/flutter/issues/104721))
  ([#109956]({{site.github}}/flutter/flutter/issues/109956))
* Support for the focal argument to `Gradient.radial`
  isn't yet implemented ([docs]({{site.api}}/flutter/dart-ui/Gradient/Gradient.radial.html)).

Recently fixed issues: (QUESTION: Should I just delete these?)

* Setting `Paint.invertColors` to true isn't yet implemented
  ([docs]({{site.api}}/flutter/dart-ui/Paint/invertColors.html)).
  ([#109739]({{site.github}}/flutter/flutter/issues/109739))
  ([#113110]({{site.github}}/flutter/flutter/issues/113110))
* Support for the `blendMode` argument to `Canvas.drawVertices`
  and `Canvas.drawAtlas` isn't yet implemented
  ([docs]({{site.api}}/flutter/dart-ui/Canvas/drawVertices.html)).
  ([#108047]({{site.github}}/flutter/flutter/issues/108047))
* Support for the `textureCoordinates` argument to the `Vertices`
  constructor isn't yet implemented
  [(docs]({{site.api}}/flutter/dart-ui/Vertices-class.html)).
* Setting `Paint.shader` in text styles isn't yet implemented.
  ([#120003]({{site.github}}/flutter/flutter/issues/120003))

The team expects to close these gaps over the coming months.
You might notice minor visual differences in rendering between
Skia and Impeller.
These minor differences might (or might not) be bugs,
so don’t hesitate to file issues.

On Android, the team continues to make progress on a Vulkan
backend for Impeller. Impeller isn't yet ready for preview on Android,
but stay tuned for more progress in a future release.

## Architecture

For detailed information about Impeller's design
and architecture, check out the [README.md][]
file in the source tree.

[README.md]: {{site.github}}/flutter/engine/blob/main/impeller/README.md

## Documentation, references, and additional reading

* [Frequently asked questions]({{site.github}}/flutter/engine/blob/main/impeller/docs/faq.md)
* [Impeller's coordinate system]({{site.github}}/flutter/engine/blob/main/impeller/docs/coordinate_system.md)
* [How to set up Xcode for GPU frame captures with metal]({{site.github}}/flutter/engine/blob/main/impeller/docs/xcode_frame_capture.md)
* [Learning to read GPU frame captures]({{site.github}}/flutter/engine/blob/main/impeller/docs/read_frame_captures.md)
* [How to enable metal validation for command line apps]({{site.github}}/flutter/engine/blob/main/impeller/docs/metal_validation.md)
* [How Impeller works around the lack of uniform buffers in Open GL ES 2.0]({{site.github}}/flutter/engine/blob/main/impeller/docs/ubo_gles2.md)
* [Guidance for writing efficient shaders]({{site.github}}/flutter/engine/blob/main/impeller/docs/shader_optimization.md)
* [How color blending works in Impeller]({{site.github}}/flutter/engine/blob/main/impeller/docs/blending.md)

