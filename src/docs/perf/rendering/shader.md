---
title: Reduce shader compilation jank on mobile
short-title: Shader jank
description: What is shader jank and how to minimize it.
---

If the animations on your mobile app appear to be janky,
but only on the first run, you can _warm up_ the
shader captured in the Skia Shader Language (SkSL) for a
significant improvement.

![Side-by-side screenshots of janky mobile app next to non-janky app]({% asset perf/render/shader-jank.gif @path %})

## What is shader compilation jank?

If an app has janky animations during the first run,
and later becomes smooth for the same animation,
then it's very likely due to shader compilation jank.

More technically, a shader is a piece of code that runs on
a GPU (graphics processing unit).
When a shader is first used, it needs to be compiled on the device.
The compilation could cost up to a few hundred milliseconds
whereas a smooth frame needs to be drawn within 16 milliseconds
for a 60 fps (frame-per-second) display.
Therefore, a compilation could cause tens of frames to be missed,
and drop the fps from 60 to 6. This is _compilation jank_.
After the compilation is complete, the animation should be smooth.

Definitive evidence for the presence of shader compilation jank
is to see `GrGLProgramBuilder::finalize` in the tracing.
See the following screenshot for an example timeline tracing.

![A tracing screenshot verifying jank]({% asset perf/render/tracing.png @path %}){:width="100%"}

## What do we mean by "first run"?

On Android, "first run" means that the user might see
jank the first time opening the app after a fresh
installation. Subsequent runs should be fine.

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

```sh
flutter run --profile --cache-sksl
```

If the same app has been previously run without `--cache-sksl`, then the
`--purge-persistent-cache` flag may be needed:

```sh
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
   `flutter_01.sksl.json`.
</li>

<li markdown="1"> Build the app with SkSL warm-up using the following,
    as appropriate:

Android:
```sh
flutter build apk --bundle-sksl-path flutter_01.sksl.json
```
or
```sh
flutter build appbundle --bundle-sksl-path flutter_01.sksl.json
```

iOS:
```sh
flutter build ios --bundle-sksl-path flutter_01.sksl.json
```

If it's built for a driver test like `test_driver/app.dart`, make sure to also specify `--target=test_driver/app.dart` (e.g., `flutter build ios --bundle-sksl-path flutter_01.sksl.json --target=test_driver/app.dart`).

</li>

<li markdown="1"> Test the newly built app.
</li>
</ol>

Alternatively, you can write some integration tests to
automate the first three steps using a single command.
For example:

```sh
flutter drive --profile --cache-sksl --write-sksl-on-exit flutter_01.sksl.json -t test_driver/app.dart
```

With such [integration tests][], you can easily and reliably get the
new SkSLs when the app code changes, or when Flutter upgrades.
Such tests can also be used to verify the performance change
before and after the SkSL warm-up. Even better, you can put
those tests into a CI (continuous integration) system so the
SkSLs are generated and tested automatically over the lifetime of an app.

Take the original version of [Flutter Gallery][] as an example.
The CI system is set up to generate SkSLs for every Flutter commit,
and verifies the performance, in the [`transitions_perf_test.dart`][] test.
For more details, see the [`flutter_gallery_sksl_warmup__transition_perf`][]
and [`flutter_gallery_sksl_warmup__transition_perf_e2e_ios32`][] tasks.

The worst frame rasterization time is a nice metric from such integration tests to indicate the severity of shader compilation jank. For instance, the steps above reduce Flutter gallery's shader compilation jank and speeds up its worst frame rasterization time on a Moto G4 from ~90 ms to ~40 ms. On iPhone 4s it's reduced from from ~300 ms to ~80 ms. That leads to the visual difference as illustrated in the beginning of this article.

[Flutter Gallery]: {{site.github}}/flutter/flutter/tree/master/dev/integration_tests/flutter_gallery
[`flutter_gallery_sksl_warmup__transition_perf`]: {{site.github}}/flutter/flutter/blob/master/dev/devicelab/bin/tasks/flutter_gallery_sksl_warmup__transition_perf.dart
[`flutter_gallery_sksl_warmup__transition_perf_e2e_ios32`]: {{site.github}}/flutter/flutter/blob/master/dev/devicelab/bin/tasks/flutter_gallery_sksl_warmup__transition_perf_e2e_ios32.dart
[integration tests]: /docs/cookbook/testing/integration/introduction
[`transitions_perf_test.dart`]: {{site.github}}/flutter/flutter/blob/master/dev/integration_tests/flutter_gallery/test_driver/transitions_perf_test.dart

## Limitations and considerations

1. **Why not just compile or warm up _all_ possible shaders?**<br>
   If there are only a limited number of possible shaders,
   then Flutter could do a warm-up and compile all of them
   before-hand to avoid such jank.
   However, for the best overall performance,
   the Skia GPU backend used by Flutter can dynamically generate
   shaders based on a lot of parameters at runtime
   (for example, draws, device models, and driver versions).
   Due to all possible combinations of those parameters,
   the number of possible shaders is exponential.
   In short, Flutter uses programs (app, Flutter, and Skia code)
   to generate some other programs (shaders). The number of possible
   shader programs that Flutter can generate is simply too large.

2. **Can SkSLs captured from one device help shader compilation jank
   on another device?**<br>
   Theoretically, there's no guarantee that the SkSLs from one device
   would help on another device (but they also won't cause any troubles
   if SkSLs aren't compatible across devices).
   Practically, as shown in the table on this [SkSL-based warmup issue][],
   SkSLs work surprisingly well
   even if 1) SkSLs are captured from iOS and then applied to Android devices,
   or 2) SkSLs are captured from emulators and then applied to real mobile
   devices. As the Flutter team has only a limited number of devices in the lab,
   we currently don't have enough data to provide a big picture of cross-device
   helpfulness. We'd love you to provide us more data points to see how it
   works in the wild. ([`FrameTiming`][] can be used to compute the worst frame
   rasterization time in release mode; the worst frame rasterization time is
   a good indicator on how severe the shader compilation jank is.)

3. **SkSL warm-up doesn't help newer iPhones using Metal.**<br>
   Flutter recently migrated from OpenGL to Metal for all newer iOS devices.
   (Please reference [Metal on iOS FAQ][] on which iOS devices are considered
   new enough to use Metal.) However, Skia currently only implemented the SkSL
   warm-up for OpenGL. So the SkSL warm-up would only speed up older iOS devices
   by default. If you find shader compilation jank to be an issue for your app
   on newer iPhones, please let us know by filing a [GitHub issue][]. In the
   longer term, we have a plan to use test-based shader warm-up to mitigate
   this. If there's an urgent need for fixing shader compilation jank on newer
   iPhones, please leave feedback on [Issue 61045][], and we can help you turn
   on OpenGL for your app.


[`FrameTiming`]: {{site.api}}/flutter/dart-ui/FrameTiming-class.html
[SkSL-based warmup issue]: {{site.github}}/flutter/flutter/issues/53607#issuecomment-608587484
[GitHub issue]: {{site.github}}/flutter/flutter/issues
[Issue 61045]: {{site.github}}/flutter/flutter/issues/61045
[Metal on iOS FAQ]: {{site.github}}/flutter/flutter/wiki/Metal-on-iOS-FAQ

If you have questions on SkSL shader warm-up,
please comment on [Issue 60313][] and [Issue 53607][].
If you have general shader warm-up questions,
please refer to [Issue 32170][].

[Issue 32170]: {{site.github}}/flutter/flutter/issues/32170
[Issue 53607]: {{site.github}}/flutter/flutter/issues/53607
[Issue 60313]: {{site.github}}/flutter/flutter/issues/60313

