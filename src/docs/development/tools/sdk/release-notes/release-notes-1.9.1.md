---
title: Flutter 1.9.1 release notes
short-title: 1.9.1 release notes
description: Release notes for Flutter 1.9.1.
---

Hello and welcome to another stable release of Flutter. So far this year, we’ve been right on target with one stable release each quarter, as per [our plan](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels) (well, less of a plan and more of a goal, but still, it’s been working out pretty well so far…). This release is our biggest yet, with 620 Pull Requests merged from 116 contributors. As always, the interesting PRs are listed below. And there are lots of interesting things to discuss in this release, including:

*   One regression fixed but also one added
*   Some breaking API changes
*   Some severe issues caught and fixed
*   Support for macOS Catalina and iOS 13
*   A number of new features
*   And more!

And to be clear, when I say “we,” I mean the Flutter community as a whole. The Flutter team couldn’t possibly continue to scale as we have without all of our contributors, no matter who your employer is. Thanks everyone for your contributions!


## Regressions

In this release, we fixed one regression ([37955](https://github.com/flutter/flutter/pull/37955) Update shader warm-up for recent Skia changes) and caused another ([38167](https://github.com/dart-lang/sdk/issues/38167) Incremental compiler re-issuing of errors from constant evaluator). The new regression is fixed after the 1.9.1 stable release ([00d14e7](https://github.com/dart-lang/sdk/commit/00d14e7) [CFE] Always start constant evaluation error where we are asked to evaluate), so if you’re seeing it, you can choose a more recent build to bring it into your Flutter apps.


## Breaking API Changes

We try hard not to make breaking changes, but we also don’t want to create unintuitive APIs as we move Flutter forward to new scenarios and new platforms. These are the breaking changes in this release. Please see the associated announcements so you can move your code forward.

[33281](https://github.com/flutter/flutter/pull/33281) ([announcement](https://groups.google.com/forum/#!msg/flutter-announce/ZmnseDOW9Wc/5K7xD0V8BwAJ)) Update TextStyle and StrutStyle height docs

[34019](https://github.com/flutter/flutter/pull/34019) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/34019%7Csort:date/flutter-announce/GBFULLQxGp4/-3uujTAaCgAJ)) Selectable Text

[34665](https://github.com/flutter/flutter/pull/34665) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/34665%7Csort:date/flutter-announce/W9KQKpf0Ves/6bdDq_U8CQAJ)) Selection handles position is off

[35110](https://github.com/flutter/flutter/pull/35110) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/35110%7Csort:date/flutter-announce/FHicLlzr9gQ/OM9KgLxMBwAJ)) Always test semantics

[35136](https://github.com/flutter/flutter/pull/35136) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/35136%7Csort:date/flutter-announce/UrhJwkaKaSc/ONoMzKrtAwAJ)) Update Dark Theme disabledColor to White38

[35785](https://github.com/flutter/flutter/pull/35785) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/35785%7Csort:date/flutter-announce/AL5ure2NWNI/4gPoziQSBAAJ)) Remove reverseDuration from implicitly animated widgets, since it’s ignored.

[36030](https://github.com/flutter/flutter/pull/36030) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/36030%7Csort:date/flutter-announce/bN6vFnoVpmk/7UCOxj6LCwAJ)) [Material] Implement TooltipTheme and Tooltip.textStyle, fix Tooltip debugLabel, update Tooltip defaults

[36106](https://github.com/flutter/flutter/pull/36106) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/36106%7Csort:date/flutter-announce/Yo3WxDCria4/AgNUznoZBgAJ)) Updated ColorScheme.dark() colors to match the Material Dark theme specification

[36217](https://github.com/flutter/flutter/pull/36217) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/36217%7Csort:date/flutter-announce/3vyI_41YX44/yQy0MHAuBgAJ)) Split Mouse from Listener

[36402](https://github.com/flutter/flutter/pull/36402) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/36402%7Csort:date/flutter-announce/taTeI07sK0w/-fsJvpfCFQAJ)) Teach render objects to reuse engine layers

[36856](https://github.com/flutter/flutter/pull/36856) (no announcement) [Material] Implement TooltipTheme and Tooltip.textStyle, update Tooltip defaults

[36964](https://github.com/flutter/flutter/pull/36964) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/36964%7Csort:date/flutter-announce/IALsYuwhzNk/OaP1ijOhCwAJ)) Interactive size const

[37338](https://github.com/flutter/flutter/pull/37338) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/37338%7Csort:date/flutter-announce/ZNX-Rd6IKSQ/3K4-1_skDAAJ)) Update constructor APIs TooltipTheme, ToggleButtonsTheme, PopupMenuTheme

[37341](https://github.com/flutter/flutter/pull/37341) (no announcement) hiding original hero after hero transition

[37544](https://github.com/flutter/flutter/pull/37544) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/37544%7Csort:date/flutter-announce/Igg0DuIO6Zg/2QroNaSkDAAJ)) Replace ButtonBar.bar method with ButtonBarTheme

[37652](https://github.com/flutter/flutter/pull/37652) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/37652%7Csort:date/flutter-announce/bTliCEss-VA/CfqN9DCWEwAJ)) Change RenderObject.getTransformTo to include ancestor.

[37736](https://github.com/flutter/flutter/pull/37736) ([announcement](https://groups.google.com/forum/#!searchin/flutter-announce/37736%7Csort:date/flutter-announce/-kotruZbBDQ/vny4JjFmFQAJ)) Added a composable waitForCondition Driver/extension API


## Severe: Crash, Customer Critical and Performance Fixes

In Flutter, we try to add a little bit of quality to every release. This time around, we fixed several severe issues, including crashes, customer critical issues and performance issues.

[34907](https://github.com/flutter/flutter/pull/34907) Fixed LicensePage to close page before loaded the License causes an error

[35223](https://github.com/flutter/flutter/pull/35223) Navigator pushAndRemoveUntil Fix

[36097](https://github.com/flutter/flutter/pull/36097) Fix nested scroll view can rebuild without layout

[37033](https://github.com/flutter/flutter/pull/37033) fix debug paint crash when axis direction inverted

[37254](https://github.com/flutter/flutter/pull/37254) Clamp Scaffold's max body height when extendBody is true

[34298](https://github.com/flutter/flutter/pull/34298) Preserving SafeArea : Part 2

[37718](https://github.com/flutter/flutter/pull/37718) Adding physicalDepth to MediaQueryData & TestWindow

[35297](https://github.com/flutter/flutter/pull/35297) Fix the first frame logic in tracing and driver


## New Features

This release also brings with it two new Material widgets: the ToggleButtons widget (called a [segmented control](https://developer.apple.com/design/human-interface-guidelines/ios/controls/segmented-controls/) on iOS) and a ColorFilter widget (described below in the Text & Accessibility section). To see these widgets in action, check out short [ToggleButtons ](https://github.com/csells/flutter_toggle_buttons)and [ColorFilter](https://github.com/csells/flutter_color_filter) samples. Also, the SelectableText widget allows the user to select read-only text.

[34599](https://github.com/flutter/flutter/pull/34599) [Material] ToggleButtons

[34019](https://github.com/flutter/flutter/pull/34019) Selectable Text

[35207](https://github.com/flutter/flutter/pull/35207) refactor out selection handlers

[36030](https://github.com/flutter/flutter/pull/36030) [Material] Implement TooltipTheme and Tooltip.textStyle, fix Tooltip debugLabel, update Tooltip defaults

[36411](https://github.com/flutter/flutter/pull/36411) Implement InputDecorationTheme copyWith, ==, hashCode

[36856](https://github.com/flutter/flutter/pull/36856) [Material] Implement TooltipTheme and Tooltip.textStyle, update Tooltip defaults

[36963](https://github.com/flutter/flutter/pull/36963) Add margins to tooltips

[37266](https://github.com/flutter/flutter/pull/37266) Change the value of kMaxUnsignedSMI for the Web

[37341](https://github.com/flutter/flutter/pull/37341) hiding original hero after hero transition

[37492](https://github.com/flutter/flutter/pull/37492) Drawer edge drag width improvements


## macOS Catalina Support

With the release of macOS Catalina just around the corner, we’ve made sure that our tooling continues to work smoothly as you migrate to Catalina, iOS 13 and Xcode 11. I should note that **you’ll want to upgrade to the Flutter 1.9.1 stable release before upgrading to Catalina**. The other order works, too, but you’ll see an error when you do it that way (the [error](https://github.com/flutter/flutter/issues/33890) is benign, but still…). 

[38325](https://github.com/flutter/flutter/pull/38325) refactor flutter upgrade to be 2 part, with the second part re-entrant

[cd70b](https://github.com/dart-lang/sdk/commit/ec2d06d4b9f4f0accad2b4aa841499e8e93cd70b) Use MAP_JIT when doing an mmap for executable pages (needed for macOS Catalina).

[38662](https://github.com/flutter/flutter/pull/38662) Change from using defaults to plutil for Plist parsing

[2856](https://github.com/flutter/website/issues/2856) Update "Getting Started" path setup to support zsh shell (macOS Catalina support)

[2857](https://github.com/flutter/website/issues/2857) Update "iOS Setup" page to reflect Xcode 11 UI update

[37733](https://github.com/flutter/flutter/pull/37733) Support macOS Catalina-style signing certificate names

[10010](https://github.com/flutter/engine/pull/10010) Use simarm_x64 when targeting arm

[37407](https://github.com/flutter/flutter/pull/37407) Remove multi-arch check in iOS builds

[37445](https://github.com/flutter/flutter/pull/37445) Switch iOS gen_snapshot from multi-arch binary to multiple binaries

[37647](https://github.com/flutter/flutter/pull/37647) Change priority of gen_snapshot search paths


## iOS

With over 50 PRs in this release, iOS support continues to be a big focus for Flutter, including an iOS 13 scrollbar implementation (that includes long-press, drag-from-right and vibration feedback support), an update to the CupertinoSwitch widget to match iOS 13 and continued experimentation with bitcode.

[35829](https://github.com/flutter/flutter/pull/35829) iOS 13 scrollbar

[37724](https://github.com/flutter/flutter/pull/37724) iOS 13 scrollbar vibration

[36087](https://github.com/flutter/flutter/pull/36087) Update visual style of CupertinoSwitch to match iOS 13

[38587](https://github.com/flutter/flutter/pull/38587) Improve bitcode check

[36471](https://github.com/flutter/flutter/pull/36471) Enable bitcode compilation for AOT

[36093](https://github.com/flutter/flutter/pull/36093) Reland bundle ios deps

[34676](https://github.com/flutter/flutter/pull/34676) Enable selection by default for password text field and expose api to…

[34723](https://github.com/flutter/flutter/pull/34723) CupertinoTextField vertical alignment

[34964](https://github.com/flutter/flutter/pull/34964) CupertinoTextField.onTap

[35303](https://github.com/flutter/flutter/pull/35303) fix default artifacts to exclude ios and android

[35307](https://github.com/flutter/flutter/pull/35307) Clean up host_app_ephemeral Profile build settings

[35731](https://github.com/flutter/flutter/pull/35731) Keep LLDB connection to iOS device alive while running from CLI.

[35749](https://github.com/flutter/flutter/pull/35749) add iOS build benchmarks

[35756](https://github.com/flutter/flutter/pull/35756) Remove @objc inference build setting

[35763](https://github.com/flutter/flutter/pull/35763) UIApplicationLaunchOptionsKey -> UIApplication.LaunchOptionsKey

[35833](https://github.com/flutter/flutter/pull/35833) Disable CocoaPods input and output paths in Xcode build phase for ephemeral add-to-app project

[36174](https://github.com/flutter/flutter/pull/36174) [cupertino_icons] Add glyph refs for brightness #16102

[36194](https://github.com/flutter/flutter/pull/36194) Keep LLDB connection to iOS device alive while running from CLI.

[36498](https://github.com/flutter/flutter/pull/36498) Clean up host_app_ephemeral_cocoapods Profile build settings

[36793](https://github.com/flutter/flutter/pull/36793) Vend Flutter module App.framework as a local CocoaPod pod to be installed by a host app

[36887](https://github.com/flutter/flutter/pull/36887) Fix thumb size calculation

[37026](https://github.com/flutter/flutter/pull/37026) Add support for the Kannada (kn) locale

[37048](https://github.com/flutter/flutter/pull/37048) use SizedBox instead of Container for building collapsed selection

[37276](https://github.com/flutter/flutter/pull/37276) Make podhelper.rb a template to avoid passing in the module name

[37319](https://github.com/flutter/flutter/pull/37319) resizeToAvoidBottomInset Cupertino without NavBar

[37449](https://github.com/flutter/flutter/pull/37449) If xcode_backend.sh script fails or substitute variables are missing, fail the host Xcode build

[37738](https://github.com/flutter/flutter/pull/37738) Use relative paths when installing module pods

[37809](https://github.com/flutter/flutter/pull/37809) Add autofocus parameter to widgets which use Focus widget internally

[37906](https://github.com/flutter/flutter/pull/37906) Always install the ephemeral engine copy instead of fetching from CocoaPods specs

[38593](https://github.com/flutter/flutter/pull/38593) Fix text scale factor for non-content components of Cupertino scaffolds

[38629](https://github.com/flutter/flutter/pull/38629) Handle case of a connected unpaired iOS device

[38645](https://github.com/flutter/flutter/pull/38645) Rename iOS arch for macOS release mode (macOS release mode 2 of 3)

[9075](https://github.com/flutter/engine/pull/9075) IOS Platform view transform/clipping

[9464](https://github.com/flutter/engine/pull/9464) Added shebangs to ios unit test scripts.

[9478](https://github.com/flutter/engine/pull/9478) iOS PlatformView clip path

[9491](https://github.com/flutter/engine/pull/9491) Purge caches on low memory on iOS

[9636](https://github.com/flutter/engine/pull/9636) Added shebangs to ios unit test scripts. (#9464)

[9667](https://github.com/flutter/engine/pull/9667) iOS platform view opacity

[9722](https://github.com/flutter/engine/pull/9722) Forwards iOS dark mode trait to the Flutter framework (#34441).

[9819](https://github.com/flutter/engine/pull/9819) Allow for dynamic thread merging on IOS for embedded view mutations

[9952](https://github.com/flutter/engine/pull/9952) ios: Fixed the callback for the first frame so that it isn't predicated on having a splash screen.

[10186](https://github.com/flutter/engine/pull/10186) Ensure debug-mode apps are always attached on iOS.

[10381](https://github.com/flutter/engine/pull/10381) Fix empty composing range on iOS

[10386](https://github.com/flutter/engine/pull/10386) Don't use DBC for hot-reload on iOS.

[10645](https://github.com/flutter/engine/pull/10645) Don't use DBC for hot-reload on iOS.

[10656](https://github.com/flutter/engine/pull/10656) fix iOS keyboard crash : -[__NSCFString substringWithRange:], range o…

[10662](https://github.com/flutter/engine/pull/10662) bump local podspec's ios deployment target version from 7.0 to 8.0

[10777](https://github.com/flutter/engine/pull/10777) Manually roll Skia to pull in iOS armv7 build failure fix.

[10791](https://github.com/flutter/engine/pull/10791) Re-lands platform brightness support on iOS

[10820](https://github.com/flutter/engine/pull/10820) iOS JIT support and enhancements for scenarios app

[10949](https://github.com/flutter/engine/pull/10949) Fix iOS references to PostPrerollResult

[11006](https://github.com/flutter/engine/pull/11006) On iOS report the preferred frames per second to tools via service protocol.


## Android

The biggest addition to Android this release is support for a new flutter command: ‘flutter build aar’. This new build command works just like ‘flutter build apk’ or ‘flutter build appbundle’, but for plugins and module projects. By building the plugins as [AARs](https://developer.android.com/studio/projects/android-library), the Android Gradle plugin can use Jetifier to translate support libraries into AndroidX libraries for all the plugin's native code, which reduces the error rate when using AndroidX in apps.

[35217](https://github.com/flutter/flutter/pull/35217) Add flutter build aar

[36732](https://github.com/flutter/flutter/pull/36732) Flutter build aar

[10778](https://github.com/flutter/engine/pull/10778) Build JARs containing the Android embedding sources and the engine native library

[34573](https://github.com/flutter/flutter/pull/34573) Ensures flutter jar is added to all build types on plugin projects

[36695](https://github.com/flutter/flutter/pull/36695) Android visible password input type support

[36805](https://github.com/flutter/flutter/pull/36805) Allow flavors and custom build types in host app

[37194](https://github.com/flutter/flutter/pull/37194) [flutter_tool] More gracefully handle Android sdkmanager failure

[37405](https://github.com/flutter/flutter/pull/37405) Add .android/Flutter/flutter.iml to module template.

[37752](https://github.com/flutter/flutter/pull/37752) Remove dead flag gradle-dir in flutter config

[9206](https://github.com/flutter/engine/pull/9206) Android Embedding Refactor PR31: Integrate platform views with the new embedding and the plugin shim.

[9360](https://github.com/flutter/engine/pull/9360) Simplify loading of app bundles on Android

[9476](https://github.com/flutter/engine/pull/9476) fix NPE when a touch event is sent to an unknown Android platform view

[9501](https://github.com/flutter/engine/pull/9501) [android] External textures must be rescaled to fill the canvas

[9525](https://github.com/flutter/engine/pull/9525) Android Embedding Refactor PR36: Add splash screen support.

[9895](https://github.com/flutter/engine/pull/9895) Android Embedding PR37: Separated FlutterActivity and FlutterFragment via FlutterActivityAndFragmentDelegate

[9999](https://github.com/flutter/engine/pull/9999) Add support for Android's visible password input type

[10250](https://github.com/flutter/engine/pull/10250) Android Embedding Refactor 38: Removed AssetManager from DartEntrypoint.

[10413](https://github.com/flutter/engine/pull/10413) Pass Android Q insets.systemGestureInsets to Window

[10424](https://github.com/flutter/engine/pull/10424) Fix deprecation warnings in the Android embedding

[10481](https://github.com/flutter/engine/pull/10481) Android embedding refactor pr40 add static engine cache

[10771](https://github.com/flutter/engine/pull/10771) Don't use gradle daemon for building

[11001](https://github.com/flutter/engine/pull/11001) Avoid dynamic lookups of the engine library's symbols on Android

[11015](https://github.com/flutter/engine/pull/11015) Remove the output directory prefix from the Android engine JAR filename


## Material

Of course, the Material design language also continues to be a major focus for Flutter.

[34869](https://github.com/flutter/flutter/pull/34869) [Material] Properly call onChangeStart and onChangeEnd in Range Slider

[34872](https://github.com/flutter/flutter/pull/34872) [Material] Support for hovered, focused, and pressed border color on OutlineButtons

[34906](https://github.com/flutter/flutter/pull/34906) Fix unused [applicationIcon] property on [showLicensePage]

[34932](https://github.com/flutter/flutter/pull/34932) Added onChanged property to TextFormField

[35075](https://github.com/flutter/flutter/pull/35075) Allow for customizing SnackBar's content TextStyle in its theme

[35282](https://github.com/flutter/flutter/pull/35282) Add Container fallback to Ink build method

[35496](https://github.com/flutter/flutter/pull/35496) [Material] Text scale and wide label fixes for Slider and Range Slider value indicator shape

[35499](https://github.com/flutter/flutter/pull/35499) Added MaterialApp.themeMode to control which theme is used.

[35560](https://github.com/flutter/flutter/pull/35560) Support for elevation based dark theme overlay color in the Material widget

[35878](https://github.com/flutter/flutter/pull/35878) Add flag to use root navigator for showModalBottomSheet

[36028](https://github.com/flutter/flutter/pull/36028) Fix slider preferred height

[36088](https://github.com/flutter/flutter/pull/36088) Add PopupMenuTheme to enable theming color, shape, elevation, text style of Menu

[36409](https://github.com/flutter/flutter/pull/36409) Add searchFieldLabel to SearchDelegate in order to show a custom hint

[36880](https://github.com/flutter/flutter/pull/36880) [Material] Create material Banner component

[37038](https://github.com/flutter/flutter/pull/37038) Update SnackBar to the latest Material specs.

[37259](https://github.com/flutter/flutter/pull/37259) [Material] Add support for hovered, pressed, focused, and selected text color on Chips.

[37269](https://github.com/flutter/flutter/pull/37269) [Material] FAB refactor - remove unnecessary IconTheme

[37355](https://github.com/flutter/flutter/pull/37355) Added ThemeData.from() method to construct a Theme from a ColorScheme

[37403](https://github.com/flutter/flutter/pull/37403) add ontap to textformfield

[37436](https://github.com/flutter/flutter/pull/37436) Hide text selection handle after entering text

[37556](https://github.com/flutter/flutter/pull/37556) [Material] Make RawChip.selected non-nullable.

[37636](https://github.com/flutter/flutter/pull/37636) Add CheckboxListTile checkColor

[37715](https://github.com/flutter/flutter/pull/37715) Fix markdown link format

[37825](https://github.com/flutter/flutter/pull/37825) Automatic focus highlight mode for FocusManager

[37870](https://github.com/flutter/flutter/pull/37870) remove Header flag from BottomNavigationBar items

[37877](https://github.com/flutter/flutter/pull/37877) Adds DefaultTextStyle ancestor to Tooltip Overlay

[37882](https://github.com/flutter/flutter/pull/37882) Add dense property to AboutListTile

[38467](https://github.com/flutter/flutter/pull/38467) [Material] Add splashColor to FAB and FAB ThemeData

[38621](https://github.com/flutter/flutter/pull/38621) [Material] Create theme for Dividers to enable customization of thickness

[38636](https://github.com/flutter/flutter/pull/38636) Adds the arrowColor option to UserAccountsDrawerHeader (#38608)


## Text & Accessibility

The biggest change in text & accessibility for this release is the new ColorFilter support, which enables you to recolor an entire widget tree according, for example, to adjust your app for users with red/green color blindness. To see it in action, check out this [ColorFilter sample](https://github.com/csells/flutter_color_filter).

[35468](https://github.com/flutter/flutter/pull/35468) Add colorFilterLayer/Widget

[9641](https://github.com/flutter/engine/pull/9641) Let pushColorFilter accept all types of ColorFilters

[9668](https://github.com/flutter/engine/pull/9668) Refactor ColorFilter to have a native wrapper

[9789](https://github.com/flutter/engine/pull/9789) fix ColorFilter.matrix constness

[34515](https://github.com/flutter/flutter/pull/34515) OutlineInputBorder adjusts for borderRadius that is too large

[35100](https://github.com/flutter/flutter/pull/35100) Add handling of 'TextInput.clearClient' message from platform to framework (#35054).

[35219](https://github.com/flutter/flutter/pull/35219) Text selection menu show/hide cases

[35493](https://github.com/flutter/flutter/pull/35493) Do not use ideographic baseline for RenderPargraph baseline

[36974](https://github.com/flutter/flutter/pull/36974) Multiline Selection Menu Position Bug

[37042](https://github.com/flutter/flutter/pull/37042) Fix selection menu not showing after clear

[38573](https://github.com/flutter/flutter/pull/38573) Clamp scrollOffset to prevent textfield bouncing

[35487](https://github.com/flutter/flutter/pull/35487) Fix RenderFittedBox when child.size.isEmpty

[36243](https://github.com/flutter/flutter/pull/36243) Allow semantics labels to be shorter or longer than raw text

[36303](https://github.com/flutter/flutter/pull/36303) Add sync star benchmark cases

[37158](https://github.com/flutter/flutter/pull/37158) Fix Textfields in Semantics Debugger

[37828](https://github.com/flutter/flutter/pull/37828) have android_semantics_testing use adb from ENV provided android sdk


## Web (tech preview)

Work continues on adding to the technical preview of web platform support to Flutter in this release, including a flag to tell if an app is running on the web. To see it in action, check out [main.dart](https://github.com/csells/flutter_mazegen/blob/master/lib/main.dart) in the [flutter_mazegen sample](https://github.com/csells/flutter_mazegen/). To learn more, see [Flutter for web](https://flutter.dev/web).

[36135](https://github.com/flutter/flutter/pull/36135) add a kIsWeb constant to foundation

[34252](https://github.com/flutter/flutter/pull/34252) Integrate dwds into flutter tool for web support

[34896](https://github.com/flutter/flutter/pull/34896) Allow multi-root web builds

[35221](https://github.com/flutter/flutter/pull/35221) Twiggle bit to exclude dev and beta from desktop and web

[36297](https://github.com/flutter/flutter/pull/36297) Add multi-line flag to semantics

[36465](https://github.com/flutter/flutter/pull/36465) Use FlutterFeatures to configure web and desktop devices

[36548](https://github.com/flutter/flutter/pull/36548) Fix the web builds by reverting version bump of build_modules

[36549](https://github.com/flutter/flutter/pull/36549) fix number encoding in message codecs for the Web

[37515](https://github.com/flutter/flutter/pull/37515) Upstream web support for IterableProperty

[37637](https://github.com/flutter/flutter/pull/37637) don't call Platform.operatingSystem in RenderView diagnostics

[37638](https://github.com/flutter/flutter/pull/37638) [web][upstream] Fix debugPrintStack for web platform

[37658](https://github.com/flutter/flutter/pull/37658) fix windows path for dwds/web builds

[37712](https://github.com/flutter/flutter/pull/37712) [web][upstream] Optimize InactiveElements deactivation

[37812](https://github.com/flutter/flutter/pull/37812) [web][upstream] Don't register exit/saveCompilationTrace for web platform since they are not available

[37815](https://github.com/flutter/flutter/pull/37815) Restructure resident web runner usage to avoid SDK users that don't support dwds

[38499](https://github.com/flutter/flutter/pull/38499) Update build web compilers and configure libraries


## Desktop (experimental)

We continue to move forward with the experimental support for the desktop platform in Flutter. If you'd like to take part in the experiment, see [Flutter Desktop shells](https://flutter.dev/desktop).

[32770](https://github.com/flutter/flutter/pull/32770) Dismiss modal with any button press

[34660](https://github.com/flutter/flutter/pull/34660) Add --target support for Windows and Linux

[34712](https://github.com/flutter/flutter/pull/34712) Fix FocusTraversalPolicy makes focus lost

[34752](https://github.com/flutter/flutter/pull/34752) [linux] Receives the unmodified characters obtained from GLFW

[35495](https://github.com/flutter/flutter/pull/35495) mark windows and macos chrome dev mode as flaky

[36197](https://github.com/flutter/flutter/pull/36197) Fix windows, exclude widgets from others

[36722](https://github.com/flutter/flutter/pull/36722) Skip flaky test windows

[36784](https://github.com/flutter/flutter/pull/36784) [flutter_tool] Improve Windows flutter clean error message

[36845](https://github.com/flutter/flutter/pull/36845) Improve Windows build failure message

[36987](https://github.com/flutter/flutter/pull/36987) Flutter assemble for macos take 2!

[37211](https://github.com/flutter/flutter/pull/37211) Don't enable scroll wheel when scrolling is off

[37342](https://github.com/flutter/flutter/pull/37342) Fix mouse region crash when using closures

[37344](https://github.com/flutter/flutter/pull/37344) Fix mouse region double render

[37351](https://github.com/flutter/flutter/pull/37351) fix errors caught by roll of macOS assemble

[37365](https://github.com/flutter/flutter/pull/37365) only build macOS kernel in debug mode

[37425](https://github.com/flutter/flutter/pull/37425) Support for macOS release mode (1 of 3)

[37509](https://github.com/flutter/flutter/pull/37509) Use macOS ephemeral directory for Pod env script

[37664](https://github.com/flutter/flutter/pull/37664) Partial macOS assemble revert

[37891](https://github.com/flutter/flutter/pull/37891) Focus debug

[38651](https://github.com/flutter/flutter/pull/38651) Update the macOS Podfile template platform version

[9654](https://github.com/flutter/engine/pull/9654) Begin separating macOS engine from view controller

[9672](https://github.com/flutter/engine/pull/9672) Add FLEDartProject for macOS embedding

[9745](https://github.com/flutter/engine/pull/9745) Fix windows test by not attempting to open a directory as a file.

[9799](https://github.com/flutter/engine/pull/9799) Update buildroot to c4df4a7b to pull in MSVC 2017 Update 9 on Windows.

[9835](https://github.com/flutter/engine/pull/9835) [Windows] Alternative Windows shell platform implementation

[9953](https://github.com/flutter/engine/pull/9953) [macos] Add reply to binary messenger

[10009](https://github.com/flutter/engine/pull/10009) [macos] Revert check on FlutterCodecs and refactor message function]

[10189](https://github.com/flutter/engine/pull/10189) [macos] Reland function refactor

[11010](https://github.com/flutter/engine/pull/11010) Rename macOS FLE* classes to Flutter*

[36546](https://github.com/flutter/flutter/pull/36546) Unskip date_picker_test on Windows as underlying issue 19696 was fixed.


## Framework

The core framework for Flutter saw several important features in this release, including support for an additional 24 new locales (ranging [from Afrikaans to Zulu](https://github.com/flutter/flutter/pull/36589)).

[36589](https://github.com/flutter/flutter/pull/36589) Update Localizations: added 24 new locales (reprise)

[33936](https://github.com/flutter/flutter/pull/33936) New parameter for RawGestureDetector to customize semantics mapping

[34202](https://github.com/flutter/flutter/pull/34202) Remove _debugWillReattachChildren assertions from _TableElement

[34626](https://github.com/flutter/flutter/pull/34626) AsyncSnapshot.data to throw if error or no data

[34895](https://github.com/flutter/flutter/pull/34895) Remove flutter_tools support for old AOT snapshotting

[34919](https://github.com/flutter/flutter/pull/34919) Remove duplicate error parts

[35132](https://github.com/flutter/flutter/pull/35132) Reduce allocations by reusing a matrix for transient transforms in _transformRect

[35143](https://github.com/flutter/flutter/pull/35143) More HttpClientResponse Uint8List fixes

[35149](https://github.com/flutter/flutter/pull/35149) More HttpClientResponse implements Stream<Uint8List> fixes

[35232](https://github.com/flutter/flutter/pull/35232) New benchmark: Gesture semantics

[35233](https://github.com/flutter/flutter/pull/35233) Attempt skipping coverage shard if tools did not change

[35245](https://github.com/flutter/flutter/pull/35245) More preparation for HttpClientResponse implements Uint8List

[35246](https://github.com/flutter/flutter/pull/35246) attempt to not skip coverage on post commit

[35263](https://github.com/flutter/flutter/pull/35263) remove unnecessary ..toList()

[35280](https://github.com/flutter/flutter/pull/35280) benchmarkWidgets.semanticsEnabled default false.

[35288](https://github.com/flutter/flutter/pull/35288) Apply coverage skip math correctly

[35408](https://github.com/flutter/flutter/pull/35408) Remove print

[35482](https://github.com/flutter/flutter/pull/35482) Use the new service protocol message names

[35491](https://github.com/flutter/flutter/pull/35491) Include tags in SemanticsNode debug properties

[35646](https://github.com/flutter/flutter/pull/35646) Prepare for Socket implements Stream

[35725](https://github.com/flutter/flutter/pull/35725) Update annotated region findAll implementation to use Iterables directly.

[35750](https://github.com/flutter/flutter/pull/35750) use sentence case in error message titles

[35762](https://github.com/flutter/flutter/pull/35762) Refactor keymapping for resident_runner

[35828](https://github.com/flutter/flutter/pull/35828) Cleanup widgets/sliver_persistent_header.dart with resolution of dart-lang/sdk#31543

[35913](https://github.com/flutter/flutter/pull/35913) Change focus example to be more canonical (and correct)

[35932](https://github.com/flutter/flutter/pull/35932) Upgraded framework packages with 'flutter update-packages --force-upgrade'.

[35979](https://github.com/flutter/flutter/pull/35979) Optimizes gesture recognizer fixes #35658

[36262](https://github.com/flutter/flutter/pull/36262) Prevents infinite loop in Table._computeColumnWidths

[36302](https://github.com/flutter/flutter/pull/36302) Issues/30526 gc

[36333](https://github.com/flutter/flutter/pull/36333) fix sliver fixed pinned appbar

[36396](https://github.com/flutter/flutter/pull/36396) Optimize the transformRect and transformPoint methods in matrix_utils.

[36482](https://github.com/flutter/flutter/pull/36482) Sped up shader warmup by only drawing on a 100x100 surface

[36493](https://github.com/flutter/flutter/pull/36493) Fixes sliver list does not layout firstchild when child reordered

[36503](https://github.com/flutter/flutter/pull/36503) Disabling Firebase Test Lab smoke test to unblock autoroller

[36698](https://github.com/flutter/flutter/pull/36698) fixes iphone force press keyboard select crashes

[36768](https://github.com/flutter/flutter/pull/36768) add an error count field to the Flutter.Error event

[36857](https://github.com/flutter/flutter/pull/36857) Ensure user-thrown errors have ErrorSummary nodes

[36867](https://github.com/flutter/flutter/pull/36867) Add reference to StrutStyle from TextStyle

[36955](https://github.com/flutter/flutter/pull/36955) Extract common PlatformView functionality: Painting and Semantics

[37187](https://github.com/flutter/flutter/pull/37187) use FlutterError in MultiChildRenderObjectWidget

[37275](https://github.com/flutter/flutter/pull/37275) Optimize the transformRect and transformPoint methods in matrix_utils…

[37479](https://github.com/flutter/flutter/pull/37479) Remove bogus code in ContainerParentDataMixin.detach

[37497](https://github.com/flutter/flutter/pull/37497) Extract common PlatformView functionality: Gesture and PointerEvent

[37703](https://github.com/flutter/flutter/pull/37703) PlatformViewLink, handling creation of the PlatformViewSurface and dispose PlatformViewController

[37790](https://github.com/flutter/flutter/pull/37790) Doc: Image.memory only accepts compressed format

[37880](https://github.com/flutter/flutter/pull/37880) reduce mac workload

[38441](https://github.com/flutter/flutter/pull/38441) Fix getOffsetToReveal for growthDirection reversed and AxisDirection down or right

[38463](https://github.com/flutter/flutter/pull/38463) Do not construct arguments to _focusDebug when running in non-debug modes

[38639](https://github.com/flutter/flutter/pull/38639) PlatformViewLink. cached surface should be a Widget type

[38686](https://github.com/flutter/flutter/pull/38686) Rename patent file

[38704](https://github.com/flutter/flutter/pull/38704) Adds canRequestFocus toggle to FocusNode

[38710](https://github.com/flutter/flutter/pull/38710) PlatformViewLink: Rename CreatePlatformViewController to CreatePlatformViewCallback

[35335](https://github.com/flutter/flutter/pull/35335) Using custom exception class for network loading error

[35574](https://github.com/flutter/flutter/pull/35574) Fix semantics for floating pinned sliver app bar

[35810](https://github.com/flutter/flutter/pull/35810) SliverFillRemaining accounts for child size when hasScrollBody is false

[35941](https://github.com/flutter/flutter/pull/35941) SliverLayoutBuilder


## Engine

The core engine continues to see many improvements across the board in this release.

[9041](https://github.com/flutter/engine/pull/9041) TextStyle.height property as a multiple of font size instead of multiple of ascent+descent+leading.

[9089](https://github.com/flutter/engine/pull/9089) Wire up custom event loop interop for the GLFW embedder.

[9329](https://github.com/flutter/engine/pull/9329) Fixed memory leak by way of accidental retain on implicit self

[9403](https://github.com/flutter/engine/pull/9403) Remove variants of ParagraphBuilder::AddText that are not used within the engine

[9419](https://github.com/flutter/engine/pull/9419) Has a binary messenger

[9423](https://github.com/flutter/engine/pull/9423) Don't hang to a platform view's input connection after it's disposed

[9424](https://github.com/flutter/engine/pull/9424) Send timings of the first frame without batching

[9431](https://github.com/flutter/engine/pull/9431) Generate weak pointers only in the platform thread

[9436](https://github.com/flutter/engine/pull/9436) Add the functionality to merge and unmerge MessageLoopTaskQueues

[9439](https://github.com/flutter/engine/pull/9439) Eliminate unused import in FlutterView

[9452](https://github.com/flutter/engine/pull/9452) Convert RRect.scaleRadii to public method

[9456](https://github.com/flutter/engine/pull/9456) Made sure that the run_tests script returns the right error code.

[9459](https://github.com/flutter/engine/pull/9459) Remove unused/unimplemented shell constructor

[9460](https://github.com/flutter/engine/pull/9460) Fixed logLevel filter bug so that filter now works as expected.

[9461](https://github.com/flutter/engine/pull/9461) Adds API for retaining intermediate engine layers

[9463](https://github.com/flutter/engine/pull/9463) Removed unused imports in new embedding.

[9466](https://github.com/flutter/engine/pull/9466) Re-enable the Wuffs GIF decoder

[9468](https://github.com/flutter/engine/pull/9468) Manually draw remainder curve for wavy decorations

[9485](https://github.com/flutter/engine/pull/9485) Add --observatory-host switch

[9486](https://github.com/flutter/engine/pull/9486) Rework image & texture management to use concurrent message queues.

[9489](https://github.com/flutter/engine/pull/9489) Handle ambiguous directionality of final trailing whitespace in mixed bidi text

[9490](https://github.com/flutter/engine/pull/9490) fix a bug where the platform view's transform is not reset before set frame

[9493](https://github.com/flutter/engine/pull/9493) Run benchmarks on try jobs.

[9495](https://github.com/flutter/engine/pull/9495) fix build breakage on [PlatformViews.mm](http://platformviews.mm/)

[9498](https://github.com/flutter/engine/pull/9498) Notify framework to clear input connection when app is backgrounded (#35054).

[9503](https://github.com/flutter/engine/pull/9503) Improve caching limits for Skia

[9506](https://github.com/flutter/engine/pull/9506) Synchronize main thread and gpu thread for first render frame

[9508](https://github.com/flutter/engine/pull/9508) Support image filter on paint

[9532](https://github.com/flutter/engine/pull/9532) fix FlutterOverlayView doesn't remove from superview in some cases

[9556](https://github.com/flutter/engine/pull/9556) Minimal integration with the Skia text shaper module

[9561](https://github.com/flutter/engine/pull/9561) libtxt: fix reference counting of SkFontStyleSets held by font asset providers

[9585](https://github.com/flutter/engine/pull/9585) Fix a race in the embedder accessibility unit test

[9589](https://github.com/flutter/engine/pull/9589) Fixes a plugin overwrite bug in the plugin shim system.

[9590](https://github.com/flutter/engine/pull/9590) Apply patches that have landed in topaz since we ported the runners to the engine repo

[9591](https://github.com/flutter/engine/pull/9591) Document various classes in //flutter/shell/common.

[9632](https://github.com/flutter/engine/pull/9632) Added Doxyfile.

[9633](https://github.com/flutter/engine/pull/9633) Cherry-pick fix for flutter/flutter#35291

[9640](https://github.com/flutter/engine/pull/9640) make EmbeddedViewParams a unique ptr

[9642](https://github.com/flutter/engine/pull/9642) Fix warning about settings unavailable GN arg build_glfw_shell

[9651](https://github.com/flutter/engine/pull/9651) Move the mutators stack handling to preroll

[9652](https://github.com/flutter/engine/pull/9652) Pipeline allows continuations that can produce to front

[9653](https://github.com/flutter/engine/pull/9653) External view embedder can tell if embedded views have mutated

[9655](https://github.com/flutter/engine/pull/9655) Allow embedders to add callbacks for responses to platform messages from the framework.

[9660](https://github.com/flutter/engine/pull/9660) ExternalViewEmbedder can CancelFrame after pre-roll

[9661](https://github.com/flutter/engine/pull/9661) Raster now returns an enum rather than boolean

[9663](https://github.com/flutter/engine/pull/9663) Mutators Stack refactoring

[9685](https://github.com/flutter/engine/pull/9685) fix Picture.toImage return type check and api conform test.

[9698](https://github.com/flutter/engine/pull/9698) Ensure that platform messages without response handles can be dispatched.

[9713](https://github.com/flutter/engine/pull/9713) Explain why OpacityLayer has an offset field

[9717](https://github.com/flutter/engine/pull/9717) Fixed logLevel filter bug so that filter now works as expected. (#9460)

[9721](https://github.com/flutter/engine/pull/9721) Add comments to differentiate two cache paths

[9725](https://github.com/flutter/engine/pull/9725) Make the license script compatible with recently changed Dart I/O stream APIs

[9727](https://github.com/flutter/engine/pull/9727) Add hooks for InputConnection lock and unlocking

[9734](https://github.com/flutter/engine/pull/9734) Fix backspace crash on Chinese devices

[9737](https://github.com/flutter/engine/pull/9737) Use libc++ variant of string view and remove the FML variant.

[9741](https://github.com/flutter/engine/pull/9741) Make FLEViewController's view an internal detail

[9747](https://github.com/flutter/engine/pull/9747) Remove get engine

[9750](https://github.com/flutter/engine/pull/9750) FLEViewController/Engine API changes

[9758](https://github.com/flutter/engine/pull/9758) Include SkParagraph headers only when the enable-skshaper flag is on

[9762](https://github.com/flutter/engine/pull/9762) Fall back to a fully qualified path to [libapp.so](http://libapp.so/) if the library can not be loaded by name

[9767](https://github.com/flutter/engine/pull/9767) Un-deprecated FlutterViewController's binaryMessenger.

[9769](https://github.com/flutter/engine/pull/9769) Document //flutter/shell/common/engine.

[9772](https://github.com/flutter/engine/pull/9772) fix objcdoc generation

[9781](https://github.com/flutter/engine/pull/9781) SendPlatformMessage allow null message value

[9797](https://github.com/flutter/engine/pull/9797) Remove breaking asserts

[9808](https://github.com/flutter/engine/pull/9808) Document FontFeature class

[9809](https://github.com/flutter/engine/pull/9809) Document //flutter/shell/common/rasterizer

[9813](https://github.com/flutter/engine/pull/9813) Made Picture::toImage happen on the IO thread with no need for an onscreen surface.

[9815](https://github.com/flutter/engine/pull/9815) Made the persistent cache's directory a const pointer.

[9816](https://github.com/flutter/engine/pull/9816) Only release the image data in the unit-test once Skia has accepted ownership of it.

[9825](https://github.com/flutter/engine/pull/9825) In a single frame codec, release the encoded image buffer after giving it to the decoder

[9828](https://github.com/flutter/engine/pull/9828) Make the virtual display's window translucent

[9847](https://github.com/flutter/engine/pull/9847) Started adding the engine hash to frameworks' Info.plist.

[9849](https://github.com/flutter/engine/pull/9849) Preserve the alpha for VD content by setting a transparent background.

[9850](https://github.com/flutter/engine/pull/9850) Add multi-line flag to semantics

[9851](https://github.com/flutter/engine/pull/9851) Add a macro for prefixing embedder.h symbols

[9855](https://github.com/flutter/engine/pull/9855) Fix missing assignment to _allowHeadlessExecution

[9859](https://github.com/flutter/engine/pull/9859) Fix justify for RTL paragraphs.

[9867](https://github.com/flutter/engine/pull/9867) Fixed error in generated xml Info.plist.

[9873](https://github.com/flutter/engine/pull/9873) Add clang version to Info.plist

[9875](https://github.com/flutter/engine/pull/9875) Simplify buildtools

[9890](https://github.com/flutter/engine/pull/9890) Log dlopen errors only in debug mode

[9893](https://github.com/flutter/engine/pull/9893) Removed logic from FlutterAppDelegate into FlutterPluginAppLifeCycleDelegate

[9894](https://github.com/flutter/engine/pull/9894) Add the isMultiline semantics flag to values

[9896](https://github.com/flutter/engine/pull/9896) Capture stderr for ninja command

[9901](https://github.com/flutter/engine/pull/9901) Handle decompressed images in InstantiateImageCodec

[9905](https://github.com/flutter/engine/pull/9905) Respect EXIF information while decompressing images.

[9906](https://github.com/flutter/engine/pull/9906) Update libcxx & libcxxabi to HEAD in prep for compiler upgrade.

[9919](https://github.com/flutter/engine/pull/9919) Removed unused method.

[9920](https://github.com/flutter/engine/pull/9920) Fix caching of Locale.toString

[9922](https://github.com/flutter/engine/pull/9922) Split out lifecycle protocol

[9923](https://github.com/flutter/engine/pull/9923) Fix failure of the onReportTimings window hook test

[9924](https://github.com/flutter/engine/pull/9924) Don't try to use unset assets_dir setting

[9925](https://github.com/flutter/engine/pull/9925) Fix the geometry test to reflect that OffsetBase comparison operators are a partial ordering

[9927](https://github.com/flutter/engine/pull/9927) Update Buildroot Version

[9929](https://github.com/flutter/engine/pull/9929) Update the exception thrown for invalid data in the codec test

[9931](https://github.com/flutter/engine/pull/9931) Fix reentrancy handling in SingleFrameCodec

[9932](https://github.com/flutter/engine/pull/9932) Exit flutter_tester with an error code on an unhandled exception

[9934](https://github.com/flutter/engine/pull/9934) Updates to the engine test runner script

[9935](https://github.com/flutter/engine/pull/9935) Fix backspace crash on Chinese devices (#9734)

[9936](https://github.com/flutter/engine/pull/9936) Move development.key from buildroot

[9937](https://github.com/flutter/engine/pull/9937) [platform view] do not make clipping view and interceptor view clipToBounds

[9938](https://github.com/flutter/engine/pull/9938) Removed PlatformViewsController if-statements from TextInputPlugin (#34286).

[9939](https://github.com/flutter/engine/pull/9939) Added hasRenderedFirstFrame() to old FlutterView for Espresso (#36211).

[9948](https://github.com/flutter/engine/pull/9948) [glfw] Enables replies on binary messenger in glfw embedder

[9958](https://github.com/flutter/engine/pull/9958) Clean up cirrus.yml file a little

[9961](https://github.com/flutter/engine/pull/9961) Fix return type of assert function in gradient_test

[9977](https://github.com/flutter/engine/pull/9977) Fix flutter/flutter #34791

[9987](https://github.com/flutter/engine/pull/9987) Update GN to git_revision:152c5144ceed9592c20f0c8fd55769646077569b

[10012](https://github.com/flutter/engine/pull/10012) Undelete used method

[10021](https://github.com/flutter/engine/pull/10021) Added a DartExecutor API for querying ## of pending channel callbacks

[10056](https://github.com/flutter/engine/pull/10056) Update .cirrus.yml

[10063](https://github.com/flutter/engine/pull/10063) Track clusters and return cluster boundaries in getGlyphPositionForCoordinates (emoji fix)

[10064](https://github.com/flutter/engine/pull/10064) Disable DartLifecycleTest::ShuttingDownTheVMShutsDownAllIsolates in runtime_unittests.

[10068](https://github.com/flutter/engine/pull/10068) Fixed memory leak with engine registrars.

[10069](https://github.com/flutter/engine/pull/10069) Enable consts from environment in DDK for flutter_web

[10073](https://github.com/flutter/engine/pull/10073) Basic structure for flutter_jit_runner far

[10074](https://github.com/flutter/engine/pull/10074) Change ParagraphBuilder to replace the parent style's font families with the child style's font families

[10075](https://github.com/flutter/engine/pull/10075) Change flutter runner target for LUCI

[10078](https://github.com/flutter/engine/pull/10078) One more luci fix

[10109](https://github.com/flutter/engine/pull/10109) Cache font family lookups that fail to obtain a font collection

[10127](https://github.com/flutter/engine/pull/10127) Track detailed LibTxt metrics

[10128](https://github.com/flutter/engine/pull/10128) Started linking the test targets against Flutter.

[10151](https://github.com/flutter/engine/pull/10151) [fucshia] fix name to reflect the cmx file

[10155](https://github.com/flutter/engine/pull/10155) src/third_party/dart a2aec5eb06...86dba81dec

[10172](https://github.com/flutter/engine/pull/10172) [dart_runner] Rename dart to dart runner

[10176](https://github.com/flutter/engine/pull/10176) Add suggested Java changes from flutter roll

[10178](https://github.com/flutter/engine/pull/10178) Removed unnecessary call to find the App.framework.

[10179](https://github.com/flutter/engine/pull/10179) [dart_runner] dart jit runner and dart jit product runner

[10195](https://github.com/flutter/engine/pull/10195) Allow embedder controlled composition of Flutter layers.

[10235](https://github.com/flutter/engine/pull/10235) Deprecate FlutterView#enableTransparentBackground

[10242](https://github.com/flutter/engine/pull/10242) Remove Dead Scenic Clipping Code Path.

[10265](https://github.com/flutter/engine/pull/10265) [dart-roll] Roll dart sdk to 80c4954d4d1d2a257005793d83b601f3ff2997a2

[10273](https://github.com/flutter/engine/pull/10273) Remove one last final call to AddPart()

[10282](https://github.com/flutter/engine/pull/10282) Export FFI from sky_engine.

[10295](https://github.com/flutter/engine/pull/10295) Fix memory overrun in minikin patch

[10296](https://github.com/flutter/engine/pull/10296) fix CI

[10297](https://github.com/flutter/engine/pull/10297) Ensure that the SingleFrameCodec stays alive until the ImageDecoder invokes its callback

[10298](https://github.com/flutter/engine/pull/10298) Fix red build again

[10303](https://github.com/flutter/engine/pull/10303) Make tree green for real this time, I promise.

[10414](https://github.com/flutter/engine/pull/10414) expose max depth on Window

[10419](https://github.com/flutter/engine/pull/10419) Make kernel compiler use host toolchain

[10423](https://github.com/flutter/engine/pull/10423) Fix mac gen_snapshot uploader

[10430](https://github.com/flutter/engine/pull/10430) Add copy_gen_snapshots.py tool

[10477](https://github.com/flutter/engine/pull/10477) Add #else, #endif condition comments

[10479](https://github.com/flutter/engine/pull/10479) Delete unused create_macos_gen_snapshot.py script

[10485](https://github.com/flutter/engine/pull/10485) Remove semi-redundant try-jobs.

[10629](https://github.com/flutter/engine/pull/10629) Fix engine platformviewscontroller leak

[10637](https://github.com/flutter/engine/pull/10637) Document the thread test fixture.

[10644](https://github.com/flutter/engine/pull/10644) [flutter_runner] Port: Add connectToService, wrapping fdio_ns_connect.

[10652](https://github.com/flutter/engine/pull/10652) Allow embedders to control Dart VM lifecycle on engine shutdown.

[10674](https://github.com/flutter/engine/pull/10674) When setting up AOT snapshots from symbol references, make buffer sizes optional.

[10675](https://github.com/flutter/engine/pull/10675) Improvements to the flutter GDB script

[10773](https://github.com/flutter/engine/pull/10773) Remove use of the deprecated AccessibilityNodeInfo boundsInParent API

[10776](https://github.com/flutter/engine/pull/10776) rename stub_ui to web_ui

[10780](https://github.com/flutter/engine/pull/10780) [flutter_runner] Improve frame scheduling

[10781](https://github.com/flutter/engine/pull/10781) [flutter] Create the compositor context on the GPU task runner.

[10782](https://github.com/flutter/engine/pull/10782) Update license script to handle ANGLE

[10783](https://github.com/flutter/engine/pull/10783) Make firebase test more LUCI friendly

[10786](https://github.com/flutter/engine/pull/10786) Remove 3 semi-redundant try-jobs

[10787](https://github.com/flutter/engine/pull/10787) Change call to |AddPart| to |AddChild|

[10788](https://github.com/flutter/engine/pull/10788) Wire up a concurrent message loop backed SkExecutor for Skia.

[10797](https://github.com/flutter/engine/pull/10797) Rename artifacts so they match the Maven convention

[10799](https://github.com/flutter/engine/pull/10799) Add a test for creating images from bytes.

[10808](https://github.com/flutter/engine/pull/10808) Remove flutter_kernel_sdk dart script

[10809](https://github.com/flutter/engine/pull/10809) [dart:zircon] Porting Cache re-usable handle wait objects

[10815](https://github.com/flutter/engine/pull/10815) Return an empty mapping for an empty file asset

[10816](https://github.com/flutter/engine/pull/10816) Add firstFrameDidRender to FlutterViewController

[10823](https://github.com/flutter/engine/pull/10823) Expose isolateId for engine

[10941](https://github.com/flutter/engine/pull/10941) Report test failures in run_tests.py

[10952](https://github.com/flutter/engine/pull/10952) Change SemanticsNode#children lists to be non-null

[10955](https://github.com/flutter/engine/pull/10955) Fix format

[10956](https://github.com/flutter/engine/pull/10956) Increase the license block scan from 5k to 6k

[11002](https://github.com/flutter/engine/pull/11002) Remove a tracing macro with a dangling pointer

[11004](https://github.com/flutter/engine/pull/11004) Trace RasterCacheResult::Draw

[11005](https://github.com/flutter/engine/pull/11005) Drop firebase test from Cirrus

[11007](https://github.com/flutter/engine/pull/11007) Update [README.md](http://readme.md/)

[11011](https://github.com/flutter/engine/pull/11011) Initialize the engine in the running state to match the animator's default state

[11012](https://github.com/flutter/engine/pull/11012) Remove the ParagraphImpl class from the text API

[11013](https://github.com/flutter/engine/pull/11013) Remove ability to override mac_sdk_path in flutter/tools/gn

[11024](https://github.com/flutter/engine/pull/11024) Add _glfw versions of the GLFW desktop libraries

[11027](https://github.com/flutter/engine/pull/11027) Fix first frame logic

[11029](https://github.com/flutter/engine/pull/11029) Disable a deprecation warning for use of a TaskDescription constructor for older platforms

[11033](https://github.com/flutter/engine/pull/11033) remove OS version

[11034](https://github.com/flutter/engine/pull/11034) Show all license diffs

[11038](https://github.com/flutter/engine/pull/11038) Make JIT work on iPhone armv7

[11040](https://github.com/flutter/engine/pull/11040) Hide verbose dart snapshot during run_test.py

[11041](https://github.com/flutter/engine/pull/11041) Add a BroadcastStream to FrameTiming

[11046](https://github.com/flutter/engine/pull/11046) Add ccls config files to .gitignore

[11052](https://github.com/flutter/engine/pull/11052) Remove unused dstColorSpace argument to MakeCrossContextFromPixmap

[11056](https://github.com/flutter/engine/pull/11056) Sort the Skia typefaces in a font style set into a consistent order

[11062](https://github.com/flutter/engine/pull/11062) Provide a placeholder queue ID for the custom embedder task runner.

[11067](https://github.com/flutter/engine/pull/11067) Minor update to the Robolectric test harness

[11068](https://github.com/flutter/engine/pull/11068) More updates to the Robolectric test harness

[11075](https://github.com/flutter/engine/pull/11075) [dynamic_thread_merging] Resubmit only on the frame where the merge


## Tools

As always, the end-to-end experience for Flutter relies heavily on its tools. With that in mind, in addition to the PRs listed below, which focus on the flutter CLI tool, you should also check out the following releases for the IntelliJ/Android Studio Flutter plugin, the VSCode Flutter plugin and Dart DevTools:



*   [DevTools 0.1.6 Release Notes](https://groups.google.com/forum/#!topic/flutter-announce/x9eiBq-OZUk) - Sept 5, 2019
*   [IntelliJ Plugin M39 Release Notes](https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!msg/flutter-announce/HH2-z-wYMH4/Yb1mzIPWBgAJ) - Sept 3, 2019
*   [VSCode Plugin v3.4](https://dartcode.org/releases/v3-4/) - Sept 3, 2019
*   [DevTools 0.1.5 Release Notes](https://groups.google.com/forum/#!searchin/flutter-announce/release$20notes|sort:date/flutter-announce/_tBeov94GEk/8IMoZnV0DQAJ) - Aug 5, 2019
*   [VSCode Plugin v3.3](https://dartcode.org/releases/v3-3/) - Aug 2, 2019
*   [IntelliJ Plugin M38 Release Notes](https://groups.google.com/forum/#!searchin/flutter-announce/intellij|sort:date/flutter-announce/-LQPz3C3JAM/ZR2WnOklEQAJ) - Aug 2, 2019
*   [DevTools 0.1.4 Release Notes](https://groups.google.com/forum/#!searchin/flutter-announce/release$20notes|sort:date/flutter-announce/ZUcqjzEDTKc/ABZtXXOpCgAJ) - Jul 19, 2019
*   [VSCode Plugin v3.2](https://dartcode.org/releases/v3-2/) - Jun 28, 2019

In addition, this release also has a lot going on under the hood to provide you with better, more actionable error messages. You can read about those details in [this blog post](https://medium.com/@taodong/e098513cecf9) from the Flutter User Experience team.

[32511](https://github.com/flutter/flutter/pull/32511) Rendering errors with root causes in the widget layer should have a reference to the widget

[28090](https://github.com/flutter/flutter/pull/28090) Ensure that cache dirs and files have appropriate permissions

[32816](https://github.com/flutter/flutter/pull/32816) Add initial implementation of flutter assemble

[34624](https://github.com/flutter/flutter/pull/34624) Break down flutter doctor validations and results

[34785](https://github.com/flutter/flutter/pull/34785) Tweak the display name of emulators

[34794](https://github.com/flutter/flutter/pull/34794) Add emulatorID field to devices in daemon

[35084](https://github.com/flutter/flutter/pull/35084) Move findTargetDevices to DeviceManager

[35092](https://github.com/flutter/flutter/pull/35092) Add FlutterProjectFactory so that it can be overridden internally.

[35186](https://github.com/flutter/flutter/pull/35186) Make tool coverage collection resilient to sentinel coverage data

[35188](https://github.com/flutter/flutter/pull/35188) ensure test isolate is paused before collecting coverage

[35192](https://github.com/flutter/flutter/pull/35192) don't block any presubmit on coverage

[35231](https://github.com/flutter/flutter/pull/35231) Fix coverage collection

[35367](https://github.com/flutter/flutter/pull/35367) Add type to StreamChannel in generated test code.

[35392](https://github.com/flutter/flutter/pull/35392) Add timer checking and Fake http client to testbed

[35406](https://github.com/flutter/flutter/pull/35406) Refactor signal and command line handler from resident runner

[35465](https://github.com/flutter/flutter/pull/35465) Mark update-packages as non-experimental

[35467](https://github.com/flutter/flutter/pull/35467) Mark update-packages as non-experimental

[35480](https://github.com/flutter/flutter/pull/35480) Update the help message on precache command for less confusion

[35681](https://github.com/flutter/flutter/pull/35681) Disable incremental compiler in dartdevc

[35765](https://github.com/flutter/flutter/pull/35765) Use public _registerService RPC in flutter_tools

[35767](https://github.com/flutter/flutter/pull/35767) set targets of zero percent for tools codecoverage

[35839](https://github.com/flutter/flutter/pull/35839) use pub run for create test and remove [INFO] logs

[35846](https://github.com/flutter/flutter/pull/35846) move reload and restart handling into terminal

[36017](https://github.com/flutter/flutter/pull/36017) Move reporting files to reporting/

[36082](https://github.com/flutter/flutter/pull/36082) Add better handling of JSON-RPC exception

[36084](https://github.com/flutter/flutter/pull/36084) handle google3 version of pb

[36105](https://github.com/flutter/flutter/pull/36105) [flutter_tool] Catch a yaml parse failure during project creation

[36109](https://github.com/flutter/flutter/pull/36109) Catch exceptions thrown by runChecked* when possible

[36122](https://github.com/flutter/flutter/pull/36122) Make sure add-to-app build bundle from outer xcodebuild/gradlew sends analytics

[36138](https://github.com/flutter/flutter/pull/36138) Implement feature flag system for flutter tools

[36199](https://github.com/flutter/flutter/pull/36199) Don't try to flutterExit if isolate is still paused

[36208](https://github.com/flutter/flutter/pull/36208) [flutter_tool] Allow analytics without a terminal attached

[36213](https://github.com/flutter/flutter/pull/36213) Use DeviceManager instead of device to determine if device supports project.

[36218](https://github.com/flutter/flutter/pull/36218) release lock in flutter pub context

[36237](https://github.com/flutter/flutter/pull/36237) Recommend to use the final version of CDN support for the trunk specs repo.

[36240](https://github.com/flutter/flutter/pull/36240) Rearrange flutter assemble implementation

[36288](https://github.com/flutter/flutter/pull/36288) Throw exception if instantiating IOSDevice on non-mac os platform

[36289](https://github.com/flutter/flutter/pull/36289) FakeHttpClientResponse improvements

[36318](https://github.com/flutter/flutter/pull/36318) Include flutter_runner in precache artifacts.

[36327](https://github.com/flutter/flutter/pull/36327) Fix invocations of ideviceinstaller not passing DYLD_LIBRARY_PATH

[36331](https://github.com/flutter/flutter/pull/36331) Minor fixes to precache help text (attempt #2)

[36434](https://github.com/flutter/flutter/pull/36434) Clean up flutter driver device detection.

[36481](https://github.com/flutter/flutter/pull/36481) Remove untested code

[36490](https://github.com/flutter/flutter/pull/36490) [flutter_tool] Send analytics command before the command runs

[36507](https://github.com/flutter/flutter/pull/36507) Bump engine version

[36513](https://github.com/flutter/flutter/pull/36513) Fix flutter pub -v

[36556](https://github.com/flutter/flutter/pull/36556) Fix usage test to use local usage

[36560](https://github.com/flutter/flutter/pull/36560) [flutter_tools] Add some useful commands to the [README.md](http://readme.md/)

[36564](https://github.com/flutter/flutter/pull/36564) Make sure fx flutter attach can find devices

[36569](https://github.com/flutter/flutter/pull/36569) Some minor cleanup for flutter_tools

[36570](https://github.com/flutter/flutter/pull/36570) Some minor fixes to the tool_coverage tool

[36585](https://github.com/flutter/flutter/pull/36585) Place build outputs under dart tool

[36598](https://github.com/flutter/flutter/pull/36598) Expose functionality to compile dart to kernel for the VM

[36679](https://github.com/flutter/flutter/pull/36679) add line-length to flutter format command line

[36727](https://github.com/flutter/flutter/pull/36727) Add missing config to create

[36773](https://github.com/flutter/flutter/pull/36773) Expose build-dir config option

[36774](https://github.com/flutter/flutter/pull/36774) Parameterize CoverageCollector with a library name predicate

[36785](https://github.com/flutter/flutter/pull/36785) [flutter_tool] Clean up usage events and custom dimensions

[36787](https://github.com/flutter/flutter/pull/36787) Check for directory instead of path separator

[36832](https://github.com/flutter/flutter/pull/36832) Remove flaky check for analyzer message.

[37036](https://github.com/flutter/flutter/pull/37036) Build number (part after +) is documented as optional, use entire app version if not present

[37044](https://github.com/flutter/flutter/pull/37044) [flutter_tool] Make a couple file operations synchronous

[37186](https://github.com/flutter/flutter/pull/37186) [flutter_tool] Usage refactor cleanup

[37196](https://github.com/flutter/flutter/pull/37196) [flutter_tool] Catch ProcessException from 'adb devices'

[37198](https://github.com/flutter/flutter/pull/37198) [flutter_tool] Re-try sending the first crash report

[37210](https://github.com/flutter/flutter/pull/37210) do not strip symbols when building profile

[37217](https://github.com/flutter/flutter/pull/37217) hide symbols from spotlight for App.framework

[37331](https://github.com/flutter/flutter/pull/37331) [flutter_tool] Add missing toString()

[37345](https://github.com/flutter/flutter/pull/37345) [flutter_tool] Include the local timezone in analytics timestamp

[37378](https://github.com/flutter/flutter/pull/37378) Disable xcode indexing in CI via COMPILER_INDEX_STORE_ENABLE=NO argument

[37422](https://github.com/flutter/flutter/pull/37422) [flutter_tool] Additional flutter manifest yaml validation

[37440](https://github.com/flutter/flutter/pull/37440) Print message when HttpException is thrown after running flutter run

[37457](https://github.com/flutter/flutter/pull/37457) Find the app bundle when the flavor contains underscores

[37500](https://github.com/flutter/flutter/pull/37500) Avoid killing Flutter tool process (#37471)

[37512](https://github.com/flutter/flutter/pull/37512) Enable track widget creation on debug builds

[37514](https://github.com/flutter/flutter/pull/37514) [flutter_tool] Remove unintended analytics screen send

[37521](https://github.com/flutter/flutter/pull/37521) have xcodeSelectPath also catch ArgumentError

[37595](https://github.com/flutter/flutter/pull/37595) Closes #37593 Add flutter_export_environment.sh to gitignore

[37654](https://github.com/flutter/flutter/pull/37654) Add missing library to flutter tools [BUILD.gn](http://build.gn/)

[37731](https://github.com/flutter/flutter/pull/37731) Add metadata to indicate if the host app contains a Flutter module

[37735](https://github.com/flutter/flutter/pull/37735) Remove unused no-build flag from the flutter run command

[37743](https://github.com/flutter/flutter/pull/37743) Handle thrown maps and rejects from fe server

[37792](https://github.com/flutter/flutter/pull/37792) Disable the progress bar when downloading the Dart SDK via Invoke-WebRequest

[37863](https://github.com/flutter/flutter/pull/37863) Expose the timeline event names so they can be used in other systems that do tracing

[37871](https://github.com/flutter/flutter/pull/37871) Catch failure to create directory in cache

[37900](https://github.com/flutter/flutter/pull/37900) Listen to ExtensionEvent instead of TimelineEvent

[37958](https://github.com/flutter/flutter/pull/37958) Catch FormatException caused by bad simctl output

[37966](https://github.com/flutter/flutter/pull/37966) Remove ephemeral directories during flutter clean

[37994](https://github.com/flutter/flutter/pull/37994) Remove no-constant-update-2018, the underlying issue has been resolved.

[38101](https://github.com/flutter/flutter/pull/38101) Catch filesystem exception from flutter create

[38102](https://github.com/flutter/flutter/pull/38102) Fix type error hidden by implicit downcasts

[38296](https://github.com/flutter/flutter/pull/38296) use common emulator/device list

[38339](https://github.com/flutter/flutter/pull/38339) [flutter_tool] Flip create language defaults to swift and kotlin

[38342](https://github.com/flutter/flutter/pull/38342) remove bsdiff from [BUILD.gn](http://build.gn/)

[38353](https://github.com/flutter/flutter/pull/38353) [flutter_tool] Observatory connection error handling cleanup

[38472](https://github.com/flutter/flutter/pull/38472) [flutter_tool] Fix bug in manifest yaml validation

[38486](https://github.com/flutter/flutter/pull/38486) Catch errors thrown into the Zone by json_rpc

[38490](https://github.com/flutter/flutter/pull/38490) Fix publish cmd

[38497](https://github.com/flutter/flutter/pull/38497) handle unexpected exit from frontend server

[38575](https://github.com/flutter/flutter/pull/38575) fix rpc exception for real

[38586](https://github.com/flutter/flutter/pull/38586) Don't reload if compilation has errors

[38637](https://github.com/flutter/flutter/pull/38637) [flutter_tool] Throw tool exit on malformed storage url override

[38652](https://github.com/flutter/flutter/pull/38652) Kill dead code

[36860](https://github.com/flutter/flutter/pull/36860) Remove Chain terse parsing

[36874](https://github.com/flutter/flutter/pull/36874) Adjust phrasing of features

[36884](https://github.com/flutter/flutter/pull/36884) Unbreak build_runner


## Full PR List

You can see the full list of merged PRs in this release [here](/docs/development/tools/sdk/release-notes/changelogs/changelog-1.9.1).