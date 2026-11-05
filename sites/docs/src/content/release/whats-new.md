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

[Dart Announce]: {{site.groups.dart-announce}}
[Dart changelog]: {{site.repo.dart-sdk}}/blob/main/CHANGELOG.md
[flutter-announce]: {{site.groups.flutter-announce}}
[release notes]: /release/release-notes

## 11 November 2026: Release 3.50

Flutter 3.50 is live! For details,
check out the [Flutter 3.50 blog post][3.50-blog-post].

**Docs updated or added since the 3.47 release**

* A new [Native interoperability][native-interop] section brings together
  guides for calling native code across Android, iOS, macOS, Windows, and Linux.
  It includes refreshed walkthroughs for [Pigeon][pigeon],
  [C and Objective-C interop][c-interop] with `package:ffigen`,
  [Java and Kotlin interop][java-interop] with `package:jnigen`,
  and bundling native code with [build hooks][bind-native-code].

* With the in-framework Material and Cupertino libraries formally deprecated
  in Flutter 3.50, a new [migration guide][design-pkg-migration] walks you
  through migrating to the standalone `material_ui` and `cupertino_ui` packages
  using `dart fix` and `MaterialUiCompatibilityBridge`.

* The [Flutter installation][install] documentation has been overhauled with
  streamlined quick-install and custom-setup flows,
  along with new instructions on [running Flutter apps on iOS devices][ios-setup]
  contributed by community member [poyito777][].

* The web documentation covers the new `--web-content-hash` build flag for
  [cache-busting hashed web assets][web-deploy],
  updated browser compatibility guidance for [WebAssembly][wasm-350],
  the `--no-deprecated-js-interop` build flag,
  and refreshed [web accessibility][web-a11y] guidance.

* The AI documentation has been reorganized around a unified
  [get started guide][ai-get-started], an [AI tools overview][ai-tools]
  covering agentic rules, custom agents (including the built-in Flutter
  accessibility agent), and `package:skills_lint`, and a new guide on
  [package skills][package-skills].

* The data and backend section features a new guide to help you
  [choose a database for your Flutter app][choose-database] and expanded
  [Firebase][firebase-docs] integration documentation.

* New guides cover setting up desktop app flavors for
  [Windows][flavors-windows] and [Linux][flavors-linux].

* The platform integration documentation includes readiness updates for
  [iOS 27, macOS 27, and Xcode 27][supported-platforms] alongside expanded
  [Swift Package Manager][swiftpm-350] migration guidance for apps and plugins.

* The contributing and compatibility documentation now details the public
  [Flutter RFC process][rfc-process] for proposing significant framework and
  ecosystem changes.

As always, check out the [breaking changes][bc-3-50] page for this release,
which includes links to migration guides and other vital information.

[3.50-blog-post]: {{site.main-url}}/blog/whats-new-in-flutter-3-50
[native-interop]: /interop
[pigeon]: /interop/pigeon
[c-interop]: /interop/ffigen
[java-interop]: /interop/jnigen
[bind-native-code]: /interop/bind-native-code
[design-pkg-migration]: /release/breaking-changes/material-ui-and-cupertino-ui
[install]: /install
[ios-setup]: /platform-integration/ios/setup
[poyito777]: https://github.com/poyito777
[web-deploy]: /deployment/web
[wasm-350]: /platform-integration/web/wasm
[web-a11y]: /ui/accessibility/web-accessibility
[ai-get-started]: /ai/get-started
[ai-tools]: /ai/tools
[package-skills]: /ai/package-skills
[choose-database]: /data-and-backend/persistence/choose-a-database
[firebase-docs]: /data-and-backend/firebase
[flavors-windows]: /deployment/flavors-windows
[flavors-linux]: /deployment/flavors-linux
[supported-platforms]: /reference/supported-platforms
[swiftpm-350]: /packages-and-plugins/swift-package-manager/for-app-developers
[rfc-process]: /release/compatibility-policy
[bc-3-50]: /release/breaking-changes#released-in-flutter-3-50

---

## 12 August 2026: Release 3.47

Flutter 3.47 is live! For details,
check out the [Flutter 3.47 blog post][3.47-blog-post].

**Docs updated or added since the 3.44 release**

* The Flutter [Widget Previews][widget-previewer] tool has graduated to stable,
  introducing local build caching for faster startup times
  and real-time preview search and filtering.

* The AI documentation has been reorganized to improve navigation
  and help you get started quickly with agent-plugins
  (formerly known as skills) using the [Antigravity CLI][antigravity-cli],
  IDE integrations, and other coding assistants.
  An experimental [AI Evaluations][ai-evals] topic page has also been added.

* A new guide on [Dependency management][dependency-mgmt] explains
  how to configure, manage, and upgrade package dependencies.

* The [Swift Package Manager][swiftpm] guides for iOS and macOS have expanded,
  and the [Add-to-app][add-to-app] documentation now includes
  SwiftPM integration instructions.

* The web documentation now includes troubleshooting guidance for
  [Wasm compilation errors][wasm] and instructions for using the
  `--source-maps` flag during web builds.

* The assets guide now explains how to bundle
  [platform-specific assets][platform-assets] in `pubspec.yaml`.

* A new migration guide helps you migrate plugins and apps to
  [built-in Kotlin][kotlin-migration] Gradle plugins.

As always, check out the [breaking changes][bc-3-47] page for this release,
which includes links to migration guides and other vital information.

[3.47-blog-post]: /blog/whats-new-in-flutter-3-47
[widget-previewer]: /tools/widget-previewer
[antigravity-cli]: /ai/antigravity-cli
[ai-evals]: /ai/evals
[dependency-mgmt]: /packages-and-plugins/dependency-management
[swiftpm]: /packages-and-plugins/swift-package-manager
[add-to-app]: /add-to-app
[wasm]: /platform-integration/web/wasm
[platform-assets]: /ui/assets/assets-and-images
[kotlin-migration]: /release/breaking-changes/migrate-to-built-in-kotlin
[bc-3-47]: /release/breaking-changes#released-in-flutter-3-47

---

## 18 May 2026: Google I/O Release 3.44

Flutter 3.44 is live! This release is jam packed.
For details, check out the [Flutter 3.44 blog post][3.44-blog-post]
and [watch the video][3.44-whats-new]:

<div class="video-wrapper">
<span class="video-intro">Check out the latest in Dart and Flutter</span>
<YouTubeEmbed id="I1uIbGh1dGE" title="What's New in Dart and Flutter 3.44" fullWidth></YouTubeEmbed>
</div>

[3.44-blog-post]: {{site.flutter-blog}}/whats-new-in-flutter-3-44-b0cc1ad3c527
[3.44-whats-new]: https://www.youtube.com/watch?v=I1uIbGh1dGE&t=451s

More on the site updates to come.

## 11 February 2026: "Year of the Fire Horse" Release 3.41

Flutter 3.41 is live! For details,
check out the [Flutter 3.41 blog post][3.41-blog-post].

[3.41-blog-post]: {{site.flutter-blog}}/whats-new-in-flutter-3-41-302ec140e632


**Docs updated or added since the 3.38 release**

In addition to many smaller updates, here are some of the more
significant changes:

* We have introduced a new getting started experience for
  both Flutter and Dart, as announced in a recent [blog post][few].
  You can find the Flutter [learning pathway][] under the **Learn**
  tab at the top of [docs.flutter.dev][]. To return to the rest of the site,
  select the **Guides** tab. As always, the **Reference**
  tab takes you to the [Flutter API docs][].

* Flutter and Dart now have an [official glossary][].
  As part of the recent migration of the websites to Jaspr,
  a glossary has been added to the Flutter website.
  Expect to see it grow in the fullness of time.

* As always, check out the [breaking changes][bc-3-41] page for this release,
  which includes links to migration guides and other vital information.
  A special thank you to [navaronbracke][], who wrote a migration
  guide for the [deprecation of the `onReorder` callback][onReorder].

[bc-3-41]: /release/breaking-changes#released-in-flutter-3-41
[docs.flutter.dev]: /
[Flutter API docs]: {{site.api}}
[few]: {{site.flutter-blog}}/announcing-our-new-dart-and-flutter-getting-started-experience-b8c4b2be0984
[learning pathway]: /learn
[navaronbracke]: https://github.com/navaronbracke
[official glossary]: /resources/glossary
[onReorder]: /release/breaking-changes/separated-builder-find-child-index-callback

---

For past releases, check out the
[What's new archive][] page.

[What's new archive]: /release/archive-whats-new
