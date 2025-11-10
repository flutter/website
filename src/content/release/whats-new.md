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

## 20 May 2025: Google I/O release 3.32

Flutter 3.32 is live! For more information,
check out the [Flutter 3.32 technical blog post][3.32-tech].
You might also check out the [Dart 3.8 release][] blog post.

[3.32-tech]: {{site.medium}}/flutter/whats-new-in-flutter-3-32-40c1086bab6e
[Dart 3.8 release]: {{site.medium}}/dartlang/announcing-dart-3-8-724eaaec9f47

**Website update**

First of all, a behind-the-scenes rewrite of the website has
been in the works. These changes have been published incrementally,
so you might have already noticed some of them:

* Dark mode is now available
* You can now rate each page on the site with a thumbs up
  or thumbs down
* The sidenav has changed and it's (hopefully) easier to find content
* The website has been made more accessible
* Files have been moved around (we always provide redirects)

**Docs updated or added since the 3.29 release**

* An updated [Flutter on iOS][] page.
* We have a new [workflow for installing Flutter][] on the various
  development platforms. This continues to be a work in progress,
  so stay tuned.
* A new page on how you can use the new DevTools feature,
  [Flutter Property Editor][].
  The [VS Code][] and [Android Studio/IntelliJ][] instructions
  are also updated on how to use this feature.
* The website is updated to explain how
  you can [use hot reload on web][] behind a flag.
  For this release, hot reload on web is an experimental feature.
* A new page on [adding iOS app extensions][].
* A completely rewritten page for
  [setting up Flutter flavors for iOS and macOS][].
* A new page for [setting up Flutter flavors for Android][].
* The Cupertino instructions were updated for the
  [Place a floating app bar above a list][floating-app-bar]
  cookbook recipe.
* You can now
  [improve accessibility of your apps with SemanticRoles][semantic-roles].
* Also, don't forget to check out the [breaking changes][bc-3.32]
  page for this release. That's also where you'll find useful
  migration info.

[Architectural overview page]: /resources/architectural-overview
[bc-3.32]: /release/breaking-changes#released-in-flutter-3-32

[adding iOS app extensions]: /platform-integration/ios/app-extensions
[Android Studio/IntelliJ]: /tools/android-studio#property-editor
[floating-app-bar]: /cookbook/lists/floating-app-bar
[Flutter on iOS]: https://flutter.dev/multi-platform/ios
[Flutter Property Editor]: /tools/property-editor
[semantic-roles]: /ui/accessibility/web-accessibility#enhancing-accessibility-with-semantic-roles
[setting up Flutter flavors for Android]: /deployment/flavors
[setting up Flutter flavors for iOS and macOS]: /deployment/flavors-ios
[use hot reload on web]: /platform-integration/web/building#hot-reload-web
[VS Code]: /tools/vs-code#property-editor
[workflow for installing Flutter]: /install

---

For past releases, check out the
[What's new archive][] page.

[What's new archive]: /release/archive-whats-new
