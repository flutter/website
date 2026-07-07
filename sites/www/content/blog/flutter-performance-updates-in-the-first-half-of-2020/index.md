---
title: "Flutter Performance Updates in the first half of 2020"
description: "By Yuqian Li and Shams Zakhour"
publishDate: 2021-02-12
author: liyuqian
image: images/15WEbz38iKKh5EfCj55mGYw.png
category: announcements
layout: blog
---

## Flutter performance updates in the first half of 2020

Being fast is a key pillar to Flutter. This article highlights performance improvements from the first half of 2020 implemented by folks from the Flutter community.

If you’ve helped out with performance after June 2020, we will cover that in a future post. We hope that sharing this with you, the Flutter community, inspires you to help us with this effort!

## Quantified improvements

### [app size] 18.5% reduction in Flutter Gallery app size

contributors: [alexmarkov](https://github.com/alexmarkov), [sstrickl](https://github.com/sstrickl), [mkustermann](https://github.com/mkustermann), [askeksa-google](https://github.com/askeksa-google), [rmacnak-google](https://github.com/rmacnak-google), [mraleph](https://github.com/mraleph), [crelier](https://github.com/crelier)

* Commit [f56b0f](https://github.com/dart-lang/sdk/commit/f56b0f690789b6f0e2e5bc1340abf4eba414b7a0), [a2bb73](https://github.com/dart-lang/sdk/commit/a2bb7301c5795e6b28089a8dc96e6ab5ca798e22), [d77f49](https://github.com/dart-lang/sdk/commit/d77f4913a18ecce8c4be95cbaa4299ff1521dc10), [e2faac](https://github.com/dart-lang/sdk/commit/e2faac751e1ef3707730e6e48f4d8f22ecbf35c3), [8e7ffa](https://github.com/dart-lang/sdk/commit/8e7ffafbafc8203361111ddcafe0e0fcc372edf8), [76c628](https://dart-review.googlesource.com/c/sdk/+/126648), [4ab9c7](https://dart-review.googlesource.com/c/sdk/+/131833), [1c2d37](https://dart-review.googlesource.com/c/sdk/+/132603), [27e64c](https://dart-review.googlesource.com/c/sdk/+/132663), [6a7e4e](https://dart-review.googlesource.com/c/sdk/+/134294), [054929](https://dart-review.googlesource.com/c/sdk/+/152323)

* 18.5% reduction ([9.6MB to 8.1MB](https://golem.corp.goog/Benchmark?team=flutter&benchmark=flutter_gallery_total_size)) the Flutter Gallery sample for Android

### [app size] 100KB size reduction for Gallery app by font subsetting

contributors: [dnfield](https://github.com/dnfield), [jonahwilliams](https://github.com/jonahwilliams), [zanderso](https://github.com/zanderso), [jmagman](https://github.com/jmagman), [blasten](https://github.com/blasten)

* PR [#14828](https://github.com/flutter/engine/pull/14828), [#49737](https://github.com/flutter/flutter/pull/49737), [#49842](https://github.com/flutter/flutter/pull/49842), [#50224](https://github.com/flutter/flutter/pull/50224), [#51808](https://github.com/flutter/flutter/pull/51808)

* 100kb [size reduction](https://github.com/flutter/flutter/pull/49737#issue-368790736) in Flutter Gallery app

* Fixed “Tree shake material icons [#16311](https://github.com/flutter/flutter/issues/16311)”, “Build hb-subset as part of engine builds and upload to cloud storage [#43642](https://github.com/flutter/flutter/issues/43642)”, “Consume font-subset in flutter_tools and treeshake icon fonts [#43644](https://github.com/flutter/flutter/issues/43644)”, “Wire up font subsetting for all platforms [#49730](https://github.com/flutter/flutter/issues/49730)”

### [speed, memory] 9x speedup and 99+% memory reduction on dart2js tools

contributors: [rmacnak-google](https://github.com/rmacnak-google), [a-siva](https://github.com/a-siva)

* Commit [5b8c4e](https://dart-review.googlesource.com/c/sdk/+/130621)

* [9x speedup (46 to 5s) and 99+% memory reduction (537 to 1.5MB)](https://dart-review.googlesource.com/c/sdk/+/130621) on dart2js self compile, 1.5GB heap, 400MB heap snapshot

### [speed] Up to 50% speedup for iOS average render speed by moving from OpenGL to Metal

contributors: [chinmaygarde](https://github.com/chinmaygarde), [dnfield](https://github.com/dnfield), [jason-simmons](https://github.com/jason-simmons), [cbracken](https://github.com/cbracken), [amirh](https://github.com/amirh), [liyuqian](https://github.com/liyuqian)

* PR [#8936](https://github.com/flutter/engine/pull/8936), [#9383](https://github.com/flutter/engine/pull/9383), [#11070](https://github.com/flutter/engine/pull/11070), [#13056](https://github.com/flutter/engine/pull/13056), [#13367](https://github.com/flutter/engine/pull/13367), [#17080](https://github.com/flutter/engine/pull/17080), [#17162](https://github.com/flutter/engine/pull/17162), [#17154](https://github.com/flutter/engine/pull/17154), [#17431](https://github.com/flutter/engine/pull/17431)

* 50% speedup ([6ms to 4ms](https://github.com/flutter/flutter/issues/53768)) for flutter_gallery_ios__transition_perf average_frame_rasterizer_time_millis

* Fixed “Flutter should use Metal instead of OpenGL on iOS [#18208](https://github.com/flutter/flutter/issues/18208)”

### [speed] 2–5x speedup for the worst frame raster time caused by shader compilations

contributors: [liyuqian](https://github.com/liyuqian), [jonahwilliams](https://github.com/jonahwilliams), [chinmaygarde](https://github.com/chinmaygarde), [iskakaushik](https://github.com/iskakaushik), [zanderso](https://github.com/zanderso), [sfshaza2](https://github.com/sfshaza2), [filiph](https://github.com/filiph), [acoutts](https://github.com/acoutts)

<DashImage figure src="images/15WEbz38iKKh5EfCj55mGYw.png" />


* PR [#17300](https://github.com/flutter/engine/pull/17300), [#53859](https://github.com/flutter/flutter/pull/53859), [#17601](https://github.com/flutter/engine/pull/17601), [#17861](https://github.com/flutter/engine/pull/17861), [#58743](https://github.com/flutter/flutter/pull/58743), [#56638](https://github.com/flutter/flutter/pull/56638), [#4430](https://github.com/flutter/website/pull/4430), [#12142](https://github.com/flutter/engine/pull/12412)

* 2.25x speedup ([90ms to 40ms](https://flutter-flutter-perf.skia.org/e/?begin=1597812484&end=1597873497&queries=branch%3Dmaster%26sub_result%3Dworst_frame_rasterizer_time_millis%26test%3Dflutter_gallery_sksl_warmup__transition_perf%26test%3Dflutter_gallery__transition_perf)) for Android flutter_gallery__transition_perf worst_frame_rasterizer_time_millis

* 5x speedup ([300ms to 60ms](https://flutter-flutter-perf.skia.org/e/?begin=1597686064&end=1597961767&numCommits=190&queries=branch%3Dmaster%26sub_result%3Dworst_frame_rasterizer_time_millis%26test%3Dflutter_gallery_sksl_warmup_ios32__transition_perf%26test%3Dflutter_gallery_ios32__transition_perf&showZero=false)) for iOS flutter_gallery_ios32__transition_perf worst_frame_rasterizer_time_millis

* 3.75x speedup ([229ms to 61ms](https://github.com/flutter/flutter/issues/61045#issuecomment-668609516)) for some real apps.

* Fixed “SkSL-based shader warmup [#53607](https://github.com/flutter/flutter/issues/53607)”, “cubic bezier regression [#35142](https://github.com/flutter/flutter/issues/35142)”, and “[saved](https://github.com/flutter/flutter/issues/61045#issuecomment-673409491)” some customers.

### [speed] 15.8x speedup for mouse hit testing

contributors: [dkwingsmt](https://github.com/dkwingsmt), [yjbanov](https://github.com/yjbanov), [goderbauer](https://github.com/goderbauer), [gspencergoog](https://github.com/gspencergoog)

* PR [#59803](https://github.com/flutter/flutter/pull/59803) [#59883](https://github.com/flutter/flutter/pull/59883)

* 15.8x ([79ms to 5ms](https://github.com/flutter/flutter/pull/59883#issue-437275465)) speedup for bench_mouse_region_grid_scroll frame duration (web).

* Fixed “Poor performance when subscribing to MouseRegion events [#41194](https://github.com/flutter/flutter/issues/41194)”

### [speed] 13.9x speedup for platform message response handling

contributors: [zljj0818](https://github.com/zljj0818), [jason-simmons](https://github.com/jason-simmons), [liyuqian](https://github.com/liyuqian)

* PR [#18838](https://github.com/flutter/engine/pull/18838), [#18945](https://github.com/flutter/engine/pull/18945), both of which are inspired by [#18808](https://github.com/flutter/engine/pull/18808)

* Fixed “Image.asset will block UI thread when load large image [#58572](https://github.com/flutter/flutter/issues/58572)”

* 13.9x ([9164us to 660us](https://flutter-engine-perf.skia.org/e/?begin=1593164913&end=1594241999&num_commits=290&queries=test%3DBM_PlatformMessageResponseDartComplete)) speedup in PlatformMessageResponseDartComplete

### [speed] 20%-37% speedup for frame build time with opaque routes

contributors: [goderbauer](https://github.com/goderbauer), [dnfield](https://github.com/dnfield)

* PR [#48900](https://github.com/flutter/flutter/pull/48900)

* 20% ([7.38ms to 6.13ms](https://github.com/flutter/flutter/pull/48900#issuecomment-577297920)) speedup in flutter_gallery_ios32__transition_perf average_frame_build_time_millis

* 37% ([50.45ms to 36.63ms](https://github.com/flutter/flutter/pull/48900#issuecomment-577297920)) speedup in flutter_gallery_ios32__transition_perf 99th_percentile_frame_build_time_millis

* Fixed “Optimize unneeded rebuild when pushing overlay/navigator opaque content [#45797](https://github.com/flutter/flutter/issues/45797)”

### [speed] 4.8x speedup for blur using ImageFiltered instead of BackdropFilter

contributors: [flar](https://github.com/flar), [hixie](https://github.com/hixie), [yjbanov](https://github.com/yjbanov), [liyuqian](https://github.com/liyuqian)

* PR [#14491](https://github.com/flutter/engine/pull/14491), [#47489](https://github.com/flutter/flutter/pull/47489), [#58277](https://github.com/flutter/flutter/pull/58277),

* 4.8x speedup ([29ms/frame to 6ms/frame](https://gist.github.com/flar/1cafb43533652e8e16ea224d93c8a1ec)) for a demo app on Moto G4.

* Fixed “ImageFilter widget [#13489](https://github.com/flutter/flutter/issues/13489)”

### [speed] Up to 14x speedup when scrolling large static content with Flutter web

contributors: [yjbanov](https://github.com/yjbanov), [ferhatb](https://github.com/ferhatb)

* PR [#17621](https://github.com/flutter/engine/pull/17621)

* 14.01x speedup ([463.74ms to 33.10ms](https://docs.google.com/spreadsheets/d/10AXb-4ulJipM6ZtiieFEBXhmybB6-_gTV6HDQlgcQdA/edit#gid=2047450737&range=D85)) for text_canvas_cached_layout.html.layout.average

* Fixed “Jank when scrolling large static content with Flutter Web [#42987](https://github.com/flutter/flutter/issues/42987)” and “Drawing text outside canvas’ bounds is expensive on the Web [#48516](https://github.com/flutter/flutter/issues/48516)”

### [speed] 6.8x speedup for Flutter engine shell initialization

contributors: [scutlight](https://github.com/scutlight), [jason-simmons](https://github.com/jason-simmons), [gaaclarke](https://github.com/gaaclarke), [liyuqian](https://github.com/liyuqian)

* PR [#18225](https://github.com/flutter/engine/pull/18225)

* 6.8x speedup ([18.3ms to 2.7ms](https://flutter-engine-perf.skia.org/e/?begin=1590623523&end=1590741783&keys=X0fffad7016a0440022353623dc52ae28&xbaroffset=17822)) for BM_ShellInitialization

### [speed] 5x speedup by skipping calling builder when constraints are the same

contributors: [yjbanov](https://github.com/yjbanov), [hixie](https://github.com/hixie)

* PR [#55414](https://github.com/flutter/flutter/pull/55414)

* 5x speedup (~10FPS to ~50FPS) on scrolling the contacts list with the Flokk customer app.

* Fixed “LayoutBuilder should cache constraints and not rebuild if unchanged [#6469](https://github.com/flutter/flutter/issues/6469)”

### [speed] 2x speedup for shadows and animation on web

contributors: [ferhatb](https://github.com/ferhatb), [mdebbar](https://github.com/mdebbar), [yjbanov](https://github.com/yjbanov)

* PR [#17864](https://github.com/flutter/engine/pull/17864), [#17866](https://github.com/flutter/engine/pull/17866), [#17867](https://github.com/flutter/engine/pull/17867)

* 2x speedup ([30fps](https://github.com/flutter/flutter/issues/54507#issue-598145549) to [60fps](https://github.com/flutter/flutter/issues/54507#issuecomment-628235938)) for a [sample web app](https://dev.gskinner.com/flutter_perf/shadows/#/).

* Fixes “Web: Poor performance when using Shadows + Animation [#54507](https://github.com/flutter/flutter/issues/54507)”

### [speed] 3X speedup in web Flutter Gallery start-up

contributors: [ferhatb](https://github.com/ferhatb), [clocksmith](https://github.com/clocksmith), [rami-a](https://github.com/rami-a)

* PR [#109](https://github.com/flutter/gallery/pull/109), [#183](https://github.com/flutter/gallery/pull/183)

* 3X speedup ([6077ms to 2039ms](https://github.com/flutter/gallery/pull/109#issue-406182087)) in web Flutter Gallery start-up

### [speed] 2.8x speedup for average frame rasterizer time by enabling raster cache in Fuchsia

contributors: [dreveman](https://github.com/dreveman), [liyuqian](https://github.com/liyuqian), [chinmaygarde](https://github.com/chinmaygarde), [arbreng](https://github.com/arbreng)

* PR [#17753](https://github.com/flutter/engine/pull/17753)

* 2.8x speedup (~10ms to ~3.5ms) for frame_rasterizer_times_avg

* Fixed “Poor performance on Fuchsia due to raster cache being disabled [#54950](https://github.com/flutter/flutter/issues/54950)”

### [speed] 1.85x speedup in 90th percentile frame build time by excluding invisible animated images

contributors: [dnfield](https://github.com/dnfield), [liyuqian](https://github.com/liyuqian), [tvolkert](https://github.com/tvolkert), [digiter](https://github.com/digiter)

* PR [#50851](https://github.com/flutter/flutter/pull/50851), [#50842](https://github.com/flutter/flutter/pull/50842)

* 1.85x speedup ([3.148 ms to 1.699 ms](https://github.com/flutter/flutter/pull/50851#issuecomment-586625240)) for animated_placeholder_perf 90th percentile frame build time

* Fixed “flutter gives low frame rates when long lists with list builder inside cards giving(avg 20–35fps) #[35592](https://github.com/flutter/flutter/issues/35592)”

### [speed] 2x speedup for Google smart displays P10 FPS

contributors: [chinmaygarde](https://github.com/chinmaygarde), [dnicoara](https://github.com/dnicoara), [cbracken](https://github.com/cbracken), [jason-simmons](https://github.com/jason-simmons), [asakhart](https://github.com/asakhart), [rdaum](https://github.com/rdaum)

* PR [#15980](https://github.com/flutter/engine/pull/15980)

* 2x speedup (30fps to 60fps) by giving embedders a way to tune thread priority.

* Fixed issue [49551](https://github.com/flutter/flutter/issues/49551)

### [speed] 2.45x speedup for ImageFilterLayer by enhancing its child cache

contributors: [flar](https://github.com/flar), [liyuqian](https://github.com/liyuqian)

* PR [#17175](https://github.com/flutter/engine/pull/17175), [#54903](https://github.com/flutter/flutter/pull/54903), [#58277](https://github.com/flutter/flutter/pull/58277)

* 2.45x speedup ([18.41 ms to 7.53 ms](https://github.com/flutter/engine/pull/17175#issuecomment-647778369)) for ImageFiltered Transform average_frame_rasterizer_time_millis

* Also fixed “Transition performance regressed slightly due to OpacityLayer raster cache miss [#52864](https://github.com/flutter/flutter/issues/52864)”

### [speed] 15% speedup for very large dart2js compilation

contributors: [rmacnak-google](https://github.com/rmacnak-google), [a-siva](https://github.com/a-siva)

* Commit [d67fbe](https://dart-review.googlesource.com/c/sdk/+/133660)

* 1.15x speedup ([545 to 472 seconds](https://dart-review.googlesource.com/c/sdk/+/133660)) very large dart2js compile, 9% reduction ([13.057 to 11.861 GB](https://dart-review.googlesource.com/c/sdk/+/133660)) in very large dart2js compile max heap capacity.

* Fixed “Growth policy misinformed by concurrent sweep [#21364](https://github.com/dart-lang/sdk/issues/21364)”

### [speed] 1.8x speedup in AOT compilation time of a large app

contributors: [alexmarkov](https://github.com/alexmarkov), [mraleph](https://github.com/mraleph), [sigurdm](https://github.com/sigurdm), [cskau-g](https://github.com/cskau-g)

* Commit [467c98](https://dart-review.googlesource.com/c/sdk/+/152100)

* 1.8x speedup ([274s to 152s](https://dart-review.googlesource.com/c/sdk/+/152100)) in AOT compilation time of a large app ( — from-dill)

### [speed] 5x-13x speedup on Dart RegExp matching in AOT mode

contributors: [mraleph](https://github.com/mraleph), [rmacnak-google](https://github.com/rmacnak-google)

* Commit [2c922b](https://dart-review.googlesource.com/c/sdk/+/151515)

* 5x speedup improvement on benchmark from issue [42366](https://github.com/dart-lang/sdk/issues/42366)

* 13x speedup ([17863744.009 us to 1301678.797 us](https://dart-review.googlesource.com/c/sdk/+/151515)) of RegExp(RunTime) benchmark on a Linux workstation

* Fixed “RegExp is very slow in AOT mode [#42366](https://github.com/dart-lang/sdk/issues/42366)”

### [speed] Up to 5x speedup in Dart UTF8 decoding

contributors: [askeksa-google](https://github.com/askeksa-google), [mkustermann](https://github.com/mkustermann), [rakudrama](https://github.com/rakudrama)

* Commit [cf6f89](https://dart-review.googlesource.com/c/sdk/+/148762), [e35ca3](https://dart-review.googlesource.com/c/sdk/+/150925), [78df4a](https://dart-review.googlesource.com/c/sdk/+/146785), [fa2fd4](https://dart-review.googlesource.com/c/sdk/+/142025)

* [5.02x speedup](https://dart-review.googlesource.com/c/sdk/+/146785) in X64JIT TwoByteString benchmark

* Fixed “Fast path Uint8List to _OneByteString conversion [#41703](https://github.com/dart-lang/sdk/issues/41703)”, “Write UTF-8 result directly to strings [#41704](https://github.com/dart-lang/sdk/issues/41704)”

### [speed] 35–65% speedup in async/sync* functions

contributors: [cskau-g](https://github.com/cskau-g), [mkustermann](https://github.com/mkustermann), [mraleph](https://github.com/mraleph)

* Commit [e29407](https://dart-review.googlesource.com/c/sdk/+/146780), [fdca1f](https://dart-review.googlesource.com/c/sdk/+/134282), [7ed169](https://dart-review.googlesource.com/c/sdk/+/133586), [ca94ad](https://dart-review.googlesource.com/c/sdk/+/136190)

* [35–65% speedup](https://dart-review.googlesource.com/c/sdk/+/133586) in Calls.IterableManualIterablePolymorphicManyYields across {dart,dart-aot}-{ia32,x64,armv7hf,armv8}

* Fixed “improve performance of sync* code on VM [#37753](https://github.com/dart-lang/sdk/issues/37753)”, “Evaluate use of IndirectGoto when generating sync-yield function in VM [#37754](https://github.com/dart-lang/sdk/issues/37754)”

### [speed] Up to 31.82% reduction in time with unboxed parameters and fields

contributors: [mkustermann](https://github.com/mkustermann), [mkustermann](https://github.com/mkustermann)

* Commit [9eb531](https://dart-review.googlesource.com/c/sdk/+/131824), [b95149](https://dart-review.googlesource.com/c/sdk/+/135313), [e076e7](https://dart-review.googlesource.com/c/sdk/+/132606), [9eb531](https://dart-review.googlesource.com/c/sdk/+/131824)

* [Up to 31.82% reduction](https://dart-review.googlesource.com/c/sdk/+/131824) in matrix_utils_transform_rect_affine iteration time.

* Fixed “Real unboxed fields in the Dart VM [#40004](https://github.com/dart-lang/sdk/issues/40004)”

### [speed] 20–25% speedup on Dart Pointer&lt;Int8,Int64,etc&gt; loads/stores in AOT

contributors: [dcharkes](https://github.com/dcharkes), [mkustermann](https://github.com/mkustermann)

* Commit [408123](https://dart-review.googlesource.com/c/sdk/+/137788)

* Speeds up Pointer&lt;Int8,Int64,etc&gt; loads/stores by [20–25%](https://dart-review.googlesource.com/c/sdk/+/137788) in AOT on x64.

* Helped “stores and loads should support unboxed indices (in AOT) [#39432](https://github.com/dart-lang/sdk/issues/39432)”

## Other improvements

### [app size, energy, memory, speed] Add A/B test mode to local devicelab runner

contributors: [yjbanov](https://github.com/yjbanov), [flar](https://github.com/flar), [ferhatb](https://github.com/ferhatb), [christopherfujino](https://github.com/christopherfujino), [liyuqian](https://github.com/liyuqian)

* PR [#54494](https://github.com/flutter/flutter/pull/54494), [#56416](https://github.com/flutter/flutter/pull/56416), [#54676](https://github.com/flutter/flutter/pull/54676)

### [app size] Fixed “iOS App Size in FAQ incorrect”

contributors: [jmagman](https://github.com/jmagman), [xster](https://github.com/xster), [dnfield](https://github.com/dnfield), [sfshaza2](https://github.com/sfshaza2)

* Issue [#38016](https://github.com/flutter/flutter/issues/38016), PR [#4080](https://github.com/flutter/website/pull/4080)

### [app size] Enable the usage of — delete-tostring-package-uri in the flutter too

contributors: [jonahwilliams](https://github.com/jonahwilliams), [dnfield](https://github.com/dnfield)

* Issue [#53174](https://github.com/flutter/flutter/issues/53174), PR [#53273](https://github.com/flutter/flutter/pull/53273)

### [energy, memory] Timeline summary now includes CPU/GPU/memory for iOS

contributors: [iskakaushik](https://github.com/iskakaushik), [gaaclarke](https://github.com/gaaclarke), [albertwang0116](https://github.com/albertwang0116), [liyuqian](https://github.com/liyuqian), [chinmaygarde](https://github.com/chinmaygarde), [gw280](https://github.com/gw280)

* Issue [#58803](https://github.com/flutter/flutter/issues/58803), PR [#18087](https://github.com/flutter/engine/pull/18087), [#18516](https://github.com/flutter/engine/pull/18516), [#18752](https://github.com/flutter/engine/pull/18752)

* [http://flutter.dev/go/engine-cpu-profiling](http://flutter.dev/go/engine-cpu-profiling)

### [memory] ImageCache flushes itself when told about memory pressure

contributors: [dnfield](https://github.com/dnfield), [goderbauer](https://github.com/goderbauer), [chunhtai](https://github.com/chunhtai)

* Issue [#16375](https://github.com/flutter/flutter/issues/16375), PR [#53959](https://github.com/flutter/flutter/pull/53959)

### [memory] Fixed “Skia PathMask cache leaks memory”

contributors: [bsalomon](https://github.com/bsalomon)

* Issue [#50972](https://github.com/flutter/flutter/issues/50972), commit [4282d2](https://skia-review.googlesource.com/c/skia/+/272654/)

### [memory] Fixed firebase_ml_vision memory leak on iOS

contributors: [rishabnayak](https://github.com/rishabnayak), [bparrishmines](https://github.com/bparrishmines)

* Issue [#32967](https://github.com/flutter/flutter/issues/32967), [#32652](https://github.com/flutter/flutter/issues/32652), PR [#1615](https://github.com/flutter/plugins/pull/1615)

### [memory] Added DevTools based max memory test

contributors: [liyuqian](https://github.com/liyuqian), [dnfield](https://github.com/dnfield), [digiter](https://github.com/digiter)

* Issue [#44013](https://github.com/flutter/flutter/issues/44013), PR [#55486](https://github.com/flutter/flutter/pull/55486)

### [memory] Defer image decoding when scrolling fast

contributors: [dnfield](https://github.com/dnfield), [hixie](https://github.com/hixie), [goderbauer](https://github.com/goderbauer)

* Issue [#44510](https://github.com/flutter/flutter/issues/44510), [#48775](https://github.com/flutter/flutter/issues/48775), PR [#49389](https://github.com/flutter/flutter/pull/49389)

### [memory] If an image is available in the tree currently, it should be resolvable by key without reloading even if it didn’t fit into the image cache

contributors: [dnfield](https://github.com/dnfield), [hixie](https://github.com/hixie), [goderbauer](https://github.com/goderbauer), [jonahwilliams](https://github.com/jonahwilliams), [ignatz](https://github.com/ignatz), [gaaclarke](https://github.com/gaaclarke)

* Issue #[48731](https://github.com/flutter/flutter/issues/48731), [#49456](https://github.com/flutter/flutter/issues/49456), [#45406](https://github.com/flutter/flutter/issues/45406), PR [#50242](https://github.com/flutter/flutter/pull/50242), [#50297](https://github.com/flutter/flutter/pull/50297), [#50316](https://github.com/flutter/flutter/pull/50316), [#50318](https://github.com/flutter/flutter/pull/50318)

* [https://flutter.dev/go/widget-tree-image-cache](https://flutter.dev/go/widget-tree-image-cache)

### [speed] Rewrite DevTools frame chart with parallel UI and raster thread times

contributors: [kenzieschmoll](https://github.com/kenzieschmoll), [terrylucas](https://github.com/terrylucas)

* PR [#1999](https://github.com/flutter/devtools/pull/1999)

### [speed] Added new Gallery mobile benchmarks

contributors: [guidezpl](https://github.com/guidezpl), [liyuqian](https://github.com/liyuqian), [clocksmith](https://github.com/clocksmith), [rami-a](https://github.com/rami-a), [flar](https://github.com/flar)

* PR [#55181](https://github.com/flutter/flutter/pull/55181), [#20](https://github.com/flutter/gallery/pull/20), [#100](https://github.com/flutter/gallery/pull/100), [#115](https://github.com/flutter/gallery/pull/115)

### [speed] Add new Gallery web benchmarks

contributors: [pennzht](https://github.com/pennzht), [yjbanov](https://github.com/yjbanov), [guidezpl](https://github.com/guidezpl), [willlarche](https://github.com/willlarche), [clocksmith](https://github.com/clocksmith), [josealba](https://github.com/josealba)

* PR [#57576](https://github.com/flutter/flutter/pull/57576), [#163](https://github.com/flutter/gallery/pull/163)

### [speed] Community added a new package to unlock 90 fps for some devices

contributors: [ajinasokan](https://github.com/ajinasokan)

* Issue [#35162](https://github.com/flutter/flutter/issues/35162)

* [https://github.com/ajinasokan/flutter_displaymode](https://github.com/ajinasokan/flutter_displaymode)

### [speed] Renamed GPU thread to raster thread

contributors: [filiph](https://github.com/filiph), [liyuqian](https://github.com/liyuqian), [kenzieschmoll](https://github.com/kenzieschmoll), [chinmaygarde](https://github.com/chinmaygarde), [cbracken](https://github.com/cbracken), [goderbauer](https://github.com/goderbauer), [zanderso](https://github.com/zanderso), [devoncarew](https://github.com/devoncarew), [sfshaza2](https://github.com/sfshaza2)

* Issue [#29443](https://github.com/flutter/flutter/issues/29443), PR [#17148](https://github.com/flutter/engine/pull/17148), [#17329](https://github.com/flutter/engine/pull/17329), [#17408](https://github.com/flutter/engine/pull/17408), [#53422](https://github.com/flutter/flutter/pull/53422), [#1758](https://github.com/flutter/devtools/pull/1758), [#3836](https://github.com/flutter/website/pull/3836)

### [speed] Added benchmark for platform views

contributors: [blasten](https://github.com/blasten), [cyanglaz](https://github.com/cyanglaz)

* Issue [52684](https://github.com/flutter/flutter/issues/52684), PR [#52717](https://github.com/flutter/flutter/pull/52717)

### [speed] Avoid unnecessary thread clock clock calls while tracing, resulting in less (kernel) trace buffer space usage, and slightly lower tracing overhead.

contributors: [nathanrogersgoogle](https://github.com/nathanrogersgoogle), [a-siva](https://github.com/a-siva), [fmeawad](https://github.com/fmeawad), [johngro](https://github.com/johngro)

* [https://dart-review.googlesource.com/c/sdk/+/149395](https://dart-review.googlesource.com/c/sdk/+/149395)

### [speed] Fix RefreshIndicator performance issue

contributors: [dnfield](https://github.com/dnfield), [goderbauer](https://github.com/goderbauer)

* Issue [#47664](https://github.com/flutter/flutter/issues/47664), PR [#53206](https://github.com/flutter/flutter/pull/53206)

### [speed] Enable lazy async stack traces via tool feature

contributors: [jonahwilliams](https://github.com/jonahwilliams), [zanderso](https://github.com/zanderso)

* Issue [#48725](https://github.com/flutter/flutter/issues/48725), PR [#49377](https://github.com/flutter/flutter/pull/49377)

### [speed] [flutter_tools] initialize frontend server with build

contributors: [jonahwilliams](https://github.com/jonahwilliams), [zanderso](https://github.com/zanderso)

* Issue [#40388](https://github.com/flutter/flutter/issues/40388), [#49865](https://github.com/flutter/flutter/issues/49865), [#43464](https://github.com/flutter/flutter/issues/43464), PR [#51477](https://github.com/flutter/flutter/pull/51477)

### [speed] Colored box and container optimization

contributors: [dnfield](https://github.com/dnfield), [hansmuller](https://github.com/hansmuller), [piinks](https://github.com/piinks), [redbrogdon](https://github.com/redbrogdon), [goderbauer](https://github.com/goderbauer), [liyuqian](https://github.com/liyuqian)

* Issue [#9672](https://github.com/flutter/flutter/issues/9672), PR [#50979](https://github.com/flutter/flutter/pull/50979)

## Conclusion

Due to the lowered productivity as a result of COVID-19, we expected to have fewer performance improvements. Surprisingly, we found more quantified improvements in Q1-Q2 2020 than Q3-Q4 2019 (25 vs. 20) thanks to our growing community! Overall, we see 49 improvements from 78 contributors in Q1-Q2 2020.

Despite our best effort, some performance contributions in Q1-Q2 2020 may be missed in this update. Please don’t hesitate to let us know of any missing contributions, and we’ll put them in the next update.