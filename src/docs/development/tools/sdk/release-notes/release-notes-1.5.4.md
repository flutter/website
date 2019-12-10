---
title: Flutter 1.5.4 release notes
short-title: 1.5.4 release notes
description: Release notes for Flutter 1.5.4.
---

In addition to continuing to focus on quality and stability since the 1.2 release, the Flutter 1.5.4 stable release adds a set of new features as we approach the Google I/O conference. Further, [Apple has a deadline for building against the 12.1 version of their iOS SDK](https://developer.apple.com/news/?id=03202019a), which we now do in this update. You can meet Apple’s requirements simply by pulling down the 1.5.4 stable release, building and updating your Flutter app in the Apple Store.

Also, this build sees fixes for the two regressions we saw in Flutter 1.2:

* [#28640](https://github.com/flutter/flutter/issues/28640) NoSuchMethodError: **android.view.MotionEvent.isFromSource was closed and fixed in all versions after 1.3.7
* [#28484](https://github.com/flutter/flutter/issues/28484) Widget rendering strange since Flutter update:** a change was made fixes this regression in 1.4.0

Finally, for details about other fixes and new features, read on.


## Breaking Changes

Our recent survey showed that Flutter developers prefer a breaking change if it means that it improves the API and behavior of Flutter. Of course, we still make breaking changes sparingly. The following are the list of breaking changes in this release along with links to a full description of each change and how to handle it in your Flutter code.



*   [flutter#26261](https://github.com/flutter/flutter/issues/26261): CupertinoTextField's cursorColor default now matches the app's theme ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/uJFi5sENr1g))
*   [flutter#26026](https://github.com/flutter/flutter/issues/26261): Need to manually trigger selection toolbars when using raw EditableText ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/uJFi5sENr1g))
*   [flutter#23148](https://github.com/flutter/flutter/issues/26261): Proposing a fix to unify Android and iOS response in the Firebase Messagng Plugin ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/v4dt7Zc-NGg))
*   [flutter#28014](https://github.com/flutter/flutter/issues/26261): Converting PointerEvent to Diagnosticable ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/ZPPRKV642Uk))
*   [flutter#20183](https://github.com/flutter/flutter/issues/26261): CupertinoTextField: Merge provided TextStyle with Theme's TextStyle ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/3OV8J3GhO6U))
*   [flutter#20693](https://github.com/flutter/flutter/issues/26261): LongPressGestureRecognizer moving after long press no longer discards up event ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/kWT0J8Ii5Rw))
*   [flutter#20693](https://github.com/flutter/flutter/issues/26261): The GestureRecognizerState enum has a new 'accepted' value ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/YXNZ4OFL8Uo))
*   [flutter#18314](https://github.com/flutter/flutter/issues/26261), [flutter#22830](https://github.com/flutter/flutter/issues/26261), [flutter#23424](https://github.com/flutter/flutter/issues/26261): Drag moveBy calls are broken in two and the default DragStartBehavior in all widgets with drag recognizers is changed to DragStartBehavior.start ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/iTZt49dP_pU))
*   [flutter#27891](https://github.com/flutter/flutter/issues/26261): Composite layers for physical shapes on all platforms ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/8bAn-BPQPE8))
*   [flutter#19418](https://github.com/flutter/flutter/issues/26261): Adding onPlatformViewCreated to AndroidViewController ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/LoAfcK5IJ9A))
*   [flutter#29070](https://github.com/flutter/flutter/issues/26261): BackdropFilter will fill its parent/ancestor clip ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/AC4NDVh1h5k))
*   [flutter#29816](https://github.com/flutter/flutter/issues/26261): FontWeight.lerp to return null if args are null ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/0uS_Hzq894I))
*   [flutter#29696](https://github.com/flutter/flutter/issues/26261): Proposal to rename PointerEnterEvent and PointerExitEvent fromHoverEvent to fromMouseEvent ([Announcement & Mitigation](https://groups.google.com/forum/#!topic/flutter-announce/ECoJc9LOs2M))
*   [flutter#28602](https://github.com/flutter/flutter/pull/28602): Allow PointerEnterEvent and PointerExitEvents to be created from any PointerEvent
*   [flutter#28953](https://github.com/flutter/flutter/pull/28953): Include platformViewId in semantics tree
*   [flutter#27612](https://github.com/flutter/flutter/pull/27612): Force line height in TextFields with strut
*   [flutter#30991](https://github.com/flutter/flutter/pull/30991): Use full height of the glyph for caret height on Android
*   [flutter#30414](https://github.com/flutter/flutter/pull/30414): Remove pressure customization from some pointer events
*   [engine#8274](https://github.com/flutter/engine/pull/8274): [ui] Add null check in FontWeight.lerp


## Severe Performance and Crash Changes

In this release, we fixed several severe performance and crash issues.



*   [flutter#30990](https://github.com/flutter/flutter/pull/30990): Allow profile widget builds in profile mode
*   [flutter#30985](https://github.com/flutter/flutter/pull/30985): Add rrect contains microbenchmark
*   [flutter#28651](https://github.com/flutter/flutter/pull/28651): Cannot execute operation because FlutterJNI is not attached to native.


## iOS Changes

Supporting iOS is just as important to the Flutter team as support Android, which you can see in the huge volume of changes we’ve made in this release to make the iOS experience even better.  



*   [flutter#29200](https://github.com/flutter/flutter/pull/29200): Cupertino localization step 1: add an English arb file
*   [flutter#29821](https://github.com/flutter/flutter/pull/29821): Cupertino localization step 1.5: fix a resource mismatch in cupertino_en.arb
*   [flutter#30160](https://github.com/flutter/flutter/pull/30160): Cupertino localization 1.9: add needed singular resource for cupertino_en.arb
*   [flutter#29644](https://github.com/flutter/flutter/pull/29644): Cupertino localization step 3: in-place move some material tools around to make room for cupertino
*   [flutter#29650](https://github.com/flutter/flutter/pull/29650): Cupertino localization step 4: let generated date localization combine material and cupertino locales
*   [flutter#29708](https://github.com/flutter/flutter/pull/29708) Cupertino localization step 5: add french arb as translated example
*   [flutter#29767](https://github.com/flutter/flutter/pull/29767): Cupertino localization step 6: add a GlobalCupertinoLocalizations base class with date time formatting
*   [flutter#30527](https://github.com/flutter/flutter/pull/30527): Cupertino localization step 11: add more translation clarifications in the instructions
*   [flutter#28629](https://github.com/flutter/flutter/pull/28629): Make sure everything in the Cupertino page transition can be linear when back swiping
*   [flutter#28001](https://github.com/flutter/flutter/pull/28001): CupertinoTextField: added ability to change placeholder color
*   [flutter#29304](https://github.com/flutter/flutter/pull/29304): Include platformViewId in semantics tree for iOS
*   [flutter#29946](https://github.com/flutter/flutter/pull/29946): Let CupertinoPageScaffold have tap status bar to scroll to top
*   [flutter#29474](https://github.com/flutter/flutter/pull/29474): Let CupertinoTextField's clear button also call onChanged
*   [flutter#29008](https://github.com/flutter/flutter/pull/29008): Update CupertinoTextField
*   [flutter#29630](https://github.com/flutter/flutter/pull/29630): Add heart shapes to CupertinoIcons
*   [flutter#28597](https://github.com/flutter/flutter/pull/28597): Adjust remaining Cupertino route animations to match native
*   [flutter#29407](https://github.com/flutter/flutter/pull/29407): [cupertino_icons] Add circle and circle_filled, for radio buttons.
*   [flutter#29024](https://github.com/flutter/flutter/pull/29024): Fix CupertinoTabView tree re-shape on view inset change
*   [flutter#28478](https://github.com/flutter/flutter/pull/28478): Support iOS devices reporting pressure data of 0
*   [flutter#29987](https://github.com/flutter/flutter/pull/29987): update CupertinoSwitch documentation
*   [flutter#29943](https://github.com/flutter/flutter/pull/29943): Remove unwanted gap between navigation bar and safe area's child
*   [flutter#28855](https://github.com/flutter/flutter/pull/28855): Move material iOS back swipe test to material
*   [flutter#28756](https://github.com/flutter/flutter/pull/28756): Handle Cupertino back gesture interrupted by Navigator push
*   [flutter#31088](https://github.com/flutter/flutter/pull/31088): Text field scroll physics
*   [flutter#30946](https://github.com/flutter/flutter/pull/30946): Add some more cupertino icons
*   [flutter#30521](https://github.com/flutter/flutter/pull/30521): Provide a default IconTheme in CupertinoTheme
*   [flutter#30475](https://github.com/flutter/flutter/pull/30475): Trackpad mode crash fix


## Material Changes

Of course, Material continues to be a priority for the Flutter team as well.



*   [flutter#28290](https://github.com/flutter/flutter/pull/28290): [Material] Create a FloatingActionButton ThemeData and honor it within the FloatingActionButton ([#28735](https://github.com/flutter/flutter/pull/28735))
*   [flutter#29980](https://github.com/flutter/flutter/pull/29980): Fix issue with account drawer header arrow rotating when setState is called
*   [flutter#29563](https://github.com/flutter/flutter/pull/29563): Avoid flickering while dragging to select text
*   [flutter#29138](https://github.com/flutter/flutter/pull/29138): Update DropdownButton underline to be customizable
*   [flutter#29572](https://github.com/flutter/flutter/pull/29572): DropdownButton Icon customizability
*   [flutter#29183](https://github.com/flutter/flutter/pull/29183): Implement labelPadding configuration in TabBarTheme
*   [flutter#21834](https://github.com/flutter/flutter/pull/21834): Add shapeBorder option on App Bar
*   [flutter#28163](https://github.com/flutter/flutter/pull/28163): [Material] Add ability to set shadow color and selected shadow color for chips and for chip themes
*   [flutter#27711](https://github.com/flutter/flutter/pull/27711): Make extended FAB's icon optional
*   [flutter#28159](https://github.com/flutter/flutter/pull/28159): [Material] Expand BottomNavigationBar API (reprise)
*   [flutter#27973](https://github.com/flutter/flutter/pull/27973): Add extendBody parameter to Scaffold, body MediaQuery reflects BAB height
*   [flutter#30390](https://github.com/flutter/flutter/pull/30390): [Material] Update slider and slider theme with new sizes, shapes, and color mappings
*   [flutter#29390](https://github.com/flutter/flutter/pull/29390): Make expansion panel optionally toggle its state by tapping its header.
*   [flutter#30754](https://github.com/flutter/flutter/pull/30754): [Material] Fix showDialog crasher caused by old contexts
*   [flutter#30525](https://github.com/flutter/flutter/pull/30525): Fix cursor outside of input width
*   [flutter#30805](https://github.com/flutter/flutter/pull/30805): Update ExpansionPanelList Samples with Scaffold Template
*   [flutter#30537](https://github.com/flutter/flutter/pull/30537): Embedded images and added variations to ListTile sample code
*   [flutter#30455](https://github.com/flutter/flutter/pull/30455): Prevent vertical scroll in shrine by ensuring card size fits the screen
*   [flutter#29413](https://github.com/flutter/flutter/pull/29413): Fix MaterialApp's _navigatorObserver when only builder used


## Desktop Changes

Flutter has been making progress on expanding support for desktop-class input mechanisms with keyboard mappings, text selection, mouse wheels and hover along with the beginnings of desktop support in our tooling.



*   [flutter#29993](https://github.com/flutter/flutter/pull/29993): Adds the keyboard mapping for Linux
*   [flutter#29769](https://github.com/flutter/flutter/pull/29769): Add support for text selection via mouse to Cupertino text fields
*   [flutter#22762](https://github.com/flutter/flutter/pull/22762): Add support for scrollwheels
*   [flutter#28900](https://github.com/flutter/flutter/pull/28900): Add key support to cupertino button
*   [flutter#28290](https://github.com/flutter/flutter/pull/28290): Text selection via mouse
*   [flutter#28602](https://github.com/flutter/flutter/pull/28602): Allow PointerEnterEvent and PointerExitEvents to be created from any PointerEvent
*   [flutter#30829](https://github.com/flutter/flutter/pull/30829): Keep hover annotation layers in sync with the mouse detector.
*   [flutter#30648](https://github.com/flutter/flutter/pull/30648): Allow downloading of desktop embedding artifacts
*   [flutter#31283](https://github.com/flutter/flutter/pull/31283): Add desktop workflows to doctor
*   [flutter#31229](https://github.com/flutter/flutter/pull/31229): Add flutter run support for linux and windows
*   [flutter#31277](https://github.com/flutter/flutter/pull/31277): pass track widget creation flag through to build script
*   [flutter#31218](https://github.com/flutter/flutter/pull/31218): Add run capability for macOS target
*   [flutter#31205](https://github.com/flutter/flutter/pull/31205): Add desktop projects and build commands (experimental)
*   [flutter#30670](https://github.com/flutter/flutter/issues/30670): Implement StandardMethodCodec for C++ shells


## Framework Changes

In addition to platform specifics, we continue to push on the core of the Flutter framework.



*   [engine#8402](https://github.com/flutter/engine/pull/8402): Enable shutting down all root isolates in a VM.
*   [flutter#31210](https://github.com/flutter/flutter/pull/31210): Use full height of the glyph for caret height on Android v2
*   [flutter#30422](https://github.com/flutter/flutter/pull/30422): Commit a navigator.pop as soon as the back swipe is lifted
*   [flutter#30792](https://github.com/flutter/flutter/pull/30792): Rename Border.uniform() -> Border.fromSide()
*   [flutter#31159](https://github.com/flutter/flutter/pull/31159): Revert "Use full height of the glyph for caret height on Android"
*   [flutter#30932](https://github.com/flutter/flutter/pull/30932): 2d transforms UX improvements
*   [flutter#30898](https://github.com/flutter/flutter/pull/30898): Check that ErrorWidget.builder is not modified after test
*   [flutter#30809](https://github.com/flutter/flutter/pull/30809): Fix issue 23527: Exception: RenderViewport exceeded its maximum numb…
*   [flutter#30880](https://github.com/flutter/flutter/pull/30880): Let sliver.dart _createErrorWidget work with other Widgets
*   [flutter#30876](https://github.com/flutter/flutter/pull/30876): Simplify toImage future handling
*   [flutter#30470](https://github.com/flutter/flutter/pull/30470): Fixed Table flex column layout error #30437
*   [flutter#30215](https://github.com/flutter/flutter/pull/30215): Check for invalid elevations
*   [flutter#30667](https://github.com/flutter/flutter/pull/30667): Fix additional @mustCallSuper indirect overrides and mixins
*   [flutter#30814](https://github.com/flutter/flutter/pull/30814): Fix StatefulWidget and StatelessWidget Sample Documentation
*   [flutter#30760](https://github.com/flutter/flutter/pull/30760): fix cast NPE in invokeListMethod and invokeMapMethod
*   [flutter#30640](https://github.com/flutter/flutter/pull/30640): Add const Border.uniformSide()
*   [flutter#30644](https://github.com/flutter/flutter/pull/30644): Make FormField._validate() return void
*   [flutter#30645](https://github.com/flutter/flutter/pull/30645): Add docs to FormFieldValidator
*   [flutter#30563](https://github.com/flutter/flutter/pull/30563): Fixed a typo in the Expanded API doc
*   [flutter#30513](https://github.com/flutter/flutter/pull/30513): Fix issue 21640: Assertion Error : '_listenerAttached': is not true
*   [flutter#30305](https://github.com/flutter/flutter/pull/30305): shorter nullable list duplications
*   [flutter#30468](https://github.com/flutter/flutter/pull/30468): Embedding diagram for BottomNavigationBar.


## Plugin Changes

In this release, we also have a number of changes in the Flutter plugins, including camera, Google Maps, the Web View, the image picker, the Firebase plugins and, now for use in your apps, [the In-App Purchase plugin beta](https://pub.dartlang.org/packages/in_app_purchase).



*   [plugins#1477](https://github.com/flutter/plugins/pull/1477): [camera] Remove activity lifecycle
*   [plugins#1022](https://github.com/flutter/plugins/pull/1022): [camera] Add serial dispatch_queue for camera plugin to avoid blocking the UI
*   [plugins#1331](https://github.com/flutter/plugins/pull/1331): [connectivity] Enable fetching current Wi-Fi network's BSSID
*   [plugins#1455](https://github.com/flutter/plugins/pull/1455): [connectivity]Added integration test.
*   [plugins#1377](https://github.com/flutter/plugins/pull/1377): [firebase_admob] Update documentation to add iOS Admob ID & add iOS Admob ID in example project
*   [plugins#1492](https://github.com/flutter/plugins/pull/1492): [firebase_analytics] Initial integration test
*   [plugins#896](https://github.com/flutter/plugins/pull/896): [firebase-analytics] Enable setAnalyticsCollectionEnabled support for iOS
*   [plugins#1159](https://github.com/flutter/plugins/pull/1159): [firebase_auth] Enable passwordless sign in
*   [plugins#1487](https://github.com/flutter/plugins/pull/1487): [firebase_auth] Migrate FlutterAuthPlugin from deprecated APIs
*   [plugins#1443](https://github.com/flutter/plugins/pull/1443): [firebase_core] Use Gradle BoM with firebase_core
*   [plugins#1427](https://github.com/flutter/plugins/pull/1427): [firebase_crashlytics] Do not break debug log formatting.
*   [plugins#1437](https://github.com/flutter/plugins/pull/1437): [firebase_crashlytics] Fix to Initialize Fabric
*   [plugins#1096](https://github.com/flutter/plugins/pull/1096) :[firebase_database]Return error message from DatabaseError#toString()
*   [plugins#1532](https://github.com/flutter/plugins/pull/1532): [firebase_messaging] remove obsolete docs instruction
*   [plugins#1405](https://github.com/flutter/plugins/pull/1405): [firebase_messaging] Additional step for iOS
*   [plugins#1353](https://github.com/flutter/plugins/pull/1353): [firebase_messaging] Update example
*   [plugins#1223](https://github.com/flutter/plugins/pull/1223): [firebase_ml_vision] Fix crash when scanning URL QR-code on iOS
*   [plugins#1514](https://github.com/flutter/plugins/pull/1514): [firebase_remote_config] Initial integration tests
*   [plugins#815](https://github.com/flutter/plugins/pull/815): [google_maps_flutter] adds support for custom icon from a byte array (PNG)
*   [plugins#1229](https://github.com/flutter/plugins/pull/1229): [google_maps_flutter] Marker APIs are now widget based (Android)
*   [plugins#1421](https://github.com/flutter/plugins/pull/1421): [in_app_purchase]make payment unified APIs
*   [plugins#1380](https://github.com/flutter/plugins/pull/1380): [in_app_purchase]load purchase
*   [flutter#26329](https://github.com/flutter/flutter/issues/26329): IAP: Purchase an auto-renewing subscription
*   [flutter#26331](https://github.com/flutter/flutter/issues/26331): IAP: Purchase a non-renewing subscription
*   [flutter#26326](https://github.com/flutter/flutter/issues/26326): IAP: Load previous purchases
*   [plugins#1249](https://github.com/flutter/plugins/pull/1249): [in_app_purchase] payment queue dart ios
*   [flutter#26327](https://github.com/flutter/flutter/pull/26327): IAP: Purchase an unlock
*   [flutter#26328](https://github.com/flutter/flutter/pull/26328): IAP: Purchase a consumable
*   [flutter#29837](https://github.com/flutter/flutter/issues/29837): Image_picker flickers when barcode_scan and image_picker are used together
*   [flutter#17950](https://github.com/flutter/flutter/issues/17950): Image_picker plugin fails, if Flutter activity is killed while native one is shown
*   [flutter#18700](https://github.com/flutter/flutter/issues/18700): [image_picker] Crash on Galaxy S5 and Note 4 when attempting to use the camera
*   [plugins#1372](https://github.com/flutter/plugins/pull/1372): [image_picker] fix "Cancel button not visible in gallery, if camera was accessed first"
*   [plugins#1471](https://github.com/flutter/plugins/pull/1471): [image_picker] Fix invalid path being returned from Google Photos
*   [flutter#29422](https://github.com/flutter/flutter/issues/29422): image_picker error:Permission Denial
*   [plugins#1237](https://github.com/flutter/plugins/pull/1237): [share] Changed compileSdkVersion of share plugin to 28
*   [plugins#1373](https://github.com/flutter/plugins/pull/1373): [shared_preferences] Add contains method
*   [plugins#1470](https://github.com/flutter/plugins/pull/1470): [video_player] Android: Added missing event.put("event", "completed");
*   [flutter#25329](https://github.com/flutter/flutter/pull/25329): [WebView] Allow the webview to take control when a URL is about to be loaded


## Tool Changes

Last but certainly not least, we made a number of tooling changes in the core Flutter repos to improve the developer experience, particularly when it comes to improving hot reload performance (and you thought it was fast before!).



*   [flutter#29693](https://github.com/flutter/flutter/pull/29693): Use source list from the compiler to track invalidated files for hot reload.
*   [flutter#28152](https://github.com/flutter/flutter/pull/28152): Improve hot reload performance
*   [flutter#29494](https://github.com/flutter/flutter/pull/29494): initial work on coverage generating script for tool
*   [flutter#31171](https://github.com/flutter/flutter/pull/31171): Allow disabling all fingerprint caches via environment variable
*   [flutter#31073](https://github.com/flutter/flutter/pull/31073): Fuchsia step 1: add SDK version file and artifact download
*   [flutter#31064](https://github.com/flutter/flutter/pull/31064): Add sorting to flutter version command
*   [flutter#31063](https://github.com/flutter/flutter/pull/31063): Download and handle product version of flutter patched sdk
*   [flutter#31074](https://github.com/flutter/flutter/pull/31074): make flutterProject option of CoverageCollector optional
*   [flutter#30818](https://github.com/flutter/flutter/pull/30818): New flag to flutter drive to skip installing fresh app on device
*   [flutter#30867](https://github.com/flutter/flutter/pull/30867): Add toggle for debugProfileWidgetBuilds
*   [flutter#27034](https://github.com/flutter/flutter/pull/27034): Updated package template .gitignore file
*   [flutter#30115](https://github.com/flutter/flutter/pull/30115): Forward missing pub commands
*   [flutter#30254](https://github.com/flutter/flutter/pull/30254): Reland: Ensure that flutter run/drive/test/update_packages only downloads required artifacts
*   [flutter#30153](https://github.com/flutter/flutter/pull/30153): Allow disabling experimental commands, devices on stable branch
*   [flutter#30428](https://github.com/flutter/flutter/pull/30428): Update repair command for Arch Linux

Further, the IDE plugins for Flutter have had a number of updates since the last stable release of Flutter.



*   Visual Studio Code: [February 21, 2019 (2.23.1)](https://dartcode.org/releases/v2-23/)
*   Visual Studio Code: [February 27, 2019 (2.24.0)](https://dartcode.org/releases/v2-24/)
*   IntelliJ/Android Studio: [March 29, 2019 (M34)](https://groups.google.com/forum/#!msg/flutter-dev/-g7MlcL7u9s/VwZtnh-XAgAJ)
*   Visual Studio Code: [April 17, 2019 (2.25.1)](https://dartcode.org/releases/v2-25/)
*   IntelliJ/Android Studio: [April 26, 2019 (M35)](https://groups.google.com/forum/#!topic/flutter-dev/qZNjCI_2BLE)
*   Visual Studio Code: [May 1, 2019 (2.26.1)](https://dartcode.org/releases/v2-26/ )


## Dynamic Update (aka Code Push)

As a final note, we’re nearly at the midpoint of the year, when it’s time to reassess the areas where we can have the most important, we've decided to drop plans for dynamic updates (aka code push) from our 2019 roadmap. If you’re interested in the reasons why, you can read [the detailed explanation](https://github.com/flutter/flutter/issues/14330#issuecomment-485565194). Dropping this work allows us to increase our focus on quality as well as our experiments in Flutter for web and Flutter for desktop.


## Full Issue List

You can see [the full list of PRs committed in this release](/docs/development/tools/sdk/release-notes/changelogs/changelog-1.5.4).
