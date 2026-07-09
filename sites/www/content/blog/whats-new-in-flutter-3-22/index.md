---
title: "What’s new in Flutter 3.22"
description: "WebAssembly, Graphics rendering enhancements, and more options for AI integration"
publishDate: 2024-05-14
author: itsjustkevin
image: images/1hf9CEzGh0uhxnzVZi2Kk4g.webp
category: releases
layout: blog
---

<DashImage figure src="images/1hf9CEzGh0uhxnzVZi2Kk4g.webp" />


## What’s new in Flutter 3.22

### WebAssembly, Graphics rendering enhancements, and more options for AI integration

Welcome back for another exciting Flutter stable release! This time, we’re thrilled to present Flutter 3.22. We’re bringing WebAssembly to the stable channel, a fully featured Vulkan backend for Impeller on Android, promising smoother graphics and a major performance boost. We’re also introducing streamlined workflows with new widget state properties, dynamic view sizing, and improved form validation. But that’s not all — you’ll find flavor-conditional asset bundling, a preview of Vertex AI for Firebase in Dart, and updated DevTools to make your life easier.

In just a few months since our last update, we’ve merged an impressive 1595 pull requests from the Flutter community, with 37 new community members contributing to Flutter for the first time!

So, dive in and discover all the new features and enhancements that the Flutter community has brought to this latest release!

## WebAssembly

With the release of Flutter 3.22, Wasm is now available on the stable channel, offering significant performance improvements. In our internal benchmarks using Chrome on an M1 MacBook, the Wonderous app’s frame rendering time improved by 2x on average and 3x in worst-case scenarios.

<DashImage figure src="images/0x6HEkml8cFGc96hg.webp" />


These enhancements are vital for apps with animations and rich transitions, where maintaining a smooth frame rate is essential. Wasm helps achieve this by reducing performance bottlenecks, resulting in smoother animations and transitions. To start using Wasm with your Flutter web apps, check out our [Dart Wasm documentation](https://dart.dev/web/wasm) and [Flutter Wasm documentation](https://docs.flutter.dev/platform-integration/web/wasm). For the full announcement, visit the [Flutter at Google I/O blog post](https://medium.com/flutter/io24-5e211f708a37).

## Engine

Flutter 3.22 introduces significant updates to Impeller, the rendering engine that powers your Flutter applications. Key highlights include the completion of the Vulkan backend on Android for smoother graphics and improved performance, ongoing optimizations for blur effects and complex path rendering, and a new experimental API for testing with Impeller. In line with our [roadmap](https://github.com/flutter/flutter/wiki/Roadmap#core-framework--engine), we’re committed to enhancing Impeller’s quality and performance, including completing the iOS migration to Impeller and expanding Android support.

### Impeller

### **Vulkan backend feature complete on Android**

In this release, Impeller’s Vulkan backend for Android is feature complete. In particular, in the past few months, the team has been hard at work completing the implementation of [fast advanced blends](https://github.com/flutter/engine/pull/50154), support for custom fragment shaders with the [FragmentProgram API](https://github.com/flutter/engine/pull/49543), [PlatformView](https://github.com/flutter/engine/pull/50730) support (though it requires a [small API migration](https://docs.flutter.dev/release/breaking-changes/android-surface-plugins)), and fully implementing [all blur styles](https://github.com/flutter/flutter/issues/134178).

### Android preview

In the 3.19 stable release, after releasing improvements in Impeller’s OpenGL backend, we invited users to try out Impeller on Android devices both with and without Vulkan support. Over the past few months, after evaluating the performance of the OpenGL backend and estimating the remaining work on the Vulkan backend, we have decided to focus our efforts on making the Vulkan backend production ready first.

Impeller solves the issue of shader compilation jank. Additionally, in our benchmarks it outperforms the legacy renderer on average, 90th, and 99th percentile frame times. We therefore believe that the performance of the Vulkan backend on Android is acceptable. In this release (3.22), an app that opts-in to Impeller will use the Vulkan backend where available. In a future release, this will become the default. When an app that opts-in to Impeller runs on a device that doesn’t support Vulkan, Flutter will gracefully fall back automatically to using OpenGL ES with Skia. No action is necessary on your part. In the future, when we believe the OpenGL ES Impeller backend is production ready, this fallback will also use Impeller.

As the Impeller preview on Android continues through the 3.22 stable cycle, we request that Flutter developers upgrade to the latest stable version, and file issues about any shortcomings noticed when [Impeller is enabled](https://docs.flutter.dev/perf/impeller#android). Feedback at this stage is invaluable to ensuring that Impeller is successful on Android and that we will be able to confidently make it the default renderer in a release later this year. The Android hardware ecosystem is very diverse. For that reason, the most helpful feedback about Impeller should include detailed information about the specific device and Android version where issues occurred.

### Blur performance improvements

Blur has been [reimplemented](https://github.com/flutter/engine/pull/47576) in Impeller for both iOS and Android. In particular, the new approach, which is similar to Skia’s, reduces the CPU and GPU time of blurs by nearly half in [benchmarks](https://flutter-flutter-perf.skia.org/e/?begin=1699468487&end=1710262311&keys=X01fc3d52ebd6fbf38afef91d82ab8d2b&requestType=0&selected=commit%3D38815%26name%3D%252Carch%253Dintel%252Cbranch%253Dmaster%252Cconfig%253Ddefault%252Cdevice_type%253DiPhone_11%252Cdevice_version%253Dnone%252Chost_type%253Dmac%252Csub_result%253Daverage_frame_rasterizer_time_millis%252Ctest%253Dbackdrop_filter_perf_ios__timeline_summary%252C&xbaroffset=38815).

The chart below shows worst-case, 99%-ile, 90%-ile, and average frame rasterization times and GPU frame times in ms on an iPhone 11 device in a pathological benchmark intended to highlight blur performance. After rewriting Impeller’s blur, both the CPU and GPU cost of backdrop filter blurs has been nearly halved. This scale of this improvement translates to non-pathological cases as well, as would appear in typical apps.

<DashImage figure src="images/0mtFyiLoIUSqk_zRB.webp" alt="99%-ile, 90%-ile and average frame rasterization times and GPU frame times in ms on an iPhone 11 device in a pathological benchmark intended to highlight blur performance" caption="99%-ile, 90%-ile and average frame rasterization times and GPU frame times in ms on an iPhone 11 device in a pathological benchmark intended to highlight blur performance" />


### Stencil-then-Cover

Impeller on both iOS and Android has [moved to a new rendering strategy](https://github.com/flutter/engine/pull/51219) based on the Stencil-then-Cover approach described in the chapter “Drawing Filled, Concave Polygons Using the Stencil Buffer” in the [OpenGL Redbook](http://www.opengl-redbook.com/). Team members discussed more on this technique as it applies to Flutter in GitHub issue [#123671](https://github.com/flutter/flutter/issues/123671).

This approach solves the issue where the raster thread was spending too much time calculating tessellations for complex paths on the CPU for example, SVGs and [Lottie animations](https://github.com/flutter/flutter/issues/141961). After the change, the total frame time (UI thread on the CPU + raster thread on the CPU + GPU work) is much lower for frames that contain complex paths. Users will notice that Lottie animations and other complex paths render more smoothly, with lower CPU utilization, and slightly higher GPU utilization.

<DashImage figure src="images/11lCd7dBwJ0ab_sieDlQNFw.webp" alt="(Left) A Lottie animation. Previously, Impeller on a recent iPhone took 64ms / frame of raster thread CPU time to render it. (Right) The same animation on the same device after we landed the Stencil-then-Cover optimization. Raster times are nearly 10x faster." caption="(Left) A Lottie animation. Previously, Impeller on a recent iPhone took 64ms / frame of raster thread CPU time to render it. (Right) The same animation on the same device after we landed the Stencil-then-Cover optimization. Raster times are nearly 10x faster." />


While pleased with these improvements, there is still more work to do. Among other opportunities, we are aware that polyline generation remains prominent in CPU profiles, and we intend to investigate shifting this work to the GPU, as well.

### New API

While still experimental, flutter test now accepts the `--enable-impeller` flag, which exercises Impeller using the Vulkan backend.

## Framework

### Widget state properties

`MaterialState` has been moved outside of the Material library and renamed `WidgetState`, in order to make it available to Cupertino, the base Flutter framework, and package authors. For more information on migrating to the new WidgetState, see the [migration guide](https://docs.flutter.dev/release/breaking-changes/material-state).

### Dynamic view sizing

[Enhancements](https://github.com/flutter/flutter/pull/140918) to dynamic view sizing benefits developers building responsive layouts, ensuring better UI adaptability across various device screens.

### Improved form validation

Thanks to the [contributions](https://github.com/flutter/flutter/pull/135578) of Flutter community member [SharbelOkzan](https://github.com/SharbelOkzan), Flutter 3.22 comes with more flexible form validation methods allowing developers to create more robust user input handling, enhancing both usability and security.

### Covariants in 2D APIs

Reducing the need for type casts in 2D graphics APIs simplifies development workflows and enhances performance, important for games and complex animations.

### Flavor-conditional asset bundling

Developers using the [flavors](https://docs.flutter.dev/deployment/flavors) feature can now configure individual assets to be bundled only when building for a specific flavor. For more information, check out [Conditionally bundling assets based on flavor](https://docs.flutter.dev/deployment/flavors#conditionally-bundling-assets-based-on-flavor).

### Transformation of assets using Dart packages

Users can now configure Dart packages to transform their app’s assets as they are bundled. For more information, check out [Transforming assets at built time](http://docs.flutter.dev/ui/assets/asset-transformation).

## Android

### Deep linking

Deep links can significantly improve the user experience in your Flutter app, acting as shortcuts that seamlessly guide users to specific content within your app, boosting engagement, and driving sales. While Universal Links for iOS and App Links for Android are highly recommended for their security and user-friendly nature, setting them up can be a bit tricky.

In the last Flutter stable release, we introduced a deep link validator tool within DevTools that supports checking web configuration for Android apps. In this version, we added a new set of features to help verify setups within your Android manifest files.

For more information on using this tool, check out [Validate deep links](https://docs.flutter.dev/tools/devtools/deep-links).

### Predictive back gesture

Flutter now adds more support for Android’s upcoming predictive back feature, where users can peek at the previous route or even the previous app during a back gesture. This is still behind a feature flag on Android devices, but you can find details on how to try it out yourself [on GitHub](https://github.com/flutter/flutter/issues/132504#issuecomment-2025776552).

<DashImage figure src="images/08b6DxQuMXAyYVu-w.webp" />


<DashImage figure src="images/0hr_OF9DsfUcsLNHv.webp" />


### Flutter tool enforces version requirements on Gradle, AGP, Java, and Kotlin

In this release, the Flutter tool enforces a policy regarding the versions that it supports for Gradle, the Android Gradle Plugin (AGP), Java, and Kotlin. Initially, the tool only provides warnings.

Currently, the supported version ranges are as follows:

* Gradle — Fully supported 7.0.2 to current, warn otherwise

* AGP — Fully supported 7.0.0 to current, warn otherwise

* Java — Fully supported Java 11 to current, warn otherwise

* Kotlin — Fully supported 1.5.0 to current, warn otherwise

In the next major release these warnings will become errors, which can be overridden with the flag `--android-skip-build-dependency-validation`. More generally speaking, the tool provides a warning for at least one release before fully dropping support (generating an error) for a given version of these dependencies.

This policy was discussed in an [associated design spec](https://docs.google.com/document/d/1qeeM5QG-jiafttSgvc7yvC19IDRggFFZQTktBVxL6sI/edit?resourcekey=0-HLEAiBOMxAlQxDs-mEeffw). Comments and feedback are always welcome.

### Support for using Gradle Kotlin DSL in Gradle build scripts on Android

Gradle Kotlin DSL is now supported in Flutter, providing an alternative to the traditional Gradle Groovy DSL. This support allows for a better code editing experience, featuring auto-completion, quick access to documentation, source navigation, and context-aware refactoring.

This initial support was contributed by GitHub user [bartekpacia](https://github.com/bartekpacia). Developers can now choose to rewrite their Gradle build scripts in Kotlin to take advantage of these benefits, although the Flutter tool doesn’t yet allow for selecting Kotlin over Groovy when using `flutter create`.

For more details, check out the [PR 140744](https://github.com/flutter/flutter/pull/140744) by [bartekpacia](https://github.com/bartekpacia).

### Platform views improvements

**Heads up for all Flutter app developers**! If you’re using Flutter to build apps that rely on native Android components (like maps, web views, or certain UI elements), we have some important news.

Due to a bug in Android 14, apps built with older versions of Flutter might not work properly on devices running this new Android version.

Flutter 3.22 fixes this issue and improves the overall performance of these native components in your Android apps. So, to ensure your app runs smoothly on all Android devices, make sure to rebuild and release your app with Flutter 3.22.

This update also includes behind-the-scenes improvements to make platform views on Android more reliable and performant overall.

### End of support for KitKat

Flutter’s minimum supported Android version is now Lollipop (API 21). Beginning with Flutter’s 3.22 stable release, Flutter will no longer work on devices running Android KitKat (API 19). For more details, see our [deprecation guide](https://docs.flutter.dev/release/breaking-changes/android-kitkat-deprecation).

## iOS

### Platform view performance

We understand that platform view performance on iOS has been a pain point for many Flutter developers. This has been especially noticeable within scroll views when using platform views.

Recent updates directly address these concerns, with significant improvements in scenarios like embedding multiple inline ads within an article. Here are some key improvements [in our benchmark](https://github.com/flutter/flutter/pull/144745):

* **Reduced GPU usage:** GPU usage has been reduced by 50%, leading to less power consumption and a potentially smoother user experience.

* **Improved frame rendering:** Average frame render times have decreased by 1.66ms (33%).

* **Minimized jank:** Worst-case frame render times have been reduced by 3.8ms (21%).

If you’ve previously experienced performance challenges when using multiple platform views (like ads, maps, etc) within scrolling views, these optimizations offer the potential for a more fluid and responsive scrolling experience. Please give it a try and let us know what you think.

<DashImage figure src="images/0uk0URkHcImHdTq2M.webp" />


<DashImage figure src="images/0-KX8Ubw77KpdGnPI.webp" />


## Ecosystem

### Vertex AI for Firebase Dart SDK preview release

The Vertex AI for Firebase product has been released to public preview and includes the Dart SDK. This enables you to use the Gemini API to build generative AI features for your Dart or Flutter app, with production, performance and enterprise scale in mind. The SDK is integrated with [Firebase App Check](https://firebase.google.com/docs/app-check), which protects your API calls, and safeguards your backend infrastructure from serious threats like billing fraud, phishing, and app impersonation. Jump into the [Getting Started for Dart](https://firebase.google.com/docs/vertex-ai/get-started?platform=flutter) and start using it with no cost with a promo code

<DashImage figure src="images/0KmIhzrfoyskNW7r8.webp" />


The [Google AI Dart SDK](https://ai.google.dev/gemini-api/docs/get-started/dart) remains available, and is recommended for prototyping only. Google AI has free-of-charge access (within limits and where available) and pay-as-you-go pricing. If you have been prototyping with the Google AI Dart SDK, and are ready to migrate to Vertex AI for Firebase, check out the [migration guide](https://firebase.google.com/docs/vertex-ai/migrate-to-vertex-ai?platform=flutter).

### DevTools updates

We continue to improve DevTools, the suite of performance and debugging tools for Dart and Flutter. This release includes performance improvements, general polish, and new features like including CPU samples in the timeline, advanced filtering, and support for importing and exporting memory snapshots.

Other notable improvements were shipped with the `devtools_extensions` and `devtools_app_shared` packages that support DevTools extension authors. We added support for connecting an extension to the new Dart Tooling Daemon (DTD), which allows DevTools extensions to access public methods registered by other DTD clients, such as an IDE, as well as allowing access to a minimal file system API for interacting with the development project.

To learn more about all the updates included in Flutter 3.22 check out the release notes for DevTools [2.32.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.32.0), [2.33.0](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.33.0), and [2.34.1](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.34.1).

### Google Mobile Ads SDK for Flutter

For those of you monetizing your Flutter apps with Ads, we’ve got some exciting news: Google Mobile Ads for Flutter has just released a major update to version 5.0.1!

**Enhanced support for User Messaging Platform (UMP) SDK:** The update adds support for the latest APIs from the Android UMP SDK version 2.2.0 and iOS UMP SDK version 2.4.0. The UMP SDK is crucial for complying with privacy regulations, making it easier for you to obtain user consent for personalized ads. This new version introduces several new APIs to simplify the consent gathering process.

**Expanded mediation partners:** We’ve broadened your ad monetization horizons by offering integrations with popular ad partners, including [Unity](https://pub.dev/packages/gma_mediation_unity), [Meta](https://pub.dev/packages/gma_mediation_meta), [AppLovin](https://pub.dev/packages/gma_mediation_applovin), [Iron Source](https://pub.dev/packages/gma_mediation_ironsource), [Mintegral](https://pub.dev/packages/gma_mediation_mintegral), [Pangle](https://pub.dev/packages/gma_mediation_pangle), [DT Exchange](https://pub.dev/packages/gma_mediation_dtexchange), [InMobi](https://pub.dev/packages/gma_mediation_inmobi), and[ Liftoff.](https://pub.dev/packages/gma_mediation_liftoffmonetize) You can now maximize your app revenue with expanded mediation options and simplified implementation.

We encourage you to try out these new features in your Flutter apps and let us know which other mediation partners you’d like to see us support. Your feedback is invaluable as we continue to enhance the Google Mobile Ads SDK for Flutter.

## Breaking Changes and Deprecations

### Removal of v1 Android embedding

Deletion of version one of the Android embedding is under way. This will likely have no effect on most apps, as

1. Version two has been the default for many years

1. The Flutter tool would already block building version one apps, unless specifically overridden with the flag `-- ignore-deprecation`.

This release breaks Flutter tool support for v1 apps completely. **It is no longer possible to override.**

**Plugin authors, please note**: when the v1 android embedding was initially deprecated a migration doc was written for plugin authors at [https://docs.flutter.dev/release/breaking-changes/plugin-api-migration](https://docs.flutter.dev/release/breaking-changes/plugin-api-migration). As part of this migration, it was recommended that plugin authors keep support for apps using the v1 embedding, by including in their `*Plugin.java` a method with the signature

`public static void registerWith(@NonNull io.flutter.plugin.common.PluginRegistry.Registrar registrar)`

We plan to fully delete the v1 Android embedding in the next release, **at which point plugins that include a method with this signature will no longer compile** (as it makes reference to a type from the v1 android embedding).

It currently serves no purpose, as this release has broken apps using the v1 embedding. We recommend that plugin authors release updated versions of their plugins with the v1 code removed as soon as possible, to avoid breakage in future versions of Flutter. For an example, check out [PR 6494](https://github.com/flutter/packages/pull/6494), which removed the plugins maintained by the Flutter team.

### Deprecations removed in 3.22

[Breaking changes](https://docs.flutter.dev/release/breaking-changes) in this release include deprecated APIs that expired after the release of v3.19. To see all affected APIs, along with additional context and migration guidance, see the [deprecation guide for this release](https://docs.flutter.dev/release/breaking-changes/3-19-deprecations). Many of these are supported by [Flutter fix](https://docs.flutter.dev/development/tools/flutter-fix), including quick fixes in the IDE. Bulk fixes can be evaluated and applied with the `dart fix` command-line tool.

As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md) — these help us identify these breaking changes. To learn more, check out [Flutter’s breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

## Conclusion

At the heart of Flutter’s success is you — our amazing community. This release wouldn’t be possible without your countless contributions and unwavering passion. From the bottom of our hearts, thank you.

Ready to explore Flutter 3.22? Dive into the full release notes and changelog, fire up your terminal, and run `flutter upgrade`. We can’t wait to see what you build!