---
title: Flutter 1.12.13 release notes
short-title: 1.12.13 release notes
description: Release notes for Flutter 1.12.13.
---

Welcome to Flutter 1.12, our biggest stable release so far!
In this release, we’ve merged 1,905 Pull Requests
from 188 contributors, including both Googlers and
non-Google contributors! Please see the chart below
for the number of PRs in each release. Over the past year,
the number of PRs has been growing in each release
(except for Flutter 1.9, which was an out-of-band
release to support Catalina). In the recent
[GitHub Octoverse report][],
Flutter is listed as one of the top 3 active repos on GitHub!

As the holiday season is upon us, we would like to express
our sincerest appreciation to our amazing developer community
who believe in Flutter, advocate for Flutter, and contribute to Flutter.
It’s been an incredible year for us all! We look forward to
working with you in the years to come.

As always, you can find interesting PRs listed below.
And there are lots of interesting things to mention in this
release, including:

*   Some breaking API changes
*   Some severe issues caught and fixed
*   Web support is now available in the beta channel
*   MacOS support is enabled in the dev channel as of 1.13
*   Improved SDK to add Flutter to existing Android/iOS apps
*   iOS 13 visual refresh including the support for iOS Dark mode
*   Enhanced tooling experiences
*   New widgets and features
*   And more!


## Breaking changes

In general, we want to avoid introducing breaking changes to Flutter,
our plugins, or our packages. However, sometimes it is inevitable
when we need to make our APIs more intuitive.
We have implemented a new process that invites you to submit
tests to help us detect breaking changes.
For more information, see [this post from Ian Hickson][]
on [flutter-announce][] and the
[breaking change policy on the Flutter wiki][].

The following list includes breaking changes in this release.
Please see the related announcements so that you can move
forward with your code.

[37024](https://github.com/flutter/flutter/pull/37024) [Implement PageView using SliverLayoutBuilder, Deprecate RenderSliverFillViewport](https://groups.google.com/g/flutter-announce/c/1CUo2GCjrD4/m/VGKsyVirFQAJ)

[37739](https://github.com/flutter/flutter/pull/37739) [Fix AnimationStatus for repeat(reverse: true) and animateWith](https://groups.google.com/g/flutter-announce/c/yYqqt4Z5IIo/m/3wRYBwSQEwAJ)

[37896](https://github.com/flutter/flutter/pull/37896) [Add opacity control to MouseRegion. Add findAnnotations to Layer.](https://groups.google.com/g/flutter-announce/c/GHSNLpjzmPw/m/ozNXwdbHDwAJ)

[38481](https://github.com/flutter/flutter/pull/38481) [Timer picker fidelity revision](https://groups.google.com/g/flutter-announce/c/cSwtxCpWWEU/m/LtZS9g6eAgAJ)

[38568](https://github.com/flutter/flutter/pull/38568) [Normalize assert checking of clipBehavior](https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!searchin/flutter-announce/clipBehavior%7Csort:date/flutter-announce/VJaYV9R9usU/_mV1GV25DwAJ)

[39079](https://github.com/flutter/flutter/pull/39079) [fix widget built twice during warm up frame](https://groups.google.com/g/flutter-announce/c/m6ewfoO64mI/m/ziD4VmwUBQAJ)

[39440](https://github.com/flutter/flutter/pull/39440) [Allow gaps in the initial route](https://groups.google.com/g/flutter-announce/c/ysFSO3eScbs/m/GzPFkLuvAQAJ)

[39919](https://github.com/flutter/flutter/pull/39919) [CupertinoDatePicker & CupertinoTimerPicker dark mode](https://groups.google.com/g/flutter-announce/c/0DAdg-k_jDw/m/DUGLDQagAAAJ)

[40166](https://github.com/flutter/flutter/pull/40166) [Added proper focus handling when pushing and popping routes](https://groups.google.com/g/flutter-announce/c/BjPKnOw5jzU/m/Ev-gUJ_VAwAJ)

[40179](https://github.com/flutter/flutter/pull/40179) [Update PopupMenu layout](https://groups.google.com/g/flutter-announce/c/UlK3y9HWyBg/m/Dybr660DAAAJ)

[40566](https://github.com/flutter/flutter/pull/40566) [Remove CupertinoSystemColors in favor of CupertinoColors](https://groups.google.com/g/flutter-announce/c/pMYPTvjWCX4/m/UiocKCk0AQAJ)

[40690](https://github.com/flutter/flutter/pull/40690) [CupertinoPageScaffold dark mode](https://groups.google.com/g/flutter-announce/c/r_2xpmKiLj4/m/-myr4ZRPAAAJ)

[41220](https://github.com/flutter/flutter/pull/41220) [Add an ActivateAction to controls that use InkWell.](https://groups.google.com/g/flutter-announce/c/oLsxPDDRc6s/m/oCtHP3ejAAAJ)

[41857 Change the dark theme elevation overlay to use the colorScheme.onSurface](https://github.com/flutter/flutter/pull/41857)

[42449](https://github.com/flutter/flutter/pull/42449) [Increase TextField's minimum height from 40 to 48](https://groups.google.com/g/flutter-announce/c/RDyeXZK0fO8/m/rdkBzgw4DgAJ)

[42470](https://github.com/flutter/flutter/pull/42470) [No multiline password fields](https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!msg/flutter-announce/Ken8TY_QiuY/qxJF2ugyBQAJ)

[42479](https://github.com/flutter/flutter/pull/42479) [Make DropdownButton's disabledHint and hint behavior consistent](https://groups.google.com/g/flutter-announce/c/yHIl-zEXm5c/m/abpgrXuHDgAJ)

[45135](https://github.com/flutter/flutter/pull/45135) [Add option to delay rendering the first frame](https://groups.google.com/g/flutter-announce/c/kBf4cXjD2y4/m/lg19fDnaAgAJ)


## Severe crash & performance bugs

In every stable release, we make an effort to improve the quality of Flutter. In 1.12, we fixed several severe issues; this includes the following  crashes and performance issues.

[40009](https://github.com/flutter/flutter/pull/40009) Add null check to _IndicatorPainter._tabOffsetsEqual() to prevent crash

[40263](https://github.com/flutter/flutter/pull/40263) Fix crash on vswhere search from flutter doctor

[40786](https://github.com/flutter/flutter/pull/40786) Fix crash on vswhere query on missing installations

[42342](https://github.com/flutter/flutter/pull/42342) Fix DropdownButton crash when hint and selectedItemBuilder are simultaneously defined

[44610](https://github.com/flutter/flutter/pull/44610) Error Message for createState assertion

[38814](https://github.com/flutter/flutter/pull/38814) Add iOS backdrop filter benchmarks

[38821](https://github.com/flutter/flutter/pull/38821) Cache caret parameters

[38861](https://github.com/flutter/flutter/pull/38861) Replace deprecated onReportTimings w/ frameTimings

[39439](https://github.com/flutter/flutter/pull/39439) Measure iOS CPU/GPU percentage

[43676](https://github.com/flutter/flutter/pull/43676) Allow multiple TimingsCallbacks

[45050](https://github.com/flutter/flutter/pull/45050) Add a perf test for picture raster cache


## New features

Flutter 1.12 introduces several new features including the
[SliverOpacity]({{site.api}}/flutter/widgets/SliverOpacity-class.html)
widget, the
[SliverAnimatedList]({{site.api}}/flutter/widgets/SliverAnimatedList-class.html),
and the ability to configure a stretch effect for a SliverAppBar.

[37416](https://github.com/flutter/flutter/pull/37416) Add MediaQuery.systemGestureInsets to support Android Q

[39857](https://github.com/flutter/flutter/pull/39857) Update ToggleButtons constraints default and add new constraints parameter

[40161](https://github.com/flutter/flutter/pull/40161) Add fullscreenDialog argument in PageRouteBuilder

[40461](https://github.com/flutter/flutter/pull/40461) Implement DropdownButton.selectedItemBuilder

[41415](https://github.com/flutter/flutter/pull/41415) Expose API for resizing image caches

[42250](https://github.com/flutter/flutter/pull/42250) SliverAppBar - Configurable overscroll stretch with callback feature & FlexibleSpaceBar support

[42485](https://github.com/flutter/flutter/pull/42485) Re-landing SliverAnimatedList.

[42842](https://github.com/flutter/flutter/pull/42842) Add "navigator" option to "showDialog" and "showGeneralDialog"

[43286](https://github.com/flutter/flutter/pull/43286) FadeInImage cacheWidth and cacheHeight support

[44289](https://github.com/flutter/flutter/pull/44289) SliverOpacity

[45127](https://github.com/flutter/flutter/pull/45127) SliverIgnorePointer

[45432](https://github.com/flutter/flutter/pull/45432) Use RenderSliverPadding to inset SliverFillViewport


## iOS support

iOS continues to be a big investment area for Flutter.
With this release, we’ve made a visual refresh to our
Cupertino library to match the iOS 13 look. We now support
dark mode in the Cupertino widgets, added two new widgets called
[CupertinoContextMenu]({{site.api}}/flutter/cupertino/CupertinoContextMenu-class.html)
and [CupertinoSlidingSegmentedControl]({{site.api}}/flutter/cupertino/CupertinoSlidingSegmentedControl-class.html),
and made improvements to segmented control widgets,
[CupertinoAlertDialog]({{site.api}}/flutter/cupertino/CupertinoAlertDialog-class.html),
and [CupertinoDatePicker]({{site.api}}/flutter/cupertino/CupertinoDatePicker-class.html)

[36871](https://github.com/flutter/flutter/pull/36871) Audit use of defaultTargetPlatform

[37719](https://github.com/flutter/flutter/pull/37719) CupertinoDynamicColor and friends

[38712](https://github.com/flutter/flutter/pull/38712) Show process error when iOS install fails

[39056](https://github.com/flutter/flutter/pull/39056) Fixed issues with Background Color #34741

[39215](https://github.com/flutter/flutter/pull/39215) CupertinoActionSheet dark mode & fidelity

[39289](https://github.com/flutter/flutter/pull/39289) CupertinoActivityIndicator & CupertinoApp dark mode

[39430](https://github.com/flutter/flutter/pull/39430) make CupertinoDynamicColor const constructible

[39463](https://github.com/flutter/flutter/pull/39463) Update validation to support Xcode11 version

[39585](https://github.com/flutter/flutter/pull/39585) remove fallback code for ios/usb artifacts

[39590](https://github.com/flutter/flutter/pull/39590) Fix user gesture in CupertinoPageRoute

[39765](https://github.com/flutter/flutter/pull/39765) CupertinoButton & Bottom tab bar dark mode

[39927](https://github.com/flutter/flutter/pull/39927) Make CupertinoDynamicColor.resolve return null when given a null color

[40007](https://github.com/flutter/flutter/pull/40007) CupertinoAlertDialog dark mode & CupertinoActionSheet fidelity

[40100](https://github.com/flutter/flutter/pull/40100) Fix a problem with disposing of focus nodes in tab scaffold

[40189](https://github.com/flutter/flutter/pull/40189) Dark mode CupertinoNavigationBar

[40447](https://github.com/flutter/flutter/pull/40447) Implement mdns for flutter run

[40454](https://github.com/flutter/flutter/pull/40454) Dark Mode R: Refresh Control

[40466](https://github.com/flutter/flutter/pull/40466) ModalRoutes ignore input when a (cupertino) pop transition is underway

[40864](https://github.com/flutter/flutter/pull/40864) Move iOS and Android gitignore rules into folders

[41326](https://github.com/flutter/flutter/pull/41326) Exception when selecting in TextField

[41355](https://github.com/flutter/flutter/pull/41355) fix bad indentations(mainly around collection literals)

[41384](https://github.com/flutter/flutter/pull/41384) [flutter_tools] Report iOS mDNS lookup failures to analytics

[41431](https://github.com/flutter/flutter/pull/41431) Cupertino { TabScafold, TextSelection, TextField } dark mode & minor fidelity update

[41473](https://github.com/flutter/flutter/pull/41473) Missing trailing commas

[41482](https://github.com/flutter/flutter/pull/41482) [flutter_tool] Add analytics events for ios-mdns fallback success/failure

[41644](https://github.com/flutter/flutter/pull/41644) indent formal parameters correctly

[41799](https://github.com/flutter/flutter/pull/41799) Improved ios 13 scrollbar fidelity

[41828](https://github.com/flutter/flutter/pull/41828) Set DEFINES_MODULE=YES in plugin templates

[41892](https://github.com/flutter/flutter/pull/41892) Fix CupertinoActivityIndicator radius

[42025](https://github.com/flutter/flutter/pull/42025) Localization refresh

[42032](https://github.com/flutter/flutter/pull/42032) Update CupertinoActivityIndicator colors and gradient

[42533](https://github.com/flutter/flutter/pull/42533) Disable arrow key focus navigation for text fields

[42550](https://github.com/flutter/flutter/pull/42550) Add enableSuggestions flag to TextField and TextFormField

[42563](https://github.com/flutter/flutter/pull/42563) Adding thumb color customization functionality to CupertinoSlider

[42602](https://github.com/flutter/flutter/pull/42602) Properly throw FlutterError when route builder returns null on CupertinoPageRoute

[42775](https://github.com/flutter/flutter/pull/42775) CupertinoSlidingSegmentedControl

[42790](https://github.com/flutter/flutter/pull/42790) This disables the up/down arrow focus navigation in text fields in a different way.

[42924](https://github.com/flutter/flutter/pull/42924) CupertinoDialogAction is missing super call

[42964](https://github.com/flutter/flutter/pull/42964) Use PRODUCT_BUNDLE_IDENTIFIER from buildSettings to find correct bundle id on iOS when using flavors

[42967](https://github.com/flutter/flutter/pull/42967) Pad CupertinoAlertDialog with MediaQuery viewInsets

[43918](https://github.com/flutter/flutter/pull/43918) CupertinoContextMenu (iOS 13)

[43932](https://github.com/flutter/flutter/pull/43932) Update CupertinoSlidingSegmentedControl control/feedback mechanism

[44149](https://github.com/flutter/flutter/pull/44149) Apply minimumDate & maximumDate constraints in CupertinoDatePicker date mode

[44391](https://github.com/flutter/flutter/pull/44391) Segmented control quick double tap fix

[44551](https://github.com/flutter/flutter/pull/44551) Remove new unused elements

[44743](https://github.com/flutter/flutter/pull/44743) Sort Localization generation output

[44870](https://github.com/flutter/flutter/pull/44870) Add -runFirstLaunch hint text

[45124](https://github.com/flutter/flutter/pull/45124) Analyze dartpad

[11350](https://github.com/flutter/engine/pull/11350) Firebase test for Platform Views on iOS

[11390](https://github.com/flutter/engine/pull/11390) preventDefault on touchend to show iOS keyboard

[11413](https://github.com/flutter/engine/pull/11413) Ios simulator unittests seem to not consider the full compilation unit

[11530](https://github.com/flutter/engine/pull/11530) Optionally strip bitcode when creating ios framework

[11652](https://github.com/flutter/engine/pull/11652) iOS platform view mutation XCUITests

[11802](https://github.com/flutter/engine/pull/11802) Adjust iOS frame start times to match the platform info

[11807](https://github.com/flutter/engine/pull/11807) Fix deleting Thai vowel bug on iOS

[11817](https://github.com/flutter/engine/pull/11817) Smooth out iOS irregular input events delivery

[11886](https://github.com/flutter/engine/pull/11886) remove extra redundant channels setup in iOS embedding engine

[12078](https://github.com/flutter/engine/pull/12078) Manage iOS contexts separately

[12084](https://github.com/flutter/engine/pull/12084) Guard availability of user notification related methods to iOS 10.0

[12192](https://github.com/flutter/engine/pull/12192) Updating text field location in IOS as a pre-work for spellcheck

[12295](https://github.com/flutter/engine/pull/12295) Issue 13238: on iOS, force an orientation change when the current orientation is not allowed

[12404](https://github.com/flutter/engine/pull/12404) Support accessibility labels on iOS switches.

[12990](https://github.com/flutter/engine/pull/12990) Fix for a11y crash on iOS

[13029](https://github.com/flutter/engine/pull/13029) Minimal test harness for iOS

[13051](https://github.com/flutter/engine/pull/13051) Don’t bump iOS deployment target for Metal builds.

[13093](https://github.com/flutter/engine/pull/13093) iOS Platform View: Fixed overrelease of the observer.

[13170](https://github.com/flutter/engine/pull/13170) Issue 13238: on iOS, force an orientation change when the current orientation is not allowed

[13449](https://github.com/flutter/engine/pull/13449) Fix iOS crash when multiple platform views are in the scene

[13469](https://github.com/flutter/engine/pull/13469) Fix stale platform view gr context on iOS

[13651](https://github.com/flutter/engine/pull/13651) Fixed the scroll direction for iOS horizontal accessibility scroll events.

[13852](https://github.com/flutter/engine/pull/13852) Do not default to downstream affinity on iOS insertText

[13857](https://github.com/flutter/engine/pull/13857) Guard against orphaned semantic objects from referencing dead accessibility bridge on iOS

[1370](https://github.com/flutter/plugins/pull/1370) [camera] Pause/resume video recording for Android & iOS

[1999](https://github.com/flutter/plugins/pull/1999) [Connectivity] add a method to request location on iOS (for iOS 13)

[2052](https://github.com/flutter/plugins/pull/2052) [instrumentation_adapter] Add stub iOS implementation and example app

[2068](https://github.com/flutter/plugins/pull/2068) [google_maps_flutter] Fix iOS MyLocationButton on iOS

[2083](https://github.com/flutter/plugins/pull/2083) [image_picker] Fix a crash when picking video on iOS 13 and above.

[2131](https://github.com/flutter/plugins/pull/2131) [share]fix iOS crash when setting the subject to null

[2139](https://github.com/flutter/plugins/pull/2139) [google_maps_flutter] Add NonNull macro to reduce warnings in iOS

[2191](https://github.com/flutter/plugins/pull/2191) [image_picker] Fix iOS build and analyzer warnings

[2192](https://github.com/flutter/plugins/pull/2192) [in_app_purchase] Fix iOS build warning

[2275](https://github.com/flutter/plugins/pull/2275) Update cirrus to create IOS simulator on 13.2 an xCode 11

[2281](https://github.com/flutter/plugins/pull/2281) [connectivity] Fix reachability stream for iOS


## Android

In this release, we’ve merged a list of changes to support Android 10, including a new activity zoom transition. 

[37526](https://github.com/flutter/flutter/pull/37526) catch errors during gradle update

[39126](https://github.com/flutter/flutter/pull/39126) Fid app bundle in Gradle 3.5

[39145](https://github.com/flutter/flutter/pull/39145) Add missing files in the Gradle wrapper directory

[39312](https://github.com/flutter/flutter/pull/39312) let flutter build aar use a local engine

[39457](https://github.com/flutter/flutter/pull/39457) Log flags in build apk and appbundle

[40640](https://github.com/flutter/flutter/pull/40640) Exclude non Android plugins from Gradle build

[41698](https://github.com/flutter/flutter/pull/41698) Download android x64 release artifacts

[41933](https://github.com/flutter/flutter/pull/41933) upload x64 android host release

[41935](https://github.com/flutter/flutter/pull/41935) [Android 10] Activity zoom transition

[41946](https://github.com/flutter/flutter/pull/41946) Do not validate the Android SDK when building an appbundle

[42378](https://github.com/flutter/flutter/pull/42378) remove println from flutter.gradle

[42401](https://github.com/flutter/flutter/pull/42401) Add support for Android x86_64 ABI to Flutter

[42508](https://github.com/flutter/flutter/pull/42508) Add Android x64 profile artifacts

[42966](https://github.com/flutter/flutter/pull/42966) expand scope of rethrown gradle errors

[43245](https://github.com/flutter/flutter/pull/43245) Add smallestScreenSize to android:configChanges in the Android manifest template

[43282](https://github.com/flutter/flutter/pull/43282) implement build aot with assemble for Android target platforms

[43876](https://github.com/flutter/flutter/pull/43876) Refactor flutter.gradle to use assemble directly

[44534](https://github.com/flutter/flutter/pull/44534) Improve performance of build APK (~50%) by running gen_snapshot concurrently

[45139](https://github.com/flutter/flutter/pull/45139) Update Android CPU device detection

[11345](https://github.com/flutter/engine/pull/11345) [Android] Write MINIMAL_SDK required to use PlatformViews to exception message

[11441](https://github.com/flutter/engine/pull/11441) Android 10+ View.setSystemGestureExclusionRects

[11451](https://github.com/flutter/engine/pull/11451) Android 10+ View.getSystemGestureExclusionRects

[12085](https://github.com/flutter/engine/pull/12085) Enable platform view keyboard input on Android Q

[13059](https://github.com/flutter/engine/pull/13059) Android targets create final zip artifacts

[13099](https://github.com/flutter/engine/pull/13099) NO_SUGGESTIONS keyboard flag in Android

[13262](https://github.com/flutter/engine/pull/13262) Added Semantic header support on Android.

[2003](https://github.com/flutter/plugins/pull/2003) [video_player] Added formatHint to to override video format on Android

[2029](https://github.com/flutter/plugins/pull/2029) fix android crash when pausing or resuming video on APIs lower than 24.

[2049](https://github.com/flutter/plugins/pull/2049) [path_provider] Android: Support multiple external storage options

[2208](https://github.com/flutter/plugins/pull/2208) delete all example/android/app/gradle.properties files

[2216](https://github.com/flutter/plugins/pull/2216) [battery]Use android.arch.lifecycle instead of androidx.lifecycle:lifecycle in

[2239](https://github.com/flutter/plugins/pull/2239) [camera] Android: Improve image streaming by creating a request suita…


## Add to App feature

We’ve made a significant upgrade to Add-to-App, the feature that allows you to integrate a Flutter module into your Android or iOS app. Can’t wait to try it? Check out the [Add-to-App documentation](/docs/development/add-to-app). 

[41666](https://github.com/flutter/flutter/pull/41666) Generate projects using the new Android embedding

[44369](https://github.com/flutter/flutter/pull/44369) Flip enable-android-embedding-v2 flag

[40810](https://github.com/flutter/flutter/pull/40810) Re-enable AAR plugins when an AndroidX failure occurred

[41820](https://github.com/flutter/flutter/pull/41820) Added SystemNavigator.pop "animated" argument.

[12752](https://github.com/flutter/engine/pull/12752) Enabled people to chose if SystemNavigator.pop is animated on iOS.

[12069](https://github.com/flutter/engine/pull/12069) Fold the calls for FlutterMain into the FlutterEngine constructor

[39945](https://github.com/flutter/flutter/pull/39945) added new lifecycle state

[11913](https://github.com/flutter/engine/pull/11913) Added new lifecycle enum

[45115](https://github.com/flutter/flutter/pull/45115) fix ios_add2app_life_cycle license

[45133](https://github.com/flutter/flutter/pull/45133) reland add lifecycle enum and fix the scheduleforcedframe

[45430](https://github.com/flutter/flutter/pull/45430) Drops detached message until we can handle it properly

[9525](https://github.com/flutter/engine/pull/9525) Android Embedding Refactor PR36: Add splash screen support.

[9506](https://github.com/flutter/engine/pull/9506) Synchronize main thread and gpu thread for first render frame

[39600](https://github.com/flutter/flutter/pull/39600) Let Material BackButton have a custom onPressed handler

[9952](https://github.com/flutter/engine/pull/9952) ios: Fixed the callback for the first frame so that it isn't predicated on having a splash screen.

[10145](https://github.com/flutter/engine/pull/10145) Added integration test that tests that the first frame callback is called

[42708](https://github.com/flutter/flutter/pull/42708) Test the Android embedding v2

[43221](https://github.com/flutter/flutter/pull/43221) Migrate examples to the Android embedding v2

[9895](https://github.com/flutter/engine/pull/9895) Android Embedding PR37: Separated FlutterActivity and FlutterFragment via FlutterActivityAndFragmentDelegate

[11890](https://github.com/flutter/engine/pull/11890) Add some AppLifecycleTests

[12128](https://github.com/flutter/engine/pull/12128) Make iOS FlutterViewController stop sending inactive/pause on app lifecycle events when not visible

[12232](https://github.com/flutter/engine/pull/12232) FlutterViewController notify will dealloc

[13280](https://github.com/flutter/engine/pull/13280) Android embedding API updates for plugin ecosystem

[13349](https://github.com/flutter/engine/pull/13349) Deprecated DartExecutor as BinaryMessenger and added a getBinaryMessenger() method. (#43202)

[13432](https://github.com/flutter/engine/pull/13432) Release shim bindings when detaching

[2232](https://github.com/flutter/plugins/pull/2232) [multiple] V2 embedding plugins use compileOnly

[1323](https://github.com/FirebaseExtended/flutterfire/pull/1323) [firebase_core][firebase_analytics] Fix bug with transitive lifecycle dependencies

[13445](https://github.com/flutter/engine/pull/13445) Fizzle onConfigurationChanged if no FlutterView

[44499](https://github.com/flutter/flutter/pull/44499) Show a warning when a module uses a v1 only plugin

[35100](https://github.com/flutter/flutter/pull/35100) Add handling of 'TextInput.clearClient' message from platform to framework (#35054).

[13474](https://github.com/flutter/engine/pull/13474) Request a reattach when creating the text input plugin on Android

[43959](https://github.com/flutter/flutter/pull/43959) Respond to TextInputClient.reattach messages.

[509](https://github.com/flutter/cocoon/pull/509) Force the phone's screen on before running a test.

[11792](https://github.com/flutter/engine/pull/11792) Started logging warnings if we drop platform messages.

[12167](https://github.com/flutter/engine/pull/12167) Channel buffers

[40165](https://github.com/flutter/flutter/pull/40165) Channel buffers

[12402](https://github.com/flutter/engine/pull/12402) Resize channel buffers

[6879](https://github.com/flutter/engine/pull/6879) Allow FlutterViewController to be released when not initialized with an engine

[9329](https://github.com/flutter/engine/pull/9329) Fixed memory leak by way of accidental retain on implicit self

[9347](https://github.com/flutter/engine/pull/9347) Surrogate binary messenger

[9419](https://github.com/flutter/engine/pull/9419) Has a binary messenger

[8387](https://github.com/flutter/engine/pull/8387) Make the resource context primary on iOS

[11798](https://github.com/flutter/engine/pull/11798) Manage resource and onscreen contexts using separate IOSGLContext objects

[12277](https://github.com/flutter/engine/pull/12277) Manage resource and onscreen contexts using separate IOSGLContext objects

[13396](https://github.com/flutter/engine/pull/13396) Made it so we clean up gl resources when view controllers get deleted.

[39157](https://github.com/flutter/flutter/pull/39157) Use new Maven artifacts from Gradle

[39503](https://github.com/flutter/flutter/pull/39503) Remove bitcode=NO from add-to-app flows

[36793](https://github.com/flutter/flutter/pull/36793) Vend Flutter module App.framework as a local CocoaPod pod to be installed by a host app

[37966](https://github.com/flutter/flutter/pull/37966) Remove ephemeral directories during flutter clean

[40302](https://github.com/flutter/flutter/pull/40302) Set DEFINES_MODULE for FlutterPluginRegistrant to generate modulemap

[37731](https://github.com/flutter/flutter/pull/37731) Add metadata to indicate if the host app contains a Flutter module

[36805](https://github.com/flutter/flutter/pull/36805) Allow flavors and custom build types in host app

[26630](https://github.com/flutter/flutter/pull/26630) Move flutter_assets to App.framework

[31463](https://github.com/flutter/flutter/pull/31463) Disable all Dart fingerprinters

[35217](https://github.com/flutter/flutter/pull/35217) Add flutter build aar

[40927](https://github.com/flutter/flutter/pull/40927) Make module pod headers public

[44065](https://github.com/flutter/flutter/pull/44065) Build ios framework

[37206](https://github.com/flutter/flutter/pull/37206) Test that modules built as AAR contain the right assets and artifacts

[44127](https://github.com/flutter/flutter/pull/44127) build aar prints how to consume the artifacts

[23782](https://github.com/flutter/flutter/pull/23782) Add flutter_shared assets to module artifact

[22707](https://github.com/flutter/flutter/pull/22707) Gradle plugin support for adding flutter as subproject to another Android app

[9893](https://github.com/flutter/engine/pull/9893) Removed logic from FlutterAppDelegate into FlutterPluginAppLifeCycleDelegate

[9922](https://github.com/flutter/engine/pull/9922) Split out lifecycle protocol

[44026](https://github.com/flutter/flutter/pull/44026) Exit tool if a plugin only supports the embedding v2 but the app doesn't

[44214](https://github.com/flutter/flutter/pull/44214) Fix v1 embedding support heuristic for plugins

[43994](https://github.com/flutter/flutter/pull/43994) flutter build aar should also build plugins as AARs

[13455](https://github.com/flutter/engine/pull/13455) Automatically register plugins in FlutterEngine. (#43855)

[44011](https://github.com/flutter/flutter/pull/44011) Move the plugin registrant to io.flutter.plugins and add the @Keep an…

[44166](https://github.com/flutter/flutter/pull/44166) Add v1 plugin register function into v2 plugin template

[13394](https://github.com/flutter/engine/pull/13394) Remove multiplexed Flutter Android Lifecycle. (#43663)

[45557](https://github.com/flutter/flutter/pull/45557) Add a note to generated plugins files

[45379](https://github.com/flutter/flutter/pull/45379) Add .flutter-plugins-dependencies to the project, which contains the app's plugin dependency graph

[3850](https://github.com/flutter/flutter-intellij/pull/3850) Support co-editing Flutter and Android in a single project

[4097](https://github.com/flutter/flutter-intellij/pull/4097) Support for debugging add-to-app modules in Android Studio

[4129](https://github.com/flutter/flutter-intellij/pull/4129) Smooth out the rough spots in add-to-app support

[4062](https://github.com/flutter/flutter-intellij/pull/4062) Re-enable attach button for add-to-app projects

[4004](https://github.com/flutter/flutter-intellij/pull/4004) Co-edit module created in Android Studio

[33297](https://github.com/flutter/flutter/pull/33297) Instrument add to app flows

[33458](https://github.com/flutter/flutter/pull/33458) Add to app measurement

[34189](https://github.com/flutter/flutter/pull/34189) Instrument usage of include_flutter.groovy and xcode_backend.sh

[13289](https://github.com/flutter/engine/pull/13289) Made restarting the Engine remember the last entrypoint that was used.

[12370](https://github.com/flutter/engine/pull/12370) Added a default entrypoint variable to match android syntax.

[10823](https://github.com/flutter/engine/pull/10823) Expose isolateId for engine

[13264](https://github.com/flutter/engine/pull/13264) Made restarting the Engine remember the last entrypoint that was used.

[13789](https://github.com/flutter/engine/pull/13789) add recent packages to javadoc list

[10481](https://github.com/flutter/engine/pull/10481) Android embedding refactor pr40 add static engine cache

[29946](https://github.com/flutter/flutter/pull/29946) Let CupertinoPageScaffold have tap status bar to scroll to top

[12587](https://github.com/flutter/engine/pull/12587) Split out the logic to handle status bar touches into its own function

[44638](https://github.com/flutter/flutter/pull/44638) Add module to create template help text

[9351](https://github.com/flutter/engine/pull/9351) Android Embedding Refactor PR32: Clean up logs in new embedding.

[6447](https://github.com/flutter/engine/pull/6447) iOS Embedding Refactor

[41794](https://github.com/flutter/flutter/pull/41794) Updated the docstring for SystemNavigator.pop.

[9304](https://github.com/flutter/engine/pull/9304) Decorate UIApplicationDelegate wrappers with matching UIKit deprecation

[266](https://github.com/FirebaseExtended/flutterfire/pull/266) [firebase_performance] support v2 android embedding

[274](https://github.com/FirebaseExtended/flutterfire/pull/274) [firebase_core] v2 embedding API

[275](https://github.com/FirebaseExtended/flutterfire/pull/275) [firebase_ml_vision] v2 embedding API

[282](https://github.com/FirebaseExtended/flutterfire/pull/282) [firebase_remote_config] Support v2 android embedder.

[287](https://github.com/FirebaseExtended/flutterfire/pull/287) [firebase_database] Support v2 android embedder.

[1266](https://github.com/FirebaseExtended/flutterfire/pull/1266) [firebase_analytics] Support Android v2 embedding

[1295](https://github.com/FirebaseExtended/flutterfire/pull/1295) [firebase_storage] Support Android v2 embedding

[1369](https://github.com/FirebaseExtended/flutterfire/pull/1369) Upgrade in-app-messaging to plugin api v2

[1370](https://github.com/FirebaseExtended/flutterfire/pull/1370) Upgrade crashlytics to v2 plugin API

[1372](https://github.com/FirebaseExtended/flutterfire/pull/1372) [firebase_dynamic_links] support v2 embedding

[2142](https://github.com/flutter/plugins/pull/2142) [Connectivity] migrate to the new android embedding

[2152](https://github.com/flutter/plugins/pull/2152) [battery] Support the v2 Android embedder

[2155](https://github.com/flutter/plugins/pull/2155) [in_app_purchase] migrate to the v2 android embedding

[2156](https://github.com/flutter/plugins/pull/2156) [Share] Support v2 android embedder.

[2157](https://github.com/flutter/plugins/pull/2157) [url_launcher] Migrate to the new embedding

[2160](https://github.com/flutter/plugins/pull/2160) [package_info] Support the v2 Android embedder (with e2e tests)

[2162](https://github.com/flutter/plugins/pull/2162) [shared_preferences] Support v2 android embedder.

[2163](https://github.com/flutter/plugins/pull/2163) [device_info] Support v2 android embedder.

[2164](https://github.com/flutter/plugins/pull/2164) [sensor] Support v2 android embedder.

[2165](https://github.com/flutter/plugins/pull/2165) [camera] Migrate to the new embedding

[2167](https://github.com/flutter/plugins/pull/2167) [quick_actions] Support v2 android embedder.

[2169](https://github.com/flutter/plugins/pull/2169) [flutter_webview] Migrate to the new embedding

[2193](https://github.com/flutter/plugins/pull/2193) [android_alarm_manager] migrate to the V2 Android embedding

[2195](https://github.com/flutter/plugins/pull/2195) [android_intent] Cleanup the V2 migration

[2196](https://github.com/flutter/plugins/pull/2196) [webview_flutter] (Trivial) Add V2 warnings

[2200](https://github.com/flutter/plugins/pull/2200) [flutter_webview] Revert v2 embedder support

[2204](https://github.com/flutter/plugins/pull/2204) [url_launcher] Re-land v2 embedding support

[2209](https://github.com/flutter/plugins/pull/2209) [webview_flutter] Re-land support v2 embedding support

[2226](https://github.com/flutter/plugins/pull/2226) [video_player] Add v2 embedding support

[2241](https://github.com/flutter/plugins/pull/2241) [Shared_preferences]suppress warnings

[2284](https://github.com/flutter/plugins/pull/2284) [path_provider] Add v2 embedding support for

[2327](https://github.com/flutter/plugins/pull/2327) [android_alarm_manager] Update minimum Flutter version to 1.12.0

[43461](https://github.com/flutter/flutter/pull/43461) Fixed usage of optional types in swift integration test.

[13423](https://github.com/flutter/engine/pull/13423) Automatically destroy FlutterEngine when created by FlutterActivity or FlutterFragment.

[42958](https://github.com/flutter/flutter/pull/42958) Turn off bitcode for integration tests and add-to-app templates

[13428](https://github.com/flutter/engine/pull/13428) Set the install name at link time for darwin dylibs

[41333](https://github.com/flutter/flutter/pull/41333) Merge Flutter assets in add to app

[39747](https://github.com/flutter/flutter/pull/39747) Fix type mismatch in Gradle

[39986](https://github.com/flutter/flutter/pull/39986) Enable Proguard by default on release mode

[40181](https://github.com/flutter/flutter/pull/40181) Update Kotlin and Gradle version

[40282](https://github.com/flutter/flutter/pull/40282) Flip the default for proguard

[40440](https://github.com/flutter/flutter/pull/40440) Rename useProguard method, so Gradle doesn't get confused

[40453](https://github.com/flutter/flutter/pull/40453) Enable R8

[40610](https://github.com/flutter/flutter/pull/40610) Enable the resource shrinker

[40900](https://github.com/flutter/flutter/pull/40900) Stop using deprecated features from Gradle

[40925](https://github.com/flutter/flutter/pull/40925) Use AndroidX in new projects by default

[41142](https://github.com/flutter/flutter/pull/41142) Add embedding as API dependency instead of compile only dependency

[41251](https://github.com/flutter/flutter/pull/41251) Migrate examples and tests to AndroidX

[41254](https://github.com/flutter/flutter/pull/41254) Test that flutter assets are contained in the APK

[41885](https://github.com/flutter/flutter/pull/41885) Include embedding transitive dependencies in plugins

[41942](https://github.com/flutter/flutter/pull/41942) Use mergeResourcesProvider instead of deprecated mergeResources

[42022](https://github.com/flutter/flutter/pull/42022) Fix smoke test

[42306](https://github.com/flutter/flutter/pull/42306) Ensure that flutter assets are copied in the AAR

[42352](https://github.com/flutter/flutter/pull/42352) Add android.permission.WAKE_LOCK permission to abstract_method_smoke_test

[42360](https://github.com/flutter/flutter/pull/42360) Add smoke test for the new Android embedding

[42548](https://github.com/flutter/flutter/pull/42548) Print message and log event when app isn't using AndroidX

[42684](https://github.com/flutter/flutter/pull/42684) Remove isNewAndroidEmbeddingEnabled flag when reading an existing pro…

[42709](https://github.com/flutter/flutter/pull/42709) Test Gradle on Windows

[42981](https://github.com/flutter/flutter/pull/42981) Remove GeneratedPluginRegistrant.java

[43187](https://github.com/flutter/flutter/pull/43187) Ensure android.enableR8 is appended to a new line

[43479](https://github.com/flutter/flutter/pull/43479) Refactor gradle.dart

[43669](https://github.com/flutter/flutter/pull/43669) Don't read AndroidManifest.xml if it doesn't exit

[43674](https://github.com/flutter/flutter/pull/43674) Add missing import

[43675](https://github.com/flutter/flutter/pull/43675) Fix device lab tests

[43927](https://github.com/flutter/flutter/pull/43927) Fix stdout test

[43941](https://github.com/flutter/flutter/pull/43941) Tweaks after the gradle.dart refactor

[44301](https://github.com/flutter/flutter/pull/44301) Don't print how to consume AARs when building plugins as AARs

[44243](https://github.com/flutter/flutter/pull/44243) Build local maven repo when using local engine

[44302](https://github.com/flutter/flutter/pull/44302) Don't add x86 nor x64 when building a local engine in debug mode

[44637](https://github.com/flutter/flutter/pull/44637) Attach looks at future observatory URIs

[44783](https://github.com/flutter/flutter/pull/44783) Forward ProcessException to error handlers

[44797](https://github.com/flutter/flutter/pull/44797) Build AAR for all build variants by default

[45439](https://github.com/flutter/flutter/pull/45439) Fallback to protocol discovery if mdns returns null

[45579](https://github.com/flutter/flutter/pull/45579) Add integration test for transitive plugin dependencies

[45743](https://github.com/flutter/flutter/pull/45743) Android log reader reads any recent logs

[45937](https://github.com/flutter/flutter/pull/45937) Handle case where lastLogcatTimestamp is null

[46040](https://github.com/flutter/flutter/pull/46040) Enable Android embedding v2 on the beta, dev and stable channel

[46101](https://github.com/flutter/flutter/pull/46101) Remove flutterBuildPluginAsAarFeature flag

[14136](https://github.com/flutter/engine/pull/14136) Expanded our scenario_app docs.

[14094](https://github.com/flutter/engine/pull/14094) Started specifying the OS version for running the tests.

[13421](https://github.com/flutter/engine/pull/13421) FlutterAppDelegate: Added back in empty lifecycle methods

[13073](https://github.com/flutter/engine/pull/13073) Removed retain cycle from notification center.

[13006](https://github.com/flutter/engine/pull/13006) Refactor: FlutterDartProject

[44782](https://github.com/flutter/flutter/pull/44782) Updated flutter/examples to further conform to new embedding: removed references to FlutterApplication, deleted all MainActivity's that were not necessary, removed all direct invocations of GeneratedPluginRegistrant. (#22529)

[45740](https://github.com/flutter/flutter/pull/45740) Do not delete output directory during flutter build ios-framework

[45560](https://github.com/flutter/flutter/pull/45560) Always compile with isysroot on iOS to point to SDK root

[45436](https://github.com/flutter/flutter/pull/45436) Always compile with -isysroot flag on iOS to point to SDK root

[45189](https://github.com/flutter/flutter/pull/45189) Remove chmod to make Flutter framework headers unwritable

[45136](https://github.com/flutter/flutter/pull/45136) Remove FLUTTER_DEVICELAB_XCODE_PROVISIONING_CONFIG code paths

[44633](https://github.com/flutter/flutter/pull/44633) Turn on bitcode for integration tests and add-to-app templates

[44625](https://github.com/flutter/flutter/pull/44625) Release startup lock during long-lived build ios framework

[44324](https://github.com/flutter/flutter/pull/44324) Add swift_versions to plugin template podspec, include default CocoaPod version

[43915](https://github.com/flutter/flutter/pull/43915) Observe logging from VM service on iOS 13

[43553](https://github.com/flutter/flutter/pull/43553) Pass environment variables through to xcodebuild

[42872](https://github.com/flutter/flutter/pull/42872) Remove use_modular_headers from Podfiles using libraries

[42808](https://github.com/flutter/flutter/pull/42808) Run flutter pub get before pod install in platform_view_ios__start_up test

[42254](https://github.com/flutter/flutter/pull/42254) Update minimum version to Xcode 10.2

[42204](https://github.com/flutter/flutter/pull/42204) Add use_modular_headers! to default Podfile

[42029](https://github.com/flutter/flutter/pull/42029) Always embed iOS Flutter.framework build mode version from Xcode configuration

[41882](https://github.com/flutter/flutter/pull/41882) Increase template Swift version from 4 to 5

[41491](https://github.com/flutter/flutter/pull/41491) Skip pod initialization if version >= 1.8.0.

[40792](https://github.com/flutter/flutter/pull/40792) Move build info checks from generating files to the xcode build

[40611](https://github.com/flutter/flutter/pull/40611) Warn when build number and version can't be parsed on iOS

[40401](https://github.com/flutter/flutter/pull/40401) Make FlutterPluginRegistrant a static framework so add-to-app can use static framework plugins

[40174](https://github.com/flutter/flutter/pull/40174) Keep Flutter.framework binaries writable so they can be code signed

[40117](https://github.com/flutter/flutter/pull/40117) Show outdated CocoaPods version in hint text

[39539](https://github.com/flutter/flutter/pull/39539) Keep Flutter.framework binaries writable so they can be code signed

[39509](https://github.com/flutter/flutter/pull/39509) Skip failing add2app test to unblock roll

[38992](https://github.com/flutter/flutter/pull/38992) Clean Xcode workspace during flutter clean

[38905](https://github.com/flutter/flutter/pull/38905) Remove iphonesimulator from SUPPORTED_PLATFORMS for Profile and Release modes

[11357](https://github.com/flutter/engine/pull/11357) Rename first frame method and notify FlutterActivity when full drawn (#38714 #36796).

[11844](https://github.com/flutter/engine/pull/11844) Updated API usage in scenario app by deleting unnecessary method.

[11902](https://github.com/flutter/engine/pull/11902) Remove un-needed FragmentActivity import statements to facilitate proguard.

[12305](https://github.com/flutter/engine/pull/12305) Introduce flutterfragmentactivity

[12328](https://github.com/flutter/engine/pull/12328) Added javadoc comments to FlutterActivity and FlutterFragmentActivity.

[12359](https://github.com/flutter/engine/pull/12359) Forwards Flutter View to platform views and detaches when needed.

[12362](https://github.com/flutter/engine/pull/12362) Fixes race condition that was reported internally.

[12806](https://github.com/flutter/engine/pull/12806) Move initialization into FlutterEngine

[12987](https://github.com/flutter/engine/pull/12987) Added FlutterActivity and FlutterFragment hook to cleanUpFlutterEngine() as symmetry for configureFlutterEngine(). (#41943)

[13214](https://github.com/flutter/engine/pull/13214) Forwards Activity result to FlutterFragment in FlutterFragmentActivity.

[13215](https://github.com/flutter/engine/pull/13215) Adds Dark Mode support to new Android embedding (this was accidentally missed previously).

[13402](https://github.com/flutter/engine/pull/13402) Converted ActivityAware and ServiceAware Lifecycles to opaque objects (#43670)

[13660](https://github.com/flutter/engine/pull/13660) Fix splash screen lookup. (#44131)

[13698](https://github.com/flutter/engine/pull/13698) Fix plugin registrant reflection path. (#44161)

[13738](https://github.com/flutter/engine/pull/13738) Removed scary experimental warnings for new embedding. (#44314)

[13739](https://github.com/flutter/engine/pull/13739) Point old plugin registry accessors to new embedding plugin accessors. (#44225)

[13743](https://github.com/flutter/engine/pull/13743) Expose asset lookup from plugin binding. (#42019)

[13855](https://github.com/flutter/engine/pull/13855) Add support for --dart-flags in FlutterShellArgs. (#44855)

[13932](https://github.com/flutter/engine/pull/13932) Removed GET_ACTIVITIES flag from all manifest meta-data lookups. (#38891)

[2087](https://github.com/flutter/plugins/pull/2087) [android_alarm_manager] Update and migrate iOS example project

[2088](https://github.com/flutter/plugins/pull/2088) [android_intent] Update and migrate iOS example project

[2089](https://github.com/flutter/plugins/pull/2089) [battery] Update and migrate iOS example project

[2090](https://github.com/flutter/plugins/pull/2090) [camera] Update and migrate iOS example project

[2091](https://github.com/flutter/plugins/pull/2091) [connectivity] Update and migrate iOS example project

[2092](https://github.com/flutter/plugins/pull/2092) [device_info] Update and migrate iOS example project

[2093](https://github.com/flutter/plugins/pull/2093) [google_maps_flutter] Update and migrate iOS example project

[2094](https://github.com/flutter/plugins/pull/2094) [google_sign_in] Update and migrate iOS example project

[2095](https://github.com/flutter/plugins/pull/2095) [image_picker] Update and migrate iOS example project

[2096](https://github.com/flutter/plugins/pull/2096) [in_app_purchase] Update and migrate iOS example project

[2097](https://github.com/flutter/plugins/pull/2097) [local_auth] Update and migrate iOS example project

[2098](https://github.com/flutter/plugins/pull/2098) [package_info] Update and migrate iOS example project

[2099](https://github.com/flutter/plugins/pull/2099) [path_provider] Update and migrate iOS example project

[2100](https://github.com/flutter/plugins/pull/2100) [quick_actions] Update and migrate iOS example project

[2101](https://github.com/flutter/plugins/pull/2101) [sensors] Update and migrate iOS example project

[2102](https://github.com/flutter/plugins/pull/2102) [share] Update and migrate iOS example project

[2103](https://github.com/flutter/plugins/pull/2103) [shared_preferences] Update and migrate iOS example project

[2109](https://github.com/flutter/plugins/pull/2109) [url_launcher] Update and migrate iOS example project

[2110](https://github.com/flutter/plugins/pull/2110) [video_player] Update and migrate iOS example project

[2115](https://github.com/flutter/plugins/pull/2115) [camera] Define clang modules in for iOS

[2125](https://github.com/flutter/plugins/pull/2125) [in_app_purchase] Define clang module for iOS

[2128](https://github.com/flutter/plugins/pull/2128) [image_picker] Define clang module for iOS

[2135](https://github.com/flutter/plugins/pull/2135) [android_alarm_manager] Define clang module for iOS

[2137](https://github.com/flutter/plugins/pull/2137) [connectivity] Define clang module for iOS

[2138](https://github.com/flutter/plugins/pull/2138) [device_info] Define clang module for iOS

[2144](https://github.com/flutter/plugins/pull/2144) [android_intent] Define clang module for iOS

[2145](https://github.com/flutter/plugins/pull/2145) [instrumentation_adapter] Define clang module for iOS

[2146](https://github.com/flutter/plugins/pull/2146) [local_auth] Define clang module for iOS

[2147](https://github.com/flutter/plugins/pull/2147) [path_provider] Define clang module for iOS

[2148](https://github.com/flutter/plugins/pull/2148) [package_info] Define clang module for iOS

[2149](https://github.com/flutter/plugins/pull/2149) [quick_actions] Define clang module for iOS

[2175](https://github.com/flutter/plugins/pull/2175) [sensors] Define clang module for iOS

[2176](https://github.com/flutter/plugins/pull/2176) [shared_preferences] Define clang module for iOS

[2177](https://github.com/flutter/plugins/pull/2177) [url_launcher] Define clang module for iOS

[2179](https://github.com/flutter/plugins/pull/2179) [battery] Define clang module for iOS

[2180](https://github.com/flutter/plugins/pull/2180) [share] Define clang module for iOS

[2182](https://github.com/flutter/plugins/pull/2182) [google_maps_flutter] Define clang module for iOS, fix analyzer warnings

[2183](https://github.com/flutter/plugins/pull/2183) [video_player] Define clang module for iOS

[2184](https://github.com/flutter/plugins/pull/2184) [google_sign_in] Define clang module for iOS

[2185](https://github.com/flutter/plugins/pull/2185) [webview_flutter] Define clang module for iOS

[2186](https://github.com/flutter/plugins/pull/2186) Run clang analyzer on iOS and macOS code in CI test when packages change

[40302](https://github.com/flutter/flutter/pull/40302) Set DEFINES_MODULE for FlutterPluginRegistrant to generate modulemap

[2206](https://github.com/flutter/plugins/pull/2206) [flutter_plugin_android_lifecycle] Update README with new plugin name

[2207](https://github.com/flutter/plugins/pull/2207) [flutter_plugin_android_lifecycle] bump e2e depenency to 0.2.1

[2223](https://github.com/flutter/plugins/pull/2223) [flutter_plugin_android_lifecycle] register the e2e plugin in the example app

[2243](https://github.com/flutter/plugins/pull/2243) [flutter_plugin_android_lifecycle] Adapt the FlutterLifecycleAdapter to the new embedding API

[44043](https://github.com/flutter/flutter/pull/44043) Add Android embedding version analytics

[2120](https://github.com/flutter/plugins/pull/2120) [image_picker] fix crash when aar from 'flutter build aar'

[2168](https://github.com/flutter/plugins/pull/2168) Add plugin for Android lifecycle in embedding

[2174](https://github.com/flutter/plugins/pull/2174) [url_launcher] Enable androidx and jetifier in android gradle properties

[11239](https://github.com/flutter/engine/pull/11239) Remove dart entrypoint Intent parameter from FlutterActivity. (#38713)

[12469](https://github.com/flutter/engine/pull/12469) Started asserting the FlutterEngine is running before communicating over channels.

[13403](https://github.com/flutter/engine/pull/13403) Use DartExecutor.getBinaryMessenger in FlutterNativeView instead of deprecated send methods


## Material

Material continues to a focus for the Flutter team. In this release, we refreshed all Material widgets with dark mode support. Also, we added support for extending the height of the Scaffold's body behind the app bar, which is contributed by a community member! 

[36998](https://github.com/flutter/flutter/pull/36998) Added properties in DropdownButtonFormField to match DropdownButton

[37962](https://github.com/flutter/flutter/pull/37962) Show search app bar theme

[38583](https://github.com/flutter/flutter/pull/38583) Added InheritedTheme

[38650](https://github.com/flutter/flutter/pull/38650) Allow independent theming of Persistent and Modal bottom sheets

[38709](https://github.com/flutter/flutter/pull/38709) [Material] Add contentPadding property to SwitchListTile

[38726](https://github.com/flutter/flutter/pull/38726) Make disabled buttons/chips/text fields not be focusable.

[38813](https://github.com/flutter/flutter/pull/38813) Add ToggleButtons.textStyle property

[38831](https://github.com/flutter/flutter/pull/38831) [Material] Add clip property to bottom sheet and theme

[38898](https://github.com/flutter/flutter/pull/38898) ToggleButtons test improvement

[39144](https://github.com/flutter/flutter/pull/39144) Add the textAlignVertical param to TextFormField

[39156](https://github.com/flutter/flutter/pull/39156) Added Scaffold.extendBodyBehindAppBar

[39299](https://github.com/flutter/flutter/pull/39299) Add showAboutDialog sample

[39333](https://github.com/flutter/flutter/pull/39333) Allow independent theming of Persistent and Modal bottom sheets Background Color

[39433](https://github.com/flutter/flutter/pull/39433) Add helperMaxLines to InputDecoration and InputDecorationTheme

[39572](https://github.com/flutter/flutter/pull/39572) Prevent exception when creating a Divider borderSide

[39583](https://github.com/flutter/flutter/pull/39583) Fix single action banner to ensure button alignment

[39627](https://github.com/flutter/flutter/pull/39627) Default colorScheme data in ButtonThemeData (fix for #38655)

[39632](https://github.com/flutter/flutter/pull/39632) Updates to debugFillProperties to test all properties in slider.dart and slider_test.dart

[39903](https://github.com/flutter/flutter/pull/39903) Fixed passing autofocus to MaterialButton, and when rebuilding Focus widget.

[39924](https://github.com/flutter/flutter/pull/39924) Adds DartPad option to the DartDoc snippet generator.

[40390](https://github.com/flutter/flutter/pull/40390) a11y improvements for textfield

[40608](https://github.com/flutter/flutter/pull/40608) Add the option to configure a chip check mark color

[40641](https://github.com/flutter/flutter/pull/40641) Add onLongPress to Buttons

[40665](https://github.com/flutter/flutter/pull/40665) Fix CupertinoTextField and TextField ToolbarOptions not changing

[40713](https://github.com/flutter/flutter/pull/40713) Material textselection context menu cannot disable select all

[40994](https://github.com/flutter/flutter/pull/40994) Fix the ThemeData.copyWith toggleButtonsTheme argument type

[41120](https://github.com/flutter/flutter/pull/41120) Dropdown Menu layout respects menu items intrinsic sizes

[41150](https://github.com/flutter/flutter/pull/41150) Rebuild modal routes when the value of userGestureInProgress changes

[41172](https://github.com/flutter/flutter/pull/41172) fix some bad indentations

[41320](https://github.com/flutter/flutter/pull/41320) [Material] Remove text ripple from TextFields

[41338](https://github.com/flutter/flutter/pull/41338) Fix ReorderableListView's use of child keys (#41334)

[41463](https://github.com/flutter/flutter/pull/41463) [Chip] Make sure InkResponse is in the foreground on delete for chips with background color

[41625](https://github.com/flutter/flutter/pull/41625) Update DefaultTabController to allow for zero tabs

[41629](https://github.com/flutter/flutter/pull/41629) [Material] Fix Tooltip to respect ambient Directionality

[41632](https://github.com/flutter/flutter/pull/41632) fix confusing 'popupTheme' variable name in a MaterialBannerTheme method

[41640](https://github.com/flutter/flutter/pull/41640) some formatting changes

[41650](https://github.com/flutter/flutter/pull/41650) DropdownButton.style API doc example for differing button and menu item text styles

[41864](https://github.com/flutter/flutter/pull/41864) Update BottomAppBar to use elevation overlays when in a dark theme

[41972](https://github.com/flutter/flutter/pull/41972) Add enableFeedback param to MaterialButton, RawMaterialButton and IconButton

[42033](https://github.com/flutter/flutter/pull/42033) Reprise: Dropdown Menu layout respects menu items intrinsic sizes

[42189](https://github.com/flutter/flutter/pull/42189) Fix regression with ModalBottomSheets not responding to changes in theme

[42366](https://github.com/flutter/flutter/pull/42366) TextStyle.fontFamily should override fontFamily parameter in ThemeData

[42404](https://github.com/flutter/flutter/pull/42404) Add isDismissible configuration for showModalBottomSheet

[42482](https://github.com/flutter/flutter/pull/42482) Only dismiss dropdowns if the orientation changes, not the size.

[42554](https://github.com/flutter/flutter/pull/42554) Fix route focusing and autofocus when reparenting focus nodes.

[42613](https://github.com/flutter/flutter/pull/42613) Fix Tooltip implementation of PopupMenuButton

[42683](https://github.com/flutter/flutter/pull/42683) Optimize focus operations by caching descendants and ancestors.

[42779](https://github.com/flutter/flutter/pull/42779) Fix chip ripple bug — No longer two ripples

[42811](https://github.com/flutter/flutter/pull/42811) Add a Focus node to the DropdownButton, and adds an activation action for it.

[42936](https://github.com/flutter/flutter/pull/42936) Support AppBars with jumbo titles

[43213](https://github.com/flutter/flutter/pull/43213) Add focus nodes, hover, and shortcuts to switches, checkboxes, and radio buttons.

[43422](https://github.com/flutter/flutter/pull/43422) trivial fixed AboutListTile having an empty icon placeholder when no icon set.

[43511](https://github.com/flutter/flutter/pull/43511) Improve DropdownButton assert message

[43526](https://github.com/flutter/flutter/pull/43526) Change PopupMenuButton.icon type to Widget

[43722](https://github.com/flutter/flutter/pull/43722) Make selected item get focus when dropdown is opened

[43843](https://github.com/flutter/flutter/pull/43843) Remove print and fix code formatting

[43848](https://github.com/flutter/flutter/pull/43848) Don't allow Disabled InkWells to be focusable

[43859](https://github.com/flutter/flutter/pull/43859) Add convenience accessor for primaryFocus

[43946](https://github.com/flutter/flutter/pull/43946) Adding subtitle to ExpansionTile

[43981](https://github.com/flutter/flutter/pull/43981) Fix typo in app_bar.dart

[44029](https://github.com/flutter/flutter/pull/44029) Use alphabetic baselines for layout of InputDecorator

[44068](https://github.com/flutter/flutter/pull/44068) Fix typo in tabs.dart

[44076](https://github.com/flutter/flutter/pull/44076) Typo on comments

[44160](https://github.com/flutter/flutter/pull/44160) Wire selectedItemBuilder through DropdownButtonFormField

[44296](https://github.com/flutter/flutter/pull/44296) ModalBarrier and Drawer barrier prevents mouse events

[44736](https://github.com/flutter/flutter/pull/44736) Check in new diffs to material localizations

[44787](https://github.com/flutter/flutter/pull/44787) Fix snippets to include element ID in the output sample.

[44867](https://github.com/flutter/flutter/pull/44867) FocusableActionDetector widget

[45081](https://github.com/flutter/flutter/pull/45081) Remove duplicated expect from text field test

[45362](https://github.com/flutter/flutter/pull/45362) Add widget of the week video embeddings


## Text & Accessibility

In Text and Accessibility, we have several enhancements in ButtonBar and AlertDialog to prevent text overflow.

[40468](https://github.com/flutter/flutter/pull/40468) Propagate textfield character limits to semantics

[41730](https://github.com/flutter/flutter/pull/41730) Allow customization of label styles for semantics debugger

[42344](https://github.com/flutter/flutter/pull/42344) Add onVisible callback to snackbar.

[42368](https://github.com/flutter/flutter/pull/42368) Update android semantics test to match existing engine behavior.

[43193](https://github.com/flutter/flutter/pull/43193) ButtonBar aligns in column when it overflows horizontally

[43226](https://github.com/flutter/flutter/pull/43226) Implement AlertDialog title/content overflow scroll

[38573](https://github.com/flutter/flutter/pull/38573) Clamp scrollOffset to prevent textfield bouncing

[41108](https://github.com/flutter/flutter/pull/41108) Fixing a text editing bug happening when text field changes.

[44605](https://github.com/flutter/flutter/pull/44605) Changing RenderEditable.textAlign doesn't break hot reload anymore


## Animation & Scroll

For animation, we released the
[TweenAnimationBuilder]({{site.api}}/flutter/widgets/TweenAnimationBuilder-class.html)
for building custom implicit animations. For more information,
check out this [TweenAnimationBuilder video](https://www.youtube.com/watch?reload=9&v=6KiPEqzJIKQ) on Youtube.  

[38317](https://github.com/flutter/flutter/pull/38317) TweenAnimationBuilder for building custom animations without managing an AnimationController

[38979](https://github.com/flutter/flutter/pull/38979) Adding onEnd callback to implicit animated widgets

[43756](https://github.com/flutter/flutter/pull/43756) Mark routes as opaque when added without animation

[39142](https://github.com/flutter/flutter/pull/39142) fix sliverfixedextent with sliverchildbuilderdelegate does not correc…

[44965](https://github.com/flutter/flutter/pull/44965) Scroll scrollable to keep focused control visible.


## Web

We increased our support for web, moving it from the dev channel to the beta channel. For more details, please check [web support blog post](https://medium.com/flutter/web-support-for-flutter-goes-beta-35b64a1217c0).

[37819](https://github.com/flutter/flutter/pull/37819) Add HtmlElementView (the Flutter Web platform view)

[38723](https://github.com/flutter/flutter/pull/38723) Handle compilation failures from web application

[38823](https://github.com/flutter/flutter/pull/38823) Print service url when connecting to web applications

[39006](https://github.com/flutter/flutter/pull/39006) Add web workflow to default validators

[39066](https://github.com/flutter/flutter/pull/39066) Kill resident runner on browser disconnect.

[39073](https://github.com/flutter/flutter/pull/39073) Add profile mode to flutter web applications

[39189](https://github.com/flutter/flutter/pull/39189) fix source map loading and service protocol for flutter web

[39344](https://github.com/flutter/flutter/pull/39344) Upstream changes necessary for text editing in flutter web

[39364](https://github.com/flutter/flutter/pull/39364) Correct libraries path and remove dart:io and dart:isolate for dart platform

[39414](https://github.com/flutter/flutter/pull/39414) Make sure profile is forwarded through build web command

[39462](https://github.com/flutter/flutter/pull/39462) Remove run in shell and add unit test for chrome launching

[39543](https://github.com/flutter/flutter/pull/39543) create .dart_tool if it is missing

[39628](https://github.com/flutter/flutter/pull/39628) Automatically generated registrants for web plugins

[39748](https://github.com/flutter/flutter/pull/39748) print launching on device message

[39751](https://github.com/flutter/flutter/pull/39751) Minor cleanup and prevent multiple exit

[39752](https://github.com/flutter/flutter/pull/39752) Add delay to recompile request for web

[39756](https://github.com/flutter/flutter/pull/39756) remove web flag from create

[39774](https://github.com/flutter/flutter/pull/39774) workaround for mangled web sdk source map packages

[39910](https://github.com/flutter/flutter/pull/39910) If there are no web plugins, don't generate a plugin registrant

[39950](https://github.com/flutter/flutter/pull/39950) Register reload sources call and make 'r' restart for web

[39951](https://github.com/flutter/flutter/pull/39951) Add "web" server device to allow running flutter for web on arbitrary browsers

[39983](https://github.com/flutter/flutter/pull/39983) Update the supported library set for Flutter for web

[39999](https://github.com/flutter/flutter/pull/39999) Disable the performance overlay for web

[40175](https://github.com/flutter/flutter/pull/40175) Ensure we send hot restart events for flutter web

[40191](https://github.com/flutter/flutter/pull/40191) add host and port to run configuration for web devices

[40301](https://github.com/flutter/flutter/pull/40301) Allow skipping webOnlyInitializePlatform in Flutter for Web

[40370](https://github.com/flutter/flutter/pull/40370) rename port to web-port and hostname to web-hostname

[40465](https://github.com/flutter/flutter/pull/40465) Pass --web-hostname and --web-port to release mode debugging options

[40627](https://github.com/flutter/flutter/pull/40627) Allow skipping chrome launch with --no-web-browser-launch

[40757](https://github.com/flutter/flutter/pull/40757) Fix visibility of web server device when Chrome is not available

[41222](https://github.com/flutter/flutter/pull/41222) Copy archived js part files out of dart_tool directory

[41347](https://github.com/flutter/flutter/pull/41347) Fix timing issues in initialization of web resident runner

[41386](https://github.com/flutter/flutter/pull/41386) Serve every html file under web

[41397](https://github.com/flutter/flutter/pull/41397) Keymap for Web

[41441](https://github.com/flutter/flutter/pull/41441) Exit resident web runner on compilation failure

[41545](https://github.com/flutter/flutter/pull/41545) Add analytics tracking for compile and refresh times for Flutter Web

[41618](https://github.com/flutter/flutter/pull/41618) Rename Server/web to Headless Server/headless-server

[41695](https://github.com/flutter/flutter/pull/41695) Add more information to cannot find Chrome message

[41815](https://github.com/flutter/flutter/pull/41815) [web] Make it clear that lowercase "r" can also perform hot restart

[41906](https://github.com/flutter/flutter/pull/41906) Ensure plugin registrants are generated in build_web

[41996](https://github.com/flutter/flutter/pull/41996) [web] Always send the route name even if it's null

[42144](https://github.com/flutter/flutter/pull/42144) Don't eagerly call runMain when --start-paused is provided to web application

[42260](https://github.com/flutter/flutter/pull/42260) Small cleanup of web code

[42289](https://github.com/flutter/flutter/pull/42289) Ensure precache web works on dev branch

[42531](https://github.com/flutter/flutter/pull/42531) Print correct hostname when web server is launched

[42676](https://github.com/flutter/flutter/pull/42676) [web] Update web runner message with flutter.dev/web

[42701](https://github.com/flutter/flutter/pull/42701) serve correct content type from debug server

[42857](https://github.com/flutter/flutter/pull/42857) Fix progress indicators for release/profile builds of web.

[42951](https://github.com/flutter/flutter/pull/42951) implement debugTogglePlatform for the web

[42970](https://github.com/flutter/flutter/pull/42970) Rename headless server to web server

[43214](https://github.com/flutter/flutter/pull/43214) For --profile builds on web, still use -O4 but unminified names.

[43573](https://github.com/flutter/flutter/pull/43573) Catch MissingPortFile from web tooling.

[43576](https://github.com/flutter/flutter/pull/43576) Enable usage of experimental incremental compiler for web

[44028](https://github.com/flutter/flutter/pull/44028) Support --no-resident on the web

[44263](https://github.com/flutter/flutter/pull/44263) Allow web server device to use extension if started with --start-paused

[44268](https://github.com/flutter/flutter/pull/44268) Switch from using app.progress to app.webLaunchUrl for passing web launch urls

[44421](https://github.com/flutter/flutter/pull/44421) switch web test to macOS

[44744](https://github.com/flutter/flutter/pull/44744) Ensure web-server does not force usage of dwds

[44746](https://github.com/flutter/flutter/pull/44746) Remove chrome device web integration test

[44830](https://github.com/flutter/flutter/pull/44830) Update manual_tests to be able to run on macOS/web

[45145](https://github.com/flutter/flutter/pull/45145) cache sdkNameAndVersion logic for web devices

[45286](https://github.com/flutter/flutter/pull/45286) Fix experimental incremental web compiler for Windows

[11360](https://github.com/flutter/engine/pull/11360) build legacy web SDK

[11421](https://github.com/flutter/engine/pull/11421) sync Flutter Web engine to the latest

[11732](https://github.com/flutter/engine/pull/11732) last flutter web sync: cc38319841

[11796](https://github.com/flutter/engine/pull/11796) Provide a hook for a plugin handler to receive messages on the web

[12161](https://github.com/flutter/engine/pull/12161) Ensure that the web image ImageShader implements Shader

[12335](https://github.com/flutter/engine/pull/12335) [Web] Implement dark mode support for web

[12445](https://github.com/flutter/engine/pull/12445) [web] filter test targets; cache host.dart compilation

[12712](https://github.com/flutter/engine/pull/12712) Support correct keymap for web

[12747](https://github.com/flutter/engine/pull/12747) Add web implementation for channel_buffers.dart

[12753](https://github.com/flutter/engine/pull/12753) [web] Don't require felt to be in PATH

[12794](https://github.com/flutter/engine/pull/12794) [web] Add support for path transform

[12811](https://github.com/flutter/engine/pull/12811) [web] Implement basic radial gradient (TileMode.clamp, no transform)

[13003](https://github.com/flutter/engine/pull/13003) [web] Update the url when route is replaced

[13066](https://github.com/flutter/engine/pull/13066) [web] Add basic color per vertex drawVertices API support

[13141](https://github.com/flutter/engine/pull/13141) Enable/tweak web sdk source maps

[13161](https://github.com/flutter/engine/pull/13161) Enable/tweak web sdk source maps, take 2

[13187](https://github.com/flutter/engine/pull/13187) [web] Environment variable to disable felt snapshot

[13190](https://github.com/flutter/engine/pull/13190) [web] Fix canvas reuse metrics. Refactor drawVertices code.

[13259](https://github.com/flutter/engine/pull/13259) [web] Support -j to use goma in felt build

[13268](https://github.com/flutter/engine/pull/13268) [web] Support input action

[13272](https://github.com/flutter/engine/pull/13272) [web] [test] Adding firefox install functionality to the test platform

[13296](https://github.com/flutter/engine/pull/13296) [web] Cupertino dynamic color fix.

[13359](https://github.com/flutter/engine/pull/13359) Web: fix Color subclass handling

[13462](https://github.com/flutter/engine/pull/13462) [web] Get the size from visualviewport instead of window.innerHeight/innerW…

[13483](https://github.com/flutter/engine/pull/13483) web: fix Paragraph.getBoxesForRange for zero-length ranges

[13634](https://github.com/flutter/engine/pull/13634) [web] Ignore changes in *.ttf files in felt build watch mode

[13699](https://github.com/flutter/engine/pull/13699) [web] Don't send keyboard events from text fields to flutter

[13722](https://github.com/flutter/engine/pull/13722) [web] Proper support for text field's obscureText

[13741](https://github.com/flutter/engine/pull/13741) [web] Refactor text editing to handle any order of platform messages gracefully

[13748](https://github.com/flutter/engine/pull/13748) [web] Support gif/webp animations, Speed up image drawing in BitmapCanvas.

[13769](https://github.com/flutter/engine/pull/13769) [web] Implement TextStyle.shadows

[13779](https://github.com/flutter/engine/pull/13779) [web] Fix path to svg for drrect

[13802](https://github.com/flutter/engine/pull/13802) [web] Fix selectable text rendering

[13809](https://github.com/flutter/engine/pull/13809) [web] Fix blendmode for images

[13860](https://github.com/flutter/engine/pull/13860) [web] Change canvas sibling transforms to 3d with z=0 to get around canvas rendering bug.

[13901](https://github.com/flutter/engine/pull/13901) [web] Fix single line bitmap canvas text shadow

[13909](https://github.com/flutter/engine/pull/13909) [web] Implement PathMetrics.length

[13922](https://github.com/flutter/engine/pull/13922) [web] Flutter for web autocorrect support

[13929](https://github.com/flutter/engine/pull/13929) [web] Allow users to enable canvas text measurement

[13940](https://github.com/flutter/engine/pull/13940) [web] Fix Edge detection for correct dom_renderer reset

[13960](https://github.com/flutter/engine/pull/13960) [web] Fix default line-height issue for Firefox

[13981](https://github.com/flutter/engine/pull/13981) [web] use Element.nodes instead of Element.children in text layout

[2119](https://github.com/flutter/plugins/pull/2119) Add web url launcher


## Desktop

We are also moving macOS support from tech preview to alpha, enabling it in the dev channel. For more details,  please see [flutter.dev/desktop](https://github.com/flutter/flutter/wiki/Desktop-shells).

[37901](https://github.com/flutter/flutter/pull/37901) [macos] Check for special keys before creating a logical key

[38748](https://github.com/flutter/flutter/pull/38748) Create correctly structured framework for macOS

[38858](https://github.com/flutter/flutter/pull/38858) Use GLFW-name artifacts on Windows and Linux

[38909](https://github.com/flutter/flutter/pull/38909) Add support for macOS release/profile mode (3 of 3)

[39017](https://github.com/flutter/flutter/pull/39017) Add "OneSequenceRecognizer.resolvePointer". Fix DragGestureRecognizer crash on multiple pointers

[39264](https://github.com/flutter/flutter/pull/39264) Add profile support on macOS

[39432](https://github.com/flutter/flutter/pull/39432) Do not hide .git in zip for Windows

[39702](https://github.com/flutter/flutter/pull/39702) Fix macOS App.framework version symlink

[39836](https://github.com/flutter/flutter/pull/39836) Switch to the Win32 Windows embedding

[40011](https://github.com/flutter/flutter/pull/40011) [windows] Searches for pre-release and 'all' Visual Studio installations

[40186](https://github.com/flutter/flutter/pull/40186) Add shortcuts and actions for default focus traversal

[40194](https://github.com/flutter/flutter/pull/40194) Add an ephemeral directory to Windows projects

[40197](https://github.com/flutter/flutter/pull/40197) [windows] Refactor to optimize vswhere queries

[40294](https://github.com/flutter/flutter/pull/40294) fix copy command and remove resolve sync for macOS assemble

[40375](https://github.com/flutter/flutter/pull/40375) Harden macOS build use of Xcode project getInfo

[40393](https://github.com/flutter/flutter/pull/40393) Convert build mode to lowercase in tool_backend

[40587](https://github.com/flutter/flutter/pull/40587) Add an ephemeral directory for Linux

[40730](https://github.com/flutter/flutter/pull/40730) Invalidate macOS pods on plugin changes

[40851](https://github.com/flutter/flutter/pull/40851) Support create for macOS (app and plugin)

[41015](https://github.com/flutter/flutter/pull/41015) Add the beginnings of plugin support for Windows and Linux

[41332](https://github.com/flutter/flutter/pull/41332) Prevent PointerEnter[or Exit]Event from erasing event.down value

[41551](https://github.com/flutter/flutter/pull/41551) Pass Linux build mode on command line

[41612](https://github.com/flutter/flutter/pull/41612) AOT support for Linux Desktop I: switch Linux builds to assemble

[41747](https://github.com/flutter/flutter/pull/41747) Add Profile entry to macOS Podfile

[42031](https://github.com/flutter/flutter/pull/42031) Rewrite MouseTracker's tracking and notifying algorithm

[42235](https://github.com/flutter/flutter/pull/42235) Reading deviceId for RawKeyEventDataAndroid event

[42487](https://github.com/flutter/flutter/pull/42487) refactor depfile usage and update linux rule

[42861](https://github.com/flutter/flutter/pull/42861) Add repeatCount to RawKeyEventDataAndroid

[42962](https://github.com/flutter/flutter/pull/42962) Remove linux-x64 unpack logic

[43238](https://github.com/flutter/flutter/pull/43238) Fixing focus traversal when the node options are empty

[43362](https://github.com/flutter/flutter/pull/43362) Allow rebuilding of docker image, re-enable deploy gallery macos

[43758](https://github.com/flutter/flutter/pull/43758) Split desktop config fallback variable by platform

[44130](https://github.com/flutter/flutter/pull/44130) Add command key bindings to macOS text editing and fix selection.

[44410](https://github.com/flutter/flutter/pull/44410) Add macOS fn key support.

[44576](https://github.com/flutter/flutter/pull/44576) [ci] Use the latest Cirrus Image for macOS

[44620](https://github.com/flutter/flutter/pull/44620) Bump memory requirements for tool_tests-general-linux

[44844](https://github.com/flutter/flutter/pull/44844) Properly interpret modifiers on GLFW key events

[45264](https://github.com/flutter/flutter/pull/45264) Add macOS hot reload test

[45392](https://github.com/flutter/flutter/pull/45392) [ci] more resources to Windows tasks

[8507](https://github.com/flutter/engine/pull/8507) Add texture support for macOS shell.

[11324](https://github.com/flutter/engine/pull/11324) Clean up Windows and Linux build output

[11327](https://github.com/flutter/engine/pull/11327) [Windows] Update API for alternative Windows shell platform implementation

[11380](https://github.com/flutter/engine/pull/11380) Use App.framework in macOS FlutterDartProject

[11386](https://github.com/flutter/engine/pull/11386) Allow non-resizable windows in GLFW embedding

[11475](https://github.com/flutter/engine/pull/11475) buildfix: support build windows release/profile mode(#32746)

[11828](https://github.com/flutter/engine/pull/11828) [Windows] Address #36422 by adding a context for async resource uploading

[12230](https://github.com/flutter/engine/pull/12230) Add an initial macOS version of FlutterAppDelegate

[12234](https://github.com/flutter/engine/pull/12234) [glfw/windows] Stops keeping track of input models

[12267](https://github.com/flutter/engine/pull/12267) [macos] Stops keeping track of text input models

[12276](https://github.com/flutter/engine/pull/12276) Add system font change listener for windows

[12423](https://github.com/flutter/engine/pull/12423) add windows embedding test

[12809](https://github.com/flutter/engine/pull/12809) Use the x64 host toolchain for x86 target gen_snapshot only on Linux

[12814](https://github.com/flutter/engine/pull/12814) Enable all engine test on windows

[13300](https://github.com/flutter/engine/pull/13300) Switch the MacOS Desktop embedder to using a thread configuration where the platform and render task runners are the same.

[13702](https://github.com/flutter/engine/pull/13702) Fix editing selection and deletion on macOS


## Framework

We’ve fixed many bugs in this release to improve the quality and stability of our framework. 

[38643](https://github.com/flutter/flutter/pull/38643) PlatformViewLink handles focus

[38699](https://github.com/flutter/flutter/pull/38699) fix widgetspan does not work with ellipsis in text widget

[38789](https://github.com/flutter/flutter/pull/38789) Fix DragTarget not being rebuilt when a rejected Draggable enters #38786

[38930](https://github.com/flutter/flutter/pull/38930) Implement system fonts system channel listener

[38936](https://github.com/flutter/flutter/pull/38936) Fix KeySet (and LogicalKeySet) hashCode calculation

[39059](https://github.com/flutter/flutter/pull/39059) Explain const values in MediaQuery test file

[39085](https://github.com/flutter/flutter/pull/39085) Make inspector details subtree depth configurable.

[39089](https://github.com/flutter/flutter/pull/39089) Correct InheritedTheme.captureAll() for multiple theme ancestors of the same type

[39195](https://github.com/flutter/flutter/pull/39195) respect reversed scroll views

[39252](https://github.com/flutter/flutter/pull/39252) Adds relayout option to CustomMultiChildLayout.

[39282](https://github.com/flutter/flutter/pull/39282) Expose text metrics in TextPainter.

[39354](https://github.com/flutter/flutter/pull/39354) Add IterableFlagsProperty and use it on proxy box classes

[39428](https://github.com/flutter/flutter/pull/39428) Replace doc example text

[39446](https://github.com/flutter/flutter/pull/39446) Add viewType to PlatformViewLink

[39844](https://github.com/flutter/flutter/pull/39844) Fix curve for popping heroes

[40099](https://github.com/flutter/flutter/pull/40099) Fix double.infinity serialization

[40105](https://github.com/flutter/flutter/pull/40105) Ensure frame is scheduled when root widget is attached

[40119](https://github.com/flutter/flutter/pull/40119) fix skips to include all channels

[40280](https://github.com/flutter/flutter/pull/40280) PlatformView: recreate surface if the controller changes

[40306](https://github.com/flutter/flutter/pull/40306) Restore offstage and ticker mode after hero pop and the from hero is null

[40609](https://github.com/flutter/flutter/pull/40609) Specify ifTrue and ifFalse for strut FlagProperty

[40635](https://github.com/flutter/flutter/pull/40635) Return WidgetSpans from getSpanForPosition

[40638](https://github.com/flutter/flutter/pull/40638) Allow sending platform messages from plugins to the framework and implement EventChannel

[40709](https://github.com/flutter/flutter/pull/40709) Fixed Selectable text align is broken

[40718](https://github.com/flutter/flutter/pull/40718) Handle CR+LF end of line sequences in the license parser

[40775](https://github.com/flutter/flutter/pull/40775) Use EdgeInsetsGeometry instead of EdgeInsets

[40917](https://github.com/flutter/flutter/pull/40917) AnimatedBuilder API Doc improvements

[41145](https://github.com/flutter/flutter/pull/41145) Explicitly set CocoaPods version

[41245](https://github.com/flutter/flutter/pull/41245) Change the way ActionDispatcher is found.

[41329](https://github.com/flutter/flutter/pull/41329) Refactor: Base tap gesture recognizer

[41417](https://github.com/flutter/flutter/pull/41417) Address previous comments, fix Intent.doNothing.

[41763](https://github.com/flutter/flutter/pull/41763) No longer rebuild Routes when MediaQuery updates

[41791](https://github.com/flutter/flutter/pull/41791) Refactor: Make MouseTracker test concise with some utility functions

[41803](https://github.com/flutter/flutter/pull/41803) Fixed media query issues and added test to prevent it from coming back

[41879](https://github.com/flutter/flutter/pull/41879) Make MouseTracker.sendMouseNotifications private

[42076](https://github.com/flutter/flutter/pull/42076) create gesture recognizers on attach and dispose on detach to avoid leaks

[42253](https://github.com/flutter/flutter/pull/42253) Change modal barrier to dismissing on tap up

[42484](https://github.com/flutter/flutter/pull/42484) Gradient transform

[42526](https://github.com/flutter/flutter/pull/42526) Improve routers performance

[42558](https://github.com/flutter/flutter/pull/42558) Use placeholder dimensions that reflect the final text layout

[42688](https://github.com/flutter/flutter/pull/42688) Source Code Comment Typo Fixes

[42777](https://github.com/flutter/flutter/pull/42777) Fix memory leak in TransitionRoute

[42879](https://github.com/flutter/flutter/pull/42879) Re-implement hardware keyboard text selection.

[42953](https://github.com/flutter/flutter/pull/42953) Soften layer breakage

[43006](https://github.com/flutter/flutter/pull/43006) Set default borderRadius to zero in ClipRRect (as documented)

[43246](https://github.com/flutter/flutter/pull/43246) Tap.dart: Fixes the spacing to the right side of reason

[43296](https://github.com/flutter/flutter/pull/43296) Skip failing test to green build

[43467](https://github.com/flutter/flutter/pull/43467) Fixed bug where we could accidently call a callback twice.

[43677](https://github.com/flutter/flutter/pull/43677) add libzip cache artifact

[43684](https://github.com/flutter/flutter/pull/43684) [flutter_runner] Use sky_engine from the topaz tree

[43685](https://github.com/flutter/flutter/pull/43685) Remove Poller class from flutter_tools

[43739](https://github.com/flutter/flutter/pull/43739) enable avoid_web_libraries_in_flutter

[43865](https://github.com/flutter/flutter/pull/43865) Reorder show and setEditingState calls to the IMM

[44150](https://github.com/flutter/flutter/pull/44150) Manually roll engine to unred the tree

[44217](https://github.com/flutter/flutter/pull/44217) Moving pointer event sanitizing to engine.

[44233](https://github.com/flutter/flutter/pull/44233) Remove yield from inherited model

[44408](https://github.com/flutter/flutter/pull/44408) Remove no longer needed clean up code

[44422](https://github.com/flutter/flutter/pull/44422) Remove TextRange, export it from dart:ui

[44490](https://github.com/flutter/flutter/pull/44490) Fix "node._relayoutBoundary == _relayoutBoundary" crash

[44611](https://github.com/flutter/flutter/pull/44611) Convert to TextPosition for getWordBoundary

[44617](https://github.com/flutter/flutter/pull/44617) Make disposing a ScrollPosition with pixels=null legal

[44622](https://github.com/flutter/flutter/pull/44622) Track and use fallback TextAffinity for null affinity platform TextSelections.

[44967](https://github.com/flutter/flutter/pull/44967) Try a mildly prettier FlutterError and make it less drastic in release mode

[45083](https://github.com/flutter/flutter/pull/45083) Fix draggable scrollable sheet scroll notification

[45240](https://github.com/flutter/flutter/pull/45240) implicit-casts:false in flutter_web_plugins

[45249](https://github.com/flutter/flutter/pull/45249) implicit-casts:false in flutter_goldens and flutter_goldens_client


## Engine

In this update, the core engine continues to see many improvements, including a fix that solves the long-requested scrolling performance issue on iPhoneX/Xs.  

[9386](https://github.com/flutter/engine/pull/9386) [glfw] Send the glfw key data to the framework.

[9498](https://github.com/flutter/engine/pull/9498) Notify framework to clear input connection when app is backgrounded (#35054).

[9806](https://github.com/flutter/engine/pull/9806) Reuse texture cache in ios_external_texture_gl.

[9864](https://github.com/flutter/engine/pull/9864) Add capability to add AppDelegate as UNUserNotificationCenterDelegate

[9888](https://github.com/flutter/engine/pull/9888) Provide dart vm initalize isolate callback so that children isolates belong to parent's isolate group.

[10154](https://github.com/flutter/engine/pull/10154) Started taking advantage of Skia's new copyTableData to avoid superfluous copies.

[10182](https://github.com/flutter/engine/pull/10182) Made flutter startup faster by allowing initialization to be parallelized

[10326](https://github.com/flutter/engine/pull/10326) copypixelbuffer causes crash

[10670](https://github.com/flutter/engine/pull/10670) Expose LineMetrics in dart:ui

[10945](https://github.com/flutter/engine/pull/10945) De-dup FILE output for each license

[11041](https://github.com/flutter/engine/pull/11041) Add a BroadcastStream to FrameTiming

[11049](https://github.com/flutter/engine/pull/11049) Release _ongoingTouches when FlutterViewController dealloc

[11062](https://github.com/flutter/engine/pull/11062) Provide a placeholder queue ID for the custom embedder task runner.

[11063](https://github.com/flutter/engine/pull/11063) Update ExternalViewEmbedder class comment.

[11070](https://github.com/flutter/engine/pull/11070) Platform View implemenation for Metal

[11210](https://github.com/flutter/engine/pull/11210) Add Chrome to Dockerfile

[11222](https://github.com/flutter/engine/pull/11222) Dont present session twice

[11224](https://github.com/flutter/engine/pull/11224) Update metal layer drawable size on relayout.

[11226](https://github.com/flutter/engine/pull/11226) Make firebase testlab always pass

[11228](https://github.com/flutter/engine/pull/11228) Re-enable firebase test and don't use google login

[11230](https://github.com/flutter/engine/pull/11230) Update tflite_native and language_model revisions to match the Dart SDK

[11256](https://github.com/flutter/engine/pull/11256) Upgrade compiler to Clang 10.

[11265](https://github.com/flutter/engine/pull/11265) make it possible to disable debug symbols stripping

[11270](https://github.com/flutter/engine/pull/11270) Reset NSNetService delegate to nil，when stop service.

[11283](https://github.com/flutter/engine/pull/11283) Fix objects equal to null not being detected as null

[11300](https://github.com/flutter/engine/pull/11300) Do not Prepare raster_cache if view_embedder is present

[11305](https://github.com/flutter/engine/pull/11305) Fix a segfault in EmbedderTest.CanSpecifyCustomTaskRunner

[11306](https://github.com/flutter/engine/pull/11306) Set FlutterMacOS podspec min version to 10.11

[11309](https://github.com/flutter/engine/pull/11309) Fix change_install_name.py to be GN-friendly

[11310](https://github.com/flutter/engine/pull/11310) When using a custom compositor, ensure the root canvas is flushed.

[11315](https://github.com/flutter/engine/pull/11315) Do not add null task observers

[11330](https://github.com/flutter/engine/pull/11330) Remove engine hash from the output artifact

[11355](https://github.com/flutter/engine/pull/11355) update sim script

[11356](https://github.com/flutter/engine/pull/11356) Remove engine hash from pom filename

[11361](https://github.com/flutter/engine/pull/11361) Include Java stack trace in method channel invocations

[11367](https://github.com/flutter/engine/pull/11367) Make message loop task entry containers thread safe

[11368](https://github.com/flutter/engine/pull/11368) Switch to an incremental runloop for GLFW

[11374](https://github.com/flutter/engine/pull/11374) Update scenarios readme

[11382](https://github.com/flutter/engine/pull/11382) Trivial: remove empty line in the pom file

[11384](https://github.com/flutter/engine/pull/11384) Account for root surface transformation on the surfaces managed by the external view embedder.

[11388](https://github.com/flutter/engine/pull/11388) Allow overriding the GLFW pixel ratio

[11392](https://github.com/flutter/engine/pull/11392) Wire up software rendering in the test compositor.

[11394](https://github.com/flutter/engine/pull/11394) Avoid root surface acquisition during custom composition with software renderer.

[11395](https://github.com/flutter/engine/pull/11395) Remove deprecated ThreadTest::GetThreadTaskRunner and use the newer CreateNewThread API.

[11416](https://github.com/flutter/engine/pull/11416) Shrink cirrus docker image: reduce RUN count, apt-get clean

[11419](https://github.com/flutter/engine/pull/11419) Support non-60 refresh rate on PerformanceOverlay

[11420](https://github.com/flutter/engine/pull/11420) Fix touchpad scrolling on Chromebook

[11423](https://github.com/flutter/engine/pull/11423) Add tracing of the number of frames in flight in the pipeline.

[11427](https://github.com/flutter/engine/pull/11427) Skip empty platform view overlays.

[11436](https://github.com/flutter/engine/pull/11436) update method for skia

[11456](https://github.com/flutter/engine/pull/11456) Update the ui.LineMetrics.height metric to be more useful to external users

[11473](https://github.com/flutter/engine/pull/11473) Add missing newline at EOF

[11489](https://github.com/flutter/engine/pull/11489) Ensure trailing newline before EOF in C++ sources

[11520](https://github.com/flutter/engine/pull/11520) Bitcode only for release

[11524](https://github.com/flutter/engine/pull/11524) Reuse texture cache in ios_external_texture_gl

[11528](https://github.com/flutter/engine/pull/11528) Strip bitcode from gen_snapshot

[11537](https://github.com/flutter/engine/pull/11537) Add check to enable metal for import

[11550](https://github.com/flutter/engine/pull/11550) Make Skia cache size channel respond with a value

[11554](https://github.com/flutter/engine/pull/11554) make engine, ui, and sdk rewriter inputs of dill construction

[11576](https://github.com/flutter/engine/pull/11576) Minor tweaks to the Doxygen theme.

[11622](https://github.com/flutter/engine/pull/11622) Include from font_asset_provider

[11635](https://github.com/flutter/engine/pull/11635) [flutter_runner] Port Expose ViewBound Wireframe Functionality

[11636](https://github.com/flutter/engine/pull/11636) [fidl][flutter_runner] Port Migrate to new fit::optional compatible APIs

[11638](https://github.com/flutter/engine/pull/11638) Update CanvasSpy::onDrawEdgeAAQuad for Skia API change

[11649](https://github.com/flutter/engine/pull/11649) [flutter] Port: Run handle wait completers on the microtask queue

[11654](https://github.com/flutter/engine/pull/11654) Append newlines to EOF of all translation units.

[11655](https://github.com/flutter/engine/pull/11655) Don't crash while loading improperly formatted fonts on Safari

[11669](https://github.com/flutter/engine/pull/11669) Add style guide and formatting information

[11717](https://github.com/flutter/engine/pull/11717) Return a JSON value for the Skia channel

[11722](https://github.com/flutter/engine/pull/11722) Quote the font family name whenever setting the font-family property.

[11736](https://github.com/flutter/engine/pull/11736) Add wasm to sky_engine

[11776](https://github.com/flutter/engine/pull/11776) [flutter_runner] Port over all the changes to the dart_runner cmx files

[11783](https://github.com/flutter/engine/pull/11783) completely strip bitcode

[11795](https://github.com/flutter/engine/pull/11795) Add a good reference source for font metrics.

[11804](https://github.com/flutter/engine/pull/11804) Incorporate View.setSystemGestureExclusionRects code review feedback from #11441

[11808](https://github.com/flutter/engine/pull/11808) Annotate nullability on FlutterEngine to make swift writing more ergonomic

[11835](https://github.com/flutter/engine/pull/11835) [CFE/VM] Fix merge/typo for bump to kernel version 29

[11839](https://github.com/flutter/engine/pull/11839) Remove ENABLE_BITCODE from Scenarios test app

[11842](https://github.com/flutter/engine/pull/11842) Fix RTL justification with newline by passing in full justify tracking var

[11847](https://github.com/flutter/engine/pull/11847) Add a sample unit test target to flutter runner

[11849](https://github.com/flutter/engine/pull/11849) Support building standalone far packages with autogen manifests

[11875](https://github.com/flutter/engine/pull/11875) [flutter_runner] Add common libs to the test far

[11877](https://github.com/flutter/engine/pull/11877) Finish plumbing message responses on method channels

[11880](https://github.com/flutter/engine/pull/11880) Handle new navigation platform messages

[11893](https://github.com/flutter/engine/pull/11893) Add @Keep annotation

[11899](https://github.com/flutter/engine/pull/11899) Improve input method and Unicode character display(#30661)

[12011](https://github.com/flutter/engine/pull/12011) Cherry-picks for 1.9.1

[12016](https://github.com/flutter/engine/pull/12016) [flutter_runner] Kernel platform files can now be built in topaz

[12023](https://github.com/flutter/engine/pull/12023) Fix multi span text ruler cache lookup failure.

[12026](https://github.com/flutter/engine/pull/12026) [flutter_runner] Plumb Flutter component arguments to the Dart entrypoint

[12034](https://github.com/flutter/engine/pull/12034) [flutter_runner] Refactor our build rules to make them more inline with topaz

[12048](https://github.com/flutter/engine/pull/12048) [flutter_runner] Generate symbols for the Dart VM profiler

[12054](https://github.com/flutter/engine/pull/12054) [flutter_runner] Port the accessibility bridge from Topaz

[12076](https://github.com/flutter/engine/pull/12076) Add a method to flutter_window_controller to destroy the current window.

[12080](https://github.com/flutter/engine/pull/12080) Don't quote generic font families

[12081](https://github.com/flutter/engine/pull/12081) Add GradientRadial paintStyle implementation

[12087](https://github.com/flutter/engine/pull/12087) Don't launch the observatory by default on each embedder unit-test invocation.

[12204](https://github.com/flutter/engine/pull/12204) Don't disable toString in release mode for dart:ui classes

[12205](https://github.com/flutter/engine/pull/12205) Don't load Roboto by default

[12218](https://github.com/flutter/engine/pull/12218) Namespace patched SDK names to not conflict with Topaz

[12222](https://github.com/flutter/engine/pull/12222) Do not generate kernel platform files on topaz tree

[12226](https://github.com/flutter/engine/pull/12226) [web_ui] add missing dispose handler for MethodCalls to flutter/platform_view

[12227](https://github.com/flutter/engine/pull/12227) [web_ui] PersistedPlatformView attribute update handling to enable resizing

[12228](https://github.com/flutter/engine/pull/12228) pin and auto-install chrome version

[12229](https://github.com/flutter/engine/pull/12229) Improve check to render (or not) a DRRect when inner falls outside of outer on RecordingCanvas

[12249](https://github.com/flutter/engine/pull/12249) Editable text fix

[12253](https://github.com/flutter/engine/pull/12253) Implement Base32Decode

[12256](https://github.com/flutter/engine/pull/12256) Do not assume Platform.script is a Dart source file during training.

[12257](https://github.com/flutter/engine/pull/12257) Re-enable ThreadChecker and fix associated failures

[12258](https://github.com/flutter/engine/pull/12258) Refactor and polish the 'felt' tool

[12269](https://github.com/flutter/engine/pull/12269) a11y: expose max character count for text fields

[12273](https://github.com/flutter/engine/pull/12273) Clean up after AppLifecycleTests

[12274](https://github.com/flutter/engine/pull/12274) Store screenshot test output as Cirrus artifacts; do fuzzy comparison of non-matching screenshot pixels

[12275](https://github.com/flutter/engine/pull/12275) Shuffle test order and repeat test runs once.

[12281](https://github.com/flutter/engine/pull/12281) optionally skip builds

[12282](https://github.com/flutter/engine/pull/12282) [flutter_runner] Change the path to artifacts

[12287](https://github.com/flutter/engine/pull/12287) Adds PluginRegistry to the C++ client wrapper API

[12288](https://github.com/flutter/engine/pull/12288) Include firefox in check to quote font families

[12289](https://github.com/flutter/engine/pull/12289) Fix flutter runner paths

[12303](https://github.com/flutter/engine/pull/12303) Add a build command to felt

[12306](https://github.com/flutter/engine/pull/12306) Fix the declaration of setSystemGestureExclusionRects to match the PlatformMessageHandler interface

[12307](https://github.com/flutter/engine/pull/12307) Cleanup in web_ui

[12308](https://github.com/flutter/engine/pull/12308) [flutter] Remove old A11y API's.

[12318](https://github.com/flutter/engine/pull/12318) Update canvaskit backend

[12319](https://github.com/flutter/engine/pull/12319) Add "type" to getDisplayRefreshRate protocol

[12320](https://github.com/flutter/engine/pull/12320) Fix continuous event polling in the GLFW event loop

[12323](https://github.com/flutter/engine/pull/12323) README for the felt tool

[12330](https://github.com/flutter/engine/pull/12330) Ensure DRRects without corners also draw.

[12336](https://github.com/flutter/engine/pull/12336) Check for index bounds in RTL handling for trailing whitespace runs.

[12340](https://github.com/flutter/engine/pull/12340) [flutter_runner] Do not use pre-builts just yet

[12342](https://github.com/flutter/engine/pull/12342) Update test to verify that secondary isolate gets shutdown before root isolate exits.

[12343](https://github.com/flutter/engine/pull/12343) [flutter_runner] Remove usages of shared snapshots from CC sources

[12345](https://github.com/flutter/engine/pull/12345) [flutter_runner] Port over the tuning advice for vulkan surface provider

[12346](https://github.com/flutter/engine/pull/12346) [flutter_runner] Move from runner context to component context

[12347](https://github.com/flutter/engine/pull/12347) [flutter_runner][async] Migrate dart/flutter to new async-loop APIs

[12348](https://github.com/flutter/engine/pull/12348) [flutter_runner] Port the new compilation trace from topaz

[12349](https://github.com/flutter/engine/pull/12349) [flutter_runner] Explicitly set |trace_skia| to false

[12350](https://github.com/flutter/engine/pull/12350) [flutter_runner] Port vulkan surface changes

[12355](https://github.com/flutter/engine/pull/12355) skip flaky test

[12363](https://github.com/flutter/engine/pull/12363) Track "mouse leave" event

[12375](https://github.com/flutter/engine/pull/12375) Sync dart_runner

[12395](https://github.com/flutter/engine/pull/12395) Update --dart-vm-flags whitelist to include --write-service-info and --sample-buffer-duration

[12403](https://github.com/flutter/engine/pull/12403) Don't send pointer events when the framework isn't ready yet

[12410](https://github.com/flutter/engine/pull/12410) Send TYPE_VIEW_FOCUSED for views with input focus.

[12412](https://github.com/flutter/engine/pull/12412) SkSL precompile

[12426](https://github.com/flutter/engine/pull/12426) Store fallback font names as a vector instead of a set.

[12431](https://github.com/flutter/engine/pull/12431) Interpret negative radii as 0 in recording_canvas.dart

[12432](https://github.com/flutter/engine/pull/12432) Work around Samsung keyboard issue

[12434](https://github.com/flutter/engine/pull/12434) delete golden files; switch to flutter/goldens

[12435](https://github.com/flutter/engine/pull/12435) add dart:html, dart:js, and dart:js_util to the copy of the Dart SDK used for analysis

[12443](https://github.com/flutter/engine/pull/12443) Force exit felt tool on sigint, sigterm

[12446](https://github.com/flutter/engine/pull/12446) Add support for JIT release mode

[12447](https://github.com/flutter/engine/pull/12447) Reflect selection changes in Firefox for text editing

[12448](https://github.com/flutter/engine/pull/12448) Make kDoNotResizeDimension public so framework can use it directly

[12450](https://github.com/flutter/engine/pull/12450) Adds support for 5 mouse buttons

[12453](https://github.com/flutter/engine/pull/12453) Adding Link SemanticsFlag

[12454](https://github.com/flutter/engine/pull/12454) Add .mskp file to binary format

[12470](https://github.com/flutter/engine/pull/12470) [web_ui] Check if a pointer is already down for the specific device

[12479](https://github.com/flutter/engine/pull/12479) Refactoring text_editing.dart

[12563](https://github.com/flutter/engine/pull/12563) Remove use of the blobs snapshot format from unittests

[12565](https://github.com/flutter/engine/pull/12565) Remove references to topaz

[12573](https://github.com/flutter/engine/pull/12573) [flutter_runner] Refactor thread_application pair to ActiveApplication

[12618](https://github.com/flutter/engine/pull/12618) Add isFocusable to SemanticsFlag

[12681](https://github.com/flutter/engine/pull/12681) Create a package-able incremental compiler

[12695](https://github.com/flutter/engine/pull/12695) Add onUnregistered callback in 'Texture' and 'FlutterTexture'

[12698](https://github.com/flutter/engine/pull/12698) [web_ui] Fixing invalid state bug for text editing

[12699](https://github.com/flutter/engine/pull/12699) Adding 'pub get' to the 'compile_xxxx.sh' in the Scenario app

[12700](https://github.com/flutter/engine/pull/12700) Add missing flag for embedder.

[12701](https://github.com/flutter/engine/pull/12701) Cleanup: Made a macro to assert ARC is enabled.

[12706](https://github.com/flutter/engine/pull/12706) Check for a null input method subtype

[12708](https://github.com/flutter/engine/pull/12708) Cleanup: Turned on NS_ASSUME_NONNULL_BEGIN for FlutterViewController.

[12710](https://github.com/flutter/engine/pull/12710) Set transparent background in textarea elements

[12725](https://github.com/flutter/engine/pull/12725) Expanded channel buffer resize to method channels.

[12728](https://github.com/flutter/engine/pull/12728) Remove unused import in the scenario app

[12730](https://github.com/flutter/engine/pull/12730) Stop setting the accessibility text if a node has SCOPES_ROUTE set.

[12733](https://github.com/flutter/engine/pull/12733) [flutter_runner] Make rd and rx uniform

[12746](https://github.com/flutter/engine/pull/12746) Send AccessibilityEvent.TYPE_VIEW_FOCUSED when input focus is set.

[12754](https://github.com/flutter/engine/pull/12754) Fix Metal builds by accounting for the updated SubmitFrame signature.

[12775](https://github.com/flutter/engine/pull/12775) Added some thread asserts to the code and made ios_surface_ safe since

[12777](https://github.com/flutter/engine/pull/12777) Fix Metal builds.

[12780](https://github.com/flutter/engine/pull/12780) Restart all modern Samsung keyboard IMM

[12783](https://github.com/flutter/engine/pull/12783) Add a unit-test to verify that root surface transformation affects platform view coordinates.

[12785](https://github.com/flutter/engine/pull/12785) Fix bug in package script and add dev_compiler to list

[12793](https://github.com/flutter/engine/pull/12793) Fixing selection issues in Firefox

[12797](https://github.com/flutter/engine/pull/12797) add option for bulk-updating screenshots; update screenshots (Work in progress

[12798](https://github.com/flutter/engine/pull/12798) [flutter_runner] Update the cmx files to include TZ support

[12799](https://github.com/flutter/engine/pull/12799) Disable EmbedderTest::CanLaunchAndShutdownMultipleTimes.

[12800](https://github.com/flutter/engine/pull/12800) Prettify all CMX files

[12801](https://github.com/flutter/engine/pull/12801) do not wrap font family name

[12802](https://github.com/flutter/engine/pull/12802) Build gen_snapshot with a 64-bit host toolchain even if the target platform is 32-bit

[12808](https://github.com/flutter/engine/pull/12808) Added an embedder example

[12813](https://github.com/flutter/engine/pull/12813) Unblock SIGPROF on flutter_tester start

[12816](https://github.com/flutter/engine/pull/12816) Enable sanitizer build variants.

[12821](https://github.com/flutter/engine/pull/12821) Update buildroot to pull in ubsan updates.

[12931](https://github.com/flutter/engine/pull/12931) remove references to package:_chrome

[12958](https://github.com/flutter/engine/pull/12958) Adding deviceId to KeyEventChannel enconding method

[12960](https://github.com/flutter/engine/pull/12960) Fix typo on channel buffer debug output.

[12974](https://github.com/flutter/engine/pull/12974) Support empty strings and vectors in standard codec

[12980](https://github.com/flutter/engine/pull/12980) Made _printDebug only happen on debug builds of the engine for now.

[12982](https://github.com/flutter/engine/pull/12982) Color matrix doc

[12986](https://github.com/flutter/engine/pull/12986) Prevent default when Tab is clicked

[12988](https://github.com/flutter/engine/pull/12988) Use the standard gen_snapshot target unless the platform requires host_targeting_host

[12989](https://github.com/flutter/engine/pull/12989) Unpublicize kDoNotResizeDimension

[12991](https://github.com/flutter/engine/pull/12991) Compile sanitizer suppressions list and file bugs as necessary.

[12999](https://github.com/flutter/engine/pull/12999) Started setting our debug background task id to invalid

[13001](https://github.com/flutter/engine/pull/13001) Missing link flag

[13004](https://github.com/flutter/engine/pull/13004) Allow embedders to disable causal async stacks in the Dart VM

[13005](https://github.com/flutter/engine/pull/13005) Auto-formatter fixes for [BUILD.gn](http://build.gn/) files

[13008](https://github.com/flutter/engine/pull/13008) Integration with more of Skia's SkShaper/SkParagraph APIs

[13009](https://github.com/flutter/engine/pull/13009) Fixing Link Semantics Typo

[13015](https://github.com/flutter/engine/pull/13015) Fire PlatformViewController FlutterView callbacks

[13042](https://github.com/flutter/engine/pull/13042) Add "felt clean" command

[13043](https://github.com/flutter/engine/pull/13043) Add a task runner for the Win32 embedding

[13044](https://github.com/flutter/engine/pull/13044) Support keyboard types on mobile browsers

[13047](https://github.com/flutter/engine/pull/13047) Allow embedders to specify arbitrary data to the isolate on launch.

[13049](https://github.com/flutter/engine/pull/13049) Ignore thread leaks from Dart VM in tsan instrumented builds.

[13053](https://github.com/flutter/engine/pull/13053) Set the Cirrus badge to only display status of the master branch.

[13056](https://github.com/flutter/engine/pull/13056) Put Metal renderer selection behind runtime flag and plist opt-in.

[13071](https://github.com/flutter/engine/pull/13071) [dart_aot_runner] Add support for generating dart_aot snapshots

[13074](https://github.com/flutter/engine/pull/13074) [dart_aot_runner] Add rules to generate dart_aot binaries

[13082](https://github.com/flutter/engine/pull/13082) java imports/style

[13085](https://github.com/flutter/engine/pull/13085) Print more output when gen_package fails

[13086](https://github.com/flutter/engine/pull/13086) Gen package output corrected

[13088](https://github.com/flutter/engine/pull/13088) felt: use rest args for specifying test targets

[13089](https://github.com/flutter/engine/pull/13089) cleanup gen_package.py

[13090](https://github.com/flutter/engine/pull/13090) Snapshot the felt tool for faster start-up

[13091](https://github.com/flutter/engine/pull/13091) Remove persistent cache unittest timeout

[13094](https://github.com/flutter/engine/pull/13094) Integrate more SkParagraph builder patches

[13096](https://github.com/flutter/engine/pull/13096) [dart_aot_runner] Use the host_toolchain to build kernels

[13097](https://github.com/flutter/engine/pull/13097) Update felt README

[13101](https://github.com/flutter/engine/pull/13101) [dart_aot_runner] Generate vmservice aotsnapshots

[13103](https://github.com/flutter/engine/pull/13103) [dart_aot_runner] Complete the port of dart_aot_runner

[13121](https://github.com/flutter/engine/pull/13121) Change IO thread shader cache strategy

[13122](https://github.com/flutter/engine/pull/13122) refactoring chrome_installer

[13123](https://github.com/flutter/engine/pull/13123) Upgrades the ICU version to 64.2

[13124](https://github.com/flutter/engine/pull/13124) Allow embedders to specify a render task runner description.

[13125](https://github.com/flutter/engine/pull/13125) add the dart:__interceptors library to the dart sdk

[13126](https://github.com/flutter/engine/pull/13126) [frontend_server] Include bytecode generation in the training run.

[13143](https://github.com/flutter/engine/pull/13143) Add flutter_tester binary to the CIPD package

[13144](https://github.com/flutter/engine/pull/13144) Document //flutter/runtime/dart_vm

[13151](https://github.com/flutter/engine/pull/13151) Remove incomplete static thread safety annotations.

[13153](https://github.com/flutter/engine/pull/13153) Make the Dart isolate constructor private.

[13154](https://github.com/flutter/engine/pull/13154) Fix an output file path for the frontend server package_incremental script

[13157](https://github.com/flutter/engine/pull/13157) Fix type error in SkVertices

[13159](https://github.com/flutter/engine/pull/13159) Move surface-based SceneBuilder implementation under surface/

[13162](https://github.com/flutter/engine/pull/13162) Document //flutter/runtime/dart_isolate.h

[13175](https://github.com/flutter/engine/pull/13175) Remove redundant call to updateEditingState in sendKeyEvent

[13176](https://github.com/flutter/engine/pull/13176) Add repeatCount to FlutterKeyEvent

[13177](https://github.com/flutter/engine/pull/13177) Update compiler to Clang 10.

[13182](https://github.com/flutter/engine/pull/13182) If we get a 'down' event, add that device to the active devices.

[13185](https://github.com/flutter/engine/pull/13185) Adding firefox_installer.dart

[13192](https://github.com/flutter/engine/pull/13192) Use window.devicePixelRatio in the CanvasKit backend

[13193](https://github.com/flutter/engine/pull/13193) Custom compositor layers must take into account the device pixel ratio.

[13196](https://github.com/flutter/engine/pull/13196) Document //flutter/runtime/dart_snapshot.h

[13207](https://github.com/flutter/engine/pull/13207) Wrap the text in text editing to fix selections.

[13209](https://github.com/flutter/engine/pull/13209) Preserve stdout colors of subprocesses run by felt

[13212](https://github.com/flutter/engine/pull/13212) Add trace events around custom compositor callbacks.

[13218](https://github.com/flutter/engine/pull/13218) Specify a human readable reason for an error from the embedder API.

[13232](https://github.com/flutter/engine/pull/13232) Avoid dereferencing IO manager weak pointers on the UI thread

[13237](https://github.com/flutter/engine/pull/13237) Do not attempt to drain the SkiaUnrefQueue in the destructor

[13238](https://github.com/flutter/engine/pull/13238) Allow embedders to update preferrred locales.

[13239](https://github.com/flutter/engine/pull/13239) Hold a reference to the Skia unref queue in UIDartState

[13240](https://github.com/flutter/engine/pull/13240) Update CanvasKit to 0.7.0 and flesh out painting

[13241](https://github.com/flutter/engine/pull/13241) Ignore *.obj files when gathering licenses

[13242](https://github.com/flutter/engine/pull/13242) Update harfbuzz to 2.6.2, Roll buildroot to a518e

[13255](https://github.com/flutter/engine/pull/13255) Fix NPE in accessibility bridge

[13261](https://github.com/flutter/engine/pull/13261) Updated license script to ignore testdata directories

[13265](https://github.com/flutter/engine/pull/13265) Ensure we call into Engine from the UI taskrunner in Shell::EngineHasLivePorts()

[13269](https://github.com/flutter/engine/pull/13269) Send flag modified events to the framework

[13270](https://github.com/flutter/engine/pull/13270) Add recipe changelog

[13274](https://github.com/flutter/engine/pull/13274) Fix decode feature detection in HtmlCodec

[13275](https://github.com/flutter/engine/pull/13275) Flesh out the CanvasKit backend some more

[13292](https://github.com/flutter/engine/pull/13292) Disable flaky test ShellTest_ReportTimingsIsCalled.

[13295](https://github.com/flutter/engine/pull/13295) Avoid accessing the Cocoa view on the GPU or IO task runners.

[13311](https://github.com/flutter/engine/pull/13311) [recipe] Upload opt flutter_tester

[13314](https://github.com/flutter/engine/pull/13314) Guarding EAGLContext used by Flutter

[13319](https://github.com/flutter/engine/pull/13319) Add FlutterEngineRunsAOTCompiledDartCode to the embedder API.

[13321](https://github.com/flutter/engine/pull/13321) Pass LinearTextFlag to SkFont - iOS13 letter spacing

[13337](https://github.com/flutter/engine/pull/13337) Bump dart/language_model to 9fJQZ0TrnAGQKrEtuL3-AXbUfPzYxqpN_OBHr9P4hE4C

[13342](https://github.com/flutter/engine/pull/13342) Intercept SystemSound.play platform message before it's sent.

[13345](https://github.com/flutter/engine/pull/13345) Expose platform view ID on embedder semantics node

[13360](https://github.com/flutter/engine/pull/13360) Turn on RasterCache based on view hierarchy

[13361](https://github.com/flutter/engine/pull/13361) Expand on CanvasKit backend more

[13364](https://github.com/flutter/engine/pull/13364) [flutter_runner] Remove the checks for libdart profiler symbols

[13367](https://github.com/flutter/engine/pull/13367) Delay metal drawable acquisition till frame submission.

[13391](https://github.com/flutter/engine/pull/13391) Implement basic Picture.toImage via BitmapCanvas

[13395](https://github.com/flutter/engine/pull/13395) fix fml_unittes is not run during presubmit

[13397](https://github.com/flutter/engine/pull/13397) [flutter_runner] Don't build far files twice

[13401](https://github.com/flutter/engine/pull/13401) Reformat [BUILD.gn](http://build.gn/) files to comply with the format checker presubmit script

[13405](https://github.com/flutter/engine/pull/13405) Make sure root surface transformations survive resetting the matrix directly in Flow.

[13406](https://github.com/flutter/engine/pull/13406) Fix the dry run mode of the GN format checker script

[13407](https://github.com/flutter/engine/pull/13407) Kick luci

[13419](https://github.com/flutter/engine/pull/13419) [dart_runner] Common libs need to exist for aot runner

[13424](https://github.com/flutter/engine/pull/13424) Add isRunningInRobolectricTest back

[13440](https://github.com/flutter/engine/pull/13440) Switch to Cirrus Dockerfile as CI

[13444](https://github.com/flutter/engine/pull/13444) Remove usage of yaml module from CIPD script

[13448](https://github.com/flutter/engine/pull/13448) Duplicate the directory fd in fml::VisitFiles

[13451](https://github.com/flutter/engine/pull/13451) Fix mDNS for iOS13

[13460](https://github.com/flutter/engine/pull/13460) [dart] Makes the intl services available

[13461](https://github.com/flutter/engine/pull/13461) CIPD needs the directory to be relative

[13464](https://github.com/flutter/engine/pull/13464) [recipe] Upload sky_engine to CIPD

[13468](https://github.com/flutter/engine/pull/13468) Pass the automaticallyRegisterPlugins flag to the FlutterEngine constructor in FlutterActivityTest

[13478](https://github.com/flutter/engine/pull/13478) use check_output instead of check_call

[13479](https://github.com/flutter/engine/pull/13479) Print the output

[13630](https://github.com/flutter/engine/pull/13630) Fix bug where Enter doesn't add new line in multi-line fields

[13642](https://github.com/flutter/engine/pull/13642) Issues/39832 reland

[13643](https://github.com/flutter/engine/pull/13643) Ensure that the CAMetalLayer FBO attachments can be read from.

[13649](https://github.com/flutter/engine/pull/13649) Add 'Cough' test font and support multiple test fonts.

[13695](https://github.com/flutter/engine/pull/13695) Fix Class.forName unchecked call warning

[13697](https://github.com/flutter/engine/pull/13697) Moves pointer event sanitizing to engine.

[13708](https://github.com/flutter/engine/pull/13708) Ensure that the device pixel ratio is taken into account with window metrics in physical pixels.

[13710](https://github.com/flutter/engine/pull/13710) Fix picture raster cache throttling

[13711](https://github.com/flutter/engine/pull/13711) Imagefilter wrapper object

[13719](https://github.com/flutter/engine/pull/13719) Fix NPE in splash screen lookup

[13727](https://github.com/flutter/engine/pull/13727) Add line boundary information to LineMetrics.

[13728](https://github.com/flutter/engine/pull/13728) Prefer SchedulerBinding.addTimingsCallback

[13731](https://github.com/flutter/engine/pull/13731) Expose the platform view mutator stack to custom compositors.

[13735](https://github.com/flutter/engine/pull/13735) Cleanup obsolete --strong option of front-end server

[13736](https://github.com/flutter/engine/pull/13736) libtxt: pass an RTL bool flag instead of a bidiFlags enum to measureText

[13742](https://github.com/flutter/engine/pull/13742) Only specify --no-link-platform when not specifying --aot, roll dart-lang sdk

[13744](https://github.com/flutter/engine/pull/13744) Create a new picture recorder even when the embedder supplied render target is recycled.

[13747](https://github.com/flutter/engine/pull/13747) Move TextRange from the framework to dart:ui.

[13760](https://github.com/flutter/engine/pull/13760) Implement Path.computeMetrics in the CanvasKit backend

[13762](https://github.com/flutter/engine/pull/13762) Turn on RasterCache based on view hierarchy

[13765](https://github.com/flutter/engine/pull/13765) Change wordBoundary to take dynamic temporarily

[13768](https://github.com/flutter/engine/pull/13768) Add ImageFilter and BackdropFilter to CanvasKit backend

[13772](https://github.com/flutter/engine/pull/13772) Move Path and PathMetrics from canvas.dart into their own files. No delta

[13780](https://github.com/flutter/engine/pull/13780) Allow passing hot reload debugging flags through

[13781](https://github.com/flutter/engine/pull/13781) Create a WeakPtrFactory for use on the UI thread in VsyncWaiter

[13782](https://github.com/flutter/engine/pull/13782) Document the coordinate space of points in FlutterPointerEvent.

[13784](https://github.com/flutter/engine/pull/13784) Add Helvetica and sans-serif as fallback font families

[13785](https://github.com/flutter/engine/pull/13785) Fix RendererContextSwitch result check in Rasterizer::MakeRasterSnapshot

[13786](https://github.com/flutter/engine/pull/13786) Take devicePixelRatio into account when drawing shadows

[13795](https://github.com/flutter/engine/pull/13795) Adds missing comma in EngineParagraphStyle.toString()

[13796](https://github.com/flutter/engine/pull/13796) implement radial gradient in canvaskit backend

[13799](https://github.com/flutter/engine/pull/13799) Update version of dart/language_model distributed with flutter engine to latest

[13803](https://github.com/flutter/engine/pull/13803) [build] Make --engine-version flag optional

[13805](https://github.com/flutter/engine/pull/13805) Remove extra shadows from ParagraphStyle

[13812](https://github.com/flutter/engine/pull/13812) RendererContextSwitch guard flutter's gl context rework.

[13829](https://github.com/flutter/engine/pull/13829) [dart_runner] Initialize logging and tracing

[13832](https://github.com/flutter/engine/pull/13832) Remove unused import

[13848](https://github.com/flutter/engine/pull/13848) Use Skia's matchStyleCSS3 to find bundled asset typefaces matching a font style

[13850](https://github.com/flutter/engine/pull/13850) Fix test to account for pixel ratio transformations being framework responsibility.

[13851](https://github.com/flutter/engine/pull/13851) Implement the rest of ui.Path methods for CanvasKit

[13869](https://github.com/flutter/engine/pull/13869) Changing test runner and platform to be browser independent

[13881](https://github.com/flutter/engine/pull/13881) Change edge conditions of getLineBoundary

[13902](https://github.com/flutter/engine/pull/13902) Adding opacity -> alpha method to Color class

[13903](https://github.com/flutter/engine/pull/13903) Implement basic text rendering support in CanvasKit backend

[13904](https://github.com/flutter/engine/pull/13904) Fix withIn matcher distance function lookup

[13907](https://github.com/flutter/engine/pull/13907) allow ignoring toString, hashCode, and == in api_conform_test

[13908](https://github.com/flutter/engine/pull/13908) Made a way to turn off the OpenGL operations on the IO thread for backgrounded apps

[13918](https://github.com/flutter/engine/pull/13918) Add virtual destructor to GPUSurfaceSoftwareDelegate.

[13926](https://github.com/flutter/engine/pull/13926) Add dev_compiler and frontend_server to package uploading rule

[13934](https://github.com/flutter/engine/pull/13934) Ensure we use the base CompositorContext's AcquireFrame method when screenshotting

[13943](https://github.com/flutter/engine/pull/13943) Made the thread checker print out the thread names on Apple platforms.

[13945](https://github.com/flutter/engine/pull/13945) Update SwiftShader to 5d1e854.

[13962](https://github.com/flutter/engine/pull/13962) Added auto-reviewer config file

[13975](https://github.com/flutter/engine/pull/13975) Refactor to passing functions by const ref

[14082](https://github.com/flutter/engine/pull/14082) add pointer data santizing in flutter web engine


## Plugins

We have made significant improvements in our plugins. We upgraded a set of plugins to support web development. Also, to support Add to App scenarios, we have a new set of APIs available for existing Android plugins to be upgraded to. If you are currently maintaining an Android plugin. We encourage you to check the [Migrating your plugin to the new APIs](http://flutter.dev/go/android-plugin-migration) documentation, and upgrade your plugins accordingly.

[1984](https://github.com/flutter/plugins/pull/1984) Remove Flutterfire plugins (moved to FirebaseExtended)

[2004](https://github.com/flutter/plugins/pull/2004) [cirrus] Use flutter create for all_plugins test

[2009](https://github.com/flutter/plugins/pull/2009) Fix unit test for sensors

[2036](https://github.com/flutter/plugins/pull/2036) video player version fix

[2055](https://github.com/flutter/plugins/pull/2055) Point opensource site at new location

[2084](https://github.com/flutter/plugins/pull/2084) [update] local_auth - intl version

[2112](https://github.com/flutter/plugins/pull/2112) Run flutter_plugin_tools format

[2141](https://github.com/flutter/plugins/pull/2141) BugFix: formatHint was meant for network streams.

[2154](https://github.com/flutter/plugins/pull/2154) Use stable Flutter image as base

[2161](https://github.com/flutter/plugins/pull/2161) Rename instrumentation_adapter plugin to e2e plugin

[2205](https://github.com/flutter/plugins/pull/2205) s/flutter_android_lifecycle/flutter_plugin_android_lifecycle/

[2230](https://github.com/flutter/plugins/pull/2230) Forbid ... implements UrlLauncherPlatform

[2231](https://github.com/flutter/plugins/pull/2231) [cleanup] Remove AndroidX warning

[2236](https://github.com/flutter/plugins/pull/2236) Use package import to import files inside lib/ directory.

[2250](https://github.com/flutter/plugins/pull/2250) Run the publish with the pub version from flutter stable

[2260](https://github.com/flutter/plugins/pull/2260) Make setMockInitialValues handle non-prefixed keys

[2267](https://github.com/flutter/plugins/pull/2267) Bump google_maps_flutter pubspec version to match CHANGELOG

[2271](https://github.com/flutter/plugins/pull/2271) [infra] Ignore analyzer issues in CI

[2280](https://github.com/flutter/plugins/pull/2280) Add google_sign_in_web plugin.


#### Plugin: Android Alarm Manager

We added the ability to get id in the callback in the Android Alarm Manager plugin.

[1985](https://github.com/flutter/plugins/pull/1985) [android_alarm_manager] Added ability to get id in the callback


#### Plugin: Android Intent

We made several improvements in the Android Intent plugin including adding the ability to pass intent flags (contributed by a community member!), and upgrading it to the [new plugin API](https://github.com/flutter/website/blob/staging-add-to-app-do-not-delete-until-2020/src/docs/development/packages-and-plugins/plugin-api-migration.md).

[2000](https://github.com/flutter/plugins/pull/2000) [android_intent] add flags option

[2045](https://github.com/flutter/plugins/pull/2045) [android_intent] Add action_application_details_settings

[2143](https://github.com/flutter/plugins/pull/2143) [android_intent] Migrate to the new embedding

[2188](https://github.com/flutter/plugins/pull/2188) [android_intent] Bump the Flutter SDK min version

[2202](https://github.com/flutter/plugins/pull/2202) [android_intent] componentName must be provided before resolveActivity is called

[2221](https://github.com/flutter/plugins/pull/2221) [android_intent]remove AndroidX constraint

[2268](https://github.com/flutter/plugins/pull/2268) [android_intent] Add missing DartDocs


#### Plugin: Battery

General bug fix in the Battery plugin.

[2189](https://github.com/flutter/plugins/pull/2189) [battery] relax the example app minimal required Flutter version


#### Plugin: Camera

We upgraded the Camera plugin to the [new plugin API](https://github.com/flutter/website/blob/staging-add-to-app-do-not-delete-until-2020/src/docs/development/packages-and-plugins/plugin-api-migration.md), and made some bug fixes.

[2057](https://github.com/flutter/plugins/pull/2057) [Camera] Fixes NullPointerException

[2123](https://github.com/flutter/plugins/pull/2123) [camera] Fix event type check

[2219](https://github.com/flutter/plugins/pull/2219) [camera]remove androidx constraint


#### Plugin: Connectivity

General bug fixes in the Connectivity plugin.

[2212](https://github.com/flutter/plugins/pull/2212) [connectivity]remove AndroidX constraint

[2262](https://github.com/flutter/plugins/pull/2262) [connectivity] add more documentations, delete example/README


#### Plugin: e2e

General bug fixes in the e2e plugin.

[2022](https://github.com/flutter/plugins/pull/2022) [instrumentation_adapter] Update README instructions

[2023](https://github.com/flutter/plugins/pull/2023) [instrumentation_adapter] update boilerplate to use @Rule instead of FlutterTest

[2024](https://github.com/flutter/plugins/pull/2024) [instrumentation_adapter] update CODEOWNERS

[2051](https://github.com/flutter/plugins/pull/2051) [instrumentation_adapter] update for release

[2075](https://github.com/flutter/plugins/pull/2075) [instrumentation_adapter] Migrate example to AndroidX

[2178](https://github.com/flutter/plugins/pull/2178) [e2e] update README

[2190](https://github.com/flutter/plugins/pull/2190) [e2e] Update to support new embedder

[2233](https://github.com/flutter/plugins/pull/2233) [e2e] update README


#### Plugin: Google Maps Flutter

We have made several improvements in the Google Maps plugin including adding support for displaying the traffic layer. 

[1702](https://github.com/flutter/plugins/pull/1702) [google_maps_flutter]Marker drag event

[1767](https://github.com/flutter/plugins/pull/1767) [google_maps_flutter] Adds support for displaying the traffic layer

[1784](https://github.com/flutter/plugins/pull/1784) [google_maps_flutter] Allow (de-)serialization of CameraPosition

[1933](https://github.com/flutter/plugins/pull/1933) [google_maps_flutter] Avoid unnecessary redraws

[2053](https://github.com/flutter/plugins/pull/2053) [google_maps_flutter] Fix analyzer failures relating to prefer_const_constructors

[2065](https://github.com/flutter/plugins/pull/2065) [google_maps_flutter] Prefer const constructors.

[2076](https://github.com/flutter/plugins/pull/2076) [google_maps_flutter] Clone cached elements in GoogleMap

[2108](https://github.com/flutter/plugins/pull/2108) [google_maps_flutter] Add Projection methods to google_maps

[2113](https://github.com/flutter/plugins/pull/2113) [google_maps_flutter] Avoid AbstractMethod crash

[2242](https://github.com/flutter/plugins/pull/2242) [google_maps_flutter] Cast error.code to unsigned long to avoid using NSInteger as %ld format warnings.


#### Plugin: Google Sign In

We made some bug fixes in Google Sign in plugin. Meanwhile, we have converted it into a federated plugin to help it scale more efficiently to multiple platforms. For more information, please refer to [Federated Plugin Implementation](https://docs.google.com/document/d/1LD7QjmzJZLCopUrFAAE98wOUQpjmguyGTN2wd_89Srs/edit#).

[2059](https://github.com/flutter/plugins/pull/2059) [google_sign_in] Fix chained async methods in error handling zones

[2127](https://github.com/flutter/plugins/pull/2127) [google_sign_in] Fix deprecated API usage issue by upgrading CocoaPod to 5.0

[2244](https://github.com/flutter/plugins/pull/2244) [google_sign_in] Move plugin to its subdir to allow for federated implementations

[2252](https://github.com/flutter/plugins/pull/2252) [google_sign_in] Handle new style URLs in GoogleUserCircleAvatar

[2266](https://github.com/flutter/plugins/pull/2266) [google_sign_in] Port plugin to use the federated Platform Interface


#### Plugin: Image Picker

General bug fixes in the Image Picker plugin.

[2070](https://github.com/flutter/plugins/pull/2070) [image_picker] swap width and height when source image orientation is left or right

[2293](https://github.com/flutter/plugins/pull/2293) [image_picker]fix a crash when a non-image file is picked.


#### Plugin: In App Purchase

General bug fixes in the In App Purchase plugin.

[2014](https://github.com/flutter/plugins/pull/2014) [In_App_Purchase] Avoids possible NullPointerException with background registrations.

[2016](https://github.com/flutter/plugins/pull/2016) [In_App_Purchase] Improve testability

[2027](https://github.com/flutter/plugins/pull/2027) [in_app_purchase] Remove skipped driver test

[2215](https://github.com/flutter/plugins/pull/2215) [in_app_purchase] remove AndroidX constraint


#### Plugin: Local Auth

General bug fixes in the Local Auth plugin.

[2047](https://github.com/flutter/plugins/pull/2047) [local_auth] Avoid user confirmation on face unlock

[2111](https://github.com/flutter/plugins/pull/2111) [local_auth] Api to stop authentication


#### Plugin: Package Info

General bug fixes in the Package Info plugin.

[2218](https://github.com/flutter/plugins/pull/2218) [package_info]remove AndroidX constraint


#### Plugin: Path Provider

In the Path Provider plugin, we added getApplicationLibraryDirectory, which is contributed by a community member!

[1953](https://github.com/flutter/plugins/pull/1953) [path_provider] add getApplicationLibraryDirectory

[1993](https://github.com/flutter/plugins/pull/1993) [pathprovider] Fix fall through bug

[2288](https://github.com/flutter/plugins/pull/2288) [path_provider] Add missing DartDocs


#### Plugin: Share

Documentation update in the Share plugin.

[2297](https://github.com/flutter/plugins/pull/2297) [share] README update


#### Plugin: Shared Preferences

General bug fixes in the Shared Preferences plugin.

[2241](https://github.com/flutter/plugins/pull/2241) [Shared_preferences]suppress warnings

[2296](https://github.com/flutter/plugins/pull/2296) [shared_preferences] Add missing DartDoc


#### Plugin: Url Launcher

We upgraded the Url Launcher plugin to the [new plugin API](https://github.com/flutter/website/blob/staging-add-to-app-do-not-delete-until-2020/src/docs/development/packages-and-plugins/plugin-api-migration.md), and made some bug fixes. Meanwhile, we have converted the Url launcher into a federated plugin to help it scale more efficiently to multiple platforms. For more information, please refer to [Federated Plugin Implementation](https://docs.google.com/document/d/1LD7QjmzJZLCopUrFAAE98wOUQpjmguyGTN2wd_89Srs/edit#).

[2038](https://github.com/flutter/plugins/pull/2038) [url_launcher] Removed reference to rootViewController during initialization

[2136](https://github.com/flutter/plugins/pull/2136) [url_launcher_web] Fix [README.md](http://readme.md/) pubspec example

[2217](https://github.com/flutter/plugins/pull/2217) [url_launcher] Add url_launcher_platform_interface package

[2220](https://github.com/flutter/plugins/pull/2220) [url_launcher]remove AndroidX constraint

[2228](https://github.com/flutter/plugins/pull/2228) [url_launcher] Use url_launcher_platform_interface to handle calls

[2237](https://github.com/flutter/plugins/pull/2237) [url_launcher] Migrate url_launcher_web to the platform interface

[2274](https://github.com/flutter/plugins/pull/2274) [url_launcher] DartDoc and test improvements


#### Plugin: Video Player

We upgraded the Video Player plugin to the [new plugin API](https://github.com/flutter/website/blob/staging-add-to-app-do-not-delete-until-2020/src/docs/development/packages-and-plugins/plugin-api-migration.md), and made some bug fixes. Meanwhile, we have converted it into a federated plugin to help it scale more efficiently to multiple platforms. For more information, please refer to [Federated Plugin Implementation](https://docs.google.com/document/d/1LD7QjmzJZLCopUrFAAE98wOUQpjmguyGTN2wd_89Srs/edit#).

[1813](https://github.com/flutter/plugins/pull/1813) [video-player] add support for content uris as urls

[1998](https://github.com/flutter/plugins/pull/1998) [video_player] Fix deprecated member use

[2124](https://github.com/flutter/plugins/pull/2124) [video_player] Move [player dispose] to onUnregistered

[2158](https://github.com/flutter/plugins/pull/2158) [video_player] Basic test for VideoPlayerController initialization

[2273](https://github.com/flutter/plugins/pull/2273) [video_player] Add platform interface

[2286](https://github.com/flutter/plugins/pull/2286) [video_player] Improve DartDocs and test coverage


#### Plugin: Webview Flutter

We upgraded the Webview Flutter plugin to the [new plugin API](https://github.com/flutter/website/blob/staging-add-to-app-do-not-delete-until-2020/src/docs/development/packages-and-plugins/plugin-api-migration.md), and made some bug fixes.

[1996](https://github.com/flutter/plugins/pull/1996) [webview_flutter] Allow underscores anywhere for Javascript Channel name

[2257](https://github.com/flutter/plugins/pull/2257) [webview_flutter] Add async NavigationDelegates


## Tooling

Flutter tooling is another big investment in this release. We launched a new version of [DartPad](http://dartpad.dev) that allows you to play with Flutter directly in your browser without installing anything, released a new feature “Hot UI” (in preview) that allows you to interact with widgets directly in the IDE, enhanced Dart DevTools with a new visual layout view, enabled simultaneous multi-device debugging in Visual Studio Code, and added support for “golden” image testing.

In addition to the PRs listed below, please also check out the following releases for the IntelliJ and Android Studio Flutter plugin, the VS Code Flutter plugin and Dart DevTools:


### VS Code



*   10/1/2019: [dartcode.org/releases/v3-5/](https://dartcode.org/releases/v3-5/)
*   11/1/2019: [dartcode.org/releases/v3-6/](https://dartcode.org/releases/v3-6/)
*   12/5/2019: [dartcode.org/releases/v3-7/](https://dartcode.org/releases/v3-7/)


### Flutter IntelliJ and Android Studio plugin



*   10/1/2019: Flutter IntelliJ Plugin [M40 Release](https://groups.google.com/d/msg/flutter-dev/s2AxzJ2TbkU/RC3S508rBwAJ)
*   11/1/2019: Flutter IntelliJ Plugin [M41 Release](https://groups.google.com/d/msg/flutter-dev/4TSSi_niovs/piNoRPr6EgAJ)
*   12/5/2019: Flutter IntelliJ Plugin [M42 Release](https://groups.google.com/forum/#!topic/flutter-announce/EmOelPrGwGo)


### DevTools



*   10/2/2019: New Dart DevTools [Release 0.1.8](https://groups.google.com/d/msg/flutter-dev/J6zDXzZOsts/vOWn7mcWCgAJ)
*   10/17/2019: New Dart DevTools [Release 0.1.9](https://groups.google.com/d/msg/flutter-dev/WuzEEENGsXU/zb0IDhkhDgAJ)
*   11/8/2019: New Dart DevTools [Release 0.1.11](https://groups.google.com/d/msg/flutter-dev/VdAni_rhpS4/UP3mBH-2AAAJ)
*   12/6/2019: New Dart DevTools [Release 0.1.12](https://groups.google.com/forum/#!topic/flutter-dev/EGLBgQAOoC8)


### Tooling PRs

[37508](https://github.com/flutter/flutter/pull/37508) build bundle with assemble

[37642](https://github.com/flutter/flutter/pull/37642) Unit test for build.dart::GenSnapshot

[37832](https://github.com/flutter/flutter/pull/37832) add --exit and --match-host-platform defaults to devicelab runner

[37845](https://github.com/flutter/flutter/pull/37845) echo error messages to stderr

[38560](https://github.com/flutter/flutter/pull/38560) refactor cocoapods validator to detect broken install

[38576](https://github.com/flutter/flutter/pull/38576) flutter_tools/version: git log.showSignature=false

[38632](https://github.com/flutter/flutter/pull/38632) Flutter Plugin Tool supports multi-platform plugin config

[38654](https://github.com/flutter/flutter/pull/38654) [flutter_tool] Remove some async file io

[38869](https://github.com/flutter/flutter/pull/38869) Store file hashes per build configuration.

[38894](https://github.com/flutter/flutter/pull/38894) [flutter_tool] Move http request close under try-catch

[38907](https://github.com/flutter/flutter/pull/38907) Throw error when hot reload enters bad state

[38920](https://github.com/flutter/flutter/pull/38920) [flutter_tool] Handle crashes from doctor validators

[38925](https://github.com/flutter/flutter/pull/38925) [flutter_tool] Only send one crash report per run

[38932](https://github.com/flutter/flutter/pull/38932) Add build warning for non-debug desktop builds

[39000](https://github.com/flutter/flutter/pull/39000) Dont throw StateError when calling assemble

[39005](https://github.com/flutter/flutter/pull/39005) [flutter_tool] Teach crash reporter about HttpException

[39013](https://github.com/flutter/flutter/pull/39013) Update package versions to latest

[39052](https://github.com/flutter/flutter/pull/39052) Make forward calls run interactively

[39136](https://github.com/flutter/flutter/pull/39136) [flutter_tool] Some additional input validation for 'version'

[39140](https://github.com/flutter/flutter/pull/39140) Move commands into their own shard

[39147](https://github.com/flutter/flutter/pull/39147) Downgrade the AndroidX warning

[39274](https://github.com/flutter/flutter/pull/39274) Use output dir instead of specific paths in assemble rules

[39280](https://github.com/flutter/flutter/pull/39280) [flutter_tool] Use a timeout for xcode showBuildSettings

[39358](https://github.com/flutter/flutter/pull/39358) surface errors from build runner

[39445](https://github.com/flutter/flutter/pull/39445) [flutter_tool] Add onError callback to asyncGuard. Use it in Doctor

[39524](https://github.com/flutter/flutter/pull/39524) Register flutterVersion service in flutter_tools.

[39530](https://github.com/flutter/flutter/pull/39530) keep symbols for profile

[39541](https://github.com/flutter/flutter/pull/39541) Handle single unsupported device

[39555](https://github.com/flutter/flutter/pull/39555) Use feature flags to control build command visibility

[39558](https://github.com/flutter/flutter/pull/39558) Filter error message from skip build script checks

[39579](https://github.com/flutter/flutter/pull/39579) [flutter_tools] Add a timeout to another showBuildSettings command

[39654](https://github.com/flutter/flutter/pull/39654) Use persisted build information to automatically clean old outputs

[39699](https://github.com/flutter/flutter/pull/39699) Detecting when installing over MingW's Git Bash, fixing paths

[39781](https://github.com/flutter/flutter/pull/39781) Add lib/generated_plugin_registrant.dart to gitignore

[39782](https://github.com/flutter/flutter/pull/39782) Allow specifying a project for Xcode getInfo

[39899](https://github.com/flutter/flutter/pull/39899) [flutter_tool] process.dart cleanup

[39997](https://github.com/flutter/flutter/pull/39997) Remove visibleForTesting annotation; this constructor is used outside…

[40029](https://github.com/flutter/flutter/pull/40029) [BUG] Process all children of intent-filter instead of just the first one to identify default activity

[40131](https://github.com/flutter/flutter/pull/40131) ensure we use pub from flutter SDK

[40159](https://github.com/flutter/flutter/pull/40159) [flutter_tool] Kill a timing-out process before trying to drain its streams

[40171](https://github.com/flutter/flutter/pull/40171) Place hot reload artifacts in a temp directory

[40195](https://github.com/flutter/flutter/pull/40195) Make Swift plugin template swift-format compliant

[40210](https://github.com/flutter/flutter/pull/40210) make sure we launch with dwds

[40259](https://github.com/flutter/flutter/pull/40259) remove io and isolate from libraries

[40366](https://github.com/flutter/flutter/pull/40366) Place existing dill into hot reload temp directory to boost initialization time

[40368](https://github.com/flutter/flutter/pull/40368) ensure dart2js does not compile unsupported packages

[40397](https://github.com/flutter/flutter/pull/40397) Adds list required components when VS is not installed

[40410](https://github.com/flutter/flutter/pull/40410) Remove fluter tool usage of protobuf

[40435](https://github.com/flutter/flutter/pull/40435) [flutter_tool] Remove the synchronous -showBuildSettings

[40472](https://github.com/flutter/flutter/pull/40472) Dont kill other processes when starting desktop application

[40783](https://github.com/flutter/flutter/pull/40783) ensure debug builds are only accessible through run

[40795](https://github.com/flutter/flutter/pull/40795) Update toolchain description to request the latest version

[40968](https://github.com/flutter/flutter/pull/40968) add missing trailing commas in flutter_tools

[40988](https://github.com/flutter/flutter/pull/40988) [flutter_tool] Report rss high watermark in command analytics events

[41224](https://github.com/flutter/flutter/pull/41224) fix flutter error report correct local widget

[41304](https://github.com/flutter/flutter/pull/41304) [flutter_tools] Allows adding multiple signal handlers

[41401](https://github.com/flutter/flutter/pull/41401) Flutter build bundle without --precompiled should always perform a debug build.

[41406](https://github.com/flutter/flutter/pull/41406) Retry devfs uploads in case they fail.

[41424](https://github.com/flutter/flutter/pull/41424) Don't update last compiled time when compilation is rejected

[41447](https://github.com/flutter/flutter/pull/41447) Switch to assemble API for dart2js

[41493](https://github.com/flutter/flutter/pull/41493) [flutter_tool] Report to analytics when the tool is killed by a signal

[41514](https://github.com/flutter/flutter/pull/41514) Ensure we find dart.exe on local engines

[41519](https://github.com/flutter/flutter/pull/41519) Make desktop stopApp only apply to processes Flutter started

[41583](https://github.com/flutter/flutter/pull/41583) Add debugging option to write vmservice address to file after starting

[41610](https://github.com/flutter/flutter/pull/41610) track unused inputs in build_runner

[41621](https://github.com/flutter/flutter/pull/41621) change logging in mDNS discovery to verbose-mode only

[41652](https://github.com/flutter/flutter/pull/41652) [flutter_tools] Add more info to pub get failure event

[41687](https://github.com/flutter/flutter/pull/41687) Use processManager.run() instead of manually capturing streams in test_utils getPackages()

[41697](https://github.com/flutter/flutter/pull/41697) Handle missing .packages file in the flutter tool for prebuilt artifacts

[41735](https://github.com/flutter/flutter/pull/41735) handle empty entry in asset list and add more explicit validation

[41751](https://github.com/flutter/flutter/pull/41751) Add support for downloading x86 JIT release artifact

[41788](https://github.com/flutter/flutter/pull/41788) Reduce log verbosity by removing individual used files

[41832](https://github.com/flutter/flutter/pull/41832) Plumb --enable-asserts through to frontend_server invocation in debug…

[41862](https://github.com/flutter/flutter/pull/41862) Make output directory a build input

[41989](https://github.com/flutter/flutter/pull/41989) Flutter doctor should require java 1.8+

[42008](https://github.com/flutter/flutter/pull/42008) Restructure ProjectFileInvalidator.findInvalidated a bit

[42016](https://github.com/flutter/flutter/pull/42016) [flutter_tool] Re-work analytics events to use labels and values

[42026](https://github.com/flutter/flutter/pull/42026) Stop leaking iproxy processes

[42028](https://github.com/flutter/flutter/pull/42028) Make ProjectFileInvalidator.findInvalidated able to use the async FileStat.stat

[42187](https://github.com/flutter/flutter/pull/42187) Be more verbose when pub fails

[42209](https://github.com/flutter/flutter/pull/42209) Add error logging to flutter generate

[42243](https://github.com/flutter/flutter/pull/42243) Improve trailing whitespace message

[42252](https://github.com/flutter/flutter/pull/42252) catch argument error from Make

[42353](https://github.com/flutter/flutter/pull/42353) Add --cache-sksl flag to drive and run

[42354](https://github.com/flutter/flutter/pull/42354) Pass -Ddart.developer.causal_async_stacks=true to frontend_server invocations.

[42364](https://github.com/flutter/flutter/pull/42364) Wrap dwds in async guard, only catch known error types

[42373](https://github.com/flutter/flutter/pull/42373) Switch build commands to use process utils

[42376](https://github.com/flutter/flutter/pull/42376) Add option to precache unsigned mac binaries.

[42471](https://github.com/flutter/flutter/pull/42471) Pass build mode-specific bytecode generation options to frontend_server.

[42476](https://github.com/flutter/flutter/pull/42476) Refactor BuildMode into class, add jit_release configuration

[42491](https://github.com/flutter/flutter/pull/42491) Extra defensive programming for pub modification time assert

[42538](https://github.com/flutter/flutter/pull/42538) [flutter_tool] Improve yaml font map validation

[42597](https://github.com/flutter/flutter/pull/42597) Deflake wildcard asset test

[42655](https://github.com/flutter/flutter/pull/42655) resident_web_runner doesn't close debug connection

[42656](https://github.com/flutter/flutter/pull/42656) Catch appInstanceId error

[42668](https://github.com/flutter/flutter/pull/42668) dispose devices on cleanupAtFinish() for run_cold.dart

[42698](https://github.com/flutter/flutter/pull/42698) Ensure we stop the status when browser connection is complete

[42791](https://github.com/flutter/flutter/pull/42791) fix type error in manifest asset bundle

[42813](https://github.com/flutter/flutter/pull/42813) Fix NPE in Chrome Device

[42972](https://github.com/flutter/flutter/pull/42972) Do not produce an error when encountering a new type in a service response.

[42977](https://github.com/flutter/flutter/pull/42977) switch dart2js build to depfile, remove Source.function

[43016](https://github.com/flutter/flutter/pull/43016) ensure we can disable --track-widget-creation in debug mode

[43022](https://github.com/flutter/flutter/pull/43022) Enable dump-skp-on-shader-compilation in drive

[43042](https://github.com/flutter/flutter/pull/43042) add samsungexynos7570 to list of known physical devices

[43080](https://github.com/flutter/flutter/pull/43080) Indent Kotlin code with 4 spaces

[43180](https://github.com/flutter/flutter/pull/43180) Adding missing break in plugin validation check

[43217](https://github.com/flutter/flutter/pull/43217) [flutter_tool] Update analytics policy, send event on disable

[43219](https://github.com/flutter/flutter/pull/43219) Add devfs for incremental compiler JavaScript bundle

[43225](https://github.com/flutter/flutter/pull/43225) Catch io.StdinException from failure to set stdin echo/line mode

[43281](https://github.com/flutter/flutter/pull/43281) Add compiler configuration to support dartdevc target

[43292](https://github.com/flutter/flutter/pull/43292) initial bootstrap script for incremental compiler support

[43381](https://github.com/flutter/flutter/pull/43381) [flutter_tool] Use engine flutter_runner prebuilts

[43390](https://github.com/flutter/flutter/pull/43390) catch ChromeDebugException from dwds

[43401](https://github.com/flutter/flutter/pull/43401) Handle permission error during flutter clean

[43402](https://github.com/flutter/flutter/pull/43402) Handle format error from vswhere

[43403](https://github.com/flutter/flutter/pull/43403) Handle version and option skew errors

[43436](https://github.com/flutter/flutter/pull/43436) Handle onError callback with optional argument

[43448](https://github.com/flutter/flutter/pull/43448) Don't html-escape in the plugin registrant templates.

[43471](https://github.com/flutter/flutter/pull/43471) flip track widget creation on by default

[43544](https://github.com/flutter/flutter/pull/43544) Catch AppConnectionException

[43546](https://github.com/flutter/flutter/pull/43546) Alias upgrade-packages => update-packages

[43577](https://github.com/flutter/flutter/pull/43577) set trace to true for desktop builds

[43586](https://github.com/flutter/flutter/pull/43586) Ensure Chrome is closed on tab close

[43598](https://github.com/flutter/flutter/pull/43598) Catch failed daemon startup error

[43599](https://github.com/flutter/flutter/pull/43599) catch failure to parse FLUTTER_STORAGE_BASE_URL

[43602](https://github.com/flutter/flutter/pull/43602) Don't indefinitely persist file hashes, handle more error conditions

[43667](https://github.com/flutter/flutter/pull/43667) Added a null check for ranges in the sourceReport map.

[43725](https://github.com/flutter/flutter/pull/43725) Add reloadMethod RPC

[43753](https://github.com/flutter/flutter/pull/43753) pass --no-gen-bytecode to aot kernel compiler invocations

[43764](https://github.com/flutter/flutter/pull/43764) Update create.dart

[43767](https://github.com/flutter/flutter/pull/43767) check if libimobiledevice executables exist

[43800](https://github.com/flutter/flutter/pull/43800) de-flake logger test

[43862](https://github.com/flutter/flutter/pull/43862) Ensure target platform is passed is always passed

[43870](https://github.com/flutter/flutter/pull/43870) check for instanceof instead of runtimeType

[43907](https://github.com/flutter/flutter/pull/43907) Serve correct mime type on release dev server

[43908](https://github.com/flutter/flutter/pull/43908) remove no-gen-bytecode flag

[43945](https://github.com/flutter/flutter/pull/43945) Remove Source.behavior, fix bug in depfile invalidation

[44017](https://github.com/flutter/flutter/pull/44017) Asset server fix for sourcemaps

[44027](https://github.com/flutter/flutter/pull/44027) Allow specifying device-vmservice-port and host-vmservice-port

[44032](https://github.com/flutter/flutter/pull/44032) Copy chrome preferences to seeded data dir

[44052](https://github.com/flutter/flutter/pull/44052) Remove flutter_tool services code

[44083](https://github.com/flutter/flutter/pull/44083) Add --dart-define option

[44119](https://github.com/flutter/flutter/pull/44119) [flutter_tool] --flutter_runner will download the debug symbols

[44146](https://github.com/flutter/flutter/pull/44146) Remove flutter.yaml migration code

[44200](https://github.com/flutter/flutter/pull/44200) Make ProjectFileInvalidator injectable

[44221](https://github.com/flutter/flutter/pull/44221) Use platform appropriate filepaths

[44227](https://github.com/flutter/flutter/pull/44227) [flutter_tool] Screenshot command must require device only for _kDeviceType

[44278](https://github.com/flutter/flutter/pull/44278) Do not pass obsolete --strong option to front-end server

[44279](https://github.com/flutter/flutter/pull/44279) link platform should be true for profile

[44360](https://github.com/flutter/flutter/pull/44360) [flutter_tool] Stream artifact downloads to files

[44447](https://github.com/flutter/flutter/pull/44447) implicit-casts:false on flutter_tools/lib

[44481](https://github.com/flutter/flutter/pull/44481) Provide specific field to accept depfiles in target class

[44488](https://github.com/flutter/flutter/pull/44488) Refactorings to testbed.run and testbed.test

[44574](https://github.com/flutter/flutter/pull/44574) Print a message when modifying settings that you may need to reload IDE/editor

[44608](https://github.com/flutter/flutter/pull/44608) Reduce some direct package:archive usage

[44753](https://github.com/flutter/flutter/pull/44753) Always link desktop platforms

[44868](https://github.com/flutter/flutter/pull/44868) Catch and display version check errors during doctor

[44933](https://github.com/flutter/flutter/pull/44933) [flutter_tool] Don't crash when failing to delete downloaded artifacts

[44966](https://github.com/flutter/flutter/pull/44966) Don't log stack traces to console on build failures

[45011](https://github.com/flutter/flutter/pull/45011) catch IOSDeviceNotFoundError in IOSDevice.startApp()

[45153](https://github.com/flutter/flutter/pull/45153) implicit-casts:false on flutter_tools

[45236](https://github.com/flutter/flutter/pull/45236) Improve time to development by initializing frontend_server concurrently with platform build

[45239](https://github.com/flutter/flutter/pull/45239) implicit-casts:false in fuchsia_remote_debug_protocol

[45303](https://github.com/flutter/flutter/pull/45303) Allow unknown fields in pubspec plugin section

[45317](https://github.com/flutter/flutter/pull/45317) de-null dartDefines in daemon mode

[45319](https://github.com/flutter/flutter/pull/45319) catch parse error from corrupt config

[45364](https://github.com/flutter/flutter/pull/45364) Allow a no-op default_package key for a plugin platform

[45407](https://github.com/flutter/flutter/pull/45407) Don't crash if the tool cannot delete asset directory

[46011](https://github.com/flutter/flutter/pull/46011) [flutter_tool] Do not continue with a no-op 'upgrade'


## Full PR List

 See the [full list](/docs/development/tools/sdk/release-notes/changelogs/changelog-1.12.13) of merged PRs for the 1.12 release.


[breaking change policy on the Flutter wiki]: {{site.github}}/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes
[flutter-announce]: https://groups.google.com/g/flutter-announce
[GitHub Octoverse report]: https://octoverse.github.com/
[this post from Ian Hickson]: https://groups.google.com/g/flutter-announce/c/Z09a317E21o
