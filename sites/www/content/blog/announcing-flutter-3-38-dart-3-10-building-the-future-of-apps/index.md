---
title: "Announcing Flutter 3.38 & Dart 3.10: Building the future of apps"
description: "Hi, Flutter community! My name is Emma Twersky, and I am unbelievably excited to be your new lead for Flutter and Dart DevRel. I’m not just…"
publishDate: 2025-11-12
author: twerske
image: images/1DwdxTpj5OEQzUzyj4lq6_A.gif
category: release
layout: blog
---

<DashImage figure src="images/1DwdxTpj5OEQzUzyj4lq6_A.gif" />


## Announcing Flutter 3.38 & Dart 3.10: Building the future of apps

Hi, Flutter community! My name is Emma Twersky, and I am unbelievably excited to be your new lead for Flutter and Dart DevRel. I’m not just here to talk about new features; I’m here for this community. The number one reason I’m here is for the incredible culture we have. If you haven’t read it, check out [Flutter culture and how to preserve it](https://blog.flutter.dev/flutter-culture-and-how-to-preserve-it-436b4ed1031d). It’s all about being open, modest, and respectful, all while building fantastic cross-platform apps, and that’s what Flutter and Dart are all about. I’m so excited to be a part of this community, and I can’t wait to share all that we’re working on.

Speaking of fantastic cross-platform apps, our friends over at NotebookLM have been going viral with their Flutter app this year. We visited them to hear about how Flutter accelerated their launch, check it out:

<YoutubeEmbed id="pMoUg3dkDJk" title="How NotebookLM Built a 4.8-Star Flutter App" fullwidth="true"/>


In fact, you can listen to the Audio Overview of this blog post (and all its linked sources) in [NotebookLM](https://notebooklm.google.com/notebook/be3457d4-2909-4290-9ba7-40ae015015cf?artifactId=f5b2b691-58a4-4c30-bb15-fcf944b9a255).

Still with me? Then hold onto your keyboards, because **Flutter 3.38 and Dart 3.10 are now available**, and they are HOT. These releases are packed with usability enhancements and improvements to our developer tooling. And yes, that includes AI.

## Building the future of apps with Google AI and the “Future of apps” series

We’ve got a whole [Flutter Flight Plans series](https://www.youtube.com/playlist?list=PLjxrf2q8roU1yXu4k7ivSLAa0cizD4feH) dropping this month and next to show you how to build the next generation of apps with Flutter, Firebase, and Gemini.

**Building dynamic UI with Flutter GenUI:** The new Flutter GenUI SDK is here to help you build dynamic UI that adapts based on your user’s intent. Don’t believe me? Watch the video, “Getting started with GenUI”, then check out the [genui package](https://github.com/flutter/genui) to see it in action.

<YoutubeEmbed id="nWr6eZKM6no" title="Getting started with GenUI" fullwidth="true"/>


**The easiest way to build with AI:** We’ve built a sample app powered by Firebase AI logic that helps you create a nice launching point for integrating AI features into your app. This sample app covers features such as using multi-modal content generation, in addition to the Gemini conversational live API. Get your hands dirty in the [Flutter AI Playground](https://g.co/firebase/flutter-ai-playground).

<YoutubeEmbed id="tErMAB5FKNw" title="How I built a Google I/O keynote demo in 30 minutes" fullwidth="true"/>


**Build multi-platform Flutter apps with Gemini CLI:** Head to [the docs](https://docs.flutter.dev/ai/create-with-ai#flutter-extension-for-gemini-cli) to jump into the Flutter extension for Gemini CLI.

<YoutubeEmbed id="RZPkE5sllck" title="Build multiplatform apps with Gemini CLI" fullwidth="true"/>


## Productivity and platform power: What’s new in Flutter 3.38 and Dart 3.10

Now for the main event. Here’s what’s new and why you should be excited.

<YoutubeEmbed id="-AuAZTyRelY" title="What's new in Flutter 3.38 and Dart 3.10" fullwidth="true"/>


### Dart 3.10 highlights: More expressive, concise, and robust code.

* **Dot shorthands:** Less typing, more coding. Instead of `MainAxisAlignment.start`, you can now just write `.start`. Check out the [dot shorthands](https://dart.dev/language/dot-shorthands) page to learn more.

* **Build hooks:** Now stable! Compile native code or bundle native assets directly with your Dart package. Get all the details in the [hooks](https://dart.dev/tools/hooks) page or watch the [Build hooks](https://www.youtube.com/watch?v=AxNF5dj8HWQ) video.

* **And more!** There’s a new [analyzer plugin system](https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server_plugin/doc/writing_a_plugin.md). You can use this system to write your own analysis rules and employ IDE quick fixes. Use the new [Deprecated annotation](https://api.dart.dev/stable/dart-core/Deprecated-class.html) for deprecating specific functionalities.

Dive into the [Dart 3.10 technical blog post](https://blog.dart.dev/announcing-dart-3-10-ea8b952b6088) for the full story.

### Flutter 3.38 highlights: A more refined framework, better platform integration, and slicker developer tools.

* **Web enhancements:** We’ve got a [config file for `flutter run`](https://docs.flutter.dev/platform-integration/web/web-dev-config-file), proxy support, and [hot reload for the web](https://docs.flutter.dev/platform-integration/web/building#hot-reload-web). Because who has time to wait?

* **Framework & UI:** `OverlayPortal` is more powerful than ever, and [predictive back gesture](https://developer.android.com/guide/navigation/predictive-back-gesture) is now default on Android. We’re also still polishing up Material and Cupertino.

* **iOS updates:** Full support for iOS 26/Xcode 26, command-line deployment, and a super-important [guide for migrating Flutter apps](https://docs.flutter.dev/release/breaking-changes/uiscenedelegate#migration-guide-for-flutter-apps).

* **Android updates:** NDK r28 is here for [16KB page size compatibility](https://developer.android.com/guide/practices/page-sizes), we’ve plugged a major memory leak, and updated to Java 17.

* **Tooling:** Big updates to the experimental [Widget Previewer tool](https://docs.flutter.dev/tools/widget-previewer) and IDEs. Go play!

* **Accessibility:** We’re always working to make Flutter more inclusive. Say hello to the new [`SliverSemantics`](https://api.flutter.dev/flutter/widgets/SliverSemantics-class.html) widget and better default behaviors.

Want all the nitty-gritty details? Of course you do. Check out the [Flutter 3.38 technical blog post](https://blog.flutter.dev/whats-new-in-flutter-3-38-3f7b258f7228).

## Community and ecosystem spotlight

This release cycle, our community has been as active as ever, with a host of valuable contributions. Here are just a few examples:

* **Windows display properties:** Thanks to [@9AZX](https://github.com/9AZX), you can now get detailed display information on Windows, including monitor lists, display sizes, refresh rates, and DPI.

* **New convenience constructors:** [@ahmeddhus](https://github.com/ahmeddhus) added a `SliverGrid.list` constructor, providing a cleaner API for creating grids from a list of widgets.

* **Enhanced gesture handling:** [@houssemeddinefadhli81](https://github.com/houssemeddinefadhli81) introduced an `onLongPressUp` callback to the `InkWell` widget to specifically handle the release of a long press gesture.

* **More flexible widgets:** [@iamtoricool](https://github.com/iamtoricool) added a `maxCount` parameter to the `Badge.count` constructor, and [@rkishan516](https://github.com/rkishan516) added a momentary variant to `CupertinoSlidingSegmentedControl`.

* **Important fixes:** We also saw crucial fixes for scrolling behavior from [@manu-sncf](https://github.com/manu-sncf) and [@yiiim](https://github.com/yiiim), focus issues from [@romaingyh](https://github.com/romaingyh), and more.

💙 Let’s be real: **this community is everything**. You’re the reason Flutter is what it is today, and beyond OSS contributions to Flutter’s core, we’re constantly blown away by what you create. In this release, we’re putting the spotlight on [Kilian](https://github.com/schultek) and the framework, [Jaspr](https://jaspr.site/). Where Flutter’s web support is great for applications, Jaspr is a traditional DOM-based (HTML/CSS) web framework that is built on top of Dart. It is a great complement to Flutter web for when you want a Dart-based solution to build sites.

We were so impressed that we migrated our entire documentation infrastructure — both dart.dev and docs.flutter.dev — over to it. Pretty cool, right? We’ve asked Kilian and the team to share the full story in a future blog post, so you’ll be hearing from them soon. In the meantime, we recommend that you [try it out](https://docs.jaspr.site/get_started/quick_start) yourself!

## Get started!

So, what are you waiting for? Upgrade to Flutter 3.38 and Dart 3.10 and let’s build the future together.

* [Flutter 3.38 release notes](https://docs.flutter.dev/release/release-notes)

* [Dart 3.10 release notes](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md)

* Dive into [the future of AI apps](https://www.youtube.com/playlist?list=PLjxrf2q8roU3ahJVrSgAnPjzkpGmL9Czl)

* Play in the [Flutter AI Playground](https://g.co/firebase/flutter-ai-playground)

* Join the [flutter.dev/community](https://flutter.dev/community)
