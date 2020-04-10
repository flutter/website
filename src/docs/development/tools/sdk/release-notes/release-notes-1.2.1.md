---
title: Flutter 1.2.1 release notes
short-title: 1.2.1 release notes
description: Release notes for Flutter 1.2.1.
---

Our #1 priority since the Flutter v1.0 release has been to
continue to address high priority issues reported both by
Flutter developers and the Flutter team itself.
This includes committing 672 pull requests in the Flutter
engine and framework since December (we've been busy!).
We've called out the new features and breaking changes
that we think are noteworthy below. The biggest ones came
from our Framework and Tool tags, but we also found and
fixed a couple of Severe issues as well.

## Framework

To more fully round-out Flutter's animation support,
this release adds several more of the standard easing functions:

[#25788](https://github.com/flutter/flutter/pull/25788) Add Robert Penner's easing functions

To integrate more fully with Android,
this release adds support for [Android App Bundles][],
a new packaging format that helps in reducing app size
and enables new features like dynamic delivery for Android apps:

[#24440](https://github.com/flutter/flutter/pull/24440) Adding support for android app bundle

To integrate more fully with iOS, this release adds several new features and fixes for iOS, including a new CupertinoTheme:

[#25183](https://github.com/flutter/flutter/pull/25183) Add navigatorKey to CupertinoTabView

[#25593](https://github.com/flutter/flutter/pull/25593) Let CupertinoTabScaffold handle keyboard insets too

[#24876](https://github.com/flutter/flutter/pull/24876) Adds a fade in and out, rounds corners, fixes offset and fixes height of cursor on iOS

[#23759](https://github.com/flutter/flutter/pull/23759) Adds CupertinoTheme

In addition to the iOS Cupertino theme support, this release continues to enhance the Material theme as well:

[#24169](https://github.com/flutter/flutter/pull/24169) [Material] Theme-able elevation on dialogs

[#25339](https://github.com/flutter/flutter/pull/25339) [Material] Theme-able TextStyles for AlertDialog

To integrate more fully with desktop form-factors like Android tablets and ChromeOS as well as desktop web and desktop OS support, this release builds more support for keyboard and mouse as first class input devices: 

[#7758](https://github.com/flutter/engine/pull/7758) Recommended implementation of combining characters implementation

[#27853](https://github.com/flutter/flutter/pull/27853) Hook up character events and unmodified code points to Android raw key event handling

[#27620](https://github.com/flutter/flutter/pull/27620) Add a keyboard key code generator

[#27627](https://github.com/flutter/flutter/pull/27627) Adding support for logical and physical key events

[#6961](https://github.com/flutter/engine/pull/6961) Add hover event support to the engine

[#24830](https://github.com/flutter/flutter/pull/24830) Implement hover support for mouse pointers

As widgets are the core way to interact with users in Flutter, this release continues to add features and fixes to the Flutter widget set with particular attention paid to the [SliverAppBar](https://docs.flutter.io/flutter/material/SliverAppBar-class.html):

[#26021](https://github.com/flutter/flutter/pull/26021) Fix SliverAppBar title opacity and test all cases

[#26101](https://github.com/flutter/flutter/pull/26101) Fix a floating snapping SliverAppBar crash

[#25091](https://github.com/flutter/flutter/pull/25091) Add animations to SliverAppBar doc

[#24736](https://github.com/flutter/flutter/pull/24736) Provide some more locations for the FAB

[#25585](https://github.com/flutter/flutter/pull/25585) Expose font fallback API in TextStyle, Roll engine 54a3577c0139..215ca1560088

[#24457](https://github.com/flutter/flutter/pull/24457) Revise Android and iOS gestures on Material TextField

[#24554](https://github.com/flutter/flutter/pull/24554) Adds force press gesture detector and recognizer

[#23919](https://github.com/flutter/flutter/pull/23919) Allow detection of taps on TabBar

[#25384](https://github.com/flutter/flutter/pull/25384) Adds support for floating cursor

[#24976](https://github.com/flutter/flutter/pull/24976) Support TextField multi-line hint text

[#26332](https://github.com/flutter/flutter/pull/26332) Strut: fine tuned control over text minimum line heights, allows forcing the line height to be a specified height

And finally, as Flutter usage continues to grow world-wide, we continue to enhance support for localizations across several languages, including Ukrainian, Polish, Swahili and Galician in this release.

[#25394](https://github.com/flutter/flutter/pull/25394) Update localizations

[#27506](https://github.com/flutter/flutter/pull/27506) Added support for Swahili (material_sw.arb)

[#27352](https://github.com/flutter/flutter/pull/24876) Including Galician language


## Plug-Ins

As in the framework and engine itself, we're continuing to focus on plugin quality as well:

[flutter/engine#7317](https://github.com/flutter/engine/pull/7317) Fix stale GrContext for iOS platform views

[flutter/engine#7558](https://github.com/flutter/engine/pull/7558) Fix lost touch events for iOS platform views

[flutter/plugins#1157](https://github.com/flutter/plugins/pull/1157) [google_maps_flutter] Fix camera positioning issue on iOS

[flutter/plugins#1176](https://github.com/flutter/plugins/pull/1176) [firebase_auth] Fix Firebase phone auth on Android

[flutter/plugins#1037](https://github.com/flutter/plugins/pull/1037) [camera] Save photo orientation on iOS

[flutter/plugins#1129](https://github.com/flutter/plugins/pull/1129) [android_alarm_manager] Fix "background start not allowed" issues, queue events that are received too early

[flutter/plugins#1051 ](https://github.com/flutter/plugins/pull/1051)[image_picker] Fix crash on iOS when the picker is tapped multiple times

The webview_flutter plugin got a communication channel between Dart and JavaScript:

[flutter/plugins#1116](https://github.com/flutter/plugins/pull/1116) Add WebView JavaScript channels (Dart side)

[flutter/plugins#1130](https://github.com/flutter/plugins/pull/1130) WebView JavasScript channels Android implementation

[flutter/plugins#1139](https://github.com/flutter/plugins/pull/1139) WebView JavaScript channels - iOS implementation

[lutter/plugins1021](https://github.com/flutter/plugins/pull/1021) javascript evaluation ios/android

We've made progress building the In App Purchase plugin (which is still pre-release):

[#1057](https://github.com/flutter/plugins/pull/1057) [IAP] Check if the payment processor is available

[#1084](https://github.com/flutter/plugins/pull/1084) [IAP] Fetch SkuDetails from Google Play

[#1068](https://github.com/flutter/plugins/pull/1068) IAP productlist ios

[#1172](https://github.com/flutter/plugins/pull/1172) [In_app_purchase] add payment objc translators


## Dart

The release contains a new Dart SDK which provides support for a new set literals syntax and increases AOT performance 10-20% by reducing the overhead of calling constructors or static methods:

[#37](https://github.com/dart-lang/language/issues/37) Set Literal

[#33274](https://github.com/dart-lang/sdk/issues/33274) Add support for "naked" instructions: global object pool, pc-relative static calls, faster indirect calls, potential code sharing


## Tool

We've added a number of new tools and new features to existing tools in this release.

This release continues to improve error messages across a range of tools:

[#26107](https://github.com/flutter/flutter/pull/26107) Better error messages for flutter tool --dynamic flag

[#26084](https://github.com/flutter/flutter/pull/26084) Improve message when saving compilation training data

[#25863](https://github.com/flutter/flutter/pull/25863) Friendlier messages when using dynamic patching

This release also adds support for Java 1.8:

[#25470](https://github.com/flutter/flutter/pull/25470) Support Java 1.8


## Severe

In this release, we've found and fixed a few severe issues from the previous release, including two crashes and one performance degradation.

Crashes

[#7314](https://github.com/flutter/flutter/issues/7314) Flutter crash on startup (metabug)

Performance

[#25381](https://github.com/flutter/flutter/pull/25381) Add cull opacity perf test to device lab


## Breaking Changes

In an effort to continue to improve Flutter since 1.0 to meet customer needs, we have had to make a few breaking changes:

### [#8769](https://github.com/flutter/flutter/pull/8769) Rename ListItem to ListTile, document ListTile fixed height geometry

Many developers were confused by the fact that ListItem was fixed height. We've renamed it to ListTile, to indicate that (like other tiles) its height is fixed, and the documentation has been updated to clearly say that about ListTile. You'll need to rename instances of the ListItem class to ListTile in your code.

### [#7518](https://github.com/flutter/engine/pull/7518) Update default flutter_assets path for iOS embedding

Flutter assets for iOS applications are now found in Frameworks/App.framework/flutter_assets instead of flutter_assets. The flutter command line tool should take care of this difference, but if you are writing an AddToApp application for iOS that shares assets with Flutter, you'll need to be aware of this change.


### [#27697](https://github.com/flutter/flutter/pull/27697) Cupertino TextField Cursor Fix

CupertinoTextField's cursorColor default now matches the app's theme. If this is undesirable, developers can use the cupertinoOverrideTheme property of ThemeData to provide a Cupertino-specific override using a CupertinoThemeData object, e.g: 
 
```
Widget build(BuildContext context) { 
  // Set theme data for override in the CupertinoThemeData's constructor 
  Theme.of(context).cupertinoOverrideTheme = CupertinoThemeData(  
    brightness: Brightness.dark,  
    primaryColor: Color(0xFF42A5F5) 
  ); 
  return Text( 
    'Example', 
    style: Theme.of(context).textTheme.title, 
  ); 
}
```


### [#23424](https://github.com/flutter/flutter/pull/23424) Teach drag start behaviors to DragGestureRecognizer

By default, a drag gesture detector's onStart callback will be called with the location of where a drag gesture is detected (i.e. after dragging a certain number of pixels) instead of at the touch down location. To use the old functionality with a given drag gesture recognizer, the dragStartBehavior variable of the recognizer should be set DragStartBehavior.down, e.g., include the bolded line below when declaring your GestureDecorator:

```
GestureDectector( 
  dragStartBehavior: DragStartBehavior.down,
  onVerticalDragDown: myDragDown 
  onVerticalDragEnd: myDragEnd, 
  onVerticalDragStart: myDragStart, 
  onVerticalDragUpdate: myDragUpdate, 
  onVerticalDragCancel: myDragCancel, 
  onHorizontalDragDown: myDragDown 
  onHorizontalDragEnd: myDragEnd, 
  onHorizontalDragStart: myDragStart, 
  onHorizontalDragUpdate: myDragUpdate, 
  onHorizontalDragCancel: myDragCancel, 
// Other fields… 
```


### [#26238](https://github.com/flutter/flutter/pull/26238) Remove long-deprecated TwoLevelList

Removed the long-deprecated TwoLevelList widget; use ListView with ExpansionTile instead. See [this example](https://github.com/flutter/flutter/blob/master/examples/catalog/lib/expansion_tile_sample.dart) for a sample that uses ExpansionTile.


###[#7442](https://github.com/flutter/engine/pull/7442) Move Picture.toImage rasterization to the GPU thread

Picture.toImage now returns a `Future<Image>` instead. This permits image rasterization to occur on the GPU thread, improving performance in many cases and ensuring correct results. At a minimum, you'll need to declare methods invoking on Picture instances as async, and use await, like this:

```
`void usePictureImage(Picture p) async { 
  var image = await p.toImage(); 
  // Do something with the pixels in image…. 
}
```

However, your application may well be performing other asynchronous actions, and you should consider how you want to handle image processing in that light. For more on Dart's support for asynchronous programming and the Future class, see [https://www.dartlang.org/tutorials/language/futures.](https://www.dartlang.org/tutorials/language/futures.)


### [#7567](https://github.com/flutter/engine/pull/7567) Rename FlutterResult in embedder.h

In the Embedder API, the FlutterResult type has been renamed to FlutterEngineResult to better explain its purpose. You'll need to rename any instances of the former to the latter.


### [#7414](https://github.com/flutter/engine/pull/7414) Strut implementation

Rename dart:ui ParagraphStyle.lineHeight to ParagraphStyle.height. The ParagraphStyle.lineHeight property previously did not do anything and was renamed to stay consistent with TextStyle.height. You'll need to rename any instances of the former to the latter.


## Regressions

Soon after our 1.2 release, we found two regressions:


* [#28640](https://github.com/flutter/flutter/issues/28640) NoSuchMethodError: android.view.MotionEvent.isFromSource

[flutter/flutter#24830](https://github.com/flutter/flutter/pull/24830) ("Implement hover support for mouse pointers.") is using an Android API that doesn't exist on older devices. This can cause a crash on Android 4.1 (Jellybean) and 4.1 (Jellybean MR1).


* [#28484](https://github.com/flutter/flutter/issues/28484) Widget rendering strange since Flutter update

This can cause rendering issues when loading certain images on physical iOS devices.

To get a fix for these regressions, once beta 1.3 lands in March,  you can switch to the beta channel and perform a "flutter upgrade" at the command line. At the time of this writing, that will update you to at least version 1.3.8, which includes [flutter/engine#8006](https://github.com/flutter/engine/pull/8006) ("Guard against using Android API not defined in API level 16 & 17") and the Skia commit that fixes the rendering issue. For the crashing issue, the two affected versions of Android are more than ten years old and represent at most 2.5% of Android users, few of which are likely to be installing new Android applications, whether they're Flutter or not. Even so, we hate to leave known regressions in a stable release, but after much internal debate, we decided it was the best way to proceed for Flutter developers and their app users.

Our ideal fix for any serious issue is to create a "hotfix" release by taking an existing release and "cherry picking" the fixes that we'd like to apply. The ability to hotfix an existing stable release is something that we implemented for 1.2 but have not quite gotten to production quality. The consequence of this is that if we had created a new stable "1.2.1-a" release with the fix for the regressions, we'd have stranded all of our users at that branch; updating to future branches would've required users to remove and reinstall Flutter from scratch, which was clearly unacceptable. We are working hard to validate our ability to hotfix in 1.3+ so that we don't have this problem again.

Another option would have been to bring 1.3 to a stable release. Our current policy is to only bring out a new stable release once per quarter to reduce churn for Flutter developers. As of this writing, the pre-stable 1.3 release contains 104 framework commits (and even more engine, Dart, and Skia commits), any of which is a risk to how your current apps are running. To reduce that risk, we leave releases in beta for a month, let developers test them, and only promote releases to the stable channel when we're confident in them. That's how we maintain stability in the quarterly releases.

Our next stable release is currently planned for May, 2019, which is the first stable release that will include the fix for this regression. If you are affected by [#28640](https://github.com/flutter/flutter/issues/28640) and feel like the workaround to use the pre-release 1.3 is not an option for you, please let us know by on [flutter/flutter#29235](https://github.com/flutter/flutter/issues/29235) itself. Similarly, if you are affected by [#28484](https://github.com/flutter/flutter/issues/28484), et us know on [flutter/flutter/#29360](https://github.com/flutter/flutter/issues/29360). If we find that there's a lot of feedback from the Flutter community that we made the wrong decision here, we'll use your feedback to reevaluate. Flutter is, after all, a community effort, and your opinions matter.


## Tooling Releases

In addition to Flutter framework changes in the 1.2 release, we've made a number of tooling releases in the same timeframe, which you can read about here:



*   Dart & Flutter support for Visual Studio Code: versions [2.21](https://dartcode.org/releases/v2-21/), [2.22](https://dartcode.org/releases/v2-22/), [2.23](https://dartcode.org/releases/v2-23/) and [2.24](https://dartcode.org/releases/v2-24/).
*   Dart & Flutter support for IntelliJ & Android Studio: [January, 2019](https://groups.google.com/forum/#!searchin/flutter-dev/nilay%7Csort:date/flutter-dev/VCfGRhDsHgs/JcYKxkxHBAAJ) and [February, 2019](https://groups.google.com/forum/#!searchin/flutter-dev/nilay%7Csort:date/flutter-dev/VCfGRhDsHgs/JcYKxkxHBAAJ) releases.
*   Dart DevTools [alpha release](https://flutter.github.io/devtools/).

## Full Issue List

You can see [the full list of PRs committed in this release](/docs/development/tools/sdk/release-notes/changelogs/changelog-1.2.1).

[Android App Bundles]: https://developer.android.com/guide/app-bundle/
