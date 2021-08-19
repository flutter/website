---
title: Performance metrics
description: Flutter metrics, and which tools and APIs are used to get them
---

* Startup time to the first frame
  * Check the time when
    [WidgetsBinding.instance.firstFrameRasterized][firstFrameRasterized] 
    is true.
  * See the
    [perf dashboard](https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3DtimeToFirstFrameRasterizedMicros).

* Frame buildDuration, rasterDuration, and totalSpan
  * See [`FrameTiming`]({{site.api}}/flutter/dart-ui/FrameTiming-class.html)
    in the API docs.

* Statistics of frame `buildDuration` (`*_frame_build_time_millis`)
  * We recommend monitoring four stats: average, 90th percentile, 99th
    percentile, and worst frame build time.
  * See, for example, [metrics][transition_build] for the 
    `flutter_gallery__transition_perf` test.

* Statistics of frame `rasterDuration` (`*_frame_build_time_millis`)
  * We recommend monitoring four stats: average, 90th percentile, 99th
    percentile, and worst frame build time.
  * See, for example, [metrics][transition_raster] for the 
    `flutter_gallery__transition_perf` test.

* CPU/GPU usage (a good approximation for energy use)
  * The usage is currently only available through trace events. See
    [profiling_summarizer.dart][profiling_summarizer].
  * See [metrics][cpu_gpu] for the `simple_animation_perf_ios` test.

* release_size_bytes to approximately measure the size of a Flutter app
  * See the [basic_material_app_android][], [basic_material_app_ios][],
    [hello_world_android][], [hello_world_ios][], [flutter_gallery_android][],
    and [flutter_gallery_ios][] tests.
  * See [metrics][size_perf] in the dashboard.
  * For info on how to measure the size more accurately,
    see the [app size](/docs/perf/app-size) page.

For a complete list of performance metrics Flutter measures per commit, visit 
the following sites, click **Query**, and filter the **test** and 
**sub_result** fields:

  * https://flutter-flutter-perf.skia.org/e/
  * https://flutter-engine-perf.skia.org/e/

[firstFrameRasterized]: {{site.api}}/flutter/widgets/WidgetsBinding/firstFrameRasterized.html

[transition_build]: https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3D90th_percentile_frame_build_time_millis%26sub_result%3D99th_percentile_frame_build_time_millis%26sub_result%3Daverage_frame_build_time_millis%26sub_result%3Dworst_frame_build_time_millis%26test%3Dflutter_gallery__transition_perf

[transition_raster]: https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3D90th_percentile_frame_rasterizer_time_millis%26sub_result%3D99th_percentile_frame_rasterizer_time_millis%26sub_result%3Daverage_frame_rasterizer_time_millis%26sub_result%3Dworst_frame_rasterizer_time_millis%26test%3Dflutter_gallery__transition_perf

[profiling_summarizer]: {{site.github}}/flutter/flutter/blob/master/packages/flutter_driver/lib/src/driver/profiling_summarizer.dart

[cpu_gpu]: https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3Daverage_cpu_usage%26sub_result%3Daverage_gpu_usage%26test%3Dsimple_animation_perf_ios

[basic_material_app_android]: {{site.github}}/flutter/flutter/blob/master/dev/devicelab/bin/tasks/basic_material_app_android__compile.dart

[basic_material_app_ios]: {{site.github}}/flutter/flutter/blob/master/dev/devicelab/bin/tasks/basic_material_app_ios__compile.dart

[hello_world_android]: {{site.github}}/flutter/flutter/blob/master/dev/devicelab/bin/tasks/hello_world_android__compile.dart

[hello_world_ios]: {{site.github}}/flutter/flutter/blob/master/dev/devicelab/bin/tasks/hello_world_ios__compile.dart

[flutter_gallery_android]: {{site.github}}/flutter/flutter/blob/master/dev/devicelab/bin/tasks/flutter_gallery_android__compile.dart

[flutter_gallery_ios]: {{site.github}}/flutter/flutter/blob/master/dev/devicelab/bin/tasks/flutter_gallery_ios__compile.dart

[size_perf]: https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3Drelease_size_bytes%26test%3Dbasic_material_app_android__compile%26test%3Dbasic_material_app_ios__compile%26test%3Dhello_world_android__compile%26test%3Dhello_world_ios__compile%26test%3Dflutter_gallery_ios__compile%26test%3Dflutter_gallery_android__compile
