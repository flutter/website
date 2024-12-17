---
title: What's new in the docs
description: >-
  A list of what's new on docs.flutter.dev and related documentation sites.
---

This page contains current and recent announcements
of what's new on the Flutter website and blog.
Find past what's new information on the
[what's new archive][] page.
You might also check out the
Flutter SDK [release notes][].

To stay on top of Flutter announcements including
breaking changes,
join the [flutter-announce][] Google group.

For Dart, you can join the [Dart Announce][] Google group,
and review the [Dart changelog][].

[Dart Announce]: {{site.groups}}/a/dartlang.org/g/announce
[Dart changelog]: {{site.github}}/dart-lang/sdk/blob/main/CHANGELOG.md
[flutter-announce]: {{site.groups}}/forum/#!forum/flutter-announce
[release notes]: /release/release-notes

## 11 December 2024: 3.27 release

Flutter 3.27 is live! For more information,
check out the [Flutter 3.27 umbrella blog post][3.27-umbrella]
and the [Flutter 3.27 technical blog post][3.27-tech].
You might also check out the [Dart 3.6 release][] blog post.

[3.27-umbrella]: {{site.medium}}/flutter/flutter-in-production-f9418261d8e1
[3.27-tech]: {{site.medium}}/flutter/whats-new-in-flutter-3-27-28341129570c
[Dart 3.6 release]: {{site.medium}}/dartlang/announcing-dart-3-6-778dd7a80983

**Docs updated or added since the 3.24 release**

This website release includes several important updates!

* The Flutter AI Toolkit is launched! You'll find the docs
  on the website in the side navigation menu under
  **App solutions > AI** and at [Flutter AI Toolkit][].

* For a long time now, we have been asked to create more
  guidance for developers who write large-scale, complex
  Flutter apps. Well, that work has begun:
  introducing [Architecting Flutter apps][]!
  This section includes eight new pages about architecting
  Flutter apps, including a [Design patterns][] page
  that has six recipes for common design patterns
  that you might find useful.

* We've added more information about
  [Support for WebAssembly (Wasm)][].

* We've also reworked the [Web renderers][] page
  to cover the two build modes for web and its
  two renderers.

* Impeller is now the default rendering engine for
  iOS and Android. We've also added a link from
  the Impeller page to the detailed [Can I use Impeller?][]
  page.

* For developers interested in monetization, we have
  introduced a new [Interactive Media Ads][] package.
  You can find it through the website in the side
  navigation menu under
  **App solutions > Monetization > Advertising**.
  Also, check out the [Video & web app support in Flutter][ad-bp]
  blog post.

* We have new docs for using Flutter with Android, specifically, 
  [Launching a Jetpack Compose activity from your Flutter application][jc]
  and [Calling JetPack APIs][jetpack-api].

* Work continues on the [Learn the fundamentals][fwe] pages
  (formerly called the First Week Experience).
  Besides updates to several pages, check out the new
  [Intro to Dart][] page.

* Further support and updated docs for the Swift Package Manager.
  Specifically, you can now build on the stable channel for SPM,
  however, plugins will continue to be installed using
  CocoaPods as the SwiftPM feature remains
  unavailable on the stable channel:
  [Swift Package Manager for plugin authors][plugin-authors] and
  [Swift Package Manager for app authors][app-authors].

* The [Deep linking validator tool][deep-linking-tool], part of DevTools,
  now works for both iOS and Android. 

* Also, don't forget to check out the [breaking changes][bc-3.27]
  page for this release. That's also where you'll find useful
  migration info.

[ad-bp]: {{site.medium}}/flutter/video-web-ad-support-in-flutter-f50e5a3480a8
[app-authors]: /packages-and-plugins/swift-package-manager/for-app-developers
[Architecting Flutter apps]: /app-architecture
[bc-3.27]: /release/breaking-changes#released-in-flutter-3-27
[Can I use Impeller?]: https://docs.google.com/spreadsheets/d/11Jr0YTUzL8R1ZLHOAqiHiQzdmcUp2Ag5j69Kd3RSUoA/edit?gid=0#gid=0
[deep-linking-tool]: /tools/devtools/deep-links
[design patterns]: /app-architecture/design-patterns
[Flutter AI Toolkit]: /ai-toolkit
[fwe]: /get-started/fundamentals
[Interactive Media Ads]: {{site.pub-pkg}}/interactive_media_ads
[jc]: /platform-integration/android/compose-activity
[jetpack-api]: /platform-integration/android/call-jetpack-apis
[Intro to Dart]: /get-started/fundamentals/dart
[plugin-authors]: /packages-and-plugins/swift-package-manager/for-plugin-authors
[Support for WebAssembly (Wasm)]: /platform-integration/web/wasm
[web renderers]: /platform-integration/web/renderers

---

## 07 August 2024: I/O Connect Beijing 3.24 release

Flutter 3.24 is live! For more information,
check out the [Flutter 3.24 umbrella blog post][3.24-umbrella]
and the [Flutter 3.24 technical blog post][3.24-tech].
You might also check out the [Dart 3.5 release][] blog post.

[3.24-tech]: {{site.flutter-medium}}/whats-new-in-flutter-3-24-6c040f87d1e4
[3.24-umbrella]: {{site.flutter-medium}}/flutter-3-24-dart-3-5-204b7d20c45d
[Dart 3.5 release]: {{site.medium}}/dartlang/dart-3-5-6ca36259fa2f

**Docs updated or added since the 3.22 release**

This website release includes several important updates!

* An updated widget catalog:
  * Added 37 missing widgets to the [Cupertino catalog][],
    and a new screenshot for the updated `CupertinoActionSheet` widget.
  * Added the new [`CarouselView`][] widget.
  * `CupertinoButton` and `CupertinoTextField`
    also have updated behaviors.
* New guides on adding support for Swift Package Manager
  to [iOS plugins][] and [iOS apps][]. (Note that,
  until all of your app's dependencies are migrated,
  Flutter will continue to use CocoaPods.)
* Updated web docs:
  * [Embedding Flutter on the web][], including how to
    enable multi-view mode
  * [Embedding web content into a Flutter app][]
* Update for Android 14:
  If you are using an Android device that runs on
  Android 14, you can now support Android's
  [predictive back gesture][].
* Updates for iOS 18:
  The iOS 18 release is in beta at the time of this release.
  These iOS 18 features are already enabled in Flutter
  and are now mentioned in the docs:
  * Use an [iOS app extension][] in your Flutter app
    to create a custom toggle. Your users can then
    add your app's toggle when customizing their
    Control Center.
  * [Tinted app icons][] are supported
* Two pages of the [Flutter fundamentals docs][] are updated:
  * [Widgets][]
  * [Layout][]
  We hope these pages are helpful for new Flutter developers.
* DevTools also has updates. Check out the release notes for
  [DevTools 2.35.0][], [DevTools 2.36.0][], and [DevTools 2.37.2][].

[`CarouselView`]: {{site.api}}/flutter/material/CarouselView-class.html
[Cupertino catalog]: /ui/widgets/cupertino
[DevTools 2.35.0]: /tools/devtools/release-notes/release-notes-2.35.0
[DevTools 2.36.0]: /tools/devtools/release-notes/release-notes-2.36.0
[DevTools 2.37.2]: /tools/devtools/release-notes/release-notes-2.37.2
[Embedding Flutter on the web]: /platform-integration/web/embedding-flutter-web
[Embedding web content into a Flutter app]: /platform-integration/web/web-content-in-flutter
[Flutter fundamentals docs]: /get-started/fundamentals
[Widgets]: /get-started/fundamentals/widgets
[iOS app extension]: /platform-integration/ios/app-extensions
[iOS plugins]: /packages-and-plugins/swift-package-manager/for-plugin-authors
[iOS apps]: /packages-and-plugins/swift-package-manager/for-app-developers
[Layout]: /get-started/fundamentals/layout
[predictive back gesture]: /platform-integration/android/predictive-back
[Tinted app icons]: /deployment/ios#add-an-app-icon

<b>Other</b>

* If you are interested in the new, experimental
  Flutter GPU API, check out the [Flutter GPU blog post][].
* The Flutter wiki has been divided up and moved into the
  relevant GitHub repos, making it easier to keep that
  info up to date.

[Flutter GPU blog post]: {{site.flutter-medium}}/getting-started-with-flutter-gpu-f33d497b7c11

---

For past releases, check out the
[What's new archive][] page.

[What's new archive]: /release/archive-whats-new

