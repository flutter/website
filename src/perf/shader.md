---
title: Shader compilation jank
short-title: Shader jank
description: What is shader jank and how to minimize it.
---

{% include docs/performance.md %}

If the animations on your mobile app appear to be janky, but only on the first
run, this is likely due to shader compilation. Flutter's long term solution to
shader compilation jank is [Impeller][], which is in developer preview on the
master channel for iOS. Before continuing with the instructions below, please
try Impeller on iOS, and let us know in a GitHub issue if it doesn't address
your issue. Impeller on Android is being actively developed, but is not yet in
developer preview.

While we work on making Impeller production ready, you can mitigate shader
compilation jank by bundling precompiled shaders with an iOS app.
Unfortunately, this approach doesn't work well on Android due to precompiled
shaders being device or GPU-specific. The Android hardware ecosystem is large
enough that the GPU-specific precompiled shaders bundled with an application
will work on only a small subset of devices, and will likely make jank worse on
the other devices, or even create rendering errors.

Also, please note that we aren't planning to make improvements to the developer
experience for creating precompiled shaders described below. Instead, we are
focusing our energies on the more robust solution to this problem that Impeller
offers.

## What is shader compilation jank?

A shader is a piece of code that runs on a GPU (graphics processing unit). When
the Skia graphics backend that Flutter uses for rendering sees a new sequence
of draw commands for the first time, it sometimes generates and compiles a
custom GPU shader for that sequence of commands. This allows that sequence and
potentially similar sequences to render as fast as possible.

Unfortunately, Skia's shader generation and compilation happen in sequence with
the frame workload. The compilation could cost up to a few hundred milliseconds
whereas a smooth frame needs to be drawn within 16 milliseconds for a 60 fps
(frame-per-second) display. Therefore, a compilation could cause tens of frames
to be missed, and drop the fps from 60 to 6. This is _compilation jank_. After
the compilation is complete, the animation should be smooth.

On the other hand, Impeller generates and compiles all necessary shaders when
we build the Flutter Engine. Therefore apps running on Impeller already have
all the shaders they need, and the shaders can be used without introducing jank
into animations.

Definitive evidence for the presence of shader compilation jank is to see
`GrGLProgramBuilder::finalize` in the tracing with `--trace-skia` enabled. See
the following screenshot for an example timeline tracing.

![A tracing screenshot verifying jank]({{site.url}}/assets/images/docs/perf/render/tracing.png){:width="100%"}

## What do we mean by "first run"?

On iOS, "first run" means that the user might see
jank when an animation first occurs every time
the user opens the app from scratch.

## How to use SkSL warmup

As of release 1.20, Flutter provides command line tools for app developers to
collect shaders that might be needed for end-users in the SkSL
(Skia Shader Language) format. The SkSL shaders can then be
packaged into the app, and get warmed up (pre-compiled)
when an end-user first opens the app, thereby reducing the compilation
jank in later animations. Use the following instructions to collect
and package the SkSL shaders:

<ol markdown="1">
<li markdown="1">Run the app with `--cache-sksl` turned on
    to capture shaders in SkSL:

```terminal
flutter run --profile --cache-sksl
```

If the same app has been previously run without `--cache-sksl`, then the
`--purge-persistent-cache` flag may be needed:

```terminal
flutter run --profile --cache-sksl --purge-persistent-cache
```

This flag removes older non-SkSL shader caches that could interfere with SkSL
shader capturing. It also purges the SkSL shaders so use it *only* on the first
`--cache-sksl` run.
</li>

<li markdown="1"> Play with the app to trigger as many animations
    as needed; particularly those with compilation jank.
</li>

<li markdown="1"> Press `M` at the command line of `flutter run` to
    write the captured SkSL shaders into a file named something like
   `flutter_01.sksl.json`. For best results, capture SkSL shaders on an actual
   iOS device. A shader captured on a simulator isn't likely to work correctly
   on actual hardware.
</li>

<li markdown="1"> Build the app with SkSL warm-up using the following,
    as appropriate:

```terminal
flutter build ios --bundle-sksl-path flutter_01.sksl.json
```

If it's built for a driver test like `test_driver/app.dart`, make sure to also
specify `--target=test_driver/app.dart` (for example, `flutter build
ios --bundle-sksl-path flutter_01.sksl.json --target=test_driver/app.dart`).

</li>

<li markdown="1"> Test the newly built app.
</li>
</ol>

Alternatively, you can write some integration tests to
automate the first three steps using a single command.
For example:

```terminal
flutter drive --profile --cache-sksl --write-sksl-on-exit flutter_01.sksl.json -t test_driver/app.dart
```

With such [integration tests][], you can easily and reliably get the
new SkSLs when the app code changes, or when Flutter upgrades.
Such tests can also be used to verify the performance change
before and after the SkSL warm-up. Even better, you can put
those tests into a CI (continuous integration) system so the
SkSLs are generated and tested automatically over the lifetime of an app.

{{site.alert.note}}
  The integration_test package is now the recommended way to write integration
  tests. See the [Integration testing]({{site.url}}/testing/integration-tests/) page
  for details.
{{site.alert.end}}

Take the original version of [Flutter Gallery][] as an example.
The CI system is set up to generate SkSLs for every Flutter commit,
and verifies the performance, in the [`transitions_perf_test.dart`][] test.
For more details, see the [`flutter_gallery_sksl_warmup__transition_perf`][]
and [`flutter_gallery_sksl_warmup__transition_perf_e2e_ios32`][] tasks.

The worst frame rasterization time is a nice metric from
such integration tests to indicate the severity of shader
compilation jank. For instance,
the steps above reduce Flutter gallery's shader compilation
jank and speeds up its worst frame rasterization time on a
Moto G4 from ~90 ms to ~40 ms. On iPhone 4s,
it's reduced from ~300 ms to ~80 ms. That leads to the visual
difference as illustrated in the beginning of this article.

[Flutter Gallery]: {{site.repo.flutter}}/tree/main/dev/integration_tests/flutter_gallery
[`flutter_gallery_sksl_warmup__transition_perf`]: {{site.repo.flutter}}/blob/master/dev/devicelab/bin/tasks/flutter_gallery_sksl_warmup__transition_perf.dart
[`flutter_gallery_sksl_warmup__transition_perf_e2e_ios32`]: {{site.repo.flutter}}/blob/master/dev/devicelab/bin/tasks/flutter_gallery_sksl_warmup__transition_perf_e2e_ios32.dart
[integration tests]: {{site.url}}/cookbook/testing/integration/introduction
[`transitions_perf_test.dart`]: {{site.repo.flutter}}/blob/master/dev/integration_tests/flutter_gallery/test_driver/transitions_perf_test.dart
[Impeller]: {{site.repo.flutter}}/wiki/Impeller
