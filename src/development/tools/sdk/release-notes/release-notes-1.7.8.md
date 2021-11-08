---
title: Flutter 1.7.8 release notes
short-title: 1.7.8 release notes
description: Release notes for Flutter 1.7.8.
---

The 1.7.8 release is a follow-on to the 1.5.4 stable release in May,
providing 1289 merged PRs and closing 184 issues.
The major themes of this release are:

*   Support for 32-bit and 64-bit bundles on Android
*   Large number of iOS features and fixes,
    including improved text editing and localization
*   [AndroidX support](https://github.com/flutter/flutter/pull/31028)
    for new projects via the --androidx flag of ‘flutter create’
*   A new widget: the
    [RangeSlider](https://api.flutter.dev/flutter/material/RangeSlider-class.html)

As detailed in our
[roadmap](https://github.com/flutter/flutter/wiki/Roadmap),
we're also continuing the ongoing work in the Flutter engine
and framework to support turning on web and desktop targets;
however, this is not yet ready for general usage.


## Support for 32-bit and 64-bit Android Bundles

From August 1st, 2019, Android apps that use native code and target Android 9 Pie will[ be required to provide a 64-bit version](https://android-developers.googleblog.com/2019/01/get-your-apps-ready-for-64-bit.html) in addition to the 32-bit version when publishing to the Google Play Store. Since all Flutter apps include native code, this requirement will affect new Flutter apps submitted to the store, as well as updates to existing Flutter apps. This does not affect existing app versions published to the store.

This release includes support for building app bundles and APKs that support both 32-bit and 64-bit binaries, completing our work on [https://github.com/flutter/flutter/issues/31922](https://github.com/flutter/flutter/issues/31922). By using this release when building an Android application, your App Bundle or APK now supports both 32-bit and 64-bit CPU architectures by default.


## Breaking Changes

The following are the list of breaking changes in this release along with descriptions of each change and how to handle it in your Flutter code.

*   [#29188](https://github.com/flutter/flutter/pull/29188) Fix 25807: implement move in sliver multibox widget
*   [#29683](https://github.com/flutter/flutter/pull/29683) [Show/hide toolbar and handles based on device kind](https://groups.google.com/d/msgid/flutter-announce/CAAzQ467mb_7ZC4-djDeWLiYEmAH815-R5eums2cWmo2ND%3Dz%3DOw%40mail.gmail.com.)
*   [#30040](https://github.com/flutter/flutter/pull/30040) Implement focus traversal for desktop platforms, shoehorn edition.
*   [#30579](https://github.com/flutter/flutter/pull/30579) [PointerDownEvent and PointerMoveEvent default buttons to 1](https://groups.google.com/d/msgid/flutter-announce/9ed026a5-f6e3-438d-b4fd-303ae444323d%40googlegroups.com.)
*   [#30874](https://github.com/flutter/flutter/pull/30874) Redo “Remove pressure customization from some pointer events”
*   [#31227](https://github.com/flutter/flutter/pull/31227) [Adding CupertinoTabController](https://groups.google.com/d/msgid/flutter-announce/a1e7e4df-0310-4083-93b6-12ffd150dad0%40googlegroups.com.)
*   [#31574](https://github.com/flutter/flutter/pull/31574) Improve RadioListTile Callback Behavior Consistency
*   [#32059](https://github.com/flutter/flutter/pull/32059) fix issue 14014 read only text field
*   [#32842](https://github.com/flutter/flutter/pull/32842) Allow “from” hero state to survive hero animation in a push transition
*   [#33148](https://github.com/flutter/flutter/pull/33148) ExpandIcon Custom Colors
*   [#33164](https://github.com/flutter/flutter/pull/33164) [remove Layer.replaceWith due to no usage and no tests](https://groups.google.com/d/msgid/flutter-announce/f9823aec-676a-41e9-a9ff-b6598c63b7fe%40googlegroups.com)
*   [#33370](https://github.com/flutter/flutter/pull/33370) [Update FadeInImage to use new Image APIs]( https://groups.google.com/d/msgid/flutter-announce/CAA8mi4cGh6BVXS5u0g_7Kep6LOL6gO5htViMTgS%2BkMJ08oAjAQ%40mail.gmail.com.)
*   [#34051](https://github.com/flutter/flutter/pull/34051) [Text inline widgets, TextSpan rework (#30069)” with improved backwards compatibility](https://groups.google.com/d/msgid/flutter-announce/CAN87bmyu29-ikjeSouVFNcpR7OEL95NPLnb7DN-F8bVLsnzkzQ%40mail.gmail.com.)
*   [#34095](https://github.com/flutter/flutter/pull/34095) [Cupertino text edit to oltip, reworked](https://groups.google.com/d/msgid/flutter-announce/f7cc747a-c812-4bab-a97c-4adb4ce04084%40googlegroups.com.)
*   [#34501](https://github.com/flutter/flutter/pull/34501) [Material] Fix TextDirection and selected thumb for RangeSliderThumbShape and RangeSliderValueIndicatorShape
*   [#33946](https://github.com/flutter/flutter/pull/33946) Reland “Text inline widgets, TextSpan rework”


## Severe Crash Changes

We’ve also fixed several crashing issues in this release.

*   [#31228](https://github.com/flutter/flutter/pull/31228) Fix ExpansionPanelList Duplicate Global Keys Exception
*   [#31581](https://github.com/flutter/flutter/pull/31581) Fix Exception on Nested TabBarView disposal
*   [#34460](https://github.com/flutter/flutter/pull/34460) Add back ability to override the local engine in Gradle


## iOS

We continue to focus heavily on the iOS support in Flutter, including enhanced text editing and localization in this release.

*   [#29809](https://github.com/flutter/flutter/pull/29809) Fix text selection toolbar appearing under obstructions
*   [#29824](https://github.com/flutter/flutter/pull/29824) Cupertino localization step 8: create a gen_cupertino_localizations and generate one for cupertino english and french
*   [#29954](https://github.com/flutter/flutter/pull/29954) Cupertino localization step 9: add tests
*   [#30129](https://github.com/flutter/flutter/pull/30129) Fix refresh control in the gallery demo, update comments
*   [#30224](https://github.com/flutter/flutter/pull/30224) Cupertino localization step 10: update the flutter_localizations README
*   [#31039](https://github.com/flutter/flutter/pull/31039) Fix bundle id on iOS launch using flutter run
*   [#31308](https://github.com/flutter/flutter/pull/31308) Added font bold when isDefaultAction is true in CupertinoDialogAction
*   [#31326](https://github.com/flutter/flutter/pull/31326) Add more shuffle cupertino icons
*   [#31332](https://github.com/flutter/flutter/pull/31332) iOS selection handles are invisible
*   [#31464](https://github.com/flutter/flutter/pull/31464) CupertinoPicker fidelity revision
*   [#31623](https://github.com/flutter/flutter/pull/31623) fix edge swiping and dropping back at starting point
*   [#31644](https://github.com/flutter/flutter/pull/31644) Cupertino localization step 12: push translation for all supported languages
*   [#31687](https://github.com/flutter/flutter/pull/31687) Center iOS caret, remove constant offsets that do not scale
*   [#31763](https://github.com/flutter/flutter/pull/31763) Fix ScrollbarPainter thumbExtent calculation and add padding
*   [#31852](https://github.com/flutter/flutter/pull/31852) Text selection handles are sometimes not interactive
*   [#32013](https://github.com/flutter/flutter/pull/32013) Cupertino Turkish Translation
*   [#32086](https://github.com/flutter/flutter/pull/32086) Fix CupertinoSliverRefreshControl onRefresh callback
*   [#32469](https://github.com/flutter/flutter/pull/32469) Let CupertinoNavigationBarBackButton take a custom onPressed
*   [#32513](https://github.com/flutter/flutter/pull/32513) Cupertino localization step 12 try 2: push translation for all supported languages
*   [#32620](https://github.com/flutter/flutter/pull/32620) Added ScrollController to TextField
*   [#32823](https://github.com/flutter/flutter/pull/32823) Add enableInteractiveSelection to CupertinoTextField
*   [#32974](https://github.com/flutter/flutter/pull/32974) Fix disabled CupertinoTextField style
*   [#33450](https://github.com/flutter/flutter/pull/33450) Do not return null from IosProject.isSwift
*   [#33624](https://github.com/flutter/flutter/pull/33624) CupertinoTabScaffold crash fix
*   [#33634](https://github.com/flutter/flutter/pull/33634) Let there be scroll bars
*   [#33653](https://github.com/flutter/flutter/pull/33653) Include advice about dispose in TextEditingController api
*   [#33684](https://github.com/flutter/flutter/pull/33684) Disable CocoaPods input and output paths in Xcode build phase and adopt new Xcode build system
*   [#33739](https://github.com/flutter/flutter/pull/33739) fixed cupertinoTextField placeholder textAlign
*   [#33852](https://github.com/flutter/flutter/pull/33852) Disable CocoaPods input and output paths in Xcode build phase and adopt new Xcode build system
*   [#34293](https://github.com/flutter/flutter/pull/34293) Change Xcode developmentRegion to ‘en’ and CFBundleDevelopmentRegion to DEVELOPMENT_LANGUAGE
*   [#34964](https://github.com/flutter/flutter/pull/34964) CupertinoTextField.onTap


## Android

In this release, we’ve improved support for Android with new support for AndroidX from an external contributor (Thanks, [Josh](https://github.com/athornz)!) and supporting 64-bit and 32-bit APK bundles in compliance with [the Google Play Store’s updated policy](https://developer.android.com/distribute/best-practices/develop/64-bit).



*   [#31028](https://github.com/flutter/flutter/pull/31028) Adds support for generating projects that use AndroidX support libraries
*   [#31359](https://github.com/flutter/flutter/pull/31359) Remove support for building dynamic patches on Android
*   [#31491](https://github.com/flutter/flutter/pull/31491) Allow adb stdout to contain the port number without failing
*   [#31835](https://github.com/flutter/flutter/pull/31835) Cherry-pick ADB CrOS fix to beta
*   [#32787](https://github.com/flutter/flutter/pull/32787) Support 32 and 64 bit
*   [#33191](https://github.com/flutter/flutter/pull/33191) Remove colon from Gradle task name since it’s deprecated
*   [#33611](https://github.com/flutter/flutter/pull/33611) Use Dart’s new direct ELF generator to package AOT blobs as shared libraries in Android APKs
*   [#33696](https://github.com/flutter/flutter/pull/33696) Generate ELF shared libraries and allow multi-abi libs in APKs and App bundles
*   [#33901](https://github.com/flutter/flutter/pull/33901) Respond to AndroidView focus events.
*   [#33923](https://github.com/flutter/flutter/pull/33923) [flutter_tool] Track APK sha calculation time
*   [#33951](https://github.com/flutter/flutter/pull/33951) Whitelist adb.exe heap corruption exit code.
*   [#34066](https://github.com/flutter/flutter/pull/34066) Adds the androidX flag to a modules pubspec.yaml template so it is se…
*   [#34123](https://github.com/flutter/flutter/pull/34123) Generate ELF shared libraries and allow multi-abi libs in APKs and App bundles


## Material

This release includes a number of improvements to existing Material components, including the DatePicker, SnackBar and TimePicker, as well as a new component: the [RangeSlider](https://api.flutter.dev/flutter/material/RangeSlider-class.html).



*   [#30572](https://github.com/flutter/flutter/pull/30572) [Material] Adaptive Slider constructor
*   [#30884](https://github.com/flutter/flutter/pull/30884) [Material] Update TabController to support dynamic Tabs
*   [#31018](https://github.com/flutter/flutter/pull/31018) [Material] selected/unselected label styles + icon themes on BottomNavigationBar
*   [#31025](https://github.com/flutter/flutter/pull/31025) added scrimColor property in Scaffold widget
*   [#31275](https://github.com/flutter/flutter/pull/31275) Update SnackBar to allow for support of the new style from Material spec
*   [#31295](https://github.com/flutter/flutter/pull/31295) Improve ThemeData.accentColor connection to secondary color
*   [#31318](https://github.com/flutter/flutter/pull/31318) Add BottomSheetTheme to enable theming color, elevation, shape of BottomSheet
*   [#31438](https://github.com/flutter/flutter/pull/31438) Implements focus handling and hover for Material buttons.
*   [#31514](https://github.com/flutter/flutter/pull/31514) Date picker layout exceptions
*   [#31566](https://github.com/flutter/flutter/pull/31566) TimePicker moves to minute mode after hour selection
*   [#31662](https://github.com/flutter/flutter/pull/31662) added shape property to SliverAppBar
*   [#31681](https://github.com/flutter/flutter/pull/31681) [Material] Create a themable Range Slider (continuous and discrete)
*   [#31693](https://github.com/flutter/flutter/pull/31693) Adds a note to Radio’s/RadioListTile’s onChange
*   [#31902](https://github.com/flutter/flutter/pull/31902) Updated primaryColor docs to refer to colorScheme properties
*   [#31938](https://github.com/flutter/flutter/pull/31938) Update scrimDrawerColor with proper const format
*   [#32053](https://github.com/flutter/flutter/pull/32053) Increase TimePicker touch targets
*   [#32070](https://github.com/flutter/flutter/pull/32070) rename foreground and background to light and dark [#32527](https://github.com/flutter/flutter/pull/32527) Added ‘enabled’ property to the PopupMenuButton
*   [#32726](https://github.com/flutter/flutter/pull/32726) Material should not prevent ScrollNotifications from bubbling upwards
*   [#32904](https://github.com/flutter/flutter/pull/32904) Use reverseDuration on Tooltip and InkWell
*   [#32911](https://github.com/flutter/flutter/pull/32911) Material Long Press Text Handle Flash
*   [#33073](https://github.com/flutter/flutter/pull/33073) SliverAppBar shape property
*   [#34869](https://github.com/flutter/flutter/pull/34869) [Material] Properly call onChangeStart and onChangeEnd in Range Slider
*   [#32950](https://github.com/flutter/flutter/pull/32950) Material allows “select all” when not collapsed


## Web

The work on web functionality continues with merging of the code from flutter_web repo into the main flutter repo, providing a simpler developer experience for this pre-release technology. We’ve already [compiled many of the existing Flutter samples for web](https://flutter.github.io/samples/). Enjoy!



*   [#32360](https://github.com/flutter/flutter/pull/32360) Allow flutter web to be compiled with flutter
*   [#33197](https://github.com/flutter/flutter/pull/33197) Wire up hot restart and incremental rebuilds for web
*   [#33406](https://github.com/flutter/flutter/pull/33406) Add web safe indirection to Platform.isPlatform getters
*   [#33525](https://github.com/flutter/flutter/pull/33525) Add capability to flutter test –platform=chrome
*   [#33533](https://github.com/flutter/flutter/pull/33533) Reland - Wire up hot restart and incremental rebuilds for web
*   [#33629](https://github.com/flutter/flutter/pull/33629) Add real-er restart for web using webkit inspection protocol
*   [#33859](https://github.com/flutter/flutter/pull/33859) Reland support flutter test on platform chrome
*   [#33892](https://github.com/flutter/flutter/pull/33892) add benchmarks to track web size
*   [#33956](https://github.com/flutter/flutter/pull/33956) Codegen an entrypoint for flutter web applications
*   [#34018](https://github.com/flutter/flutter/pull/34018) Add flutter create for the web
*   [#34084](https://github.com/flutter/flutter/pull/34084) make running on web spooky
*   [#34112](https://github.com/flutter/flutter/pull/34112) Separate web and io implementations of network image
*   [#34159](https://github.com/flutter/flutter/pull/34159) Use product define for flutter web and remove extra asset server
*   [#34589](https://github.com/flutter/flutter/pull/34589) Remove most of the target logic for build web, cleanup rules
*   [#34856](https://github.com/flutter/flutter/pull/34856) set device name to Chrome
*   [#34885](https://github.com/flutter/flutter/pull/34885) Reland: rename web device


## Desktop

The experimental support for desktop in Flutter continues as well, with many improvements to the basics needed on desktop like hover, focus traversal, shortcuts, actions and even game controllers! We’ve also continued to simplify the developer experience, which you can read about [here](http://github.com/google/flutter-desktop-embedding). This is very early, but if you are trying desktop support in Flutter, please [log issues](https://github.com/google/flutter-desktop-embedding/issues) when you find them!



*   [#30076](https://github.com/flutter/flutter/pull/30076) Implements FocusTraversalPolicy and DefaultFocusTraversal features.
*   [#30339](https://github.com/flutter/flutter/pull/30339) Add buttons to gestures
*   [#31329](https://github.com/flutter/flutter/pull/31329) Add Xcode build script for macOS target
*   [#31515](https://github.com/flutter/flutter/pull/31515) Support local engine and asset sync for macOS
*   [#31567](https://github.com/flutter/flutter/pull/31567) Remove need for build/name scripts on Linux desktop
*   [#31631](https://github.com/flutter/flutter/pull/31631) Teach Linux to use local engine
*   [#31699](https://github.com/flutter/flutter/pull/31699) Re-land: Add support for Tooltip hover
*   [#31802](https://github.com/flutter/flutter/pull/31802) Reland “Fix text field selection toolbar under Opacity (#31097)”
*   [#31819](https://github.com/flutter/flutter/pull/31819) Redo: Add buttons to gestures
*   [#31873](https://github.com/flutter/flutter/pull/31873) Add basic desktop linux checks
*   [#31935](https://github.com/flutter/flutter/pull/31935) Redo#2: Add buttons to gestures
*   [#32025](https://github.com/flutter/flutter/pull/32025) Make Hover Listener respect transforms
*   [#32142](https://github.com/flutter/flutter/pull/32142) Fix RenderPointerListener so that callbacks aren’t called at the wrong time.
*   [#32335](https://github.com/flutter/flutter/pull/32335) Teach flutter msbuild for Windows
*   [#32776](https://github.com/flutter/flutter/pull/32776) Text field focus and hover support.
*   [#32838](https://github.com/flutter/flutter/pull/32838) Handles hidden by keyboard
*   [#32914](https://github.com/flutter/flutter/pull/32914) Make hover and focus not respond when buttons and fields are disabled.
*   [#33090](https://github.com/flutter/flutter/pull/33090) [Material] Add support for hovered, pressed, and focused text color on Buttons.
*   [#33277](https://github.com/flutter/flutter/pull/33277) Implement macOS support in flutter doctor
*   [#33279](https://github.com/flutter/flutter/pull/33279) Fix a problem in first focus determination.
*   [#33298](https://github.com/flutter/flutter/pull/33298) Add actions and keyboard shortcut map support
*   [#33443](https://github.com/flutter/flutter/pull/33443) Wrap Windows build invocation in a batch script
*   [#33454](https://github.com/flutter/flutter/pull/33454) ensure unpack declares required artifacts
*   [#33477](https://github.com/flutter/flutter/pull/33477) Fix onExit calling when the mouse is removed.
*   [#33540](https://github.com/flutter/flutter/pull/33540) Pass local engine variables to Windows build
*   [#33608](https://github.com/flutter/flutter/pull/33608) Restructure macOS project files
*   [#33632](https://github.com/flutter/flutter/pull/33632) Update the keycodes from source
*   [#33636](https://github.com/flutter/flutter/pull/33636) Implement plugin tooling support for macOS
*   [#33695](https://github.com/flutter/flutter/pull/33695) Add pseudo-key synonyms for keys like shift, meta, alt, and control.
*   [#33868](https://github.com/flutter/flutter/pull/33868) Game controller button support
*   [#33872](https://github.com/flutter/flutter/pull/33872) Add ‘doctor’ support for Windows
*   [#33874](https://github.com/flutter/flutter/pull/33874) Prevent windows web doctor from launching chrome
*   [#34050](https://github.com/flutter/flutter/pull/34050) limit open files on macOS when copying assets
*   [#34376](https://github.com/flutter/flutter/pull/34376) Add missing pieces for ‘driver’ support on macOS
*   [#34755](https://github.com/flutter/flutter/pull/34755) Add linux doctor implementation


## Animation, Scrolling & Images

In this release, we continue to polish animations, scrolling and image support.



*   [#21896](https://github.com/flutter/flutter/pull/21896) Bottom sheet scrolling
*   [#28834](https://github.com/flutter/flutter/pull/28834) Sliver animated list [#29677](https://github.com/flutter/flutter/pull/29677) Fix calculation of hero rectTween when Navigator isn’t fullscreen
*   [#32730](https://github.com/flutter/flutter/pull/32730) Add reverseDuration to AnimationController
*   [#32843](https://github.com/flutter/flutter/pull/32843) Added a missing dispose of an AnimationController that was leaking a ticker.
*   [#31832](https://github.com/flutter/flutter/pull/31832) Allow DSS to be dragged when its children do not fill extent
*   [#33627](https://github.com/flutter/flutter/pull/33627) SliverFillRemaining flag for different use cases
*   [#32853](https://github.com/flutter/flutter/pull/32853) Add onBytesReceived callback to consolidateHttpClientResponseBytes()
*   [#32857](https://github.com/flutter/flutter/pull/32857) Add debugNetworkImageHttpClientProvider
*   [#32936](https://github.com/flutter/flutter/pull/32936) Add some sanity to the ImageStream listener API
*   [#33729](https://github.com/flutter/flutter/pull/33729) Update consolidateHttpClientResponseBytes() to use compressionState
*   [#33369](https://github.com/flutter/flutter/pull/33369) Add loading support to Image


## Typography & Accessibility

We’re also continuing to push towards excellent typography and accessibility, including support for accessing OpenType font-specific features, as demonstrated in [this sample](https://github.com/timsneath/typography).



*   [#31987](https://github.com/flutter/flutter/pull/31987) Text wrap width
*   [#33230](https://github.com/flutter/flutter/pull/33230) Framework support for font features in text styles
*   [#33808](https://github.com/flutter/flutter/pull/33808) fix ExpansionPanelList merge the header semantics when it is not necessary
*   [#34368](https://github.com/flutter/flutter/pull/34368) Fix semantics_tester
*   [#34434](https://github.com/flutter/flutter/pull/34434) Semantics fixes


## Fundamentals

As always, we continue to polish the fundamentals.



*   [#30388](https://github.com/flutter/flutter/pull/30388) Add hintStyle in SearchDelegate
*   [#30406](https://github.com/flutter/flutter/pull/30406) Add binaryMessenger constructor argument to platform channels
*   [#30612](https://github.com/flutter/flutter/pull/30612) Added required parameters to FlexibleSpaceBarSettings
*   [#30796](https://github.com/flutter/flutter/pull/30796) Unbounded TextField width error
*   [#30942](https://github.com/flutter/flutter/pull/30942) rectMoreOrLess equals, prep for 64bit rects
*   [#31282](https://github.com/flutter/flutter/pull/31282) Stop precaching the artifacts for dynamic mode.
*   [#31485](https://github.com/flutter/flutter/pull/31485) Prevent exception being thrown on hasScrolledBody
*   [#31520](https://github.com/flutter/flutter/pull/31520) Don’t add empty OpacityLayer to the engine
*   [#31526](https://github.com/flutter/flutter/pull/31526) replace no-op log reader with real implementation
*   [#31757](https://github.com/flutter/flutter/pull/31757) Make FlutterProject factories synchronous
*   [#31807](https://github.com/flutter/flutter/pull/31807) Make const available for classes that override AssetBundle
*   [#31825](https://github.com/flutter/flutter/pull/31825) Fix missing return statements on function literals
*   [#31861](https://github.com/flutter/flutter/pull/31861) Add Horizontal Padding to Constrained Chip Label Calculations
*   [#31868](https://github.com/flutter/flutter/pull/31868) Handle notification errors
*   [#31889](https://github.com/flutter/flutter/pull/31889) Start abstracting platform logic builds behind a shared interface
*   [#32126](https://github.com/flutter/flutter/pull/32126) Bump multicast_dns version
*   [#32192](https://github.com/flutter/flutter/pull/32192) Transform PointerEvents to the local coordinate system of the event receiver
*   [#32328](https://github.com/flutter/flutter/pull/32328) Add breadcrumbs to TextOverflow
*   [#32434](https://github.com/flutter/flutter/pull/32434) Support for replacing the TabController, after disposing the old one
*   [#32528](https://github.com/flutter/flutter/pull/32528) Tapping a modal bottom sheet should not dismiss it by default
*   [#33152](https://github.com/flutter/flutter/pull/33152) ModalRoute resumes previous focus on didPopNext
*   [#33297](https://github.com/flutter/flutter/pull/33297) Instrument add to app flows
*   [#33458](https://github.com/flutter/flutter/pull/33458) Add to app measurement
*   [#33462](https://github.com/flutter/flutter/pull/33462) Fix text scaling of strut style
*   [#33473](https://github.com/flutter/flutter/pull/33473) fix 23723 rounding error
*   [#33474](https://github.com/flutter/flutter/pull/33474) Fixed for DropdownButton crashing when a style was used that didn’t include a fontSize
*   [#33475](https://github.com/flutter/flutter/pull/33475) Move declaration of semantic handlers from detectors to recognizers
*   [#33488](https://github.com/flutter/flutter/pull/33488) use toFixedAsString and DoubleProperty in diagnosticProperties
*   [#33802](https://github.com/flutter/flutter/pull/33802) Double double tap toggles instead of error
*   [#33876](https://github.com/flutter/flutter/pull/33876) Reland “Framework support for font features in text styles”
*   [#33886](https://github.com/flutter/flutter/pull/33886) Add currentSystemFrameTimeStamp to SchedulerBinding
*   [#33955](https://github.com/flutter/flutter/pull/33955) Add localFocalPoint to ScaleDetector
*   [#33999](https://github.com/flutter/flutter/pull/33999) Updating MediaQuery with viewPadding
*   [#34055](https://github.com/flutter/flutter/pull/34055) Toggle toolbar exception fix
*   [#34057](https://github.com/flutter/flutter/pull/34057) Add endIndent property to Divider and VerticalDivider
*   [#34068](https://github.com/flutter/flutter/pull/34068) fix empty selection arrow when double clicked on empty read only text…
*   [#34081](https://github.com/flutter/flutter/pull/34081) Report async callback errors that currently go unreported.
*   [#34175](https://github.com/flutter/flutter/pull/34175) Don’t show scrollbar if there isn’t enough content
*   [#34243](https://github.com/flutter/flutter/pull/34243) update the Flutter.Frame event to use new engine APIs
*   [#34295](https://github.com/flutter/flutter/pull/34295) Prepare for Uint8List SDK breaking changes
*   [#34298](https://github.com/flutter/flutter/pull/34298) Preserving SafeArea : Part 2
*   [#34355](https://github.com/flutter/flutter/pull/34355) Text field vertical align
*   [#34365](https://github.com/flutter/flutter/pull/34365) redux of a change to use new engine APIs for Flutter.Frame events
*   [#34508](https://github.com/flutter/flutter/pull/34508) add route information to Flutter.Navigation events
*   [#34512](https://github.com/flutter/flutter/pull/34512) Make sure fab semantics end up on top
*   [#34515](https://github.com/flutter/flutter/pull/34515) OutlineInputBorder adjusts for borderRadius that is too large
*   [#34519](https://github.com/flutter/flutter/pull/34519) fix page scroll position rounding error
*   [#34526](https://github.com/flutter/flutter/pull/34526) retry on HttpException during cache download
*   [#34529](https://github.com/flutter/flutter/pull/34529) Remove compilation trace and dynamic support code
*   [#34573](https://github.com/flutter/flutter/pull/34573) Ensures flutter jar is added to all build types on plugin projects
*   [#34587](https://github.com/flutter/flutter/pull/34587) Do not copy paths, rects, and rrects when layer offset is zero
*   [#34932](https://github.com/flutter/flutter/pull/34932) Added onChanged property to TextFormField
*   [#35092](https://github.com/flutter/flutter/pull/35092) Add FlutterProjectFactory so that it can be overridden internally.
*   [#33272](https://github.com/flutter/flutter/pull/33272) Add mustRunAfter on mergeAssets task to force task ordering
*   [#33535](https://github.com/flutter/flutter/pull/33535) Custom height parameters for DataTable header and data rows
*   [#33628](https://github.com/flutter/flutter/pull/33628) DataTable Custom Horizontal Padding


## Tooling

Last but not least, we continue to polish and simplify our tooling as well, including providing a much clearer error message when the flutter tooling finds itself in a read-only directory (a common problem for Flutter developers that we’re hoping this helps address).



*   [#31342](https://github.com/flutter/flutter/pull/31342) check if project exists before regenerating platform specific tooling
*   [#31399](https://github.com/flutter/flutter/pull/31399) add ignorable track-widget-creation flag to build aot
*   [#31406](https://github.com/flutter/flutter/pull/31406) if there is no .ios or ios sub-project, don’t attempt building for iOS
*   [#31446](https://github.com/flutter/flutter/pull/31446) Allow filtering devices to only those supported by current project
*   [#31591](https://github.com/flutter/flutter/pull/31591) make sure we exit early if the Runner.xcodeproj file is missing
*   [#31804](https://github.com/flutter/flutter/pull/31804) only build asset when there is asset declared in pubspec
*   [#31812](https://github.com/flutter/flutter/pull/31812) Fix #31764: Show appropriate error message when fonts pubspec.yaml isn’t iterable
*   [#32072](https://github.com/flutter/flutter/pull/32072) don’t NPE with empty pubspec
*   [#33041](https://github.com/flutter/flutter/pull/33041) Rename flutter packages to flutter pub
*   [#33448](https://github.com/flutter/flutter/pull/33448) Use vswhere to find Visual Studio
*   [#33472](https://github.com/flutter/flutter/pull/33472) add daemon command to enumerate supported platforms
*   [#33924](https://github.com/flutter/flutter/pull/33924) Added –dart-flags option to flutter run
*   [#33980](https://github.com/flutter/flutter/pull/33980) Increase daemon protocol version for getSupportedPlatforms
*   [#33990](https://github.com/flutter/flutter/pull/33990) Add device category for daemon
*   [#34181](https://github.com/flutter/flutter/pull/34181) Reland “Added –dart-flags option to flutter run (#33924)”
*   [#34291](https://github.com/flutter/flutter/pull/34291) Check whether FLUTTER_ROOT and FLUTTER_ROOT/bin are writable.
*   [#34353](https://github.com/flutter/flutter/pull/34353) Refactor Gradle plugin
*   [#34517](https://github.com/flutter/flutter/pull/34517) pass .packages path to snapshot invocation
*   [#34527](https://github.com/flutter/flutter/pull/34527) Don’t crash on invalid .packages file
*   [#34606](https://github.com/flutter/flutter/pull/34606) Remove portions of the Gradle script related to dynamic patching
*   [#34616](https://github.com/flutter/flutter/pull/34616) Kill compiler process when test does not exit cleanly
*   [#34624](https://github.com/flutter/flutter/pull/34624) Break down flutter doctor validations and results
*   [#34683](https://github.com/flutter/flutter/pull/34683) add read only semantics flag
*   [#34684](https://github.com/flutter/flutter/pull/34684) Add more structure to errors.
*   [#34685](https://github.com/flutter/flutter/pull/34685) Close platform when tests are complete (dispose compiler and delete font files)
*   [#34725](https://github.com/flutter/flutter/pull/34725) Fix NPE in flutter tools
*   [#34736](https://github.com/flutter/flutter/pull/34736) Remove flags related to dynamic patching
*   [#34785](https://github.com/flutter/flutter/pull/34785) Tweak the display name of emulators
*   [#34794](https://github.com/flutter/flutter/pull/34794) Add emulatorID field to devices in daemon
*   [#34802](https://github.com/flutter/flutter/pull/34802) Prefer ephemeral devices from command line run
*   [#34859](https://github.com/flutter/flutter/pull/34859) Fix Vertical Alignment Regression
*   [#35074](https://github.com/flutter/flutter/pull/35074) Attempt to enable tool coverage redux
*   [#35084](https://github.com/flutter/flutter/pull/35084) Move findTargetDevices to DeviceManager
*   [#33284](https://github.com/flutter/flutter/pull/33284) make sure we build test targets too
*   [#33867](https://github.com/flutter/flutter/pull/33867) Remove environment variable guards for command line desktop and web
*   [#33283](https://github.com/flutter/flutter/pull/33283) Fix relative paths and snapshot logic in tool


## Full Issue List

You can see the full list of issues addressed in this release [here](/docs/development/tools/sdk/release-notes/changelogs/changelog-1.7.8).
