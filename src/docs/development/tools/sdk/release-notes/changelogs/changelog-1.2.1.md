---
title: Change log for Flutter 1.2.2 
short-title: 1.2.2 change log
description: Change log for Flutter 1.2.2 containing a list of all PRs merged for this release.
---


## PRs closed in this release of flutter/flutter

From Fri Nov 29 19:41:00 2018 -0800 to Thu Feb 21 20:22:00 2019 -0800


[21157](https://github.com/flutter/flutter/pull/21157) Swap scope with gesture (cla: yes, f: scrolling, framework)

[22139](https://github.com/flutter/flutter/pull/22139) move INTERNET permission to debug/AndroidManifest.xml (cla: yes, tool, ▣ platform-android)

[23118](https://github.com/flutter/flutter/pull/23118) Setting icon color to first ListTile in ExpansionTile. Fixes #23053 (cla: yes, f: material design, framework)

[23188](https://github.com/flutter/flutter/pull/23188) Check for duplicative Flutter.framework emeddings when building for Xcode 10 (cla: yes, tool, ⌺‬ platform-ios)

[23424](https://github.com/flutter/flutter/pull/23424) Teach drag start behaviors to DragGestureRecognizer (a: text input, cla: yes, d: examples, f: cupertino, f: date/time picker, f: gestures, f: material design, f: scrolling, framework)

[23506](https://github.com/flutter/flutter/pull/23506) Create slider with editable numerical value in gallery (cla: yes, f: material design, framework)

[23531](https://github.com/flutter/flutter/pull/23531) [O] Remove many timeouts. (a: tests, cla: yes, t: gradle, team, tool)

[23677](https://github.com/flutter/flutter/pull/23677) Add animation tests for changes to the FloatingActionButtonLocation (cla: yes, f: material design, framework)

[23759](https://github.com/flutter/flutter/pull/23759) Adds CupertinoTheme (cla: yes, f: cupertino, f: material design, framework, team: gallery)

[23782](https://github.com/flutter/flutter/pull/23782) Add flutter_shared assets to module artifact (a: assets, t: gradle, tool)

[23817](https://github.com/flutter/flutter/pull/23817) Fix project directory has spaces lead to compile error (a: existing-apps, cla: yes, tool, ▣ platform-android)

[23860](https://github.com/flutter/flutter/pull/23860) Clearing pendingImages when the cache is cleared or evicted. (cla: yes, framework)

[23889](https://github.com/flutter/flutter/pull/23889) Flutter doctor error message lookup (cla: yes, t: flutter doctor, tool)

[23919](https://github.com/flutter/flutter/pull/23919) Allow detection of taps on TabBar (cla: yes, f: material design, framework)

[24156](https://github.com/flutter/flutter/pull/24156) [Material] Bottom app bar theme (cla: yes, f: material design, framework)

[24169](https://github.com/flutter/flutter/pull/24169) [Material] Theme-able elevation on dialogs. (cla: yes, f: material design, framework)

[24209](https://github.com/flutter/flutter/pull/24209) Do not ignore pubspec.lock in project templates (cla: yes, tool)

[24440](https://github.com/flutter/flutter/pull/24440) Adding support for android app bundle - Issue #17829 (cla: no, t: gradle, tool, ▣ platform-android)

[24449](https://github.com/flutter/flutter/pull/24449) Text field style merge (cla: yes, f: material design, framework)

[24457](https://github.com/flutter/flutter/pull/24457) Revise Android and iOS gestures on Material TextField (a: text input, cla: yes, f: cupertino, f: material design, framework)

[24511](https://github.com/flutter/flutter/pull/24511) [H] Undeprecate BigInteger support, but document what it actually does. (cla: yes, framework)

[24513](https://github.com/flutter/flutter/pull/24513) Add some basic tests for evaluating expressions in `flutter test` (a: debugging, a: tests, cla: yes, tool)

[24515](https://github.com/flutter/flutter/pull/24515) Add some a basic debug stepping tests (a: debugging, cla: yes, tool)

[24527](https://github.com/flutter/flutter/pull/24527) obscureText and enableInteractiveSelection defaults (a: text input, cla: yes, framework)

[24537](https://github.com/flutter/flutter/pull/24537) Add ipv6 and observatory port support to the attach command. (cla: yes, customer: dream (g3), tool)

[24551](https://github.com/flutter/flutter/pull/24551) Add consumedScrollExtent to SliverConstraints as reported by Viewport (cla: yes, f: scrolling, framework)

[24554](https://github.com/flutter/flutter/pull/24554) Adds force press gesture detector and recognizer (cla: yes, f: gestures, framework)

[24580](https://github.com/flutter/flutter/pull/24580) Remove code signing special casing for Googlers round 2 (cla: yes, tool, ⌺‬ platform-ios)

[24581](https://github.com/flutter/flutter/pull/24581) [OR] Cleanup device lab test and remove a timeout. (cla: yes, t: hot reload, tool)

[24587](https://github.com/flutter/flutter/pull/24587) Validate style in TextField (cla: yes, f: material design, framework)

[24632](https://github.com/flutter/flutter/pull/24632) Include error message in crash reports (cla: yes, tool)

[24635](https://github.com/flutter/flutter/pull/24635) TextFormField cursor params (a: text input, cla: yes, f: material design, framework)

[24643](https://github.com/flutter/flutter/pull/24643) [H] Some minor tweaks to InputDecoration (mainly docs). (cla: yes, f: material design, framework)

[24669](https://github.com/flutter/flutter/pull/24669) Ensure that cache dirs and files have appropriate permissions (cla: yes, tool)

[24728](https://github.com/flutter/flutter/pull/24728) [H] Support setting the elevation of disabled floating action buttons (cla: yes, f: material design, framework)

[24736](https://github.com/flutter/flutter/pull/24736) [H] Provide some more locations for the FAB. (cla: yes, f: material design, framework)

[24744](https://github.com/flutter/flutter/pull/24744) drop/restore focus when app becomes invisible/visible (a: text input, cla: yes, framework)

[24746](https://github.com/flutter/flutter/pull/24746) Change the required version of adb, as older versions break hot reload. (cla: yes, tool, ▣ platform-android)

[24752](https://github.com/flutter/flutter/pull/24752) Replace platform check with switch (cla: yes, f: material design)

[24754](https://github.com/flutter/flutter/pull/24754) Replace Android-specific check with switch (cla: yes, framework, team)

[24761](https://github.com/flutter/flutter/pull/24761) Adds support for floating cursor (a: text input, cla: yes, framework)

[24767](https://github.com/flutter/flutter/pull/24767) [H] Improved positioning of leading and trailing widgets in overflowing ListTiles (cla: yes, f: material design, framework)

[24779](https://github.com/flutter/flutter/pull/24779) Skip formatters if text has not changed (a: text input, cla: yes, framework)

[24797](https://github.com/flutter/flutter/pull/24797) Iterate through potential grapheme cluster lengths in text painter (a: text input, a: typography, cla: yes, framework)

[24816](https://github.com/flutter/flutter/pull/24816) [H] ClipPath.shape and related fixes (cla: yes, f: material design, framework)

[24830](https://github.com/flutter/flutter/pull/24830) Implement hover support for mouse pointers. (cla: yes, f: gestures, framework, ⎊ platform-chromebook, ▣ platform-android)

[24848](https://github.com/flutter/flutter/pull/24848) [H] Handle errors in `compute()` by propagating them to the Future. (cla: yes, framework)

[24862](https://github.com/flutter/flutter/pull/24862) Fix semantics compiler for offstage children (a: accessibility, cla: yes, framework, severe: crash)

[24868](https://github.com/flutter/flutter/pull/24868) Clarify dart:ui dependencies in foundation library (cla: yes, d: api docs, framework)

[24876](https://github.com/flutter/flutter/pull/24876) Adds a fade in and out, rounds corners, fixes offset and fixes height of cursor on iOS (a: text input, cla: yes, f: cupertino, f: material design, framework)

[24878](https://github.com/flutter/flutter/pull/24878) Add a flutter-attach entry point for fuchsia (cla: yes, tool)

[24881](https://github.com/flutter/flutter/pull/24881) Remove offstage wording from KeepAlive (cla: yes, framework)

[24889](https://github.com/flutter/flutter/pull/24889) Update AUTHORS (cla: yes, team)

[24890](https://github.com/flutter/flutter/pull/24890) Remove deprecated lint "prefer_bool_in_asserts". (cla: yes, team)

[24892](https://github.com/flutter/flutter/pull/24892) Handle a TabBarView special case: last tab deleted before animation ends (cla: yes, f: material design, framework)

[24930](https://github.com/flutter/flutter/pull/24930) Run flutter tests through mini test engine when run directly (flutter run -t test_file) (a: tests, cla: yes, framework)

[24932](https://github.com/flutter/flutter/pull/24932) Fixed Typography null factory constructor (cla: yes, f: material design, framework)

[24941](https://github.com/flutter/flutter/pull/24941) Update Switch doc: disabled state (cla: yes, f: material design, framework)

[24942](https://github.com/flutter/flutter/pull/24942) Fix debugPrint(null) to not crash (cla: yes, framework, severe: crash)

[24944](https://github.com/flutter/flutter/pull/24944) Fix flutter root error message string interpolation (cla: yes, tool)

[24953](https://github.com/flutter/flutter/pull/24953) Fuchsia multiple devices and target (cla: yes, customer: fuchsia, tool)

[24976](https://github.com/flutter/flutter/pull/24976) Support TextField multi-line hint text #20941 (cla: yes, f: material design, framework)

[24989](https://github.com/flutter/flutter/pull/24989) Add documentation for how to use annotated region (cla: yes, d: api docs, framework)

[24993](https://github.com/flutter/flutter/pull/24993) Add InputDecoration alignLabelWithHint parameter (cla: yes, f: material design, framework)

[24994](https://github.com/flutter/flutter/pull/24994) Add polling module discovery for Fuchsia (cla: yes, tool, ○ platform-fuchsia)

[24999](https://github.com/flutter/flutter/pull/24999) Remove TextField.noMaxLength, use maxLength = -1 instead (cla: yes, f: material design, framework)

[25003](https://github.com/flutter/flutter/pull/25003) Fix typo in documentation (cla: yes, d: api docs, framework)

[25007](https://github.com/flutter/flutter/pull/25007) Warn when building on master channel (cla: yes, tool)

[25008](https://github.com/flutter/flutter/pull/25008) [Slider] Custom track, ticker, and overlay shape painters (cla: yes, f: material design, framework)

[25013](https://github.com/flutter/flutter/pull/25013) Adds a small fix to the Cupertino Navigation demo (cla: yes, team: gallery)

[25046](https://github.com/flutter/flutter/pull/25046) Add a check for build methods that return context.widget (cla: yes, framework)

[25048](https://github.com/flutter/flutter/pull/25048) Don't crash if pinned & floating AppBar has less than minExtent remainingPaintExtent (cla: yes, framework, severe: crash)

[25049](https://github.com/flutter/flutter/pull/25049) Fix behavior of handleDrawFrame() in benchmark mode. (a: tests, cla: yes, framework)

[25051](https://github.com/flutter/flutter/pull/25051) Do not fade out text for pinned & floating AppBar (cla: yes, f: material design, framework)

[25055](https://github.com/flutter/flutter/pull/25055) Include cursor in textfield intrinsic width measurement (a: text input, cla: yes, framework)

[25058](https://github.com/flutter/flutter/pull/25058) ensure lastBuildTimestamp is set before early return (cla: yes, tool)

[25076](https://github.com/flutter/flutter/pull/25076) fix: cuertino dialog action background blur effect (cla: yes, f: cupertino, framework)

[25079](https://github.com/flutter/flutter/pull/25079) Fix Podfile issue #24342 (cla: yes, tool, waiting for tree to go green, ⌺‬ platform-ios)

[25091](https://github.com/flutter/flutter/pull/25091) Add animations to SliverAppBar doc (cla: yes, d: api docs, f: material design, framework)

[25094](https://github.com/flutter/flutter/pull/25094) Include empty config message in 'flutter config' output (cla: yes, tool)

[25095](https://github.com/flutter/flutter/pull/25095) InputDecorator Count Widget (cla: yes, f: material design, framework)

[25096](https://github.com/flutter/flutter/pull/25096) Change network image URL in doc (cla: yes, d: api docs, framework)

[25120](https://github.com/flutter/flutter/pull/25120) Replace deprecated link (to design-principles page) in comment (cla: yes, d: api docs, f: material design, framework)

[25125](https://github.com/flutter/flutter/pull/25125) Add reverse functionality to repeat() of AnimationController (a: animation, cla: yes, framework)

[25126](https://github.com/flutter/flutter/pull/25126) Fix error message and other typos (cla: yes, framework)

[25154](https://github.com/flutter/flutter/pull/25154) Don't require the AVD folder to exist in order to run `flutter emulators` (cla: yes, tool, ▣ platform-android)

[25159](https://github.com/flutter/flutter/pull/25159) fix #25143 Successive calls to `precacheImage()` throw an exception (cla: yes, framework, waiting for tree to go green)

[25168](https://github.com/flutter/flutter/pull/25168) Fixed an InheritedWidget code sample typo (cla: yes, framework)

[25178](https://github.com/flutter/flutter/pull/25178) Adds favicon to Dash/Zeal docset, adds OpenSearch metadata. (cla: yes, team)

[25183](https://github.com/flutter/flutter/pull/25183) Add navigatorKey to CupertinoTabView (cla: yes, f: cupertino, framework)

[25184](https://github.com/flutter/flutter/pull/25184) Add imports section to sample code templates, and more docs. (cla: yes, team)

[25186](https://github.com/flutter/flutter/pull/25186) Temporarily add back filtered bintray ExoPlayer repository (cla: yes, team: gallery)

[25217](https://github.com/flutter/flutter/pull/25217) Fixed Spelling. (cla: yes, framework)

[25221](https://github.com/flutter/flutter/pull/25221) Support ANDROID_SDK_ROOT in addition to ANDROID_HOME (cla: yes, tool, ▣ platform-android)

[25228](https://github.com/flutter/flutter/pull/25228) IntrinsicWidth stepWidth or stepHeight == 0.0 (cla: yes, framework)

[25229](https://github.com/flutter/flutter/pull/25229) Right aligned backspace bug (a: text input, cla: yes, framework)

[25237](https://github.com/flutter/flutter/pull/25237) Fix typo (a: text input, cla: yes, d: api docs, framework)

[25238](https://github.com/flutter/flutter/pull/25238) [OR] Update links for China help (cla: yes, tool)

[25239](https://github.com/flutter/flutter/pull/25239) Call mark* methods before attaching child (cla: yes, framework, severe: crash)

[25240](https://github.com/flutter/flutter/pull/25240) Revert "Ensure that cache dirs and files have appropriate permissions" (cla: yes, tool)

[25243](https://github.com/flutter/flutter/pull/25243) Allow snippets tool to be run from arbitrary CWDs (cla: yes, d: api docs, team)

[25269](https://github.com/flutter/flutter/pull/25269) Make doctor output consistent between VS Code/IntelliJ/Android Studio when plugins are missing (cla: yes, t: flutter doctor, tool)

[25288](https://github.com/flutter/flutter/pull/25288) Revert "Add ipv6 and observatory port support to the attach command." (cla: yes, tool)

[25300](https://github.com/flutter/flutter/pull/25300) Remove uses-material-design from hello_world example (a: size, cla: yes, d: examples)

[25301](https://github.com/flutter/flutter/pull/25301) Flutter tool support for automatic saving of JIT compilation trace (cla: yes, framework, tool)

[25303](https://github.com/flutter/flutter/pull/25303) Add ipv6 and observatory port support to the attach command (cla: yes, tool)

[25305](https://github.com/flutter/flutter/pull/25305) Use stderr instead of stdout to contain errors in flutter attach test (a: tests, cla: yes)

[25332](https://github.com/flutter/flutter/pull/25332) [fuchsia] Get Dart VM service ports from The Hub (cla: yes, tool, ○ platform-fuchsia)

[25335](https://github.com/flutter/flutter/pull/25335) Revert "obscureText and enableInteractiveSelection defaults" (a: text input, cla: yes, framework)

[25339](https://github.com/flutter/flutter/pull/25339) [Material] Theme-able TextStyles for AlertDialog (cla: yes, f: material design, framework)

[25342](https://github.com/flutter/flutter/pull/25342) Revert "Revert "obscureText and enableInteractiveSelection defaults"" (a: text input, cla: yes, f: material design, framework)

[25344](https://github.com/flutter/flutter/pull/25344) Add fuchsia devices to daemon command (cla: yes, customer: fuchsia, tool)

[25345](https://github.com/flutter/flutter/pull/25345) assert(elevation >= 0.0) and doc clarifications (cla: yes, customer: fuchsia, f: material design, framework)

[25352](https://github.com/flutter/flutter/pull/25352) Revert "Adds support for floating cursor" (a: text input, cla: yes, f: cupertino, f: material design, framework)

[25380](https://github.com/flutter/flutter/pull/25380) Revert "Use stderr instead of stdout to contain errors in flutter attach test" (a: tests, cla: yes)

[25381](https://github.com/flutter/flutter/pull/25381) Add cull opacity perf test to device lab (a: tests, cla: yes, framework, severe: performance)

[25382](https://github.com/flutter/flutter/pull/25382) Revert "Call mark* methods before attaching child (#25239)" (cla: yes, framework, severe: crash)

[25384](https://github.com/flutter/flutter/pull/25384) Adds support for floating cursor (a: text input, cla: yes, f: cupertino, f: material design, framework)

[25390](https://github.com/flutter/flutter/pull/25390) Revert "drop/restore focus when app becomes invisible/visible" (a: text input, cla: yes, framework)

[25394](https://github.com/flutter/flutter/pull/25394) Update localizations (a: internationalization, cla: yes, framework)

[25395](https://github.com/flutter/flutter/pull/25395) Reland "Call mark* methods before attaching child (#25239)" (cla: yes, framework, severe: crash)

[25413](https://github.com/flutter/flutter/pull/25413) Added key.properties and *.jks to .gitignore (cla: yes, tool, waiting for tree to go green)

[25416](https://github.com/flutter/flutter/pull/25416) try disabling flutter run test (cla: yes, team)

[25440](https://github.com/flutter/flutter/pull/25440) don't warn for non-matching device discoverers (cla: yes, tool)

[25443](https://github.com/flutter/flutter/pull/25443) fix the daemon device.getDevices call (cla: yes, tool)

[25470](https://github.com/flutter/flutter/pull/25470) Support Java 1.8 (cla: yes, t: gradle, tool)

[25472](https://github.com/flutter/flutter/pull/25472) Read correct cached VM snapshot in dynamic mode (PRODUCT vs RELEASE) (cla: yes, tool)

[25473](https://github.com/flutter/flutter/pull/25473) TextField.onChanged() doc update (a: text input, cla: yes, d: api docs, framework)

[25474](https://github.com/flutter/flutter/pull/25474) fix some formatting issues (a: animation, cla: yes, f: cupertino, framework, team)

[25477](https://github.com/flutter/flutter/pull/25477) TransitionRoute.canTransitionFrom,To() doc update (cla: yes, d: api docs, f: routes, framework)

[25479](https://github.com/flutter/flutter/pull/25479) Depend on the goldens repo through git. (a: tests, cla: yes, tool)

[25482](https://github.com/flutter/flutter/pull/25482) Mark flaky tests as such (a: tests, cla: yes)

[25483](https://github.com/flutter/flutter/pull/25483) Update examples to match the new version of generated build.gradle (cla: yes, d: examples)

[25484](https://github.com/flutter/flutter/pull/25484) Fix gradle local.properties tests that were never excersized (cla: yes, t: gradle, tool)

[25488](https://github.com/flutter/flutter/pull/25488) Transition Curve Fix (a: animation, cla: yes, f: cupertino, framework)

[25489](https://github.com/flutter/flutter/pull/25489) Video demo instrumentation (a: tests, cla: yes, team: gallery)

[25512](https://github.com/flutter/flutter/pull/25512) Fix failed assert when running `flutter test` with `--start-paused` (cla: yes, tool)

[25513](https://github.com/flutter/flutter/pull/25513) make "See also" sections uniform (cla: yes, team)

[25514](https://github.com/flutter/flutter/pull/25514) fix typo (cla: yes, team)

[25515](https://github.com/flutter/flutter/pull/25515) Write snippets index file when generating docs (cla: yes, d: api docs, team)

[25516](https://github.com/flutter/flutter/pull/25516) Change flutter create to use master-docs.flutter.io instead of firebase URL. (cla: yes, tool)

[25520](https://github.com/flutter/flutter/pull/25520) Fix flutter tool to actually honor --build-number/--build-name flags (cla: yes, t: gradle, tool)

[25521](https://github.com/flutter/flutter/pull/25521) fix indentation in doc comments (cla: yes, team)

[25563](https://github.com/flutter/flutter/pull/25563) Revert "Update examples to match the new version of generated build.gradle (#25483)" (cla: yes, d: examples, t: gradle, team, team: gallery)

[25568](https://github.com/flutter/flutter/pull/25568) Fix the build (a: tests, cla: yes, team)

[25569](https://github.com/flutter/flutter/pull/25569) Reland: Update examples to match the new version of generated build.gradle (#25483) (cla: yes, d: examples, t: gradle, team)

[25573](https://github.com/flutter/flutter/pull/25573) Update DayPicker,DatePicker doc "see also" sections (cla: yes, d: api docs, f: date/time picker, f: material design, framework)

[25574](https://github.com/flutter/flutter/pull/25574) Use full textspan tree instead of top level textspan (cla: yes, framework)

[25576](https://github.com/flutter/flutter/pull/25576) Flutter tool support for building dynamic patches on Android (cla: yes, t: gradle, tool)

[25579](https://github.com/flutter/flutter/pull/25579) fix doc-comment snippets (cla: yes, team)

[25582](https://github.com/flutter/flutter/pull/25582) Add missing dependency to fix the build (cla: yes, team, team: gallery)

[25584](https://github.com/flutter/flutter/pull/25584) Fix material reference in CupertinoPicker doc (cla: yes, d: api docs, f: cupertino, framework)

[25585](https://github.com/flutter/flutter/pull/25585) Expose font fallback API in TextStyle, Roll engine 54a3577c0139..215ca1560088 (8 commits) (a: typography, cla: yes, f: material design, framework)

[25586](https://github.com/flutter/flutter/pull/25586) Report devfs stats (cla: yes, tool)

[25593](https://github.com/flutter/flutter/pull/25593) Let CupertinoTabScaffold handle keyboard insets too (cla: yes, f: cupertino, framework)

[25594](https://github.com/flutter/flutter/pull/25594) Switch over to the new name for compilation trace native function (cla: yes, framework)

[25595](https://github.com/flutter/flutter/pull/25595) Don't parse APK unless explicitly requested (cla: yes, tool)

[25604](https://github.com/flutter/flutter/pull/25604) no period after an alone reference in see also section (cla: yes, d: api docs, framework)

[25631](https://github.com/flutter/flutter/pull/25631) Default baseline build options (cla: yes, tool)

[25642](https://github.com/flutter/flutter/pull/25642) Revert dependency upgrade to see if it helps with build times and APK size (cla: yes, team, team: gallery)

[25645](https://github.com/flutter/flutter/pull/25645) Friendlier flags for Dart compilation training. (cla: yes, tool)

[25646](https://github.com/flutter/flutter/pull/25646) Revert "[O] Remove many timeouts." (a: tests, cla: yes, t: flutter driver, tool)

[25670](https://github.com/flutter/flutter/pull/25670) 3D SemanticsTree (a: accessibility, cla: yes, f: material design, framework)

[25674](https://github.com/flutter/flutter/pull/25674) Updated Shrine demo (a: tests, cla: yes, team, team: gallery)

[25678](https://github.com/flutter/flutter/pull/25678) Pin the goldens repo to a specific commit in the android_views test. (a: tests, cla: yes)

[25682](https://github.com/flutter/flutter/pull/25682) Move runner directory messages to the user messages class (a: internationalization, cla: yes, tool)

[25683](https://github.com/flutter/flutter/pull/25683) Selects a word on force tap (a: text input, cla: yes, f: cupertino, f: material design, framework)

[25718](https://github.com/flutter/flutter/pull/25718) Fix merge conflict. (cla: yes, f: material design, framework)

[25788](https://github.com/flutter/flutter/pull/25788) Add Robert Penner’s easing functions (a: animation, cla: yes, framework)

[25790](https://github.com/flutter/flutter/pull/25790) Clarify doc for AnimatedContainer (a: animation, cla: yes, d: api docs, framework)

[25792](https://github.com/flutter/flutter/pull/25792) Actively reject UiKitView gestures. (a: platform-views, cla: yes, f: gestures, framework)

[25796](https://github.com/flutter/flutter/pull/25796) Allow dynamic patches without a patch number. (cla: yes, t: gradle, tool)

[25798](https://github.com/flutter/flutter/pull/25798) remove early-stage from Gallery's About screen (cla: yes, team, team: gallery)

[25799](https://github.com/flutter/flutter/pull/25799) Make LicensePage respect the notch (cla: yes, f: material design, framework)

[25815](https://github.com/flutter/flutter/pull/25815) Flutter engine roll with dart roll (cla: yes)

[25817](https://github.com/flutter/flutter/pull/25817) fix flutter run in dev/manual_tests (a: tests, cla: yes, team)

[25849](https://github.com/flutter/flutter/pull/25849) Roll engine to f0a1d6f91 (cla: yes)

[25854](https://github.com/flutter/flutter/pull/25854) Fix analyzer "prefer const" warning. (cla: yes, team)

[25857](https://github.com/flutter/flutter/pull/25857) Mark flutter_gallery__back_button_memory as flaky. (a: tests, cla: yes, team, team: gallery)

[25863](https://github.com/flutter/flutter/pull/25863) Friendlier messages when using dynamic patching (cla: yes, tool)

[25864](https://github.com/flutter/flutter/pull/25864) Make decodeImageFromList mockable (cla: yes, framework)

[25865](https://github.com/flutter/flutter/pull/25865) [H] Add ImageStreamCompleter.hasListeners (and cleanup) (cla: yes, f: material design, framework)

[25872](https://github.com/flutter/flutter/pull/25872) Optimize cocoapods logic in flutter doctor. (cla: yes, customer: gold, tool, waiting for tree to go green, ⌺‬ platform-ios)

[25888](https://github.com/flutter/flutter/pull/25888) Extract TestBorder into a utility file (a: tests, cla: yes)

[25922](https://github.com/flutter/flutter/pull/25922) update lint list (cla: yes, team)

[25974](https://github.com/flutter/flutter/pull/25974) Add a validator to ensure NO_PROXY is set correctly if HTTP_PROXY is set (cla: yes, t: flutter doctor, tool)

[25977](https://github.com/flutter/flutter/pull/25977) Add didSendFirstFrameEvent service extension. (cla: yes, framework)

[25980](https://github.com/flutter/flutter/pull/25980) Ensure all errors thrown by image providers can be caught by developers. (cla: yes, framework)

[25984](https://github.com/flutter/flutter/pull/25984) use RRect to draw avatar check on chip (cla: yes, f: material design, framework)

[25988](https://github.com/flutter/flutter/pull/25988) Add Golden test for background painting order. (a: tests, cla: yes, engine)

[25992](https://github.com/flutter/flutter/pull/25992) Add docs to TextStyle for fontFamilyFallback/Custom font fallback (cla: yes, d: api docs, framework)

[25994](https://github.com/flutter/flutter/pull/25994) Simplify ImageStream(Completer).removeListener (cla: yes, framework)

[25995](https://github.com/flutter/flutter/pull/25995) Address code review comment. (cla: yes, team)

[26001](https://github.com/flutter/flutter/pull/26001) Add long-press-drag cursor move support for text fields (a: text input, cla: yes, f: cupertino, f: material design, framework, severe: API break)

[26015](https://github.com/flutter/flutter/pull/26015) [fuchsia] Fix flutter_gallery BUILD.gn (cla: yes, team, team: gallery)

[26017](https://github.com/flutter/flutter/pull/26017) Fix recursive link resulted `flutter doctor` stucking.  (cla: yes, customer: gold, tool, ▣ platform-android)

[26021](https://github.com/flutter/flutter/pull/26021) Fix SliverAppBar title opacity and test all cases (cla: yes, f: material design, framework)

[26024](https://github.com/flutter/flutter/pull/26024) Workaround the Gradle crash due to non ASCII characters. (cla: yes, team)

[26030](https://github.com/flutter/flutter/pull/26030) Turn clipping on for Card Demo (cla: yes, team, team: gallery)

[26031](https://github.com/flutter/flutter/pull/26031) Clean gallery about page post-1.0 (cla: yes, team, team: gallery)

[26039](https://github.com/flutter/flutter/pull/26039) Report hot reload statistics. (cla: yes, t: hot reload, tool)

[26041](https://github.com/flutter/flutter/pull/26041) Update dartdoc to 0.27.0 (cla: yes, d: api docs, team)

[26042](https://github.com/flutter/flutter/pull/26042) Update material spec references in BottomSheet et al., Scaffold (cla: yes, d: api docs, f: material design, framework)

[26069](https://github.com/flutter/flutter/pull/26069) Improve the intergrity checking for "gradle wrapper". (cla: yes, t: gradle, tool)

[26084](https://github.com/flutter/flutter/pull/26084) Improve message when saving compilation training data (cla: yes, tool)

[26088](https://github.com/flutter/flutter/pull/26088) Fix typos introduced with the TextField.onTap PR, udpated debugFillProperties (cla: yes, f: material design, framework)

[26089](https://github.com/flutter/flutter/pull/26089) Explain that BoxDecoration doesn't do clip. (cla: yes, d: api docs, framework)

[26090](https://github.com/flutter/flutter/pull/26090) Replace netls and netaddr with dev_finder (cla: yes, tool, ○ platform-fuchsia)

[26101](https://github.com/flutter/flutter/pull/26101) Fix a floating snapping SliverAppBar crash (cla: yes, f: material design, framework)

[26104](https://github.com/flutter/flutter/pull/26104) Put correct VM snapshot in APK when using cached engine (cla: yes, tool)

[26107](https://github.com/flutter/flutter/pull/26107) Better error messages for flutter tool --dynamic flag. (cla: yes, tool)

[26143](https://github.com/flutter/flutter/pull/26143) Fix DropDownButton with no items resulting in RenderFlex overflow (cla: yes, f: material design, framework)

[26153](https://github.com/flutter/flutter/pull/26153) Remove the cc @Hixie from no-response template (cla: yes, team)

[26192](https://github.com/flutter/flutter/pull/26192) [FAB] Adding FAB as class in tests. (cla: yes, f: material design, framework)

[26199](https://github.com/flutter/flutter/pull/26199) Fix tristate checkbox false to null transition, test ALL transitions (cla: yes, f: material design, framework)

[26201](https://github.com/flutter/flutter/pull/26201) Prevent calls to view.uiIsolate.flutterExit on devices which do not support it (cla: yes, tool, ○ platform-fuchsia)

[26203](https://github.com/flutter/flutter/pull/26203) Add support for reverse to ReorderableListView (cla: yes, f: material design, framework)

[26209](https://github.com/flutter/flutter/pull/26209) Revert "Teach drag start behaviors to DragGestureRecognizer (#23424)" (a: text input, cla: yes, d: examples, f: cupertino, f: gestures, f: material design, f: scrolling, framework, team: gallery)

[26227](https://github.com/flutter/flutter/pull/26227) Give integration tests unique temp folder names (a: tests, cla: yes)

[26235](https://github.com/flutter/flutter/pull/26235) rev the min dart sdk dep in the templates to 2.1.0 (cla: yes, tool)

[26238](https://github.com/flutter/flutter/pull/26238) Remove long-deprecated TwoLevelList (cla: yes, f: material design, framework, severe: API break)

[26239](https://github.com/flutter/flutter/pull/26239) Force DatePicker value to stay within firstDate and lastDate upon year change (cla: yes, f: date/time picker, framework)

[26244](https://github.com/flutter/flutter/pull/26244) move analysis_options to package (cla: yes, team)

[26246](https://github.com/flutter/flutter/pull/26246) Teach drag start behaviors to DragGestureRecognizer (cla: yes, f: gestures, f: scrolling, framework)

[26249](https://github.com/flutter/flutter/pull/26249) Revert "Replace netls and netaddr with dev_finder" (cla: yes, tool, ○ platform-fuchsia)

[26250](https://github.com/flutter/flutter/pull/26250) Reland: Switch to dev_finder (cla: yes, tool, ○ platform-fuchsia)

[26252](https://github.com/flutter/flutter/pull/26252) Manual engine roll with analyzer fixes (cla: yes)

[26257](https://github.com/flutter/flutter/pull/26257) Add link to Flutter brand guidelines (cla: yes, f: material design, framework)

[26259](https://github.com/flutter/flutter/pull/26259) Deprecate Scaffold resizeToAvoidBottomPadding, now resizeToAvoidBottomInset (cla: yes, f: material design, framework)

[26260](https://github.com/flutter/flutter/pull/26260) Fixed typo (cla: yes, d: api docs, f: material design, framework)

[26262](https://github.com/flutter/flutter/pull/26262) Declare a system message channel for Skia configuration (cla: yes, dependency: skia, framework)

[26265](https://github.com/flutter/flutter/pull/26265) Add support for detecting which modifier keys have been pressed on RawKeyboardEvents (a: text input, cla: yes, framework)

[26266](https://github.com/flutter/flutter/pull/26266) [flutter_driver] Move Fuchsia logging code. (cla: yes, t: flutter driver, tool, ○ platform-fuchsia)

[26269](https://github.com/flutter/flutter/pull/26269) Update docs for editable_text (TextField) (a: text input, cla: yes, d: api docs, f: cupertino, f: material design, framework, waiting for tree to go green)

[26270](https://github.com/flutter/flutter/pull/26270) Fix red tree (Android module) (cla: yes, t: gradle, tool)

[26271](https://github.com/flutter/flutter/pull/26271) Add compileOptions to android_host_app (a: existing-apps, a: tests, cla: yes)

[26274](https://github.com/flutter/flutter/pull/26274) Add source line to snippet metadata file (cla: yes, d: api docs)

[26285](https://github.com/flutter/flutter/pull/26285) Wrap lines at 80 characters (cla: yes, team)

[26290](https://github.com/flutter/flutter/pull/26290) Add new curve animations to class documentation (a: animation, cla: yes, d: api docs, framework, waiting for tree to go green)

[26295](https://github.com/flutter/flutter/pull/26295) Added the superellipse (a.k.a. squircle) shape to flutter. (a: fidelity, cla: yes, f: cupertino, framework)

[26297](https://github.com/flutter/flutter/pull/26297) Added 'physics' prop to Stepper. (cla: yes, f: material design, framework)

[26300](https://github.com/flutter/flutter/pull/26300) Allow bundle identifier to be surrounded with quotes. (cla: yes, tool)

[26303](https://github.com/flutter/flutter/pull/26303) Adds a type parameter to invokeMethod (and additional utility methods) (cla: yes, framework, p: framework, plugin, team)

[26309](https://github.com/flutter/flutter/pull/26309) Fix descenders cutoff in TextField (a: text input, cla: yes, framework)

[26312](https://github.com/flutter/flutter/pull/26312) Add logic for creating rollback dynamic patches. (cla: yes, t: gradle, tool, ▣ platform-android)

[26313](https://github.com/flutter/flutter/pull/26313) Fix Listenable.merge to not leak (cla: yes, framework)

[26315](https://github.com/flutter/flutter/pull/26315) Ensure that Dart SDK dirs have appropriate permissions (cla: yes, tool)

[26332](https://github.com/flutter/flutter/pull/26332) Integrate Strut: Add StrutStyle, expose Strut API, wire up strut with dart:ui, Roll engine 31a7f4d..e7eb1c8 (7 commits) (a: text input, a: typography, cla: yes, framework, severe: API break)

[26333](https://github.com/flutter/flutter/pull/26333) Add back lost gallery theme code (cla: yes, team, team: gallery, waiting for tree to go green)

[26334](https://github.com/flutter/flutter/pull/26334) mark tests as not flaky (a: tests, cla: yes, team)

[26337](https://github.com/flutter/flutter/pull/26337) chromebot recipe instructions missing a step (cla: yes, team)

[26339](https://github.com/flutter/flutter/pull/26339) Revert "Check for duplicative Flutter.framework emeddings when building for Xcode 10" (cla: yes, t: xcode, tool, ⌺‬ platform-ios)

[26376](https://github.com/flutter/flutter/pull/26376) removed image with 404 (cla: yes, team)

[26377](https://github.com/flutter/flutter/pull/26377) Restore ignore for *.lock files (cla: yes)

[26378](https://github.com/flutter/flutter/pull/26378) Friendlier flutter tool messages for dynamic mode (cla: yes, tool)

[26385](https://github.com/flutter/flutter/pull/26385) Deprecate the animated image frame cache (a: tests, cla: yes, framework)

[26386](https://github.com/flutter/flutter/pull/26386) Check response code, retry when downloading docs (cla: yes, team)

[26388](https://github.com/flutter/flutter/pull/26388) fix #26207 .gitignore only include project root build directory (cla: yes, tool)

[26389](https://github.com/flutter/flutter/pull/26389) Make sure package cache prepare does not end up creating projects inside the cloned Flutter repo (a: tests, cla: yes, team)

[26392](https://github.com/flutter/flutter/pull/26392) Avoid use of ParagraphConstrains const ctor (cla: yes, framework, team)

[26395](https://github.com/flutter/flutter/pull/26395) Emit more of HTTP error response bodies (cla: yes, team)

[26402](https://github.com/flutter/flutter/pull/26402) Let the packaging recipe use gsutil.py (cla: yes, team)

[26403](https://github.com/flutter/flutter/pull/26403) Re-enable compute credites for macOS PRs only. (cla: yes, team)

[26422](https://github.com/flutter/flutter/pull/26422) Create an injectable factory for application packages. (cla: yes, tool)

[26426](https://github.com/flutter/flutter/pull/26426) Send ServiceExtensionToggled event when service extension is set. (cla: yes, f: inspector, framework)

[26430](https://github.com/flutter/flutter/pull/26430) Roll engine e5ec3cf3ea5c..b7f6bf0192d1 (28 commits) (cla: yes)

[26436](https://github.com/flutter/flutter/pull/26436) Revert "move analysis_options to package" (cla: yes, team)

[26440](https://github.com/flutter/flutter/pull/26440) [fuchsia] Add BUILD.gn for flutter_localizations (a: internationalization, cla: yes, framework)

[26441](https://github.com/flutter/flutter/pull/26441) Fix some doc references (cla: yes, d: api docs, f: cupertino, framework)

[26444](https://github.com/flutter/flutter/pull/26444) Update compileSdkVersion in the Android app templates to Android P (cla: yes, tool, ▣ platform-android)

[26449](https://github.com/flutter/flutter/pull/26449) Add asserts for @required parameters (cla: yes, framework, team)

[26450](https://github.com/flutter/flutter/pull/26450) Add a manifest for profile builds that enables INTERNET permission (cla: yes, tool, ▣ platform-android)

[26454](https://github.com/flutter/flutter/pull/26454) Cleanup temporary catchError. (cla: yes, framework)

[26456](https://github.com/flutter/flutter/pull/26456) `flutter create --template=plugin` now includes flutter (dart) unit test (cla: yes, tool)

[26482](https://github.com/flutter/flutter/pull/26482) Grammatical fix: "places" to "placed" (cla: yes, d: api docs, framework)

[26511](https://github.com/flutter/flutter/pull/26511) desktop workflow, devices, and test (cla: yes, tool, ⌘‬ platform-mac, ❖ platform-windows, 🐧 platform-linux)

[26519](https://github.com/flutter/flutter/pull/26519) Skip `flutter test` expression eval tests (a: tests, cla: yes, tool)

[26533](https://github.com/flutter/flutter/pull/26533) [Material] TabBarTheme text style parameters (cla: yes, f: material design, framework)

[26537](https://github.com/flutter/flutter/pull/26537) Report overall and transfer timings as part of hot reload statistics,… (cla: yes, t: hot reload, tool)

[26539](https://github.com/flutter/flutter/pull/26539) Narrow regexp for import search in bot's analyze script. (cla: yes, team)

[26545](https://github.com/flutter/flutter/pull/26545) remove ignore_for_file lints (cla: yes, team)

[26546](https://github.com/flutter/flutter/pull/26546) Update dartdoc to 0.28.0 and add flags to constrain warnings (cla: yes, d: api docs, team)

[26550](https://github.com/flutter/flutter/pull/26550) Remove incorrect Coveralls badge. (cla: yes, team)

[26559](https://github.com/flutter/flutter/pull/26559) add type parameter back to PageRouteFactory (cla: yes, team)

[26562](https://github.com/flutter/flutter/pull/26562) Remove todo from Podhelpr.rb (cla: yes, team)

[26565](https://github.com/flutter/flutter/pull/26565) Emulator support for dynamic mode on Intel architecture (cla: yes, tool, ▣ platform-android)

[26579](https://github.com/flutter/flutter/pull/26579) Fix+unskip `flutter test` expression eval tests (cla: yes, tool)

[26586](https://github.com/flutter/flutter/pull/26586) Added Sample code for Stack widget (cla: yes, d: api docs, framework)

[26589](https://github.com/flutter/flutter/pull/26589) Do not exit tool if parts of fuchsia workflow fail (cla: yes, tool, ○ platform-fuchsia)

[26592](https://github.com/flutter/flutter/pull/26592) Prevent crash when calling lerp for IconThemeData with null arguments (cla: yes, framework)

[26593](https://github.com/flutter/flutter/pull/26593) Support running macOS prebuilt application (cla: yes, tool, ⌘‬ platform-mac)

[26596](https://github.com/flutter/flutter/pull/26596) Roll engine to 5983e34a3c0e1217da7e8bbe9f2fe685048fe259 (cla: yes)

[26597](https://github.com/flutter/flutter/pull/26597) [Material] Implement App Bar Theme (cla: yes, f: material design, framework)

[26598](https://github.com/flutter/flutter/pull/26598) Add tests for getOffsetToReveal on RenderSlivers (a: tests, cla: yes, framework, severe: crash)

[26604](https://github.com/flutter/flutter/pull/26604) Adding a shutdown hook to HotRunnerConfig (cla: yes, tool)

[26605](https://github.com/flutter/flutter/pull/26605) Implemented Dark Mode for Android (#25525) (cla: yes, f: material design, framework, ▣ platform-android)

[26611](https://github.com/flutter/flutter/pull/26611) IconButton backgroundColor doc sample (cla: yes, d: api docs, f: material design, framework)

[26612](https://github.com/flutter/flutter/pull/26612) Remove TODO, reduce tech debt (cla: yes, team)

[26613](https://github.com/flutter/flutter/pull/26613) Updated AlertDialog content doc (cla: yes, f: material design, framework)

[26629](https://github.com/flutter/flutter/pull/26629) [HX] Quick fix for tap-to-show-keyboard regression (a: text input, cla: yes, f: gestures, f: material design, framework, ⚠ TODAY)

[26630](https://github.com/flutter/flutter/pull/26630) Move flutter_assets to App.framework (a: existing-apps, cla: yes, t: xcode, tool, ⌺‬ platform-ios)

[26642](https://github.com/flutter/flutter/pull/26642) Fix --build-shared-library on newer NDKs (cla: yes, tool, ▣ platform-android)

[26644](https://github.com/flutter/flutter/pull/26644) Revert "Add flutter_shared assets to module artifact (#23782)" (a: assets, cla: yes, t: gradle, tool)

[26650](https://github.com/flutter/flutter/pull/26650) Wrap dart:convert to track utf8 decode failures (cla: yes, tool)

[26652](https://github.com/flutter/flutter/pull/26652) Fix rounding error in build tests (a: tests, a: text input, cla: yes, framework)

[26659](https://github.com/flutter/flutter/pull/26659) Adds fix for NAN value and pressure values outside of device reported min and max (a: text input, cla: yes, f: gestures, framework, waiting for tree to go green)

[26663](https://github.com/flutter/flutter/pull/26663) Make getOffsetToReveal work with nested Viewports (cla: yes, f: scrolling, framework)

[26668](https://github.com/flutter/flutter/pull/26668) [Gradle] Copy ICU data to flutter_shared only when building an AAR module (cla: yes, t: gradle, tool)

[26669](https://github.com/flutter/flutter/pull/26669) Register hotRestart service in flutter_tools. (cla: yes, tool)

[26675](https://github.com/flutter/flutter/pull/26675) Revert "Move flutter_assets to App.framework (#26630)" (a: existing-apps, cla: yes, t: xcode, tool)

[26680](https://github.com/flutter/flutter/pull/26680) [frdp] Adds paths for `find` and `ls` for Fuchsia execution. (cla: yes, team, tool, ○ platform-fuchsia)

[26690](https://github.com/flutter/flutter/pull/26690) Doc fix: SliverChildBuilderDelegate is the lazy one (cla: yes, d: api docs, f: scrolling, framework)

[26693](https://github.com/flutter/flutter/pull/26693) Add another test to ImageStream (a: tests, cla: yes, framework, waiting for tree to go green)

[26694](https://github.com/flutter/flutter/pull/26694) Roll engine back to 1e93a8eb39d79f643952737aa4fc31e1787a5a17 (cla: yes, engine, team)

[26702](https://github.com/flutter/flutter/pull/26702) Update test temp folder name to be more consistent with others (a: tests, cla: yes, tool)

[26713](https://github.com/flutter/flutter/pull/26713) Roll engine to 05fee4eeee0ff6b219b1fcc394371e5f6963cc46 (a: assets, cla: yes, tool, ⌺‬ platform-ios)

[26715](https://github.com/flutter/flutter/pull/26715) Experimental flags in flutter (cla: yes, tool)

[26716](https://github.com/flutter/flutter/pull/26716) Fix missing const analyzer warning (a: tests, cla: yes, team)

[26720](https://github.com/flutter/flutter/pull/26720) Allow attaching to profile builds (cla: yes, tool)

[26721](https://github.com/flutter/flutter/pull/26721) Respect EditableText.keyboardAppearance (a: text input, cla: yes, f: cupertino, framework)

[26722](https://github.com/flutter/flutter/pull/26722) [Material] Refactor _build<Widget> methods in BottomNavBar (cla: yes, f: material design, framework)

[26727](https://github.com/flutter/flutter/pull/26727) Roll engine to d470fc65ea1cb91ae66706b320d82c4536a4da8b (cla: yes)

[26734](https://github.com/flutter/flutter/pull/26734) Reverts default DragStartBehavior to DragStartBehavior.down (a: text input, cla: yes, f: cupertino, f: material design, f: scrolling, framework)

[26736](https://github.com/flutter/flutter/pull/26736) [O] Removing all timeouts (mark II) (a: tests, cla: yes, framework, t: flutter driver, team, tool)

[26737](https://github.com/flutter/flutter/pull/26737) Use Cirrus image's fastlane instead of freezing our own set of gem dependencies (cla: yes, team, team: gallery)

[26763](https://github.com/flutter/flutter/pull/26763) Close the Scaffold drawer in scroll_perf_test.dart (cla: yes, team)

[26764](https://github.com/flutter/flutter/pull/26764) Fix lerp in textTheme to allow for null parameters (cla: yes, f: material design, framework)

[26765](https://github.com/flutter/flutter/pull/26765) [Material] Inline the single Theme.of(context) call in BAB (cla: yes, f: material design, framework)

[26766](https://github.com/flutter/flutter/pull/26766) Report early error if appropriate host local engine is not found. (cla: yes, tool)

[26770](https://github.com/flutter/flutter/pull/26770) Revert switch drag behavior (cla: yes, f: material design, framework)

[26774](https://github.com/flutter/flutter/pull/26774) [cupertino_icons] add car, bus, train, paw, controller, and flask icons. (cla: yes, f: cupertino, framework)

[26778](https://github.com/flutter/flutter/pull/26778) Better ListTile leading/trailing widget alignment (cla: yes, f: material design, framework)

[26790](https://github.com/flutter/flutter/pull/26790) Rev Android Platform to 28 for bots (cla: yes, t: gradle, team)

[26793](https://github.com/flutter/flutter/pull/26793) Fill editable_text.dart test coverage (a: tests, a: text input, cla: yes, framework)

[26795](https://github.com/flutter/flutter/pull/26795) Update VERSION_LINUX_SDK (cla: yes, team, 🐧 platform-linux)

[26796](https://github.com/flutter/flutter/pull/26796) [Material] Theme data type for cards (cla: yes, f: material design, framework)

[26797](https://github.com/flutter/flutter/pull/26797) Update VERSION_WIN_SDK (cla: yes, team, ❖ platform-windows)

[26798](https://github.com/flutter/flutter/pull/26798) targetSdkVersion 28 (cla: yes, d: examples, team, ▣ platform-android)

[26807](https://github.com/flutter/flutter/pull/26807) #19060 Update material.google.com links to material.io (cla: yes, d: api docs, f: material design, framework, team)

[26808](https://github.com/flutter/flutter/pull/26808) Add Checkbox checkIcon color parameter (cla: yes, f: material design, framework)

[26809](https://github.com/flutter/flutter/pull/26809) Fix test expectations per change made in #26736 (cla: yes, team)

[26819](https://github.com/flutter/flutter/pull/26819) Refactor android launchable activity extractor logic (cla: yes, customer: gold, tool, waiting for tree to go green, ▣ platform-android)

[26826](https://github.com/flutter/flutter/pull/26826) Avoid calling `cancel` on `AnsiSpinner` more than once when building for iOS (cla: yes, tool, ⌘‬ platform-mac, ⌺‬ platform-ios)

[26840](https://github.com/flutter/flutter/pull/26840) Support using flutter with specific version (cla: yes, tool)

[26883](https://github.com/flutter/flutter/pull/26883) Move Circle CI badge next to heading in Readme (cla: yes, team)

[26896](https://github.com/flutter/flutter/pull/26896) Add uiMode to android:configChanges (cla: yes, team, tool, ▣ platform-android)

[26898](https://github.com/flutter/flutter/pull/26898) make FDE opt-in via the environment variable (cla: yes, tool)

[26900](https://github.com/flutter/flutter/pull/26900) Make reassemble public (cla: yes, framework)

[26901](https://github.com/flutter/flutter/pull/26901) Add Dismissible.confirmDismiss callback (cla: yes, f: material design, framework)

[26904](https://github.com/flutter/flutter/pull/26904) Fix immediately overriding the user's chosen AM/PM selection (cla: yes, f: cupertino, f: date/time picker, framework, waiting for tree to go green)

[26911](https://github.com/flutter/flutter/pull/26911) Dismissible not dismissable (cla: yes, team, team: gallery)

[26913](https://github.com/flutter/flutter/pull/26913) Upgrade the Gradle script to Android plugin version 3.3.0 (cla: yes, team)

[26921](https://github.com/flutter/flutter/pull/26921) fix some bad indentations (cla: yes, team)

[26926](https://github.com/flutter/flutter/pull/26926) Roll engine to 10eb972fc15b8a3f97ed7c26032cae03b10fca2c (cla: yes)

[26932](https://github.com/flutter/flutter/pull/26932) Make UriMapper and StdoutHandler public and add test cases (cla: yes, tool)

[26938](https://github.com/flutter/flutter/pull/26938) Fix gradle verbose error. (cla: yes, customer: gold, t: gradle, tool, waiting for tree to go green)

[26942](https://github.com/flutter/flutter/pull/26942) Detect Android SDK 28/28.0.3 (a: first hour, cla: yes, t: flutter doctor, tool, waiting for tree to go green, ▣ platform-android)

[26944](https://github.com/flutter/flutter/pull/26944) Use mDNS to discover the device port (cla: yes, tool, ⌺‬ platform-ios)

[26964](https://github.com/flutter/flutter/pull/26964) Refactor logic to get plugins path for android studio in mac (cla: yes, customer: gold, t: gradle, tool, waiting for tree to go green, ▣ platform-android)

[26967](https://github.com/flutter/flutter/pull/26967) Use site-shared as canonical source for Flutter logo (cla: yes, team)

[26970](https://github.com/flutter/flutter/pull/26970) Fix a problem that: `PODS_ROOT` not defined because that Debug.xcconfig misses Flutter environment (cla: yes, customer: gold, t: xcode, tool, waiting for tree to go green, ⌺‬ platform-ios)

[26978](https://github.com/flutter/flutter/pull/26978) Add flutter_build package for codegen and version sync with tool (cla: yes, tool)

[26988](https://github.com/flutter/flutter/pull/26988) Experimental flags for hot reloads (cla: yes, t: hot reload, tool)

[26989](https://github.com/flutter/flutter/pull/26989) Add experimentalBuildEnabled flag and initial shim for build_runner (cla: yes, tool)

[26990](https://github.com/flutter/flutter/pull/26990) Re-enable use of ParagraphConstrains const ctor (cla: yes, framework, team)

[26991](https://github.com/flutter/flutter/pull/26991) Assert when calling a method that tries to use the ticker unsafely after dispose (a: animation, a: debugging, cla: yes, framework, waiting for tree to go green)

[26993](https://github.com/flutter/flutter/pull/26993) Add WorkspaceSettings.xcsettings for stocks app (cla: yes, d: examples)

[26996](https://github.com/flutter/flutter/pull/26996) Explain font platform inconsistency (cla: yes, d: api docs, framework)

[27003](https://github.com/flutter/flutter/pull/27003) Add more RenderEditable test coverage (a: tests, a: text input, cla: yes, framework)

[27032](https://github.com/flutter/flutter/pull/27032) Pass --verify-entry-points in debug mode. (cla: yes, tool)

[27037](https://github.com/flutter/flutter/pull/27037) Revert "Experimental flags for hot reloads" (cla: yes, t: hot reload, tool)

[27039](https://github.com/flutter/flutter/pull/27039) Improve documentation on decodeSyslog (cla: yes, tool, ⌺‬ platform-ios)

[27042](https://github.com/flutter/flutter/pull/27042) Updated DropdownButton docs (cla: yes, f: material design, framework)

[27043](https://github.com/flutter/flutter/pull/27043) Experimental flags for hot reloads, fixed (cla: yes, t: hot reload, tool)

[27045](https://github.com/flutter/flutter/pull/27045) Revert "Upgrade the Gradle script to Android plugin version 3.3.0 (#26913)" (cla: yes, t: gradle, team)

[27046](https://github.com/flutter/flutter/pull/27046) Update packages (cla: yes, team)

[27049](https://github.com/flutter/flutter/pull/27049) Roll engine to 31c79171796c7d24d5f81033db77e25f95c45a64 (cla: yes)

[27053](https://github.com/flutter/flutter/pull/27053) Modify offline docs platform family for Dash/Zeal (cla: yes, team)

[27054](https://github.com/flutter/flutter/pull/27054) Update flutter clean to remove .dart_tool directory (cla: yes, tool)

[27058](https://github.com/flutter/flutter/pull/27058) Add arguments for pushing named routes (cla: yes, d: examples, f: routes, framework, waiting for tree to go green)

[27059](https://github.com/flutter/flutter/pull/27059) Revert "Experimental flags for hot reloads, fixed" (cla: yes, t: hot reload, tool)

[27093](https://github.com/flutter/flutter/pull/27093) Update readmes for stocks/gallery (cla: yes, d: examples, team, team: gallery)

[27096](https://github.com/flutter/flutter/pull/27096) Revert "Warn when building on master channel (#25007)" (cla: yes, tool)

[27097](https://github.com/flutter/flutter/pull/27097) Typo fixes for notched_shapes.dart (cla: yes, framework)

[27111](https://github.com/flutter/flutter/pull/27111) format initializer list of constructors (cla: yes, team)

[27112](https://github.com/flutter/flutter/pull/27112) prevent _computeColumnWidths from getting stuck due to double precision (cla: yes, framework)

[27113](https://github.com/flutter/flutter/pull/27113) Fix gsutil.py call for windows (cla: yes, team)

[27114](https://github.com/flutter/flutter/pull/27114) Adds haptic vibration to Cupertino switch (cla: yes, f: cupertino, framework)

[27116](https://github.com/flutter/flutter/pull/27116) Add some instructions to the README for packaging archives locally (cla: yes, team)

[27122](https://github.com/flutter/flutter/pull/27122) Add module checking (cla: yes, tool)

[27140](https://github.com/flutter/flutter/pull/27140) Add docs and sample for takeException (a: tests, cla: yes, d: api docs)

[27154](https://github.com/flutter/flutter/pull/27154) Add2App: Fix crash resulted from hard-code module 'app'  (a: existing-apps, cla: yes, customer: gold, t: gradle, tool)

[27169](https://github.com/flutter/flutter/pull/27169)  Update an IconButton sample, add RaisedButton sample (cla: yes, d: api docs, f: material design, framework)

[27181](https://github.com/flutter/flutter/pull/27181) Change "Starting Xcode build" status text to "Running xcode build" (cla: yes, t: xcode, tool, ⌘‬ platform-mac)

[27186](https://github.com/flutter/flutter/pull/27186) Improve unsupported text (cla: yes, tool)

[27191](https://github.com/flutter/flutter/pull/27191) Revert f9e6242db (#26944) (cla: yes, tool)

[27195](https://github.com/flutter/flutter/pull/27195) PopupMenuDivider.represents() paramter must be void, not Null (cla: yes, f: material design, framework)

[27197](https://github.com/flutter/flutter/pull/27197) Add default values for optional parameters. (cla: yes, team)

[27199](https://github.com/flutter/flutter/pull/27199) Remove obsolete ignore: (cla: yes, framework, team)

[27207](https://github.com/flutter/flutter/pull/27207) Add support for multiroot scheme to PackageUriMapper (cla: yes, tool)

[27208](https://github.com/flutter/flutter/pull/27208) Add a flag to enable tracing to systrace. (cla: yes, tool, ▣ platform-android)

[27211](https://github.com/flutter/flutter/pull/27211) Inject KernelCompiler via KernelCompilerFactory (cla: yes, tool)

[27252](https://github.com/flutter/flutter/pull/27252) Add support for experimental flags during hot reload. (cla: yes, t: hot reload, tool)

[27253](https://github.com/flutter/flutter/pull/27253) [flutter_tool,doctor] Fix and test gen_snapshot failure message (cla: yes, tool)

[27256](https://github.com/flutter/flutter/pull/27256) Update additionalTime in TestWidgetsFlutterBinding.runAsync() to 1000. (a: tests, cla: yes, team)

[27257](https://github.com/flutter/flutter/pull/27257) Add basic codegen app to be used for integration testing and benchmarks (a: tests, cla: yes, tool)

[27260](https://github.com/flutter/flutter/pull/27260) Update Align docs (cla: yes, framework, waiting for tree to go green)

[27261](https://github.com/flutter/flutter/pull/27261) format parameter list (cla: yes, team)

[27271](https://github.com/flutter/flutter/pull/27271) Remove all obsolete "// ignore:" (cla: yes, team, waiting for tree to go green)

[27272](https://github.com/flutter/flutter/pull/27272) Fix asserts for initialDateTime in CupertinoDatePicker (cla: yes, f: cupertino, f: date/time picker, framework, waiting for tree to go green)

[27274](https://github.com/flutter/flutter/pull/27274) Add missing comma to fix build (cla: yes, d: api docs, framework)

[27277](https://github.com/flutter/flutter/pull/27277) Use flutter_tools to generate build_script (cla: yes, tool)

[27278](https://github.com/flutter/flutter/pull/27278) Make version documentation clearer. (cla: yes, tool)

[27295](https://github.com/flutter/flutter/pull/27295) Handle missing curl (cla: yes, tool)

[27297](https://github.com/flutter/flutter/pull/27297) Add Material/Card borderOnForeground flag to allow border to be painted behind the child widget (cla: yes, f: material design, framework)

[27305](https://github.com/flutter/flutter/pull/27305) Outline for survey implementation (cla: yes, d: api docs, team)

[27316](https://github.com/flutter/flutter/pull/27316) Add elevation to Chips to allow for more flexibility (cla: yes, f: material design, framework)

[27319](https://github.com/flutter/flutter/pull/27319) Don't send accept/reject if compilation never started. (cla: yes, tool)

[27322](https://github.com/flutter/flutter/pull/27322) Fix typo in WrapAlignment documentation (cla: yes, d: api docs, framework, waiting for tree to go green)

[27323](https://github.com/flutter/flutter/pull/27323) don't pass the --packages-dir flag (cla: yes, tool)

[27365](https://github.com/flutter/flutter/pull/27365) Updated focus handling for nested FocusScopes (cla: yes)

[27367](https://github.com/flutter/flutter/pull/27367) Update shrine login screen so that cancel dismisses the route (cla: yes, team, team: gallery)

[27374](https://github.com/flutter/flutter/pull/27374) Lazily download artifacts: The Phantom Menace  (cla: yes, tool)

[27376](https://github.com/flutter/flutter/pull/27376) Material.border type is now BorderRadiusGeometry (cla: yes, f: material design, framework)

[27378](https://github.com/flutter/flutter/pull/27378) Make the deviceDiscovery API overridable (cla: yes, tool)

[27381](https://github.com/flutter/flutter/pull/27381) Fix bug in UnconstrainedBox class debugFillProperties (a: debugging, cla: yes, framework)

[27387](https://github.com/flutter/flutter/pull/27387) Track InheritedElement dependencies in diagnostic properties (cla: yes, framework)

[27389](https://github.com/flutter/flutter/pull/27389) Enable dependency injection of Window instead of using static property (cla: yes)

[27399](https://github.com/flutter/flutter/pull/27399) Add elevation/pressElevation to ChipThemeData (cla: yes, f: material design, framework)

[27400](https://github.com/flutter/flutter/pull/27400) Ensure Shrine app respects the platform toggle from Gallery options (cla: yes, team, team: gallery)

[27409](https://github.com/flutter/flutter/pull/27409) Ensure all curves return 0 and 1 in .transform(t) when t=0/1 (a: animation, cla: yes, framework, waiting for tree to go green)

[27410](https://github.com/flutter/flutter/pull/27410) Disable usage of bare instructions in AOT (cla: yes, tool)

[27413](https://github.com/flutter/flutter/pull/27413) Fix typo "when when" (cla: yes, d: api docs, framework)

[27424](https://github.com/flutter/flutter/pull/27424) [H] Expose "center" on CustomScrollView (cla: yes, f: date/time picker, f: scrolling)

[27425](https://github.com/flutter/flutter/pull/27425) [HR] Clean up matters related to "offstageness". (cla: yes, framework)

[27432](https://github.com/flutter/flutter/pull/27432) Remove leftover of GlobalKey removal listeners (cla: yes, framework)

[27433](https://github.com/flutter/flutter/pull/27433) Fix issue where SliverPersistentHeader that is both floating and pinned would scroll down when scrolling past the beginning of the ScrollView (cla: yes, f: scrolling, framework, waiting for tree to go green)

[27471](https://github.com/flutter/flutter/pull/27471) Refactor ios bundleid/android application process logic. (cla: yes, tool)

[27477](https://github.com/flutter/flutter/pull/27477) [H] Tabs (cla: yes, f: material design, framework)

[27481](https://github.com/flutter/flutter/pull/27481) Move Brightness to dart:ui in the engine (#27479). (cla: yes, framework)

[27487](https://github.com/flutter/flutter/pull/27487) [H] Make NotchedShape more practical to use (cla: yes, f: material design, framework)

[27501](https://github.com/flutter/flutter/pull/27501) Update docs for initstate(), didUpdateWidget(), dispose() (cla: yes, d: api docs, framework)

[27502](https://github.com/flutter/flutter/pull/27502) Make a kReleaseMode constant that is public. (cla: yes, framework)

[27504](https://github.com/flutter/flutter/pull/27504) Added support for the Galician language (material_es_GL.arb) (a: internationalization, cla: yes, framework)

[27505](https://github.com/flutter/flutter/pull/27505) Remove icudtl.dat from APK asset size checks (cla: yes, team)

[27506](https://github.com/flutter/flutter/pull/27506) Added support for Swahili (material_sw.arb) (a: internationalization, cla: yes, framework)

[27509](https://github.com/flutter/flutter/pull/27509) Removed double the (cla: yes, d: api docs, f: material design, framework)

[27510](https://github.com/flutter/flutter/pull/27510) [Material] Allow slider shapes to be easily resized (cla: yes, f: material design, framework)

[27511](https://github.com/flutter/flutter/pull/27511) Update dartdoc to 0.28.1+1 and add parameters for source-code linking (cla: yes, team)

[27513](https://github.com/flutter/flutter/pull/27513) Add scroll performance test for flutter_gallery (cla: yes, team)

[27519](https://github.com/flutter/flutter/pull/27519) Update OutlineButton on-pressed fill color (cla: yes, f: material design, framework)

[27528](https://github.com/flutter/flutter/pull/27528) Fixed Cupertino Switch Demo (cla: yes, f: cupertino, framework, waiting for tree to go green)

[27531](https://github.com/flutter/flutter/pull/27531) Print 50000$ monopoly money (cla: yes, tool, waiting for tree to go green)

[27532](https://github.com/flutter/flutter/pull/27532) Add @isTest to Flutter's wrappers over group/test (a: tests, cla: yes)

[27534](https://github.com/flutter/flutter/pull/27534) Stop using SelectionChangedCause internally to show the text selection toolbar (a: text input, cla: yes, f: cupertino, f: material design, framework, severe: API break)

[27553](https://github.com/flutter/flutter/pull/27553) Use CP_REPOS_DIR if it's set (cla: yes, tool, ⌺‬ platform-ios)

[27556](https://github.com/flutter/flutter/pull/27556) update flutter and flutter.bat command to suggest stable branch (cla: yes, tool)

[27559](https://github.com/flutter/flutter/pull/27559) Update dartdoc to 0.28.1+2 and fix search text alignment (cla: yes, team)

[27564](https://github.com/flutter/flutter/pull/27564) Fix window bug in _sendPlatformMessage() (#27541). (cla: yes, framework, p: framework)

[27566](https://github.com/flutter/flutter/pull/27566) Warn when gradle builds fail because of AndroidX (cla: yes, t: gradle, tool)

[27568](https://github.com/flutter/flutter/pull/27568) Fix initial scroll of TabBar in release mode (cla: yes, f: material design, f: scrolling, framework)

[27569](https://github.com/flutter/flutter/pull/27569) Bugfix: Add platformBrightness to TestWindow. (a: tests, cla: yes)

[27570](https://github.com/flutter/flutter/pull/27570) Small cleanup in CupertinoSliverRefreshControl (cla: yes, f: cupertino, framework)

[27573](https://github.com/flutter/flutter/pull/27573) Let text selection toolbar buttons be independent from theme (cla: yes, f: cupertino, framework)

[27575](https://github.com/flutter/flutter/pull/27575) Update OutlineButton default border width and highlight elevation (cla: yes, f: material design, framework)

[27576](https://github.com/flutter/flutter/pull/27576) Handle CupertinoTabScaffold rebuilds with deleted tabs (cla: yes, f: cupertino, framework)

[27577](https://github.com/flutter/flutter/pull/27577) [flutter_driver] Use async call to run SSH cmds w/o deadlock. (cla: yes, t: flutter driver, tool, ○ platform-fuchsia)

[27588](https://github.com/flutter/flutter/pull/27588) CupertinoSliverRefreshControl inactive overscroll behavior (cla: yes, f: cupertino, framework, waiting for tree to go green)

[27596](https://github.com/flutter/flutter/pull/27596) Check powershell version. (cla: yes, tool, waiting for tree to go green, ❖ platform-windows)

[27604](https://github.com/flutter/flutter/pull/27604) Update material Galician (gl) translations filename (a: internationalization, cla: yes, framework)

[27607](https://github.com/flutter/flutter/pull/27607) Remove build runner from injection (cla: yes, tool)

[27613](https://github.com/flutter/flutter/pull/27613) [Material] Simple API for skipping over certain Slider shapes (cla: yes, f: material design, framework)

[27615](https://github.com/flutter/flutter/pull/27615) fix list devices throwing on junk input (cla: yes, tool, ○ platform-fuchsia)

[27616](https://github.com/flutter/flutter/pull/27616) minor doc fixes for overlay (cla: yes, framework)

[27620](https://github.com/flutter/flutter/pull/27620) Add a keyboard key code generator. (cla: yes, tool)

[27623](https://github.com/flutter/flutter/pull/27623) Make FlexibleSpaceBar title padding configurable (cla: yes, f: material design, framework)

[27627](https://github.com/flutter/flutter/pull/27627) Adding support for logical and physical key events (cla: yes, framework)

[27632](https://github.com/flutter/flutter/pull/27632) Null check logic for datatable. (cla: yes, f: material design, framework)

[27647](https://github.com/flutter/flutter/pull/27647) Fixed #27621: CupertinoTimerPicker breaks if minuteInterval > 1 (cla: yes, f: cupertino, framework)

[27648](https://github.com/flutter/flutter/pull/27648) Make sample analyzer more friendly for running locally. (cla: yes, team)

[27659](https://github.com/flutter/flutter/pull/27659) fix small typo (cla: yes, framework, waiting for tree to go green)

[27661](https://github.com/flutter/flutter/pull/27661) Add build_runner_core to flutter_tools BUILD.gn (cla: yes, tool)

[27663](https://github.com/flutter/flutter/pull/27663) TextField should only set EditableText.cursorOffset for iOS (a: text input, cla: yes, f: material design, framework)

[27665](https://github.com/flutter/flutter/pull/27665) Add desktop devices to daemon behind flag (cla: yes, tool)

[27668](https://github.com/flutter/flutter/pull/27668) Wire dart2js through flutter tool, add compilation test (cla: yes, tool)

[27672](https://github.com/flutter/flutter/pull/27672) Support for building dynamic patches in AOT mode. (cla: yes, tool)

[27687](https://github.com/flutter/flutter/pull/27687) Add android studio process logic for JetBrainsToolbox (cla: yes, customer: gold, tool, ▣ platform-android, ⚠ TODAY)

[27690](https://github.com/flutter/flutter/pull/27690) remove super_goes_last (cla: yes, team)

[27691](https://github.com/flutter/flutter/pull/27691) Fix Xcode_backend.sh for flavors (cla: yes, t: xcode, tool, waiting for tree to go green, ⌺‬ platform-ios)

[27697](https://github.com/flutter/flutter/pull/27697) Cupertino TextField Cursor Fix (a: text input, cla: yes, f: cupertino, framework)

[27699](https://github.com/flutter/flutter/pull/27699) [Material] Update the card demo in the Gallery to demonstrate different uses of the Card widget (cla: yes, f: material design, framework, team, team: gallery)

[27703](https://github.com/flutter/flutter/pull/27703) Add builder parameter to showDatePicker, showTimePicker (cla: yes, f: date/time picker, f: material design, framework)

[27705](https://github.com/flutter/flutter/pull/27705) Revert "Lazily download artifacts" (cla: yes, tool)

[27708](https://github.com/flutter/flutter/pull/27708) remove build_runner_core import from flutter_tools (cla: yes, tool)

[27709](https://github.com/flutter/flutter/pull/27709) Increase our build budget to 16ms (cla: yes, t: flutter driver, tool)

[27717](https://github.com/flutter/flutter/pull/27717) Refactor "no ios devices attached" logic. (cla: yes, tool, ⌺‬ platform-ios)

[27735](https://github.com/flutter/flutter/pull/27735) Lazily download artifacts (Part II): The Clone Wars (cla: yes, tool)

[27743](https://github.com/flutter/flutter/pull/27743) Refactor build-number/build-name logic. (cla: yes, t: gradle, t: xcode, tool)

[27752](https://github.com/flutter/flutter/pull/27752) Adding horizontal and vertical scale parameter to ScaleUpdateDetails. (cla: yes, f: gestures, framework, waiting for tree to go green)

[27754](https://github.com/flutter/flutter/pull/27754) Add support for binary compression of dynamic patches by the flutter tool. (cla: yes, t: gradle, tool)

[27765](https://github.com/flutter/flutter/pull/27765) Refactor local engine logic (cla: yes, t: xcode, tool, ⌺‬ platform-ios)

[27773](https://github.com/flutter/flutter/pull/27773) DatePicker noon/midnight overflow fix (cla: yes, f: cupertino, f: date/time picker, framework)

[27789](https://github.com/flutter/flutter/pull/27789) Revert "Disable usage of bare instructions in AOT (#27410)" (cla: yes, tool)

[27793](https://github.com/flutter/flutter/pull/27793) Remove remaining "### Sample code" segments, and fix the snippet generator. (cla: yes, d: api docs, team)

[27800](https://github.com/flutter/flutter/pull/27800) Prevent tests from importing other tests. (a: tests, cla: yes, team)

[27803](https://github.com/flutter/flutter/pull/27803) Added sample code to AnimatedWidget (a: animation, cla: yes, d: api docs, framework, waiting for tree to go green)

[27808](https://github.com/flutter/flutter/pull/27808) Manual Engine roll for flutter/engine#7791 - Add trailing whitespace tracking. (a: text input, cla: yes, framework)

[27812](https://github.com/flutter/flutter/pull/27812) Pass method used to start flutter application (cla: yes, tool)

[27817](https://github.com/flutter/flutter/pull/27817) Optimize flutter run logic for iOS by "ONLY_ACTIVE_ARCH=YES" if possible (cla: yes)

[27818](https://github.com/flutter/flutter/pull/27818) Fix Dashing rules to use new dartdoc CSS entity markers. (cla: yes, d: api docs, team)

[27825](https://github.com/flutter/flutter/pull/27825) Deflake AnsiSpinner tests (a: tests, cla: yes, team, team: flakes, waiting for tree to go green)

[27849](https://github.com/flutter/flutter/pull/27849) Revert "Roll engine 713fe130eb02..d48de7a3ec97 (1 commits)" (cla: yes)

[27851](https://github.com/flutter/flutter/pull/27851) Fixes a cursor offset mistake for Material on iOS (a: text input, cla: yes, framework, ⌺‬ platform-ios)

[27853](https://github.com/flutter/flutter/pull/27853) Hook up character events and unmodified code points to Android raw key event handling. (cla: yes, framework)

[27855](https://github.com/flutter/flutter/pull/27855) Reland "Roll engine 713fe130eb02..d48de7a3ec97 (1 commits)" (cla: yes)

[27861](https://github.com/flutter/flutter/pull/27861) Temporarily disable inconsistent strut golden tests due to test fonts (a: tests, a: typography, cla: yes, framework)

[27864](https://github.com/flutter/flutter/pull/27864) Fix crash when disposing nested Scrollables while holding in overscroll position (cla: yes, f: scrolling, framework, severe: crash)

[27865](https://github.com/flutter/flutter/pull/27865) Add Armenian translations (a: internationalization, cla: yes, framework)

[27866](https://github.com/flutter/flutter/pull/27866) Handle back swipe completed->completed or completed->dismissed transitions (cla: yes, f: cupertino, f: routes, framework)

[27873](https://github.com/flutter/flutter/pull/27873) Don't cache result for homeDirPath. (cla: yes, tool)

[27892](https://github.com/flutter/flutter/pull/27892) Fix overflow clipping/fading for text (cla: yes, framework)

[27895](https://github.com/flutter/flutter/pull/27895) Revert "Lazily download artifacts (Part II)" (cla: yes, tool)

[27900](https://github.com/flutter/flutter/pull/27900) Fixes switch vibration (cla: yes, f: cupertino, framework)

[27902](https://github.com/flutter/flutter/pull/27902) update packages and supress lint (cla: yes, framework, tool, waiting for tree to go green)

[27908](https://github.com/flutter/flutter/pull/27908) Reland automatic discovery of observatory port for iOS (cla: yes, tool, waiting for tree to go green, ⌘‬ platform-mac, ⌺‬ platform-ios)

[27914](https://github.com/flutter/flutter/pull/27914) fix multiroot scheme (cla: yes, tool)

[27915](https://github.com/flutter/flutter/pull/27915) Revert "[HR] Clean up matters related to "offstageness"." (cla: yes, f: scrolling, framework)

[27919](https://github.com/flutter/flutter/pull/27919) Revert "Ensure all curves return 0 and 1 in .transform(t) when t=0/1" (a: animation, cla: yes, framework)

[27929](https://github.com/flutter/flutter/pull/27929) Use double literals where a double type is expected (a: animation, cla: yes, framework, team)

[27945](https://github.com/flutter/flutter/pull/27945) Fixes crossAxisSpacing overflow in RTL (a: internationalization, cla: yes, f: scrolling, framework, waiting for tree to go green)

[27953](https://github.com/flutter/flutter/pull/27953) Add outer try block for obtainKey errors. Add docs. (cla: yes, framework, waiting for tree to go green)

[27955](https://github.com/flutter/flutter/pull/27955) Adds media query check in editable_text (a: text input, cla: yes, framework, waiting for tree to go green)

[27966](https://github.com/flutter/flutter/pull/27966) Revert "Fix overflow clipping/fading for text" (a: typography, cla: yes, framework)

[27968](https://github.com/flutter/flutter/pull/27968) Sample code for Icon class (cla: yes, d: api docs, framework)

[27969](https://github.com/flutter/flutter/pull/27969) Do not draw Slider tick marks if they are too dense (cla: yes, f: material design, framework)

[27970](https://github.com/flutter/flutter/pull/27970) Make sure the selection is still painted under the text (a: text input, cla: yes, framework)

[27973](https://github.com/flutter/flutter/pull/27973) Add extendBody parameter to Scaffold, body MediaQuery reflects BAB height (cla: yes, f: material design, framework)

[27980](https://github.com/flutter/flutter/pull/27980) Reapply "Fix overflow clipping/fading for text (#27892)" (a: typography, cla: yes, framework)

[27983](https://github.com/flutter/flutter/pull/27983) Test text paint orders by color (a: tests, a: text input, cla: yes, framework)

[27987](https://github.com/flutter/flutter/pull/27987) add ui.Window fallback to TestViewConfiguration (a: tests, cla: yes, tool)

[28006](https://github.com/flutter/flutter/pull/28006) Re-apply "Ensure all curves return 0 and 1 in .transform(t) when t=0/1" (a: animation, cla: yes, framework)

[28011](https://github.com/flutter/flutter/pull/28011) Remove accidentally committed libs (cla: yes, tool)

[28024](https://github.com/flutter/flutter/pull/28024) Disable prefer_collection_literals in the analyzer until we can update to using set literals (cla: yes, team)

[28027](https://github.com/flutter/flutter/pull/28027) Remove extra slash from builder that is not handled on windows (cla: yes, tool)

[28031](https://github.com/flutter/flutter/pull/28031) Revert "Add support for binary compression of dynamic patches by the flutter tool. (#27754)" (cla: yes, t: gradle, tool, ▣ platform-android)

[28032](https://github.com/flutter/flutter/pull/28032) Revert 26001 (a: text input, cla: yes, f: cupertino, f: material design, framework, severe: API break)

[28040](https://github.com/flutter/flutter/pull/28040) Remove json_schema and cli_util deps from flutter_tool (cla: yes, team, tool, waiting for tree to go green)

[28101](https://github.com/flutter/flutter/pull/28101) Remove unused --packages argument to gen_snapshot. (cla: yes, tool)

[28178](https://github.com/flutter/flutter/pull/28178) Roll engine to f45572e95f93edb89b6750a4f36ad8ed7c0a2560 (cla: yes)

[28182](https://github.com/flutter/flutter/pull/28182) Add TextOverflow.visible (a: typography, cla: yes, framework, waiting for tree to go green)

[28183](https://github.com/flutter/flutter/pull/28183) Rename SuperellipseShare ContinuousRectangleBorder (cla: yes, f: material design, framework)

[28216](https://github.com/flutter/flutter/pull/28216) Fix 'to to' (cla: yes, f: material design, framework)

[28222](https://github.com/flutter/flutter/pull/28222) Manual engine roll to 6d7eb52185b117a3972cac4e23625f97198114d9 (cla: yes)

[28224](https://github.com/flutter/flutter/pull/28224) Adds a template for Pull Requests (cla: yes, team, waiting for tree to go green)

[28235](https://github.com/flutter/flutter/pull/28235) Remove line breaks from PR template (cla: yes, team)

[28238](https://github.com/flutter/flutter/pull/28238) Remove set literal syntax (cla: yes, team)

[28265](https://github.com/flutter/flutter/pull/28265) Revert "Remove unused --packages argument to gen_snapshot." (cla: yes, tool)

[28272](https://github.com/flutter/flutter/pull/28272) Make logcat less chatty on perf tests (cla: yes, team)


## PRs closed in this release of flutter/engine

From Fri Nov 29 19:41:00 2018 -0800 to Thu Feb 21 20:22:00 2019 -0800


[6399](https://github.com/flutter/engine/pull/6399) System Channels, Plugins, Dart Entrypoint, FlutterFragment (cla: yes)

[6558](https://github.com/flutter/engine/pull/6558) Retained rendering in Fuchsia PhysicalShapeLayer (cla: yes)

[6719](https://github.com/flutter/engine/pull/6719) Add onStart hook to FlutterFragmentActivity (cla: yes)

[6805](https://github.com/flutter/engine/pull/6805) [OR] Offset.fromDirection and Size.aspectRatio (cla: yes)

[6879](https://github.com/flutter/engine/pull/6879) Allow FlutterViewController to be released when not initialized with an engine (cla: yes)

[6903](https://github.com/flutter/engine/pull/6903) [H] Undeprecate BigInteger support, but document what it actually does. (cla: yes)

[6913](https://github.com/flutter/engine/pull/6913) Support real fonts in 'flutter test' (cla: yes)

[6918](https://github.com/flutter/engine/pull/6918) Announce in/out of list (cla: yes)

[6919](https://github.com/flutter/engine/pull/6919) Reland "Compile libcxx and libcxxabi for Android (#6886)" (cla: yes, size)

[6922](https://github.com/flutter/engine/pull/6922) Verify RunConfiguration is valid before running (cla: yes)

[6923](https://github.com/flutter/engine/pull/6923) Compute cull_rect and optimize in Layer::Preroll (cla: yes)

[6926](https://github.com/flutter/engine/pull/6926) Roll buildtools to bac220c15490dcf7b7d8136f75100bbc77e8d217 (cla: yes, size)

[6927](https://github.com/flutter/engine/pull/6927) Support overriding font leading in TextStyle and LibTxt (affects: text input, brand new feature, cla: yes)

[6936](https://github.com/flutter/engine/pull/6936) Return real null instead of null string when locale has not been set in locale closure. (cla: yes)

[6945](https://github.com/flutter/engine/pull/6945) Adds force cursor support (cla: yes)

[6961](https://github.com/flutter/engine/pull/6961) Add hover event support to the engine (cla: yes)

[6967](https://github.com/flutter/engine/pull/6967) Eliminate obsolete FlutterDartProject initializers (cla: yes)

[6973](https://github.com/flutter/engine/pull/6973) Eliminate main_dart_file_path, package_file_path (cla: yes)

[6977](https://github.com/flutter/engine/pull/6977) Rename dart-non-checked-mode: disable-dart-asserts (cla: yes)

[6985](https://github.com/flutter/engine/pull/6985) Fix keyboard not showing for targetSdk 28 (cla: yes)

[6989](https://github.com/flutter/engine/pull/6989) Japanese Clear Text Crash (cla: yes)

[6991](https://github.com/flutter/engine/pull/6991) MInor Docs to runtime controller WindowData (cla: yes)

[7002](https://github.com/flutter/engine/pull/7002) Support querying display refresh rate in engine (cla: yes)

[7012](https://github.com/flutter/engine/pull/7012) Merge latest from master => 21008 staging branch (cla: yes)

[7024](https://github.com/flutter/engine/pull/7024) Roll Skia to 57d29eaf2ed7518983d9e91fd5219f4cfc181f88 (cla: yes)

[7031](https://github.com/flutter/engine/pull/7031) Pass operator_new_alignment value through gn script into GN args. (cla: yes)

[7048](https://github.com/flutter/engine/pull/7048) Only overflow the cache for one required frame (cla: yes)

[7068](https://github.com/flutter/engine/pull/7068)  SK_SUPPORT_LEGACY_TEXTENCODINGENUM (cla: yes)

[7087](https://github.com/flutter/engine/pull/7087) Wire up support for external OpenGL textures for the embedder. (cla: yes)

[7097](https://github.com/flutter/engine/pull/7097) Simplify conversion of numeric types in the message codec on iOS (cla: yes)

[7098](https://github.com/flutter/engine/pull/7098) Android embedding refactor PR1: JNI Extraction to FlutterJNI.java (cla: yes)

[7102](https://github.com/flutter/engine/pull/7102) Prepare for upcoming fuchsia vulkan driver changes (cla: yes)

[7108](https://github.com/flutter/engine/pull/7108) Fix destruction of the child object list in the iOS accessibility bridge (cla: yes)

[7146](https://github.com/flutter/engine/pull/7146) Revert "Reland "Compile libcxx and libcxxabi for Android (#6886)"" (cla: yes, size)

[7151](https://github.com/flutter/engine/pull/7151) Generalize runFromBundle to support multiple bundlePaths (cla: yes)

[7152](https://github.com/flutter/engine/pull/7152) Add native for fetching compilation trace as a memory buffer, for use in automated tools (cla: yes)

[7158](https://github.com/flutter/engine/pull/7158) Minor comments fix and add TODO (cla: yes)

[7160](https://github.com/flutter/engine/pull/7160)  Reland "Compile libcxx and libcxxabi for Android (#6886)" (cla: yes, size)

[7161](https://github.com/flutter/engine/pull/7161) Handle null bundlePaths in FlutterRunArguments (cla: yes)

[7162](https://github.com/flutter/engine/pull/7162) Merge master branch into skia-master (cla: no)

[7163](https://github.com/flutter/engine/pull/7163) Merge skia-master branch into master (cla: no)

[7164](https://github.com/flutter/engine/pull/7164) Add empty metrics to account for truncated whitespace for GetRectsForRange. (cla: yes)

[7179](https://github.com/flutter/engine/pull/7179) Fixed Spelling. (cla: yes)

[7185](https://github.com/flutter/engine/pull/7185) Check for empty line before adding empty 'padding' metrics (cla: yes)

[7187](https://github.com/flutter/engine/pull/7187) Revert "Support overriding font leading in TextStyle and LibTxt (#6927)" (cla: yes)

[7189](https://github.com/flutter/engine/pull/7189) Remove unnecessary includes of Skia headers. (cla: yes)

[7194](https://github.com/flutter/engine/pull/7194) Roll buildroot to 4cb5a74c9612b71b917997f46e97da6d1051eab4 (cla: yes, size)

[7195](https://github.com/flutter/engine/pull/7195) Roll buildroot to 8e538639660413490ea9261eee84864005e240f4 (cla: yes, size)

[7202](https://github.com/flutter/engine/pull/7202) Add .woff file to binary format (cla: yes)

[7207](https://github.com/flutter/engine/pull/7207) Downloading and installation of dynamic updates on Android (cla: yes)

[7208](https://github.com/flutter/engine/pull/7208) Fallback font match caching to fix emoji lag. (cla: yes)

[7213](https://github.com/flutter/engine/pull/7213) Roll Dart to version e15e8609aa8610f8c432f1caf2ab89358e2fce50 (cla: yes)

[7214](https://github.com/flutter/engine/pull/7214) [Fuchsia] Depend on libtrace when that is what's really meant (cla: yes)

[7221](https://github.com/flutter/engine/pull/7221) [vulkan] Fix Fuchsia build (cla: yes)

[7227](https://github.com/flutter/engine/pull/7227) Compile embedder unit test Dart to kernel (cla: yes)

[7230](https://github.com/flutter/engine/pull/7230) Revert "Compile embedder unit test Dart to kernel (#7227)" (cla: yes)

[7231](https://github.com/flutter/engine/pull/7231) Compile embedder unit test Dart to kernel (re-land) (cla: yes)

[7234](https://github.com/flutter/engine/pull/7234) Fix misspelling in doc comments (cla: yes)

[7235](https://github.com/flutter/engine/pull/7235) Fix settings.advisory_script_uri in iOS createShell (cla: yes)

[7237](https://github.com/flutter/engine/pull/7237) Allow inferred types using diamond syntax (cla: yes)

[7238](https://github.com/flutter/engine/pull/7238) Clarify TextAffinity docs (cla: yes)

[7239](https://github.com/flutter/engine/pull/7239) Simplify nested try-with-resources statements (cla: yes)

[7240](https://github.com/flutter/engine/pull/7240) Fix linter errors in ResourceUpdater (cla: yes)

[7241](https://github.com/flutter/engine/pull/7241) Support user-provided font-fallback. (cla: yes)

[7242](https://github.com/flutter/engine/pull/7242) Revert spelling correction in licence matcher (cla: yes)

[7244](https://github.com/flutter/engine/pull/7244) iOS A11y memory leak (cla: yes)

[7245](https://github.com/flutter/engine/pull/7245) Roll buildroot to support Android SDK 28 (cla: yes)

[7246](https://github.com/flutter/engine/pull/7246) Update iOS unit test for the removal of hex string encoding of uint64 data (cla: yes)

[7248](https://github.com/flutter/engine/pull/7248) Update terminology to match that of the flutter tool (cla: yes)

[7250](https://github.com/flutter/engine/pull/7250) Extract function to collect licenses for component (cla: yes)

[7254](https://github.com/flutter/engine/pull/7254) Fix javadoc for Android-28 (cla: yes)

[7256](https://github.com/flutter/engine/pull/7256) Document native functions for compilation trace (cla: yes)

[7257](https://github.com/flutter/engine/pull/7257) Add a system message channel for controlling the Skia resource cache size (cla: yes)

[7258](https://github.com/flutter/engine/pull/7258) Remove unused GrContext in AndroidSurfaceGL (cla: yes)

[7260](https://github.com/flutter/engine/pull/7260) Re-run license tool on all source when it changes (cla: yes)

[7261](https://github.com/flutter/engine/pull/7261) Update usage of some Android APIs that are deprecated in API level 28 (cla: yes)

[7266](https://github.com/flutter/engine/pull/7266) Eliminate use of new keyword in license tool (cla: yes)

[7267](https://github.com/flutter/engine/pull/7267) Mark all unreassigned locals final in license tool (cla: yes)

[7269](https://github.com/flutter/engine/pull/7269) [License] Eliminate duplicate case in switch (cla: yes)

[7270](https://github.com/flutter/engine/pull/7270) [License] Assert license filename is non-null, non-empty (cla: yes)

[7272](https://github.com/flutter/engine/pull/7272) Make IOManager own resource context (cla: yes)

[7273](https://github.com/flutter/engine/pull/7273) [License] Sync analysis_options.yaml from framework (cla: yes)

[7274](https://github.com/flutter/engine/pull/7274) TextAffinity Docs Improvement (cla: yes)

[7275](https://github.com/flutter/engine/pull/7275) [License] Enable avoid_positional_boolean_parameters lint (cla: yes)

[7276](https://github.com/flutter/engine/pull/7276) Remove unused native function dumpCompilationTrace() (cla: yes)

[7281](https://github.com/flutter/engine/pull/7281) TextInputType.number default fix (cla: yes)

[7282](https://github.com/flutter/engine/pull/7282) Add elevation and thickness to SemanticsNode (accessibility, cla: yes)

[7283](https://github.com/flutter/engine/pull/7283) Revert "Roll Dart to version e15e8609aa8610f8c432f1caf2ab89358e2fce50" (cla: yes)

[7284](https://github.com/flutter/engine/pull/7284) Roll buildroot and update method of getting android SDK and support libs (cla: yes)

[7286](https://github.com/flutter/engine/pull/7286) Roll version of Dart to d1817ddc91fd3aea061647b2e21860c47a5a5180 (cla: yes)

[7287](https://github.com/flutter/engine/pull/7287) Paint all backgrounds first to prevent overlap (cla: yes)

[7307](https://github.com/flutter/engine/pull/7307) Only reject gestures to embedded UIViews when the framework says so. (cla: yes)

[7308](https://github.com/flutter/engine/pull/7308) Support loading flutter assets from dynamic patch (cla: yes)

[7309](https://github.com/flutter/engine/pull/7309) Allow dynamic patches without a patch number. (cla: yes)

[7313](https://github.com/flutter/engine/pull/7313) Revert "Only reject gestures to embedded UIViews when the framework s… (cla: yes)

[7315](https://github.com/flutter/engine/pull/7315)  Reland "Only reject gestures to embedded UIViews when the framework sa… (cla: yes)

[7316](https://github.com/flutter/engine/pull/7316) Roll dart to 88e6fe0f67 (cla: yes)

[7317](https://github.com/flutter/engine/pull/7317) Recreate the overlay rendering surfaces if the GrContext was changed. (cla: yes)

[7322](https://github.com/flutter/engine/pull/7322) Roll buildroot (cla: yes)

[7324](https://github.com/flutter/engine/pull/7324) Update GetCallbackHandle to use Dart_IsTearOff instead of a string comparison (cla: yes)

[7325](https://github.com/flutter/engine/pull/7325) Minor refactoring of dynamic patching code. (cla: yes)

[7327](https://github.com/flutter/engine/pull/7327) Give more control over when dynamic patches get downloaded and installed. (cla: yes)

[7346](https://github.com/flutter/engine/pull/7346) Make `ParagraphConstraints` have const constructor (cla: yes)

[7354](https://github.com/flutter/engine/pull/7354) Preparing to remove SK_SUPPORT_LEGACY_PAINT_TEXTMEASURE (cla: yes)

[7360](https://github.com/flutter/engine/pull/7360) Fix typo clas -> class (cla: yes)

[7363](https://github.com/flutter/engine/pull/7363) Roll Dart to version ec86471ccc47a62df8b4009e1fb37c66ff9dc91b (cla: yes)

[7370](https://github.com/flutter/engine/pull/7370) [HR] Documentation cleanup (cla: yes)

[7371](https://github.com/flutter/engine/pull/7371) Test SDK roll (cla: yes)

[7374](https://github.com/flutter/engine/pull/7374) Revert "Test SDK roll" (cla: yes)

[7387](https://github.com/flutter/engine/pull/7387) Improve TextAffinity Docs (cla: yes)

[7398](https://github.com/flutter/engine/pull/7398) Replace Java code with equivalent, more concise code. (cla: yes)

[7401](https://github.com/flutter/engine/pull/7401) Reset ParagraphBuilder after build() (cla: yes)

[7403](https://github.com/flutter/engine/pull/7403) Dart SDK roll for 2019-01-07 (cla: yes)

[7404](https://github.com/flutter/engine/pull/7404) fix up analysis for Dart in Engine (cla: yes)

[7405](https://github.com/flutter/engine/pull/7405) Dart SDK roll for 2019-01-07 (cla: yes)

[7409](https://github.com/flutter/engine/pull/7409) Cleanup dead code (cla: yes)

[7410](https://github.com/flutter/engine/pull/7410) Refactor shared code into separate function to simplify further work. (cla: yes)

[7411](https://github.com/flutter/engine/pull/7411) Dart SDK roll for 2019-01-08 (cla: yes)

[7413](https://github.com/flutter/engine/pull/7413) remove deprecated updateNode argument (cla: yes)

[7414](https://github.com/flutter/engine/pull/7414) Strut implementation (cla: yes)

[7416](https://github.com/flutter/engine/pull/7416) Dart SDK roll for 2019-01-08 (cla: yes)

[7417](https://github.com/flutter/engine/pull/7417) Dart SDK roll for 2019-01-09 (cla: yes)

[7419](https://github.com/flutter/engine/pull/7419) Dart SDK roll for 2019-01-09 (cla: yes)

[7421](https://github.com/flutter/engine/pull/7421) Dart SDK roll for 2019-01-09 (cla: yes)

[7426](https://github.com/flutter/engine/pull/7426) Refactor dynamic patching to use clearer naming and structure. (cla: yes)

[7427](https://github.com/flutter/engine/pull/7427) Allow embedders to add per shell idle notification callbacks. (cla: yes)

[7428](https://github.com/flutter/engine/pull/7428) Download dynamic patch to separate file to avoid races (cla: yes)

[7429](https://github.com/flutter/engine/pull/7429) Eliminate unused import of ZipException (cla: yes)

[7431](https://github.com/flutter/engine/pull/7431) Dart SDK roll for 2019-01-09 (cla: yes)

[7432](https://github.com/flutter/engine/pull/7432) Improve 404 handling when downloading dynamic patches. (cla: yes)

[7433](https://github.com/flutter/engine/pull/7433) Eliminate std::string using directive (cla: yes)

[7435](https://github.com/flutter/engine/pull/7435) Add Ahem to LibTxt testing fonts. (cla: yes)

[7436](https://github.com/flutter/engine/pull/7436) Clear the font collection's cache when a font is dynamically loaded (cla: yes)

[7437](https://github.com/flutter/engine/pull/7437) Temporary revert of Dart SDK rolls made since 2019/01/08 (cla: yes)

[7439](https://github.com/flutter/engine/pull/7439) Remove legacy and deprecated defaultClipBehavior (cla: yes)

[7442](https://github.com/flutter/engine/pull/7442) Move Picture.toImage rasterization to the GPU thread (cla: yes)

[7443](https://github.com/flutter/engine/pull/7443) Avg ms/frame instead of FPS in performance overlay (cla: yes)

[7444](https://github.com/flutter/engine/pull/7444) Pass deadline to embedder idle notification callback (cla: yes)

[7445](https://github.com/flutter/engine/pull/7445) Use anti-aliasing when drawing text in the performance overlay (cla: yes)

[7446](https://github.com/flutter/engine/pull/7446) Reland Dart SDK rolls made since 2019/01/08 (cla: yes)

[7447](https://github.com/flutter/engine/pull/7447) Make SetLocales more consistent with other RuntimeController methods (cla: yes)

[7449](https://github.com/flutter/engine/pull/7449) Dart SDK roll for 2019-01-11 (cla: yes)

[7450](https://github.com/flutter/engine/pull/7450) Stop pumping frames in applicationWillResignActive (cla: yes)

[7451](https://github.com/flutter/engine/pull/7451) Dart SDK roll for 2019-01-11 (cla: yes)

[7459](https://github.com/flutter/engine/pull/7459) add ColorFilter matrix support (cla: yes)

[7461](https://github.com/flutter/engine/pull/7461) Dart SDK roll for 2019-01-14 (cla: yes)

[7463](https://github.com/flutter/engine/pull/7463) Dart SDK roll for 2019-01-14 (cla: yes)

[7464](https://github.com/flutter/engine/pull/7464) update site to use SkFont for text fields (cla: yes)

[7476](https://github.com/flutter/engine/pull/7476) Log errors returned from method channel invocations in the text input plugin (cla: yes)

[7480](https://github.com/flutter/engine/pull/7480) Switch to Skia's new SkColorSpace factory (cla: yes)

[7483](https://github.com/flutter/engine/pull/7483) Revert "Add elevation and thickness to SemanticsNode" (cla: yes)

[7484](https://github.com/flutter/engine/pull/7484) Reland "Add elevation and thickness to SemanticsNode (#7282)" (accessibility, cla: yes)

[7485](https://github.com/flutter/engine/pull/7485) Execute Picture.toImage on the current thread in the test environment (cla: yes)

[7488](https://github.com/flutter/engine/pull/7488) Implemented Dark Mode for Android (#25525) (cla: yes)

[7492](https://github.com/flutter/engine/pull/7492) Cleanup Dart sticky errors API and roll tonic to 4634b29a24ccfc0fcfafcc8196ef30131185ad88 (cla: yes)

[7493](https://github.com/flutter/engine/pull/7493) Add runttime unittest that loads and runs an isolate from the kernel. (cla: yes)

[7495](https://github.com/flutter/engine/pull/7495) Add unittest that runs Dart code synchronously. (cla: yes)

[7496](https://github.com/flutter/engine/pull/7496) Validate dynamic patches before attempting to install (cla: yes)

[7497](https://github.com/flutter/engine/pull/7497) Deprecate FlutterProjectArgs.main_path, packages_path (cla: yes)

[7500](https://github.com/flutter/engine/pull/7500) Introduced a number of Java system channels in io/flutter/embedding/engine/systemchannels/ (cla: yes)

[7503](https://github.com/flutter/engine/pull/7503) Edit the bundleid so that it conform to UIT specifications. (cla: yes)

[7511](https://github.com/flutter/engine/pull/7511) Remove unused headers (cla: yes)

[7512](https://github.com/flutter/engine/pull/7512) Wrap the user entrypoint function in a zone with native exception callback. (cla: yes)

[7516](https://github.com/flutter/engine/pull/7516) Fixes Android pressure range (cla: yes)

[7518](https://github.com/flutter/engine/pull/7518) Update default flutter_assets path for iOS embedding (cla: yes)

[7522](https://github.com/flutter/engine/pull/7522) Revert "Wrap the user entrypoint function in a zone with native exception callback. (#7512)" (cla: yes)

[7525](https://github.com/flutter/engine/pull/7525) Support custom kernel blob path in test fixtures (cla: yes)

[7528](https://github.com/flutter/engine/pull/7528) Ensure the ResourceContext is not ripped out from under dart (cla: yes)

[7530](https://github.com/flutter/engine/pull/7530) Fix suspicious typo "painted" to "paint" (cla: yes)

[7532](https://github.com/flutter/engine/pull/7532) Mark new unavailable for those init marked unavailable (cla: yes)

[7533](https://github.com/flutter/engine/pull/7533) Configure the embedder for AOT in "profile" and "release" runtime modes. (cla: yes)

[7537](https://github.com/flutter/engine/pull/7537) Add mock capability to PerformanceOverlayLayer (cla: yes)

[7538](https://github.com/flutter/engine/pull/7538) Allow embedders to specify AOT snapshot buffers. (cla: yes)

[7539](https://github.com/flutter/engine/pull/7539) IWYU to get SkFontMetrics (cla: yes)

[7544](https://github.com/flutter/engine/pull/7544) Keep engine alive if VC is not deallocated (cla: yes)

[7545](https://github.com/flutter/engine/pull/7545) IWYU, esp. since SkFontMetrics.h is leaving SkPaint.h (cla: yes)

[7548](https://github.com/flutter/engine/pull/7548) Remove SkColorSpaceXformCanvas, use color-managed SkSurfaces instead (cla: yes)

[7549](https://github.com/flutter/engine/pull/7549) Remove the shell build target's dependency on the embedder library (cla: yes)

[7551](https://github.com/flutter/engine/pull/7551) Re-land "Wrap the user entrypoint function in a zone with native exception callback. (#7512)" (cla: yes)

[7558](https://github.com/flutter/engine/pull/7558) Fix UIButton selector doesn't work in iOS platformview (cla: yes)

[7563](https://github.com/flutter/engine/pull/7563) Fix typos in Fuchsia (cla: yes)

[7566](https://github.com/flutter/engine/pull/7566) Avoid unnecessarily creating/destroying the PlatformView (cla: yes)

[7567](https://github.com/flutter/engine/pull/7567) Rename FlutterResult in embedder.h (cla: yes)

[7576](https://github.com/flutter/engine/pull/7576) Allow generating coverage reports for all unit-tests in the engine. (cla: yes)

[7577](https://github.com/flutter/engine/pull/7577) [embedder] Avoid looking for the kernel binary in AOT builds. (cla: yes)

[7579](https://github.com/flutter/engine/pull/7579) Add lcov coverage file generation. (cla: yes)

[7588](https://github.com/flutter/engine/pull/7588) Embed ICU data inside libflutter.so on Android (cla: yes)

[7591](https://github.com/flutter/engine/pull/7591) Roll buildroot to b4d21cb2a64d63218c8d99533d9c14e99201e8d8 (cla: yes)

[7602](https://github.com/flutter/engine/pull/7602) Update buildtools to c9e5400c9e03a0cfb7313d14fde38525399a7715 (cla: yes)

[7610](https://github.com/flutter/engine/pull/7610) Provide public api to allow FlutterEngine related context to be destoryed (affects: engine, cla: yes, customer: gold, platform-ios)

[7611](https://github.com/flutter/engine/pull/7611) Update license to sync with flutter/flutter (cla: yes)

[7617](https://github.com/flutter/engine/pull/7617) Allow the engine to redirect traces to systrace via settings. (cla: yes)

[7621](https://github.com/flutter/engine/pull/7621) Improve PathMetrics (cla: yes)

[7628](https://github.com/flutter/engine/pull/7628) Check in GEM_HOME for jazzy (cla: yes)

[7633](https://github.com/flutter/engine/pull/7633) Revert buildtools roll back to bac220c (cla: yes)

[7634](https://github.com/flutter/engine/pull/7634) Expose the Flutter engine, Dart and Skia versions to Dart. (cla: yes)

[7642](https://github.com/flutter/engine/pull/7642) Initial import of FDE macOS framework (cla: yes)

[7643](https://github.com/flutter/engine/pull/7643) Respect default goma path on Windows (cla: yes)

[7645](https://github.com/flutter/engine/pull/7645) Fix dynamic array -> vector (cla: yes)

[7647](https://github.com/flutter/engine/pull/7647) Update the verify_exported script to include the symbols for ICU data (cla: yes)

[7648](https://github.com/flutter/engine/pull/7648) [embedder] Document make_resource_current on FlutterOpenGLRendererConfig and warn if the callback is not set. (cla: yes)

[7649](https://github.com/flutter/engine/pull/7649) Fix two typos in embedder docs (cla: yes)

[7651](https://github.com/flutter/engine/pull/7651) Add FlutterProjectArgs::root_isolate_create_callback (cla: yes)

[7658](https://github.com/flutter/engine/pull/7658) Use the Wuffs GIF decoder (cla: yes)

[7659](https://github.com/flutter/engine/pull/7659) DCHECK that clip layer's behavior isn't none (cla: yes)

[7660](https://github.com/flutter/engine/pull/7660) Add kernel-worker and dart2js to BUILD.gn (cla: yes)

[7678](https://github.com/flutter/engine/pull/7678) Move Brightness definition to dart:ui (#27479) (cla: yes)

[7686](https://github.com/flutter/engine/pull/7686) Replace hb_face_reference_table with hb_ot_color_has_png in isColorBitmapFont (cla: yes)

[7687](https://github.com/flutter/engine/pull/7687) Lower the threshold to raster cache pictures (cla: yes)

[7689](https://github.com/flutter/engine/pull/7689) Revert "Disable the persistent cache (#6835)" (cla: yes)

[7691](https://github.com/flutter/engine/pull/7691) Don't warn for Async texture uploads on Fuchsia (cla: yes)

[7692](https://github.com/flutter/engine/pull/7692) Ensure dart2js and kernel worker snapshots are copied out of gen dir (cla: yes)

[7694](https://github.com/flutter/engine/pull/7694) Create stubbed dart:ui implementation, dart2js libraries file, copy rule (cla: yes)

[7701](https://github.com/flutter/engine/pull/7701) Revert "Lower the threshold to raster cache pictures" (cla: yes)

[7702](https://github.com/flutter/engine/pull/7702) Update snapshot build rules to generate .o files instead of .S files on Windows (Windows, cla: yes)

[7708](https://github.com/flutter/engine/pull/7708) [fuchsia] Update scenic include (cla: yes)

[7713](https://github.com/flutter/engine/pull/7713) Disable wuff on Windows (cla: yes)

[7715](https://github.com/flutter/engine/pull/7715) Decode using the last cached required frame (cla: yes, crash)

[7717](https://github.com/flutter/engine/pull/7717) Allow all entrypoints support by the command line VM. (cla: yes)

[7718](https://github.com/flutter/engine/pull/7718) Roll buildroot to c82412bcdcd593f1385a478ae2c4b8eb9814f3b8 (cla: yes)

[7719](https://github.com/flutter/engine/pull/7719) libtxt: support justification of RTL text (cla: yes)

[7725](https://github.com/flutter/engine/pull/7725) Correct libraries.yaml path for stub_ui, add brightness, copy dart2js_platform.dill files (cla: yes)

[7726](https://github.com/flutter/engine/pull/7726) Fix versions implementation (cla: yes)

[7731](https://github.com/flutter/engine/pull/7731) [fuchsia] Update path to fuchsia.ui.scenic (cla: yes)

[7733](https://github.com/flutter/engine/pull/7733) Update documentation for command line args in FlutterProjectArgs. (cla: yes)

[7734](https://github.com/flutter/engine/pull/7734) Use all font managers to discover fonts for strut. (cla: yes)

[7735](https://github.com/flutter/engine/pull/7735) Use correct flags on LUCI/legacy (cla: yes)

[7737](https://github.com/flutter/engine/pull/7737) Provide a default pressure range if a MotionEvent does not have a device (cla: yes)

[7738](https://github.com/flutter/engine/pull/7738) Android embedding refactor pr3 add remaining systemchannels (cla: yes)

[7739](https://github.com/flutter/engine/pull/7739) Add onPlatformBrightnessChanged/platformBrightness to stub ui window. (cla: yes)

[7740](https://github.com/flutter/engine/pull/7740) Rename macOS framework to FlutterMacOS.framework (cla: yes)

[7741](https://github.com/flutter/engine/pull/7741) use full git hash for version (cla: yes)

[7744](https://github.com/flutter/engine/pull/7744) Support for loading dynamic patches in AOT mode. (cla: yes)

[7746](https://github.com/flutter/engine/pull/7746) Don't call OnAnimatorNotifyIdle if a frame is scheduled (cla: yes)

[7751](https://github.com/flutter/engine/pull/7751) Create mipmaps for images when uploading them on the IO thread (cla: yes)

[7753](https://github.com/flutter/engine/pull/7753) allow specifying out directory root (cla: yes)

[7755](https://github.com/flutter/engine/pull/7755) Document GPUSurfaceGLDelegate methods and move it to its own file. (cla: yes)

[7756](https://github.com/flutter/engine/pull/7756) Add flutter config to macOS targets (cla: yes)

[7758](https://github.com/flutter/engine/pull/7758) Recommended implementation of combining characters implementation. (cla: yes)

[7759](https://github.com/flutter/engine/pull/7759) Throttle picture raster cache (cla: yes)

[7762](https://github.com/flutter/engine/pull/7762) Allow specifying the out directory prefix (cla: yes)

[7764](https://github.com/flutter/engine/pull/7764) Add x bit to some python scripts (cla: yes)

[7765](https://github.com/flutter/engine/pull/7765) Revert "Add mock capability to PerformanceOverlayLayer" (cla: yes)

[7777](https://github.com/flutter/engine/pull/7777) Support for binary decompression of dynamic patches. (cla: yes)

[7785](https://github.com/flutter/engine/pull/7785) Don't use WUFFs (cla: yes)

[7786](https://github.com/flutter/engine/pull/7786) Update licenses for the switch away from the Wuffs GIF decoder (cla: yes)

[7790](https://github.com/flutter/engine/pull/7790) Allow embedders to specify pointer device IDs. (cla: yes)

[7791](https://github.com/flutter/engine/pull/7791) Add space metrics tracking for trailing whitespace "ghost" runs. (cla: yes)

[7801](https://github.com/flutter/engine/pull/7801) Revert "Use all font managers to discover fonts for strut. (#7734)" (cla: yes)

[7804](https://github.com/flutter/engine/pull/7804) Add support for new Scenic clip planes. (cla: yes)

[7806](https://github.com/flutter/engine/pull/7806) Remove the Dart JIT snapshot data from AOT builds of the embedder library (cla: yes)

[7807](https://github.com/flutter/engine/pull/7807) Add flow events connecting pointer events to frames (cla: yes)

[7809](https://github.com/flutter/engine/pull/7809) Use newer Skia API for PathMeasure (cla: yes)

[7811](https://github.com/flutter/engine/pull/7811) Add FFI to libraries.yaml. (cla: yes)

[7813](https://github.com/flutter/engine/pull/7813) Expose more pointer phases in embedder.h (cla: yes)

[7814](https://github.com/flutter/engine/pull/7814) Fix typo in painting.dart (cla: yes, waiting for tree to go green)

[7815](https://github.com/flutter/engine/pull/7815) Allow specifying the buildtools path (cla: yes, waiting for tree to go green)

[7819](https://github.com/flutter/engine/pull/7819) Fix tests that were committed after cirrus ran (cla: yes)

[7826](https://github.com/flutter/engine/pull/7826) Pass flow id properly. (cla: yes)

[7827](https://github.com/flutter/engine/pull/7827) Remove unnecessary entry-point closurization. (cla: yes)

[7830](https://github.com/flutter/engine/pull/7830) Move up ndk version that is being downloaded(old one no longer available). (cla: yes)

[7832](https://github.com/flutter/engine/pull/7832) Shut down and restart the Dart VM as needed. (cla: yes)

[7834](https://github.com/flutter/engine/pull/7834) [fuchsia][SCN-1054] Map elevation onto -Z in Scenic (cla: yes)

[7836](https://github.com/flutter/engine/pull/7836) Delete GL textures when they are released from the texture registry. (cla: yes)

[7837](https://github.com/flutter/engine/pull/7837) Fix NullPointerException in SurfaceTextureRegistryEntry (cla: yes)

[7838](https://github.com/flutter/engine/pull/7838) Fix NullPointerException in ResourceCleaner (cla: yes)

[7839](https://github.com/flutter/engine/pull/7839) Ensure to pass dill file after VM options for gen_snapshot (cla: yes)

[7841](https://github.com/flutter/engine/pull/7841) Don't call static method from instance variable (cla: yes)

[7843](https://github.com/flutter/engine/pull/7843) Add support for calling into other plugins from a background context on iOS (cla: yes)

[7845](https://github.com/flutter/engine/pull/7845) Add fml::FileExists implementation for Windows (cla: yes)

[7846](https://github.com/flutter/engine/pull/7846) Update buildroot to 7f64ff4928e to unblock Mac builds. (cla: yes)

[7849](https://github.com/flutter/engine/pull/7849) Revert "Android embedding refactor pr3 add remaining systemchannels (… (cla: yes)

[7853](https://github.com/flutter/engine/pull/7853) Revert "Support for binary decompression of dynamic patches. (#7777)" (cla: yes)

[7862](https://github.com/flutter/engine/pull/7862) Reland "Lower the threshold to raster cache pictures (#7687)" (cla: yes)

[7863](https://github.com/flutter/engine/pull/7863) Reland PerformanceOverlayLayer golden test (cla: yes)

[7874](https://github.com/flutter/engine/pull/7874) Android embedding refactor pr3 add remaining systemchannels (cla: yes)

[7875](https://github.com/flutter/engine/pull/7875) Fix caret being at left edge when newline pressed on centered text (cla: yes)

[7876](https://github.com/flutter/engine/pull/7876) Revert "Remove unnecessary entry-point closurization." (cla: yes)

[7877](https://github.com/flutter/engine/pull/7877) Revert "Shut down and restart the Dart VM as needed." (cla: yes)

[7878](https://github.com/flutter/engine/pull/7878) Android embedding refactor pr5 add flutterengine impl (cla: yes)

[7880](https://github.com/flutter/engine/pull/7880) Test profile and release build and unit tests (cla: yes)

[7882](https://github.com/flutter/engine/pull/7882) Fix minor typos in accessibility action docs (cla: yes)

[7883](https://github.com/flutter/engine/pull/7883) Correct onAccessibilityFeaturesChanged docs (cla: yes)

[7886](https://github.com/flutter/engine/pull/7886) Revert "Android embedding refactor pr3 add remaining systemchannels" (cla: yes)

[7891](https://github.com/flutter/engine/pull/7891) Add accessibility semantics support to embedder (cla: yes)

[7892](https://github.com/flutter/engine/pull/7892) Android embedding refactor pr3 add remaining systemchannels (cla: yes)

[7893](https://github.com/flutter/engine/pull/7893) Respect the custom GL proc table when creating the resource context on the IO thread. (cla: yes)

[7895](https://github.com/flutter/engine/pull/7895) Revert "Reland PerformanceOverlayLayer golden test (#7863)" (cla: yes)

[7899](https://github.com/flutter/engine/pull/7899) Eliminate .member = foo struct initialization (cla: yes)

[7904](https://github.com/flutter/engine/pull/7904) Reland "Remove unnecessary entry-point closurization." (cla: yes)



## PRs closed in this release of flutter/plugins

From Fri Nov 29 19:41:00 2018 -0800 to Thu Feb 21 20:22:00 2019 -0800


[690](https://github.com/flutter/plugins/pull/690) [video_player] Fix aspect ratio (cla: yes)

[842](https://github.com/flutter/plugins/pull/842) Remove base detector class and change detection method name (cla: yes, flutterfire)

[895](https://github.com/flutter/plugins/pull/895) [connectivity] Added getWifiIP() (cla: yes)

[896](https://github.com/flutter/plugins/pull/896) [firebase-analytics] Enable setAnalyticsCollectionEnabled support for iOS (cla: no, flutterfire, submit queue)

[926](https://github.com/flutter/plugins/pull/926) Remove firebase_auth dependency from android_alarm_manager library and add initialize step to readme (cla: yes, documentation, submit queue)

[936](https://github.com/flutter/plugins/pull/936) Fixed typo `BarcodeValueType` (cla: yes)

[947](https://github.com/flutter/plugins/pull/947) fix: url_launcher can't launcher for Android (cla: yes)

[949](https://github.com/flutter/plugins/pull/949) Fixes: 'webview_flutter/WebviewFlutterPlugin.h' file not found (cla: yes)

[950](https://github.com/flutter/plugins/pull/950) Show https://flutter.io in the webview_flutter example. (cla: yes)

[954](https://github.com/flutter/plugins/pull/954) add new plugins reference to README.md (cla: yes)

[956](https://github.com/flutter/plugins/pull/956) Make the description for webview_flutter longer. (cla: yes)

[957](https://github.com/flutter/plugins/pull/957) fix message structure from intent (cla: yes)

[959](https://github.com/flutter/plugins/pull/959) Add navigation methods to webview_flutter (cla: yes)

[960](https://github.com/flutter/plugins/pull/960) Fail call when trying to recover auth with backgrounded app (cla: yes)

[961](https://github.com/flutter/plugins/pull/961) Control the GoogleMap options with widget parameters. (cla: yes)

[965](https://github.com/flutter/plugins/pull/965) Add byte streaming capability for the camera  (cla: yes)

[967](https://github.com/flutter/plugins/pull/967) Fix initialUrl null check for webview_flutter (cla: yes)

[971](https://github.com/flutter/plugins/pull/971) Add the ability for ML Kit to create image from bytes (cla: yes)

[972](https://github.com/flutter/plugins/pull/972) Fix typo in WebView's "initWithWithFrame". (cla: yes)

[974](https://github.com/flutter/plugins/pull/974) Implemented reload method in webview_flutter (cla: yes)

[976](https://github.com/flutter/plugins/pull/976) [camera] Fix issue with crash when the physical device's orientation is unknown on Android. (cla: yes)

[977](https://github.com/flutter/plugins/pull/977) Temporarily add exoplayer repo accidentally deleted from jcenter (cla: yes)

[992](https://github.com/flutter/plugins/pull/992) Add currentUrl accessor to WebView plugin. (cla: yes)

[993](https://github.com/flutter/plugins/pull/993) Allow user to handle PlatformExceptions caught by FirebaseAnalyticsObserver._sendScreenView(). (cla: yes)

[995](https://github.com/flutter/plugins/pull/995) Bump webview_flutter's version. (cla: yes)

[997](https://github.com/flutter/plugins/pull/997) closeWebView fixes for url_launcher (cla: yes)

[1002](https://github.com/flutter/plugins/pull/1002) Fixed local_auth crash with API < 24 #24339 (cla: yes)

[1006](https://github.com/flutter/plugins/pull/1006) Bump android_alarm_manager version to 0.2.3 (cla: yes)

[1021](https://github.com/flutter/plugins/pull/1021) javascript evaluation ios/android (cla: yes, feature, webview)

[1024](https://github.com/flutter/plugins/pull/1024) Doc and build script updates to the IAP plugin (cla: yes)

[1025](https://github.com/flutter/plugins/pull/1025) Fix CI analyzer errors (cla: yes)

[1031](https://github.com/flutter/plugins/pull/1031) Workaround the Gradle crash due to non ASCII characters. (cla: yes)

[1034](https://github.com/flutter/plugins/pull/1034) Remove comments from license file (cla: yes)

[1037](https://github.com/flutter/plugins/pull/1037) Save photo orientation on iOS (cla: yes)

[1040](https://github.com/flutter/plugins/pull/1040) Rev version to publish 0.3.1 to pub (cla: yes)

[1042](https://github.com/flutter/plugins/pull/1042) Remove scary message (cla: yes)

[1046](https://github.com/flutter/plugins/pull/1046) Fix Crash When StartPreview Error (cla: yes)

[1051](https://github.com/flutter/plugins/pull/1051) Fix image picker crash on IOS (cla: yes)

[1057](https://github.com/flutter/plugins/pull/1057) [IAP] Check if the payment processor is available (cla: yes)

[1058](https://github.com/flutter/plugins/pull/1058) Update dart doc for forceSafariVC for the usage of universal links on iOS (cla: yes)

[1060](https://github.com/flutter/plugins/pull/1060) Bump camera plugin version and update changelog. (cla: yes)

[1062](https://github.com/flutter/plugins/pull/1062) Url launcher ios universallinksonly (cla: yes)

[1065](https://github.com/flutter/plugins/pull/1065) Supress `strong_mode_implicit_dynamic_method` for `invokeMethod` calls. (cla: yes)

[1068](https://github.com/flutter/plugins/pull/1068) Iap productlist ios (cla: yes)

[1072](https://github.com/flutter/plugins/pull/1072) adding nil check (cla: yes)

[1076](https://github.com/flutter/plugins/pull/1076) Fix `Manifest versionCode not found` (cla: yes)

[1082](https://github.com/flutter/plugins/pull/1082) [IAP] Clean up Dart unit tests (cla: yes)

[1083](https://github.com/flutter/plugins/pull/1083) [IAP] Add missing license headers (cla: yes)

[1084](https://github.com/flutter/plugins/pull/1084) [IAP] Fetch SkuDetails from Google Play (cla: yes)

[1085](https://github.com/flutter/plugins/pull/1085) Url launcher refactor (cla: yes)

[1086](https://github.com/flutter/plugins/pull/1086) Enable compute credits for commits, and for macOS PRs (cla: yes)

[1087](https://github.com/flutter/plugins/pull/1087) cirrues update to mojave-xcode-10.1 (cla: yes)

[1088](https://github.com/flutter/plugins/pull/1088) add deprecated_member_use_from_same_package to pass analyzer (cla: yes)

[1089](https://github.com/flutter/plugins/pull/1089) Fix a crash when selecting downloaded images on certain devices (cla: yes)

[1090](https://github.com/flutter/plugins/pull/1090) [IAP] Generate boilerplate serializers (cla: yes)

[1092](https://github.com/flutter/plugins/pull/1092) Fix broken documentation link to AndroidBuildVersionCodes (cla: yes)

[1093](https://github.com/flutter/plugins/pull/1093) [image_picker] Fixed a crash that would occur when called in quick succession on Android (cla: yes)

[1102](https://github.com/flutter/plugins/pull/1102) cleanup (cla: yes)

[1103](https://github.com/flutter/plugins/pull/1103) Migrate independent plugins to AndroidX (cla: yes)

[1104](https://github.com/flutter/plugins/pull/1104) Include Android SDK 27 in the docker image and accept licenses (cla: yes)

[1105](https://github.com/flutter/plugins/pull/1105) update change log for url launcher (cla: yes)

[1106](https://github.com/flutter/plugins/pull/1106) [firebase_ml_vision] Set minimum iOS to 8 (cla: yes)

[1108](https://github.com/flutter/plugins/pull/1108) Remove 'init' static method (cla: yes)

[1109](https://github.com/flutter/plugins/pull/1109) Update all plugins to minimum iOS 8.0 (cla: yes)

[1112](https://github.com/flutter/plugins/pull/1112) [IAP] Update README (cla: yes)

[1115](https://github.com/flutter/plugins/pull/1115) Migrate remaining plugins to AndroidX (cla: yes)

[1116](https://github.com/flutter/plugins/pull/1116) Add WebView JavaScript channels (Dart side). (cla: yes)

[1117](https://github.com/flutter/plugins/pull/1117) [firebase_auth] Update a broken dependency. (cla: yes)

[1118](https://github.com/flutter/plugins/pull/1118) [IAP] Update dev deps to match flutter_driver (cla: yes)

[1120](https://github.com/flutter/plugins/pull/1120) A few additional Androix dependencies (cla: yes)

[1124](https://github.com/flutter/plugins/pull/1124) Updated `launch` to use async and await, fixed the incorrect return value by `launch` method. (cla: yes)

[1125](https://github.com/flutter/plugins/pull/1125) Fixed image picker crash when used with android alarm manager (cla: yes)

[1126](https://github.com/flutter/plugins/pull/1126) [In_app_purchase] add payment translators in objc (cla: yes)

[1127](https://github.com/flutter/plugins/pull/1127) Revert AndroidX changes for 1.0.0 plugins (cla: yes)

[1128](https://github.com/flutter/plugins/pull/1128) Migrate to AndroidX forward roll (cla: yes)

[1129](https://github.com/flutter/plugins/pull/1129) android_alarm_manager background execution bug fixes (bugfix, cla: yes, submit queue)

[1130](https://github.com/flutter/plugins/pull/1130) WebView JavasScript channels Android implementation. (cla: yes, feature, webview)

[1132](https://github.com/flutter/plugins/pull/1132) Use string to save double for shared_preference(Android). (bugfix, cla: yes, needs love, submit queue)

[1133](https://github.com/flutter/plugins/pull/1133) Added support for persisting alarms across reboots (cla: yes, feature)

[1134](https://github.com/flutter/plugins/pull/1134) Updated connectivity to singleton (cla: yes)

[1135](https://github.com/flutter/plugins/pull/1135) FIx issue with calculating iOS image orientation in certain special c… (cla: yes)

[1138](https://github.com/flutter/plugins/pull/1138) Add a gradle warning to the AndroidX plugins (cla: yes)

[1139](https://github.com/flutter/plugins/pull/1139) WebView JavaScript channels - iOS implementation. (cla: yes)

[1140](https://github.com/flutter/plugins/pull/1140) Change iOS video format back to bgra8888 (cla: yes)

[1147](https://github.com/flutter/plugins/pull/1147) [In_app_purchase] Use json serializer for skproduct wrapper and related classes. (cla: yes)

[1148](https://github.com/flutter/plugins/pull/1148) Update NSNull check with directly checking the expected type.  (cla: yes)

[1149](https://github.com/flutter/plugins/pull/1149) Allow clearing cookies for FlutterWebView (cla: yes)

[1155](https://github.com/flutter/plugins/pull/1155) Updating the example to match the new API (cla: yes, documentation, flutterfire, submit queue)

[1156](https://github.com/flutter/plugins/pull/1156) Add capability of using single plane buffers (cla: yes)

[1157](https://github.com/flutter/plugins/pull/1157) Workaround to fix the camera positioning issue on the google map view (cla: yes)

[1161](https://github.com/flutter/plugins/pull/1161) Add Swift example to README.md for google_maps_flutter (cla: yes)

[1162](https://github.com/flutter/plugins/pull/1162) [In_app_purchase] Expose nslocale and expose currencySymbol instead of currencyCode to match android (cla: yes)

[1163](https://github.com/flutter/plugins/pull/1163) Change from Rectangle<num>/Point<num> to Rect/Offset for ui convenience (cla: yes)

[1169](https://github.com/flutter/plugins/pull/1169) [In_app_purchase] getproductlist basic draft (cla: yes)

[1170](https://github.com/flutter/plugins/pull/1170) Remove ML models from ML Kit Vision plugin (cla: yes)

[1171](https://github.com/flutter/plugins/pull/1171) Revert "IAP add payment translators in objc (#1126)" (cla: yes)

[1172](https://github.com/flutter/plugins/pull/1172) [In_app_purchase] add payment objc translators (cla: yes)

[1173](https://github.com/flutter/plugins/pull/1173) Fix biometrics check error below ios11. (cla: yes)

[1175](https://github.com/flutter/plugins/pull/1175) Add unit tests to connectivity plugin (cla: yes)

[1176](https://github.com/flutter/plugins/pull/1176) Fix Firebase phone auth on Android (cla: yes)

[1177](https://github.com/flutter/plugins/pull/1177) Fix bug causing black screen on some Android devices (cla: yes)

[1178](https://github.com/flutter/plugins/pull/1178) [In_app_purchase] iOS add payment dart wrappers (cla: yes)

[1180](https://github.com/flutter/plugins/pull/1180) Expose exception on the signIn method in Google sign in. (cla: yes)

[1185](https://github.com/flutter/plugins/pull/1185) remove extra space (cla: yes)

[1193](https://github.com/flutter/plugins/pull/1193) Mark some packages as unpublishable (cla: yes)

[1194](https://github.com/flutter/plugins/pull/1194) [In_app_purchase] Fix the param map passed down to the platform channel when calling querySkuDetails (cla: yes)

[1195](https://github.com/flutter/plugins/pull/1195) Fix bug where HttpMetric/Trace dictionaries weren't being initialized on iOS (cla: yes)

[1199](https://github.com/flutter/plugins/pull/1199) [In_app_purchase] fix requesthandler crash (cla: yes)

[1200](https://github.com/flutter/plugins/pull/1200) WebView controller let's you clear cache (cla: yes)

[1202](https://github.com/flutter/plugins/pull/1202) Fix IllegalStateException for cloud_firestore transactions (cla: yes)

[1203](https://github.com/flutter/plugins/pull/1203) Don’t send empty cloud_firestore snapshots on iOS when encountering errors (cla: yes)

[1204](https://github.com/flutter/plugins/pull/1204) Remove assertion for firebase_core that can interfere with hot-restart (cla: yes)

[1205](https://github.com/flutter/plugins/pull/1205) Introduce CODEOWNERS (cla: yes)

[1206](https://github.com/flutter/plugins/pull/1206) Fix iOS transactions when getting a snapshot that doesn't exist (cla: yes)

[1207](https://github.com/flutter/plugins/pull/1207) Fix cloud_firestore dates on some iOS devices (cla: yes)

[1209](https://github.com/flutter/plugins/pull/1209) fix firestore multiple app support for DocumentSnapshot and transactions (cla: yes)

[1210](https://github.com/flutter/plugins/pull/1210) cloud functions multiple app support (cla: yes)

[1212](https://github.com/flutter/plugins/pull/1212) Change version webview flutter (cla: yes)

[1213](https://github.com/flutter/plugins/pull/1213) Set GoogleAppMeasurement dependency version (cla: yes)

[1214](https://github.com/flutter/plugins/pull/1214) Video player supported formats (cla: yes)

[1215](https://github.com/flutter/plugins/pull/1215) Bump video_player version to 0.10.0+2 (cla: yes)

[1217](https://github.com/flutter/plugins/pull/1217) [android_alarm_manager] Include missing dependency (cla: yes)

[1220](https://github.com/flutter/plugins/pull/1220) remove the blank line in CODEOWNER (cla: yes)

[1221](https://github.com/flutter/plugins/pull/1221) Remove the method channel's reference to webview/maps on dispose. (cla: yes)

[1222](https://github.com/flutter/plugins/pull/1222) [In_app_purchase]remove categories (cla: yes)

[1225](https://github.com/flutter/plugins/pull/1225) Rotate image file based on Exif data (cla: yes, submit queue)

[1226](https://github.com/flutter/plugins/pull/1226) Remove categories (cla: yes)

[1230](https://github.com/flutter/plugins/pull/1230) [IAP] Add Java call for launchBillingFlow (cla: yes)

[1231](https://github.com/flutter/plugins/pull/1231) [in_app_purchase] make payment objc (cla: yes)

[1232](https://github.com/flutter/plugins/pull/1232) [IAP] Add the Dart API for launchBillingFlow (cla: yes)

[1238](https://github.com/flutter/plugins/pull/1238) [Camera] remove extra space in CHANGELOG (cla: yes)

[1242](https://github.com/flutter/plugins/pull/1242) Bugfix documents: webview_flutter JavascriptChannel, Example is not updated. (cla: yes)

[1246](https://github.com/flutter/plugins/pull/1246) Collection literals ignores in webview flutter plugin (cla: yes)

[1248](https://github.com/flutter/plugins/pull/1248) Remove left over conflict marker (cla: yes)
