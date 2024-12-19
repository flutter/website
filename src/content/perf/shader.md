---
title: Shader compilation jank
short-title: Shader jank
description: What is shader jank and how to minimize it.
---

{% render docs/performance.md %}

This document describes what shader compilation jank is and how to minimize it.

Shader compilation jank is the annoying stutter you sometimes see in
animations, especially the first time you run an app. This happens because the
app has to compile shaders while it's running.

If you are using [Impeller][], Flutter's default mobile renderer, you shouldn't
experience jank because all necessary shaders are precompiled. However, if
you're not using Impeller and your mobile app's animations appear to
stutter, this is likely due to shader compilation jank.

[Impeller]: /perf/impeller

## What causes shader compilation jank?

When the Skia graphics renderer is used instead of [Impeller][] and Skia sees a
new sequence of draw commands for the first time, it sometimes generates and
compiles a custom GPU shader for that sequence of commands. This allows that
sequence and potentially similar sequences to render as fast as possible.

Unfortunately, Skia's shader generation and compilation happens in sequence with
the frame workload. The compilation could cost up to a few hundred milliseconds
whereas a smooth frame needs to be drawn within 16 milliseconds for a 60 fps
(frame-per-second) display. Therefore, a compilation could cause tens of frames
to be missed, and drop the fps from 60 to 6. This is _compilation jank_.
After the compilation is complete, the animation should be smooth.

Definitive evidence for the presence of shader compilation jank
is to set `GrGLProgramBuilder::finalize` in the tracing
with `--trace-skia` enabled.
The following screenshot shows an example timeline tracing.

![A tracing screenshot verifying jank](/assets/images/docs/perf/render/tracing.png){:width="100%"}

## How to reduce compilation jank

If you're not using Flutter's Impeller graphics renderer and you're creating an
iOS app, you can minimize shader compilation jank by bundling precompiled
shaders with your iOS app. To learn more, see the iOS app development
documentation.

If you're not using Flutter's Impeller graphics renderer and you're creating an
Android app, you can minimize shader compilation jank with the `cache-sksl`
command line tool. To learn more, see [How to use SkSL warmup](#how-to-use-sksl-warmup).

## How to use SkSL warmup

To reduce shader compilation jank when a user first opens an Android app, you
can use Flutter's `cache-sksl` command-line tool. This tool precompiles shaders
into SkSL (Skia Shading Language) format, which can then be bundled with your
Android app.

Important considerations:

* On Android, precompiled shaders are device or GPU-specific.
* The precompiled shaders for Android might only work with a subset of devices.
* Precompiled shaders could make jank worse or produce errors on some
  types of Android devices while making jank better on others.
* With `cache-sksl`, you can precompile shaders for one specific class of
  Android device at a time.

Use the following instructions to collect and package the SkSL shaders:

<ol>
<li>

Run the app with `--cache-sksl` turned on to produce shaders in `SkSL` format:

```console
flutter run --profile --cache-sksl
```

If the same app has been previously run
without `--cache-sksl`, then the
`--purge-persistent-cache` flag might be needed:

```console
flutter run --profile --cache-sksl --purge-persistent-cache
```

This flag removes older non-SkSL shader caches that
could interfere with SkSL shader capturing.
It also purges the SkSL shaders so use it *only* on the first
`--cache-sksl` run.
</li>

<li>

Play with the app to trigger as many animations
as needed; particularly those with compilation jank.

</li>

<li> 

Press `M` at the command line of `flutter run` to
 write the captured SkSL shaders into a file named something like
`flutter_01.sksl.json`.
For best results,
capture SkSL shaders on an actual iOS device.
A shader captured on a simulator isn't likely to work correctly
on actual hardware.

</li>

<li> 

Build the app with SkSL warm-up using the following,
as appropriate:

```console
flutter build ios --bundle-sksl-path flutter_01.sksl.json
```

If the app is built for a driver test like `test_driver/app.dart`,
make sure to specify a target. For example:

```console
flutter build ios --bundle-sksl-path flutter_01.sksl.json --target=test_driver/app.dart
```

</li>

<li> Test the newly built app.
</li>
</ol>
