---
title: Performance FAQ
description: Frequently asked questions about Flutter performance
---

This page collects some frequently asked questions
about evaluating and debugging Flutter's performance.

* Which performance dashboards have metrics that are related to Flutter?
  * [Flutter dashboard on appspot][]
  * [Flutter Skia dashboard][]
  * [Flutter Engine Skia dashboard][]

[Flutter dashboard on appspot]: https://flutter-dashboard.appspot.com/
[Flutter engine Skia dashboard]: https://flutter-engine-perf.skia.org/t/?subset=regressions
[Flutter Skia dashboard]: https://flutter-flutter-perf.skia.org/t/?subset=regressions

* How do I add a benchmark to Flutter?
  * [How to write a render speed test for Flutter][speed-test]
  * [How to write a memory test for Flutter][memory-test]

[memory-test]: {{site.github}}/flutter/flutter/wiki/How-to-write-a-memory-test-for-Flutter
[speed-test]: {{site.github}}/flutter/flutter/wiki/How-to-write-a-render-speed-test-for-Flutter

* What are some tools for capturing and analyzing performance
  metrics?
  * [Dart DevTools](/docs/development/tools/devtools)
  * [Apple instruments](https://en.wikipedia.org/wiki/Instruments_(software))
  * [Linux perf](https://en.wikipedia.org/wiki/Perf_(Linux))
  * [Chrome tracing (enter `about:tracing` in your
    Chrome URL field)][tracing]
  * [Android systrace (`adb systrace`)][systrace]
  * [Fuchsia `fx traceutil`][traceutil]
  * [Perfetto](https://ui.perfetto.dev/)
  * [speedscope](https://www.speedscope.app/)

[systrace]: https://developer.android.com/studio/profile/systrace
[tracing]: https://www.chromium.org/developers/how-tos/trace-event-profiling-tool
[traceutil]: https://fuchsia.dev/fuchsia-src/development/tracing/usage-guide

* My Flutter app looks janky or stutters. How do I fix it?
  * [Improving rendering performance][]

[Improving rendering performance]: /docs/perf/rendering

* What are some costly performance operations that I need
  to be careful with?
  * [`Opacity`][], [`Clip.antiAliasWithSaveLayer`][],
     or anything that triggers [`saveLayer`][]
  * [`ImageFilter`][]
  * Also see [Performance best practices][]

[`Clip.antiAliasWithSaveLayer`]: {{site.api}}/flutter/dart-ui/Clip-class.html
[`ImageFilter`]: {{site.api}}/flutter/dart-ui/ImageFilter-class.html
[Performance best practices]: /flutter/dart-ui/ImageFilter-class.html
[`Opacity`]: {{site.api}}/flutter/widgets/Opacity-class.html
[Performance best practices]: /docs/perf/rendering/best-practices
[`savelayer`]: {{site.api}}/flutter/dart-ui/Canvas/saveLayer.html

* How do I tell which widgets in my Flutter app are rebuilt
  in each frame?
  * Set [`debugProfileBuildsEnabled`][] true in
    [widgets/debug.dart][debug.dart].
  * Alternatively, change the `performRebuild` function in
    [widgets/framework.dart][framework.dart] to ignore
    `debugProfileBuildsEnabled` and always call
    `Timeline.startSync(...)/finish`.
  * If you use IntelliJ, a GUI view of this data is available.
    Select **show widget rebuild information**,
    and you'll visually see which widgets rebuild
    visually in your IDE.

[`debugProfileBuildsEnabled`]: {{site.api}}/flutter/widgets/debugProfileBuildsEnabled.html
[debug.dart]: {{site.github}}/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/debug.dart
[framework.dart]: {{site.github}}/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/framework.dart

* How do I query the target frames per second (of the display)?
  * [Get the display refresh rate][]

[Get the display refresh rate]: {{site.github}}/flutter/flutter/wiki/Engine-specific-Service-Protocol-extensions#get-the-display-refresh-rate-_fluttergetdisplayrefreshrate

* How to solve my app’s poor animations caused by an expensive
  Dart async function call that is blocking the UI thread?
  * Spawn another isolate using the
    [`compute` property][]

[`compute` property]: {{site.api}}/flutter/foundation/compute.html

* How do I determine my Flutter app’s package size that a
  user will download?
  * See [Measuring your app's size][]

[Measuring your app's size]: /docs/perf/app-size

* How do I see the breakdown of the Flutter engine size?
  * Visit the [binary size dashboard][], and replace the git
    hash in the URL with a recent commit hash from
    [GitHub commits][].

[binary size dashboard]: https://storage.googleapis.com/flutter_infra/flutter/c3976b3c7183f479717bffed3f640fb92afbd3dc/android-arm-release/sizes/index.html
[GitHub commits]: {{site.github}}/flutter/engine/commits

* How can I take a screenshot of an app that is running and export it
  as a SKP file?
  * Run `flutter screenshot --type=skia --observatory-uri=...`
  * Note a known issue viewing screenshots:
    * [Issue 21237][]: Doesn’t record images in real devices.
  * To analyze and visualize the SKP file,
    check out the [Skia WASM debugger][].

[Issue 21237]: {{site.github}}/flutter/flutter/issues/21237
[Skia WASM debugger]: https://debugger.skia.org/

* How do I retrieve the shader persistent cache from a device?
  * On Android, you can do the following:
    ```terminal
    adb shell
    run-as <com.your_app_package_name>
    cp <your_folder> <some_public_folder, e.g., /sdcard> -r
    adb pull <some_public_folder/your_folder>
    ```

* How do I perform a trace in Fuchsia?
  * See [Fuchsia tracing guidelines][traceutil]

