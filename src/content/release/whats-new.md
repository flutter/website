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

To stay on top of Flutter announcements including breaking changes,
join the [flutter-announce][] Google group.

For Dart, you can join the [Dart Announce][] Google group,
and review the [Dart changelog][].

[Dart Announce]: {{site.groups}}/a/dartlang.org/g/announce
[Dart changelog]: {{site.github}}/dart-lang/sdk/blob/main/CHANGELOG.md
[flutter-announce]: {{site.groups}}/forum/#!forum/flutter-announce
[release notes]: /release/release-notes

## 12 November 2025: Release 3.38

Flutter 3.38 is live! For details,
check out the [Flutter 3.38 technical blog post][3.38-tech].

[3.38-tech]: {{site.flutter-blog}}/whats-new-in-flutter-3-38-3f7b258f7228

**Website update**

A significant update to the website has recently landed!
As with the update to the dart.dev website that landed
earlier this year, the docs.flutter.dev website has been
reimplemented to use [Jaspr][], a Dart web framework.

Let us know what you think!

[Jaspr]: https://jaspr.site/

**Docs updated or added since the 3.35 release**

* The Dart language now supports _dot shorthands_ syntax
  (aka _shorthands_), which allows you to write more
  concise code. For more information, visit the
  [Dart dot shorthands][] page on dart.dev. Over time,
  the samples on this website will be updated
  to take advantage of this new feature.

* The `flutter run` command now supports a configuration file
  that allows you to specify web settings like host, port,
  certification, and header.
  The web dev config file also supports proxy settings,
  making it possible to forward specific path requests
  to another server. This makes it easier to develop a
  web client that connects to dynamic endpoints on the same host. 
  For more information, visit
  [setting up a web development configuration file][web-config-file].

* Development continues on the Flutter Widget Previewer tool,
  introduced as an experimental feature in the 3.35 release.
  For this release, the previewer better integrates with the VS Code
  and IntelliJ IDEs (including Android Studio).
  It's still an experimental feature.
  For more info about the latest version, 
  check out the [Widget Previewer tool page][].

* The Flutter 3.38 release fully supports the platform releases
  for iOS 26, Xcode 26, and macOS 26, all of which were released in September. 
  For the most recent info on Flutter's support for iOS,
  visit [Flutter on latest iOS][].

* Flutter 3.38 supports the new Apple-mandated [UIScene lifecycle][].
  To support this, code migration is required.
  For more information, visit the [UIScene migration guide][].

* With a focus on improving Flutter's accessibility,
  the [accessibility docs][] have also been completely reworked. 

* Also, don't forget to check out the [breaking changes][bc-3.38]
  page for this release. That's where you'll find information
  about breaking changes, code deprecations, and migration guides.

Other relevant resources:

* [3.38 release notes and changelog][]
* [DevTools 2.51.1 release notes][]
* [Dart 3.10 release][] blog post

[3.38 release notes and changelog]: /release/release-notes/release-notes-3.38.0
[accessibility docs]: /ui/accessibility
[bc-3.38]: /release/breaking-changes#released-in-flutter-3-38
[Dart 3.10 release]: https://blog.dart.dev/announcing-dart-3-10-ea8b952b6088
[Dart dot shorthands]: {{site.dart-site}}/language/dot-shorthands
[DevTools 2.51.1 release notes]: /tools/devtools/release-notes/release-notes-2.51.1
[Flutter on latest iOS]: /platform-integration/ios/ios-latest
[UIScene lifecycle]: {{site.apple-dev}}/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle
[UIScene migration guide]: /release/breaking-changes/uiscenedelegate
[Widget Previewer tool page]: /tools/widget-previewer
[web-config-file]: /platform-integration/web/web-dev-config-file

--- 

## 13 August 2025: Release 3.35

Flutter 3.35 is live! For more information,
check out the [Flutter 3.35 technical blog post][3.35-tech].
You might also check out the [Dart 3.9 release][] blog post.

[3.35-tech]: {{site.flutter-blog}}/whats-new-in-flutter-3-35-c58ef72e3766
[Dart 3.9 release]: {{site.medium}}/dartlang/announcing-dart-3-9-ba49e8f38298

**Docs updated or added since the 3.32 release**

* Hot reload is now available on the web and no longer
  requires an experimental flag. For more information,
  check out [hot reload][].

* There is a new [Create with AI][] guide which covers
  how you can leverage AI tools like Gemini Code Assist,
  GeminiCLI, and the Dart and Flutter MCP Server to build
  AI-powered features for your Flutter apps.

* You can now use the [Flutter Widget Previewer][] guide
  to help you view a preview of your Flutter widgets in
  Chrome.

* Each stable release affects which versions of
  deployed platforms that Flutter supports.
  For more information, visit the updated
  [supported platforms][] page.

* On Android, you can now protect sensitive content,
  such as customer information, when you share your screen.
  Learn more by visiting [Protect your app's sensitive content][].

* Also, don't forget to check out the [breaking changes][bc-3.35]
  page for this release. That's also where you'll find useful
  migration info.

[Flutter Widget Previewer]: /tools/widget-previewer
[Create with AI]: /ai/create-with-ai
[bc-3.35]: /release/breaking-changes#released-in-flutter-3-35
[hot reload]: /tools/hot-reload
[Protect your app's sensitive content]: /platform-integration/android/sensitive-content
[supported platforms]: /reference/supported-platforms

---

For past releases, check out the
[What's new archive][] page.

[What's new archive]: /release/archive-whats-new
