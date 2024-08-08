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
* Two of the [First week experience][] pages are updated:
  * [Flutter fundamentals][]
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
[First week experience]: /get-started/fwe
[Flutter fundamentals]: /get-started/fwe/fundamentals
[iOS app extension]: /platform-integration/ios/app-extensions
[iOS plugins]: /packages-and-plugins/swift-package-manager/for-plugin-authors
[iOS apps]: /packages-and-plugins/swift-package-manager/for-app-developers
[Layout]: /get-started/fwe/layout
[predictive back gesture]: /platform-integration/android/predictive-back
[Tinted app icons]: /deployment/ios#add-an-app-icon

## Other
* If you are interested in the new, experimental
  Flutter GPU API, check out the [Flutter GPU blog post][].
* The Flutter wiki has been divided up and moved into the
  relevant GitHub repos, making it easier to keep that
  info up to date.

[Flutter GPU blog post]: {{site.flutter-medium}}/getting-started-with-flutter-gpu-f33d497b7c11

## 14 May 2024: Google I/O 3.22 release

Flutter 3.22 is live! For more information,
check out the [Flutter 3.22 umbrella blog post][3.22-umbrella]
and the [Flutter 3.22 technical blog post][3.22-tech].

You might also check out the [Dart 3.4 release][] blog post.
In particular, Dart now provides a "baked in" language macro,
`JsonCodable`, for serializing and deserializing JSON data. 
A future (and unspecified) Dart release will allow
you to create your own macros.
To learn more, check out [dart.dev/go/macros][].

[3.22-tech]: {{site.flutter-medium}}/whats-new-in-flutter-3-22-fbde6c164fe3
[3.22-umbrella]: {{site.flutter-medium}}/io24-5e211f708a37
[Dart 3.4 release]: {{site.medium}}/dartlang/dart-3-4-bd8d23b4462a
[dart.dev/go/macros]: http://dart.dev/go/macros

**Docs updated or added since the 3.19 release**

* A new 7-page section on [Adaptive and Responsive design][].
  (This replaces our previous, somewhat scattered,
  documentation on this subject.)
* For new-ish Flutter developer who has worked through
  the first Flutter codelab, we've added some "what's next"
  advice on how to move beyond that initial step.
  Check out the docs for the
  [First week experience of Flutter][], also called **FWE**.
* Our [Flutter install][] docs have been revamped.
* We have three new codelabs and a new guide for the Games Toolkit.
  To see the list of additions,
  check out the updated [Casual Games Toolkit][] page.
* A new section, [Conditionally bundling assets based on flavor][],
  in the Flavors page.
* Flutter support for Web Assembly (Wasm) has now reached stable.
  To learn more, check out the updated
  [Support for WebAssembly (Wasm)][] page.
* DevTools has a new screen for evaluating deep links on Android.
  To learn more, check out the new page, [Validate deep links][].
* We have a new page that describes web bootstrapping for
  Flutter SDK release 3.22 and later.
  Check out [Flutter web app initialization][].
* You can now provide code to transform your assets
  into another format at runtime. To learn more,
  check out [Transforming assets at build time][].

**Website infrastructure**

* If you contribute to the website, you might have noticed
  some recent changes. Namely, the website infrastructure
  has been updated and the new workflow is simpler.
  For more details, check out the [website README][].
* You might also have noticed that the **App solutions**
  submenu in the sidenav now has an **AI** section,
  and an enhanced **Monetization** section,
  to name some of the changes.

[Adaptive and Responsive design]: /ui/adaptive-responsive
[Casual Games Toolkit]: /resources/games-toolkit
[Conditionally bundling assets based on flavor]: /deployment/flavors#conditionally-bundling-assets-based-on-flavor
[First week experience of Flutter]: /get-started/fwe
[Flutter install]: /get-started/install
[Flutter web app initialization]: /platform-integration/web/initialization
[website README]: {{site.github}}/flutter/website/?tab=readme-ov-file#flutter-documentation-website
[Support for WebAssembly (Wasm)]: /platform-integration/web/wasm
[Transforming assets at build time]: /ui/assets/asset-transformation
[Validate deep links]: /tools/devtools/deep-links

---

For past releases, check out the
[What's new archive][] page.

[What's new archive]: /release/archive-whats-new

