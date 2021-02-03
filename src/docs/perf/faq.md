---
title: Frequently asked questions
description: Frequently asked questions about Flutter performance
---

- Which performance dashboards have metrics that are related to Flutter?
  - https://flutter-dashboard.appspot.com/
  - https://flutter-flutter-perf.skia.org/t/?subset=regressions
  - https://flutter-engine-perf.skia.org/t/?subset=regressions
  - https://flutter-dashboard.appspot.com/benchmarks.html (to be retired)

- How do I add a benchmark to Flutter?
  - https://github.com/flutter/flutter/wiki/How-to-write-a-render-speed-test-for-Flutter
  - https://github.com/flutter/flutter/wiki/How-to-write-a-memory-test-for-Flutter

- What are some tools for capturing and analyzing performance metrics?
  - [Dart DevTools](https://flutter.dev/docs/development/tools/devtools/)
  - [Apple instruments](https://en.wikipedia.org/wiki/Instruments_(software))
  - [Linux perf](https://en.wikipedia.org/wiki/Perf_(Linux))
  - [Chrome tracing (enter `about:tracing` in your Chrome URL field)][tracing]
  - [Android systrace (`adb systrace`)][systrace]
  - [Fuchsia `fx traceutil`][traceutil]
  - [Dart observatory](https://dart-lang.github.io/observatory/)
  - https://ui.perfetto.dev/
  - https://www.speedscope.app/

- My Flutter app looks janky or stutters. How do I fix it?
  - https://flutter.dev/docs/perf/rendering

- What are some costly performance operations that I need to be careful with?
  - `Opacity`, `Clip.antiAliasWithSaveLayer`, or anything that triggers
    saveLayer
  - `ImageFilter`
  - https://flutter.dev/docs/perf/rendering/best-practices

- How do I tell which widgets in my Flutter app are rebuilt in each frame?
  - Make `debugProfileBuildsEnabled` true in [widgets/debug.dart][debug.dart].
  - Alternatively, change the `performRebuild` function in
    [widgets/framework.dart][framework.dart] to ignore
    `debugProfileBuildsEnabled` and always call
    `Timeline.startSync(...)/finish`.
  - If you use IntelliJ, a GUI view of this data is available. Select
    **show widget rebuild information**, and you will see which widgets
    rebuild visually in your IDE.

- How do I query the target frames per second (of the display)?
  - https://github.com/flutter/flutter/wiki/Engine-specific-Service-Protocol-extensions#get-the-display-refresh-rate-_fluttergetdisplayrefreshrate

- How to solve my app’s poor animations caused by an expensive Dart async
  function call that is blocking the UI thread?
  - Spawn another isolate using
    https://api.flutter.dev/flutter/foundation/compute.html

- How do I determine my Flutter app’s package size that will be downloaded by a
  user?
  - https://flutter.dev/docs/perf/app-size

- How do I see the breakdown of the Flutter engine size?
  - Visit
    https://storage.googleapis.com/flutter_infra/flutter/c3976b3c7183f479717bffed3f640fb92afbd3dc/android-arm-release/sizes/index.html,
    and replace the git hash in the URL with a recent commit hash from
    https://github.com/flutter/engine/commits.

- How can I take a screenshot of an app that is running and export it as a SKP
  file?
  - Run `flutter screenshot --type=skia --observotry-uri=...`
  - Known issue of a SKP screenshot:
    - Doesn’t record images in real devices [#21237](https://github.com/flutter/flutter/issues/21237).
  - To analyze and visualize the SKP file, visit https://debugger.skia.org/.

- How do I retrieve the shader persistent cache from a device?
  - On Android, you can do the following:
    ```
    adb shell
    run-as <com.your_app_package_name>
    cp <your_folder> <some_public_folder, e.g., /sdcard> -r
    adb pull <some_public_folder/your_folder>
    ```

- How do I perform a trace in Fuchsia?
  - https://fuchsia.dev/fuchsia-src/development/tracing/usage-guide

[tracing]:
https://www.chromium.org/developers/how-tos/trace-event-profiling-tool

[systrace]: https://developer.android.com/studio/profile/systrace

[traceutil]: https://fuchsia.dev/fuchsia-src/development/tracing/usage-guide

[debug.dart]:
https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/debug.dart

[framework.dart]:
https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/framework.dart