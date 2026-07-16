---
title: "Announcing Flutter 1.20"
description: "Performance improvements, mobile autofill, a new widget and more!"
publishDate: 2020-08-05
author: csells
image: images/0Ve1UjCRej9MtX2kv.webp
category: release
layout: blog
---

Our ongoing vision with Flutter is to provide a portable toolkit for building stunning experiences wherever you might want to paint pixels on the screen. With every release, we continue to push towards ensuring that Flutter is fast, beautiful, productive and open for every platform we support. In Flutter 1.20, which is released today to our stable channel, Flutter has improvements for every one of these four pillars.

In the category of *fast*, we’ve got multiple performance improvements, from the lowest levels of the rendering engine and in the Dart language itself.

To enable you to build Flutter apps that are ever more *beautiful*, this release has several UI enhancements, including the long-awaited support for autofill, a new way to layer your widgets to support pan and zoom, new mouse cursor support, updates to old favorite Material widgets (such as the time and date pickers), and a whole new responsive license page for the About box in your desktop and mobile form-factor Flutter apps.

To make sure that you continue to be more *productive*, we’ve got updates to the [Flutter extension for Visual Studio Code](https://dartcode.org/) that brings Dart DevTools directly into your IDE, automatically updating your import statements as you move your files around and a new set of metadata for building your own tools.

And it’s because of Flutter’s *openness* and amazing community contributors that this release includes 3,029 merged PRs and 5,485 closed issues from 359 contributors from around the world, including 270 contributors from the Flutter community at large. In fact, this marks the largest number of contributors we’ve ever had for a Flutter release. Special shoutout to community contributor [CareF](https://github.com/CareF) for 28 PRs, [AyushBherwani1998](https://github.com/AyushBherwani1998) for 26 PRs, including 10 to the Flutter samples as part of his Google Summer of Code project, and [a14n](https://github.com/a14n) for 13 PRs, many of which are in service of landing null safety for Flutter (more on that topic soon!). We couldn’t create Flutter without a broad team of community contributors, so thank you!

Each new release of Flutter brings with it increased usage and momentum. In fact, in April, [we reported](https://medium.com/flutter/flutter-spring-2020-update-f723d898d7af) that the number of Flutter apps in the Google Play store had reached 50,000, with a peak rate of 10,000 new apps/month. Now, just over three months later, there are more than 90,000 Flutter apps in Google Play. We’re seeing a lot of this growth in India, which is now the #1 region for Flutter developers, having doubled in the last six months, which aligns well with [Google’s increased investment](https://www.businessinsider.com/google-alphabet-india-health-agriculture-education-tech-ai-sundar-pichai-2020-7) in that region. And finally, Flutter isn’t Flutter without Dart, so it’s great to see the that [the IEEE has reported that Dart has moved up 4 slots since last year to be #12](https://spectrum.ieee.org/static/interactive-the-top-programming-languages-2020) in the top 50 languages that they track.

## Performance improvements for Flutter and Dart

On the Flutter team, we’re always looking for new ways to decrease the size and latency of your app. As an example of the former, this release fixes [a tooling performance issue with icon font tree shaking](https://github.com/flutter/flutter/pull/55417) and [makes font tree shaking the default behavior](https://github.com/flutter/flutter/pull/56633) when building your non-web apps. Icon font tree shaking removes the icons that you’re not using in your app, thus reducing the size. Using this against the Flutter Gallery app, we found that it [reduced the app size by 100kb](https://github.com/flutter/flutter/pull/49737). Now you get this behavior by default in your mobile apps when you’re doing a release build. It’s currently restricted to TrueType Fonts, but that restriction will be lifted in future releases.

Another performance improvement we’ve made in this release reduces jank in the initial display of your animation using a warm-up phase. You can see an example of the jank improvement in this animation (slowed down to half speed).

<DashImage figure src="images/0LJO_r2jMcO7_49Jj.webp" alt="animation without and with the SkSL warm-up" caption="animation without and with the SkSL warm-up" />

If a Flutter app has janky animations during the first run, the Skia Shading Language shader provides for pre-compilation as part of your app’s build that can speed it up by more than 2x. If you’d like to take advantage of this advanced functionality, see [the SkSL warm-up page](https://flutter.dev/docs/perf/rendering/shader) on flutter.dev.

And finally, as we optimize for desktop form-factors, we continue to refine our mouse support. In this release, we’ve [refactored the mouse hit testing system](https://github.com/flutter/flutter/pull/59883) to provide a number of architectural advantages that were blocked due to performance issues. The refactoring enables us to improve the performance by as much as 15x in our web-based microbenchmarks! What this means to you is that you get better, more consistent, and more accurate hit testing w/o giving up performance: win-win!

With this better, faster, stronger mouse hit testing, we’ve added support for mouse cursors — one of the most upvoted features for desktop. Several commonly used widgets will display the cursors you expect by default, or you can specify another from the list of supported cursors.

<DashImage figure src="images/01zBQM3EBFDm7gLXC.gif" alt="new mouse cursors over existing widgets on Android" caption="new mouse cursors over existing widgets on Android" />

This release of Flutter is built on the 2.9 release of Dart. This features a new state-based, two-pass UTF-8 decoder with decoding primitives optimized in the Dart VM, partially taking advantage of SIMD instructions. UTF-8 is by far the most widely used character encoding method on the internet, and being able to decode it quickly is critical when receiving large network responses. In our UTF-8 decoding benchmarks we have seen improvements across the board from nearly 200% for English texts to 400% for Chinese texts on low-end ARM devices.

## Autofill for mobile text fields

One of the #1 most requested Flutter features for a while has been to support the underlying Android and iOS support for text autofill in Flutter programs. With [PR 52126](https://github.com/flutter/flutter/pull/52126), we’re pleased to say that the wait is over — no more asking your users to re-enter data that the OS has already gathered for them.

<DashImage figure src="images/0fI60rwc5QF7eh8jr.webp" alt="Autofill in action" caption="Autofill in action" />

You’ll be pleased to hear that we’ve already started adding this functionality for the web, as well.

## A new widget for common patterns of interaction

This release introduces a new widget, the `InteractiveViewer`. The `InteractiveViewer` is designed for building common kinds of interactivity into your app, like pan, zoom, and drag ’n’ drop, even in the face of resizing, which [this simple Go board sample](https://github.com/justinmc/flutter-go) demonstrates.

<DashImage figure src="images/1NgNeXqnYnJaekXxEJqSE-w.webp" alt="Zooming, panning, resizing, dragging and dropping with the `InteractiveViewer`" caption="Zooming, panning, resizing, dragging and dropping with the `InteractiveViewer`" />

To see how to integrate the `InteractiveViewer` into your own app, [check out the API documentation](https://api.flutter.dev/flutter/widgets/InteractiveViewer-class.html) where you can play with it in DartPad. Also, if you’d like to hear about how the `InteractiveViewer` was designed and developed, you can [see a presentation by the author for Chicago Flutter on YouTube](https://www.youtube.com/watch?v=ChFa0A72Uto).

If you’re interested in adding the kind of interactivity to your Flutter app that `InteractiveViewer` enables, then you’ll probably also be happy to hear that we’ve [added more capabilities to drag ’n’ drop](https://github.com/monkeyswarm/DragTargetDetailsExample) in this release. Specifically, if you’d like to know precisely where the drop happened on the target widget (it’s always been available to the *Draggable* object itself), now you can get that information with the *DragTarget onAcceptDetails* method.

<DashImage figure src="images/0dfvbXEE8UpLj6nGS.webp" alt="New drag target accept details in action" caption="New drag target accept details in action" />

Check out [this sample](https://github.com/monkeyswarm/DragTargetDetailsExample) for the details and look forward to a future release that will make this information available during the drag as well so that the *DragTarget* can more easily provide visual updates during a drag operation.

## Updated Material Slider, RangeSlider, TimePicker, and DatePicker

In addition to new widgets, this release includes a number of updated widgets to match [the latest Material guidelines](https://material.io/components/sliders). These include `Slider` and `RangeSlider`. For more information, see [What’s new with the Slider widget?](https://medium.com/flutter/whats-new-with-the-slider-widget-ce48a22611a3)

<DashImage figure src="images/0q-1IbQugDfhrwqDK.webp" alt="updated Material Slider" caption="updated Material Slider" />

<DashImage figure src="images/05zRP2E4rqoKmOkxH.webp" alt="Updated Material RangeSlider" caption="Updated Material RangeSlider" />

`DatePicker` has been updated to include a new compact design as well as support for date ranges.

<DashImage figure src="images/0rVf86HRSJ0MyVMB7.webp" alt="updated DatePicker" caption="updated DatePicker" />

And finally, `TimePicker` has a completely new style.

<DashImage figure src="images/0Ve1UjCRej9MtX2kv.webp" alt="updated TimePicker" caption="updated TimePicker" />

If you’d like to play around with it, here’s [a fun web demo built with Flutter](https://flutter-time-picker.firebaseapp.com/#/).

## Responsive Licenses page

Another update this release is the new responsive licenses page available from the `AboutDialog`.

<DashImage figure src="images/0goluPziG4B5Be-NT.webp" alt="new licenses page" caption="new licenses page" />

[PR 57588](https://github.com/flutter/flutter/pull/57588), from community contributor [TonicArtos](https://github.com/TonicArtos), is not only updated to match Material guidelines, making it just plain nice to look at, but it’s easier to navigate and designed to work as well on tablets and desktops as on phones. Thanks, TonicArtos! Since every Flutter app should be showing the licenses for the packages they’re using, you just made every Flutter app better!

## New pubspec.yaml format required for publishing plugins

Of course, Flutter isn’t just the widgets; it’s also the tooling and this release comes with too many updates to mention. However, here are some of the highlights.

First and foremost, a public service announcement: if you’re a Flutter plugin author, then the legacy `pubspec.yaml` format is no longer supported for publishing plugins. If you try, you’ll get the following error message when executing *pub publish*:

<DashImage figure src="images/0PWJq9DpGlqdZkkLH.webp" alt="Legacy pubspec format error message upon plugin publication" caption="Legacy pubspec format error message upon plugin publication" />

The old format did not support specifying which platforms your plugins support, and has been deprecated since Flutter 1.12. [The new `pubspec.yaml` format](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms) is now required for publishing new or updated plugins.

For clients of plugins, the tools still understand the old pubspec format and will for the foreseeable future. All existing plugins on pub.dev using the legacy `pubspec.yaml` format will continue to work with Flutter apps for the foreseeable future.

## Preview of embedded Dart DevTools in Visual Studio Code

The biggest tooling update in this release comes to the Visual Studio Code extension, which provides a preview of a new feature to enable you to bring Dart DevTools screens directly into your coding workspace.

<DashImage figure src="images/0aAYBrux106MX4MxQ.webp" alt="Preview of Layout Explorer from Dart DevTools embedded into Visual Studio Code" caption="Preview of Layout Explorer from Dart DevTools embedded into Visual Studio Code" />

Enable this feature with the new *dart.previewEmbeddedDevTools* setting. The above screenshot shows the Flutter Widget Inspector embedded directly into Visual Studio Code but with this new setting enabled, you can choose your favorite page embed using the Dart DevTools menu on the status bar.

<DashImage figure src="images/0uzKuydE5rOcPqqnX.webp" />

This menu allows you to choose which pages to show.

<DashImage figure src="images/0TcCxp1ljELxXMG8c.webp" />

This feature is still in preview, so [let us know if you have any trouble with it](https://github.com/Dart-Code/Dart-Code/issues).

## Updates to network tracking

The latest version of Dart DevTools comes with an updated version of the Network page that enables web socket profiling.

<DashImage figure src="images/0hv9zwpJyaf8H-Ssa.webp" alt="Timing, status and content type of socket connections on the Network page of Dart DevTools" caption="Timing, status and content type of socket connections on the Network page of Dart DevTools" />

The Network page now adds timing information to the network calls from your app, along with other information like status and content type. Additional improvements have been made to the details UI to provide an overview of the data in a websocket or http request. We’ve also got more plans for this page to include HTTP request/response bodies and monitoring gRPC traffic.

## Updating import statements on file rename

Another new feature for Visual Studio Code is updating imports on rename, which automatically updates *import* statements when files are moved or renamed.

<DashImage figure src="images/00Xhr32bM0mcyJFXl.webp" alt="moving Dart files in Visual Studio Code updates the import statements" caption="moving Dart files in Visual Studio Code updates the import statements" />

This feature currently only works for single files and not multiple files or folders, but that support is coming soon.

## Tooling metadata for every tool builder

One more update to mention is for people building Flutter tooling. We’ve created a new project on GitHub to capture and publish metadata about the Flutter framework itself. It provides machine-readable data files for the following:

* a [catalog](https://github.com/flutter/tools_metadata/blob/master/resources/catalog/widgets.json) of all of the current Flutter widgets (395 widgets!)

* a [mapping of Flutter framework color names to color values](https://github.com/flutter/tools_metadata/tree/master/resources/colors), for both the Material and Cupertino color sets

* [Icon metadata](https://github.com/flutter/tools_metadata/tree/master/resources/icons) for Material and Cupertino icons, including icon names and preview icons

This is the same metadata that we use for the Android Studio / IntelliJ and VS Code extensions ourselves; we thought you might find it useful when building your own tools. In fact, this metadata enables the feature in the IntelliJ family of IDEs to show the color being used in your Flutter code:

<DashImage figure src="images/0QfzssiJe72kCh0LU.webp" />

Related to that is a new feature in IntelliJ and Android Studio that displays color blocks for Color.fromARGB() and Color.fromRGBO():

<DashImage figure src="images/0J4G5VKzvTTxFJaxb.webp" />

Special thanks to [dratushnyy](https://github.com/dratushnyy) on GitHub for contributing improvements to the color previews in IntelliJ!

## Typesafe platform channels for platform interop

In response to popular demand from plugin authors in our user surveys, recently we’ve been experimenting on how to make communication between Flutter and the host platform safer and easier for [plugins](https://flutter.dev/docs/development/packages-and-plugins/developing-packages) and [Add-to-App](https://flutter.dev/docs/development/add-to-app). To address this need, we created [Pigeon](https://pub.dev/packages/pigeon), a command-line tool that uses Dart syntax to generate type-safe messaging code on top of platform channels without adding additional runtime dependencies. With Pigeon, instead of manually matching method strings on platform channels and serializing arguments, you can invoke Java/Objective-C/Kotlin/Swift class methods and pass non-primitive data objects by directly calling Dart methods (and vice versa).

<DashImage figure src="images/0Pe9BXnIWEyUpoI-_.webp" />

While still in prerelease, Pigeon has become mature enough that we’re using it ourselves in the [video_player](https://pub.dev/packages/video_player) plugin. If you’d interested in testing out Pigeon for your own uses, see the updated the [platform channel documentation](https://flutter.dev/docs/development/platform-integration/platform-channels#pigeon) as well as this [sample project](https://github.com/flutter/samples/tree/master/add_to_app/flutter_module_books).

## Too many tooling updates to list

So much great stuff has happened to the tools in the Flutter 1.20 timeframe that we can’t list it all here. However, you might want to take a look at the update announcements themselves:

* [VS Code extensions v3.13](https://groups.google.com/g/flutter-announce/c/TlN12RemsYw)

* [VS Code extensions v3.12](https://groups.google.com/g/flutter-announce/c/8tSufvaRJUg)

* [VS Code extensions v3.11](https://groups.google.com/g/flutter-announce/c/gM0bqO7NFA0)

* [Flutter IntelliJ Plugin M46 Release](https://groups.google.com/g/flutter-announce/c/8C2v2ueXjts)

* [Flutter IntelliJ Plugin M47 Release](https://groups.google.com/g/flutter-announce/c/6SF3PG_XB8g/m/6mAY7eC_AAAJ)

* [Flutter IntelliJ Plugin M48 Release](https://groups.google.com/g/flutter-announce/c/i9NTk5o9rZQ)

* [New tools for Flutter developers, built in Flutter](https://medium.com/flutter/new-tools-for-flutter-developers-built-in-flutter-a122cb4eec86)

## Breaking Changes

As ever, we try to keep the number of breaking changes low. Here’s the list from the Flutter 1.20 release.

* [55336](https://github.com/flutter/flutter/pull/55336) Adding tabSemanticsLabel to CupertinoLocalizations — [Migration guide PR](https://github.com/flutter/website/pull/3996)

* [55977](https://github.com/flutter/flutter/pull/55977) [Add clipBehavior to widgets with clipRect](https://flutter.dev/go/clip-behavior)

* [55998](https://github.com/flutter/flutter/pull/55998) [Fixes the navigator pages update crashes when there is still route wa…](https://groups.google.com/forum/#!searchin/flutter-announce/55998%7Csort:date/flutter-announce/yoq2VGi94q8/8pTsRL28AQAJ)

* [56582](https://github.com/flutter/flutter/pull/56582) [Update Tab semantics in Cupertino to be the same as Material](https://flutter.dev/docs/release/breaking-changes/cupertino-tab-bar-localizations#migration-guide)

* [57065](https://github.com/flutter/flutter/pull/57065) Remove deprecated child parameter for NestedScrollView’s overlap managing slivers

* [58392](https://github.com/flutter/flutter/pull/58392) iOS mid-drag activity indicator

## Summary

Hopefully, you’re as excited about this release as we are. From many angles, this is Flutter’s biggest release yet. With performance improvements, new and updated widgets, and tooling improvements, we can only hit the highlights. We want to thank you, the strong and growing set of community contributors that enables every Flutter release to be bigger, faster, and stronger than the one before. And there’s more to come, with support for [null safety](https://dart.dev/null-safety), a new version of the Ads, Maps, and WebView plugins, and more tooling support in the works. (In fact, you might be interested in Bob Nystrom’s deep dive on [Understanding null safety](https://dart.dev/null-safety/understanding-null-safety).)

With all of this extra power in Flutter and the tools, what are you going to build?
