---
title: "What’s new in Flutter 2.5"
description: >-
  Performance improvements, DevTools updates, new Material You support, a new
  app template, and more!
publishDate: 2021-09-08
author: csells
image: images/0esYsdKzKL64130ln.webp
category: release
layout: blog
---

Hello and welcome to Flutter 2.5! This is a big release, with the 2nd highest stats in the history of Flutter releases: 4600 issues closed and 3932 PRs merged from 252 contributors with 216 reviewers. If we look back over the last year, we see a huge 21,072 PRs created by 1337 contributors, of which 15,172 of them were merged. While the “what’s new in Flutter” blog posts focuses on new features, our #1 job with Flutter is always making sure you have the features you need at the highest possible quality level.

And in fact, this release continues a number of important performance and tooling improvements to track down performance problems in your own app. At the same time, there are a number of new features, including full screen support for Android, more Material You (also called v3) support, updated text editing to support switchable keyboard shortcuts, a new, more detailed look at your widgets in the Widget Inspector, new support for adding dependencies in your Visual Studio Code projects, new support for getting coverage information from your test runs in IntelliJ/Android Studio and a whole new app template to serve as a better foundation for your real-world Flutter apps. This release is jam-packed with exciting new updates, so let’s get started.

## Performance: iOS shader warmup, async tasks, GC & message passing

This release comes with several performance improvements. First on this list is a PR to wire up Metal shader precompilation from offline training runs ([#25644](https://github.com/flutter/engine/pull/25644)), which (as our benchmarks show) cuts worst case frame rasterization times by 2/3s, and the 99th percentile frame by half. We continue to make progress on reducing iOS jank and this is another step along that path. Shader warmup is but one source of jank, however. Previously, processing asynchronous events from the network, filesystem, plugins, or other isolates could interrupt animations, another source of jank. Following improvements to scheduling policies ([#25789](https://github.com/flutter/engine/pull/25789)) on the UI isolate’s event loop in this release, frame processing now takes priority over processing other asynchronous events, eliminating jank from this source in our testing.

<DashImage figure src="images/04O_Zg7UAwbnGissJ.webp" alt="*Frame lag due to processing asynchronous event results before and after*" caption="*Frame lag due to processing asynchronous event results before and after*" />

Another cause of jank is when the garbage collector (GC)pauses the UI thread to reclaim memory. Previously, memory for some images would only be reclaimed lazily in response to GC performed by the Dart VM. As a workaround in earlier releases, the Flutter Engine would hint to the Dart VM that image memory could be reclaimed by a GC, which in theory could lead to more timely memory reclamation. Unfortunately, in practice this led to too many major GCs, and the memory would still sometimes not be reclaimed quickly enough to avoid low-memory situations on memory constrained devices. In this release, memory for unused images is reclaimed eagerly ([#26219](https://github.com/flutter/engine/pull/26219), [#82883](https://github.com/flutter/flutter/pull/82883), [#84740](https://github.com/flutter/flutter/pull/84740)), reducing GCs considerably.

<DashImage figure src="images/0OJrGTdsznMa2N0DI.webp" alt="*GCs before and after adding the fix to eagerly reclaim unused large image memory*" caption="*GCs before and after adding the fix to eagerly reclaim unused large image memory*" />

For example, in one of our tests, playing a 20 second animated GIF went from needing 400+ GCs to needing just 4. Fewer major GCs means that animations involving images appearing and disappearing will have less jank, and consume less CPU and power.

Another performance improvement in Flutter 2.5 is the latency when sending messages between Dart and Objective-C/Swift (iOS) or Dart and Java/Kotlin (Android). As part of [tuning-up](https://docs.google.com/document/d/1oNLxJr_ZqjENVhF94-PqxsGPx0qGXx-pRJxXL6LSagc/edit#heading=h.9gabvat7tlxf) message channels generally, removing unnecessary copies from messaging codecs reduced latencies by up to 50% depending on message size and device ([#25988](https://github.com/flutter/engine/pull/25988), [#26331](https://github.com/flutter/engine/pull/26331)).

<DashImage figure src="images/0TvARS8SsME4sl-Ib.webp" alt="*iOS message latencies before and after*" caption="*iOS message latencies before and after*" />

You can read more about the details of this work in the [Improving Platform Channel Performance in Flutter](https://medium.com/flutter/improving-platform-channel-performance-in-flutter-e5b4e5df04af) blog post by Aaron Clarke.

One final performance update if you’re targeting iOS: In this release, Flutter apps built on on Apple Silicon M1 Macs run natively on ARM iOS simulators ([#pull/85642](https://github.com/flutter/flutter/pull/85642)). This means there’s no Rosetta translation between the Intel x86_64 instructions and ARM, which increases performance during your iOS app testing and allows you to avoid some subtle Rosetta issues ([#74970](https://github.com/flutter/flutter/issues/74970#issuecomment-858170914), [#79641](https://github.com/flutter/flutter/issues/79641)). This is another step along the path for full support in Flutter for Apple Silicon. Stay tuned for more.

## Dart 2.14: formatting, language features, pub & linting out-of-the-box

Of course, Flutter isn’t Flutter without the Dart language and runtime on which it builds. This release of Flutter comes with Dart 2.14. [The new release of Dart](https://medium.com/@mit.mit/announcing-dart-2-14-b48b9bb2fb67) comes with new formatting to make [cascades](https://dart.dev/guides/language/language-tour#cascade-notation) more clear, new pub support for ignoring files, and new language features, including the return of the legendary triple shift operator. In addition, and one of the best things about Dart 2.14, is that this release has created a standard set of lints shared between new Dart and Flutter projects that come right out of the box.

<DashImage figure src="images/0CNbVsc26rivkp2vI.webp" alt="*`flutter create` comes out of the box with an analysis_options.yaml file pre-populated with recommended Flutter lints*" caption="*`flutter create` comes out of the box with an analysis_options.yaml file pre-populated with recommended Flutter lints*" />

Not only do you get these lints when you create a new Dart or Flutter project, but with [just a few steps](https://flutter.dev/docs/release/breaking-changes/flutter-lints-package#migration-guide), you can add this same analysis to your existing apps as well. For the details of these lints, the new language features and more, check out [the release announcement for Dart 2.14](https://medium.com/dartlang/announcing-dart-2-13-c6d547b57067).

## Framework: Android full screen, Material You & text editing shortcuts

The Flutter 2.5 release includes a number of fixes and improvements to the framework. Starting with [Android, we’ve fixed a set of related issues around full screen modes](https://github.com/flutter/flutter/pull/81303) with nearly 100 thumbs up between them. The names of the modes themselves makes this one of our favorite new features: *lean back, sticky, sticky immersive, and edge to edge*. This change also added a way to listen to fullscreen changes in the other modes. For example, if the user engages with the app, when the system UI comes back, developers can now write their code to return to fullscreen or do something else.

<DashImage figure src="images/0-5pu9nXQw88jixos.webp" alt="*New Android edge-to-edge mode: normal mode (left), Edge to Edge mode (center), Edge to Edge with a custom SystemUIOverlayStyle (right)*" caption="*New Android edge-to-edge mode: normal mode (left), Edge to Edge mode (center), Edge to Edge with a custom SystemUIOverlayStyle (right)*" />

In this release, we continue to build support for the new Material You (aka v3) specification, including updates to floating action button sizes and theming ([#86441](https://github.com/flutter/flutter/pull/86441)), and a new `MaterialState.scrolledUnder` state that you can see in action with the sample code in the PR ([#79999](https://github.com/flutter/flutter/pull/79999)).

<DashImage figure src="images/07ivd_3xtI3uaZ4nO.webp" alt="*New Material You FAB sizes*" caption="*New Material You FAB sizes*" />

<DashImage figure src="images/1uTH_ZL2MFJSlPvhuZ81o5A.webp" alt="*New MaterialState.scrolledUnder state in action*" caption="*New MaterialState.scrolledUnder state in action*" />

And while we’re talking about scrolling, another improvement is the addition of scroll metrics notifications ([#85221](https://github.com/flutter/flutter/pull/85221), [#85499](https://github.com/flutter/flutter/pull/85499)), which provide notifications of scrollable areas even if the user isn’t scrolling. For example, the following shows the scrollbar appearing or disappearing as appropriate based on the underlying size of the `ListView`:

<DashImage figure src="images/011VHtSVUTukATeQN.webp" alt="*The new scroll metrics notifications enabling the scrollbar to appear and disappear automatically without scrolling*" caption="*The new scroll metrics notifications enabling the scrollbar to appear and disappear automatically without scrolling*" />

In this case, you don’t have to write any code but if you want to capture the [`ScrollMetricNotification`](https://master-api.flutter.dev/flutter/widgets/ScrollMetricsNotification-class.html) changes, you can. Special thanks goes out to community contributor [xu-baolin](https://github.com/xu-baolin) who worked hard on this and came up with a great solution.

Another excellent contribution from the community is the addition of Material banner support to the `ScaffoldMessenger`. You may remember the `ScaffoldMessenger` from [the Flutter 2.0 release announcement](https://medium.com/flutter/whats-new-in-flutter-2-0-fe8e95ecc65) as a more robust way to show `SnackBars` at the bottom of the screen to provide users with notifications. In Flutter 2.5, you can now add a banner to the top of your scaffold that stays in place until the user dismisses it.

<DashImage figure src="images/0WnLtflm5SF1I9GxK.webp" />

Your app can get this behavior by calling the `showMaterialBanner` method of `ScaffoldMessenger`:

```dart
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('The MaterialBanner is below'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Show MaterialBanner'),
            onPressed: () => ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                content: const Text('Hello, I am a Material Banner'),
                leading: const Icon(Icons.info),
                backgroundColor: Colors.yellow,
                actions: [
                  TextButton(
                    child: const Text('Dismiss'),
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

```

The [Material guidelines for banners](https://material.io/components/banners#usage) state that your app should show only one at a time, so if your app calls `showMaterialBanner` more than once, the `ScaffoldMessenger` will maintain a queue, showing each new banner as the previous one is dismissed. Thanks to [Calamity210](https://github.com/Calamity210) for this great addition to the Material support in Flutter!

Building further on Flutter 2.0 and its new text editing features, like text selection pivot points and being able to stop propagation of a keyboard event once it’s been handled, in this release, we’ve added the ability to make text editing keyboard shortcuts overridable ([#85381](https://github.com/flutter/flutter/pull/85381)). If you want **Ctrl-A** to do something custom instead of selecting all text, you can do that. The [`DefaultTextEditingShortcuts`](https://github.com/flutter/flutter/blob/b524270af147847f64fa296cf6eed3633ffe683d/packages/flutter/lib/src/widgets/default_text_editing_shortcuts.dart#L163) class contains a list of every keyboard shortcut supported by Flutter on each platform. If you want to override anything, use Flutter’s existing [`Shortcuts`](https://api.flutter.dev/flutter/widgets/Shortcuts-class.html) widget to remap any shortcut to an existing or custom intent. You can place that widget anywhere in your widget tree where you want the override to apply. Check out some examples in the [API reference](https://api.flutter.dev/flutter/widgets/DefaultTextEditingShortcuts-class.html).

## Plugins: camera, image picker & plus plugins

Another plugin that’s seen a lot of improvements is [the camera plugin](https://pub.dev/packages/camera):

* [3795](https://github.com/flutter/plugins/pull/3795) [camera] android-rework part 1: Base classes to support Android Camera features

* [3796](https://github.com/flutter/plugins/pull/3796) [camera] android-rework part 2: Android auto focus feature

* [3797](https://github.com/flutter/plugins/pull/3797) [camera] android-rework part 3: Android exposure related features

* [3798](https://github.com/flutter/plugins/pull/3798) [camera] android-rework part 4: Android flash and zoom features

* [3799](https://github.com/flutter/plugins/pull/3799) [camera] android-rework part 5: Android FPS range, resolution and sensor orientation features

* [4039](https://github.com/flutter/plugins/pull/4039) [camera] android-rework part 6: Android exposure- and focus point features

* [4052](https://github.com/flutter/plugins/pull/4052) [camera] android-rework part 7: Android noise reduction feature

* [4054](https://github.com/flutter/plugins/pull/4054) [camera] android-rework part 8: Supporting modules for final implementation

* [4010](https://github.com/flutter/plugins/pull/4010) [camera] Do not trigger flat device orientation on iOS

* [4158](https://github.com/flutter/plugins/pull/4158) [camera] Fix coordinate rotation for setting focus- and exposure points on iOS

* [4197](https://github.com/flutter/plugins/pull/4197) [camera] Fix camera preview not always rebuilding on orientation change

* [3992](https://github.com/flutter/plugins/pull/3992) [camera] Prevent crash when setting unsupported FocusMode

* [4151](https://github.com/flutter/plugins/pull/4151) [camera] Introduce camera_web package

There’s also been a lot of work on [the image_picker plugin](https://pub.dev/packages/image_picker) focusing on the end-to-end camera experience:

* [3898](https://github.com/flutter/plugins/pull/3898) [image_picker] Image picker fix camera device

* [3956](https://github.com/flutter/plugins/pull/3956) [image_picker] Change storage location for camera captures to internal cache on Android, to comply with new Google Play storage requirements

* [4001](https://github.com/flutter/plugins/pull/4001) [image_picker] Removed redundant request for camera permission

* [4019](https://github.com/flutter/plugins/pull/4019) [image_picker] Fix rotation when camera is a source

This work improves the functionality and robustness of the camera and image_picker plugins for Android. In addition, you’ll notice an early version of the [camera plugin](https://pub.dev/packages/camera_web) is available with web support ([#4151](https://github.com/flutter/plugins/pull/4151)). This preview provides basic support for viewing camera preview, taking a picture, using flash and zoom controls, all on the web. It is currently not an [endorsed plugin](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#endorsed-federated-plugin), so you will need to [add it explicitly](https://pub.dev/packages/camera_web/install) to be used in your web app.

The initial Android camera rewrite work was contributed by [acoutts](https://github.com/acoutts). The camera and image_picker work was landed by [Baseflow](https://www.baseflow.com/open-source/flutter), a consulting firm specializing in Flutter and well-known for [their own packages on pub.dev](https://pub.dev/publishers/baseflow.com/packages). The camera_web work was largely done by [Very Good Ventures](https://verygood.ventures/), a US-based Flutter consulting firm. Many thanks to all of you for your contributions to the Flutter community!

Another valuable community contribution is by the Flutter Community organization, known for [the “plus” plugins](https://plus.fluttercommunity.dev/). With this release of Flutter, each of the corresponding plugins from the Flutter team now carry a recommendation just like this one for [battery](https://pub.dev/packages/battery):

<DashImage figure src="images/0rvrCGEZ-vkRxga-n.webp" />

Furthermore, since these plugins are no longer actively maintained, they are no longer marked as Flutter Favorite plugins. If you haven’t already done so, we recommend moving to the plus versions of the following plugins:

<DashImage figure src="images/1YX-xNXUTKnNuZNBAmt7CAQ.webp" />

## Flutter DevTools: performance, Widget inspector, & polish

This release of Flutter comes with a number of improvements to Flutter DevTools. First and foremost is the added support in DevTools to take advantage of engine updates ([#26205](https://github.com/flutter/engine/pull/26205), [#26233](https://github.com/flutter/engine/pull/26233), [#26237](https://github.com/flutter/engine/pull/26237), [#26970](https://github.com/flutter/engine/pull/26970), [#27074](https://github.com/flutter/engine/pull/27074), [#26617](https://github.com/flutter/engine/pull/26617)). One set of these updates enables Flutter to do a better job of associating trace events with specific frames, which helps developers to determine why a frame might be going over budget. You can see this reflected in the DevTools Frames chart that has been rebuilt to be “live”; frames are populated in this chart as they are rendered in your app. Selecting a frame from this chart navigates to the timeline events for that frame:

<DashImage figure src="images/08evmW5s37nGUIc98.webp" />

The Flutter engine now also identifies shader compilation events in the timeline. Flutter DevTools uses these events to help you diagnose shader compilation jank in your app.

<DashImage figure src="images/0esYsdKzKL64130ln.webp" alt="DevTools detecting lost frames due to shader compilation" caption="DevTools detecting lost frames due to shader compilation" />

With this new feature, DevTools detects when you’ve lost frames to shader compilation so that you can fix the issue. To run your app as if it’s the first time (before your shader cache has been populated as it would be for any user), use `flutter run` with the `--purge-persistent-cache` flag. This clears the cache to ensure you are reproducing the environment that users see for the “first run” or “re-open” (iOS) experience. This feature is still under development, so please [file issues](https://b.corp.google.com/issues/new?component=775375&template=1369639) for problems you find, or for any improvements we can make to help debug shader compilation jank.

In addition, when you’re tracking down CPU performance issues in your app, you may have been swamped in profiling data from Dart and Flutter libraries and/or the native code of the engine. If you’d like to turn any of these off to focus on your own code, you can do that with the new CPU Profiler feature ([#3236](https://github.com/flutter/devtools/pull/3236)) that enables you to hide profiler information from any of these sources.

<DashImage figure src="images/0IzjrKssfjooCGzKm.webp" />

For any of the categories you don’t filter out, they’ve now been color-coded ([#3310](https://github.com/flutter/devtools/pull/3310), [#3324](https://github.com/flutter/devtools/pull/3324)) so that you can easily see what parts of the CPU Frame Chart come from what parts of the system.

<DashImage figure src="images/0ewigNSGco1ozScc0.webp" alt="Colored frame chart to identify app vs. native vs. Dart vs. Flutter code activities in your app" caption="Colored frame chart to identify app vs. native vs. Dart vs. Flutter code activities in your app" />

Performance isn’t the only thing that you’ll want to debug. This release of DevTools comes with an update to the Widget Inspector that allows you to hover over a widget to evaluate the object, view properties, widget state, and so on.

<DashImage figure src="images/0cLXjl-F3Vj0bFkKg.webp" />

And, when you select a widget, it automatically populates in the new Widget Inspector Console, where you can explore the widget’s properties.

<DashImage figure src="images/0l8XoqqLcz6W0CkRE.webp" />

When paused at a breakpoint, you can also evaluate expressions from the console.

In addition to the new features, the Widget Inspector has undergone a facelift. To make DevTools a more useful destination for understanding and debugging your Flutter apps, we partnered with [Codemate](https://codemate.com), a creative tech agency in Finland, to make some updates.

<DashImage figure src="images/0iN9uTsyfsUOt8cTw.webp" alt="Flutter DevTools polished UX for greater ease of use" caption="Flutter DevTools polished UX for greater ease of use" />

In this screenshot, you can see the following changes:

* **Better communicating what the debug toggle buttons do** — those buttons have new icons, task-oriented labels, as well as rich tooltips that describe what they do and when to use them. Each tooltip further links out to detailed documentation of the feature.

* **Easier to scan and locate widgets of interest** — frequently used widgets from the Flutter framework now show icons in the widget tree view on the left hand side of the inspector. They’re further color coded based on their categories. For example, layout widgets are displayed in blue while content widgets are displayed in green. Furthermore, each Text widget now shows a preview of its content.

* **Aligning the color scheme of the layout explorer and the widget tree** — it’s now easier to identify the same widget from the layout explorer and the widget tree. For example, the “Column” widget in the screenshot below is on a blue background in the layout explorer, and it has a blue icon in the widget tree view.

We’d love to [hear your thoughts](https://github.com/flutter/devtools/issues) about any issues that stem from these updates or any other improvements we can make to ensure that DevTools works great. And these highlights are just the start. For a full list of what’s new in DevTools with this release of Flutter, check out the release notes:

* [Flutter DevTools 2.3.2 Release Notes](https://groups.google.com/g/flutter-announce/c/LSNbc2rKIjQ/m/7Y7cWgO2CQAJ)

* [Flutter DevTools 2.4.0 Release Notes](https://groups.google.com/g/flutter-announce/c/qenYe5LuHb8/m/tkWcBCVaAQAJ)

* [Flutter DevTools 2.6.0 Release Notes](https://groups.google.com/g/flutter-announce/c/yBEZOWdV9nc/m/KCX3m2BpCAAJ)

## IntelliJ/Android Studio: integration tests, test coverage, and icon previews

The IntelliJ/Android Studio plugin for Flutter has also undergone a number of improvements with this release, starting with the ability to run integration tests ([#5459](https://github.com/flutter/flutter-intellij/pull/5459)). Integration tests are whole-app tests that run on a device, live in the integration_test directory and use the same `testWidgets()` functionality from widget unit tests.

<DashImage figure src="images/0kTKO_OcWee8OS0Lo.webp" alt="Integration testing your Flutter app in IntelliJ/Android Studio" caption="Integration testing your Flutter app in IntelliJ/Android Studio" />

To add an integration test to your project, [follow the instructions on flutter.dev](https://flutter.dev/docs/testing/integration-tests). To connect the test with IntelliJ or Android Studio, add a run configuration that launches the integration tests and connect a device for the test to use. Running the configuration allows you to run the test, including setting breakpoints, stepping, etc.

In addition, the latest IJ/AS plugin for Flutter allows you to see the coverage information for both unit test and integration test runs. You can access this from the toolbar button next to the “Debug” button:

<DashImage figure src="images/0vxdeNoUw3boFaeFu.webp" />

Coverage info is displayed using red and green bars in the gutter of the editor. In this example, lines 9–13 were tested, but lines 3 and 4 were not.

<DashImage figure src="images/0G5M8qrjxw3gyeT7a.webp" />

The latest release also includes the new ability to preview icons used from packages from pub.dev built around TrueType font files ([#5504](https://github.com/flutter/flutter-intellij/pull/5504), [#5595](https://github.com/flutter/flutter-intellij/pull/5595), [#5677](https://github.com/flutter/flutter-intellij/pull/5677), [#5704](https://github.com/flutter/flutter-intellij/pull/5704)), just as the Material and Cupertino icons support previewing.

<DashImage figure src="images/0TK2px5OYQ_ggn2jx.webp" alt="Icon preview in IntelliJ/Android Studio" caption="Icon preview in IntelliJ/Android Studio" />

To enable icon previews you need to tell the plugin which packages you are using. There is a new text field in the plugin settings/preferences page:

<DashImage figure src="images/0GTrbuGlv9G-YPvOi.webp" />

Note that this works for icons defined as static constants in a class, as shown in the sample code in the screen shot. It won’t work for expressions, such as `LineIcons.addressBook()` or `LineIcons.values['code']`. If you are the author of an icon package that does NOT work with this feature, please create an [issue](https://github.com/flutter/flutter-intellij/issues).

That are lots more updates for the IntelliJ/Android Studio plugin for Flutter that you can read about in the release notes:

* [Flutter IntelliJ Plugin M57 Release](https://groups.google.com/g/flutter-announce/c/nZPj0uIW3h4/m/2Xnx8KQtAwAJ)

* [Flutter IntelliJ Plugin M58 Release](https://groups.google.com/g/flutter-announce/c/WJUH0m6cu-U/m/_n0RltLFAAAJ)

* [Flutter IntelliJ Plugin M59 Release](https://groups.google.com/g/flutter-announce/c/CNzqxtybpBA/m/nSu7QabMAQAJ)

* [Flutter IntelliJ Plugin M60 Release](https://groups.google.com/g/flutter-announce/c/qc40yulxvAg/m/B_1HuGmoBQAJ)

## Visual Studio Code: dependencies, Fix All, and Test Runner

The Visual Studio Code plugin for Flutter has also improved in this release, beginning with two new commands “Dart: Add Dependency” and “Dart: Add Dev Dependency” ([#3306](https://github.com/Dart-Code/Dart-Code/issues/3306), [#3474](https://github.com/Dart-Code/Dart-Code/issues/3474)).

<DashImage figure src="images/0S8Nl6GbXHBHV64Rr.webp" alt="Adding a Dart dependency in Visual Studio Code" caption="Adding a Dart dependency in Visual Studio Code" />

These commands provide functionality like [the Pubspec Assist plugin by Jeroen Meijer](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist) has been providing for awhile now. These new commands come right out of the box and provide a type-to-filter list of packages periodically fetched from pub.dev.

You may also be interested in the “Fix All” command ([#3445](https://github.com/Dart-Code/Dart-Code/issues/3445), [#3469](https://github.com/Dart-Code/Dart-Code/issues/3469)) that’s available for Dart files and can fix all of the same issues as [dart fix](https://dart.dev/tools/dart-fix) for the current open file in one step.

<DashImage figure src="images/0dzvJ63ojTXw-Grsu.webp" alt="Using Flutter Fix rules to fix all known issues in your code" caption="Using Flutter Fix rules to fix all known issues in your code" />

This can also be set to run on-save by adding `source.fixAll` to the `editor.codeActionsOnSave` VS Code setting.

Or, if you’d like to give the preview feature a try, you can enable the `dart.previewVsCodeTestRunner` setting and see Dart and Flutter tests run via the new Visual Studio Code test runner.

<DashImage figure src="images/0chKF4N2FzPBN3R3G.webp" alt="Using the new Visual Studio Code test runner test your Dart and Flutter code" caption="Using the new Visual Studio Code test runner test your Dart and Flutter code" />

The Visual Studio Code test runner looks a little different than the current Dart and Flutter test runner and will persist results across sessions. The Visual Studio Code test runner also adds new gutter icons showing the last state of a test that can be clicked to run the test (or right-clicked for a context menu).

<DashImage figure src="images/0snvlKGuZPa9zHFBc.webp" />

In coming releases, the existing Dart and Flutter test runner will be removed in favor of the new Visual Studio Code test runner.

And this is just the tip of the iceberg with new Visual Studio Code features and fixes. For all of the details, check out the release notes:

* [v3.26](https://dartcode.org/releases/v3-26/) VS Code Test Runner integration, Flutter Create Settings, …

* [v3.25](https://dartcode.org/releases/v3-25/) Additional Dependency Management improvements, Fix All in File / On-Save, …

* [v3.24](https://dartcode.org/releases/v3-24/) Dependencies tree improvements, Easier launch configurations, Editor improvements

* [v3.23](https://dartcode.org/releases/v3-23/) Profile Mode improvements, Improved dependencies tree, LSP improvements

## Tools: exceptions, new app template & Pigeon 1.0

In previous versions of Flutter, you may have been frustrated by exceptions that you expected to be unhandled so that you could trigger the debugger and figure out where they originated only to find that the Flutter framework did not let the exception through to trigger the “unhandled expectation” handler in your debugger. In this release, debuggers now break correctly on unhandled exceptions that previously were just caught by the framework ([#17007](https://github.com/flutter/flutter/issues/17007)). This improves the debugging experience as your debugger can now point you directly to the throwing line in their code instead of pointing to a random line deep in the framework. A related new feature enables you to decide if a FutureBuilder should rethrow or swallow errors ([#84308](https://github.com/flutter/flutter/pull/84308)). This should give you a large number of additional exceptions to help track down the issues in your Flutter apps.

Since the dawn of Flutter, there has been the Counter app template, which has many good qualities: it shows off many features of the Dart language, demonstrates several key Flutter concepts and it’s small enough to fit into a single file, even with a lot of explanatory comments. However, what it doesn’t do is provide a particularly good jumping off point for a real-world Flutter app. In this release, there’s a new template ([#83530](https://github.com/flutter/flutter/pull/83530)) available via the following command:

`$ flutter create -t skeleton my_app`

<DashImage figure src="images/03utkTiVxsZOcvcKl.webp" alt="*The new Flutter skeleton template in action*" caption="*The new Flutter skeleton template in action*" />

The skeleton template generates a two-page List View Flutter app (with Detail View) that follows community best practices. It was developed with a great deal of internal and external review to provide a better base on which to build a production quality app and supports the following features:

* Uses `ChangeNotifier` to coordinate multiple widgets

* Generates localizations by default using arb files

* Includes an example image and establishes 1x, 2x, and 3x folders for image assets

* Uses a “feature-first” folder organization

* Supports shared preferences

* Supports light and dark theming

* Supports navigation between multiple pages

Over time, as Flutter best practices evolve, expect this new template to evolve with them.

If, on the other end of the spectrum, you’re developing a plugin and not an app, you may be interested in the 1.0 release of Pigeon. Pigeon is a codegen tool for generating typesafe interop code between Flutter and its host platform. It allows you to define a description of your plugin’s API and generate skeleton code for Dart, Java, and Objective-C (which are accessible to Kotlin and Swift, respectively).

<DashImage figure src="images/0CfaqXymLvWZc6Cqo.webp" alt="Sample generated Pigeon code" caption="Sample generated Pigeon code" />

Pigeon is already used in some of the plugins from the Flutter team. With this release, which provides more helpful error messages, added support for generics, primitive data types as arguments and return types, and multiple arguments, expect it to be used more heavily in the future. If you’d like to take advantage of Pigeon in your own plugin or add-to-app projects, you can find out more information at [the pigeon plugin page](https://pub.dev/packages/pigeon).

## Breaking changes & deprecations

The following are the breaking changes in the Flutter 2.5 release:

* [Default drag scrolling devices](https://flutter.dev/docs/release/breaking-changes/default-scroll-behavior-drag)

* [Deprecated API removed after v2.2](https://flutter.dev/docs/release/breaking-changes/2-2-deprecations)

* [Introducing package:flutter_lints](https://flutter.dev/docs/release/breaking-changes/flutter-lints-package)

* [ThemeData’s accent properties have been deprecated](https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties)

* [GestureRecognizer Cleanup](https://flutter.dev/docs/release/breaking-changes/gesture-recognizer-add-allowed-pointer)

* [Replace AnimationSheetBuilder.display with collate](https://flutter.dev/docs/release/breaking-changes/animation-sheet-builder-display)

* [Using HTML slots to render platform views in the web](https://flutter.dev/docs/release/breaking-changes/platform-views-using-html-slots-web)

* [Migrate LogicalKeySet to SingleActivator](https://github.com/flutter/flutter/pull/80756)

For the full list of breaking changes since the 1.17 release, [see flutter.dev](https://flutter.dev/docs/release/breaking-changes).

As we continue to update Flutter Fix (available in your IDE and via the `dart fix` command), we have a grand total of 157 rules to automatically migrate your code affected by these or past breaking changes, as well as any deprecations. As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md), they help us identify these breaking changes. To learn more, check out [our breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

Also, with the Flutter 2.5 release, we are deprecating support for iOS 8 [as announced in Sept, 2020](https://flutter.dev/go/rfc-ios8-deprecation). Dropping support for iOS 8, which has less than 1% market share, allows the Flutter team to focus on new platforms in wider usage. Deprecation means that these platforms may work but that we will not test new versions of Flutter or the plugins on these platforms. You can see the list of [currently supported Flutter platforms on flutter.dev](https://flutter.dev/docs/development/tools/sdk/release-notes/supported-platforms).

## Summary

In closing, thank you as always to the Flutter community around the world that makes all of this possible. To the hundreds of developers who have contributed and reviewed the 1000s of PRs in this update, here’s to the fruits of each of your efforts. Together, we’re working to transform the app development process for developers around the world so you can ship more, faster, deploying to the platforms you care about from a single codebase.

Stay tuned for more updates from all of us on the Flutter team at Google. The year is not over yet!
