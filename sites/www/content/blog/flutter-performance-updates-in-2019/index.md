---
title: "Flutter Performance Updates in 2019"
description: "By Yuqian Li and Shams Zakhour"
publishDate: 2020-07-31
author: sfshaza2
image: images/1bWXPMmCXDmBWN7rZbxZcyg.webp
category: announcements
layout: blog
---

Being fast is a key pillar to Flutter. This article highlights performance improvements from the second half of 2019 implemented by folks from the Flutter community. (Yes, this is late, but it’s better late than never!)

If you’ve helped out with performance in 2020, we will cover that in a future post. We hope that sharing this with you, the Flutter community, inspires you to help us with this effort!

## Q4 (Oct-Dec) 2019

### Quantified improvements

<DashImage figure src="images/1bWXPMmCXDmBWN7rZbxZcyg.webp" alt="70% memory reduction in fast scrolling through large images" caption="70% memory reduction in fast scrolling through large images" />


**70% memory reduction in fast scrolling through large images
contributors: [liyuqian](https://github.com/liyuqian), [dnfield](https://github.com/dnfield), [chinmaygarde](https://github.com/chinmaygarde)**

* [PR 14265: Cleanup the IO thread GrContext](https://github.com/flutter/engine/pull/14265)

* [PR 46184: Memory test on scrolling large images quickly](https://github.com/flutter/flutter/pull/46184)

* [Dashboard: 70% reduction (400MB to 120MB) in fast_scroll_large_images__memory diff-median](https://flutter-dashboard.appspot.com/benchmarks.html)

* [Issue 19558: IO thread GrContext memory needs to be cleaned up](https://github.com/flutter/flutter/issues/19558)

**40% reduction in CPU/GPU usages for simple iOS animations
contributors: [flar](https://github.com/flar), [liyuqian](https://github.com/liyuqian), [hixie](https://github.com/hixie), [chinmaygarde](https://github.com/chinmaygarde)**

* [PR 14104: Rework simpler conditional offscreen for screen readback support](https://github.com/flutter/engine/pull/14104)

* [PR 13976: Dynamically determine whether to use offscreen surface based on need](https://github.com/flutter/engine/pull/13976)

* [PR 31865: Simple animation costs high CPU/GPU/Power usages (~20%) on iPhone 6](https://github.com/flutter/flutter/issues/31865)

* [40% (23%-CPU-14%-GPU to 13%-CPU-8.5%-GPU) reduction in simple_animation_perf_iphonexs cpu_percentage, gpu_percentage](https://github.com/flutter/flutter/issues/31865#issuecomment-566268237)

**41% speedup for caret performance
contributors: [garyqian](https://github.com/garyqian), [liyuqian](https://github.com/liyuqian), [justinmc](https://github.com/justinmc)**

* [PR 46720: Pass _caretPrototype to prevent cache miss](https://github.com/flutter/flutter/pull/46720)

* [PR 46720: 41% speedup (6.709ms to 4.756ms) for 90th percentile frame build time](https://github.com/flutter/flutter/pull/46720)

* Fixed [Issue 24522: Caret performance is poor, high GPU time per frame](https://github.com/flutter/flutter/issues/24522)

**10% speedup for list scrolling by fixing raster cache throttling
contributors: [liyuqian](https://github.com/liyuqian), [chinmaygarde](https://github.com/chinmaygarde), [flar](https://github.com/flar), [cyanglaz](https://github.com/cyanglaz), [zsunkun](https://github.com/zsunkun)**

* [PR 31865: Simple animation costs high CPU/GPU/Power usages (~20%) on iPhone 6](https://github.com/flutter/flutter/issues/31865)

* [PR 13710: Fix picture raster cache throttling](https://github.com/flutter/engine/pull/13710)

* [PR 45050: Add a perf test for picture raster cache](https://github.com/flutter/flutter/pull/45050)

* Fixed a blocker issue, [43083: List scrolling is not smooth](https://github.com/flutter/flutter/issues/43083) with [PR 13710: Fix picture raster cache throttling](https://github.com/flutter/flutter/issues/13710)

**37x speedup for cached benchmarks load time ([Dashboard](https://flutter-dashboard.appspot.com/benchmarks.html))
contributors: [caseyhillers](https://github.com/caseyhillers), [tvolkert](https://github.com/tvolkert), [digiter](https://github.com/digiter), [jonahwilliams](https://github.com/jonahwilliams)**

* [PR 494: Cache get-benchmarks](https://github.com/flutter/cocoon/pull/494)

* [PR 484: /api/public/get-status serves cached responses](https://github.com/flutter/cocoon/pull/484)

* [37x speedup (37s to 1s) in benchmarks loading time](https://github.com/flutter/cocoon/pull/494#issue-333227543)

**2.3x speedup for building APKs
contributors: [jonahwilliams](https://github.com/jonahwilliams), [blasten](https://github.com/blasten), [zanderso](https://github.com/zanderso), [xster](https://github.com/xster)**

* [PR 44534: Improve performance of build APK (~50%) by running gen_snapshot concurrently](https://github.com/flutter/flutter/pull/44534)

* [2.3x speedup (140s to 60s) in a release build of an APK for target platforms android-arm, android-arm64, and android-x64](https://github.com/flutter/flutter/pull/44534#issue-339112036)

**+103 performance metrics recorded per Flutter engine commit
contributors: [liyuqian](https://github.com/liyuqian), [digiter](https://github.com/digiter), [keyonghan](https://github.com/keyonghan), [godofredoc](https://github.com/godofredoc), [cbracken](https://github.com/cbracken)**

* [PR 14556: Run and collect benchmarks](https://github.com/flutter/engine/pull/14556)

* Related issue: [PR 37434: Centralize performance metrics, provide universal alerts, and improve performance dashboard](https://github.com/flutter/flutter/issues/37434)

**20% app size reduction
contributors: [mraleph](https://github.com/mraleph), [alexmarkov](https://github.com/alexmarkov), [rmacnak-google](https://github.com/rmacnak-google), [mkustermann](https://github.com/mkustermann), [sstrickl](https://github.com/sstrickl), [aartbik](https://github.com/aartbik)**

* 3% from [Lift PC offsets out of StackMaps](https://github.com/dart-lang/sdk/commit/a2bb7301c5795e6b28089a8dc96e6ab5ca798e22)

* 2.58% from [Further compress the information previously in StackMaps](https://github.com/dart-lang/sdk/commit/d77f4913a18ecce8c4be95cbaa4299ff1521dc10)

* 1% from [Canonicalize CompressedStackMaps payloads when possible](https://github.com/dart-lang/sdk/commit/dc808f3fcbf7e6de7e2b25441ff7ed891362e70a)

* 2% from [Fully enable deduplication of instructions in bare mode](https://github.com/dart-lang/sdk/commit/e2faac751e1ef3707730e6e48f4d8f22ecbf35c3)

* 0.3% from [Do not generate monomorphic prologue for functions which need args descriptor](https://github.com/dart-lang/sdk/commit/f6477854cdb0da052be3423a24961feaf5a0d845)

* 1% from [Drop redundant initializing stores of null](https://github.com/dart-lang/sdk/commit/46cef9bfddf3cfc05618448d228f0e3377058baf)

* 6% from [Reduce alignment of Instructions and remove some debugging trap instructions](https://github.com/dart-lang/sdk/commit/8e7ffafbafc8203361111ddcafe0e0fcc372edf8)

* 1.2% from [Adjust CSP during the invocation stub instead of each function prologue](https://github.com/dart-lang/sdk/commit/c873220e43af1a1f4675df4108e575465e598578)

* 1% from [ARM64: Block R22 to hold NullObject()](https://github.com/dart-lang/sdk/commit/f8d42542ddd40c06bb71d6fb85d78ed4bbffa785)

* 2.5% from [Whole-program constant propagation](https://github.com/dart-lang/sdk/commit/f56b0f690789b6f0e2e5bc1340abf4eba414b7a0)

* 0.77% from [Dead code elimination](https://github.com/dart-lang/sdk/commit/b69596bb1ba81874e4b9d7a577071c67c357ec39)

**108x speedup on Dart FFI performance
contributors: [dcharkes](https://github.com/dcharkes), [mkustermann](https://github.com/mkustermann), [sjindel](https://github.com/sjindel), [alexmarkov](https://github.com/alexmarkov)**

* [Gerrit 120661: Optimize Pointer operations for statically known types](https://dart-review.googlesource.com/c/sdk/+/120661)

* [Gerrit 119645: Pointer optimize indexed load and store](https://dart-review.googlesource.com/c/sdk/+/119645)

* [Gerrit 121580: Allow inlining of force optimized functions in AoT](https://dart-review.googlesource.com/c/sdk/+/121580)

**10–15% performance improvement in tight code
contributors: [aartbik](https://github.com/aartbik), [mkustermann](https://github.com/mkustermann), [mraleph](https://github.com/mraleph)**

* [Gerrit 117200: Loop analysis and BCE improvements](https://dart-review.googlesource.com/c/sdk/+/117200)

* 10–15% performance improvement in golem armv7, and TypedData Bench: [Gerrit 117200: Loop analysis and BCE improvements](https://dart-review.googlesource.com/c/sdk/+/117200)

**2.2x speedup in flutter test with new incremental serializer
contributors: [jensjoha](https://github.com/jensjoha), [alexmarkov](https://github.com/alexmarkov)**

* [Gerrit 121121: Enable incremental serializer by default](https://dart-review.googlesource.com/c/sdk/+/121121)

* 2.2x speedup (3:38 to 1:39) in `flutter test`

**10% faster Kernel binary serialization by giving inlining hints to Dart VM JIT
contributors: [jensjoha](https://github.com/jensjoha), [johnniwinther](https://github.com/johnniwinther)**

* [Gerrit 119540: Add VM pragma prefer-inline to certain methods in kernel serialization](https://dart-review.googlesource.com/c/sdk/+/119540)

**30% performance improvement on async heavy code
contributors: [cskau-g](https://github.com/cskau-g), [mkustermann](https://github.com/mkustermann), [mraleph](https://github.com/mraleph)**

* [Adds non-eager async stack frame collector](https://dart-review.googlesource.com/c/sdk/+/122644)

## Other improvements

**Fixed a memory leak when using `PlatformView` on iOS**

* [Fix Memory leak when using `PlatformView` [IOS]](https://github.com/flutter/engine/pull/7919)

* [Memory leak when using `PlatformView` [IOS]](https://github.com/flutter/flutter/issues/24714)

## Fixed a memory leak when animation is playing on iOS

* [Gerrit 260538: Don’t allocate invalidation messages for generators that make uncacheable textures](https://skia-review.googlesource.com/c/skia/+/260538)

* [Memory Leak when animation is playing in iOS](https://github.com/flutter/flutter/issues/47108)

**Fixed more iOS memory leaks**

* [https://github.com/flutter/engine/pull/14275](https://github.com/flutter/engine/pull/14275)

* [https://github.com/flutter/engine/pull/14326](https://github.com/flutter/engine/pull/14326)

* [https://github.com/flutter/flutter/issues/35243](https://github.com/flutter/flutter/issues/35243)

**Started revamping [Performance](https://flutter.dev/docs/perf) pages on flutter.dev and added instructions on [measuring app size](https://flutter.dev/docs/perf/app-size).**

* [PR 3159: Performance](https://github.com/flutter/website/pull/3159/)

**Corrected the first frame waiting logic and measurement**

* [PR 37192: Reland “Fix the first frame logic in tracing and driver (#35297)”](https://github.com/flutter/flutter/pull/37192)

* Fixed [Issue 47108: Memory Leak when animation is playing in iOS](https://github.com/flutter/flutter/issues/47108)

**DevTools added full timeline mode with support for async and recorded tracing.**

* [PR 1241: Add full timeline view](https://github.com/flutter/devtools/pull/1241)

**IntelliJ plugin fixed 120FPS support**

* [PR 4289: Remove hard coded refresh rate for fps calculation](https://github.com/flutter/flutter-intellij/pull/4289)

**Many timeline tracing improvements thanks to ByteDance**

* [Gerrit 127920: [timeline] Add support for timeline asynchronous events in android platform trace](https://dart-review.googlesource.com/c/sdk/+/127920)

* [Gerrit 128200: [timeline] support vm events available to systrace](https://dart-review.googlesource.com/c/sdk/+/128200)

* [Gerrit 127921: support more sync event when use systrace to record timeline event](https://dart-review.googlesource.com/c/sdk/+/127921)

* [PR 14323: Fix missing API stream when record event in systrace](https://github.com/flutter/engine/pull/14323)

* [PR 14521: Support timeline can be enabled in release mode](https://github.com/flutter/engine/pull/14521)

* [PR 14319: Fix missing timeline event of flutter engine’s startup time](https://github.com/flutter/engine/pull/14319)

* [PR 47742: fix duration event of timeline summary](https://github.com/flutter/flutter/pull/47742)

* [Gerrit 131360: Support timeline conversion to iOS platform trace](https://dart-review.googlesource.com/c/sdk/+/131360)

* [PR 16520: support endless trace buffer](https://github.com/flutter/engine/pull/16520)

* [PR 47419: support endless recorder for timeline](https://github.com/flutter/flutter/pull/47419)

## Q3 (July-Sept) 2019

### Quantified improvements

**1.5–5x speedup for rect & point transformations
contributors: [flar](https://github.com/flar), [yjbanov](https://github.com/yjbanov), [dnfield](https://github.com/dnfield)**

* [PR 37275: Optimize the transformRect and transformPoint methods in matrix_utils](https://github.com/flutter/flutter/pull/37275)

* 5.3x speedup (2300ms to 430ms) in [`MatrixUtils_affine_transformRect_iteration`](http://go/flutter-benchmarks)

* 1.5x speedup (466ms to 320ms) in `MatrixUtils_affine_transformPoint_iteration`

**N/2–1 fewer missed frames on iPhone X/Xs scrolling
contributors: [liyuqian](https://github.com/liyuqian), [chinmaygarde](https://github.com/chinmaygarde), [gaaclarke](https://github.com/gaaclarke)**

* [https://github.com/flutter/engine/pull/12385](https://github.com/flutter/engine/pull/12385)

* [PR 12385: Reland “Smooth out iOS irregular input events delivery](https://github.com/flutter/engine/pull/12385)

* Reduced the worst-case number of missed frames from N/2 to 1 in a scroll of N frames. In practice, N/10 frames were missed on average before the fix.

* Fixed one of our top-voted issues:
[Issue 31086: Scroll performance significantly degraded on iPhone X, Xs devices due to irregular input events delivery](https://github.com/flutter/flutter/issues/31086)

**15% faster engine start and shutdown with parallel initialization
contributors: [gaaclarke](https://github.com/gaaclarke), [chinmaygarde](https://github.com/chinmaygarde), [liyuqian](https://github.com/liyuqian)**

* [PR 10182: Made flutter startup faster by allowing initialization to be parallelized](https://github.com/flutter/engine/pull/10182)

* [1.16x speedup (3829377 ns to 3286713 ns) in BM_ShellInitializationAndShutdown](https://github.com/flutter/engine/pull/10182#issuecomment-531953100)

**14.57ms faster startup and 8MB smaller memory usage for shader warm-up
contributors: [gaaclarke](https://github.com/gaaclarke), [liyuqian](https://github.com/liyuqian), [dnfield](https://github.com/dnfield)**

* [PR 36482: Sped up shader warmup by only drawing on a 100x100 surface](https://github.com/flutter/flutter/pull/36482)

* [Saves 14.57ms (18.848ms to 4.279ms) in reading/converting pixels at startup](https://github.com/flutter/flutter/pull/36482#issue-299068276)

* [Saves 8MB (39220KB to 31184KB) in start-median memory](https://github.com/flutter/flutter/pull/36482#issuecomment-531067365)

* [Saves 4MB (45034KB to 40980KB) in end-median memory](https://github.com/flutter/flutter/pull/36482#issuecomment-531067365)

**1.02%-8.04% reduction in code size
contributors: [johnniwinther](https://github.com/johnniwinther), [aartbik](https://github.com/aartbik), [rmacnak-google](https://github.com/rmacnak-google), [jensjoha](https://github.com/jensjoha), [alexmarkov](https://github.com/alexmarkov), [mkustermann](https://github.com/mkustermann)**

* [https://dart-review.googlesource.com/c/sdk/+/118280](https://dart-review.googlesource.com/c/sdk/+/118280)

* [https://dart-review.googlesource.com/c/sdk/+/112758](https://dart-review.googlesource.com/c/sdk/+/112758)

* [https://dart-review.googlesource.com/c/sdk/+/118181](https://dart-review.googlesource.com/c/sdk/+/118181)

* -8.04% (5.57MB to 5.13MB) in armv8 animation_bench_instructions_size

* -2.7% (2.10MB to 2.05MB) in armv7 flutter_gallery_readonlydata_size

* -1.22% (2.10MB to 2.05MB) in armv7 layout_bench_instructions_size

**Up-to-2x increase for Flutter on Fuchsia FPS; improved frame scheduling
contributors: [dreveman](https://github.com/dreveman), [amott](https://github.com/amott), [rosswang](https://github.com/rosswang), [mikejurka](https://github.com/mikejurka)**

* [https://fuchsia-review.googlesource.com/c/topaz/+/280230](https://fuchsia-review.googlesource.com/c/topaz/+/280230)

* [https://fuchsia-review.googlesource.com/c/topaz/+/286735](https://fuchsia-review.googlesource.com/c/topaz/+/286735)

* [https://fuchsia-review.googlesource.com/c/topaz/+/300135](https://fuchsia-review.googlesource.com/c/topaz/+/300135)

* [https://fuchsia-review.googlesource.com/c/topaz/+/306773](https://fuchsia-review.googlesource.com/c/topaz/+/306773)

* [https://fuchsia-review.googlesource.com/c/topaz/+/306772](https://fuchsia-review.googlesource.com/c/topaz/+/306772)

* [https://fuchsia-review.googlesource.com/c/topaz/+/307953](https://fuchsia-review.googlesource.com/c/topaz/+/307953)

### Quantified regression fixes

**3x speedup for BackdropFilter on iOS
contributors: [lhkbob](https://github.com/lhkbob), [liyuqian](https://github.com/liyuqian), [flar](https://github.com/flar)**

* [https://skia-review.googlesource.com/c/skia/+/237904](https://skia-review.googlesource.com/c/skia/+/237904)

* [https://skia-review.googlesource.com/c/skia/+/234413](https://skia-review.googlesource.com/c/skia/+/234413)

* [https://github.com/flutter/flutter/pull/38814](https://github.com/flutter/flutter/pull/38814)

* [3x speedup (110ms to 34ms) in GM_savelayer_with_backdrop](https://perf.skia.org/e/?begin=1567010155&end=1567104574&queries=name%3DGM_savelayer_with_backdrop%26os%3DiOS)

* Fixed regression [https://github.com/flutter/flutter/issues/36064](https://github.com/flutter/flutter/issues/36064)

To achieve some huge improvements (3x for example), the bad performance of the old state probably played an equally important role as the hard work in Q3 (July-Sept) 2019. We also marked some improvements as non-trivial fixes of equally big regressions. Nevertheless, we appreciate such work. Without it, we’d continue to have bad performance and regressions. We don’t want the big improvements to dwarf the smaller improvements. They just didn’t have a very bad old performance to start with, which in some sense is a good thing.

### Other improvements

* DevTools [support variable display refresh rates (e.g. 60 FPS, 120 FPS, etc.)](https://github.com/flutter/devtools/blob/master/packages/devtools/CHANGELOG.md#018---2019-10-01)

* VSCode plugin’s scanning for projects is now asynchronous which should improve extension activation speed and reduce the chances of triggering VS Code’s “extension causes high CPU” warning. ([#1840](https://github.com/Dart-Code/Dart-Code/issues/1840)/[#2003](https://github.com/Dart-Code/Dart-Code/issues/2003)/[#1961](https://github.com/Dart-Code/Dart-Code/issues/1961))

* iPhone Xs is [added to Flutter device lab](https://github.com/flutter/flutter/issues/34590) for benchmarking

## Conclusion

<DashImage figure src="images/1VpFwtNIAQAKacPIFLIbGYw.webp" alt="57% of respondents are very satisfied with Flutter. In total, 94% are positively satisfied." caption="57% of respondents are very satisfied with Flutter. In total, 94% are positively satisfied." />


Thanks to these contributions from our community, the proportion of users positively satisfied with Flutter’s mobile performance increased from 85% in Q3 2019 to 92% in 2020. Despite our best effort, some performance contributions in Q3-Q4 2019 may be missed in this update. Please don’t hesitate to let us know of any missing contributions, and we’ll put them in the next update.
