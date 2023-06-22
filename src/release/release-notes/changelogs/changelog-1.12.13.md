---
title: Change log for Flutter 1.12.13
short-title: 1.12.13 change log
description: Change log for Flutter 1.12.13 containing a list of all PRs merged for this release.
---

## PRs closed in this release of flutter/flutter

From Sun Aug 19 17:37:00 2019 -0700 to Mon Nov 25 12:05:00 2019 -0800


[34188](https://github.com/flutter/flutter/pull/34188) Use separate isolate for image loading. (a: images, a: tests, cla: yes, framework)

[35100](https://github.com/flutter/flutter/pull/35100) Add handling of 'TextInput.clearClient' message from platform to framework (#35054). (a: text input, cla: yes, framework)

[35516](https://github.com/flutter/flutter/pull/35516) more UI-as-code (cla: yes, team)

[36864](https://github.com/flutter/flutter/pull/36864) Clean up bots output and remove timeouts (cla: yes, team, waiting for tree to go green)

[36871](https://github.com/flutter/flutter/pull/36871) Audit use of defaultTargetPlatform (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)

[36998](https://github.com/flutter/flutter/pull/36998) Added properties in DropdownButtonFormField to match DropdownButton (cla: yes, f: material design, framework)

[37024](https://github.com/flutter/flutter/pull/37024) Implement PageView using SliverLayoutBuilder, Deprecate RenderSliverFillViewport (cla: yes, f: gestures, f: scrolling, framework, severe: API break, waiting for tree to go green)

[37268](https://github.com/flutter/flutter/pull/37268) run web tests in batches; enable foundation tests (cla: yes, ☸ platform-web)

[37416](https://github.com/flutter/flutter/pull/37416) Add MediaQuery.systemGestureInsets to support Android Q (cla: yes, customer: crowd, framework, severe: new feature, ▣ platform-android)

[37508](https://github.com/flutter/flutter/pull/37508) build bundle with assemble (cla: yes, tool)

[37526](https://github.com/flutter/flutter/pull/37526) catch errors during gradle update (cla: yes, tool)

[37544](https://github.com/flutter/flutter/pull/37544) Replace ButtonBar.bar method with ButtonBarTheme (cla: yes, d: examples, f: material design, framework, severe: API break, team, team: gallery)

[37642](https://github.com/flutter/flutter/pull/37642) Unit test for build.dart::GenSnapshot (cla: yes, tool)

[37645](https://github.com/flutter/flutter/pull/37645) Update CONTRIBUTING.md (cla: yes, team)

[37646](https://github.com/flutter/flutter/pull/37646) Instrument pending timers in tests (a: tests, cla: yes, framework)

[37719](https://github.com/flutter/flutter/pull/37719) CupertinoDynamicColor and friends (cla: yes, f: cupertino, f: material design, framework)

[37739](https://github.com/flutter/flutter/pull/37739) Fix AnimationStatus for repeat(reverse: true) and animateWith (a: animation, cla: yes, framework, severe: API break)

[37819](https://github.com/flutter/flutter/pull/37819) Add HtmlElementView (the Flutter Web platform view) (cla: yes, framework, ☸ platform-web)

[37832](https://github.com/flutter/flutter/pull/37832) add --exit and --match-host-platform defaults to devicelab runner (cla: yes, team, tool)

[37845](https://github.com/flutter/flutter/pull/37845) echo error messages to stderr (CQ+1, cla: yes, tool)

[37896](https://github.com/flutter/flutter/pull/37896) Add opacity control to MouseRegion. Add findAnnotations to Layer. (a: desktop, cla: yes, framework, severe: API break)

[37901](https://github.com/flutter/flutter/pull/37901) [macos] Check for special keys before creating a logical key (a: desktop, cla: yes, framework, ⌘‬ platform-mac)

[37962](https://github.com/flutter/flutter/pull/37962) Show search app bar theme (cla: yes, f: material design, framework)

[38317](https://github.com/flutter/flutter/pull/38317) TweenAnimationBuilder for building custom animations without managing an AnimationController (a: animation, cla: yes, framework)

[38464](https://github.com/flutter/flutter/pull/38464) Moved the default BinaryMessenger instance to ServicesBinding (a: accessibility, a: tests, cla: yes, f: cupertino, f: material design, framework, team)

[38481](https://github.com/flutter/flutter/pull/38481) Timer picker fidelity revision (cla: yes, f: cupertino, framework, severe: API break, will affect goldens)

[38560](https://github.com/flutter/flutter/pull/38560) refactor cocoapods validator to detect broken install (cla: yes, tool)

[38568](https://github.com/flutter/flutter/pull/38568) Normalize assert checking of clipBehavior (CQ+1, cla: yes, f: material design, framework, severe: API break)

[38573](https://github.com/flutter/flutter/pull/38573) Clamp scrollOffset to prevent textfield bouncing (a: text input, cla: yes, framework)

[38576](https://github.com/flutter/flutter/pull/38576) flutter_tools/version: git log.showSignature=false (cla: yes, tool)

[38583](https://github.com/flutter/flutter/pull/38583) Added InheritedTheme (cla: yes, f: material design, framework)

[38632](https://github.com/flutter/flutter/pull/38632) Flutter Plugin Tool supports multi-platform plugin config (cla: yes, tool)

[38643](https://github.com/flutter/flutter/pull/38643) PlatformViewLink handles focus (a: platform-views, cla: yes, framework)

[38650](https://github.com/flutter/flutter/pull/38650) Allow independent theming of Persistent and Modal bottom sheets (cla: yes, f: material design, framework)

[38654](https://github.com/flutter/flutter/pull/38654) [flutter_tool] Remove some async file io (cla: yes, tool)

[38699](https://github.com/flutter/flutter/pull/38699) fix widgetspan does not work with ellipsis in text widget (cla: yes, framework)

[38709](https://github.com/flutter/flutter/pull/38709) [Material] Add contentPadding property to SwitchListTile (cla: yes, f: material design, framework)

[38712](https://github.com/flutter/flutter/pull/38712) Show process error when iOS install fails (cla: yes, tool)

[38723](https://github.com/flutter/flutter/pull/38723) Handle compilation failures from web application (cla: yes, tool, ☸ platform-web)

[38724](https://github.com/flutter/flutter/pull/38724) Remove xcconfigs from template Copy Bundle Resources build phases (cla: yes, d: examples, t: xcode, team, team: gallery, tool, ⌺‬ platform-ios)

[38726](https://github.com/flutter/flutter/pull/38726) Make disabled buttons/chips/text fields not be focusable. (CQ+1, cla: yes, f: material design, framework)

[38748](https://github.com/flutter/flutter/pull/38748) Create correctly structured framework for macOS (cla: yes, tool)

[38789](https://github.com/flutter/flutter/pull/38789) Fix DragTarget not being rebuilt when a rejected Draggable enters #38786 (cla: yes, framework)

[38813](https://github.com/flutter/flutter/pull/38813) Add ToggleButtons.textStyle property (cla: yes, f: material design, framework)

[38814](https://github.com/flutter/flutter/pull/38814) Add iOS backdrop filter benchmarks (cla: yes, severe: performance, team)

[38815](https://github.com/flutter/flutter/pull/38815) Revert "Added a composable waitForCondition Driver/extension API (#37… (a: tests, cla: yes, framework)

[38821](https://github.com/flutter/flutter/pull/38821) Cache caret parameters (a: text input, cla: yes, framework, severe: performance)

[38823](https://github.com/flutter/flutter/pull/38823) Print service url when connecting to web applications (cla: yes, tool, ☸ platform-web)

[38831](https://github.com/flutter/flutter/pull/38831) [Material] Add clip property to bottom sheet and theme (cla: yes, f: material design, framework)

[38833](https://github.com/flutter/flutter/pull/38833) More explicit link to xkcd in CoC (cla: yes)

[38836](https://github.com/flutter/flutter/pull/38836) Added a composable waitForCondition Driver/extension API. (a: tests, cla: yes, framework)

[38840](https://github.com/flutter/flutter/pull/38840) Fix analyzer issues for onReportTiming to frameTiming (a: tests, cla: yes, framework)

[38858](https://github.com/flutter/flutter/pull/38858) Use GLFW-name artifacts on Windows and Linux (cla: yes, tool)

[38861](https://github.com/flutter/flutter/pull/38861) Replace deprecated onReportTimings w/ frameTimings (cla: yes, framework, severe: performance)

[38866](https://github.com/flutter/flutter/pull/38866) Revert "Automatic focus highlight mode for FocusManager (#37825)" (cla: yes, f: material design, framework)

[38869](https://github.com/flutter/flutter/pull/38869) Store file hashes per build configuration. (cla: yes, tool)

[38894](https://github.com/flutter/flutter/pull/38894) [flutter_tool] Move http request close under try-catch (cla: yes, tool)

[38895](https://github.com/flutter/flutter/pull/38895) [Shrine] Adding outlines to text fields (cla: yes, d: examples, team, team: gallery)

[38898](https://github.com/flutter/flutter/pull/38898) ToggleButtons test improvement (cla: yes, f: material design, framework)

[38905](https://github.com/flutter/flutter/pull/38905) Remove iphonesimulator from SUPPORTED_PLATFORMS for Profile and Release modes (cla: yes, t: xcode, tool, ⌺‬ platform-ios)

[38907](https://github.com/flutter/flutter/pull/38907) Throw error when hot reload enters bad state (cla: yes, tool)

[38909](https://github.com/flutter/flutter/pull/38909) Add support for macOS release/profile mode (3 of 3) (cla: yes, tool, ⌘‬ platform-mac)

[38916](https://github.com/flutter/flutter/pull/38916) Update BUILD.gn for package:flutter_test (a: tests, cla: yes, framework)

[38920](https://github.com/flutter/flutter/pull/38920) [flutter_tool] Handle crashes from doctor validators (cla: yes, tool)

[38922](https://github.com/flutter/flutter/pull/38922) Better docs for text (ready to land) (cla: yes, framework, waiting for tree to go green)

[38925](https://github.com/flutter/flutter/pull/38925) [flutter_tool] Only send one crash report per run (cla: yes, tool)

[38930](https://github.com/flutter/flutter/pull/38930) Implement system fonts system channel listener (cla: yes, framework)

[38932](https://github.com/flutter/flutter/pull/38932) Add build warning for non-debug desktop builds (cla: yes, tool)

[38936](https://github.com/flutter/flutter/pull/38936) Fix KeySet<T> (and LogicalKeySet) hashCode calculation (cla: yes, framework)

[38979](https://github.com/flutter/flutter/pull/38979) Adding onEnd callback to implicit animated widgets (a: animation, cla: yes, framework, waiting for tree to go green)

[38992](https://github.com/flutter/flutter/pull/38992) Clean Xcode workspace during flutter clean (cla: yes, tool)

[38999](https://github.com/flutter/flutter/pull/38999) Mark smoke_catalina_start_up not flaky (CQ+1, cla: yes, team)

[39000](https://github.com/flutter/flutter/pull/39000) Dont throw StateError when calling assemble (CQ+1, cla: yes, tool)

[39005](https://github.com/flutter/flutter/pull/39005) [flutter_tool] Teach crash reporter about HttpException (cla: yes, tool)

[39006](https://github.com/flutter/flutter/pull/39006) Add web workflow to default validators (cla: yes, tool)

[39013](https://github.com/flutter/flutter/pull/39013) Update package versions to latest (cla: yes, tool)

[39017](https://github.com/flutter/flutter/pull/39017) Add "OneSequenceRecognizer.resolvePointer". Fix DragGestureRecognizer crash on multiple pointers (a: desktop, cla: yes, f: gestures, framework)

[39052](https://github.com/flutter/flutter/pull/39052) Make forward calls run interactively (cla: yes, tool)

[39056](https://github.com/flutter/flutter/pull/39056) Fixed issues with Background Color #34741 (cla: yes, f: cupertino, framework)

[39059](https://github.com/flutter/flutter/pull/39059) Explain const values in MediaQuery test file (cla: yes, framework)

[39066](https://github.com/flutter/flutter/pull/39066) Kill resident runner on browser disconnect. (cla: yes, tool, ☸ platform-web)

[39072](https://github.com/flutter/flutter/pull/39072) Break dependency of tools/lib/src from lib/src/commands/ (cla: yes, tool)

[39073](https://github.com/flutter/flutter/pull/39073) Add profile mode to flutter web applications (cla: yes, tool, ☸ platform-web)

[39079](https://github.com/flutter/flutter/pull/39079) fix widget built twice during warm up frame (cla: yes, f: scrolling, framework, severe: API break, waiting for tree to go green)

[39080](https://github.com/flutter/flutter/pull/39080) Fix plugin template app's tests (cla: yes, team, tool)

[39082](https://github.com/flutter/flutter/pull/39082) Golden Doc Updates (a: tests, cla: yes, d: api docs, d: examples, framework, waiting for tree to go green)

[39085](https://github.com/flutter/flutter/pull/39085) Make inspector details subtree depth configurable. (cla: yes, framework)

[39088](https://github.com/flutter/flutter/pull/39088) Doc Improvements for SliverFillRemaining (cla: yes, d: api docs, d: examples, framework, waiting for tree to go green)

[39089](https://github.com/flutter/flutter/pull/39089) Correct InheritedTheme.captureAll() for multiple theme ancestors of the same type (cla: yes, framework)

[39124](https://github.com/flutter/flutter/pull/39124) Update image_list example to use https instead of http (a: images, cla: yes, d: examples, framework, team)

[39126](https://github.com/flutter/flutter/pull/39126) Fid app bundle in Gradle 3.5 (cla: yes, tool)

[39136](https://github.com/flutter/flutter/pull/39136) [flutter_tool] Some additional input validation for 'version' (cla: yes, tool, waiting for tree to go green)

[39140](https://github.com/flutter/flutter/pull/39140) Move commands into their own shard (cla: yes, tool)

[39142](https://github.com/flutter/flutter/pull/39142) fix sliverfixedextent with sliverchildbuilderdelegate does not correc… (cla: yes, f: scrolling, framework)

[39144](https://github.com/flutter/flutter/pull/39144) Add the textAlignVertical param to TextFormField (cla: yes, f: material design, framework)

[39145](https://github.com/flutter/flutter/pull/39145) Add missing files in the Gradle wrapper directory (cla: yes, t: gradle, tool)

[39147](https://github.com/flutter/flutter/pull/39147) Downgrade the AndroidX warning (cla: yes, tool)

[39150](https://github.com/flutter/flutter/pull/39150) Mention conduct@flutter.dev (cla: yes, waiting for tree to go green)

[39156](https://github.com/flutter/flutter/pull/39156) Added Scaffold.extendBodyBehindAppBar (cla: yes, f: material design, framework)

[39157](https://github.com/flutter/flutter/pull/39157) Use new Maven artifacts from Gradle (cla: yes, t: gradle, tool)

[39160](https://github.com/flutter/flutter/pull/39160) Revert "echo error messages to stderr" (cla: yes, waiting for tree to go green)

[39189](https://github.com/flutter/flutter/pull/39189) fix source map loading and service protocol for flutter web (cla: yes, tool)

[39195](https://github.com/flutter/flutter/pull/39195) respect reversed scroll views (cla: yes, framework)

[39196](https://github.com/flutter/flutter/pull/39196) Added a Driver wait condition for no pending platform messages (a: tests, cla: yes, framework)

[39198](https://github.com/flutter/flutter/pull/39198) Docs (a: tests, cla: yes, f: material design, framework)

[39214](https://github.com/flutter/flutter/pull/39214) Place terminalUi flag on terminal interface (cla: yes, tool)

[39215](https://github.com/flutter/flutter/pull/39215) CupertinoActionSheet dark mode & fidelity (cla: yes, f: cupertino, framework)

[39225](https://github.com/flutter/flutter/pull/39225) Manul engine roll to d4932ba71 (cla: yes, engine)

[39252](https://github.com/flutter/flutter/pull/39252) Adds relayout option to CustomMultiChildLayout. (cla: yes, customer: wednesday, framework)

[39263](https://github.com/flutter/flutter/pull/39263) Change SliverGeometry.maxScrollObstructionExtent for RenderSliverFloatingPersistentHeader to match docs (cla: yes, framework)

[39264](https://github.com/flutter/flutter/pull/39264) Add profile support on macOS (cla: yes, tool)

[39274](https://github.com/flutter/flutter/pull/39274) Use output dir instead of specific paths in assemble rules (cla: yes, tool)

[39280](https://github.com/flutter/flutter/pull/39280) [flutter_tool] Use a timeout for xcode showBuildSettings (cla: yes, tool)

[39282](https://github.com/flutter/flutter/pull/39282) Expose text metrics in TextPainter. (cla: yes, framework)

[39286](https://github.com/flutter/flutter/pull/39286) Update docs for GrowthDirection and scrollOffset (cla: yes, d: api docs, framework, waiting for tree to go green)

[39289](https://github.com/flutter/flutter/pull/39289) CupertinoActivityIndicator & CupertinoApp dark mode (cla: yes, f: cupertino, framework)

[39299](https://github.com/flutter/flutter/pull/39299) Add showAboutDialog sample (cla: yes, f: material design, framework)

[39300](https://github.com/flutter/flutter/pull/39300) Add smoke tests for Catalina/Android testing. (cla: yes, team)

[39312](https://github.com/flutter/flutter/pull/39312) let flutter build aar use a local engine (cla: yes, tool)

[39333](https://github.com/flutter/flutter/pull/39333) Allow independent theming of Persistent and Modal bottom sheets Background Color (cla: yes, f: material design, framework)

[39338](https://github.com/flutter/flutter/pull/39338) [flutter_tool] Create a temp snapshot to run create_test.dart tests (cla: yes, tool)

[39344](https://github.com/flutter/flutter/pull/39344) Upstream changes necessary for text editing in flutter web (a: text input, cla: yes, framework, ☸ platform-web)

[39345](https://github.com/flutter/flutter/pull/39345) Adding header rule to FB hosting for API docs. (cla: yes, team)

[39347](https://github.com/flutter/flutter/pull/39347) Revert "Add smoke tests for Catalina/Android testing." (cla: yes, team)

[39353](https://github.com/flutter/flutter/pull/39353) Rename macos_build_flutter_assets.sh (cla: yes, tool)

[39354](https://github.com/flutter/flutter/pull/39354) Add IterableFlagsProperty and use it on proxy box classes (cla: yes, framework)

[39357](https://github.com/flutter/flutter/pull/39357) Relax requirements around local engine, build hello_world with bitcode (cla: yes, d: examples, t: xcode, team, tool, ⌺‬ platform-ios)

[39358](https://github.com/flutter/flutter/pull/39358) surface errors from build runner (cla: yes, tool)

[39361](https://github.com/flutter/flutter/pull/39361) [devicelab] Reland adding smoke tests for Catalina/Android testing (cla: yes, team)

[39363](https://github.com/flutter/flutter/pull/39363) Move ios tests to the right section (cla: yes, team)

[39364](https://github.com/flutter/flutter/pull/39364) Correct libraries path and remove dart:io and dart:isolate for dart platform (cla: yes, tool, ☸ platform-web)

[39414](https://github.com/flutter/flutter/pull/39414) Make sure profile is forwarded through build web command (cla: yes, tool, ☸ platform-web)

[39428](https://github.com/flutter/flutter/pull/39428) Replace doc example text (cla: yes, framework)

[39429](https://github.com/flutter/flutter/pull/39429) Update packages --force-upgrade (cla: yes, team)

[39430](https://github.com/flutter/flutter/pull/39430) make CupertinoDynamicColor const constructible (cla: yes, f: cupertino, framework)

[39431](https://github.com/flutter/flutter/pull/39431) Revert "Relax requirements around local engine, build hello_world with bitcode" (cla: yes, d: examples, team, tool)

[39432](https://github.com/flutter/flutter/pull/39432) Do not hide .git in zip for Windows (cla: yes, team, waiting for tree to go green)

[39433](https://github.com/flutter/flutter/pull/39433) Add helperMaxLines to InputDecoration and InputDecorationTheme (cla: yes, f: material design, framework)

[39434](https://github.com/flutter/flutter/pull/39434) Reland "Relax arguments around local engine, build hello_world with bitcode" (cla: yes, d: examples, team, tool)

[39439](https://github.com/flutter/flutter/pull/39439) Measure iOS CPU/GPU percentage (cla: yes, severe: performance, team)

[39440](https://github.com/flutter/flutter/pull/39440) Allow gaps in the initial route (cla: yes, f: routes, framework, severe: API break, ☸ platform-web)

[39445](https://github.com/flutter/flutter/pull/39445) [flutter_tool] Add onError callback to asyncGuard. Use it in Doctor (cla: yes, tool)

[39446](https://github.com/flutter/flutter/pull/39446) Add viewType to PlatformViewLink (a: platform-views, cla: yes, framework)

[39447](https://github.com/flutter/flutter/pull/39447) Revert "Better docs for text (ready to land)" (cla: yes, f: material design, framework)

[39448](https://github.com/flutter/flutter/pull/39448) Update README.md (cla: yes, team)

[39450](https://github.com/flutter/flutter/pull/39450) Check phone number formatting in the gallery text fields demo (cla: yes, d: examples, f: material design, team, team: gallery)

[39457](https://github.com/flutter/flutter/pull/39457) Log flags in build apk and appbundle (cla: yes)

[39462](https://github.com/flutter/flutter/pull/39462) Remove run in shell and add unit test for chrome launching (cla: yes, tool, ☸ platform-web)

[39463](https://github.com/flutter/flutter/pull/39463) Update validation to support Xcode11 version (cla: yes, t: xcode, tool, waiting for tree to go green, ‎‍💻platform-catalina)

[39503](https://github.com/flutter/flutter/pull/39503) Remove bitcode=NO from add-to-app flows (cla: yes, team, tool)

[39504](https://github.com/flutter/flutter/pull/39504) Revert "Expose text metrics in TextPainter." (cla: yes, framework)

[39505](https://github.com/flutter/flutter/pull/39505) fix recursiveCopy to preserve executable bit (cla: yes, team)

[39509](https://github.com/flutter/flutter/pull/39509) Skip failing add2app test to unblock roll (a: tests, cla: yes, team)

[39514](https://github.com/flutter/flutter/pull/39514) kill leaked chrome processes (cla: yes, team)

[39515](https://github.com/flutter/flutter/pull/39515) migrate from slow async io calls (a: tests, cla: yes, framework, team)

[39519](https://github.com/flutter/flutter/pull/39519) Reland "Expose LineMetrics in TextPainter (#39282)" (cla: yes, framework)

[39523](https://github.com/flutter/flutter/pull/39523) Revert "Add handling of 'TextInput.clearClient' message from platform… (cla: yes, framework)

[39524](https://github.com/flutter/flutter/pull/39524) Register flutterVersion service in flutter_tools. (cla: yes, tool)

[39530](https://github.com/flutter/flutter/pull/39530) keep symbols for profile (cla: yes, tool)

[39535](https://github.com/flutter/flutter/pull/39535) Do not render any frames when just initializing Bindings (a: tests, cla: yes, framework, severe: API break, waiting for tree to go green)

[39539](https://github.com/flutter/flutter/pull/39539) Keep Flutter.framework binaries writable so they can be code signed (a: existing-apps, cla: yes, t: xcode, tool)

[39540](https://github.com/flutter/flutter/pull/39540) Revert "Roll engine 9a17d8e45197..101e03c1c841 (4 commits)" (cla: yes, engine)

[39541](https://github.com/flutter/flutter/pull/39541) Handle single unsupported device (cla: yes, team, tool)

[39543](https://github.com/flutter/flutter/pull/39543) create .dart_tool if it is missing (cla: yes, tool, ☸ platform-web)

[39545](https://github.com/flutter/flutter/pull/39545) remove a period from the service protocol printout (cla: yes, tool)

[39555](https://github.com/flutter/flutter/pull/39555) Use feature flags to control build command visibility (cla: yes, tool)

[39558](https://github.com/flutter/flutter/pull/39558) Filter error message from skip build script checks (cla: yes, tool)

[39572](https://github.com/flutter/flutter/pull/39572) Prevent exception when creating a Divider borderSide (cla: yes, f: material design, framework)

[39577](https://github.com/flutter/flutter/pull/39577) Use dpr and window size from binding for accessibility guide (a: tests, cla: yes, framework)

[39579](https://github.com/flutter/flutter/pull/39579) [flutter_tools] Add a timeout to another showBuildSettings command (cla: yes, tool)

[39580](https://github.com/flutter/flutter/pull/39580) Mark flutter_gallery__transition_perf as non-flaky (cla: yes, team)

[39581](https://github.com/flutter/flutter/pull/39581) Update dartdoc to 0.28.5 (cla: yes, team)

[39583](https://github.com/flutter/flutter/pull/39583) Fix single action banner to ensure button alignment (cla: yes, f: material design, framework)

[39585](https://github.com/flutter/flutter/pull/39585) remove fallback code for ios/usb artifacts (cla: yes, tool, waiting for tree to go green)

[39588](https://github.com/flutter/flutter/pull/39588) Revert "fix recursiveCopy to preserve executable bit" (cla: yes, team)

[39589](https://github.com/flutter/flutter/pull/39589) Re-Land of HighlightMode change with benchmark improvements. (a: desktop, cla: yes, framework)

[39590](https://github.com/flutter/flutter/pull/39590) Fix user gesture in CupertinoPageRoute (cla: yes, f: cupertino, framework)

[39594](https://github.com/flutter/flutter/pull/39594) Reland "fix recursiveCopy to preserve executable bit" (cla: yes, team)

[39598](https://github.com/flutter/flutter/pull/39598) disable low value linux tests (cla: yes, team)

[39600](https://github.com/flutter/flutter/pull/39600) Let Material BackButton have a custom onPressed handler (cla: yes, f: material design, framework)

[39626](https://github.com/flutter/flutter/pull/39626) disable low value windows tests (cla: yes, team)

[39627](https://github.com/flutter/flutter/pull/39627) Default colorScheme data in ButtonThemeData (fix for #38655) (cla: yes, f: material design, framework, passed first triage)

[39628](https://github.com/flutter/flutter/pull/39628) Automatically generated registrants for web plugins (cla: yes, team, tool, ☸ platform-web)

[39632](https://github.com/flutter/flutter/pull/39632) Updates to debugFillProperties to test all properties in slider.dart and slider_test.dart (cla: yes, f: material design, framework, waiting for tree to go green)

[39654](https://github.com/flutter/flutter/pull/39654) Use persisted build information to automatically clean old outputs (cla: yes, tool)

[39670](https://github.com/flutter/flutter/pull/39670) Center action icons of swipe to dismiss example (cla: yes, d: examples, f: material design, team, team: gallery)

[39699](https://github.com/flutter/flutter/pull/39699) Detecting when installing over MingW's Git Bash, fixing paths (cla: yes, tool, waiting for tree to go green)

[39701](https://github.com/flutter/flutter/pull/39701) Remove input files argument to target (cla: yes, tool)

[39702](https://github.com/flutter/flutter/pull/39702) Fix macOS App.framework version symlink (cla: yes, tool)

[39747](https://github.com/flutter/flutter/pull/39747) Fix type mismatch in Gradle (cla: yes, tool)

[39748](https://github.com/flutter/flutter/pull/39748) print launching on device message (cla: yes, tool, ☸ platform-web)

[39751](https://github.com/flutter/flutter/pull/39751) Minor cleanup and prevent multiple exit (cla: yes, tool, ☸ platform-web)

[39752](https://github.com/flutter/flutter/pull/39752) Add delay to recompile request for web (cla: yes, tool)

[39756](https://github.com/flutter/flutter/pull/39756) remove web flag from create (cla: yes, tool)

[39761](https://github.com/flutter/flutter/pull/39761) Null TextWidthBasis docs (cla: yes, f: material design, framework)

[39765](https://github.com/flutter/flutter/pull/39765) CupertinoButton & Bottom tab bar dark mode (cla: yes, f: cupertino, f: material design, framework)

[39768](https://github.com/flutter/flutter/pull/39768) Revert "Remove input files argument to target" (cla: yes, tool)

[39769](https://github.com/flutter/flutter/pull/39769) remove input files argument to target (cla: yes, tool)

[39772](https://github.com/flutter/flutter/pull/39772) These Catalina tests are no longer flaky. (cla: yes, team)

[39774](https://github.com/flutter/flutter/pull/39774) workaround for mangled web sdk source map packages (cla: yes, tool)

[39776](https://github.com/flutter/flutter/pull/39776) handle browser refresh (cla: yes, tool)

[39778](https://github.com/flutter/flutter/pull/39778) Revert "Replace deprecated onReportTimings w/ frameTimings" (a: tests, cla: yes, framework)

[39780](https://github.com/flutter/flutter/pull/39780) Updates CORS origin for snippets to a wildcard. (cla: yes, team)

[39781](https://github.com/flutter/flutter/pull/39781) Add lib/generated_plugin_registrant.dart to gitignore (cla: yes, tool)

[39782](https://github.com/flutter/flutter/pull/39782) Allow specifying a project for Xcode getInfo (cla: yes, tool)

[39783](https://github.com/flutter/flutter/pull/39783) Hotfix for 1.9.1 (cla: yes, engine)

[39784](https://github.com/flutter/flutter/pull/39784) Revert Maven dependencies (#39747) (39157) (cla: yes, d: examples, team, tool)

[39786](https://github.com/flutter/flutter/pull/39786) Revert "Show search app bar theme" (cla: yes, f: material design, framework)

[39798](https://github.com/flutter/flutter/pull/39798) Reland #39157 (cla: yes, d: examples, team, tool, waiting for tree to go green)

[39834](https://github.com/flutter/flutter/pull/39834) update to the latest package:dwds (cla: yes, team)

[39836](https://github.com/flutter/flutter/pull/39836) Switch to the Win32 Windows embedding (a: desktop, cla: yes, tool, ❖ platform-windows)

[39837](https://github.com/flutter/flutter/pull/39837) Remove dead accessors of _getUnusedChangesInLastReload. (cla: yes, tool)

[39844](https://github.com/flutter/flutter/pull/39844) Fix curve for popping heroes (cla: yes, framework, waiting for tree to go green)

[39851](https://github.com/flutter/flutter/pull/39851) Build flutter_gallery with bitcode (cla: yes, d: examples, t: xcode, team, team: gallery, waiting for tree to go green, ⌺‬ platform-ios)

[39857](https://github.com/flutter/flutter/pull/39857) Update ToggleButtons constraints default and add new constraints parameter (cla: yes, f: material design, framework, severe: new feature)

[39859](https://github.com/flutter/flutter/pull/39859) Revert "Keep Flutter.framework binaries writable so they can be code signed" (cla: yes, tool)

[39899](https://github.com/flutter/flutter/pull/39899) [flutter_tool] process.dart cleanup (cla: yes, tool)

[39903](https://github.com/flutter/flutter/pull/39903) Fixed passing autofocus to MaterialButton, and when rebuilding Focus widget. (cla: yes, f: material design, framework)

[39910](https://github.com/flutter/flutter/pull/39910) If there are no web plugins, don't generate a plugin registrant (cla: yes, tool)

[39912](https://github.com/flutter/flutter/pull/39912) Revert "Build flutter_gallery with bitcode" (cla: yes, d: examples, team, team: gallery)

[39917](https://github.com/flutter/flutter/pull/39917) Fix new prefer_const_constructors after analyzer fix. (a: tests, cla: yes, d: examples, framework, team, team: gallery)

[39919](https://github.com/flutter/flutter/pull/39919) CupertinoDatePicker & CupertinoTimerPicker dark mode (cla: yes, f: cupertino, framework, severe: API break, will affect goldens)

[39924](https://github.com/flutter/flutter/pull/39924) Adds DartPad option to the DartDoc snippet generator. (cla: yes, f: material design, framework, team)

[39927](https://github.com/flutter/flutter/pull/39927) Make CupertinoDynamicColor.resolve return null when given a null color (cla: yes, f: cupertino, framework)

[39932](https://github.com/flutter/flutter/pull/39932) update packages --force upgrade (cla: yes, team)

[39934](https://github.com/flutter/flutter/pull/39934) remove dart dir chrome profile (cla: yes, tool)

[39945](https://github.com/flutter/flutter/pull/39945) added new lifecycle state (a: existing-apps, cla: yes, framework, severe: API break)

[39950](https://github.com/flutter/flutter/pull/39950) Register reload sources call and make 'r' restart for web (cla: yes, tool)

[39951](https://github.com/flutter/flutter/pull/39951) Add "web" server device to allow running flutter for web on arbitrary browsers (cla: yes, tool, ☸ platform-web)

[39983](https://github.com/flutter/flutter/pull/39983) Update the supported library set for Flutter for web (cla: yes, tool)

[39985](https://github.com/flutter/flutter/pull/39985) Revert "Correct libraries path and remove dart:io and dart:isolate for dart platform" (cla: yes, tool)

[39986](https://github.com/flutter/flutter/pull/39986) Enable Proguard by default on release mode (cla: yes, tool)

[39988](https://github.com/flutter/flutter/pull/39988) Roll build runner and remove delay (cla: yes, team, tool, ☸ platform-web)

[39997](https://github.com/flutter/flutter/pull/39997) Remove visibleForTesting annotation; this constructor is used outside… (cla: yes, passed first triage, tool, waiting for tree to go green)

[39999](https://github.com/flutter/flutter/pull/39999) Disable the performance overlay for web (cla: yes, framework, ☸ platform-web)

[40001](https://github.com/flutter/flutter/pull/40001) Update to latest dwds (cla: yes, team)

[40005](https://github.com/flutter/flutter/pull/40005) Cherry-picks for 1.9.1 (cla: yes, engine)

[40007](https://github.com/flutter/flutter/pull/40007) CupertinoAlertDialog dark mode & CupertinoActionSheet fidelity (cla: yes, f: cupertino, framework)

[40009](https://github.com/flutter/flutter/pull/40009) Add null check to _IndicatorPainter._tabOffsetsEqual() to prevent crash (cla: yes, f: material design, framework, severe: crash)

[40011](https://github.com/flutter/flutter/pull/40011) [windows] Searches for pre-release and 'all' Visual Studio installations (cla: yes, tool, ❖ platform-windows)

[40029](https://github.com/flutter/flutter/pull/40029) [BUG] Process all children of intent-filter instead of just the first one to identify default activity (cla: yes, passed first triage, tool, waiting for tree to go green)

[40045](https://github.com/flutter/flutter/pull/40045) clean up use of build runner internals (cla: yes, tool)

[40048](https://github.com/flutter/flutter/pull/40048) fix typo (cla: yes, framework, passed first triage, waiting for tree to go green)

[40049](https://github.com/flutter/flutter/pull/40049) Use build runners script gen directly. (cla: yes, tool)

[40066](https://github.com/flutter/flutter/pull/40066) use IOOverrides to allow inject file system, write test, find bug (cla: yes, tool)

[40089](https://github.com/flutter/flutter/pull/40089) Diagrams and samples for Rank 20-30 popular api docs (cla: yes, d: api docs, d: examples, f: material design, framework, from: study)

[40099](https://github.com/flutter/flutter/pull/40099) Fix double.infinity serialization (cla: yes, framework)

[40100](https://github.com/flutter/flutter/pull/40100) Fix a problem with disposing of focus nodes in tab scaffold (cla: yes, f: cupertino, framework)

[40102](https://github.com/flutter/flutter/pull/40102) Lower the iterations on flutter_gallery__back_button_memory (cla: yes, team)

[40105](https://github.com/flutter/flutter/pull/40105) Ensure frame is scheduled when root widget is attached (cla: yes, framework)

[40112](https://github.com/flutter/flutter/pull/40112) Revert engine roll (cla: yes, engine)

[40117](https://github.com/flutter/flutter/pull/40117) Show outdated CocoaPods version in hint text (cla: yes, t: flutter doctor, tool, waiting for tree to go green)

[40119](https://github.com/flutter/flutter/pull/40119) fix skips to include all channels (cla: yes)

[40131](https://github.com/flutter/flutter/pull/40131) ensure we use pub from flutter SDK (cla: yes, tool)

[40155](https://github.com/flutter/flutter/pull/40155) Remove failing devicelab tests (cla: yes, team)

[40159](https://github.com/flutter/flutter/pull/40159) [flutter_tool] Kill a timing-out process before trying to drain its streams (cla: yes, tool)

[40161](https://github.com/flutter/flutter/pull/40161) Add fullscreenDialog argument in PageRouteBuilder (cla: yes, f: routes, framework, severe: new feature, waiting for tree to go green)

[40165](https://github.com/flutter/flutter/pull/40165) Channel buffers (cla: yes, framework)

[40166](https://github.com/flutter/flutter/pull/40166) Added proper focus handling when pushing and popping routes (cla: yes, f: material design, framework, severe: API break)

[40171](https://github.com/flutter/flutter/pull/40171) Place hot reload artifacts in a temp directory (cla: yes, tool)

[40174](https://github.com/flutter/flutter/pull/40174) Keep Flutter.framework binaries writable so they can be code signed (cla: yes, tool)

[40175](https://github.com/flutter/flutter/pull/40175) Ensure we send hot restart events for flutter web (cla: yes, tool)

[40179](https://github.com/flutter/flutter/pull/40179) Update PopupMenu layout (cla: yes, f: material design, framework, severe: API break)

[40181](https://github.com/flutter/flutter/pull/40181) Update Kotlin and Gradle version (a: accessibility, cla: yes, d: examples, team, team: gallery, tool)

[40186](https://github.com/flutter/flutter/pull/40186) Add shortcuts and actions for default focus traversal (a: desktop, cla: yes, framework, team)

[40189](https://github.com/flutter/flutter/pull/40189) Dark mode CupertinoNavigationBar (cla: yes, f: cupertino, framework, will affect goldens)

[40190](https://github.com/flutter/flutter/pull/40190) disable bitcode for hello_world (cla: yes, d: examples, team)

[40191](https://github.com/flutter/flutter/pull/40191) add host and port to run configuration for web devices (cla: yes, tool, ☸ platform-web)

[40193](https://github.com/flutter/flutter/pull/40193) Pass local engine in flutter_test_performance benchmark (cla: yes, team)

[40194](https://github.com/flutter/flutter/pull/40194) Add an ephemeral directory to Windows projects (a: desktop, cla: yes, tool)

[40195](https://github.com/flutter/flutter/pull/40195) Make Swift plugin template swift-format compliant (cla: yes, tool)

[40197](https://github.com/flutter/flutter/pull/40197) [windows] Refactor to optimize vswhere queries (cla: yes, t: flutter doctor, tool, ❖ platform-windows)

[40200](https://github.com/flutter/flutter/pull/40200) Disable foundation tests since some are failing (cla: yes, team)

[40204](https://github.com/flutter/flutter/pull/40204) Revert "build bundle with assemble" (cla: yes, team, tool)

[40210](https://github.com/flutter/flutter/pull/40210) make sure we launch with dwds (cla: yes, tool)

[40259](https://github.com/flutter/flutter/pull/40259) remove io and isolate from libraries (cla: yes, tool)

[40263](https://github.com/flutter/flutter/pull/40263) Fix crash on vswhere search from flutter doctor (cla: yes, severe: crash, t: flutter doctor, tool, ❖ platform-windows)

[40266](https://github.com/flutter/flutter/pull/40266) Lower the iteration count on back_button_memory test (cla: yes, team)

[40275](https://github.com/flutter/flutter/pull/40275) Manual roll of engine 7ea9884...5b94c8a (64 commits) (cla: yes, engine)

[40280](https://github.com/flutter/flutter/pull/40280) PlatformView: recreate surface if the controller changes (a: platform-views, cla: yes, framework)

[40282](https://github.com/flutter/flutter/pull/40282) Flip the default for proguard (cla: yes, tool, waiting for tree to go green)

[40285](https://github.com/flutter/flutter/pull/40285) Enable FTL reporting on an integration test (cla: yes, d: examples, team)

[40291](https://github.com/flutter/flutter/pull/40291) range_slider_test.dart diagnostics property tests (cla: yes, f: material design, framework)

[40294](https://github.com/flutter/flutter/pull/40294) fix copy command and remove resolve sync for macOS assemble (cla: yes, tool)

[40301](https://github.com/flutter/flutter/pull/40301) Allow skipping webOnlyInitializePlatform in Flutter for Web (cla: yes, tool)

[40302](https://github.com/flutter/flutter/pull/40302) Set DEFINES_MODULE for FlutterPluginRegistrant to generate modulemap (a: existing-apps, cla: yes, team, tool)

[40304](https://github.com/flutter/flutter/pull/40304) Revert engine roll (cla: yes, engine)

[40306](https://github.com/flutter/flutter/pull/40306) Restore offstage and ticker mode after hero pop and the from hero is null (cla: yes, framework)

[40359](https://github.com/flutter/flutter/pull/40359) Revert engine roll (cla: yes, engine)

[40366](https://github.com/flutter/flutter/pull/40366) Place existing dill into hot reload temp directory to boost initialization time (cla: yes, tool)

[40367](https://github.com/flutter/flutter/pull/40367) [Docs] Create 'center' snippets template (cla: yes, f: material design, framework, team)

[40368](https://github.com/flutter/flutter/pull/40368) ensure dart2js does not compile unsupported packages (cla: yes, tool)

[40370](https://github.com/flutter/flutter/pull/40370) rename port to web-port and hostname to web-hostname (cla: yes, tool)

[40372](https://github.com/flutter/flutter/pull/40372) Roll engine from 7ea9884..3c6383f (77 commits 🔥) (cla: yes, engine, waiting for tree to go green)

[40375](https://github.com/flutter/flutter/pull/40375) Harden macOS build use of Xcode project getInfo (cla: yes, tool)

[40386](https://github.com/flutter/flutter/pull/40386) Revert "Roll engine from 7ea9884..3c6383f (77 commits 🔥) (#40372)" (cla: yes, engine)

[40390](https://github.com/flutter/flutter/pull/40390) a11y improvements for textfield (cla: yes, f: material design, framework, waiting for tree to go green)

[40391](https://github.com/flutter/flutter/pull/40391) Place conditional imports on same line (a: tests, cla: yes, framework)

[40393](https://github.com/flutter/flutter/pull/40393) Convert build mode to lowercase in tool_backend (a: desktop, cla: yes, tool)

[40394](https://github.com/flutter/flutter/pull/40394) Roll engine to 6e6de944536b820e4f148036b01004ef0ed68917 (cla: yes, engine)

[40397](https://github.com/flutter/flutter/pull/40397) Adds list required components when VS is not installed (cla: yes, t: flutter doctor, tool, ❖ platform-windows)

[40398](https://github.com/flutter/flutter/pull/40398) roll ios-deploy version to 2fbbee77ea2b3212959b9dddda816f59094cd7cd (cla: yes, tool)

[40399](https://github.com/flutter/flutter/pull/40399) Fix for broken LocalFileComparator output (a: tests, cla: yes, framework)

[40401](https://github.com/flutter/flutter/pull/40401) Make FlutterPluginRegistrant a static framework so add-to-app can use static framework plugins (a: existing-apps, cla: yes, tool, waiting for tree to go green, ⌺‬ platform-ios)

[40404](https://github.com/flutter/flutter/pull/40404) Revert "Roll engine to 6e6de944536b820e4f148036b01004ef0ed68917 (#403… (cla: yes, engine)

[40410](https://github.com/flutter/flutter/pull/40410) Remove fluter tool usage of protobuf (cla: yes, team, tool)

[40435](https://github.com/flutter/flutter/pull/40435) [flutter_tool] Remove the synchronous -showBuildSettings (cla: yes, tool)

[40440](https://github.com/flutter/flutter/pull/40440) Rename useProguard method, so Gradle doesn't get confused (cla: yes, tool, waiting for tree to go green)

[40441](https://github.com/flutter/flutter/pull/40441) Remove all flaky marks (cla: yes, team)

[40442](https://github.com/flutter/flutter/pull/40442) Roll engine 7ea9884..1b6344439 (91 commits 🔥🔥🔥) (cla: yes, engine)

[40446](https://github.com/flutter/flutter/pull/40446) [flutter_tool] Use curly braces around single statment control structures (cla: yes, tool)

[40447](https://github.com/flutter/flutter/pull/40447) Implement mdns for `flutter run` (cla: yes, tool, ⌺‬ platform-ios)

[40453](https://github.com/flutter/flutter/pull/40453) Enable R8 (a: accessibility, cla: yes, d: examples, team, team: gallery, tool, waiting for tree to go green)

[40454](https://github.com/flutter/flutter/pull/40454) Dark Mode R: Refresh Control  (cla: yes, f: cupertino, framework)

[40461](https://github.com/flutter/flutter/pull/40461) Implement DropdownButton.selectedItemBuilder (cla: yes, f: material design, framework, severe: new feature)

[40465](https://github.com/flutter/flutter/pull/40465) Pass --web-hostname and --web-port to release mode debugging options (cla: yes, tool)

[40466](https://github.com/flutter/flutter/pull/40466) ModalRoutes ignore input when a (cupertino) pop transition is underway (cla: yes, f: cupertino, f: material design, framework)

[40468](https://github.com/flutter/flutter/pull/40468) Propagate textfield character limits to semantics (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)

[40470](https://github.com/flutter/flutter/pull/40470) Reland: implement build bundle with assemble (cla: yes, team, tool)

[40472](https://github.com/flutter/flutter/pull/40472) Dont kill other processes when starting desktop application (cla: yes, tool)

[40555](https://github.com/flutter/flutter/pull/40555) [Docs] Add missing trailing comma to stateful_widget_scaffold_center template (cla: yes, team)

[40566](https://github.com/flutter/flutter/pull/40566) Remove CupertinoSystemColors in favor of CupertinoColors (cla: yes, f: cupertino, framework, severe: API break)

[40587](https://github.com/flutter/flutter/pull/40587) Add an ephemeral directory for Linux (cla: yes, tool)

[40607](https://github.com/flutter/flutter/pull/40607) New overview for animations library (a: animation, cla: yes, d: api docs, d: examples, framework, from: study, waiting for tree to go green)

[40608](https://github.com/flutter/flutter/pull/40608) Add the option to configure a chip check mark color (cla: yes, f: material design, framework)

[40609](https://github.com/flutter/flutter/pull/40609) Specify ifTrue and ifFalse for strut FlagProperty (cla: yes, framework)

[40610](https://github.com/flutter/flutter/pull/40610) Enable the resource shrinker (cla: yes, tool)

[40611](https://github.com/flutter/flutter/pull/40611) Warn when build number and version can't be parsed on iOS (cla: yes, tool, ⌺‬ platform-ios)

[40617](https://github.com/flutter/flutter/pull/40617) Wait for first frame in driver tests (cla: yes, d: examples, team, team: gallery)

[40624](https://github.com/flutter/flutter/pull/40624) Revert "Measure iOS CPU/GPU percentage" (cla: yes, team)

[40627](https://github.com/flutter/flutter/pull/40627) Allow skipping chrome launch with --no-web-browser-launch (cla: yes, tool)

[40630](https://github.com/flutter/flutter/pull/40630) enable foundation and physics tests on the Web (cla: yes, team)

[40634](https://github.com/flutter/flutter/pull/40634) Benchmark for un-triaged image results on Flutter Gold (a: tests, cla: yes, framework, team, waiting for tree to go green)

[40635](https://github.com/flutter/flutter/pull/40635) Return WidgetSpans from getSpanForPosition (cla: yes, framework)

[40636](https://github.com/flutter/flutter/pull/40636) Dark mode for CupertinoSwitch and CupertinoScrollbar, Fidelity updates (a: tests, cla: yes, f: cupertino, framework, severe: API break, will affect goldens)

[40638](https://github.com/flutter/flutter/pull/40638) Allow sending platform messages from plugins to the framework and implement EventChannel (cla: yes, framework, plugin)

[40640](https://github.com/flutter/flutter/pull/40640) Exclude non Android plugins from Gradle build (cla: yes, team, tool)

[40641](https://github.com/flutter/flutter/pull/40641) Add onLongPress to Buttons (cla: yes, f: material design, framework, waiting for tree to go green)

[40665](https://github.com/flutter/flutter/pull/40665) Fix CupertinoTextField and TextField ToolbarOptions not changing (cla: yes, f: material design, framework, waiting for tree to go green)

[40678](https://github.com/flutter/flutter/pull/40678) Extract some onPress methods (cla: yes, d: examples, framework, team, team: gallery, waiting for tree to go green)

[40690](https://github.com/flutter/flutter/pull/40690) CupertinoPageScaffold dark mode (cla: yes, f: cupertino, framework, severe: API break)

[40692](https://github.com/flutter/flutter/pull/40692) fix platform environment (cla: yes, tool)

[40695](https://github.com/flutter/flutter/pull/40695) TextField docs for getting value (a: text input, cla: yes, d: api docs, f: material design, framework)

[40697](https://github.com/flutter/flutter/pull/40697) Update keyboard maps (cla: yes, framework, team)

[40701](https://github.com/flutter/flutter/pull/40701) add missing trailing commas (in examples/) (cla: yes, d: examples, framework, team, team: gallery)

[40704](https://github.com/flutter/flutter/pull/40704) add missing trailing commas (in dev/) (cla: yes, framework, team)

[40706](https://github.com/flutter/flutter/pull/40706) Add fake keyboard key generation to the testing framework (a: tests, cla: yes, f: material design, framework)

[40709](https://github.com/flutter/flutter/pull/40709) Fixed Selectable text align is broken (cla: yes, framework)

[40710](https://github.com/flutter/flutter/pull/40710) Skia Gold Support for Local & PreSubmit Testing in package:flutter (a: images, a: tests, cla: yes, framework, severe: API break, team, will affect goldens)

[40713](https://github.com/flutter/flutter/pull/40713) Material textselection context menu cannot disable select all (cla: yes, f: material design, framework)

[40714](https://github.com/flutter/flutter/pull/40714) Revert "Propagate textfield character limits to semantics" (a: accessibility, a: tests, cla: yes, f: material design, framework)

[40715](https://github.com/flutter/flutter/pull/40715) [Flutter Driver] Simplified the serialization/deserialization logic of the Descendant/… (a: tests, cla: yes, framework)

[40718](https://github.com/flutter/flutter/pull/40718) Handle CR+LF end of line sequences in the license parser (cla: yes, framework)

[40730](https://github.com/flutter/flutter/pull/40730) Invalidate macOS pods on plugin changes (cla: yes, tool)

[40743](https://github.com/flutter/flutter/pull/40743) Added notice to docs that setPreferredOrientations does not always work on iPad (cla: yes, d: api docs, framework, waiting for tree to go green)

[40757](https://github.com/flutter/flutter/pull/40757) Fix visibility of web server device when Chrome is not available (cla: yes, tool)

[40766](https://github.com/flutter/flutter/pull/40766) Run `flutter update-packages --force-upgrade`. (cla: yes, team)

[40767](https://github.com/flutter/flutter/pull/40767) Reapply "Revert "Propagate textfield character limits to semantics (#40468)" (a: accessibility, a: tests, cla: yes, f: material design, framework, team, waiting for tree to go green)

[40775](https://github.com/flutter/flutter/pull/40775) Use EdgeInsetsGeometry instead of EdgeInsets (cla: yes, framework, waiting for tree to go green)

[40783](https://github.com/flutter/flutter/pull/40783) ensure debug builds are only accessible through run (cla: yes, tool)

[40786](https://github.com/flutter/flutter/pull/40786)  Fix crash on vswhere query on missing installations (cla: yes, severe: crash, t: flutter doctor, tool, waiting for tree to go green, ❖ platform-windows)

[40792](https://github.com/flutter/flutter/pull/40792) Move build info checks from generating files to the xcode build (cla: yes, tool, ⌺‬ platform-ios)

[40795](https://github.com/flutter/flutter/pull/40795) Update toolchain description to request the latest version (CQ+1, cla: yes, t: flutter doctor, tool, waiting for tree to go green, ❖ platform-windows)

[40806](https://github.com/flutter/flutter/pull/40806) Allow test beds to override defaultTestTimeout (a: tests, cla: yes, framework, waiting for tree to go green)

[40810](https://github.com/flutter/flutter/pull/40810) Re-enable AAR plugins when an AndroidX failure occurred (cla: yes, team, tool)

[40851](https://github.com/flutter/flutter/pull/40851) Support create for macOS (app and plugin) (cla: yes, tool)

[40857](https://github.com/flutter/flutter/pull/40857) Give benchmark output dill path (cla: yes, team)

[40862](https://github.com/flutter/flutter/pull/40862) Revert "Reland: implement build bundle with assemble" (cla: yes, team, tool)

[40864](https://github.com/flutter/flutter/pull/40864) Move iOS and Android gitignore rules into folders (cla: yes, tool)

[40900](https://github.com/flutter/flutter/pull/40900) Stop using deprecated features from Gradle (cla: yes, tool)

[40917](https://github.com/flutter/flutter/pull/40917) AnimatedBuilder API Doc improvements (cla: yes, framework, waiting for tree to go green)

[40925](https://github.com/flutter/flutter/pull/40925) Use AndroidX in new projects by default (cla: yes, tool)

[40927](https://github.com/flutter/flutter/pull/40927) Make module pod headers public (a: existing-apps, cla: yes, tool, ⌺‬ platform-ios)

[40968](https://github.com/flutter/flutter/pull/40968) add missing trailing commas in flutter_tools (cla: yes, team, tool, waiting for tree to go green)

[40979](https://github.com/flutter/flutter/pull/40979) Revert "Run `flutter update-packages --force-upgrade`." (cla: yes, team)

[40984](https://github.com/flutter/flutter/pull/40984) Revert "Use separate isolate for image loading. (#34188)" (cla: yes, framework)

[40988](https://github.com/flutter/flutter/pull/40988) [flutter_tool] Report rss high watermark in command analytics events (cla: yes, tool)

[40993](https://github.com/flutter/flutter/pull/40993) Label bugs created via the SUPPORT template (cla: yes, team)

[40994](https://github.com/flutter/flutter/pull/40994) Fix the ThemeData.copyWith toggleButtonsTheme argument type (cla: yes, f: material design, framework, waiting for tree to go green)

[40995](https://github.com/flutter/flutter/pull/40995) Revert "Use AndroidX in new projects by default" (cla: yes, team, tool)

[40997](https://github.com/flutter/flutter/pull/40997) Force upgrade packages again. (cla: yes, team)

[41000](https://github.com/flutter/flutter/pull/41000) Fix run_release_test (cla: yes, team)

[41001](https://github.com/flutter/flutter/pull/41001) Revert "Revert "Use AndroidX in new projects by default"" (cla: yes, engine, waiting for tree to go green)

[41009](https://github.com/flutter/flutter/pull/41009) Add Sample code to SlideTransition (cla: yes, framework, team, waiting for tree to go green)

[41014](https://github.com/flutter/flutter/pull/41014) Fix mouse hover to not schedule a frame for every mouse move. (a: tests, cla: yes, f: material design, framework)

[41015](https://github.com/flutter/flutter/pull/41015) Add the beginnings of plugin support for Windows and Linux (a: desktop, cla: yes, tool, ❖ platform-windows, 🐧 platform-linux)

[41042](https://github.com/flutter/flutter/pull/41042) Revert "Re-enable AAR plugins when an AndroidX failure occurred" (cla: yes, team, tool)

[41076](https://github.com/flutter/flutter/pull/41076) add missing trailing commas in packages/flutter (cla: yes, framework, team, waiting for tree to go green)

[41108](https://github.com/flutter/flutter/pull/41108) Fixing a text editing bug happening when text field changes. (a: text input, cla: yes, framework)

[41120](https://github.com/flutter/flutter/pull/41120) Dropdown Menu layout respects menu items intrinsic sizes (cla: yes, f: material design, framework, will affect goldens)

[41142](https://github.com/flutter/flutter/pull/41142) Add embedding as API dependency instead of compile only dependency (cla: yes, team, tool, waiting for tree to go green)

[41145](https://github.com/flutter/flutter/pull/41145) Explicitly set CocoaPods version (cla: yes)

[41150](https://github.com/flutter/flutter/pull/41150) Rebuild modal routes when the value of userGestureInProgress changes (cla: yes, f: material design, framework)

[41160](https://github.com/flutter/flutter/pull/41160) Reland #40810: Re-enable AAR plugins when an AndroidX failure occurred (cla: yes, team, tool, waiting for tree to go green)

[41172](https://github.com/flutter/flutter/pull/41172) fix some bad indentations (cla: yes, f: material design, framework, team, tool)

[41206](https://github.com/flutter/flutter/pull/41206) Cherry-picks (cla: yes, engine)

[41207](https://github.com/flutter/flutter/pull/41207) Bump version of just package:multicast_dns (cla: yes, team)

[41211](https://github.com/flutter/flutter/pull/41211) Update AUTHORS (cla: yes, framework, waiting for tree to go green)

[41213](https://github.com/flutter/flutter/pull/41213) Revert engine roll (cla: yes, engine)

[41220](https://github.com/flutter/flutter/pull/41220) Add an ActivateAction to controls that use InkWell. (cla: yes, f: material design, framework, severe: API break, team)

[41222](https://github.com/flutter/flutter/pull/41222) Copy archived js part files out of dart_tool directory (cla: yes, tool, ☸ platform-web)

[41224](https://github.com/flutter/flutter/pull/41224) fix flutter error report correct local widget (a: error message, cla: yes, framework, from: study, team, tool)

[41229](https://github.com/flutter/flutter/pull/41229) V1.9.1 hotfixes (cla: yes, engine, team, tool)

[41230](https://github.com/flutter/flutter/pull/41230) Re-Re-land Implement flutter build bundle with assemble (cla: yes, team, tool)

[41232](https://github.com/flutter/flutter/pull/41232) Revert "Benchmark for un-triaged image results on Flutter Gold" (cla: yes, team)

[41234](https://github.com/flutter/flutter/pull/41234) Reland "Measure iOS CPU/GPU percentage (#39439)" (cla: yes, team)

[41240](https://github.com/flutter/flutter/pull/41240) Manual roll of the engine to 63949eb0fd982b27adc218364805913380af7411. (cla: yes, engine)

[41245](https://github.com/flutter/flutter/pull/41245) Change the way ActionDispatcher is found. (cla: yes, framework)

[41247](https://github.com/flutter/flutter/pull/41247) Desktop manual tests (cla: yes, f: material design, team)

[41251](https://github.com/flutter/flutter/pull/41251) Migrate examples and tests to AndroidX (a: accessibility, cla: yes, d: examples, team, team: gallery)

[41254](https://github.com/flutter/flutter/pull/41254) Test that flutter assets are contained in the APK (cla: yes, team)

[41263](https://github.com/flutter/flutter/pull/41263) fix bad indentation (cla: yes, framework, team)

[41295](https://github.com/flutter/flutter/pull/41295) Revert "Re-Re-land Implement flutter build bundle with assemble" (cla: yes, team, tool)

[41300](https://github.com/flutter/flutter/pull/41300) Modifying unit tests for editable_text (cla: yes, framework)

[41302](https://github.com/flutter/flutter/pull/41302) Re-Re-Re-land implement flutter build bundle with assemble (cla: yes, team, tool)

[41304](https://github.com/flutter/flutter/pull/41304) [flutter_tools] Allows adding multiple signal handlers (cla: yes, tool)

[41320](https://github.com/flutter/flutter/pull/41320) [Material] Remove text ripple from TextFields (cla: yes, f: material design, framework, waiting for tree to go green, will affect goldens)

[41326](https://github.com/flutter/flutter/pull/41326) Exception when selecting in TextField (cla: yes, f: cupertino, framework)

[41327](https://github.com/flutter/flutter/pull/41327) Incorporating Link Semantics (a: accessibility, a: tests, cla: yes, framework)

[41329](https://github.com/flutter/flutter/pull/41329) Refactor: Base tap gesture recognizer (cla: yes, f: gestures, framework, waiting for tree to go green)

[41332](https://github.com/flutter/flutter/pull/41332) Prevent PointerEnter[or Exit]Event from erasing event.down value (a: desktop, cla: yes, framework)

[41333](https://github.com/flutter/flutter/pull/41333) Merge Flutter assets in add to app (cla: yes, team, tool)

[41338](https://github.com/flutter/flutter/pull/41338) Fix ReorderableListView's use of child keys (#41334) (cla: yes, f: material design, framework)

[41342](https://github.com/flutter/flutter/pull/41342) Revert engine rolls (cla: yes, engine)

[41347](https://github.com/flutter/flutter/pull/41347) Fix timing issues in initialization of web resident runner (cla: yes, tool)

[41355](https://github.com/flutter/flutter/pull/41355) fix bad indentations(mainly around collection literals) (cla: yes, f: cupertino, f: material design, framework, team, tool)

[41378](https://github.com/flutter/flutter/pull/41378) Fix erroneous comments referring to blobs snapshots. (cla: yes, team)

[41384](https://github.com/flutter/flutter/pull/41384) [flutter_tools] Report iOS mDNS lookup failures to analytics (cla: yes, tool)

[41386](https://github.com/flutter/flutter/pull/41386) Serve every html file under web (cla: yes, tool)

[41397](https://github.com/flutter/flutter/pull/41397) Keymap for Web (a: accessibility, a: text input, cla: yes, framework, waiting for tree to go green, ☸ platform-web)

[41400](https://github.com/flutter/flutter/pull/41400) Revert "Reland "Measure iOS CPU/GPU percentage (#39439)"" (cla: yes, team)

[41401](https://github.com/flutter/flutter/pull/41401) Flutter build bundle without --precompiled should always perform a debug build. (cla: yes, tool)

[41403](https://github.com/flutter/flutter/pull/41403) Devicelab run.dart: Fixed check for path equality (cla: yes, team)

[41406](https://github.com/flutter/flutter/pull/41406) Retry devfs uploads in case they fail. (cla: yes, tool)

[41408](https://github.com/flutter/flutter/pull/41408) add tests to ensure the sdk is well-formed (cla: yes, tool)

[41410](https://github.com/flutter/flutter/pull/41410) [flutter_tools] Adds tests of mdns analytics events (cla: yes, tool)

[41411](https://github.com/flutter/flutter/pull/41411) roll libimobiledevice artifacts to signed version (cla: yes, tool)

[41415](https://github.com/flutter/flutter/pull/41415) Expose API for resizing image caches (a: images, cla: yes, framework, severe: API break, severe: new feature)

[41417](https://github.com/flutter/flutter/pull/41417) Address previous comments, fix Intent.doNothing. (cla: yes, framework)

[41422](https://github.com/flutter/flutter/pull/41422) Revert "Dropdown Menu layout respects menu items intrinsic sizes" (cla: yes, f: material design, framework)

[41424](https://github.com/flutter/flutter/pull/41424) Don't update last compiled time when compilation is rejected (cla: yes, tool)

[41426](https://github.com/flutter/flutter/pull/41426) Reland "Measure iOS CPU/GPU percentage (#41234)" (cla: yes, team)

[41431](https://github.com/flutter/flutter/pull/41431) Cupertino { TabScafold, TextSelection, TextField } dark mode & minor fidelity update (cla: yes, f: cupertino, f: material design, framework, will affect goldens)

[41441](https://github.com/flutter/flutter/pull/41441) Exit resident web runner on compilation failure (cla: yes, tool, ☸ platform-web)

[41447](https://github.com/flutter/flutter/pull/41447) Switch to assemble API for dart2js (cla: yes, tool)

[41449](https://github.com/flutter/flutter/pull/41449) Revert "Address previous comments, fix Intent.doNothing. (#41417)" (cla: yes, framework, team)

[41463](https://github.com/flutter/flutter/pull/41463) [Chip] Make sure InkResponse is in the foreground on delete for chips with background color (a: fidelity, cla: yes, f: material design, framework)

[41473](https://github.com/flutter/flutter/pull/41473) Missing trailing commas (cla: yes, f: cupertino, f: material design, framework, team, tool)

[41477](https://github.com/flutter/flutter/pull/41477) Reland changes to Intent.doNothing to avoid analyzer issue (cla: yes, framework, team)

[41480](https://github.com/flutter/flutter/pull/41480) Revert "Roll engine 18bc0b259641..e31b2ff64dc2 (1 commits)" (cla: yes, engine)

[41482](https://github.com/flutter/flutter/pull/41482) [flutter_tool] Add analytics events for ios-mdns fallback success/failure (cla: yes, tool)

[41491](https://github.com/flutter/flutter/pull/41491) Skip pod initialization if version >= 1.8.0. (cla: yes, t: flutter doctor, team, team: infra, tool, ⌺‬ platform-ios)

[41493](https://github.com/flutter/flutter/pull/41493) [flutter_tool] Report to analytics when the tool is killed by a signal (cla: yes, tool)

[41498](https://github.com/flutter/flutter/pull/41498) Revert "Exit resident web runner on compilation failure" (cla: yes, tool)

[41499](https://github.com/flutter/flutter/pull/41499) Roll build runner (cla: yes, team, tool)

[41503](https://github.com/flutter/flutter/pull/41503) Revert engine to 5b952f286fc070e99cf192775fa5c9dfe858b692 (cla: yes, engine)

[41504](https://github.com/flutter/flutter/pull/41504) V1.9.1 hotfixes (cla: yes, engine, team, tool)

[41505](https://github.com/flutter/flutter/pull/41505) Reland: Exit resident web runner on compilation failure  (cla: yes, tool)

[41509](https://github.com/flutter/flutter/pull/41509) Add flutter drive to readme. (cla: yes, team)

[41514](https://github.com/flutter/flutter/pull/41514) Ensure we find dart.exe on local engines (cla: yes, tool)

[41515](https://github.com/flutter/flutter/pull/41515) Revert "Don't update last compiled time when compilation is rejected" (cla: yes, tool)

[41519](https://github.com/flutter/flutter/pull/41519) Make desktop stopApp only apply to processes Flutter started (cla: yes, tool, waiting for tree to go green)

[41521](https://github.com/flutter/flutter/pull/41521) Revert "CupertinoDatePicker & CupertinoTimerPicker dark mode" (a: tests, cla: yes, f: cupertino, framework)

[41530](https://github.com/flutter/flutter/pull/41530) Add support for depfile dependency (cla: yes, tool)

[41545](https://github.com/flutter/flutter/pull/41545) Add analytics tracking for compile and refresh times for Flutter Web (cla: yes, tool)

[41551](https://github.com/flutter/flutter/pull/41551) Pass Linux build mode on command line (cla: yes, tool)

[41575](https://github.com/flutter/flutter/pull/41575) Revert "Reland "Measure iOS CPU/GPU percentage (#41234)"" (cla: yes, team)

[41578](https://github.com/flutter/flutter/pull/41578) Reland "Measure iOS CPU/GPU percentage #41426" (cla: yes, team)

[41579](https://github.com/flutter/flutter/pull/41579) Rename the file to fix the device lab (cla: yes, team)

[41580](https://github.com/flutter/flutter/pull/41580) Reland: don't update last compile time when compilation is rejected. (cla: yes, tool)

[41583](https://github.com/flutter/flutter/pull/41583) Add debugging option to write vmservice address to file after starting (cla: yes, tool)

[41610](https://github.com/flutter/flutter/pull/41610) track unused inputs in build_runner (cla: yes, tool)

[41612](https://github.com/flutter/flutter/pull/41612) AOT support for Linux Desktop I: switch Linux builds to assemble (cla: yes, e: glfw, tool)

[41618](https://github.com/flutter/flutter/pull/41618) Rename Server/web to Headless Server/headless-server (cla: yes, tool, ☸ platform-web)

[41621](https://github.com/flutter/flutter/pull/41621) change logging in mDNS discovery to verbose-mode only (cla: yes, tool)

[41625](https://github.com/flutter/flutter/pull/41625) Update DefaultTabController to allow for zero tabs (cla: yes, f: material design, framework, waiting for tree to go green)

[41629](https://github.com/flutter/flutter/pull/41629) [Material] Fix Tooltip to respect ambient Directionality (cla: yes, f: material design, framework, waiting for tree to go green)

[41632](https://github.com/flutter/flutter/pull/41632) fix confusing 'popupTheme' variable name in a MaterialBannerTheme method (cla: yes, f: material design, framework)

[41640](https://github.com/flutter/flutter/pull/41640) some formatting changes (cla: yes, f: material design, framework, team, tool, waiting for tree to go green)

[41644](https://github.com/flutter/flutter/pull/41644) indent formal parameters correctly (cla: yes, f: cupertino, f: material design, framework, team, tool, waiting for tree to go green)

[41646](https://github.com/flutter/flutter/pull/41646) replace package:vm_service_client with package:vm_service in the devicelab project (cla: yes, team, tool, waiting for tree to go green)

[41650](https://github.com/flutter/flutter/pull/41650) DropdownButton.style API doc example for differing button and menu item text styles (cla: yes, f: material design, framework, waiting for tree to go green)

[41651](https://github.com/flutter/flutter/pull/41651) added questions on Platform / OS Version / Device (cla: yes, team, waiting for tree to go green)

[41652](https://github.com/flutter/flutter/pull/41652) [flutter_tools] Add more info to pub get failure event (cla: yes, tool)

[41658](https://github.com/flutter/flutter/pull/41658) Revert "Switch to assemble API for dart2js" (cla: yes, team, tool)

[41659](https://github.com/flutter/flutter/pull/41659) Reland: Switch to assemble API for dart2js (cla: yes, team, tool)

[41666](https://github.com/flutter/flutter/pull/41666) Generate projects using the new Android embedding (cla: yes, tool, ▣ platform-android)

[41675](https://github.com/flutter/flutter/pull/41675) Fix documentation for the required argument (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[41687](https://github.com/flutter/flutter/pull/41687) Use processManager.run() instead of manually capturing streams in test_utils getPackages() (cla: yes, tool, waiting for tree to go green)

[41695](https://github.com/flutter/flutter/pull/41695) Add more information to cannot find Chrome message (cla: yes, tool, ☸ platform-web)

[41697](https://github.com/flutter/flutter/pull/41697) Handle missing .packages file in the flutter tool for prebuilt artifacts (cla: yes, tool)

[41698](https://github.com/flutter/flutter/pull/41698) Download android x64 release artifacts (cla: yes, tool)

[41704](https://github.com/flutter/flutter/pull/41704) Manual roll of engine to 16d7694e760a..5c428d924790 (10 commits) (cla: yes, engine)

[41717](https://github.com/flutter/flutter/pull/41717) Update label applied for performance template bugs (cla: yes, team, waiting for tree to go green)

[41730](https://github.com/flutter/flutter/pull/41730) Allow customization of label styles for semantics debugger (a: accessibility, cla: yes, framework, waiting for tree to go green)

[41735](https://github.com/flutter/flutter/pull/41735) handle empty entry in asset list and add more explicit validation (cla: yes, tool)

[41736](https://github.com/flutter/flutter/pull/41736) Disable CPU/GPU measurement on BackdropFilter test (cla: yes, team)

[41744](https://github.com/flutter/flutter/pull/41744) Fix tools test verifyVersion() regex (cla: yes, team)

[41747](https://github.com/flutter/flutter/pull/41747) Add Profile entry to macOS Podfile (cla: yes, tool, waiting for tree to go green)

[41751](https://github.com/flutter/flutter/pull/41751) Add support for downloading x86 JIT release artifact (cla: yes, tool)

[41763](https://github.com/flutter/flutter/pull/41763) No longer rebuild Routes when MediaQuery updates (cla: yes, framework, waiting for tree to go green)

[41780](https://github.com/flutter/flutter/pull/41780) Revert "Dsiable CPU/GPU measurement on BackdropFilter test (#41736)" (cla: yes, team)

[41788](https://github.com/flutter/flutter/pull/41788) Reduce log verbosity by removing individual used files (cla: yes, tool)

[41791](https://github.com/flutter/flutter/pull/41791) Refactor: Make MouseTracker test concise with some utility functions (cla: yes, framework, waiting for tree to go green)

[41794](https://github.com/flutter/flutter/pull/41794) Updated the docstring for SystemNavigator.pop. (cla: yes, framework)

[41795](https://github.com/flutter/flutter/pull/41795) Reland "Dsiable CPU/GPU measurement on BackdropFilter test (#41736)" (cla: yes, team)

[41799](https://github.com/flutter/flutter/pull/41799) Improved ios 13 scrollbar fidelity (cla: yes, f: cupertino, f: material design, framework)

[41803](https://github.com/flutter/flutter/pull/41803) Fixed media query issues and added test to prevent it from coming back (cla: yes, framework, waiting for tree to go green)

[41806](https://github.com/flutter/flutter/pull/41806) run services tests on the Web (cla: yes, framework, team)

[41814](https://github.com/flutter/flutter/pull/41814) Enables setting of semantics focused and focusable attributes within Focus widgets. (CQ+1, a: accessibility, a: tests, cla: yes, f: material design, framework, team)

[41815](https://github.com/flutter/flutter/pull/41815) [web] Make it clear that lowercase "r" can also perform hot restart (cla: yes, tool, ☸ platform-web)

[41820](https://github.com/flutter/flutter/pull/41820) Added SystemNavigator.pop "animated" argument. (cla: yes, framework)

[41828](https://github.com/flutter/flutter/pull/41828) Set DEFINES_MODULE=YES in plugin templates (cla: yes, t: xcode, team, tool, waiting for tree to go green, ⌘‬ platform-mac, ⌺‬ platform-ios)

[41832](https://github.com/flutter/flutter/pull/41832) Plumb --enable-asserts through to frontend_server invocation in debug… (cla: yes, tool)

[41857](https://github.com/flutter/flutter/pull/41857) Change the dark theme elevation overlay to use the colorScheme.onSurface (cla: yes, f: material design, framework, severe: API break)

[41859](https://github.com/flutter/flutter/pull/41859) CupertinoTheme & CupertinoTextTheme dark mode updates (a: tests, cla: yes, f: cupertino, f: material design, framework, severe: API break, will affect goldens)

[41862](https://github.com/flutter/flutter/pull/41862) Make output directory a build input (cla: yes, tool)

[41864](https://github.com/flutter/flutter/pull/41864) Update BottomAppBar to use elevation overlays when in a dark theme (cla: yes, f: material design, framework)

[41879](https://github.com/flutter/flutter/pull/41879) Make MouseTracker.sendMouseNotifications private (cla: yes, framework)

[41880](https://github.com/flutter/flutter/pull/41880) Clean up test infrastructure (cla: yes, team, tool)

[41882](https://github.com/flutter/flutter/pull/41882) Increase template Swift version from 4 to 5 (cla: yes, d: examples, team, tool, ⌘‬ platform-mac, ⌺‬ platform-ios)

[41885](https://github.com/flutter/flutter/pull/41885) Include embedding transitive dependencies in plugins (cla: yes, tool, waiting for tree to go green)

[41889](https://github.com/flutter/flutter/pull/41889) Clean up ProjectFileInvalidator.findInvalidated a bit (cla: yes, tool)

[41892](https://github.com/flutter/flutter/pull/41892) Fix CupertinoActivityIndicator radius (cla: yes, f: cupertino, framework)

[41906](https://github.com/flutter/flutter/pull/41906) Ensure plugin registrants are generated in build_web (cla: yes, tool, ☸ platform-web)

[41922](https://github.com/flutter/flutter/pull/41922) Enable more web tests; use blacklist to filter them out (a: tests, cla: yes, framework, team)

[41931](https://github.com/flutter/flutter/pull/41931) Revert "Fix ReorderableListView's use of child keys (#41334)" (cla: yes, f: material design, framework)

[41933](https://github.com/flutter/flutter/pull/41933) upload x64 android host release (cla: yes, tool)

[41935](https://github.com/flutter/flutter/pull/41935) [Android 10] Activity zoom transition (cla: yes, f: material design, framework, waiting for tree to go green, ▣ platform-android)

[41936](https://github.com/flutter/flutter/pull/41936) Updates packages, including package:multicast_dns. (cla: yes, team, tool)

[41942](https://github.com/flutter/flutter/pull/41942) Use `mergeResourcesProvider` instead of deprecated `mergeResources` (cla: yes, tool, waiting for tree to go green)

[41945](https://github.com/flutter/flutter/pull/41945) Revert ActivateAction PR (cla: yes, f: material design, framework)

[41946](https://github.com/flutter/flutter/pull/41946) Do not validate the Android SDK when building an appbundle (cla: yes, tool, waiting for tree to go green)

[41952](https://github.com/flutter/flutter/pull/41952) Send pubspec.yaml back in time to fix flakiness (cla: yes, tool)

[41960](https://github.com/flutter/flutter/pull/41960) Revert "replace package:vm_service_client with package:vm_service in the devicelab project" (cla: yes, team, tool)

[41972](https://github.com/flutter/flutter/pull/41972) Add enableFeedback param to MaterialButton, RawMaterialButton and IconButton (cla: yes, f: material design, framework)

[41989](https://github.com/flutter/flutter/pull/41989) Flutter doctor should require java 1.8+ (cla: yes, tool, waiting for tree to go green)

[41996](https://github.com/flutter/flutter/pull/41996) [web] Always send the route name even if it's null (cla: yes, f: routes, framework, ☸ platform-web)

[42006](https://github.com/flutter/flutter/pull/42006) Typos & Style clean up (cla: yes, framework, team, waiting for tree to go green)

[42008](https://github.com/flutter/flutter/pull/42008) Restructure ProjectFileInvalidator.findInvalidated a bit (cla: yes, tool)

[42015](https://github.com/flutter/flutter/pull/42015) Fix local test failures in flutter_tools (cla: yes, tool, waiting for tree to go green)

[42016](https://github.com/flutter/flutter/pull/42016) [flutter_tool] Re-work analytics events to use labels and values (cla: yes, tool)

[42022](https://github.com/flutter/flutter/pull/42022) Fix smoke test (cla: yes)

[42025](https://github.com/flutter/flutter/pull/42025) Localization refresh (a: internationalization, cla: yes, f: cupertino, f: material design, framework)

[42026](https://github.com/flutter/flutter/pull/42026) Stop leaking iproxy processes (cla: yes, tool)

[42028](https://github.com/flutter/flutter/pull/42028) Make `ProjectFileInvalidator.findInvalidated` able to use the async `FileStat.stat` (cla: yes, tool)

[42029](https://github.com/flutter/flutter/pull/42029) Always embed iOS Flutter.framework build mode version from Xcode configuration (cla: yes, d: examples, t: xcode, team, team: gallery, tool, ⌺‬ platform-ios)

[42030](https://github.com/flutter/flutter/pull/42030) Revert "AOT support for Linux Desktop I: switch Linux builds to assemble" (cla: yes, tool)

[42031](https://github.com/flutter/flutter/pull/42031) Rewrite MouseTracker's tracking and notifying algorithm (a: desktop, cla: yes, framework)

[42032](https://github.com/flutter/flutter/pull/42032) Update CupertinoActivityIndicator colors and gradient (cla: yes, f: cupertino, framework, will affect goldens)

[42033](https://github.com/flutter/flutter/pull/42033) Reprise: Dropdown Menu layout respects menu items intrinsic sizes (cla: yes, f: material design, framework)

[42035](https://github.com/flutter/flutter/pull/42035) trying to diagnose failure in CI (cla: yes, tool)

[42036](https://github.com/flutter/flutter/pull/42036) trying to diagnose failure in CI, mark II (cla: yes, tool)

[42037](https://github.com/flutter/flutter/pull/42037) Diagnose failure in CI, Mark III (cla: yes, tool)

[42038](https://github.com/flutter/flutter/pull/42038) Reland "AOT support for Linux Desktop I: switch Linux builds to assemble" (cla: yes, tool)

[42063](https://github.com/flutter/flutter/pull/42063) More consistent temp directory naming (a: tests, cla: yes, tool)

[42064](https://github.com/flutter/flutter/pull/42064) Refactor sdk_validation_test (cla: yes, tool, waiting for tree to go green)

[42076](https://github.com/flutter/flutter/pull/42076) create gesture recognizers on attach and dispose on detach to avoid leaks (a: quality, cla: yes, f: gestures, framework, waiting for tree to go green)

[42091](https://github.com/flutter/flutter/pull/42091) Skip sdk_validation_test again (cla: yes, tool)

[42118](https://github.com/flutter/flutter/pull/42118) Apply mocks to test command (cla: yes, tool)

[42136](https://github.com/flutter/flutter/pull/42136) Update dartdoc to 0.28.7 (cla: yes, team)

[42144](https://github.com/flutter/flutter/pull/42144)  Don't eagerly call runMain when --start-paused is provided to web application (cla: yes, tool)

[42162](https://github.com/flutter/flutter/pull/42162) Expose wait conditions in the public flutter_driver API (a: tests, cla: yes, framework)

[42187](https://github.com/flutter/flutter/pull/42187) Be more verbose when pub fails (cla: yes, tool)

[42189](https://github.com/flutter/flutter/pull/42189) Fix regression with ModalBottomSheets not responding to changes in theme (cla: yes, f: material design, framework)

[42203](https://github.com/flutter/flutter/pull/42203) Shard web tests; enable semantics tests on the Web (CQ+1, cla: yes, team)

[42204](https://github.com/flutter/flutter/pull/42204) Add use_modular_headers! to default Podfile (cla: yes, d: examples, t: xcode, team, team: gallery, tool, ⌺‬ platform-ios)

[42209](https://github.com/flutter/flutter/pull/42209) Add error logging to flutter generate (cla: yes, tool)

[42235](https://github.com/flutter/flutter/pull/42235) Reading deviceId for RawKeyEventDataAndroid event (a: desktop, cla: yes, framework)

[42236](https://github.com/flutter/flutter/pull/42236) [Gallery] Add Material Study app Rally as an example app (cla: yes, d: examples, f: material design, team, team: gallery, waiting for tree to go green)

[42243](https://github.com/flutter/flutter/pull/42243) Improve trailing whitespace message (cla: yes, team, tool, waiting for tree to go green)

[42250](https://github.com/flutter/flutter/pull/42250) SliverAppBar - Configurable overscroll stretch with callback feature & FlexibleSpaceBar support (cla: yes, f: material design, f: scrolling, framework, severe: new feature, waiting for tree to go green)

[42252](https://github.com/flutter/flutter/pull/42252) catch argument error from Make (cla: yes, tool)

[42253](https://github.com/flutter/flutter/pull/42253) Change modal barrier to dismissing on tap up (cla: yes, framework)

[42254](https://github.com/flutter/flutter/pull/42254) Update minimum version to Xcode 10.2 (cla: yes, tool)

[42257](https://github.com/flutter/flutter/pull/42257) Make Pub an interface in the flutter tool (cla: yes, tool)

[42260](https://github.com/flutter/flutter/pull/42260) Small cleanup of web code (cla: yes, tool)

[42267](https://github.com/flutter/flutter/pull/42267) Improve documentation around animations. (cla: yes, framework, waiting for tree to go green)

[42276](https://github.com/flutter/flutter/pull/42276) Revert removal of linux from unpack command. (cla: yes, tool)

[42278](https://github.com/flutter/flutter/pull/42278) Re-land keyboard traversal PRs (cla: yes, f: cupertino, f: material design, framework, team)

[42289](https://github.com/flutter/flutter/pull/42289) Ensure precache web works on dev branch (cla: yes, tool)

[42306](https://github.com/flutter/flutter/pull/42306) Ensure that flutter assets are copied in the AAR (cla: yes, team, tool, waiting for tree to go green)

[42342](https://github.com/flutter/flutter/pull/42342) Fix DropdownButton crash when hint and selectedItemBuilder are simultaneously defined (cla: yes, f: material design, framework, severe: crash)

[42344](https://github.com/flutter/flutter/pull/42344) Add onVisible callback to snackbar. (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)

[42352](https://github.com/flutter/flutter/pull/42352) Add android.permission.WAKE_LOCK permission to abstract_method_smoke_test (cla: yes, team)

[42353](https://github.com/flutter/flutter/pull/42353) Add --cache-sksl flag to drive and run (cla: yes, tool)

[42354](https://github.com/flutter/flutter/pull/42354) Pass -Ddart.developer.causal_async_stacks=true to frontend_server invocations. (cla: yes, tool)

[42360](https://github.com/flutter/flutter/pull/42360) Add smoke test for the new Android embedding (cla: yes, team, tool, waiting for tree to go green)

[42364](https://github.com/flutter/flutter/pull/42364) Wrap dwds in async guard, only catch known error types (cla: yes, tool)

[42365](https://github.com/flutter/flutter/pull/42365) Add font fallback clarification docs (cla: yes, d: api docs, framework)

[42366](https://github.com/flutter/flutter/pull/42366) TextStyle.fontFamily should override fontFamily parameter in ThemeData (cla: yes, f: material design, framework)

[42368](https://github.com/flutter/flutter/pull/42368) Update android semantics test to match existing engine behavior. (a: accessibility, cla: yes, team)

[42369](https://github.com/flutter/flutter/pull/42369) Always fake ProcessManager when you fake Filesystem in tests (cla: yes, tool)

[42373](https://github.com/flutter/flutter/pull/42373) Switch build commands to use process utils (cla: yes, tool)

[42376](https://github.com/flutter/flutter/pull/42376) Add option to precache unsigned mac binaries. (cla: yes, tool)

[42378](https://github.com/flutter/flutter/pull/42378) remove println from flutter.gradle (cla: yes, tool)

[42379](https://github.com/flutter/flutter/pull/42379) Partial deflaking of abstract_method_smoke_test (a: tests, cla: yes, team, waiting for tree to go green)

[42401](https://github.com/flutter/flutter/pull/42401) Add support for Android x86_64 ABI to Flutter (cla: yes, tool)

[42404](https://github.com/flutter/flutter/pull/42404) Add isDismissible configuration for showModalBottomSheet (cla: yes, f: material design, framework)

[42441](https://github.com/flutter/flutter/pull/42441) Add transitive dependencies back (cla: yes, tool, waiting for tree to go green)

[42445](https://github.com/flutter/flutter/pull/42445) Fix typo in docs: EdgeInserts->EdgeInsets (a: text input, cla: yes, d: api docs, f: material design, framework)

[42449](https://github.com/flutter/flutter/pull/42449) Increase TextField's minimum height from 40 to 48 (cla: yes, f: material design, framework, severe: API break, will affect goldens)

[42454](https://github.com/flutter/flutter/pull/42454) Fix abstract_method_smoke_test flakiness (a: tests, cla: yes, team, waiting for tree to go green)

[42456](https://github.com/flutter/flutter/pull/42456) Revert removing DropdownMenuItem hint/disabledHint wrapper (cla: yes, f: material design, framework)

[42462](https://github.com/flutter/flutter/pull/42462) Update docker_builder dependencies (cla: yes)

[42464](https://github.com/flutter/flutter/pull/42464) Wait for isolate start before proceeding with expression evaluation tests (cla: yes, tool)

[42470](https://github.com/flutter/flutter/pull/42470) No multiline password fields (cla: yes, f: cupertino, f: material design, framework, severe: API break)

[42471](https://github.com/flutter/flutter/pull/42471) Pass build mode-specific bytecode generation options to frontend_server. (cla: yes, tool)

[42475](https://github.com/flutter/flutter/pull/42475) Fix semantics testing now that dropdown can take a11y focus again. (a: accessibility, cla: yes, team)

[42476](https://github.com/flutter/flutter/pull/42476) Refactor BuildMode into class, add jit_release configuration (cla: yes, tool)

[42478](https://github.com/flutter/flutter/pull/42478) Revert "Rewrite MouseTracker's tracking and notifying algorithm" (cla: yes, framework)

[42479](https://github.com/flutter/flutter/pull/42479) Make DropdownButton's disabledHint and hint behavior consistent (cla: yes, f: material design, framework, severe: API break)

[42482](https://github.com/flutter/flutter/pull/42482) Only dismiss dropdowns if the orientation changes, not the size. (cla: yes, f: material design, framework)

[42484](https://github.com/flutter/flutter/pull/42484) Gradient transform (cla: yes, framework, will affect goldens)

[42485](https://github.com/flutter/flutter/pull/42485) Re-landing SliverAnimatedList (a: animation, cla: yes, f: scrolling, framework, severe: new feature, waiting for tree to go green)

[42486](https://github.com/flutter/flutter/pull/42486) Redo: Rewrite MouseTracker's tracking and notifying algorithm (cla: yes, framework)

[42487](https://github.com/flutter/flutter/pull/42487) refactor depfile usage and update linux rule (cla: yes, tool)

[42491](https://github.com/flutter/flutter/pull/42491) Extra defensive programming for pub modification time assert (cla: yes, tool, waiting for tree to go green)

[42496](https://github.com/flutter/flutter/pull/42496) Roll dart package dependencies (cla: yes, team)

[42508](https://github.com/flutter/flutter/pull/42508) Add Android x64 profile artifacts (cla: yes, tool)

[42526](https://github.com/flutter/flutter/pull/42526) Improve routers performance (cla: yes, framework)

[42530](https://github.com/flutter/flutter/pull/42530) add WAKE_LOCK back to abstract method test (cla: yes, team)

[42531](https://github.com/flutter/flutter/pull/42531) Print correct hostname when web server is launched (cla: yes, tool, ☸ platform-web)

[42533](https://github.com/flutter/flutter/pull/42533) Disable arrow key focus navigation for text fields (cla: yes, f: cupertino, f: material design, framework)

[42538](https://github.com/flutter/flutter/pull/42538) [flutter_tool] Improve yaml font map validation (cla: yes, tool)

[42546](https://github.com/flutter/flutter/pull/42546) Fix and enable painting tests on the Web (cla: yes, framework, team, tool)

[42548](https://github.com/flutter/flutter/pull/42548) Print message and log event when app isn't using AndroidX (cla: yes, tool)

[42550](https://github.com/flutter/flutter/pull/42550) Add enableSuggestions flag to TextField and TextFormField (a: text input, cla: yes, f: cupertino, f: material design, framework)

[42551](https://github.com/flutter/flutter/pull/42551) Revert "Roll engine eed171ff3538..00f330068d3e (5 commits) (#42541)" (cla: yes, engine)

[42554](https://github.com/flutter/flutter/pull/42554) Fix route focusing and autofocus when reparenting focus nodes. (cla: yes, f: material design, framework)

[42557](https://github.com/flutter/flutter/pull/42557) Skip test (cla: yes, tool)

[42558](https://github.com/flutter/flutter/pull/42558) Use placeholder dimensions that reflect the final text layout (cla: yes, framework)

[42563](https://github.com/flutter/flutter/pull/42563) Adding thumb color customisation functionality to CupertinoSlider (cla: yes, f: cupertino, framework)

[42597](https://github.com/flutter/flutter/pull/42597) Deflake wildcard asset test (cla: yes, tool)

[42602](https://github.com/flutter/flutter/pull/42602) Properly throw FlutterError when route builder returns null on CupertinoPageRoute (cla: yes, f: cupertino, framework)

[42613](https://github.com/flutter/flutter/pull/42613) Fix Tooltip implementation of PopupMenuButton (cla: yes, f: material design, framework, waiting for tree to go green)

[42637](https://github.com/flutter/flutter/pull/42637) Re-enable asserts on Windows integration tests (a: tests, cla: yes, team)

[42640](https://github.com/flutter/flutter/pull/42640) Add more structure to errors (continuation of #34684) (a: tests, cla: yes, f: cupertino, f: material design, framework)

[42655](https://github.com/flutter/flutter/pull/42655) resident_web_runner doesn't close debug connection (cla: yes, tool)

[42656](https://github.com/flutter/flutter/pull/42656) Catch appInstanceId error (cla: yes, tool)

[42668](https://github.com/flutter/flutter/pull/42668) dispose devices on cleanupAtFinish() for run_cold.dart (cla: yes, tool, waiting for tree to go green)

[42676](https://github.com/flutter/flutter/pull/42676) [web] Update web runner message with flutter.dev/web (cla: yes, tool, waiting for tree to go green)

[42683](https://github.com/flutter/flutter/pull/42683) Optimize focus operations by caching descendants and ancestors. (cla: yes, f: material design, framework)

[42684](https://github.com/flutter/flutter/pull/42684) Remove isNewAndroidEmbeddingEnabled flag when reading an existing pro… (cla: yes, tool)

[42686](https://github.com/flutter/flutter/pull/42686) Update dartdoc to 0.28.8 (cla: yes, team)

[42687](https://github.com/flutter/flutter/pull/42687) Revert "Fix and enable painting tests on the Web (#42546)" (cla: yes, framework, team, tool)

[42688](https://github.com/flutter/flutter/pull/42688) Source Code Comment Typo Fixes (cla: yes, framework)

[42689](https://github.com/flutter/flutter/pull/42689) Reland: fix and enable painting web tests (cla: yes, framework, team, tool)

[42691](https://github.com/flutter/flutter/pull/42691) fixing todo comments in flutter tests to include url link. (cla: yes, tool, waiting for tree to go green)

[42698](https://github.com/flutter/flutter/pull/42698) Ensure we stop the status when browser connection is complete (cla: yes, tool)

[42699](https://github.com/flutter/flutter/pull/42699) unpin test and update packages (cla: yes, team, tool)

[42701](https://github.com/flutter/flutter/pull/42701) serve correct content type from debug server (cla: yes, tool, ☸ platform-web)

[42708](https://github.com/flutter/flutter/pull/42708) Test the Android embedding v2 (cla: yes, team, tool)

[42709](https://github.com/flutter/flutter/pull/42709) Test Gradle on Windows (cla: yes, team)

[42764](https://github.com/flutter/flutter/pull/42764) Revert "Expose API for resizing image caches" (cla: yes, framework)

[42771](https://github.com/flutter/flutter/pull/42771) don't precompile dependencies when building the flutter tool (cla: yes, waiting for tree to go green)

[42773](https://github.com/flutter/flutter/pull/42773) enable rendering tests on the Web (cla: yes, framework, team)

[42775](https://github.com/flutter/flutter/pull/42775) CupertinoSlidingSegmentedControl (cla: yes, f: cupertino, framework)

[42777](https://github.com/flutter/flutter/pull/42777) Fix memory leak in TransitionRoute (cla: yes, framework, waiting for tree to go green)

[42779](https://github.com/flutter/flutter/pull/42779) Fix chip ripple bug — No longer two ripples (cla: yes, f: material design, framework)

[42785](https://github.com/flutter/flutter/pull/42785) Reland "Expose API for resizing image caches #41415" (cla: yes, framework)

[42790](https://github.com/flutter/flutter/pull/42790) This disables the up/down arrow focus navigation in text fields in a different way. (cla: yes, f: cupertino, f: material design, framework)

[42791](https://github.com/flutter/flutter/pull/42791) fix type error in manifest asset bundle (cla: yes, tool)

[42807](https://github.com/flutter/flutter/pull/42807) Add most of the widget tests; add more web test shards (cla: yes, framework, team)

[42808](https://github.com/flutter/flutter/pull/42808) Run flutter pub get before pod install in platform_view_ios__start_up test (a: tests, cla: yes, team)

[42811](https://github.com/flutter/flutter/pull/42811) Add a Focus node to the DropdownButton, and adds an activation action for it. (cla: yes, f: material design, framework)

[42813](https://github.com/flutter/flutter/pull/42813) Fix NPE in Chrome Device (cla: yes, tool)

[42842](https://github.com/flutter/flutter/pull/42842) Add "navigator" option to "showDialog" and "showGeneralDialog" (cla: yes, f: routes, framework, severe: new feature, waiting for tree to go green)

[42854](https://github.com/flutter/flutter/pull/42854) Revert "Default colorScheme data in ButtonThemeData (fix for #38655)" (cla: yes, f: material design, framework, waiting for tree to go green)

[42857](https://github.com/flutter/flutter/pull/42857) Fix progress indicators for release/profile builds of web. (cla: yes, tool)

[42861](https://github.com/flutter/flutter/pull/42861) Add repeatCount to RawKeyEventDataAndroid (a: desktop, cla: yes, framework, waiting for tree to go green, ▣ platform-android)

[42863](https://github.com/flutter/flutter/pull/42863) V1.9.1 hotfixes (cla: yes, engine, team, tool)

[42867](https://github.com/flutter/flutter/pull/42867) Use Cirrus credits for billing. (cla: yes, team, team: infra)

[42872](https://github.com/flutter/flutter/pull/42872) Remove use_modular_headers from Podfiles using libraries (cla: yes, d: examples, team, team: gallery, tool)

[42873](https://github.com/flutter/flutter/pull/42873) Update README to include non-mobile targets (cla: yes, team)

[42879](https://github.com/flutter/flutter/pull/42879) Re-implement hardware keyboard text selection. (cla: yes, framework)

[42882](https://github.com/flutter/flutter/pull/42882) Reenable the dartdocs benchmark tracking (cla: yes, team)

[42922](https://github.com/flutter/flutter/pull/42922) Fix typo (cla: no, f: material design, framework)

[42924](https://github.com/flutter/flutter/pull/42924) CupertinoDialogAction is missing super call (cla: yes, f: cupertino, framework, waiting for tree to go green)

[42931](https://github.com/flutter/flutter/pull/42931) separation of hot restart and hotter restart (cla: yes, tool)

[42936](https://github.com/flutter/flutter/pull/42936) Support AppBars with jumbo titles (cla: yes, f: material design, framework)

[42951](https://github.com/flutter/flutter/pull/42951) implement debugTogglePlatform for the web (cla: yes, tool)

[42953](https://github.com/flutter/flutter/pull/42953) Soften layer breakage (cla: yes, framework)

[42958](https://github.com/flutter/flutter/pull/42958) Turn off bitcode for integration tests and add-to-app templates (a: existing-apps, cla: yes, team, tool, ⌺‬ platform-ios)

[42962](https://github.com/flutter/flutter/pull/42962) Remove linux-x64 unpack logic (cla: yes, tool)

[42964](https://github.com/flutter/flutter/pull/42964) Use PRODUCT_BUNDLE_IDENTIFIER from buildSettings to find correct bundle id on iOS when using flavors (cla: yes, t: xcode, tool, waiting for tree to go green)

[42966](https://github.com/flutter/flutter/pull/42966) expand scope of rethrown gradle errors (cla: yes, tool)

[42967](https://github.com/flutter/flutter/pull/42967) Pad CupertinoAlertDialog with MediaQuery viewInsets (cla: yes, f: cupertino, framework)

[42968](https://github.com/flutter/flutter/pull/42968) Quick fix on material dialog docs (cla: yes, f: material design, framework)

[42970](https://github.com/flutter/flutter/pull/42970) Rename headless server to web server (cla: yes, tool)

[42971](https://github.com/flutter/flutter/pull/42971) re-enable some linux devicelab tests (cla: yes, team)

[42972](https://github.com/flutter/flutter/pull/42972) Do not produce an error when encountering a new type in a service response. (cla: yes, tool)

[42977](https://github.com/flutter/flutter/pull/42977) switch dart2js build to depfile, remove Source.function (cla: yes, tool)

[42981](https://github.com/flutter/flutter/pull/42981) Remove GeneratedPluginRegistrant.java (cla: yes, team)

[42982](https://github.com/flutter/flutter/pull/42982) Revert "Clean up test infrastructure" (cla: yes, team, tool)

[43006](https://github.com/flutter/flutter/pull/43006) Set default borderRadius to zero in ClipRRect (as documented) (cla: yes, framework, waiting for tree to go green)

[43013](https://github.com/flutter/flutter/pull/43013) Wire up canRequestFocus and skipTraversal in FocusScopeNode (cla: yes, d: examples, framework, team, team: gallery)

[43016](https://github.com/flutter/flutter/pull/43016) ensure we can disable --track-widget-creation in debug mode (cla: yes, tool)

[43019](https://github.com/flutter/flutter/pull/43019) Build only required web tests; fix and enable most of material tests (cla: yes, f: material design, framework, team, tool)

[43022](https://github.com/flutter/flutter/pull/43022) Enable dump-skp-on-shader-compilation in drive (cla: yes, tool, waiting for tree to go green)

[43026](https://github.com/flutter/flutter/pull/43026) temporarily disable system_debug_ios devicelab test (cla: yes, team)

[43030](https://github.com/flutter/flutter/pull/43030) Clean up test infrastructure (cla: yes, team, tool)

[43042](https://github.com/flutter/flutter/pull/43042) add samsungexynos7570  to list of known physical devices (cla: yes, tool)

[43080](https://github.com/flutter/flutter/pull/43080) Indent Kotlin code with 4 spaces (cla: yes, team, tool, waiting for tree to go green)

[43149](https://github.com/flutter/flutter/pull/43149) Disable CI tests that LUCI is failing (1) (cla: yes, team)

[43150](https://github.com/flutter/flutter/pull/43150) Disable CI tests that LUCI is failing (2) (cla: yes, team)

[43173](https://github.com/flutter/flutter/pull/43173) Fix typo in README.md (cla: yes, team)

[43180](https://github.com/flutter/flutter/pull/43180) Adding missing break in plugin validation check (cla: yes, tool)

[43183](https://github.com/flutter/flutter/pull/43183) Silence presubmit codecov (cla: yes, team)

[43187](https://github.com/flutter/flutter/pull/43187) Ensure `android.enableR8` is appended to a new line (cla: yes, tool)

[43188](https://github.com/flutter/flutter/pull/43188) [cleanup] Remove unused files (cla: yes, team)

[43193](https://github.com/flutter/flutter/pull/43193) ButtonBar aligns in column when it overflows horizontally (a: accessibility, cla: yes, f: material design, framework)

[43200](https://github.com/flutter/flutter/pull/43200) remove period from URL so that it opens correctly in vscode (cla: yes, tool)

[43207](https://github.com/flutter/flutter/pull/43207) comment out fastlane test archiving (cla: yes, team)

[43213](https://github.com/flutter/flutter/pull/43213) Add focus nodes, hover, and shortcuts to switches, checkboxes, and radio buttons. (cla: yes, f: material design, framework)

[43214](https://github.com/flutter/flutter/pull/43214) For --profile builds on web, still use -O4 but unminified names. (cla: yes, tool)

[43217](https://github.com/flutter/flutter/pull/43217) [flutter_tool] Update analytics policy, send event on disable (cla: yes, tool)

[43219](https://github.com/flutter/flutter/pull/43219) Add devfs for incremental compiler JavaScript bundle (cla: yes, tool, waiting for tree to go green)

[43221](https://github.com/flutter/flutter/pull/43221) Migrate examples to the Android embedding v2 (cla: yes, d: examples, team, team: gallery)

[43225](https://github.com/flutter/flutter/pull/43225) Catch io.StdinException from failure to set stdin echo/line mode (cla: yes, tool)

[43226](https://github.com/flutter/flutter/pull/43226) Implement AlertDialog title/content overflow scroll (a: accessibility, cla: yes, f: material design, framework)

[43227](https://github.com/flutter/flutter/pull/43227) Revert "Skia Gold Support for Local & PreSubmit Testing in package:flutter" (cla: yes)

[43235](https://github.com/flutter/flutter/pull/43235) Revert "Extra defensive programming for pub modification time assert" (cla: yes)

[43238](https://github.com/flutter/flutter/pull/43238) Fixing focus traversal when the node options are empty (a: desktop, cla: yes, framework)

[43245](https://github.com/flutter/flutter/pull/43245) Add `smallestScreenSize` to `android:configChanges` in the Android manifest template (cla: yes, tool, waiting for tree to go green)

[43246](https://github.com/flutter/flutter/pull/43246) Tap.dart: Fixes the spacing to the right side of reason (cla: yes, f: gestures, framework)

[43281](https://github.com/flutter/flutter/pull/43281) Add compiler configuration to support dartdevc target (cla: yes, tool)

[43282](https://github.com/flutter/flutter/pull/43282) implement build aot with assemble for Android target platforms (cla: yes, tool)

[43286](https://github.com/flutter/flutter/pull/43286) FadeInImage cacheWidth and cacheHeight support (a: images, cla: yes, framework, severe: new feature)

[43288](https://github.com/flutter/flutter/pull/43288) V1.9.1 hotfix (cla: yes, engine, framework, team, tool)

[43292](https://github.com/flutter/flutter/pull/43292) initial bootstrap script for incremental compiler support (cla: yes, tool, waiting for tree to go green)

[43296](https://github.com/flutter/flutter/pull/43296) Skip failing test to green build (cla: yes, framework)

[43315](https://github.com/flutter/flutter/pull/43315) Extra defensive programming for pub modification time assert (cla: yes, tool)

[43362](https://github.com/flutter/flutter/pull/43362) Allow rebuilding of docker image, re-enable deploy gallery macos (cla: yes, team, team: infra)

[43366](https://github.com/flutter/flutter/pull/43366) run flutter update-packages --force-upgrade (cla: yes, team)

[43367](https://github.com/flutter/flutter/pull/43367) Revert "Add focus nodes, hover, and shortcuts to switches, checkboxes, and radio buttons." (cla: yes, f: material design, framework)

[43371](https://github.com/flutter/flutter/pull/43371) Re-land Local & Pre-Submit Support for Skia Gold (a: images, a: quality, a: tests, cla: yes, framework, team, waiting for tree to go green, will affect goldens)

[43379](https://github.com/flutter/flutter/pull/43379) ENABLE_ANDROID_EMBEDDING_V2 isn't a general thing. (cla: yes, team)

[43381](https://github.com/flutter/flutter/pull/43381) [flutter_tool] Use engine flutter_runner prebuilts (cla: yes, tool, waiting for tree to go green)

[43384](https://github.com/flutter/flutter/pull/43384) Re-Land: Add focus nodes, hover, and shortcuts to switches, checkboxes, and radio buttons. (a: accessibility, cla: yes, f: material design, framework, team)

[43388](https://github.com/flutter/flutter/pull/43388) Depend on specific package versions in module_test (cla: yes, team, waiting for tree to go green)

[43390](https://github.com/flutter/flutter/pull/43390) catch ChromeDebugException from dwds (cla: yes, tool)

[43391](https://github.com/flutter/flutter/pull/43391) Revert "[Chip] Make sure InkResponse is in the foreground on delete f… (cla: yes, f: material design, framework)

[43401](https://github.com/flutter/flutter/pull/43401) Handle permission error during flutter clean (cla: yes, tool, waiting for tree to go green)

[43402](https://github.com/flutter/flutter/pull/43402) Handle format error from vswhere (cla: yes, tool)

[43403](https://github.com/flutter/flutter/pull/43403) Handle version and option skew errors (cla: yes, tool)

[43422](https://github.com/flutter/flutter/pull/43422) *trivial* fixed AboutListTile having an empty icon placeholder when no icon set. (cla: yes, f: material design, framework, waiting for tree to go green)

[43436](https://github.com/flutter/flutter/pull/43436) Handle onError callback with optional argument (cla: yes, tool, waiting for tree to go green)

[43438](https://github.com/flutter/flutter/pull/43438) Revert "Enable dump-skp-on-shader-compilation in drive" (cla: yes)

[43448](https://github.com/flutter/flutter/pull/43448) Don't html-escape in the plugin registrant templates. (cla: yes, tool, waiting for tree to go green)

[43455](https://github.com/flutter/flutter/pull/43455) Reland "Enable dump-skp-on-shader-compilation in drive (#43022)" (cla: yes, tool)

[43458](https://github.com/flutter/flutter/pull/43458) Support platform-specific test lines (cla: yes, team)

[43461](https://github.com/flutter/flutter/pull/43461) Fixed usage of optional types in swift integration test. (cla: yes, team)

[43466](https://github.com/flutter/flutter/pull/43466) Adding handling of TextInputClient.onConnectionClosed messages handli… (a: tests, a: text input, cla: yes, framework, severe: API break, waiting for tree to go green, ☸ platform-web)

[43467](https://github.com/flutter/flutter/pull/43467) Fixed bug where we could accidently call a callback twice. (cla: yes, framework)

[43471](https://github.com/flutter/flutter/pull/43471) flip track widget creation on by default (cla: yes, tool, waiting for tree to go green)

[43479](https://github.com/flutter/flutter/pull/43479) Refactor gradle.dart (cla: yes, tool)

[43511](https://github.com/flutter/flutter/pull/43511) Improve DropdownButton assert message (cla: yes, f: material design, framework)

[43526](https://github.com/flutter/flutter/pull/43526) Change PopupMenuButton.icon type to Widget (cla: yes, f: material design, framework)

[43528](https://github.com/flutter/flutter/pull/43528) Adjust and refactor all `MaterialButton` tests into its respective file (cla: yes, f: material design, framework, waiting for tree to go green)

[43529](https://github.com/flutter/flutter/pull/43529) Cupertino web tests (cla: yes, f: material design, framework, team)

[43544](https://github.com/flutter/flutter/pull/43544) Catch AppConnectionException (cla: yes, tool)

[43546](https://github.com/flutter/flutter/pull/43546) Alias upgrade-packages => update-packages (cla: yes, tool)

[43553](https://github.com/flutter/flutter/pull/43553) Pass environment variables through to xcodebuild (cla: yes, t: xcode, team, team: infra, tool, ⌺‬ platform-ios)

[43557](https://github.com/flutter/flutter/pull/43557) Revert "Allow rebuilding of docker image, re-enable deploy gallery macos" (cla: yes, team)

[43573](https://github.com/flutter/flutter/pull/43573) Catch MissingPortFile from web tooling. (cla: yes, tool)

[43576](https://github.com/flutter/flutter/pull/43576) Enable usage of experimental incremental compiler for web (cla: yes, tool)

[43577](https://github.com/flutter/flutter/pull/43577) set trace to true for desktop builds (cla: yes, tool)

[43586](https://github.com/flutter/flutter/pull/43586) Ensure Chrome is closed on tab close (cla: yes, tool)

[43598](https://github.com/flutter/flutter/pull/43598) Catch failed daemon startup error (cla: yes, tool)

[43599](https://github.com/flutter/flutter/pull/43599) catch failure to parse FLUTTER_STORAGE_BASE_URL (cla: yes, tool)

[43602](https://github.com/flutter/flutter/pull/43602) Don't indefinitely persist file hashes, handle more error conditions (cla: yes, tool)

[43611](https://github.com/flutter/flutter/pull/43611) Revert "Migrate examples to the Android embedding v2" (cla: yes, d: examples, team, team: gallery)

[43636](https://github.com/flutter/flutter/pull/43636) Enable tests that failed due to CupertinoDynamicColor (cla: yes, team)

[43643](https://github.com/flutter/flutter/pull/43643) Reland: Migrate examples new embedding (cla: yes, d: examples, team, team: gallery)

[43647](https://github.com/flutter/flutter/pull/43647) Revert "Re-Land: Add focus nodes, hover, and shortcuts to switches, checkboxes, and radio buttons. (#43384)" (a: accessibility, cla: yes, f: material design, framework, team)

[43654](https://github.com/flutter/flutter/pull/43654) Re-land fix docker build and deploy_gallery-macos (cla: yes, team)

[43657](https://github.com/flutter/flutter/pull/43657) Re-Land: Add focus nodes, hover, and shortcuts to switches, checkboxes, and radio buttons. (a: accessibility, cla: yes, f: material design, framework, team)

[43658](https://github.com/flutter/flutter/pull/43658) Added note about design doc template. (cla: yes)

[43662](https://github.com/flutter/flutter/pull/43662) Enable heroes_test.dart on the web matrix (cla: yes, framework, team, work in progress; do not review)

[43667](https://github.com/flutter/flutter/pull/43667) Added a null check for ranges in the sourceReport map. (cla: yes, tool)

[43669](https://github.com/flutter/flutter/pull/43669) Don't read AndroidManifest.xml if it doesn't exit (cla: yes, tool, waiting for tree to go green)

[43674](https://github.com/flutter/flutter/pull/43674) Add missing import (cla: yes)

[43675](https://github.com/flutter/flutter/pull/43675) Fix device lab tests (cla: yes)

[43676](https://github.com/flutter/flutter/pull/43676) Allow multiple TimingsCallbacks (cla: yes, framework, severe: performance)

[43677](https://github.com/flutter/flutter/pull/43677) add libzip cache artifact (cla: yes)

[43684](https://github.com/flutter/flutter/pull/43684) [flutter_runner] Use sky_engine from the topaz tree (cla: yes)

[43685](https://github.com/flutter/flutter/pull/43685) Remove Poller class from flutter_tools (cla: yes)

[43689](https://github.com/flutter/flutter/pull/43689) Revert: Migrate examples new embedding (cla: yes)

[43691](https://github.com/flutter/flutter/pull/43691) Re-enable chrome dev mode tests (cla: yes)

[43722](https://github.com/flutter/flutter/pull/43722) Make selected item get focus when dropdown is opened (cla: yes, f: material design, framework)

[43725](https://github.com/flutter/flutter/pull/43725) Add reloadMethod RPC (cla: yes, tool)

[43736](https://github.com/flutter/flutter/pull/43736) CupertinoPicker minor documentation update (cla: yes, d: api docs, f: cupertino, framework)

[43738](https://github.com/flutter/flutter/pull/43738) Separate DropdownButton and DropdownButtonFormField tests (cla: yes, f: material design, framework)

[43739](https://github.com/flutter/flutter/pull/43739) enable avoid_web_libraries_in_flutter (cla: yes, framework)

[43742](https://github.com/flutter/flutter/pull/43742) Adjust and refactor all `FlatButton` tests into its respective file (cla: yes, f: material design, framework, waiting for tree to go green)

[43745](https://github.com/flutter/flutter/pull/43745) Run update packages --force-upgrade (cla: yes, team)

[43748](https://github.com/flutter/flutter/pull/43748) Gold Performance improvements (a: tests, cla: yes, framework, team)

[43753](https://github.com/flutter/flutter/pull/43753) pass --no-gen-bytecode to aot kernel compiler invocations (cla: yes, tool)

[43756](https://github.com/flutter/flutter/pull/43756) Mark routes as opaque when added without animation (a: animation, cla: yes, f: inspector, f: routes, framework)

[43758](https://github.com/flutter/flutter/pull/43758) Split desktop config fallback variable by platform (a: desktop, cla: yes, tool)

[43759](https://github.com/flutter/flutter/pull/43759) [flutter_tool] Teach the tool about local engine Fuchsia artifacts (cla: yes, tool, waiting for tree to go green)

[43761](https://github.com/flutter/flutter/pull/43761) Make test case use mockStopwatch (cla: yes, tool)

[43764](https://github.com/flutter/flutter/pull/43764) Update create.dart (cla: yes, tool, waiting for tree to go green)

[43767](https://github.com/flutter/flutter/pull/43767) check if libimobiledevice executables exist (cla: yes, tool)

[43800](https://github.com/flutter/flutter/pull/43800) de-flake logger test (cla: yes, tool)

[43827](https://github.com/flutter/flutter/pull/43827) Revert "Added a null check for ranges in the sourceReport map." (cla: yes, tool)

[43841](https://github.com/flutter/flutter/pull/43841) Update cupertino demos in gallery (cla: yes, d: examples, f: cupertino, framework, team, team: gallery)

[43843](https://github.com/flutter/flutter/pull/43843) Remove print and fix code formatting (cla: yes, f: material design, framework)

[43848](https://github.com/flutter/flutter/pull/43848) Don't allow Disabled InkWells to be focusable (cla: yes, f: material design, framework)

[43859](https://github.com/flutter/flutter/pull/43859) Add convenience accessor for primaryFocus (cla: yes, f: material design, framework, team)

[43862](https://github.com/flutter/flutter/pull/43862) Ensure target platform is passed is always passed (cla: yes, tool)

[43865](https://github.com/flutter/flutter/pull/43865) Reorder show and setEditingState calls to the IMM (cla: yes, framework)

[43868](https://github.com/flutter/flutter/pull/43868) Reland: Migrate examples to the Android embedding v2 (cla: yes, d: examples, team, team: gallery, waiting for tree to go green)

[43870](https://github.com/flutter/flutter/pull/43870) check for instanceof instead of runtimeType (cla: yes, tool)

[43876](https://github.com/flutter/flutter/pull/43876) Refactor flutter.gradle to use assemble directly (cla: yes, tool)

[43885](https://github.com/flutter/flutter/pull/43885) Revert "Reland: Migrate examples to the Android embedding v2" (cla: yes, d: examples, team, team: gallery)

[43907](https://github.com/flutter/flutter/pull/43907) Serve correct mime type on release dev server (cla: yes, tool)

[43908](https://github.com/flutter/flutter/pull/43908) remove no-gen-bytecode flag (cla: yes, tool)

[43913](https://github.com/flutter/flutter/pull/43913) Revert "[flutter_runner] Use sky_engine from the topaz tree (#43684)" (a: tests, cla: yes, framework)

[43915](https://github.com/flutter/flutter/pull/43915) Observe logging from VM service on iOS 13 (a: debugging, cla: yes, tool, ⌺‬ platform-ios)

[43918](https://github.com/flutter/flutter/pull/43918) CupertinoContextMenu (iOS 13) (cla: yes, f: cupertino, framework)

[43927](https://github.com/flutter/flutter/pull/43927) Fix stdout test (cla: yes, team)

[43932](https://github.com/flutter/flutter/pull/43932) Update CupertinoSlidingSegmentedControl control/feedback mechanism (cla: yes, f: cupertino, framework)

[43934](https://github.com/flutter/flutter/pull/43934) L10n Simplification (a: internationalization, cla: yes, framework, team, waiting for tree to go green)

[43939](https://github.com/flutter/flutter/pull/43939) Revert "Revert "Reland: Migrate examples to the Android embedding v2"" (cla: yes, d: examples, team, team: gallery)

[43941](https://github.com/flutter/flutter/pull/43941) Tweaks after the gradle.dart refactor (cla: yes, tool)

[43945](https://github.com/flutter/flutter/pull/43945) Remove Source.behavior, fix bug in depfile invalidation (cla: yes, tool)

[43946](https://github.com/flutter/flutter/pull/43946) Adding subtitle to ExpansionTile (cla: yes, f: material design, framework)

[43948](https://github.com/flutter/flutter/pull/43948) Synchronize modifier keys in RawKeyboard.keysPressed with modifier flags on events. (a: desktop, a: tests, cla: yes, framework)

[43950](https://github.com/flutter/flutter/pull/43950) remove listDartSources (cla: yes, tool)

[43952](https://github.com/flutter/flutter/pull/43952) Require awaiting testbed.run (cla: yes, tool)

[43955](https://github.com/flutter/flutter/pull/43955) Make more spinner tests not flaky (cla: yes, tool)

[43959](https://github.com/flutter/flutter/pull/43959) Respond to TextInputClient.reattach messages. (cla: yes, framework, waiting for tree to go green)

[43981](https://github.com/flutter/flutter/pull/43981) Fix typo in app_bar.dart (cla: yes, f: material design, framework, waiting for tree to go green)

[43990](https://github.com/flutter/flutter/pull/43990) Upgrade dartdoc to 0.29.0 (cla: yes, team)

[43994](https://github.com/flutter/flutter/pull/43994) flutter build aar should also build plugins as AARs (cla: yes, team, tool)

[43997](https://github.com/flutter/flutter/pull/43997) Revert: Migrate examples to the Android embedding v2 (cla: yes, d: examples, team, team: gallery)

[44003](https://github.com/flutter/flutter/pull/44003) Revert "Implement AlertDialog title/content overflow scroll #43226" (cla: yes, f: material design, framework)

[44010](https://github.com/flutter/flutter/pull/44010) dev/ci/README.md update (cla: yes, team, waiting for tree to go green)

[44011](https://github.com/flutter/flutter/pull/44011) Move the plugin registrant to io.flutter.plugins and add the @Keep an… (cla: yes, tool, waiting for tree to go green)

[44017](https://github.com/flutter/flutter/pull/44017) Asset server fix for sourcemaps (cla: yes, tool)

[44019](https://github.com/flutter/flutter/pull/44019) Ignore generated .project files for VSCode Java Plugin (cla: yes, team)

[44026](https://github.com/flutter/flutter/pull/44026) Exit tool if a plugin only supports the embedding v2 but the app doesn't (cla: yes, tool, waiting for tree to go green)

[44027](https://github.com/flutter/flutter/pull/44027) Allow specifying device-vmservice-port and host-vmservice-port (cla: yes, tool)

[44028](https://github.com/flutter/flutter/pull/44028) Support --no-resident on the web (cla: yes, tool)

[44029](https://github.com/flutter/flutter/pull/44029) Use alphabetic baselines for layout of InputDecorator (cla: yes, f: material design, framework)

[44031](https://github.com/flutter/flutter/pull/44031) Added tests for the new Android heading semantic flag to android_semantics_testing (a: accessibility, cla: yes, team)

[44032](https://github.com/flutter/flutter/pull/44032) Copy chrome preferences to seeded data dir (cla: yes, tool)

[44043](https://github.com/flutter/flutter/pull/44043) Add Android embedding version analytics (cla: yes, tool, waiting for tree to go green)

[44052](https://github.com/flutter/flutter/pull/44052) Remove flutter_tool services code (cla: yes, tool)

[44065](https://github.com/flutter/flutter/pull/44065) Build ios framework (cla: yes, team, tool)

[44068](https://github.com/flutter/flutter/pull/44068) Fix typo in tabs.dart (cla: yes, f: material design, framework, waiting for tree to go green)

[44076](https://github.com/flutter/flutter/pull/44076) Typo on comments (cla: yes, f: material design, framework, waiting for tree to go green)

[44083](https://github.com/flutter/flutter/pull/44083) Add --dart-define option (cla: yes, tool, waiting for tree to go green)

[44119](https://github.com/flutter/flutter/pull/44119) [flutter_tool] --flutter_runner will download the debug symbols (cla: yes, tool)

[44127](https://github.com/flutter/flutter/pull/44127) build aar prints how to consume the artifacts (cla: yes, tool, waiting for tree to go green)

[44130](https://github.com/flutter/flutter/pull/44130) Add command key bindings to macOS text editing and fix selection. (a: desktop, cla: yes, customer: octopod, framework, ⌘‬ platform-mac)

[44139](https://github.com/flutter/flutter/pull/44139) Reland: Migrate examples to the Android embedding v2 (cla: yes, d: examples, team, team: gallery, waiting for tree to go green)

[44146](https://github.com/flutter/flutter/pull/44146) Remove flutter.yaml migration code (cla: yes, tool)

[44147](https://github.com/flutter/flutter/pull/44147) Remove plugin imports from module_test_ios (a: tests, cla: yes, team)

[44149](https://github.com/flutter/flutter/pull/44149) Apply minimumDate & maximumDate constraints in CupertinoDatePicker date mode  (cla: yes, f: cupertino, framework)

[44150](https://github.com/flutter/flutter/pull/44150) Manually roll engine to unred the tree (cla: yes, engine)

[44151](https://github.com/flutter/flutter/pull/44151) Add version to fuchsia_remote_debug_protocol (cla: yes, team, waiting for tree to go green)

[44160](https://github.com/flutter/flutter/pull/44160) Wire selectedItemBuilder through DropdownButtonFormField (cla: yes, f: material design, framework)

[44166](https://github.com/flutter/flutter/pull/44166) Add v1 plugin register function into v2 plugin template (cla: yes, team, tool)

[44169](https://github.com/flutter/flutter/pull/44169) Adjust and refactor all `RaisedButton` tests into its respective file (cla: yes, f: material design, framework)

[44189](https://github.com/flutter/flutter/pull/44189) make some BuildContext methods generics (cla: yes, d: examples, framework, severe: API break, team, team: gallery)

[44194](https://github.com/flutter/flutter/pull/44194) Revert "[Gallery] Add Material Study app Rally as an example app" (cla: yes, d: examples, f: material design, team, team: gallery)

[44200](https://github.com/flutter/flutter/pull/44200) Make ProjectFileInvalidator injectable (cla: yes, tool)

[44201](https://github.com/flutter/flutter/pull/44201) Temporarily bring the embedding dependencies in the Flutter gallery (cla: yes, d: examples, team, team: gallery)

[44210](https://github.com/flutter/flutter/pull/44210) Revert "Exit tool if a plugin supports the embedding v2 but the app d… (cla: yes, tool)

[44214](https://github.com/flutter/flutter/pull/44214) Fix v1 embedding support heuristic for plugins (cla: yes, tool, waiting for tree to go green)

[44217](https://github.com/flutter/flutter/pull/44217) Moving pointer event sanitizing to engine. (cla: yes, customer: crowd, customer: dream (g3), customer: headline, framework)

[44221](https://github.com/flutter/flutter/pull/44221) Use platform appropriate filepaths (cla: yes, tool)

[44223](https://github.com/flutter/flutter/pull/44223) Update Stocks example using i18n tool  (cla: yes, d: examples, team)

[44227](https://github.com/flutter/flutter/pull/44227) [flutter_tool] Screenshot command must require device only for _kDeviceType (cla: yes, tool)

[44233](https://github.com/flutter/flutter/pull/44233) Remove yield from inherited model (cla: yes, framework)

[44243](https://github.com/flutter/flutter/pull/44243) Build local maven repo when using local engine (cla: yes, tool)

[44263](https://github.com/flutter/flutter/pull/44263) Allow web server device to use extension if started with --start-paused (cla: yes, team, tool)

[44268](https://github.com/flutter/flutter/pull/44268) Switch from using app.progress to app.webLaunchUrl for passing web launch urls (cla: yes, tool)

[44277](https://github.com/flutter/flutter/pull/44277) Revert "Roll engine 6c763bb551cb..9726b4cb99d3 (4 commits)" (cla: yes, engine)

[44278](https://github.com/flutter/flutter/pull/44278) Do not pass obsolete --strong option to front-end server (cla: yes, tool)

[44279](https://github.com/flutter/flutter/pull/44279) link platform should be true for profile (cla: yes, tool)

[44281](https://github.com/flutter/flutter/pull/44281) revert add new enum change (cla: yes, framework, team, tool)

[44289](https://github.com/flutter/flutter/pull/44289) SliverOpacity (cla: yes, f: scrolling, framework, severe: new feature, waiting for tree to go green)

[44292](https://github.com/flutter/flutter/pull/44292) Manual roll for add new enum roll back (cla: yes, engine)

[44296](https://github.com/flutter/flutter/pull/44296) ModalBarrier and Drawer barrier prevents mouse events (a: desktop, cla: yes, f: gestures, f: material design, framework)

[44299](https://github.com/flutter/flutter/pull/44299) Re-enable Pesto in profile/release mode (cla: yes, d: examples, team, team: gallery)

[44301](https://github.com/flutter/flutter/pull/44301) Don't print how to consume AARs when building plugins as AARs (cla: yes, tool)

[44302](https://github.com/flutter/flutter/pull/44302) Don't add x86 nor x64 when building a local engine in debug mode (cla: yes, tool, waiting for tree to go green)

[44307](https://github.com/flutter/flutter/pull/44307) Fixing local golden output flake (a: tests, cla: yes, framework, team: flakes)

[44308](https://github.com/flutter/flutter/pull/44308) Add more flutter build ios-framework tests before the impending jonahpocalypse (cla: yes, team, waiting for tree to go green)

[44312](https://github.com/flutter/flutter/pull/44312) Demonstrate that artifact invalidation works (cla: yes, team)

[44313](https://github.com/flutter/flutter/pull/44313) l10n tool improvements, stocks app refresh (a: internationalization, cla: yes, d: examples, team)

[44317](https://github.com/flutter/flutter/pull/44317) CupertinoDynamicColor improvements (a: tests, cla: yes, d: examples, f: cupertino, framework, team, team: gallery)

[44318](https://github.com/flutter/flutter/pull/44318) Remove TODO that's done (cla: yes, documentation, framework)

[44324](https://github.com/flutter/flutter/pull/44324) Add swift_versions to plugin template podspec, include default CocoaPod version (cla: yes, team, tool, ⌘‬ platform-mac, ⌺‬ platform-ios)

[44328](https://github.com/flutter/flutter/pull/44328) Adjust and refactor all `OutlineButton` tests into its respective file (cla: yes, f: material design, framework, waiting for tree to go green)

[44344](https://github.com/flutter/flutter/pull/44344) Update packages to get latest dwds in flutter_tools (cla: yes, team)

[44351](https://github.com/flutter/flutter/pull/44351) [Material] Update the Slider and RangeSlider to the latest Material spec (cla: yes, d: examples, f: material design, framework, team, team: gallery)

[44360](https://github.com/flutter/flutter/pull/44360) [flutter_tool] Stream artifact downloads to files (cla: yes, tool)

[44365](https://github.com/flutter/flutter/pull/44365) Turn off docs upload temporarily (cla: yes, team)

[44369](https://github.com/flutter/flutter/pull/44369) Flip enable-android-embedding-v2 flag (cla: yes, severe: API break, team, tool, waiting for tree to go green)

[44371](https://github.com/flutter/flutter/pull/44371) Revert "Turn off docs upload temporarily (#44365)" (cla: yes, team)

[44391](https://github.com/flutter/flutter/pull/44391) Segmented control quick double tap fix (cla: yes, f: cupertino, framework)

[44396](https://github.com/flutter/flutter/pull/44396) Revert "Enable usage of experimental incremental compiler for web" (cla: yes, team, tool)

[44400](https://github.com/flutter/flutter/pull/44400) Reland: enable usage of experimental web compiler (cla: yes, team, tool)

[44408](https://github.com/flutter/flutter/pull/44408) Remove no longer needed clean up code (cla: yes, framework, waiting for tree to go green)

[44410](https://github.com/flutter/flutter/pull/44410) Add macOS fn key support. (cla: yes, framework, team)

[44413](https://github.com/flutter/flutter/pull/44413) Turn off docs upload temporarily (cla: yes, team)

[44421](https://github.com/flutter/flutter/pull/44421) switch web test to macOS (cla: yes, team)

[44422](https://github.com/flutter/flutter/pull/44422) Remove TextRange, export it from dart:ui (cla: yes, framework)

[44447](https://github.com/flutter/flutter/pull/44447) implicit-casts:false on flutter_tools/lib (cla: yes, tool)

[44451](https://github.com/flutter/flutter/pull/44451) Use raw string for l10n description  (a: internationalization, cla: yes, team, waiting for tree to go green)

[44454](https://github.com/flutter/flutter/pull/44454) Re-enable docs uploading (cla: yes, team)

[44457](https://github.com/flutter/flutter/pull/44457) [flutter_tool] Update Fuchsia SDK (cla: yes, tool)

[44463](https://github.com/flutter/flutter/pull/44463) Revert "Demonstrate that artifact invalidation works" (cla: yes, team)

[44466](https://github.com/flutter/flutter/pull/44466) Update dartdoc to 0.29.1 (cla: yes, team)

[44467](https://github.com/flutter/flutter/pull/44467) Make sure all our .dart files have license headers (a: accessibility, cla: yes, d: examples, f: cupertino, f: material design, team, team: gallery)

[44468](https://github.com/flutter/flutter/pull/44468) Fix test for null flutter root (cla: yes, tool)

[44469](https://github.com/flutter/flutter/pull/44469) Deprecation cleanup in flutter_tools (cla: yes, tool)

[44473](https://github.com/flutter/flutter/pull/44473) l10n tool improvements, stocks app i18n refresh (a: internationalization, cla: yes, d: examples, team)

[44479](https://github.com/flutter/flutter/pull/44479) Adding flutter_goldens tests to misc shards (a: tests, cla: yes, framework, team)

[44481](https://github.com/flutter/flutter/pull/44481) Provide specific field to accept depfiles in target class (cla: yes, tool)

[44487](https://github.com/flutter/flutter/pull/44487) reland add new enum change (#44281) (a: existing-apps, cla: yes, framework, team)

[44488](https://github.com/flutter/flutter/pull/44488) Refactorings to testbed.run and testbed.test (cla: yes, tool)

[44490](https://github.com/flutter/flutter/pull/44490) Fix "node._relayoutBoundary == _relayoutBoundary" crash (cla: yes, framework, waiting for tree to go green)

[44499](https://github.com/flutter/flutter/pull/44499) Show a warning when a module uses a v1 only plugin (cla: yes, tool, waiting for tree to go green)

[44534](https://github.com/flutter/flutter/pull/44534) Improve performance of build APK (~50%)  by running gen_snapshot concurrently (cla: yes, team, tool)

[44551](https://github.com/flutter/flutter/pull/44551) Remove new unused elements (a: accessibility, cla: yes, f: cupertino, framework)

[44574](https://github.com/flutter/flutter/pull/44574) Print a message when modifying settings that you may need to reload IDE/editor (cla: yes, tool)

[44576](https://github.com/flutter/flutter/pull/44576) [ci] Use the latest Cirrus Image for macOS  (cla: yes)

[44584](https://github.com/flutter/flutter/pull/44584) Update meta to 1.1.8 (cla: yes, team)

[44605](https://github.com/flutter/flutter/pull/44605) Changing RenderEditable.textAlign doesn't break hot reload anymore (a: text input, cla: yes, framework, t: hot reload)

[44608](https://github.com/flutter/flutter/pull/44608) Reduce some direct package:archive usage (cla: yes, tool)

[44610](https://github.com/flutter/flutter/pull/44610) Error Message for createState assertion (a: error message, a: quality, cla: yes, framework, severe: crash, waiting for tree to go green)

[44611](https://github.com/flutter/flutter/pull/44611) Convert to TextPosition for getWordBoundary (cla: yes, framework)

[44613](https://github.com/flutter/flutter/pull/44613) Revert engine rolls. (cla: yes, engine)

[44617](https://github.com/flutter/flutter/pull/44617) Make disposing a ScrollPosition with pixels=null legal (cla: yes, framework, waiting for tree to go green)

[44618](https://github.com/flutter/flutter/pull/44618) Update our deprecation style. (a: tests, cla: yes, f: cupertino, f: material design, framework, team, work in progress; do not review)

[44619](https://github.com/flutter/flutter/pull/44619) Update Gold to fallback on skipping comparator when offline (a: annoyance, a: quality, a: tests, cla: yes, framework, team: flakes)

[44620](https://github.com/flutter/flutter/pull/44620) Bump memory requirements for tool_tests-general-linux (cla: yes)

[44622](https://github.com/flutter/flutter/pull/44622) Track and use fallback TextAffinity for null affinity platform TextSelections. (cla: yes, framework)

[44625](https://github.com/flutter/flutter/pull/44625) Release startup lock during long-lived build ios framework (cla: yes, tool)

[44633](https://github.com/flutter/flutter/pull/44633) Turn on bitcode for integration tests and add-to-app templates (a: existing-apps, a: tests, cla: yes, team, tool)

[44637](https://github.com/flutter/flutter/pull/44637) Attach looks at future observatory URIs (cla: yes, tool, waiting for tree to go green)

[44638](https://github.com/flutter/flutter/pull/44638) Add module to create template help text (a: existing-apps, cla: yes, tool)

[44736](https://github.com/flutter/flutter/pull/44736) Check in new diffs to material localizations (a: internationalization, cla: yes, f: material design)

[44743](https://github.com/flutter/flutter/pull/44743) Sort Localization generation output (a: internationalization, cla: yes, f: cupertino, f: material design, team)

[44744](https://github.com/flutter/flutter/pull/44744) Ensure web-server does not force usage of dwds (cla: yes, tool)

[44746](https://github.com/flutter/flutter/pull/44746) Remove chrome device web integration test (cla: yes, team)

[44753](https://github.com/flutter/flutter/pull/44753) Always link desktop platforms (cla: yes, tool)

[44758](https://github.com/flutter/flutter/pull/44758) Canonicalize locale string in `gen_l10n.dart` (a: internationalization, cla: yes, team)

[44761](https://github.com/flutter/flutter/pull/44761) Sort locales and method/properties/getters alphabetically (a: internationalization, cla: yes, d: examples, team)

[44772](https://github.com/flutter/flutter/pull/44772) Test framework for analyze.dart (cla: yes, team, waiting for tree to go green)

[44776](https://github.com/flutter/flutter/pull/44776) More license header fixes (cla: yes, d: examples, team, team: gallery)

[44778](https://github.com/flutter/flutter/pull/44778) Revert "Implement PageView using SliverLayoutBuilder, Deprecate RenderSliverFillViewport (#37024)" (cla: yes, framework)

[44782](https://github.com/flutter/flutter/pull/44782) Updated flutter/examples to further conform to new embedding: removed references to FlutterApplication, deleted all MainActivity's that were not necessary, removed all direct invocations of GeneratedPluginRegistrant. (#22529) (cla: yes, d: examples, team, team: gallery)

[44783](https://github.com/flutter/flutter/pull/44783) Forward ProcessException to error handlers (cla: yes, tool)

[44787](https://github.com/flutter/flutter/pull/44787) Fix snippets to include element ID in the output sample. (cla: yes, f: material design, team)

[44790](https://github.com/flutter/flutter/pull/44790) Roll engine manual 31cd2dfca22a...b358dc58fbce (39 commits) (cla: yes, engine, framework)

[44797](https://github.com/flutter/flutter/pull/44797) Build AAR for all build variants by default (cla: yes, tool)

[44830](https://github.com/flutter/flutter/pull/44830) Update manual_tests to be able to run on macOS/web (a: desktop, cla: yes, f: material design, team)

[44843](https://github.com/flutter/flutter/pull/44843) Revert "Allow specifying device-vmservice-port and host-vmservice-port" (cla: yes, tool)

[44844](https://github.com/flutter/flutter/pull/44844) Properly interpret modifiers on GLFW key events (a: desktop, cla: yes, framework, 🐧 platform-linux)

[44853](https://github.com/flutter/flutter/pull/44853) Reland: Allow specifying device-vmservice-port and host-vmservice-port (cla: yes, tool)

[44867](https://github.com/flutter/flutter/pull/44867) FocusableActionDetector widget (cla: yes, f: material design, framework)

[44868](https://github.com/flutter/flutter/pull/44868) Catch and display version check errors during doctor (a: first hour, cla: yes, tool)

[44870](https://github.com/flutter/flutter/pull/44870) Add -runFirstLaunch hint text (a: first hour, cla: yes, t: xcode, tool)

[44878](https://github.com/flutter/flutter/pull/44878) Fake locale in doctor_test (cla: yes, tool)

[44882](https://github.com/flutter/flutter/pull/44882) Update package test (cla: yes, team)

[44907](https://github.com/flutter/flutter/pull/44907) [Gallery] Reland Add Material Study app Rally as an example app (cla: yes, d: examples, f: material design, team, team: gallery, waiting for tree to go green)

[44920](https://github.com/flutter/flutter/pull/44920) [flutter_tool] Various fixes for 'run' for Fuchsia. (cla: yes, d: examples, team, team: gallery, tool)

[44933](https://github.com/flutter/flutter/pull/44933) [flutter_tool] Don't crash when failing to delete downloaded artifacts (cla: yes, tool)

[44935](https://github.com/flutter/flutter/pull/44935) [flutter_runner] Use sky_engine from the topaz tree (a: tests, cla: yes, framework)

[44947](https://github.com/flutter/flutter/pull/44947) Revert "reland add new enum change (#44281) (#44487)" (cla: yes, framework, team)

[44965](https://github.com/flutter/flutter/pull/44965) Scroll scrollable to keep focused control visible. (a: desktop, cla: yes, f: scrolling, framework)

[44966](https://github.com/flutter/flutter/pull/44966) Don't log stack traces to console on build failures (cla: yes, tool)

[44967](https://github.com/flutter/flutter/pull/44967) Try a mildly prettier FlutterError and make it less drastic in release mode (cla: yes, framework, waiting for tree to go green)

[44996](https://github.com/flutter/flutter/pull/44996) implicit-casts:false in flutter_test (a: tests, cla: yes, framework)

[45000](https://github.com/flutter/flutter/pull/45000) Manual engine roll to b2640d97e7e8034f28b4e7b92c15b0824e433897 (cla: yes, engine, framework)

[45011](https://github.com/flutter/flutter/pull/45011) catch IOSDeviceNotFoundError in IOSDevice.startApp() (cla: yes, tool)

[45012](https://github.com/flutter/flutter/pull/45012) reland add new enum change (cla: yes, framework, team)

[45050](https://github.com/flutter/flutter/pull/45050) Add a perf test for picture raster cache (cla: yes, severe: performance, t: flutter driver, team)

[45080](https://github.com/flutter/flutter/pull/45080) Ignore vscode Java plugin auto-generated files (cla: yes, team)

[45081](https://github.com/flutter/flutter/pull/45081) Remove duplicated expect from text field test (cla: yes, f: material design, framework)

[45083](https://github.com/flutter/flutter/pull/45083) Fix draggable scrollable sheet scroll notification (cla: yes, framework, waiting for tree to go green)

[45115](https://github.com/flutter/flutter/pull/45115) fix ios_add2app_life_cycle license (cla: yes, team)

[45119](https://github.com/flutter/flutter/pull/45119) revert added lifecycle enum (cla: yes, framework, team)

[45124](https://github.com/flutter/flutter/pull/45124) Analyze dartpad (cla: yes, f: cupertino, framework, team)

[45125](https://github.com/flutter/flutter/pull/45125) Gallery Typo Fix (cla: yes, d: examples, team, team: gallery)

[45126](https://github.com/flutter/flutter/pull/45126) Enable iOS platform views for Flutter Gallery (cla: yes, d: examples, team, team: gallery)

[45127](https://github.com/flutter/flutter/pull/45127) SliverIgnorePointer (cla: yes, f: scrolling, framework, severe: new feature, waiting for tree to go green)

[45133](https://github.com/flutter/flutter/pull/45133) reland add lifecycle enum and fix the scheduleforcedframe (cla: yes, framework, team)

[45135](https://github.com/flutter/flutter/pull/45135) Add option to delay rendering the first frame (cla: yes, framework, severe: API break)

[45136](https://github.com/flutter/flutter/pull/45136) Remove FLUTTER_DEVICELAB_XCODE_PROVISIONING_CONFIG code paths (a: tests, cla: yes, team, team: infra)

[45139](https://github.com/flutter/flutter/pull/45139) Update Android CPU device detection (cla: yes, tool)

[45141](https://github.com/flutter/flutter/pull/45141) Revert "[flutter_runner] Use sky_engine from the topaz tree (#44935)" (a: tests, cla: yes, framework)

[45145](https://github.com/flutter/flutter/pull/45145) cache sdkNameAndVersion logic for web devices (cla: yes, tool)

[45151](https://github.com/flutter/flutter/pull/45151) fix type errors (cla: yes, tool)

[45153](https://github.com/flutter/flutter/pull/45153) implicit-casts:false on flutter_tools (cla: yes, tool)

[45168](https://github.com/flutter/flutter/pull/45168) Allow plural localized strings to not specify every case (a: internationalization, cla: yes, team)

[45172](https://github.com/flutter/flutter/pull/45172) Fix device daemon test when desktop or web are enabled (a: tests, cla: yes, tool)

[45178](https://github.com/flutter/flutter/pull/45178) Increase memory from 8->10GB for tool_tests-commands-linux (a: tests, cla: yes)

[45180](https://github.com/flutter/flutter/pull/45180) Add the rally_assets package to Gallery's BUILD.gn (cla: yes, d: examples, team, team: gallery)

[45187](https://github.com/flutter/flutter/pull/45187) [flutter_tool] Builds aot for Fuchsia release and jit product for jit-release. (cla: yes, tool)

[45189](https://github.com/flutter/flutter/pull/45189) Remove chmod to make Flutter framework headers unwritable (cla: yes, tool)

[45192](https://github.com/flutter/flutter/pull/45192) Roll engine to f4fba66c2fad1c1d5705ea0734ee4250211f6757 (cla: yes, engine)

[45200](https://github.com/flutter/flutter/pull/45200) Spell check of Flutter docs (cla: yes, d: api docs, documentation, team)

[45203](https://github.com/flutter/flutter/pull/45203) Roll engine f4fba66c2fad..c812a62b8810 (4 commits) (cla: yes, engine)

[45211](https://github.com/flutter/flutter/pull/45211) Revert "Attach looks at future observatory URIs" (cla: yes, tool)

[45212](https://github.com/flutter/flutter/pull/45212) Upgrade gauge for debugging (cla: yes, team, team: infra)

[45215](https://github.com/flutter/flutter/pull/45215) Remove  URLs in deprecation annotation (cla: yes, team)

[45217](https://github.com/flutter/flutter/pull/45217) Roll engine c812a62b8810..2d35b4ec1f04 (4 commits) (cla: yes, engine)

[45228](https://github.com/flutter/flutter/pull/45228) Reland: Attach looks at future observatory URIs (cla: yes, tool)

[45236](https://github.com/flutter/flutter/pull/45236) Improve time to development by initializing frontend_server concurrently with platform build (cla: yes, tool)

[45237](https://github.com/flutter/flutter/pull/45237) Revert "Attach looks at future observatory URIs" (cla: yes, tool)

[45239](https://github.com/flutter/flutter/pull/45239) implicit-casts:false in fuchsia_remote_debug_protocol (cla: yes, tool, waiting for tree to go green)

[45240](https://github.com/flutter/flutter/pull/45240) implicit-casts:false in flutter_web_plugins (cla: yes)

[45249](https://github.com/flutter/flutter/pull/45249) implicit-casts:false in flutter_goldens and flutter_goldens_client (cla: yes)

[45259](https://github.com/flutter/flutter/pull/45259) Add minimum macOS application to the Flutter Gallery (cla: yes, d: examples, team, team: gallery)

[45260](https://github.com/flutter/flutter/pull/45260) Revert "reland add lifecycle enum and fix the scheduleforcedframe" (cla: yes, framework, team)

[45264](https://github.com/flutter/flutter/pull/45264) Add macOS hot reload test (cla: yes, team)

[45268](https://github.com/flutter/flutter/pull/45268) Revert "[Material] Update the Slider and RangeSlider to the latest Material spec" (cla: yes, d: examples, f: material design, framework, team, team: gallery)

[45279](https://github.com/flutter/flutter/pull/45279) Revert "[Gallery] Add Material Study app Rally as an example app" (cla: yes, d: examples, team, team: gallery)

[45282](https://github.com/flutter/flutter/pull/45282) [fuchsia] Reland use sky_engine from Topaz (a: tests, cla: yes, framework)

[45286](https://github.com/flutter/flutter/pull/45286) Fix experimental incremental web compiler for Windows (cla: yes, tool)

[45291](https://github.com/flutter/flutter/pull/45291) Revert "Reduce some direct package:archive usage" (cla: yes, tool)

[45303](https://github.com/flutter/flutter/pull/45303) Allow unknown fields in pubspec plugin section (cla: yes, tool)

[45307](https://github.com/flutter/flutter/pull/45307) Reland: Attach looks at future observatory URIs (cla: yes, tool, waiting for tree to go green)

[45317](https://github.com/flutter/flutter/pull/45317) de-null dartDefines in daemon mode (cla: yes, tool, waiting for tree to go green)

[45319](https://github.com/flutter/flutter/pull/45319) catch parse error from corrupt config (cla: yes, tool)

[45320](https://github.com/flutter/flutter/pull/45320) Remove Flags (cla: yes, tool)

[45349](https://github.com/flutter/flutter/pull/45349) Revert "[flutter_tool] Builds aot for Fuchsia release and jit product for jit-release." (cla: yes, tool)

[45350](https://github.com/flutter/flutter/pull/45350) Reland: [flutter_tool] Fuchsia AOT builds (cla: yes, tool)

[45353](https://github.com/flutter/flutter/pull/45353) Revert "Add the rally_assets package to Gallery's BUILD.gn (#45180)" (cla: yes, d: examples, team, team: gallery)

[45362](https://github.com/flutter/flutter/pull/45362) Add widget of the week video embeddings (cla: yes, f: material design, framework)

[45364](https://github.com/flutter/flutter/pull/45364) Allow a no-op default_package key for a plugin platform (cla: yes, tool)

[45379](https://github.com/flutter/flutter/pull/45379) Add `.flutter-plugins-dependencies` to the project, which contains the app's plugin dependency graph (cla: yes, team, tool, waiting for tree to go green)

[45385](https://github.com/flutter/flutter/pull/45385) Revert "Add option to delay rendering the first frame" (cla: yes, framework)

[45392](https://github.com/flutter/flutter/pull/45392) [ci] more resources to Windows tasks (cla: yes)

[45407](https://github.com/flutter/flutter/pull/45407) Don't crash if the tool cannot delete asset directory (cla: yes, tool)

[45412](https://github.com/flutter/flutter/pull/45412) Revert "catch parse error from corrupt config" (cla: yes, tool)

[45414](https://github.com/flutter/flutter/pull/45414) Reland handle corrupt config file (cla: yes, tool)

[45422](https://github.com/flutter/flutter/pull/45422) Revert "Improve time to development by initializing frontend_server concurrently with platform build" (cla: yes, tool)

[45430](https://github.com/flutter/flutter/pull/45430) Drops detached message until we can handle it properly (cla: yes, framework)

[45442](https://github.com/flutter/flutter/pull/45442) Engine roll to include SkRRect fix (cla: yes, engine)

[45455](https://github.com/flutter/flutter/pull/45455) Disable tests that fail on non-master branches (cla: yes, team)

## PRs closed in this release of flutter/engine

From Sun Aug 19 17:37:00 2019 -0700 to Mon Nov 25 12:05:00 2019 -0800


[8507](https://github.com/flutter/engine/pull/8507) Add texture support for macOS shell. (affects: desktop, cla: yes, platform-macos, waiting for customer response)

[9386](https://github.com/flutter/engine/pull/9386) [glfw] Send the glfw key data to the framework. (affects: desktop, cla: yes, glfw)

[9498](https://github.com/flutter/engine/pull/9498) Notify framework to clear input connection when app is backgrounded (#35054). (cla: yes)

[9806](https://github.com/flutter/engine/pull/9806) Reuse texture cache in ios_external_texture_gl. (cla: yes)

[9864](https://github.com/flutter/engine/pull/9864) Add capability to add AppDelegate as UNUserNotificationCenterDelegate (cla: yes)

[9888](https://github.com/flutter/engine/pull/9888) Provide dart vm initalize isolate callback so that children isolates belong to parent's isolate group. (cla: yes)

[10154](https://github.com/flutter/engine/pull/10154) Started taking advantage of Skia's new copyTableData to avoid superfluous copies. (cla: yes)

[10182](https://github.com/flutter/engine/pull/10182) Made flutter startup faster by allowing initialization to be parallelized (cla: yes)

[10326](https://github.com/flutter/engine/pull/10326) copypixelbuffer causes crash (cla: yes)

[10670](https://github.com/flutter/engine/pull/10670) Expose LineMetrics in dart:ui (affects: text input, brand new feature, cla: yes)

[10814](https://github.com/flutter/engine/pull/10814) Reland remove kernel sdk script (cla: yes, platform-web)

[10945](https://github.com/flutter/engine/pull/10945) De-dup FILE output for each license (cla: yes)

[11031](https://github.com/flutter/engine/pull/11031) sync web engine; run web engine tests (cla: yes)

[11035](https://github.com/flutter/engine/pull/11035) Roll angle licenses (cla: yes)

[11041](https://github.com/flutter/engine/pull/11041) Add a BroadcastStream to FrameTiming (cla: yes)

[11049](https://github.com/flutter/engine/pull/11049) Release _ongoingTouches when FlutterViewController dealloc (cla: yes)

[11062](https://github.com/flutter/engine/pull/11062) Provide a placeholder queue ID for the custom embedder task runner. (cla: yes)

[11063](https://github.com/flutter/engine/pull/11063) Update ExternalViewEmbedder class comment. (cla: yes)

[11064](https://github.com/flutter/engine/pull/11064) Reland "Track detailed LibTxt metrics with LineMetrics(#10127)" (cla: yes)

[11070](https://github.com/flutter/engine/pull/11070) Platform View implemenation for Metal (cla: yes)

[11210](https://github.com/flutter/engine/pull/11210) Add Chrome to Dockerfile (cla: yes)

[11222](https://github.com/flutter/engine/pull/11222) [b/139487101] Dont present session twice (cla: yes)

[11224](https://github.com/flutter/engine/pull/11224) Update metal layer drawable size on relayout. (cla: yes)

[11226](https://github.com/flutter/engine/pull/11226) Make firebase testlab always pass (cla: yes)

[11228](https://github.com/flutter/engine/pull/11228) Re-enable firebase test and don't use google login (cla: yes)

[11230](https://github.com/flutter/engine/pull/11230) Update tflite_native and language_model revisions to match the Dart SDK (cla: yes)

[11239](https://github.com/flutter/engine/pull/11239) Remove dart entrypoint Intent parameter from FlutterActivity. (#38713) (cla: yes)

[11255](https://github.com/flutter/engine/pull/11255) Migrate Embedder API documentation to Doxygen format. (cla: yes)

[11256](https://github.com/flutter/engine/pull/11256) Upgrade compiler to Clang 10. (cla: yes)

[11265](https://github.com/flutter/engine/pull/11265) make it possible to disable debug symbols stripping (cla: yes)

[11270](https://github.com/flutter/engine/pull/11270) Reset NSNetService delegate to nil，when stop service. (cla: yes)

[11283](https://github.com/flutter/engine/pull/11283) Fix objects equal to null not being detected as null (cla: yes)

[11300](https://github.com/flutter/engine/pull/11300) Do not Prepare raster_cache if view_embedder is present (cla: yes)

[11305](https://github.com/flutter/engine/pull/11305) Fix a segfault in EmbedderTest.CanSpecifyCustomTaskRunner (cla: yes)

[11306](https://github.com/flutter/engine/pull/11306) Set FlutterMacOS podspec min version to 10.11 (cla: yes, waiting for tree to go green)

[11309](https://github.com/flutter/engine/pull/11309) Fix change_install_name.py to be GN-friendly (cla: yes, waiting for tree to go green)

[11310](https://github.com/flutter/engine/pull/11310) When using a custom compositor, ensure the root canvas is flushed. (cla: yes)

[11315](https://github.com/flutter/engine/pull/11315) Do not add null task observers (cla: yes)

[11316](https://github.com/flutter/engine/pull/11316) [lsc] Remove fuchsia.net.SocketProvider (cla: yes)

[11319](https://github.com/flutter/engine/pull/11319) Add tests for platform views (cla: yes)

[11322](https://github.com/flutter/engine/pull/11322) [fuchsia] Wire up OpacityLayer to Scenic (cla: yes)

[11324](https://github.com/flutter/engine/pull/11324) Clean up Windows and Linux build output (cla: yes)

[11327](https://github.com/flutter/engine/pull/11327) [Windows] Update API for alternative Windows shell platform implementation (cla: yes)

[11330](https://github.com/flutter/engine/pull/11330) Remove engine hash from the output artifact (cla: yes)

[11337](https://github.com/flutter/engine/pull/11337) Reference the Flutter framework instead of the dylib in iOS tests. (cla: yes)

[11345](https://github.com/flutter/engine/pull/11345) [Android] Write MINIMAL_SDK required to use PlatformViews to exception message (cla: yes)

[11350](https://github.com/flutter/engine/pull/11350) Firebase test for Platform Views on iOS (cla: yes)

[11355](https://github.com/flutter/engine/pull/11355) update sim script (cla: yes)

[11356](https://github.com/flutter/engine/pull/11356) Remove engine hash from pom filename (cla: yes)

[11357](https://github.com/flutter/engine/pull/11357) Rename first frame method and notify FlutterActivity when full drawn (#38714 #36796). (cla: yes)

[11359](https://github.com/flutter/engine/pull/11359) Dry up fixture comparison in embedder unit-tests. (cla: yes)

[11360](https://github.com/flutter/engine/pull/11360) build legacy web SDK (cla: yes)

[11361](https://github.com/flutter/engine/pull/11361) Include Java stack trace in method channel invocations (cla: yes)

[11367](https://github.com/flutter/engine/pull/11367) Make message loop task entry containers thread safe (cla: yes)

[11368](https://github.com/flutter/engine/pull/11368) Switch to an incremental runloop for GLFW (cla: yes)

[11374](https://github.com/flutter/engine/pull/11374) Update scenarios readme (cla: yes)

[11380](https://github.com/flutter/engine/pull/11380) Use App.framework in macOS FlutterDartProject (cla: yes)

[11382](https://github.com/flutter/engine/pull/11382) Trivial: remove empty line in the pom file (cla: yes)

[11384](https://github.com/flutter/engine/pull/11384) Account for root surface transformation on the surfaces managed by the external view embedder. (cla: yes)

[11386](https://github.com/flutter/engine/pull/11386) Allow non-resizable windows in GLFW embedding (cla: yes)

[11388](https://github.com/flutter/engine/pull/11388) Allow overriding the GLFW pixel ratio (cla: yes)

[11390](https://github.com/flutter/engine/pull/11390) preventDefault on touchend to show iOS keyboard (cla: yes)

[11392](https://github.com/flutter/engine/pull/11392) Wire up software rendering in the test compositor. (cla: yes)

[11394](https://github.com/flutter/engine/pull/11394) Avoid root surface acquisition during custom composition with software renderer. (cla: yes)

[11395](https://github.com/flutter/engine/pull/11395) Remove deprecated ThreadTest::GetThreadTaskRunner and use the newer CreateNewThread API. (cla: yes)

[11413](https://github.com/flutter/engine/pull/11413) Ios simulator unittests seem to not consider the full compilation unit (cla: yes)

[11416](https://github.com/flutter/engine/pull/11416) Shrink cirrus docker image: reduce RUN count, apt-get clean (cla: yes)

[11419](https://github.com/flutter/engine/pull/11419) Support non-60 refresh rate on PerformanceOverlay (cla: yes)

[11420](https://github.com/flutter/engine/pull/11420) Fix touchpad scrolling on Chromebook  (cla: yes)

[11421](https://github.com/flutter/engine/pull/11421) sync Flutter Web engine to the latest (cla: yes)

[11423](https://github.com/flutter/engine/pull/11423) Add tracing of the number of frames in flight in the pipeline. (cla: yes)

[11427](https://github.com/flutter/engine/pull/11427) Skip empty platform view overlays. (cla: yes)

[11436](https://github.com/flutter/engine/pull/11436) update method for skia (cla: yes)

[11441](https://github.com/flutter/engine/pull/11441) Android 10+ View.setSystemGestureExclusionRects (cla: yes, platform-android)

[11449](https://github.com/flutter/engine/pull/11449) Roll buildroot and update gn script for bitcode_marker (cla: yes)

[11451](https://github.com/flutter/engine/pull/11451) Android 10+ View.getSystemGestureExclusionRects (cla: yes, platform-android)

[11456](https://github.com/flutter/engine/pull/11456) Update the ui.LineMetrics.height metric to be more useful to external users (cla: yes)

[11466](https://github.com/flutter/engine/pull/11466) Assert that the JUnit tests are running on Java 8 (cla: yes, waiting for tree to go green)

[11473](https://github.com/flutter/engine/pull/11473) Add missing newline at EOF (cla: yes)

[11475](https://github.com/flutter/engine/pull/11475) buildfix: support build windows release/profile mode(#32746) (cla: yes)

[11483](https://github.com/flutter/engine/pull/11483) Roll buildroot to 58d85da77cf1d5c668d185570fa8ed3d2e1a1ab5 (cla: yes)

[11489](https://github.com/flutter/engine/pull/11489) Ensure trailing newline before EOF in C++ sources (cla: yes)

[11492](https://github.com/flutter/engine/pull/11492) Roll third_party/benchmark to a779ffce872b4c811beef482e18bd0b63626aa42 (cla: yes)

[11514](https://github.com/flutter/engine/pull/11514) Update label of Fuchsia FIDL targets. (cla: yes)

[11520](https://github.com/flutter/engine/pull/11520) Bitcode only for release (cla: yes)

[11522](https://github.com/flutter/engine/pull/11522) Revert "Reuse texture cache in ios_external_texture_gl. (#9806)" (cla: yes)

[11524](https://github.com/flutter/engine/pull/11524) Reuse texture cache in ios_external_texture_gl (cla: yes)

[11528](https://github.com/flutter/engine/pull/11528) Strip bitcode from gen_snapshot (cla: yes)

[11530](https://github.com/flutter/engine/pull/11530) Optionally strip bitcode when creating ios framework (cla: yes)

[11537](https://github.com/flutter/engine/pull/11537) Add check to enable metal for import (cla: yes)

[11550](https://github.com/flutter/engine/pull/11550) Make Skia cache size channel respond with a value (cla: yes)

[11554](https://github.com/flutter/engine/pull/11554) make engine, ui, and sdk rewriter inputs of dill construction (cla: yes)

[11576](https://github.com/flutter/engine/pull/11576) Minor tweaks to the Doxygen theme. (cla: yes)

[11622](https://github.com/flutter/engine/pull/11622) Include <string> from font_asset_provider (cla: yes)

[11635](https://github.com/flutter/engine/pull/11635) [flutter_runner] Port Expose ViewBound Wireframe Functionality (cla: yes)

[11636](https://github.com/flutter/engine/pull/11636) [fidl][flutter_runner] Port Migrate to new fit::optional compatible APIs (cla: yes)

[11638](https://github.com/flutter/engine/pull/11638) Update CanvasSpy::onDrawEdgeAAQuad for Skia API change (cla: yes)

[11640](https://github.com/flutter/engine/pull/11640) remove Web test blacklist; all tests should pass now (cla: yes)

[11649](https://github.com/flutter/engine/pull/11649) [flutter] Port: Run handle wait completers on the microtask queue (cla: yes)

[11652](https://github.com/flutter/engine/pull/11652) iOS platform view mutation XCUITests (cla: yes)

[11654](https://github.com/flutter/engine/pull/11654) Append newlines to EOF of all translation units. (cla: yes)

[11655](https://github.com/flutter/engine/pull/11655) Don't crash while loading improperly formatted fonts on Safari (cla: yes)

[11669](https://github.com/flutter/engine/pull/11669) Add style guide and formatting information (cla: yes)

[11717](https://github.com/flutter/engine/pull/11717) Return a JSON value for the Skia channel (cla: yes)

[11720](https://github.com/flutter/engine/pull/11720) Revert "Notify framework to clear input connection when app is backgrounded (#35054) (#9498)" (cla: yes)

[11722](https://github.com/flutter/engine/pull/11722) Quote the font family name whenever setting the font-family property. (cla: yes)

[11732](https://github.com/flutter/engine/pull/11732) last flutter web sync: cc38319841 (cla: yes)

[11736](https://github.com/flutter/engine/pull/11736) Add wasm to sky_engine (cla: yes)

[11776](https://github.com/flutter/engine/pull/11776) [flutter_runner] Port over all the changes to the dart_runner cmx files (cla: yes)

[11783](https://github.com/flutter/engine/pull/11783) completely strip bitcode (cla: yes)

[11784](https://github.com/flutter/engine/pull/11784) Roll fuchsia/sdk/core/linux-amd64 from -UaaS... to fSXZ0... (cla: yes)

[11790](https://github.com/flutter/engine/pull/11790) Roll fuchsia/clang/linux-amd64 from wGyr4... to -mnHl... (cla: yes)

[11792](https://github.com/flutter/engine/pull/11792) Started logging warnings if we drop platform messages. (cla: yes)

[11795](https://github.com/flutter/engine/pull/11795) Add a good reference source for font metrics. (cla: yes)

[11796](https://github.com/flutter/engine/pull/11796) Provide a hook for a plugin handler to receive messages on the web (cla: yes)

[11798](https://github.com/flutter/engine/pull/11798) Manage resource and onscreen contexts using separate IOSGLContext objects (cla: yes)

[11799](https://github.com/flutter/engine/pull/11799) Let java unit tests build with autoninja (cla: yes)

[11802](https://github.com/flutter/engine/pull/11802) Adjust iOS frame start times to match the platform info (cla: yes)

[11804](https://github.com/flutter/engine/pull/11804) Incorporate View.setSystemGestureExclusionRects code review feedback from #11441 (cla: yes, platform-android)

[11807](https://github.com/flutter/engine/pull/11807) Fix deleting Thai vowel bug on iOS (cla: yes)

[11808](https://github.com/flutter/engine/pull/11808) Annotate nullability on FlutterEngine to make swift writing more ergonomic (cla: yes)

[11817](https://github.com/flutter/engine/pull/11817) Smooth out iOS irregular input events delivery (cla: yes)

[11828](https://github.com/flutter/engine/pull/11828) [Windows] Address #36422 by adding a context for async resource uploading (affects: desktop, cla: yes, platform-windows)

[11835](https://github.com/flutter/engine/pull/11835) [CFE/VM] Fix merge/typo for bump to kernel version 29 (cla: yes)

[11839](https://github.com/flutter/engine/pull/11839) Remove ENABLE_BITCODE from Scenarios test app (affects: tests, cla: yes)

[11841](https://github.com/flutter/engine/pull/11841) Revert "Add a BroadcastStream to FrameTiming (#11041)" (cla: yes)

[11842](https://github.com/flutter/engine/pull/11842) Fix RTL justification with newline by passing in full justify tracking  var (cla: yes)

[11844](https://github.com/flutter/engine/pull/11844) Updated API usage in scenario app by deleting unnecessary method. (cla: yes)

[11847](https://github.com/flutter/engine/pull/11847) Add a sample unit test target to flutter runner (cla: yes)

[11849](https://github.com/flutter/engine/pull/11849) Support building standalone far packages with autogen manifests (cla: yes)

[11875](https://github.com/flutter/engine/pull/11875) [flutter_runner] Add common libs to the test far (cla: yes)

[11877](https://github.com/flutter/engine/pull/11877) Finish plumbing message responses on method channels (cla: yes)

[11880](https://github.com/flutter/engine/pull/11880) Handle new navigation platform messages (cla: yes, platform-web)

[11883](https://github.com/flutter/engine/pull/11883) LTO fuchsia binaries (cla: yes)

[11886](https://github.com/flutter/engine/pull/11886) remove extra redundant channels setup in iOS embedding engine (cla: yes)

[11890](https://github.com/flutter/engine/pull/11890) Add some AppLifecycleTests (CQ+1, cla: yes)

[11893](https://github.com/flutter/engine/pull/11893) Add @Keep annotation (cla: yes)

[11899](https://github.com/flutter/engine/pull/11899) Improve input method and Unicode character display(#30661) (cla: yes)

[11902](https://github.com/flutter/engine/pull/11902) Remove un-needed FragmentActivity import statements to facilitate proguard. (cla: yes)

[11912](https://github.com/flutter/engine/pull/11912) Document dependencies and remove support-v13 (cla: yes)

[11913](https://github.com/flutter/engine/pull/11913) Added new lifecycle enum (CQ+1, cla: yes, prod: API break, waiting for tree to go green)

[12010](https://github.com/flutter/engine/pull/12010) option for --no-lto for fuchsia (CQ+1, cla: yes, waiting for tree to go green)

[12011](https://github.com/flutter/engine/pull/12011) Cherry-picks for 1.9.1 (cla: yes)

[12016](https://github.com/flutter/engine/pull/12016) [flutter_runner] Kernel platform files can now be built in topaz (cla: yes)

[12023](https://github.com/flutter/engine/pull/12023) Fix multi span text ruler cache lookup failure. (cla: yes)

[12026](https://github.com/flutter/engine/pull/12026) [flutter_runner] Plumb Flutter component arguments to the Dart entrypoint (cla: yes)

[12034](https://github.com/flutter/engine/pull/12034) [flutter_runner] Refactor our build rules to make them more inline with topaz (cla: yes)

[12048](https://github.com/flutter/engine/pull/12048) [flutter_runner] Generate symbols for the Dart VM profiler (cla: yes)

[12054](https://github.com/flutter/engine/pull/12054) [flutter_runner] Port the accessibility bridge from Topaz (cla: yes)

[12055](https://github.com/flutter/engine/pull/12055) Revert "Manage resource and onscreen contexts using separate IOSGLCon… (cla: yes)

[12058](https://github.com/flutter/engine/pull/12058) Roll fuchsia/clang/linux-amd64 from -mnHl... to VoYNW... (cla: yes)

[12076](https://github.com/flutter/engine/pull/12076) Add a method to flutter_window_controller to destroy the current window. (cla: yes)

[12078](https://github.com/flutter/engine/pull/12078) Manage iOS contexts separately (cla: yes)

[12079](https://github.com/flutter/engine/pull/12079) Add custom test plugin that supports screenshot tests (cla: yes)

[12080](https://github.com/flutter/engine/pull/12080) Don't quote generic font families (cla: yes)

[12081](https://github.com/flutter/engine/pull/12081) Add GradientRadial paintStyle implementation (cla: yes)

[12084](https://github.com/flutter/engine/pull/12084) Guard availability of user notification related methods to iOS 10.0 (cla: yes)

[12085](https://github.com/flutter/engine/pull/12085) Enable platform view keyboard input on Android Q (cla: yes, waiting for tree to go green)

[12087](https://github.com/flutter/engine/pull/12087) Don't launch the observatory by default on each embedder unit-test invocation. (cla: yes)

[12128](https://github.com/flutter/engine/pull/12128) Make iOS FlutterViewController stop sending inactive/pause on app lifecycle events when not visible (cla: yes, prod: API break)

[12161](https://github.com/flutter/engine/pull/12161) Ensure that the web image ImageShader implements Shader (cla: yes)

[12167](https://github.com/flutter/engine/pull/12167) Channel buffers (cla: yes)

[12190](https://github.com/flutter/engine/pull/12190) Move the Fuchsia tryjob into a its own step and disable LTO. (cla: yes)

[12192](https://github.com/flutter/engine/pull/12192) Updating text field location in IOS as a pre-work for spellcheck (affects: text input, cla: yes, platform-web)

[12197](https://github.com/flutter/engine/pull/12197) add a convenience CLI tool for building and testing web engine (cla: yes)

[12204](https://github.com/flutter/engine/pull/12204) Don't disable toString in release mode for dart:ui classes (cla: yes)

[12205](https://github.com/flutter/engine/pull/12205) Don't load Roboto by default (cla: yes)

[12206](https://github.com/flutter/engine/pull/12206) Only build the x64 variant of Fuchsia on the try-jobs. (cla: yes)

[12209](https://github.com/flutter/engine/pull/12209) Roll buildroot and Fuchsia toolchain and unblock the Fuchsia/Linux autoroller manually. (cla: yes)

[12218](https://github.com/flutter/engine/pull/12218) Namespace patched SDK names to not conflict with Topaz (cla: yes)

[12222](https://github.com/flutter/engine/pull/12222) Do not generate kernel platform files on topaz tree (cla: yes)

[12226](https://github.com/flutter/engine/pull/12226) [web_ui] add missing dispose handler for MethodCalls to flutter/platform_view (cla: yes)

[12227](https://github.com/flutter/engine/pull/12227) [web_ui] PersistedPlatformView attribute update handling to enable resizing (cla: yes)

[12228](https://github.com/flutter/engine/pull/12228) pin and auto-install chrome version (cla: yes)

[12229](https://github.com/flutter/engine/pull/12229) Improve check to render (or not) a DRRect when inner falls outside of outer on RecordingCanvas (cla: yes)

[12230](https://github.com/flutter/engine/pull/12230) Add an initial macOS version of FlutterAppDelegate (cla: yes)

[12232](https://github.com/flutter/engine/pull/12232) FlutterViewController notify will dealloc (cla: yes)

[12233](https://github.com/flutter/engine/pull/12233) Revert "Manage iOS contexts separately" (cla: yes)

[12234](https://github.com/flutter/engine/pull/12234) [glfw/windows] Stops keeping track of input models (cla: yes)

[12235](https://github.com/flutter/engine/pull/12235) Roll dart to e6887536aadc7fbd1990448989601cee0224958d. (cla: yes)

[12249](https://github.com/flutter/engine/pull/12249) Editable text fix (affects: text input, cla: yes, platform-web)

[12251](https://github.com/flutter/engine/pull/12251) Revert "Smooth out iOS irregular input events delivery (#11817)" (cla: yes)

[12253](https://github.com/flutter/engine/pull/12253) Implement Base32Decode (cla: yes)

[12255](https://github.com/flutter/engine/pull/12255) Roll dart to d9489622befb638c040975163cf9b8eba2ff057b. (cla: yes)

[12256](https://github.com/flutter/engine/pull/12256) Do not assume Platform.script is a Dart source file during training. (cla: yes)

[12257](https://github.com/flutter/engine/pull/12257) Re-enable ThreadChecker and fix associated failures (CQ+1, cla: yes)

[12258](https://github.com/flutter/engine/pull/12258) Refactor and polish the 'felt' tool (cla: yes)

[12263](https://github.com/flutter/engine/pull/12263) Revert "Started taking advantage of Skia's new copyTableData to avoid (#10154)" (cla: yes)

[12264](https://github.com/flutter/engine/pull/12264) Revert "Add some AppLifecycleTests (#11890)" (cla: yes)

[12266](https://github.com/flutter/engine/pull/12266) Reland add some AppLifecycleTests (cla: yes)

[12267](https://github.com/flutter/engine/pull/12267) [macos] Stops keeping track of text input models (cla: yes, platform-macos)

[12268](https://github.com/flutter/engine/pull/12268) Close the tree (cla: yes)

[12269](https://github.com/flutter/engine/pull/12269) a11y: expose max character count for text fields (cla: yes)

[12272](https://github.com/flutter/engine/pull/12272) Revert "Close the tree" (cla: yes)

[12273](https://github.com/flutter/engine/pull/12273) Clean up after AppLifecycleTests (cla: yes)

[12274](https://github.com/flutter/engine/pull/12274) Store screenshot test output as Cirrus artifacts; do fuzzy comparison of non-matching screenshot pixels (cla: yes)

[12275](https://github.com/flutter/engine/pull/12275) Shuffle test order and repeat test runs once. (CQ+1, cla: yes)

[12276](https://github.com/flutter/engine/pull/12276) Add system font change listener for windows (cla: yes)

[12277](https://github.com/flutter/engine/pull/12277) Manage resource and onscreen contexts using separate IOSGLContext objects (cla: yes)

[12280](https://github.com/flutter/engine/pull/12280) Reland "Smooth out iOS irregular input events delivery (#11817)" (cla: yes)

[12281](https://github.com/flutter/engine/pull/12281) optionally skip builds (cla: yes)

[12282](https://github.com/flutter/engine/pull/12282) [flutter_runner] Change the path to artifacts (cla: yes)

[12284](https://github.com/flutter/engine/pull/12284) New features for golden tests (for web) (cla: yes)

[12287](https://github.com/flutter/engine/pull/12287) Adds PluginRegistry to the C++ client wrapper API (cla: yes)

[12288](https://github.com/flutter/engine/pull/12288) Include firefox in check to quote font families (cla: yes)

[12289](https://github.com/flutter/engine/pull/12289) Fix flutter runner paths (cla: yes)

[12292](https://github.com/flutter/engine/pull/12292) Revert "Add iOS platform view mutation XCUITests to the scenario app … (cla: yes)

[12295](https://github.com/flutter/engine/pull/12295) Issue 13238: on iOS, force an orientation change when the current orientation is not allowed (cla: yes, platform-ios)

[12303](https://github.com/flutter/engine/pull/12303) Add a build command to felt (cla: yes, platform-web)

[12305](https://github.com/flutter/engine/pull/12305) Introduce flutterfragmentactivity (cla: yes)

[12306](https://github.com/flutter/engine/pull/12306) Fix the declaration of setSystemGestureExclusionRects to match the PlatformMessageHandler interface (cla: yes)

[12307](https://github.com/flutter/engine/pull/12307) Cleanup in web_ui (cla: yes)

[12308](https://github.com/flutter/engine/pull/12308) [flutter] Remove old A11y API's. (cla: yes)

[12318](https://github.com/flutter/engine/pull/12318) Update canvaskit backend (cla: yes)

[12319](https://github.com/flutter/engine/pull/12319) Add "type" to getDisplayRefreshRate protocol (cla: yes)

[12320](https://github.com/flutter/engine/pull/12320) Fix continuous event polling in the GLFW event loop (cla: yes)

[12322](https://github.com/flutter/engine/pull/12322) Tests for #11283 (cla: yes)

[12323](https://github.com/flutter/engine/pull/12323) README for the felt tool (cla: yes, platform-web)

[12324](https://github.com/flutter/engine/pull/12324) Roll buildroot and remove toolchain prefix. (cla: yes)

[12325](https://github.com/flutter/engine/pull/12325) [fuchsia] add fuchsia.netstack.Netstack (affects: engine, cla: yes, customer: pink)

[12327](https://github.com/flutter/engine/pull/12327) Revert "Provide dart vm initalize isolate callback so that children i… (cla: yes)

[12328](https://github.com/flutter/engine/pull/12328) Added javadoc comments to FlutterActivity and FlutterFragmentActivity. (cla: yes)

[12330](https://github.com/flutter/engine/pull/12330) Ensure DRRects without corners also draw. (cla: yes)

[12335](https://github.com/flutter/engine/pull/12335) [Web] Implement dark mode support for web (cla: yes)

[12336](https://github.com/flutter/engine/pull/12336) Check for index bounds in RTL handling for trailing whitespace runs. (cla: yes)

[12338](https://github.com/flutter/engine/pull/12338) Add missing CL, fix targets for Fuchsia (cla: yes)

[12340](https://github.com/flutter/engine/pull/12340) [flutter_runner] Do not use pre-builts just yet (cla: yes)

[12342](https://github.com/flutter/engine/pull/12342) Update test to verify that secondary isolate gets shutdown before root isolate exits. (cla: yes)

[12343](https://github.com/flutter/engine/pull/12343) [flutter_runner] Remove usages of shared snapshots from CC sources (cla: yes)

[12345](https://github.com/flutter/engine/pull/12345) [flutter_runner] Port over the tuning advice for vulkan surface provider (cla: yes)

[12346](https://github.com/flutter/engine/pull/12346) [flutter_runner] Move from runner context to component context (cla: yes)

[12347](https://github.com/flutter/engine/pull/12347) [flutter_runner][async] Migrate dart/flutter to new async-loop APIs (cla: yes)

[12348](https://github.com/flutter/engine/pull/12348) [flutter_runner] Port the new compilation trace from topaz (cla: yes)

[12349](https://github.com/flutter/engine/pull/12349) [flutter_runner] Explicitly set |trace_skia| to false (cla: yes)

[12350](https://github.com/flutter/engine/pull/12350) [flutter_runner] Port vulkan surface changes (cla: yes)

[12353](https://github.com/flutter/engine/pull/12353) Add web engine screenshot (scuba) tests (cla: yes)

[12354](https://github.com/flutter/engine/pull/12354) java lints (cla: yes)

[12355](https://github.com/flutter/engine/pull/12355) skip flaky test (cla: yes)

[12359](https://github.com/flutter/engine/pull/12359) Forwards Flutter View to platform views and detaches when needed. (cla: yes)

[12362](https://github.com/flutter/engine/pull/12362) Fixes race condition that was reported internally. (cla: yes)

[12363](https://github.com/flutter/engine/pull/12363) Track "mouse leave" event (cla: yes, platform-windows)

[12364](https://github.com/flutter/engine/pull/12364) Revert "Reland "Smooth out iOS irregular input events delivery" (#12280)" (cla: yes)

[12370](https://github.com/flutter/engine/pull/12370) Added a default entrypoint variable to match android syntax. (cla: yes)

[12373](https://github.com/flutter/engine/pull/12373) Added unit tests for method channels. (cla: yes)

[12375](https://github.com/flutter/engine/pull/12375) Sync dart_runner (cla: yes)

[12376](https://github.com/flutter/engine/pull/12376) Roll Wuffs to 0.2.0-alpha.47 (cla: yes)

[12380](https://github.com/flutter/engine/pull/12380) [flutter_runner] a11y updates, tests! (CQ+1, cla: yes)

[12383](https://github.com/flutter/engine/pull/12383) Add macOS testing support (cla: yes)

[12385](https://github.com/flutter/engine/pull/12385) Reland "Smooth out iOS irregular input events delivery (#12280)" (cla: yes)

[12395](https://github.com/flutter/engine/pull/12395) Update --dart-vm-flags whitelist to include --write-service-info and --sample-buffer-duration (cla: yes)

[12402](https://github.com/flutter/engine/pull/12402) Resize channel buffers (CQ+1, cla: yes)

[12403](https://github.com/flutter/engine/pull/12403) Don't send pointer events when the framework isn't ready yet (cla: yes, platform-web)

[12404](https://github.com/flutter/engine/pull/12404) Support accessibility labels on iOS switches. (cla: yes)

[12410](https://github.com/flutter/engine/pull/12410) Send TYPE_VIEW_FOCUSED for views with input focus. (cla: yes)

[12412](https://github.com/flutter/engine/pull/12412) SkSL precompile (cla: yes)

[12413](https://github.com/flutter/engine/pull/12413) Migrate from fuchsia.crash.Analyzer to fuchsia.feedback.CrashReporter (cla: yes)

[12423](https://github.com/flutter/engine/pull/12423) add windows embedding test (cla: yes)

[12426](https://github.com/flutter/engine/pull/12426) Store fallback font names as a vector instead of a set. (cla: yes)

[12428](https://github.com/flutter/engine/pull/12428) Reword confusing messaging surrounding unhandled exception in flutter_runner on Fuchsia (cla: yes)

[12431](https://github.com/flutter/engine/pull/12431) Interpret negative radii as 0 in recording_canvas.dart (cla: yes)

[12432](https://github.com/flutter/engine/pull/12432) Work around Samsung keyboard issue (cla: yes)

[12434](https://github.com/flutter/engine/pull/12434) delete golden files; switch to flutter/goldens (cla: yes)

[12435](https://github.com/flutter/engine/pull/12435) add dart:html, dart:js, and dart:js_util to the copy of the Dart SDK used for analysis (cla: yes)

[12436](https://github.com/flutter/engine/pull/12436) Roll dart sdk to 69b5681546c68ab85e2ce6d3e7b92ed7d113e7c1. (cla: yes)

[12443](https://github.com/flutter/engine/pull/12443) Force exit felt tool on sigint, sigterm (cla: yes)

[12445](https://github.com/flutter/engine/pull/12445) [web] filter test targets; cache host.dart compilation (cla: yes)

[12446](https://github.com/flutter/engine/pull/12446) Add support for JIT release mode (cla: yes)

[12447](https://github.com/flutter/engine/pull/12447) Reflect selection changes in Firefox for text editing (cla: yes, platform-web)

[12448](https://github.com/flutter/engine/pull/12448) Make kDoNotResizeDimension public so framework can use it directly (cla: yes)

[12450](https://github.com/flutter/engine/pull/12450) Adds support for 5 mouse buttons (cla: yes)

[12453](https://github.com/flutter/engine/pull/12453) Adding Link SemanticsFlag (accessibility, affects: framework, cla: yes)

[12454](https://github.com/flutter/engine/pull/12454) Add .mskp file to binary format (cla: yes)

[12455](https://github.com/flutter/engine/pull/12455) Revert "Send TYPE_VIEW_FOCUSED for views with input focus. (#12410)" (cla: yes)

[12466](https://github.com/flutter/engine/pull/12466) Revert "Support accessibility labels on iOS switches." (cla: yes)

[12469](https://github.com/flutter/engine/pull/12469) Started asserting the FlutterEngine is running before communicating over channels. (cla: yes)

[12470](https://github.com/flutter/engine/pull/12470) [web_ui] Check if a pointer is already down for the specific device (cla: yes)

[12479](https://github.com/flutter/engine/pull/12479) Refactoring text_editing.dart (cla: yes)

[12563](https://github.com/flutter/engine/pull/12563) Remove use of the blobs snapshot format from unittests (cla: yes)

[12565](https://github.com/flutter/engine/pull/12565) Remove references to topaz (cla: yes)

[12572](https://github.com/flutter/engine/pull/12572) Update linux toolchain for fuchsia (cla: yes)

[12573](https://github.com/flutter/engine/pull/12573) [flutter_runner] Refactor thread_application pair to ActiveApplication (cla: yes)

[12578](https://github.com/flutter/engine/pull/12578) Revert "Update linux toolchain for fuchsia" (cla: yes)

[12587](https://github.com/flutter/engine/pull/12587) Split out the logic to handle status bar touches into its own function (cla: yes)

[12610](https://github.com/flutter/engine/pull/12610) Revert "[fuchsia] Wire up OpacityLayer to Scenic (#11322)" (cla: yes)

[12618](https://github.com/flutter/engine/pull/12618) Add isFocusable to SemanticsFlag (cla: yes)

[12681](https://github.com/flutter/engine/pull/12681) Create a package-able incremental compiler (cla: yes)

[12695](https://github.com/flutter/engine/pull/12695) Add onUnregistered callback in 'Texture' and 'FlutterTexture' (cla: yes)

[12698](https://github.com/flutter/engine/pull/12698) [web_ui] Fixing invalid state bug for text editing (affects: text input, cla: yes, platform-web)

[12699](https://github.com/flutter/engine/pull/12699) Adding 'pub get' to the 'compile_xxxx.sh' in the Scenario app (cla: yes)

[12700](https://github.com/flutter/engine/pull/12700) Add missing flag for embedder. (cla: yes)

[12701](https://github.com/flutter/engine/pull/12701) Cleanup: Made a macro to assert ARC is enabled. (cla: yes)

[12703](https://github.com/flutter/engine/pull/12703) [flutter_runner] Replace read exec calls on Fuchsia to adhere to Verified Execution semantics (cla: yes)

[12706](https://github.com/flutter/engine/pull/12706) Check for a null input method subtype (cla: yes)

[12707](https://github.com/flutter/engine/pull/12707) Reland "Add iOS platform view mutation XCUITests to the scenario app(#11652)" (cla: yes)

[12708](https://github.com/flutter/engine/pull/12708) Cleanup: Turned on NS_ASSUME_NONNULL_BEGIN for FlutterViewController. (CQ+1, cla: yes)

[12710](https://github.com/flutter/engine/pull/12710) Set transparent background in textarea elements (affects: text input, cla: yes, platform-web)

[12712](https://github.com/flutter/engine/pull/12712) Support correct keymap for web (accessibility, affects: text input, cla: yes, platform-web)

[12725](https://github.com/flutter/engine/pull/12725) Expanded channel buffer resize to method channels. (cla: yes)

[12728](https://github.com/flutter/engine/pull/12728) Remove unused import in the scenario app (cla: yes)

[12730](https://github.com/flutter/engine/pull/12730) Stop setting the accessibility text if a node has SCOPES_ROUTE set. (cla: yes)

[12732](https://github.com/flutter/engine/pull/12732) Fix parameter naming in docs (cla: yes)

[12733](https://github.com/flutter/engine/pull/12733) [flutter_runner] Make rd and rx uniform (cla: yes)

[12742](https://github.com/flutter/engine/pull/12742) Revert "Revert "Update linux toolchain for fuchsia" (#12578)" (CQ+1, cla: yes)

[12746](https://github.com/flutter/engine/pull/12746) Send AccessibilityEvent.TYPE_VIEW_FOCUSED when input focus is set. (cla: yes)

[12747](https://github.com/flutter/engine/pull/12747) Add web implementation for channel_buffers.dart (cla: yes)

[12752](https://github.com/flutter/engine/pull/12752) Enabled people to chose if SystemNavigator.pop is animated on iOS. (cla: yes)

[12753](https://github.com/flutter/engine/pull/12753) [web] Don't require felt to be in PATH (cla: yes, platform-web)

[12754](https://github.com/flutter/engine/pull/12754) Fix Metal builds by accounting for the updated SubmitFrame signature. (cla: yes)

[12761](https://github.com/flutter/engine/pull/12761) Build AOT and test targets, generate FARs when building Fuchsia (CQ+1, cla: yes)

[12771](https://github.com/flutter/engine/pull/12771) roll buildroot to 01e923507b28e5d1d3fe7597d2db2b30b0a543e9 (CQ+1, cla: yes)

[12773](https://github.com/flutter/engine/pull/12773) Revert "Manage resource and onscreen contexts using separate IOSGLCon… (cla: yes)

[12775](https://github.com/flutter/engine/pull/12775) Added some thread asserts to the code and made ios_surface_ safe since (cla: yes)

[12777](https://github.com/flutter/engine/pull/12777) Fix Metal builds. (cla: yes)

[12780](https://github.com/flutter/engine/pull/12780) Restart all modern Samsung keyboard IMM (cla: yes)

[12781](https://github.com/flutter/engine/pull/12781) Revert "Build AOT and test targets, generate FARs when building Fuchsia" (cla: yes)

[12783](https://github.com/flutter/engine/pull/12783) Add a unit-test to verify that root surface transformation affects platform view coordinates. (cla: yes)

[12785](https://github.com/flutter/engine/pull/12785) Fix bug in package script and add dev_compiler to list (cla: yes)

[12793](https://github.com/flutter/engine/pull/12793) Fixing selection issues in Firefox (cla: yes, platform-web)

[12794](https://github.com/flutter/engine/pull/12794) [web] Add support for path transform (cla: yes)

[12795](https://github.com/flutter/engine/pull/12795) Reland fuchsia build improvements (CQ+1, cla: yes)

[12797](https://github.com/flutter/engine/pull/12797) add option for bulk-updating screenshots; update screenshots (Work in progress (WIP), cla: yes)

[12798](https://github.com/flutter/engine/pull/12798) [flutter_runner] Update the cmx files to include TZ support (cla: yes)

[12799](https://github.com/flutter/engine/pull/12799) Disable EmbedderTest::CanLaunchAndShutdownMultipleTimes. (cla: yes)

[12800](https://github.com/flutter/engine/pull/12800) Prettify all CMX files (cla: yes)

[12801](https://github.com/flutter/engine/pull/12801) do not wrap font family name (cla: yes, platform-web)

[12802](https://github.com/flutter/engine/pull/12802) Build gen_snapshot with a 64-bit host toolchain even if the target platform is 32-bit (cla: yes)

[12805](https://github.com/flutter/engine/pull/12805) Unbreak Fuchsia unopt builds (cla: yes)

[12806](https://github.com/flutter/engine/pull/12806) Move initialization into FlutterEngine (cla: yes)

[12808](https://github.com/flutter/engine/pull/12808) Added an embedder example (cla: yes)

[12809](https://github.com/flutter/engine/pull/12809) Use the x64 host toolchain for x86 target gen_snapshot only on Linux (cla: yes)

[12811](https://github.com/flutter/engine/pull/12811) [web] Implement basic radial gradient (TileMode.clamp, no transform) (cla: yes)

[12813](https://github.com/flutter/engine/pull/12813) Unblock SIGPROF on flutter_tester start (cla: yes)

[12814](https://github.com/flutter/engine/pull/12814) Enable all engine test on windows (cla: yes)

[12815](https://github.com/flutter/engine/pull/12815) Revert "Adding Link SemanticsFlag" (cla: yes)

[12816](https://github.com/flutter/engine/pull/12816) Enable sanitizer build variants. (cla: yes)

[12819](https://github.com/flutter/engine/pull/12819) Open source canvas tests from flutter_web_ui (cla: yes)

[12821](https://github.com/flutter/engine/pull/12821) Update buildroot to pull in ubsan updates. (cla: yes)

[12931](https://github.com/flutter/engine/pull/12931) remove references to package:_chrome (cla: yes)

[12958](https://github.com/flutter/engine/pull/12958) Adding deviceId to KeyEventChannel enconding method (cla: yes)

[12960](https://github.com/flutter/engine/pull/12960) Fix typo on channel buffer debug output. (cla: yes)

[12972](https://github.com/flutter/engine/pull/12972) Re-land Adding Link Semantics (accessibility, affects: framework, cla: yes)

[12974](https://github.com/flutter/engine/pull/12974) Support empty strings and vectors in standard codec (cla: yes)

[12977](https://github.com/flutter/engine/pull/12977) Unblock Fuchsia roll (cla: yes)

[12980](https://github.com/flutter/engine/pull/12980) Made _printDebug only happen on debug builds of the engine for now. (cla: yes)

[12982](https://github.com/flutter/engine/pull/12982) Color matrix doc (cla: yes)

[12983](https://github.com/flutter/engine/pull/12983) Roll Wuffs to 0.2.0-rc.1 (cla: yes)

[12986](https://github.com/flutter/engine/pull/12986) Prevent default when Tab is clicked (accessibility, affects: text input, cla: yes, platform-web)

[12987](https://github.com/flutter/engine/pull/12987) Added FlutterActivity and FlutterFragment hook to cleanUpFlutterEngine() as symmetry for configureFlutterEngine(). (#41943) (cla: yes)

[12988](https://github.com/flutter/engine/pull/12988) Use the standard gen_snapshot target unless the platform requires host_targeting_host (cla: yes)

[12989](https://github.com/flutter/engine/pull/12989) Unpublicize kDoNotResizeDimension (cla: yes)

[12990](https://github.com/flutter/engine/pull/12990) Fix for a11y crash on iOS (cla: yes)

[12991](https://github.com/flutter/engine/pull/12991) Compile sanitizer suppressions list and file bugs as necessary. (cla: yes)

[12997](https://github.com/flutter/engine/pull/12997) Roll dart to aece1c1e92. (cla: yes)

[12999](https://github.com/flutter/engine/pull/12999) Started setting our debug background task id to invalid (cla: yes)

[13001](https://github.com/flutter/engine/pull/13001) Missing link flag (cla: yes)

[13003](https://github.com/flutter/engine/pull/13003) [web] Update the url when route is replaced (cla: yes, platform-web)

[13004](https://github.com/flutter/engine/pull/13004) Allow embedders to disable causal async stacks in the Dart VM (cla: yes)

[13005](https://github.com/flutter/engine/pull/13005) Auto-formatter fixes for BUILD.gn files (cla: yes)

[13006](https://github.com/flutter/engine/pull/13006) Refactor: FlutterDartProject (cla: yes)

[13008](https://github.com/flutter/engine/pull/13008) Integration with more of Skia's SkShaper/SkParagraph APIs (cla: yes)

[13009](https://github.com/flutter/engine/pull/13009) Fixing Link Semantics Typo (accessibility, affects: framework, cla: yes)

[13013](https://github.com/flutter/engine/pull/13013) Add missing focusable testing info (cla: yes)

[13015](https://github.com/flutter/engine/pull/13015) Fire PlatformViewController FlutterView callbacks (cla: yes)

[13017](https://github.com/flutter/engine/pull/13017) Revert "Upgrade compiler to Clang 10." (cla: yes)

[13029](https://github.com/flutter/engine/pull/13029) Minimal test harness for iOS (cla: yes)

[13033](https://github.com/flutter/engine/pull/13033) dart analysis of tests, cleanup (CQ+1, cla: yes)

[13037](https://github.com/flutter/engine/pull/13037) Analyze framework Dart code in presubmit tests (cla: yes)

[13042](https://github.com/flutter/engine/pull/13042) Add "felt clean" command (cla: yes)

[13043](https://github.com/flutter/engine/pull/13043) Add a task runner for the Win32 embedding (cla: yes)

[13044](https://github.com/flutter/engine/pull/13044) Support keyboard types on mobile browsers (affects: text input, cla: yes, platform-web)

[13045](https://github.com/flutter/engine/pull/13045) Wires the locale provided by Fuchsia. (cla: yes)

[13047](https://github.com/flutter/engine/pull/13047) Allow embedders to specify arbitrary data to the isolate on launch. (cla: yes)

[13048](https://github.com/flutter/engine/pull/13048) Test child isolates are terminated when root is shutdown (cla: yes)

[13049](https://github.com/flutter/engine/pull/13049) Ignore thread leaks from Dart VM in tsan instrumented builds. (cla: yes)

[13051](https://github.com/flutter/engine/pull/13051) Don’t bump iOS deployment target for Metal builds. (cla: yes)

[13053](https://github.com/flutter/engine/pull/13053) Set the Cirrus badge to only display status of the master branch. (cla: yes)

[13056](https://github.com/flutter/engine/pull/13056) Put Metal renderer selection behind runtime flag and plist opt-in. (cla: yes)

[13059](https://github.com/flutter/engine/pull/13059) Android targets create final zip artifacts (CQ+1, cla: yes)

[13066](https://github.com/flutter/engine/pull/13066) [web] Add basic color per vertex drawVertices API support (cla: yes)

[13067](https://github.com/flutter/engine/pull/13067) Revert "Test child isolates are terminated when root is shutdown" (cla: yes)

[13071](https://github.com/flutter/engine/pull/13071) [dart_aot_runner] Add support for generating dart_aot snapshots (cla: yes)

[13073](https://github.com/flutter/engine/pull/13073) Removed retain cycle from notification center. (cla: yes)

[13074](https://github.com/flutter/engine/pull/13074) [dart_aot_runner] Add rules to generate dart_aot binaries (cla: yes)

[13075](https://github.com/flutter/engine/pull/13075) Revert "[dart_aot_runner] Add support for generating dart_aot snapsho… (cla: yes)

[13076](https://github.com/flutter/engine/pull/13076) Reland dart_aot_runner shims (cla: yes)

[13082](https://github.com/flutter/engine/pull/13082) java imports/style (cla: yes, waiting for tree to go green)

[13085](https://github.com/flutter/engine/pull/13085) Print more output when gen_package fails (cla: yes)

[13086](https://github.com/flutter/engine/pull/13086) Gen package output corrected (cla: yes)

[13088](https://github.com/flutter/engine/pull/13088) felt: use rest args for specifying test targets (cla: yes)

[13089](https://github.com/flutter/engine/pull/13089) cleanup gen_package.py (cla: yes)

[13090](https://github.com/flutter/engine/pull/13090) Snapshot the felt tool for faster start-up (cla: yes)

[13091](https://github.com/flutter/engine/pull/13091) Remove persistent cache unittest timeout (cla: yes)

[13093](https://github.com/flutter/engine/pull/13093) iOS Platform View: Fixed overrelease of the observer. (cla: yes)

[13094](https://github.com/flutter/engine/pull/13094) Integrate more SkParagraph builder patches (cla: yes)

[13096](https://github.com/flutter/engine/pull/13096) [dart_aot_runner] Use the host_toolchain to build kernels (cla: yes)

[13097](https://github.com/flutter/engine/pull/13097) Update felt README (cla: yes)

[13099](https://github.com/flutter/engine/pull/13099) NO_SUGGESTIONS keyboard flag in Android (cla: yes)

[13100](https://github.com/flutter/engine/pull/13100) ColorFilter matrix docs (cla: yes)

[13101](https://github.com/flutter/engine/pull/13101) [dart_aot_runner] Generate vmservice aotsnapshots (cla: yes)

[13103](https://github.com/flutter/engine/pull/13103) [dart_aot_runner] Complete the port of dart_aot_runner (cla: yes)

[13121](https://github.com/flutter/engine/pull/13121) Change IO thread shader cache strategy (cla: yes)

[13122](https://github.com/flutter/engine/pull/13122) refactoring chrome_installer (cla: yes)

[13123](https://github.com/flutter/engine/pull/13123) Upgrades the ICU version to 64.2 (cla: yes)

[13124](https://github.com/flutter/engine/pull/13124) Allow embedders to specify a render task runner description. (cla: yes)

[13125](https://github.com/flutter/engine/pull/13125) add the dart:__interceptors library to the dart sdk (cla: yes)

[13126](https://github.com/flutter/engine/pull/13126) [frontend_server] Include bytecode generation in the training run. (cla: yes)

[13141](https://github.com/flutter/engine/pull/13141) Enable/tweak web sdk source maps (cla: yes)

[13143](https://github.com/flutter/engine/pull/13143) Add `flutter_tester` binary to the CIPD package (cla: yes)

[13144](https://github.com/flutter/engine/pull/13144) Document //flutter/runtime/dart_vm (cla: yes)

[13145](https://github.com/flutter/engine/pull/13145) Merge the Fuchsia frontend_server build script into the new flutter_frontend_server target (cla: yes)

[13146](https://github.com/flutter/engine/pull/13146) Revert "Upgrades the ICU version to 64.2 (#13123)" (cla: yes)

[13148](https://github.com/flutter/engine/pull/13148) Revert "Enable/tweak web sdk source maps (#13141)" (cla: yes)

[13151](https://github.com/flutter/engine/pull/13151) Remove incomplete static thread safety annotations. (cla: yes)

[13153](https://github.com/flutter/engine/pull/13153) Make the Dart isolate constructor private. (cla: yes)

[13154](https://github.com/flutter/engine/pull/13154) Fix an output file path for the frontend server package_incremental script (cla: yes)

[13155](https://github.com/flutter/engine/pull/13155) Roll buildroot to pull in static thread safety analysis options. (cla: yes)

[13157](https://github.com/flutter/engine/pull/13157) Fix type error in SkVertices (cla: yes)

[13158](https://github.com/flutter/engine/pull/13158) Add templates to generate fuchsia host bundles (cla: yes)

[13159](https://github.com/flutter/engine/pull/13159) Move surface-based SceneBuilder implementation under surface/ (cla: yes)

[13160](https://github.com/flutter/engine/pull/13160) Revert "Issue 13238: on iOS, force an orientation change when the current orientation is not allowed" (cla: yes)

[13161](https://github.com/flutter/engine/pull/13161) Enable/tweak web sdk source maps, take 2 (cla: yes)

[13162](https://github.com/flutter/engine/pull/13162) Document //flutter/runtime/dart_isolate.h (cla: yes)

[13163](https://github.com/flutter/engine/pull/13163) Manual roll of src/third_party/dart 4131d3d7c4...41b65b27c2 (28 commits) (cla: yes)

[13170](https://github.com/flutter/engine/pull/13170) Issue 13238: on iOS, force an orientation change when the current orientation is not allowed (cla: yes)

[13175](https://github.com/flutter/engine/pull/13175) Remove redundant call to updateEditingState in sendKeyEvent (cla: yes)

[13176](https://github.com/flutter/engine/pull/13176) Add repeatCount to FlutterKeyEvent (cla: yes)

[13177](https://github.com/flutter/engine/pull/13177) Update compiler to Clang 10. (cla: yes)

[13179](https://github.com/flutter/engine/pull/13179) Update timeout_microseconds to timeout in docs (cla: yes)

[13180](https://github.com/flutter/engine/pull/13180) Use the fixtures mechanism for txt unit-tests and benchmarks. (cla: yes)

[13181](https://github.com/flutter/engine/pull/13181) Revert "Update compiler to Clang 10." (cla: yes)

[13182](https://github.com/flutter/engine/pull/13182) If we get a 'down' event, add that device to the active devices. (cla: yes)

[13185](https://github.com/flutter/engine/pull/13185) Adding firefox_installer.dart (affects: tests, cla: yes, platform-web)

[13187](https://github.com/flutter/engine/pull/13187) [web] Environment variable to disable felt snapshot (cla: yes, platform-web)

[13189](https://github.com/flutter/engine/pull/13189) Add utils to disable on mac/windows, disable invalid LibLxt tests on mac (cla: yes)

[13190](https://github.com/flutter/engine/pull/13190) [web] Fix canvas reuse metrics. Refactor drawVertices code. (cla: yes)

[13192](https://github.com/flutter/engine/pull/13192) Use `window.devicePixelRatio` in the CanvasKit backend (cla: yes)

[13193](https://github.com/flutter/engine/pull/13193) Custom compositor layers must take into account the device pixel ratio. (cla: yes)

[13196](https://github.com/flutter/engine/pull/13196) Document //flutter/runtime/dart_snapshot.h (cla: yes)

[13207](https://github.com/flutter/engine/pull/13207) Wrap the text in text editing to fix selections. (cla: yes)

[13209](https://github.com/flutter/engine/pull/13209) Preserve stdout colors of subprocesses run by felt (cla: yes, platform-web)

[13211](https://github.com/flutter/engine/pull/13211) Revert "Custom compositor layers must take into account the device pixel ratio." (cla: yes)

[13212](https://github.com/flutter/engine/pull/13212) Add trace events around custom compositor callbacks. (cla: yes)

[13213](https://github.com/flutter/engine/pull/13213) Re-land "Custom compositor layers must take into account the device pixel ratio." (cla: yes)

[13214](https://github.com/flutter/engine/pull/13214) Forwards Activity result to FlutterFragment in FlutterFragmentActivity. (cla: yes)

[13215](https://github.com/flutter/engine/pull/13215) Adds Dark Mode support to new Android embedding (this was accidentally missed previously). (cla: yes)

[13216](https://github.com/flutter/engine/pull/13216) Reland icu upgrade (cla: yes)

[13218](https://github.com/flutter/engine/pull/13218) Specify a human readable reason for an error from the embedder API. (cla: yes)

[13232](https://github.com/flutter/engine/pull/13232) Avoid dereferencing IO manager weak pointers on the UI thread (CQ+1, cla: yes)

[13233](https://github.com/flutter/engine/pull/13233) Update ui.instantiateImageCodec docs to reflect what it does. (cla: yes)

[13236](https://github.com/flutter/engine/pull/13236) Roll buildroot to 994c6 (cla: yes)

[13237](https://github.com/flutter/engine/pull/13237) Do not attempt to drain the SkiaUnrefQueue in the destructor (cla: yes)

[13238](https://github.com/flutter/engine/pull/13238) Allow embedders to update preferrred locales. (cla: yes)

[13239](https://github.com/flutter/engine/pull/13239) Hold a reference to the Skia unref queue in UIDartState (cla: yes)

[13240](https://github.com/flutter/engine/pull/13240) Update CanvasKit to 0.7.0 and flesh out painting (cla: yes)

[13241](https://github.com/flutter/engine/pull/13241) Ignore *.obj files when gathering licenses (cla: yes)

[13242](https://github.com/flutter/engine/pull/13242) Update harfbuzz to 2.6.2, Roll buildroot to a518e (cla: yes)

[13255](https://github.com/flutter/engine/pull/13255) Fix NPE in accessibility bridge (cla: yes)

[13259](https://github.com/flutter/engine/pull/13259) [web] Support -j to use goma in felt build (cla: yes, platform-web)

[13261](https://github.com/flutter/engine/pull/13261) Updated license script to ignore testdata directories (cla: yes)

[13262](https://github.com/flutter/engine/pull/13262) Added Semantic header support on Android. (cla: yes)

[13264](https://github.com/flutter/engine/pull/13264) Made restarting the Engine remember the last entrypoint that was used. (cla: yes)

[13265](https://github.com/flutter/engine/pull/13265) Ensure we call into Engine from the UI taskrunner in Shell::EngineHasLivePorts() (cla: yes)

[13268](https://github.com/flutter/engine/pull/13268) [web] Support input action (affects: text input, cla: yes, platform-web)

[13269](https://github.com/flutter/engine/pull/13269) Send flag modified events to the framework (cla: yes)

[13270](https://github.com/flutter/engine/pull/13270) Add recipe changelog (cla: yes)

[13272](https://github.com/flutter/engine/pull/13272) [web] [test] Adding firefox install functionality to the test platform (affects: tests, cla: yes, platform-web)

[13273](https://github.com/flutter/engine/pull/13273) Make flutter_tester support multithreaded testing, and run all Dart tests in both single and multithreaded configurations (cla: yes)

[13274](https://github.com/flutter/engine/pull/13274) Fix decode feature detection in HtmlCodec (cla: yes)

[13275](https://github.com/flutter/engine/pull/13275) Flesh out the CanvasKit backend some more (cla: yes)

[13280](https://github.com/flutter/engine/pull/13280) Android embedding API updates for plugin ecosystem (cla: yes)

[13282](https://github.com/flutter/engine/pull/13282) Manual Roll of Dart from a61c775db8...e1c409792c (cla: yes)

[13287](https://github.com/flutter/engine/pull/13287) Revert "Made restarting the Engine remember the last entrypoint that … (cla: yes)

[13289](https://github.com/flutter/engine/pull/13289) Made restarting the Engine remember the last entrypoint that was used. (cla: yes)

[13290](https://github.com/flutter/engine/pull/13290) Do not request executable permission on Fuchsia file mappings unless it is required (cla: yes)

[13292](https://github.com/flutter/engine/pull/13292) Disable flaky test ShellTest_ReportTimingsIsCalled. (cla: yes)

[13294](https://github.com/flutter/engine/pull/13294) Roll Dart to 6a65ea9cad4b014f88d2f1be1b321db493725a1c. (cla: yes)

[13295](https://github.com/flutter/engine/pull/13295) Avoid accessing the Cocoa view on the GPU or IO task runners. (cla: yes)

[13296](https://github.com/flutter/engine/pull/13296) [web] Cupertino dynamic color fix. (cla: yes)

[13298](https://github.com/flutter/engine/pull/13298) Show strace logs when the Fuchsia gen_package script gets an error from the packaging tool (cla: yes)

[13300](https://github.com/flutter/engine/pull/13300) Switch the MacOS Desktop embedder to using a thread configuration where the platform and render task runners are the same. (cla: yes)

[13311](https://github.com/flutter/engine/pull/13311) [recipe] Upload opt flutter_tester (cla: yes)

[13314](https://github.com/flutter/engine/pull/13314) Guarding EAGLContext used by Flutter (cla: yes, platform-ios)

[13315](https://github.com/flutter/engine/pull/13315) Roll Dart to 635c47b1c9efe86b896d95bd446c6a5e2459037e. (cla: yes)

[13316](https://github.com/flutter/engine/pull/13316) Update the dependencies for the Fuchsia build of flutter_frontend_server (cla: yes)

[13319](https://github.com/flutter/engine/pull/13319) Add FlutterEngineRunsAOTCompiledDartCode to the embedder API. (cla: yes)

[13321](https://github.com/flutter/engine/pull/13321) Pass LinearTextFlag to SkFont -  iOS13 letter spacing (cla: yes)

[13335](https://github.com/flutter/engine/pull/13335) [fuchsia] [packaging] Host bundles are per runtime-mode (cla: yes)

[13337](https://github.com/flutter/engine/pull/13337) Bump dart/language_model to 9fJQZ0TrnAGQKrEtuL3-AXbUfPzYxqpN_OBHr9P4hE4C (cla: yes)

[13338](https://github.com/flutter/engine/pull/13338) [fuchsia] [packaging] Layout debug symbols for Fuchsia (CQ+1, cla: yes)

[13339](https://github.com/flutter/engine/pull/13339) Fix the output filename of the Fuchsia archive build template (CQ+1, cla: yes)

[13341](https://github.com/flutter/engine/pull/13341) Create a separate directory for the intermediate outputs of each Fuchsia archive build action (cla: yes)

[13342](https://github.com/flutter/engine/pull/13342) Intercept SystemSound.play platform message before it's sent. (cla: yes)

[13345](https://github.com/flutter/engine/pull/13345) Expose platform view ID on embedder semantics node (CQ+1, cla: yes)

[13346](https://github.com/flutter/engine/pull/13346) Remove TODO on embedder a11y unit tests (CQ+1, cla: yes)

[13349](https://github.com/flutter/engine/pull/13349) Deprecated DartExecutor as BinaryMessenger and added a getBinaryMessenger() method. (#43202) (cla: yes)

[13359](https://github.com/flutter/engine/pull/13359) Web: fix Color subclass handling (cla: yes)

[13360](https://github.com/flutter/engine/pull/13360) Turn on RasterCache based on view hierarchy (cla: yes)

[13361](https://github.com/flutter/engine/pull/13361) Expand on CanvasKit backend more (cla: yes)

[13364](https://github.com/flutter/engine/pull/13364) [flutter_runner] Remove the checks for libdart profiler symbols (cla: yes)

[13367](https://github.com/flutter/engine/pull/13367) Delay metal drawable acquisition till frame submission. (cla: yes)

[13391](https://github.com/flutter/engine/pull/13391) Implement basic Picture.toImage via BitmapCanvas (cla: yes)

[13394](https://github.com/flutter/engine/pull/13394) Remove multiplexed Flutter Android Lifecycle. (#43663) (cla: yes)

[13395](https://github.com/flutter/engine/pull/13395) fix fml_unittes is not run during presubmit (cla: yes)

[13396](https://github.com/flutter/engine/pull/13396) Made it so we clean up gl resources when view controllers get deleted. (CQ+1, cla: yes)

[13397](https://github.com/flutter/engine/pull/13397) [flutter_runner] Don't build far files twice (cla: yes)

[13400](https://github.com/flutter/engine/pull/13400) Revert "[flutter_runner] Don't build far files twice (#13397)" (cla: yes)

[13401](https://github.com/flutter/engine/pull/13401) Reformat BUILD.gn files to comply with the format checker presubmit script (cla: yes)

[13402](https://github.com/flutter/engine/pull/13402) Converted ActivityAware and ServiceAware Lifecycles to opaque objects (#43670) (cla: yes)

[13403](https://github.com/flutter/engine/pull/13403) Use DartExecutor.getBinaryMessenger in FlutterNativeView instead of deprecated send methods (cla: yes)

[13405](https://github.com/flutter/engine/pull/13405) Make sure root surface transformations survive resetting the matrix directly in Flow. (cla: yes)

[13406](https://github.com/flutter/engine/pull/13406) Fix the dry run mode of the GN format checker script (cla: yes)

[13407](https://github.com/flutter/engine/pull/13407) Kick luci (cla: yes)

[13419](https://github.com/flutter/engine/pull/13419) [dart_runner] Common libs need to exist for aot runner (CQ+1, cla: yes)

[13421](https://github.com/flutter/engine/pull/13421) FlutterAppDelegate: Added back in empty lifecycle methods  (cla: yes)

[13422](https://github.com/flutter/engine/pull/13422) [fuchsia] [packaging] Create a script to upload debug symbols to CIPD (cla: yes)

[13423](https://github.com/flutter/engine/pull/13423) Automatically destroy FlutterEngine when created by FlutterActivity or FlutterFragment. (cla: yes)

[13424](https://github.com/flutter/engine/pull/13424) Add isRunningInRobolectricTest back (cla: yes, waiting for tree to go green)

[13425](https://github.com/flutter/engine/pull/13425) Revert "fix fml_unittes is not run during presubmit (#13395)" (cla: yes)

[13426](https://github.com/flutter/engine/pull/13426) Reland "fix fml_unittes is not run during presubmit (#13395)" (CQ+1, cla: yes)

[13428](https://github.com/flutter/engine/pull/13428) Set the install name at link time for darwin dylibs (cla: yes)

[13432](https://github.com/flutter/engine/pull/13432) Release shim bindings when detaching (cla: yes)

[13440](https://github.com/flutter/engine/pull/13440) Switch to Cirrus Dockerfile as CI (cla: yes)

[13442](https://github.com/flutter/engine/pull/13442) Revert "Turn on RasterCache based on view hierarchy (#13360)" (cla: yes)

[13444](https://github.com/flutter/engine/pull/13444) Remove usage of yaml module from CIPD script (cla: yes)

[13445](https://github.com/flutter/engine/pull/13445) Fizzle onConfigurationChanged if no FlutterView (cla: yes)

[13448](https://github.com/flutter/engine/pull/13448) Duplicate the directory fd in fml::VisitFiles (cla: yes)

[13449](https://github.com/flutter/engine/pull/13449) Fix iOS crash when multiple platform views are in the scene (cla: yes)

[13451](https://github.com/flutter/engine/pull/13451) Fix mDNS for iOS13 (cla: yes, waiting for tree to go green)

[13455](https://github.com/flutter/engine/pull/13455) Automatically register plugins in FlutterEngine. (#43855) (cla: yes)

[13460](https://github.com/flutter/engine/pull/13460) [dart] Makes the intl services available (cla: yes)

[13461](https://github.com/flutter/engine/pull/13461) CIPD needs the directory to be relative (cla: yes)

[13462](https://github.com/flutter/engine/pull/13462) [web] Get the size from visualviewport instead of window.innerHeight/innerW… (cla: yes, platform-web)

[13463](https://github.com/flutter/engine/pull/13463) [fuchsia] [packaging] Prettify parent folder name (cla: yes)

[13464](https://github.com/flutter/engine/pull/13464) [recipe] Upload sky_engine to CIPD (cla: yes)

[13466](https://github.com/flutter/engine/pull/13466) [fuchsia] Bundle stripped SO files in fars (CQ+1, cla: yes)

[13467](https://github.com/flutter/engine/pull/13467) Revert 78a8ca0f62b04fa49030ecdd2d91726c0639401f (CQ+1, cla: yes)

[13468](https://github.com/flutter/engine/pull/13468) Pass the automaticallyRegisterPlugins flag to the FlutterEngine constructor in FlutterActivityTest (cla: yes)

[13469](https://github.com/flutter/engine/pull/13469) Fix stale platform view gr context on iOS (cla: yes)

[13471](https://github.com/flutter/engine/pull/13471) Package fml_unittests in a .far file for fml unit tests on Fuchsia (cla: yes)

[13474](https://github.com/flutter/engine/pull/13474) Request a reattach when creating the text input plugin on Android (cla: yes, waiting for tree to go green)

[13478](https://github.com/flutter/engine/pull/13478) use check_output instead of check_call (cla: yes)

[13479](https://github.com/flutter/engine/pull/13479) Print the output (cla: yes)

[13480](https://github.com/flutter/engine/pull/13480) Disabled GPUThreadMerger tests. (cla: yes)

[13482](https://github.com/flutter/engine/pull/13482) [fuchsia] [packaging] Fuchsia tree expects nested bz2 archives (cla: yes)

[13483](https://github.com/flutter/engine/pull/13483) web: fix Paragraph.getBoxesForRange for zero-length ranges (cla: yes)

[13486](https://github.com/flutter/engine/pull/13486) Add fuchsia.intl.PropertyProvider to our services on Fuchsia (cla: yes)

[13630](https://github.com/flutter/engine/pull/13630) Fix bug where Enter doesn't add new line in multi-line fields (affects: text input, cla: yes, platform-web)

[13632](https://github.com/flutter/engine/pull/13632) Revert "Added new lifecycle enum (#11913)" (cla: yes)

[13634](https://github.com/flutter/engine/pull/13634) [web] Ignore changes in *.ttf files in felt build watch mode (cla: yes, platform-web)

[13642](https://github.com/flutter/engine/pull/13642) Issues/39832 reland (CQ+1, cla: yes)

[13643](https://github.com/flutter/engine/pull/13643) Ensure that the CAMetalLayer FBO attachments can be read from. (cla: yes)

[13649](https://github.com/flutter/engine/pull/13649) Add 'Cough' test font and support multiple test fonts. (cla: yes)

[13651](https://github.com/flutter/engine/pull/13651) Fixed the scroll direction for iOS horizontal accessibility scroll events. (cla: yes)

[13660](https://github.com/flutter/engine/pull/13660) Fix splash screen lookup. (#44131) (cla: yes)

[13695](https://github.com/flutter/engine/pull/13695) Fix Class.forName unchecked call warning (cla: yes)

[13696](https://github.com/flutter/engine/pull/13696) [fuchsia] Temporarily disable intl provider (cla: yes)

[13697](https://github.com/flutter/engine/pull/13697) Moves pointer event sanitizing to engine. (cla: yes)

[13698](https://github.com/flutter/engine/pull/13698) Fix plugin registrant reflection path. (#44161) (cla: yes)

[13699](https://github.com/flutter/engine/pull/13699) [web] Don't send keyboard events from text fields to flutter (affects: text input, cla: yes, platform-web)

[13702](https://github.com/flutter/engine/pull/13702) Fix editing selection and deletion on macOS (cla: yes)

[13708](https://github.com/flutter/engine/pull/13708) Ensure that the device pixel ratio is taken into account with window metrics in physical pixels. (cla: yes)

[13710](https://github.com/flutter/engine/pull/13710) Fix picture raster cache throttling (cla: yes, waiting for tree to go green)

[13711](https://github.com/flutter/engine/pull/13711) Imagefilter wrapper object (cla: yes)

[13719](https://github.com/flutter/engine/pull/13719) Fix NPE in splash screen lookup (cla: yes)

[13720](https://github.com/flutter/engine/pull/13720) Revert "Added new lifecycle enum" (cla: yes)

[13721](https://github.com/flutter/engine/pull/13721) Revert "[fuchsia] Temporarily disable intl provider (#13696)" (cla: yes)

[13722](https://github.com/flutter/engine/pull/13722) [web] Proper support for text field's obscureText (affects: text input, cla: yes, platform-web)

[13727](https://github.com/flutter/engine/pull/13727) Add line boundary information to LineMetrics. (cla: yes)

[13728](https://github.com/flutter/engine/pull/13728) Prefer SchedulerBinding.addTimingsCallback (cla: yes)

[13731](https://github.com/flutter/engine/pull/13731) Expose the platform view mutator stack to custom compositors. (cla: yes)

[13735](https://github.com/flutter/engine/pull/13735) Cleanup obsolete --strong option of front-end server (cla: yes)

[13736](https://github.com/flutter/engine/pull/13736) libtxt: pass an RTL bool flag instead of a bidiFlags enum to measureText (cla: yes)

[13737](https://github.com/flutter/engine/pull/13737) [web] Don't run engine tests under vm (causing warnings) (cla: yes)

[13738](https://github.com/flutter/engine/pull/13738) Removed scary experimental warnings for new embedding. (#44314) (cla: yes)

[13739](https://github.com/flutter/engine/pull/13739) Point old plugin registry accessors to new embedding plugin accessors.  (#44225) (cla: yes)

[13741](https://github.com/flutter/engine/pull/13741) [web] Refactor text editing to handle any order of platform messages gracefully (affects: text input, cla: yes, platform-web)

[13742](https://github.com/flutter/engine/pull/13742) Only specify --no-link-platform when not specifying --aot, roll dart-lang sdk (cla: yes)

[13743](https://github.com/flutter/engine/pull/13743) Expose asset lookup from plugin binding. (#42019) (cla: yes)

[13744](https://github.com/flutter/engine/pull/13744) Create a new picture recorder even when the embedder supplied render target is recycled. (cla: yes)

[13747](https://github.com/flutter/engine/pull/13747) Move TextRange from the framework to dart:ui. (cla: yes)

[13748](https://github.com/flutter/engine/pull/13748) [web] Support gif/webp animations, Speed up image drawing in BitmapCanvas.  (cla: yes)

[13753](https://github.com/flutter/engine/pull/13753) Revert "Guarding EAGLContext used by Flutter" (cla: yes)

[13755](https://github.com/flutter/engine/pull/13755) Reland "Guarding EAGLContext used by Flutter #13314" (cla: yes)

[13756](https://github.com/flutter/engine/pull/13756) Manual roll of Dart e68ca9b652acdb642668a6acb5f630d5be6c03da...fa4379946109467c8a48f20f19d83d7c72968a3e (cla: yes)

[13757](https://github.com/flutter/engine/pull/13757) Revert "Reland "Guarding EAGLContext used by Flutter #13314"" (cla: yes)

[13758](https://github.com/flutter/engine/pull/13758) Reland children isolates sharing isolate group change. (cla: yes)

[13759](https://github.com/flutter/engine/pull/13759) Reland "Guarding EAGLContext used by Flutter #13314" (CQ+1, cla: yes)

[13760](https://github.com/flutter/engine/pull/13760) Implement Path.computeMetrics in the CanvasKit backend (cla: yes)

[13761](https://github.com/flutter/engine/pull/13761) Manual Dart roll fa4379946109467c8a48f20f19d83d7c72968a3e...d45c3d15cb3cea0104a87697c085259666eec528 (cla: yes)

[13762](https://github.com/flutter/engine/pull/13762) Turn on RasterCache based on view hierarchy (cla: yes)

[13763](https://github.com/flutter/engine/pull/13763) Remove usage of fuchsia.modular.Clipboard. (cla: yes)

[13765](https://github.com/flutter/engine/pull/13765) Change wordBoundary to take dynamic temporarily (cla: yes)

[13767](https://github.com/flutter/engine/pull/13767) reland add lifecycle enum (cla: yes)

[13768](https://github.com/flutter/engine/pull/13768) Add ImageFilter and BackdropFilter to CanvasKit backend (cla: yes)

[13769](https://github.com/flutter/engine/pull/13769) [web] Implement TextStyle.shadows (cla: yes)

[13772](https://github.com/flutter/engine/pull/13772) Move Path and PathMetrics from canvas.dart into their own files. No delta (cla: yes)

[13779](https://github.com/flutter/engine/pull/13779) [web] Fix path to svg for drrect (cla: yes)

[13780](https://github.com/flutter/engine/pull/13780) Allow passing hot reload debugging flags through (cla: yes)

[13781](https://github.com/flutter/engine/pull/13781) Create a WeakPtrFactory for use on the UI thread in VsyncWaiter (cla: yes)

[13782](https://github.com/flutter/engine/pull/13782) Document the coordinate space of points in FlutterPointerEvent. (cla: yes)

[13784](https://github.com/flutter/engine/pull/13784) Add Helvetica and sans-serif as fallback font families (cla: yes)

[13785](https://github.com/flutter/engine/pull/13785) Fix RendererContextSwitch result check in Rasterizer::MakeRasterSnapshot (cla: yes)

[13786](https://github.com/flutter/engine/pull/13786) Take devicePixelRatio into account when drawing shadows (cla: yes)

[13788](https://github.com/flutter/engine/pull/13788) Revert "Guarding EAGLContext used by Flutter #13314" (cla: yes)

[13789](https://github.com/flutter/engine/pull/13789) add recent packages to javadoc list (cla: yes, waiting for tree to go green)

[13795](https://github.com/flutter/engine/pull/13795) Adds missing comma in EngineParagraphStyle.toString() (cla: yes)

[13796](https://github.com/flutter/engine/pull/13796) implement radial gradient in canvaskit backend (cla: yes)

[13799](https://github.com/flutter/engine/pull/13799) Update version of dart/language_model distributed with flutter engine to latest (cla: yes)

[13802](https://github.com/flutter/engine/pull/13802) [web] Fix selectable text rendering (cla: yes)

[13803](https://github.com/flutter/engine/pull/13803) [build] Make --engine-version flag optional (CQ+1, cla: yes)

[13805](https://github.com/flutter/engine/pull/13805) Remove extra shadows from ParagraphStyle (cla: yes)

[13809](https://github.com/flutter/engine/pull/13809) [web] Fix blendmode for images (cla: yes)

[13812](https://github.com/flutter/engine/pull/13812) RendererContextSwitch guard flutter's gl context rework. (CQ+1, cla: yes)

[13828](https://github.com/flutter/engine/pull/13828) Revert "Roll src/third_party/skia d860a78fd60c..581108137b46 (13 comm… (cla: yes)

[13829](https://github.com/flutter/engine/pull/13829) [dart_runner] Initialize logging and tracing (cla: yes)

[13832](https://github.com/flutter/engine/pull/13832) Remove unused import (cla: yes)

[13837](https://github.com/flutter/engine/pull/13837) Roll buildroot to 0fec442d067a0998352ea12706fcae0a53b62884. (cla: yes)

[13842](https://github.com/flutter/engine/pull/13842) Disable LTO on Fuchsia (cla: yes)

[13847](https://github.com/flutter/engine/pull/13847) Avoid GL calls when compiling for Fuchsia. (cla: yes)

[13848](https://github.com/flutter/engine/pull/13848) Use Skia's matchStyleCSS3 to find bundled asset typefaces matching a font style (cla: yes)

[13850](https://github.com/flutter/engine/pull/13850) Fix test to account for pixel ratio transformations being framework responsibility. (cla: yes)

[13851](https://github.com/flutter/engine/pull/13851) Implement the rest of ui.Path methods for CanvasKit (cla: yes)

[13852](https://github.com/flutter/engine/pull/13852) Do not default to downstream affinity on iOS insertText (cla: yes)

[13855](https://github.com/flutter/engine/pull/13855) Add support for --dart-flags in FlutterShellArgs. (#44855) (cla: yes)

[13857](https://github.com/flutter/engine/pull/13857) Guard against orphaned semantic objects from referencing dead accessibility bridge on iOS (accessibility, cla: yes)

[13860](https://github.com/flutter/engine/pull/13860) [web] Change canvas sibling transforms to 3d with z=0 to get around canvas rendering bug. (cla: yes)

[13864](https://github.com/flutter/engine/pull/13864) [flow][fuchsia] Add more tracing to layers and Fuchsia surface pool (cla: yes)

[13865](https://github.com/flutter/engine/pull/13865) [fuchsia] Package flutter_frontend_server snapshot for fuchsia (cla: yes)

[13869](https://github.com/flutter/engine/pull/13869) Changing test runner and platform to be browser independent (cla: yes)

[13881](https://github.com/flutter/engine/pull/13881) Change edge conditions of getLineBoundary (cla: yes)

[13885](https://github.com/flutter/engine/pull/13885) Work around Fuchsia a11y / ICU name conflict (cla: yes)

[13901](https://github.com/flutter/engine/pull/13901) [web] Fix single line bitmap canvas text shadow (cla: yes)

[13902](https://github.com/flutter/engine/pull/13902) Adding opacity -> alpha method to Color class (affects: framework, cla: yes)

[13903](https://github.com/flutter/engine/pull/13903) Implement basic text rendering support in CanvasKit backend (cla: yes)

[13904](https://github.com/flutter/engine/pull/13904) Fix withIn matcher distance function lookup (cla: yes)

[13906](https://github.com/flutter/engine/pull/13906) Revert "RendererContextSwitch guard flutter's gl context rework." (cla: yes)

[13907](https://github.com/flutter/engine/pull/13907) allow ignoring toString, hashCode, and == in api_conform_test (cla: yes)

[13908](https://github.com/flutter/engine/pull/13908) Made a way to turn off the OpenGL operations on the IO thread for backgrounded apps (cla: yes)

[13909](https://github.com/flutter/engine/pull/13909) [web] Implement PathMetrics.length (cla: yes)

[13910](https://github.com/flutter/engine/pull/13910) Roll buildroot to a985f7f63ac. (cla: yes)

[13918](https://github.com/flutter/engine/pull/13918) Add virtual destructor to GPUSurfaceSoftwareDelegate. (cla: yes)

[13922](https://github.com/flutter/engine/pull/13922) [web] Flutter for web autocorrect support (cla: yes, platform-web, waiting for tree to go green)

[13923](https://github.com/flutter/engine/pull/13923) Roll Skia to e678b79c489d (2 commits) (cla: yes)

[13925](https://github.com/flutter/engine/pull/13925) [shell][fuchsia] Migrate away from deprecated async loop configs (CQ+1, cla: yes)

[13926](https://github.com/flutter/engine/pull/13926) Add dev_compiler and frontend_server to package uploading rule (cla: yes)

[13928](https://github.com/flutter/engine/pull/13928) Roll Skia to e678b79c489d (cla: yes)

[13929](https://github.com/flutter/engine/pull/13929) [web] Allow users to enable canvas text measurement (cla: yes, platform-web)

[13932](https://github.com/flutter/engine/pull/13932) Removed GET_ACTIVITIES flag from all manifest meta-data lookups. (#38891) (cla: yes)

[13934](https://github.com/flutter/engine/pull/13934) Ensure we use the base CompositorContext's AcquireFrame method when screenshotting (CQ+1, cla: yes)

[13940](https://github.com/flutter/engine/pull/13940) [web] Fix Edge detection for correct dom_renderer reset (cla: yes)

[13943](https://github.com/flutter/engine/pull/13943) Made the thread checker print out the thread names on Apple platforms. (cla: yes)

[13945](https://github.com/flutter/engine/pull/13945) Update SwiftShader to 5d1e854. (cla: yes)

[13947](https://github.com/flutter/engine/pull/13947) [flutter_runner] fix a11y tests (cla: yes)

[13960](https://github.com/flutter/engine/pull/13960) [web] Fix default line-height issue for Firefox (cla: yes)

[13962](https://github.com/flutter/engine/pull/13962) Added auto-reviewer config file (cla: yes)

[13963](https://github.com/flutter/engine/pull/13963) Remove the strace debug logging from the Fuchsia gen_package script (cla: yes)

[13971](https://github.com/flutter/engine/pull/13971) [fuchsia] Ensure we do not initialize nan RoundedRectangles (cla: yes)

[13975](https://github.com/flutter/engine/pull/13975) Refactor to passing functions by const ref (CQ+1, cla: yes)

[13980](https://github.com/flutter/engine/pull/13980) Updated googletest to fix fuchsia build. (CQ+1, cla: yes)

[13981](https://github.com/flutter/engine/pull/13981) [web] use Element.nodes instead of Element.children in text layout (cla: yes, platform-web)

[13989](https://github.com/flutter/engine/pull/13989) [fuchsia] Capture SkRRect in scene_update_context by value (cla: yes)

[13990](https://github.com/flutter/engine/pull/13990) Setup a Metal test surface and add a new unit-test target that tests the testing utilities. (cla: yes)

## PRs closed in this release of flutter/plugins

From Sun Aug 19 17:37:00 2019 -0700 to Mon Nov 25 12:05:00 2019 -0800


[1370](https://github.com/flutter/plugins/pull/1370) [camera] Pause/resume video recording for Android & iOS (cla: yes, feature)

[1702](https://github.com/flutter/plugins/pull/1702) [google_maps_flutter]Marker drag event (cla: yes, in review)

[1767](https://github.com/flutter/plugins/pull/1767) [google_maps_flutter] Adds support for displaying the traffic layer (cla: yes, in review)

[1784](https://github.com/flutter/plugins/pull/1784) [google_maps_flutter] Allow (de-)serialization of CameraPosition (cla: yes, in review, submit queue)

[1813](https://github.com/flutter/plugins/pull/1813) [video-player] add support for content uris as urls (cla: yes, in review)

[1866](https://github.com/flutter/plugins/pull/1866) [instrumentation_adapter] enable Firebase Test Lab Android testing (cla: yes)

[1933](https://github.com/flutter/plugins/pull/1933) [google_maps_flutter] Avoid unnecessary redraws (cla: yes, in review)

[1953](https://github.com/flutter/plugins/pull/1953) [path_provider] add getApplicationLibraryDirectory (cla: yes)

[1984](https://github.com/flutter/plugins/pull/1984) Remove Flutterfire plugins (moved to FirebaseExtended) (cla: yes)

[1985](https://github.com/flutter/plugins/pull/1985) [android_alarm_manager] Added ability to get id in the callback (cla: yes)

[1990](https://github.com/flutter/plugins/pull/1990) [path_provider] Add missing tests (backlog, cla: yes)

[1993](https://github.com/flutter/plugins/pull/1993) [pathprovider] Fix fall through bug (cla: yes)

[1996](https://github.com/flutter/plugins/pull/1996) [webview_flutter] Allow underscores anywhere for Javascript Channel name (cla: yes)

[1998](https://github.com/flutter/plugins/pull/1998) [video_player] Fix deprecated member use (cla: yes)

[1999](https://github.com/flutter/plugins/pull/1999) [Connectivity] add a method to request location on iOS (for iOS 13) (cla: yes)

[2000](https://github.com/flutter/plugins/pull/2000) [android_intent] add flags option (cla: yes, submit queue)

[2003](https://github.com/flutter/plugins/pull/2003) [video_player] Added `formatHint` to to override video format on Android (cla: yes)

[2004](https://github.com/flutter/plugins/pull/2004) [cirrus] Use flutter create for all_plugins test (cla: yes)

[2005](https://github.com/flutter/plugins/pull/2005) Add explicit initialization of TestWidgets binding to all breaking unit tests (cla: yes)

[2009](https://github.com/flutter/plugins/pull/2009) Fix unit test for sensors (cla: yes)

[2010](https://github.com/flutter/plugins/pull/2010) [Image_picker] fix `retrieveImage` breakage, added tests. (cla: yes)

[2014](https://github.com/flutter/plugins/pull/2014) [In_App_Purchase] Avoids possible NullPointerException with background registrations. (cla: yes, submit queue)

[2015](https://github.com/flutter/plugins/pull/2015) [google_sign_in] Use implementation rather than api dependencies for plugin third-party dependencies. (cla: yes)

[2016](https://github.com/flutter/plugins/pull/2016) [In_App_Purchase] Improve testability (cla: yes, in review)

[2022](https://github.com/flutter/plugins/pull/2022) [instrumentation_adapter] Update README instructions (cla: yes)

[2023](https://github.com/flutter/plugins/pull/2023) [instrumentation_adapter] update boilerplate to use @Rule instead of FlutterTest (cla: yes)

[2024](https://github.com/flutter/plugins/pull/2024) [instrumentation_adapter] update CODEOWNERS (cla: yes)

[2027](https://github.com/flutter/plugins/pull/2027) [in_app_purchase] Remove skipped driver test (cla: yes)

[2028](https://github.com/flutter/plugins/pull/2028) [instrumentation_adapter] Update documentation about using androidx (cla: yes)

[2029](https://github.com/flutter/plugins/pull/2029) fix android crash when pausing or resuming video on APIs lower than 24. (cla: yes, in review)

[2036](https://github.com/flutter/plugins/pull/2036) video player version fix (cla: yes)

[2038](https://github.com/flutter/plugins/pull/2038) [url_launcher] Removed reference to rootViewController during initialization (cla: yes, in review, waiting for test harness)

[2045](https://github.com/flutter/plugins/pull/2045) [android_intent] Add action_application_details_settings (cla: yes, submit queue)

[2047](https://github.com/flutter/plugins/pull/2047) [local_auth] Avoid user confirmation on face unlock (cla: yes, submit queue, waiting for test harness)

[2049](https://github.com/flutter/plugins/pull/2049) [path_provider] Android: Support multiple external storage options (cla: yes, in review)

[2050](https://github.com/flutter/plugins/pull/2050) [instrumentation_adapter] Add support for running tests with Flutter driver (cla: yes)

[2051](https://github.com/flutter/plugins/pull/2051) [instrumentation_adapter] update for release (cla: yes)

[2052](https://github.com/flutter/plugins/pull/2052) [instrumentation_adapter] Add stub iOS implementation and example app (cla: yes)

[2053](https://github.com/flutter/plugins/pull/2053) [google_maps_flutter] Fix analyzer failures relating to prefer_const_constructors (cla: yes)

[2055](https://github.com/flutter/plugins/pull/2055) Point opensource site at new location (cla: yes)

[2056](https://github.com/flutter/plugins/pull/2056) Reland "[webview_flutter] Add a getTitle method to WebViewController"… (cla: yes)

[2057](https://github.com/flutter/plugins/pull/2057) [Camera] Fixes NullPointerException (cla: yes, submit queue, waiting for test harness)

[2059](https://github.com/flutter/plugins/pull/2059) [google_sign_in] Fix chained async methods in error handling zones (cla: yes)

[2065](https://github.com/flutter/plugins/pull/2065) [google_maps_flutter] Prefer const constructors. (cla: yes)

[2068](https://github.com/flutter/plugins/pull/2068) [google_maps_flutter] Fix iOS MyLocationButton on iOS (cla: yes)

[2070](https://github.com/flutter/plugins/pull/2070) [image_picker] swap width and height when source image orientation is left or right (cla: yes, in review)

[2075](https://github.com/flutter/plugins/pull/2075) [instrumentation_adapter] Migrate example to AndroidX (cla: yes)

[2076](https://github.com/flutter/plugins/pull/2076) [google_maps_flutter] Clone cached elements in GoogleMap (cla: yes)

[2083](https://github.com/flutter/plugins/pull/2083) [image_picker] Fix a crash when picking video on iOS 13 and above. (cla: yes, in review)

[2084](https://github.com/flutter/plugins/pull/2084) [update] local_auth - intl version (cla: yes)

[2087](https://github.com/flutter/plugins/pull/2087) [android_alarm_manager] Update and migrate iOS example project (cla: yes)

[2088](https://github.com/flutter/plugins/pull/2088) [android_intent] Update and migrate iOS example project (cla: yes)

[2089](https://github.com/flutter/plugins/pull/2089) [battery] Update and migrate iOS example project (cla: yes)

[2090](https://github.com/flutter/plugins/pull/2090) [camera] Update and migrate iOS example project (cla: yes, submit queue)

[2091](https://github.com/flutter/plugins/pull/2091) [connectivity] Update and migrate iOS example project (cla: yes)

[2092](https://github.com/flutter/plugins/pull/2092) [device_info] Update and migrate iOS example project (cla: yes)

[2093](https://github.com/flutter/plugins/pull/2093) [google_maps_flutter] Update and migrate iOS example project (cla: yes)

[2094](https://github.com/flutter/plugins/pull/2094) [google_sign_in]  Update and migrate iOS example project (cla: yes)

[2095](https://github.com/flutter/plugins/pull/2095) [image_picker] Update and migrate iOS example project (cla: yes)

[2096](https://github.com/flutter/plugins/pull/2096) [in_app_purchase] Update and migrate iOS example project (cla: yes, submit queue)

[2097](https://github.com/flutter/plugins/pull/2097) [local_auth] Update and migrate iOS example project (cla: yes)

[2098](https://github.com/flutter/plugins/pull/2098) [package_info] Update and migrate iOS example project (cla: yes)

[2099](https://github.com/flutter/plugins/pull/2099) [path_provider] Update and migrate iOS example project (cla: yes)

[2100](https://github.com/flutter/plugins/pull/2100) [quick_actions] Update and migrate iOS example project (cla: yes)

[2101](https://github.com/flutter/plugins/pull/2101) [sensors] Update and migrate iOS example project (cla: yes)

[2102](https://github.com/flutter/plugins/pull/2102) [share] Update and migrate iOS example project (cla: yes)

[2103](https://github.com/flutter/plugins/pull/2103) [shared_preferences] Update and migrate iOS example project (cla: yes)

[2108](https://github.com/flutter/plugins/pull/2108) [google_maps_flutter] Add Projection methods to google_maps (cla: yes)

[2109](https://github.com/flutter/plugins/pull/2109) [url_launcher] Update and migrate iOS example project (cla: yes, submit queue)

[2110](https://github.com/flutter/plugins/pull/2110) [video_player] Update and migrate iOS example project (cla: yes)

[2111](https://github.com/flutter/plugins/pull/2111) [local_auth] Api to stop authentication (cla: yes)

[2112](https://github.com/flutter/plugins/pull/2112) Run flutter_plugin_tools format (cla: yes)

[2113](https://github.com/flutter/plugins/pull/2113) [google_maps_flutter] Avoid AbstractMethod crash (cla: yes)

[2115](https://github.com/flutter/plugins/pull/2115) [camera] Define clang modules in for iOS (cla: yes)

[2119](https://github.com/flutter/plugins/pull/2119) Add web url launcher (cla: yes)

[2120](https://github.com/flutter/plugins/pull/2120) [image_picker] fix crash when aar from 'flutter build aar' (cla: yes, in review)

[2123](https://github.com/flutter/plugins/pull/2123) [camera] Fix event type check (cla: yes)

[2124](https://github.com/flutter/plugins/pull/2124) [video_player] Move [player dispose] to `onUnregistered` (cla: yes)

[2125](https://github.com/flutter/plugins/pull/2125) [in_app_purchase] Define clang module for iOS (cla: yes)

[2127](https://github.com/flutter/plugins/pull/2127) [google_sign_in] Fix deprecated API usage issue by upgrading CocoaPod to 5.0 (cla: yes, submit queue)

[2128](https://github.com/flutter/plugins/pull/2128) [image_picker] Define clang module for iOS (cla: yes)

[2131](https://github.com/flutter/plugins/pull/2131) [share]fix iOS crash when setting the subject to null (cla: yes)

[2135](https://github.com/flutter/plugins/pull/2135) [android_alarm_manager] Define clang module for iOS (cla: yes)

[2136](https://github.com/flutter/plugins/pull/2136) [url_launcher_web] Fix README.md pubspec example (cla: yes)

[2137](https://github.com/flutter/plugins/pull/2137) [connectivity] Define clang module for iOS (cla: yes)

[2138](https://github.com/flutter/plugins/pull/2138) [device_info] Define clang module for iOS (cla: yes)

[2139](https://github.com/flutter/plugins/pull/2139) [google_maps_flutter] Add NonNull macro to reduce warnings in iOS (cla: yes)

[2141](https://github.com/flutter/plugins/pull/2141) BugFix: `formatHint` was meant for network streams. (cla: yes)

[2142](https://github.com/flutter/plugins/pull/2142) [Connectivity] migrate to the new android embedding (cla: yes)

[2143](https://github.com/flutter/plugins/pull/2143) [android_intent] Migrate to the new embedding (cla: yes)

[2144](https://github.com/flutter/plugins/pull/2144) [android_intent] Define clang module for iOS (cla: yes)

[2145](https://github.com/flutter/plugins/pull/2145) [instrumentation_adapter] Define clang module for iOS (cla: yes)

[2146](https://github.com/flutter/plugins/pull/2146) [local_auth] Define clang module for iOS (cla: yes)

[2147](https://github.com/flutter/plugins/pull/2147) [path_provider] Define clang module for iOS (cla: yes)

[2148](https://github.com/flutter/plugins/pull/2148) [package_info] Define clang module for iOS (cla: yes)

[2149](https://github.com/flutter/plugins/pull/2149) [quick_actions] Define clang module for iOS (cla: yes)

[2152](https://github.com/flutter/plugins/pull/2152) [battery] Support the v2 Android embedder (cla: yes)

[2154](https://github.com/flutter/plugins/pull/2154) Use stable Flutter image as base (cla: yes)

[2155](https://github.com/flutter/plugins/pull/2155) [in_app_purchase] migrate to the v2 android embedding (cla: yes)

[2156](https://github.com/flutter/plugins/pull/2156) [Share] Support v2 android embedder. (cla: yes)

[2157](https://github.com/flutter/plugins/pull/2157) [url_launcher] Migrate to the new embedding (cla: yes)

[2158](https://github.com/flutter/plugins/pull/2158) [video_player] Basic test for VideoPlayerController initialization (cla: yes)

[2160](https://github.com/flutter/plugins/pull/2160) [package_info] Support the v2 Android embedder (with e2e tests) (cla: yes)

[2161](https://github.com/flutter/plugins/pull/2161) Rename instrumentation_adapter plugin to e2e plugin (cla: yes)

[2162](https://github.com/flutter/plugins/pull/2162) [shared_preferences] Support v2 android embedder. (cla: yes)

[2163](https://github.com/flutter/plugins/pull/2163) [device_info]  Support v2 android embedder. (cla: yes)

[2164](https://github.com/flutter/plugins/pull/2164) [sensor] Support v2 android embedder. (cla: yes)

[2165](https://github.com/flutter/plugins/pull/2165) [camera] Migrate to the new embedding (cla: yes)

[2167](https://github.com/flutter/plugins/pull/2167) [quick_actions] Support v2 android embedder. (cla: yes)

[2168](https://github.com/flutter/plugins/pull/2168) Add plugin for Android lifecycle in embedding (cla: yes)

[2169](https://github.com/flutter/plugins/pull/2169) [flutter_webview] Migrate to the new embedding (cla: yes)

[2174](https://github.com/flutter/plugins/pull/2174) [url_launcher] Enable androidx and jetifier in android gradle properties (cla: yes)

[2175](https://github.com/flutter/plugins/pull/2175) [sensors] Define clang module for iOS (cla: yes)

[2176](https://github.com/flutter/plugins/pull/2176) [shared_preferences] Define clang module for iOS (cla: yes)

[2177](https://github.com/flutter/plugins/pull/2177) [url_launcher] Define clang module for iOS (cla: yes)

[2178](https://github.com/flutter/plugins/pull/2178) [e2e] update README (cla: yes)

[2179](https://github.com/flutter/plugins/pull/2179) [battery] Define clang module for iOS (cla: yes)

[2180](https://github.com/flutter/plugins/pull/2180) [share] Define clang module for iOS (cla: yes)

[2182](https://github.com/flutter/plugins/pull/2182) [google_maps_flutter] Define clang module for iOS, fix analyzer warnings (cla: yes)

[2183](https://github.com/flutter/plugins/pull/2183) [video_player] Define clang module for iOS (cla: yes)

[2184](https://github.com/flutter/plugins/pull/2184) [google_sign_in] Define clang module for iOS (cla: yes)

[2185](https://github.com/flutter/plugins/pull/2185) [webview_flutter] Define clang module for iOS (cla: yes)

[2186](https://github.com/flutter/plugins/pull/2186) Run clang analyzer on iOS and macOS code in CI test when packages change (cla: yes)

[2188](https://github.com/flutter/plugins/pull/2188) [android_intent] Bump the Flutter SDK min version (cla: yes)

[2189](https://github.com/flutter/plugins/pull/2189) [battery] relax the example app minimal required Flutter version  (cla: yes)

[2190](https://github.com/flutter/plugins/pull/2190) [e2e] Update to support new embedder (cla: yes)

[2191](https://github.com/flutter/plugins/pull/2191) [image_picker] Fix iOS build and analyzer warnings (cla: yes)

[2192](https://github.com/flutter/plugins/pull/2192) [in_app_purchase] Fix iOS build warning (cla: yes)

[2194](https://github.com/flutter/plugins/pull/2194) [battery] add e2e dependency to the example app (cla: yes)

[2195](https://github.com/flutter/plugins/pull/2195) [android_intent] Cleanup the V2 migration (cla: yes)

[2196](https://github.com/flutter/plugins/pull/2196) [webview_flutter] (Trivial) Add V2 warnings (cla: yes)

[2197](https://github.com/flutter/plugins/pull/2197) Enable testing on both master and stable (cla: yes)

[2199](https://github.com/flutter/plugins/pull/2199) Revert "Enable testing on both master and stable (#2197)" (cla: yes)

[2200](https://github.com/flutter/plugins/pull/2200) [flutter_webview] Revert v2 embedder support (cla: yes)

[2201](https://github.com/flutter/plugins/pull/2201) [url_launcher] Revert embedding support (cla: yes)

[2202](https://github.com/flutter/plugins/pull/2202) [android_intent] componentName must be provided before resolveActivity is called (cla: yes, waiting for test harness)

[2203](https://github.com/flutter/plugins/pull/2203) Re-land testing of plugins on stable (cla: yes)

[2204](https://github.com/flutter/plugins/pull/2204) [url_launcher] Re-land v2 embedding support (cla: yes)

[2205](https://github.com/flutter/plugins/pull/2205) s/flutter_android_lifecycle/flutter_plugin_android_lifecycle/ (cla: yes)

[2206](https://github.com/flutter/plugins/pull/2206) [flutter_plugin_android_lifecycle] Update README with new plugin name (cla: yes)

[2207](https://github.com/flutter/plugins/pull/2207) [flutter_plugin_android_lifecycle] bump e2e depenency to 0.2.1 (cla: yes)

[2208](https://github.com/flutter/plugins/pull/2208) delete all example/android/app/gradle.properties files (cla: yes)

[2209](https://github.com/flutter/plugins/pull/2209) [webview_flutter] Re-land support v2 embedding support (cla: yes)

[2211](https://github.com/flutter/plugins/pull/2211) Ensure that when testing on stable Cirrus is upgraded to latest on iOS (cla: yes)

[2212](https://github.com/flutter/plugins/pull/2212) [connectivity]remove AndroidX constraint (cla: yes)

[2215](https://github.com/flutter/plugins/pull/2215) [in_app_purchase] remove AndroidX constraint (cla: yes)

[2216](https://github.com/flutter/plugins/pull/2216) [battery]Use android.arch.lifecycle instead of androidx.lifecycle:lifecycle in (cla: yes)

[2217](https://github.com/flutter/plugins/pull/2217) [url_launcher] Add `url_launcher_platform_interface` package (cla: yes)

[2218](https://github.com/flutter/plugins/pull/2218) [package_info]remove AndroidX constraint (cla: yes)

[2219](https://github.com/flutter/plugins/pull/2219) [camera]remove androidx constraint (cla: yes)

[2220](https://github.com/flutter/plugins/pull/2220) [url_launcher]remove AndroidX constraint (cla: yes)

[2221](https://github.com/flutter/plugins/pull/2221) [android_intent]remove AndroidX constraint (cla: yes)

[2222](https://github.com/flutter/plugins/pull/2222) Fix testing instructions in CONTRIBUTING.md (cla: yes)

[2223](https://github.com/flutter/plugins/pull/2223) [flutter_plugin_android_lifecycle] register the e2e plugin in the example app (cla: yes)

[2226](https://github.com/flutter/plugins/pull/2226) [video_player] Add v2 embedding support (cla: yes)

[2228](https://github.com/flutter/plugins/pull/2228) [url_launcher] Use `url_launcher_platform_interface` to handle calls (cla: yes)

[2230](https://github.com/flutter/plugins/pull/2230) Forbid `... implements UrlLauncherPlatform` (cla: yes)

[2231](https://github.com/flutter/plugins/pull/2231) [cleanup] Remove AndroidX warning (cla: yes)

[2232](https://github.com/flutter/plugins/pull/2232) [multiple] V2 embedding plugins use compileOnly (cla: yes)

[2233](https://github.com/flutter/plugins/pull/2233) [e2e] update README (cla: yes)

[2236](https://github.com/flutter/plugins/pull/2236) Use package import to import files inside lib/ directory. (cla: yes)

[2237](https://github.com/flutter/plugins/pull/2237) [url_launcher] Migrate url_launcher_web to the platform interface (cla: yes)

[2239](https://github.com/flutter/plugins/pull/2239) [camera] Android: Improve image streaming by creating a request suita… (cla: yes, waiting for test harness)

[2241](https://github.com/flutter/plugins/pull/2241) [Shared_preferences]suppress warnings (cla: yes)

[2242](https://github.com/flutter/plugins/pull/2242) [google_maps_flutter] Cast error.code to unsigned long to avoid using NSInteger as %ld format warnings. (cla: yes, submit queue)

[2243](https://github.com/flutter/plugins/pull/2243) [flutter_plugin_android_lifecycle] Adapt the FlutterLifecycleAdapter to the new embedding API (cla: yes)

[2244](https://github.com/flutter/plugins/pull/2244) [google_sign_in] Move plugin to its subdir to allow for federated implementations (cla: yes)

[2250](https://github.com/flutter/plugins/pull/2250) Run the publish with the pub version from flutter stable (cla: yes)

[2252](https://github.com/flutter/plugins/pull/2252) [google_sign_in] Handle new style URLs in GoogleUserCircleAvatar (cla: yes)

[2257](https://github.com/flutter/plugins/pull/2257) [webview_flutter] Add async NavigationDelegates (cla: yes)

[2260](https://github.com/flutter/plugins/pull/2260) Make setMockInitialValues handle non-prefixed keys (cla: yes)

[2261](https://github.com/flutter/plugins/pull/2261) [image_picker] more documentations and tests. (cla: yes)

[2262](https://github.com/flutter/plugins/pull/2262) [connectivity] add more documentations, delete example/README (cla: yes)

[2266](https://github.com/flutter/plugins/pull/2266) [google_sign_in] Port plugin to use the federated Platform Interface (cla: yes)

[2267](https://github.com/flutter/plugins/pull/2267) Bump google_maps_flutter pubspec version to match CHANGELOG (cla: yes)

[2268](https://github.com/flutter/plugins/pull/2268) [android_intent] Add missing DartDocs (cla: yes)

[2269](https://github.com/flutter/plugins/pull/2269) [connectivity] Lint for public DartDocs (cla: yes)

[2270](https://github.com/flutter/plugins/pull/2270) [image_picker] Lint for public DartDocs (cla: yes)

[2271](https://github.com/flutter/plugins/pull/2271) [infra] Ignore analyzer issues in CI (cla: yes)

[2272](https://github.com/flutter/plugins/pull/2272) [sensors] Documentation and test improvements (cla: yes)

[2273](https://github.com/flutter/plugins/pull/2273) [video_player] Add platform interface (cla: yes)

[2274](https://github.com/flutter/plugins/pull/2274) [url_launcher] DartDoc and test improvements (cla: yes)

[2275](https://github.com/flutter/plugins/pull/2275) Update cirrus to create IOS simulator on 13.2 an xCode 11 (cla: yes)

[2280](https://github.com/flutter/plugins/pull/2280) Add google_sign_in_web plugin. (cla: yes)

[2281](https://github.com/flutter/plugins/pull/2281) [connectivity] Fix reachability stream for iOS (cla: yes)

[2282](https://github.com/flutter/plugins/pull/2282) Migrate plugins to use e2e tests. (cla: yes)

[2284](https://github.com/flutter/plugins/pull/2284) [path_provider] Add v2 embedding support for (cla: yes)

[2286](https://github.com/flutter/plugins/pull/2286) [video_player] Improve DartDocs and test coverage (cla: yes)

[2288](https://github.com/flutter/plugins/pull/2288) [path_provider] Add missing DartDocs (cla: yes)

[2289](https://github.com/flutter/plugins/pull/2289) [url_launcher] Update deps and docs in url_launcher_web (cla: yes)

[2292](https://github.com/flutter/plugins/pull/2292) Update CONTRIBUTING.md to allow mockito (cla: yes)

[2293](https://github.com/flutter/plugins/pull/2293) [image_picker]fix a crash when a non-image file is picked. (cla: yes)

[2296](https://github.com/flutter/plugins/pull/2296) [shared_preferences] Add missing DartDoc (cla: yes)

[2297](https://github.com/flutter/plugins/pull/2297) [share] README update (cla: yes)

