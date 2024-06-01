---
title: Flutter 3.3.0 release notes
short-title: 3.3.0 release notes
description: Release notes for Flutter 3.3.0.
---
This page has release notes for 3.3.0.
For information about subsequent bug-fix releases,
see [Hotfixes to the Stable Channel][].

[Hotfixes to the Stable Channel]: {{site.repo.flutter}}/blob/master/docs/releases/Hotfixes-to-the-Stable-Channel.md

## What's changed

The following changes happened in this release:

### Framework
* Improve A11Y tests for text contrast by @matasb-google in https://github.com/flutter/flutter/pull/100267
* Fixes `FadeInImage` to follow gapless playback by @werainkhatri in https://github.com/flutter/flutter/pull/94601
* Remove deprecated RaisedButton by @Piinks in https://github.com/flutter/flutter/pull/98547
* Remove text selection ThemeData deprecations 3 by @Piinks in https://github.com/flutter/flutter/pull/100586
* Configurable padding around FocusNodes in Scrollables by @ds84182 in https://github.com/flutter/flutter/pull/96815
* Add missing `ListTile` tests, remove duplicate test and fix typos by @TahaTesser in https://github.com/flutter/flutter/pull/101141
* Cleans up AutomaticKeepAlive by @chunhtai in https://github.com/flutter/flutter/pull/101376
* Add onDismiss to AnimatedModalBarrier, update tests by @gspencergoog in https://github.com/flutter/flutter/pull/100162
* Adjust some of the interface names to be consistent by @gspencergoog in https://github.com/flutter/flutter/pull/101378
* Fix `DrawerHeader` decoration not inheriting `ColorScheme.primary` by @TahaTesser in https://github.com/flutter/flutter/pull/101280
* Fix reverse cases for App Bar scrolled under behavior by @Piinks in https://github.com/flutter/flutter/pull/101460
* Add `ListTile` debugFillProperties by @TahaTesser in https://github.com/flutter/flutter/pull/100765
* Revert "Refactor `ToggleButtons` (remove `RawMaterialButton`)" by @Piinks in https://github.com/flutter/flutter/pull/101536
* Don't build surface until the platform view has been created by @blasten in https://github.com/flutter/flutter/pull/101399
* Re-enable Gold post-submit fail state by @Piinks in https://github.com/flutter/flutter/pull/101528
* Ensure that the engine frame callbacks are installed if the first scheduled frame is a forced frame by @jason-simmons in https://github.com/flutter/flutter/pull/101544
* Enable strict-casts (as replacement for implicit-casts) by @goderbauer in https://github.com/flutter/flutter/pull/101567
* Update key examples to use `Focus` widgets instead of `RawKeyboardListener` by @gspencergoog in https://github.com/flutter/flutter/pull/101537
* Enable unnecessary_import by @goderbauer in https://github.com/flutter/flutter/pull/101600
* Correct word in AppBar's docs by @guillempuche in https://github.com/flutter/flutter/pull/100893
* Remove deprecated Scaffold SnackBar API by @Piinks in https://github.com/flutter/flutter/pull/98549
* Migrate common buttons to Material 3 by @darrenaustin in https://github.com/flutter/flutter/pull/100794
* Allow ClipRRect.borderRadius to support BorderRadiusDirectional by @MrBirb in https://github.com/flutter/flutter/pull/101200
* Add some debug properties to BackdropFilterLayer by @wangying3426 in https://github.com/flutter/flutter/pull/101101
* Add debugging flags to enhance the timeline arguments for Build, Layout, and Paint by @kenzieschmoll in https://github.com/flutter/flutter/pull/101602
* Remove deprecated FlatButton by @Piinks in https://github.com/flutter/flutter/pull/98545
* Refactor chip class and move independent chips into separate classes by @TahaTesser in https://github.com/flutter/flutter/pull/101507
* Update WidgetsBindingsObserver example by @danagbemava-nc in https://github.com/flutter/flutter/pull/101512
* [framework] introduce repaint boundary in Opacity widgets by @jonahwilliams in https://github.com/flutter/flutter/pull/101601
* `CupertinoContextMenu`/`ContextMenuAction`: Add clickable cursor for web by @TahaTesser in https://github.com/flutter/flutter/pull/99519
* Fix test from opacity/repaint change by @jonahwilliams in https://github.com/flutter/flutter/pull/101774
* Revert "Configurable padding around FocusNodes in Scrollables" by @Piinks in https://github.com/flutter/flutter/pull/101772
* Add variable font axes to TextStyle by @jason-simmons in https://github.com/flutter/flutter/pull/100978
* [framework] elide ImageFilter layers when animation is stopped by @jonahwilliams in https://github.com/flutter/flutter/pull/101731
* removed obsolete timelineArgumentsIndicatingLandmarkEvent by @gaaclarke in https://github.com/flutter/flutter/pull/101382
* [framework] use ImageFilter for zoom page transition by @jonahwilliams in https://github.com/flutter/flutter/pull/101786
* Increased WriteBuffers starting capacity to 64 bytes. by @gaaclarke in https://github.com/flutter/flutter/pull/101790
* Support trackpad gestures in framework by @moffatman in https://github.com/flutter/flutter/pull/89944
* made ascii string encoding faster by @gaaclarke in https://github.com/flutter/flutter/pull/101777
* Always finish the timeline event logged by Element.inflateWidget by @jason-simmons in https://github.com/flutter/flutter/pull/101794
* Revert "[framework] use ImageFilter for zoom page transition" by @jonahwilliams in https://github.com/flutter/flutter/pull/101838
* Add default selection style by @chunhtai in https://github.com/flutter/flutter/pull/100719
* Removed extra the by @QuncCccccc in https://github.com/flutter/flutter/pull/101837
* Revert changes to opacity/fade transition repaint boundary and secondary change by @jonahwilliams in https://github.com/flutter/flutter/pull/101844
* Correct docs to refer to replacement render object by @Piinks in https://github.com/flutter/flutter/pull/101858
* Prepare framework for `use_super_parameters` by @goderbauer in https://github.com/flutter/flutter/pull/100905
* Test framework for executable files by @christopherfujino in https://github.com/flutter/flutter/pull/101853
* Fix InkWell highlight and splash sometimes persists by @bleroux in https://github.com/flutter/flutter/pull/100880
* Fix Backbutton is not displayed when there is a endDrawer by @chunhtai in https://github.com/flutter/flutter/pull/101869
* Clipping if only one character text overflows by @xu-baolin in https://github.com/flutter/flutter/pull/99146
* RawKeyboardMacos accepts a new field "specifiedLogicalKey" by @dkwingsmt in https://github.com/flutter/flutter/pull/100803
* Revert "Add default selection style (#100719)" by @chunhtai in https://github.com/flutter/flutter/pull/101921
* De-dupe docs by @Piinks in https://github.com/flutter/flutter/pull/101934
* adds `isAttached` getter to DraggableScrollableController by @maheshmnj in https://github.com/flutter/flutter/pull/100269
* Revert "Fix reverse cases for App Bar scrolled under behavior (#101460)" by @Piinks in https://github.com/flutter/flutter/pull/101929
* Linux and Windows right clicking text behavior by @justinmc in https://github.com/flutter/flutter/pull/101588
* Revert "Fix Backbutton is not displayed when there is a endDrawer (#1… by @chunhtai in https://github.com/flutter/flutter/pull/101998
* Add alignment parameter for `persistentFooterButtons` by @TahaTesser in https://github.com/flutter/flutter/pull/101297
* Register a service extension for `profileUserWidgetBuilds` by @kenzieschmoll in https://github.com/flutter/flutter/pull/101989
* Reland "Add default selection style (#100719)" by @chunhtai in https://github.com/flutter/flutter/pull/101954
* Refactor 'FakeSceneBuilder' to use 'NoSuchMethod Forwarding' by @ColdPaleLight in https://github.com/flutter/flutter/pull/101970
* Newly constructed tweens should have same begin and end by @werainkhatri in https://github.com/flutter/flutter/pull/94363
* Add Material 3 `Dialog` examples and update existing `Dialog` examples by @TahaTesser in https://github.com/flutter/flutter/pull/101508
* Add Material 3 `NavigationRail` example and improve Material 2 example by @TahaTesser in https://github.com/flutter/flutter/pull/101345
* Migrate `ListTile` TextTheme TextStyle references to Material 3 by @TahaTesser in https://github.com/flutter/flutter/pull/101900
* Add Material 3 `FloatingActionButton` and `FloatingActionButton` variants examples by @TahaTesser in https://github.com/flutter/flutter/pull/101105
* Add examples and troubleshooting comment for `ClipRRect` by @bleroux in https://github.com/flutter/flutter/pull/101907
* Delay focus trap unfocus until post-frame by @gspencergoog in https://github.com/flutter/flutter/pull/101847
* Revert "Clipping if only one character text overflows" by @justinmc in https://github.com/flutter/flutter/pull/102092
* Prevent Mediaquery from losing navigationMode value when removePadding() is called by @egramond in https://github.com/flutter/flutter/pull/101938
* Fix a `DataTable` crash and improve some docs by @xu-baolin in https://github.com/flutter/flutter/pull/100959
* Removed required from deprecated API by @Piinks in https://github.com/flutter/flutter/pull/102107
* Expose `ignoringPointer` property for `Draggable` and `LongPressDraggable` by @xu-baolin in https://github.com/flutter/flutter/pull/100475
* Revert "Migrate `ListTile` TextTheme TextStyle references to Material 3" by @HansMuller in https://github.com/flutter/flutter/pull/102152
* Add API sample code to AccessibilityGuideline by @chunhtai in https://github.com/flutter/flutter/pull/102161
* Fix spacing issues in `typography.dart`, `navigation_bar.dart` and `modal_barrier.dart` by @TahaTesser in https://github.com/flutter/flutter/pull/102136
* Increased StandardMethodCodec's WriteBuffer start capacity by @gaaclarke in https://github.com/flutter/flutter/pull/101860
* The sample code used within the comments in textContaining is wrong by @TowaYamashita in https://github.com/flutter/flutter/pull/100860
* Improve 'NestedScrollView and internal scrolling' test to account for all the inner children layers by @TahaTesser in https://github.com/flutter/flutter/pull/102309
* Adds tooltip to semantics node by @chunhtai in https://github.com/flutter/flutter/pull/87684
* Replace `ListTile` with `Chip` in the `debugCheckHasMaterial control test` by @TahaTesser in https://github.com/flutter/flutter/pull/102311
* Fix the code point for CupertinoIcons.location by @jason-simmons in https://github.com/flutter/flutter/pull/101923
* Fix jumping when doing long press for selecting text by @rgevrek in https://github.com/flutter/flutter/pull/102270
* Add matcher to find at least a given number of widgets (#102081) by @DanielCardonaRojas in https://github.com/flutter/flutter/pull/102342
* Assign debugCreator for more layers by @wangying3426 in https://github.com/flutter/flutter/pull/101899
* Enable TestDefaultBinaryMessenger to intercept all platform channels. by @HelioStrike in https://github.com/flutter/flutter/pull/100049
* Re-land reverse case for AppBar scrolled under by @Piinks in https://github.com/flutter/flutter/pull/102343
* Made Directionality forego dependency tracking for better performance. by @gaaclarke in https://github.com/flutter/flutter/pull/102336
* [framework] allow disabling image filter layer by @jonahwilliams in https://github.com/flutter/flutter/pull/102085
* Fix a `Slider` widget accessibility bug by @xu-baolin in https://github.com/flutter/flutter/pull/102129
* Fix DraggableScrollableController.animateTo leaks Ticker by @bleroux in https://github.com/flutter/flutter/pull/102504
* Avoid scheduling a forced frame when there is no child to the renderView by @dnfield in https://github.com/flutter/flutter/pull/102556
* [framework] allow other RenderObjects to behave like repaint boundaries by @jonahwilliams in https://github.com/flutter/flutter/pull/101952
* Revert "Re-land reverse case for AppBar scrolled under" by @Piinks in https://github.com/flutter/flutter/pull/102580
* [framework] Reland: use ImageFilter for zoom page transition  by @jonahwilliams in https://github.com/flutter/flutter/pull/102552
* Improve efficiency of copying the animation ObserverList in notifyListeners by @jason-simmons in https://github.com/flutter/flutter/pull/102536
* Fix docs re: return value of Navigator's restorable methods by @goderbauer in https://github.com/flutter/flutter/pull/102595
* [framework] remove usage and deprecate physical model layer by @jonahwilliams in https://github.com/flutter/flutter/pull/102274
* Revert "[framework] Reland: use ImageFilter for zoom page transition " by @jonahwilliams in https://github.com/flutter/flutter/pull/102611
* add missing trailing commas in list/set/map literals by @a14n in https://github.com/flutter/flutter/pull/102585
* rename local functions with `_`s by @pq in https://github.com/flutter/flutter/pull/102615
* Fixes documentation inconsistencies around 'material' and 'material design' by @guidezpl in https://github.com/flutter/flutter/pull/102632
* [reland] Refactor ToggleButtons (remove RawMaterialButton) by @TahaTesser in https://github.com/flutter/flutter/pull/101760
* Migrate AppBar to Material 3 by @darrenaustin in https://github.com/flutter/flutter/pull/101884
* Fix AppBar scrolledUnder initial state - the third by @Piinks in https://github.com/flutter/flutter/pull/102582
* [flutter_driver] rename local functions with `_`s by @pq in https://github.com/flutter/flutter/pull/102689
* Fix `BottomNavigationBar` label style text colors by @TahaTesser in https://github.com/flutter/flutter/pull/102638
* Revert "Fix `BottomNavigationBar` label style text colors" by @Piinks in https://github.com/flutter/flutter/pull/102756
* `ReorderableListView`: fix broken dartpad example & update examples, add tests  by @TahaTesser in https://github.com/flutter/flutter/pull/102723
* Add padding for Navigation Bar to account for safe area by @QuncCccccc in https://github.com/flutter/flutter/pull/102419
* Correct typos by @apeltop in https://github.com/flutter/flutter/pull/102487
* Add RouteInformationParser.parseRouteInformationWithDependencies by @chunhtai in https://github.com/flutter/flutter/pull/102414
* [web] allow small golden deltas in HTML renderer by @yjbanov in https://github.com/flutter/flutter/pull/102791
* Improvements to SearchDelegate by @prateekmedia in https://github.com/flutter/flutter/pull/91982
* `ToggleButtons`: Add interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/100124
* Add `surfaceTintColor` to `NavigationBar` by @TahaTesser in https://github.com/flutter/flutter/pull/102628
* `Hero`: Add an example for `createRectTween` by @TahaTesser in https://github.com/flutter/flutter/pull/102650
* Defer the OverlayEntry listenable disposal until its widget is unmounted by @LongCatIsLooong in https://github.com/flutter/flutter/pull/102794
* Update FAB M3 token template class to new naming scheme and fix a typo in `card.dart` by @TahaTesser in https://github.com/flutter/flutter/pull/102654
* delete fast reassemble code by @jonahwilliams in https://github.com/flutter/flutter/pull/102842
* Revert "delete fast reassemble code" by @zanderso in https://github.com/flutter/flutter/pull/102856
* Adds RouterConfig to simply API by @chunhtai in https://github.com/flutter/flutter/pull/102786
* Add widget of the week videos by @tvolkert in https://github.com/flutter/flutter/pull/102862
* Fix `CupertinoDatePicker` dark mode text color by @TahaTesser in https://github.com/flutter/flutter/pull/100312
* Fix `CupertinoFormRow` dark mode text color by @TahaTesser in https://github.com/flutter/flutter/pull/100313
* Fix `CupertinoPicker` dark mode text color by @TahaTesser in https://github.com/flutter/flutter/pull/100310
* Fix position of CupertinoContextMenu within Transform.scale by @moffatman in https://github.com/flutter/flutter/pull/97896
* Revert "Fix position of CupertinoContextMenu within Transform.scale" by @darrenaustin in https://github.com/flutter/flutter/pull/102938
* Fix `CupertinoTimerPicker` dark mode text color by @TahaTesser in https://github.com/flutter/flutter/pull/100311
* [devicelab, flutter_test, ...] rename local functions with `_`s by @pq in https://github.com/flutter/flutter/pull/102833
* partial revert of repaint boundary change by @jonahwilliams in https://github.com/flutter/flutter/pull/102962
* (Test-only) Add tests for new `ImageFilter.dilate`/`ImageFilter.erode` in flutter engine by @fzyzcjy in https://github.com/flutter/flutter/pull/101036
* Reland "Fix position of CupertinoContextMenu within Transform.scale" by @moffatman in https://github.com/flutter/flutter/pull/102943
* Add prominent link to Google Fonts from icons documentation by @guidezpl in https://github.com/flutter/flutter/pull/102808
* Don't hardcode ink sparkle SPIR-V by @zanderso in https://github.com/flutter/flutter/pull/102674
* Fix crash from alt-tab'ing just after startup by @jeremyschlatter in https://github.com/flutter/flutter/pull/102453
* Revert "Fix crash from alt-tab'ing just after startup" by @darrenaustin in https://github.com/flutter/flutter/pull/103074
* Fix `NavigationDestination` API doc by @guidezpl in https://github.com/flutter/flutter/pull/103031
* Add assertion that snackbars have a place to go by @Piinks in https://github.com/flutter/flutter/pull/103006
* `CupertinoSearchTextField`: Add interactive examples by @TahaTesser in https://github.com/flutter/flutter/pull/103042
* `CupertinoFormRow`: Add an interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/103041
* `CupertinoActivityIndicator`: Add an interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/103040
* `CupertinoSwitch`: Add an interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/103043
* Cupertino examples improvements and clean up by @TahaTesser in https://github.com/flutter/flutter/pull/103044
* Fix DraggableScrollableSheet leaks Ticker by @bleroux in https://github.com/flutter/flutter/pull/102916
* Add missing HIG links to cupertino documentation by @guidezpl in https://github.com/flutter/flutter/pull/103110
* rename local functions with `_`s by @pq in https://github.com/flutter/flutter/pull/102991
* Revert "Add assertion that snackbars have a place to go" by @Piinks in https://github.com/flutter/flutter/pull/103138
* Revert "Fix jumping when doing long press for selecting text" by @CaseyHillers in https://github.com/flutter/flutter/pull/103141
* Remove unnecessary space in doc comment of `TextStyle` by @nilsreichardt in https://github.com/flutter/flutter/pull/103117
* DefaultTextEditingShortcuts should use meta-based shortcut for iOS by @chunhtai in https://github.com/flutter/flutter/pull/103077
* Fix Backbutton is not displayed when there is a endDrawer by @chunhtai in https://github.com/flutter/flutter/pull/102093
* Reland "Fix crash from alt-tab'ing just after startup"  by @dkwingsmt in https://github.com/flutter/flutter/pull/103093
* Clear the baseline cache when RenderBox is laid out by @xu-baolin in https://github.com/flutter/flutter/pull/101493
* Does not replace the root layer unnecessarily by @xu-baolin in https://github.com/flutter/flutter/pull/101748
* [DropdownButton]: Fix `alignment` parameter doesn't work for `hint` when `isExpanded: true` by @TahaTesser in https://github.com/flutter/flutter/pull/102752
* Add blank line after first sentence of doc comment for `fontFamily` by @nilsreichardt in https://github.com/flutter/flutter/pull/103119
* Fix a [CupertinoDatePicker] semantics bug by @xu-baolin in https://github.com/flutter/flutter/pull/103123
* Increase Tooltip font size on Desktop by @bleroux in https://github.com/flutter/flutter/pull/103189
* remove unnecessary .toString() by @a14n in https://github.com/flutter/flutter/pull/103226
* remove assert on markNeedsCompositingBitsUpdate by @jonahwilliams in https://github.com/flutter/flutter/pull/103227
* Update Cupertino examples and add missing tests by @TahaTesser in https://github.com/flutter/flutter/pull/103128
* Fix `DropdownButton` menu clip by @TahaTesser in https://github.com/flutter/flutter/pull/102970
* Updating the Slider Widget to allow up and down arrow keys to navigate out of the slider when in directional NavigationMode. by @egramond in https://github.com/flutter/flutter/pull/103149
* Fix empty Stack with infinite constraints throws by @bleroux in https://github.com/flutter/flutter/pull/102642
* Added clipBehavior on TabBarView by @QuncCccccc in https://github.com/flutter/flutter/pull/103166
* Fix a `_WrappedScrollBehavior.shouldNotify` bug by @xu-baolin in https://github.com/flutter/flutter/pull/103267
* `CupertinoTabScaffold`/`CupertinoTabController`: Add interactive examples by @TahaTesser in https://github.com/flutter/flutter/pull/103196
* Adds `menuBarMenuLabel`, and removes unneeded key localizations by @gspencergoog in https://github.com/flutter/flutter/pull/102100
* Replace ListView with ListView.builder for LicensesPage by @Maistho in https://github.com/flutter/flutter/pull/102692
* Expose controller for PaginatedDataTable by @amanv8060 in https://github.com/flutter/flutter/pull/100005
* Fix Tooltip obscured by keyboard by @bleroux in https://github.com/flutter/flutter/pull/103339
* Updated tokens to v0.98. by @darrenaustin in https://github.com/flutter/flutter/pull/103360
* fix compile error in the example code by @ktakayama in https://github.com/flutter/flutter/pull/103261
* [Reland] Assert there are Scaffolds to present to for snackbars and banners by @Piinks in https://github.com/flutter/flutter/pull/103426
* Fix selection not deselected when TextField loses focus by @Renzo-Olivares in https://github.com/flutter/flutter/pull/103424
* fix `SliverReorderableList` not work on Android platform bug by @xu-baolin in https://github.com/flutter/flutter/pull/103406
* Fix ThemeData extension throws when the ThemeExtension not found by @SuperPenguin in https://github.com/flutter/flutter/pull/103343
* Accessibility troubleshooting docs for TextField widgets by @LongCatIsLooong in https://github.com/flutter/flutter/pull/103521
* [gen_keycode, RawKeyboard] Apply derived keyboard layout from Linux by @dkwingsmt in https://github.com/flutter/flutter/pull/102709
* Avoid analyzing API example code twice, clean-up by @goderbauer in https://github.com/flutter/flutter/pull/103548
* [framework] fix slider regression due to touch slop changes by @jonahwilliams in https://github.com/flutter/flutter/pull/103569
* Refactor web text editing shortcuts by @chunhtai in https://github.com/flutter/flutter/pull/103377
* Provide default method call handler for SystemChannels.textInput by @fbcouch in https://github.com/flutter/flutter/pull/101087
* Add Tooltip textAlign property by @bleroux in https://github.com/flutter/flutter/pull/103475
* docs: update Cubic constructor doc. by @daniloapr in https://github.com/flutter/flutter/pull/103555
* Add blank line after first sentence of doc comment for `CheckedModeBanner` by @nilsreichardt in https://github.com/flutter/flutter/pull/103490
* Fix avoid_redundant_argument_values analyzer warnings enabled in the latest Dart SDK by @jason-simmons in https://github.com/flutter/flutter/pull/103734
* Make _RenderCustomClip respect clipBehavior by @dnfield in https://github.com/flutter/flutter/pull/103748
* Implement paintsChild on RenderObjects that skip painting on their children by @dnfield in https://github.com/flutter/flutter/pull/103768
* [web] do not swallow WebDriver errors by @yjbanov in https://github.com/flutter/flutter/pull/103754
* add noSuchMethod to _MulticastCanvas to unblock smoke testing against forthcoming new getTransform/Clip methods by @flar in https://github.com/flutter/flutter/pull/103737
* Add VoidCallbackAction and VoidCallbackIntent by @gspencergoog in https://github.com/flutter/flutter/pull/103518
* Add a mechanism to observe layer tree composition. by @dnfield in https://github.com/flutter/flutter/pull/103378
* More missing clipBehavior respects by @dnfield in https://github.com/flutter/flutter/pull/103931
* Final chapter: migrate api doc samples to super-parameters by @goderbauer in https://github.com/flutter/flutter/pull/104007
* Reorder Theme fields and arguments to be consistently alphabetical within sections. by @gspencergoog in https://github.com/flutter/flutter/pull/104011
* Revert "Fix Backbutton is not displayed when there is a endDrawer" by @CaseyHillers in https://github.com/flutter/flutter/pull/104039
* `AppBar`: Fix nested scroll view doesn't update `AppBar` elevation for Material 3 by @TahaTesser in https://github.com/flutter/flutter/pull/103899
* switched to a double variant of clamp to avoid boxing by @gaaclarke in https://github.com/flutter/flutter/pull/103559
* Some MacOS control key shortcuts by @justinmc in https://github.com/flutter/flutter/pull/103936
* Fix documentation for filterQuality fields by @bleroux in https://github.com/flutter/flutter/pull/104056
* Can't drag the cursor with the mouse by @justinmc in https://github.com/flutter/flutter/pull/103002
* Fix right clicking a field to focus by @justinmc in https://github.com/flutter/flutter/pull/103228
* Add Tooltip default vertical padding by @bleroux in https://github.com/flutter/flutter/pull/103395
* Stop recommending "shrinkWrap" by @dnfield in https://github.com/flutter/flutter/pull/104008
* [Scrollbar]Skip the ScrollPosition check if the bar was unmounted by @xu-baolin in https://github.com/flutter/flutter/pull/103948
* Add Material 3  `AppBar` example by @TahaTesser in https://github.com/flutter/flutter/pull/102823
* Add StrokeAlign to Border by @bernaferrari in https://github.com/flutter/flutter/pull/102112
* Define `ColorSwatch.lerp()` function by @davidmigloz in https://github.com/flutter/flutter/pull/103701
* Add const `MaterialStatePropertyAll` class. by @darrenaustin in https://github.com/flutter/flutter/pull/104127
* Add ShortcutsRegistry by @gspencergoog in https://github.com/flutter/flutter/pull/103456
* [framework] inline AbstractNode into RenderObject by @jonahwilliams in https://github.com/flutter/flutter/pull/103832
* Revert "Fix `DropdownButton` menu clip" by @Piinks in https://github.com/flutter/flutter/pull/104203
* Add ability for `ModalRoutes` to ignore pointers during transitions and do so on `Cupertino` routes by @willlockwood in https://github.com/flutter/flutter/pull/95757
* [Mouse] Remove all pointers at the end of tests by @dkwingsmt in https://github.com/flutter/flutter/pull/102694
* Desktop platforms should not collapse selection on copy by @Renzo-Olivares in https://github.com/flutter/flutter/pull/104209
* `CupertinoColors`: Add diagrams by @TahaTesser in https://github.com/flutter/flutter/pull/103280
* Add Tooltip onTriggered callback by @bleroux in https://github.com/flutter/flutter/pull/104237
* Fix tooltips don't dismiss when using TooltipTriggerMode.tap by @bleroux in https://github.com/flutter/flutter/pull/103960
* Revert "[framework] inline AbstractNode into RenderObject" by @CaseyHillers in https://github.com/flutter/flutter/pull/104257
* Add support for Material 3 medium and large top app bars. by @darrenaustin in https://github.com/flutter/flutter/pull/103962
* Do not assert callbacks contains key if disposed by @dnfield in https://github.com/flutter/flutter/pull/104292
* Mention that `NavigationBar` is a new widget by @guidezpl in https://github.com/flutter/flutter/pull/104264
* [Keyboard, Windows] Fix that IME events are still dispatched to FocusNode.onKey by @dkwingsmt in https://github.com/flutter/flutter/pull/104244
* Sped up Element._sort by @gaaclarke in https://github.com/flutter/flutter/pull/104103
* Started sharing SemanticsProperties between the Widget and the RenderObject by @gaaclarke in https://github.com/flutter/flutter/pull/104281
* Add Focus support for iOS platform view by @hellohuanlin in https://github.com/flutter/flutter/pull/103019
* Fix ColorScheme.copyWith for surfaceTint by @darrenaustin in https://github.com/flutter/flutter/pull/104435
* Fix `BottomAppBar` dip without FAB by @TahaTesser in https://github.com/flutter/flutter/pull/104490
* `RefreshIndicator`: Add `notificationPredicate` example by @TahaTesser in https://github.com/flutter/flutter/pull/103894
* [flutter roll] Revert "Add ability for `ModalRoutes` to ignore pointers during trans… by @XilaiZhang in https://github.com/flutter/flutter/pull/104520
* Remove `RenderObject.rotate` by @LongCatIsLooong in https://github.com/flutter/flutter/pull/103092
* Reland "Fix Backbutton is not displayed when there is a endDrawer (#1… by @chunhtai in https://github.com/flutter/flutter/pull/104110
* Supports global selection for all devices by @chunhtai in https://github.com/flutter/flutter/pull/95226
* Add an example and update `GestureDetector` documentation by @bleroux in https://github.com/flutter/flutter/pull/102360
* Fix an issue that clearing the image cache may cause resource leaks by @Yeatse in https://github.com/flutter/flutter/pull/104527
* [framework] ensure ink sparkle is disposed by @jonahwilliams in https://github.com/flutter/flutter/pull/104569
* `Switch`: Add an interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/103045
* Use `curly_braces_in_flow_control_structures` for `material` by @guidezpl in https://github.com/flutter/flutter/pull/104499
* [reland] Migrate `ListTile` TextTheme TextStyle references to Material 3 by @TahaTesser in https://github.com/flutter/flutter/pull/102167
* A bunch of cleanups and a missing `ShortcutRegistar` in `WidgetsApp` by @gspencergoog in https://github.com/flutter/flutter/pull/104560
* Remove unused code from tests by @goderbauer in https://github.com/flutter/flutter/pull/104550
* Removing Shorcuts.of and Shortctus.maybeOf by @gspencergoog in https://github.com/flutter/flutter/pull/104215
* Cleanup random dead test code by @goderbauer in https://github.com/flutter/flutter/pull/104568
* Use `curly_braces_in_flow_control_structures` for `foundation`, `gestures`, `painting`, `physics` by @guidezpl in https://github.com/flutter/flutter/pull/104610
* Use `curly_braces_in_flow_control_structures` for `animations`, `cupertino` by @guidezpl in https://github.com/flutter/flutter/pull/104612
* Use `curly_braces_in_flow_control_structures` for `rendering` by @guidezpl in https://github.com/flutter/flutter/pull/104611
* Use `curly_braces_in_flow_control_structures` for `services`, `scheduler`, `semantics` by @guidezpl in https://github.com/flutter/flutter/pull/104616
* Use `curly_braces_in_flow_control_structures` for non-`flutter` packages by @guidezpl in https://github.com/flutter/flutter/pull/104629
* Dispose ValueNotifier instances in LicensePage state classes by @tgucio in https://github.com/flutter/flutter/pull/104589
* [Slider]The initial value of discrete slider should respect the discrete values by @xu-baolin in https://github.com/flutter/flutter/pull/103966
* Hide the text selection toolbar on mobile when orientation changes by @markusaksli-nc in https://github.com/flutter/flutter/pull/103512
* Dispose ValueNotifier in EditableTextState by @tgucio in https://github.com/flutter/flutter/pull/104590
* Dispose ValueNotifier instances in RenderEditable by @tgucio in https://github.com/flutter/flutter/pull/104591
* Include forceElevated for scrolledUnder in new SliverAppBar variants by @Piinks in https://github.com/flutter/flutter/pull/104536
* Improve PlatformMenu `MenuItem` documentation by @ueman in https://github.com/flutter/flutter/pull/104321
* fix a _DraggableScrollableSheetScrollPosition update bug by @xu-baolin in https://github.com/flutter/flutter/pull/103328
* PlatformMenuBar changes to bring it into line with upcoming MenuBar implementation by @gspencergoog in https://github.com/flutter/flutter/pull/104565
* [Reland]: Fix `DropdownButton` menu clip by @TahaTesser in https://github.com/flutter/flutter/pull/104251
* Added option for Platform Channel statistics and Timeline events by @gaaclarke in https://github.com/flutter/flutter/pull/104531
* Update links to `material` library docs by @guidezpl in https://github.com/flutter/flutter/pull/104392
* Use `curly_braces_in_flow_control_structures` for `widgets` by @guidezpl in https://github.com/flutter/flutter/pull/104609
* Fix typo "technicallv" in `editable_text.dart` by @nilsreichardt in https://github.com/flutter/flutter/pull/104701
* Add error message and documentation when a `SnackBar` is off screen by @bleroux in https://github.com/flutter/flutter/pull/102073
* Quick grammar fix in the PipelineOwner docs by @justinmc in https://github.com/flutter/flutter/pull/104730
* Remove extraneous InheritedWidget by @gspencergoog in https://github.com/flutter/flutter/pull/104676
* SelectableRegion does not merge child semantics nodes by @chunhtai in https://github.com/flutter/flutter/pull/104659
* Added MaterialStatesController, updated InkWell et al. by @HansMuller in https://github.com/flutter/flutter/pull/103167
* Fixes a bug when dragging selection handle sends events in wrong coor… by @chunhtai in https://github.com/flutter/flutter/pull/104739
* Right click on selection when unfocused should re-focus by @justinmc in https://github.com/flutter/flutter/pull/104666
* Update `material_color_utilities` dependency to 0.1.5. by @darrenaustin in https://github.com/flutter/flutter/pull/104771
* Revert "Add error message and documentation when a `SnackBar` is off screen" by @Piinks in https://github.com/flutter/flutter/pull/104843
* use immutable buffer for loading asset images by @jonahwilliams in https://github.com/flutter/flutter/pull/103496
* Hide `SelectableRegion` text selection toolbar when orientation changes by @markusaksli-nc in https://github.com/flutter/flutter/pull/104841
* fix: assert does not match annotation by @justforlxz in https://github.com/flutter/flutter/pull/104606
* MacOS transpose keyboard shortcut by @justinmc in https://github.com/flutter/flutter/pull/104457
* Add troubleshooting doc for MediaQueryData.size by @bleroux in https://github.com/flutter/flutter/pull/104828
* `InheritedModel`: Add a complete interactive example and update snippet for null safety by @TahaTesser in https://github.com/flutter/flutter/pull/104174
* Improve `PlatformException#stacktrace` docs for Android by @ueman in https://github.com/flutter/flutter/pull/104331
* Switch debugAssertNotDisposed to be a static by @gspencergoog in https://github.com/flutter/flutter/pull/104772
* more const immutable classes by @a14n in https://github.com/flutter/flutter/pull/104988
* Fix `showSearch` query text field doesn't show toolbar initially when field is empty. by @TahaTesser in https://github.com/flutter/flutter/pull/105023
* Remove remaining uses of hashValues in the framework by @jason-simmons in https://github.com/flutter/flutter/pull/105046
* Fix actions padding for M3 alert dialogs by @guidezpl in https://github.com/flutter/flutter/pull/105008
* Add `actionsPadding` to dialog theme by @guidezpl in https://github.com/flutter/flutter/pull/105109
* Revert "Added MaterialStatesController, updated InkWell et al." by @HansMuller in https://github.com/flutter/flutter/pull/105138
* Turn on `curly_braces_in_flow_control_structures` for developer-facing code by @guidezpl in https://github.com/flutter/flutter/pull/105113
* Hide text selection toolbar when dragging handles on mobile by @markusaksli-nc in https://github.com/flutter/flutter/pull/104274
* Revert "Hide text selection toolbar when dragging handles on mobile" by @zanderso in https://github.com/flutter/flutter/pull/105247
* Refactor `MaterialStateProperty` lerp functions by @TahaTesser in https://github.com/flutter/flutter/pull/104507
* Merge dirty relayout boundaries after `RenderObject.invokeLayoutCallback` by @LongCatIsLooong in https://github.com/flutter/flutter/pull/105175
* Update documentation for app bar theme properties by @zeshuaro in https://github.com/flutter/flutter/pull/102501
* `CheckedPopupMenuItem`: Fix cursor bug and add cursor parameter by @TahaTesser in https://github.com/flutter/flutter/pull/103474
* Revert "Add `actionsPadding` to dialog theme" by @guidezpl in https://github.com/flutter/flutter/pull/105293
* fix: Removed helper method from Scaffold by @albertodev01 in https://github.com/flutter/flutter/pull/99714
* [DataTable]: Add ability to only select row using checkbox by @TahaTesser in https://github.com/flutter/flutter/pull/105123
* Revert "[DataTable]: Add ability to only select row using checkbox (#105123)" by @TahaTesser in https://github.com/flutter/flutter/pull/105311
* Remove `RenderAligningShiftedBox.mixin` (no longer needed) by @TahaTesser in https://github.com/flutter/flutter/pull/105177
* Sort diagnostics node dependencies so that order is stable by @kenzieschmoll in https://github.com/flutter/flutter/pull/105319
* remove forced compositing from opacity by @jonahwilliams in https://github.com/flutter/flutter/pull/105334
* Do not crash if the controller and TabBarView are updated at different phases (build and layout) of the same frame. by @xu-baolin in https://github.com/flutter/flutter/pull/104998
* [Stepper] Add Alternative Label on horizontal-type Stepper by @KKimj in https://github.com/flutter/flutter/pull/91496
* Remove `new` keyword in a few files by @nilsreichardt in https://github.com/flutter/flutter/pull/104438
* [framework] respect debugDisableShadows in slider thumbs by @jonahwilliams in https://github.com/flutter/flutter/pull/105467
* Revert "remove forced compositing from opacity" by @zanderso in https://github.com/flutter/flutter/pull/105489
* Fix `ButtonStyleButton`  `InkWell` shape by @TahaTesser in https://github.com/flutter/flutter/pull/100226
* Text selection located wrong position when selecting multiple lines over max lines by @takassh in https://github.com/flutter/flutter/pull/102747
* Fix drawers are draggable on desktop platforms by @TahaTesser in https://github.com/flutter/flutter/pull/100476
* Migrate `IconButton` to Material 3 - Part 1 by @QuncCccccc in https://github.com/flutter/flutter/pull/105176
* Improve the `SliverChildBuilderDelegate` docs for folk to troubleshoot. by @xu-baolin in https://github.com/flutter/flutter/pull/103183
* fix a _ScaffoldLayout delegate update bug by @xu-baolin in https://github.com/flutter/flutter/pull/104954
* Updated tokens to v0.99. by @darrenaustin in https://github.com/flutter/flutter/pull/105545
* Improve `useMaterial3` documentation by @guidezpl in https://github.com/flutter/flutter/pull/104815
* `CupertinoSlider`: Add clickable cursor for web by @TahaTesser in https://github.com/flutter/flutter/pull/99557
* TimePicker : Ability to define dialOnly / inputOnly modes by @LempereurBenjamin in https://github.com/flutter/flutter/pull/104491
* add some exports of public API in foundation/serialization.dart by @a14n in https://github.com/flutter/flutter/pull/104231
* Fix PageView throws Null check error by @bleroux in https://github.com/flutter/flutter/pull/104405
* Fix `SliverReorderableList` item dispose by @TahaTesser in https://github.com/flutter/flutter/pull/105097
* Fix BoxShadow toString() by @bleroux in https://github.com/flutter/flutter/pull/105696
* Export public API types from foundation/*.dart library. by @a14n in https://github.com/flutter/flutter/pull/105648
* Updating PrimaryScrollController for Desktop by @Piinks in https://github.com/flutter/flutter/pull/102099
* exports public API types from scheduler/*.dart by @a14n in https://github.com/flutter/flutter/pull/105737
* Reland: Added MaterialStatesController, updated InkWell et al. #103167 by @HansMuller in https://github.com/flutter/flutter/pull/105656
* Text handle drag swap on Apple platforms by @justinmc in https://github.com/flutter/flutter/pull/105069
* Remove duplicated key in _IconButtonM3 by @cedvdb in https://github.com/flutter/flutter/pull/105577
* Add enabled property to CheckboxlistTile  by @maheshmnj in https://github.com/flutter/flutter/pull/102314
* Fixed issue with Hero Animations and BoxScrollViews in Scaffolds by @youssef-attia in https://github.com/flutter/flutter/pull/105654
* Added useMaterial3 parameters to the light, dark and fallback ThemeData constructors. by @darrenaustin in https://github.com/flutter/flutter/pull/105944
* Reland "Add actionsPadding to Dialog theme" by @guidezpl in https://github.com/flutter/flutter/pull/105588
* TextInput: Verify TextRange and make method call fail loudly by @dkwingsmt in https://github.com/flutter/flutter/pull/104711
* Updated tokens to v0.101. by @darrenaustin in https://github.com/flutter/flutter/pull/105923
* Allow DoNothingIntent and DoNothingAndStopPropagationIntent to be used in a const environment by @dkwingsmt in https://github.com/flutter/flutter/pull/105983
* Make RenderSliverGrid more accurately report overflow by @dnfield in https://github.com/flutter/flutter/pull/104064
* Fix confusing typo: extent vs. extend selection by @jpnurmi in https://github.com/flutter/flutter/pull/106002
* fix a Scaffold extendBodyBehindAppBar update bug by @xu-baolin in https://github.com/flutter/flutter/pull/104958
* TextFormField docs: added proper type with GlobalKey; replaced "we" by @EnduringBeta in https://github.com/flutter/flutter/pull/105605
* [framework] fix RangeSlider regression due to touch slop changes by @xu-baolin in https://github.com/flutter/flutter/pull/106094
* Revert "Make RenderSliverGrid more accurately report overflow" by @dnfield in https://github.com/flutter/flutter/pull/106123
* Fix SliverPadding geometry  by @Piinks in https://github.com/flutter/flutter/pull/106071
* Ignore uses of soon-to-be deprecated `NullThrownError`. by @lrhn in https://github.com/flutter/flutter/pull/105693
* Fix `StretchingOverscrollIndicator` clipping and add `clipBehavior` parameter by @TahaTesser in https://github.com/flutter/flutter/pull/105303
* [gen_keycodes] Remove invalid Web code maps by @dkwingsmt in https://github.com/flutter/flutter/pull/106074
* Ignore body_might_complete_normally_catch_error violations by @srawlins in https://github.com/flutter/flutter/pull/105795
* Fix debugPaintSize throws 'Null Check error' by @bleroux in https://github.com/flutter/flutter/pull/106108
* Revert "Fix `StretchingOverscrollIndicator` clipping and add `clipBehavior` parameter" by @Piinks in https://github.com/flutter/flutter/pull/106207
* Export public API types from gestures/*.dart library by @a14n in https://github.com/flutter/flutter/pull/105864
* feat: add icon to AlertDialog by @werainkhatri in https://github.com/flutter/flutter/pull/104920
* [docs] fix typos in page_transitions_theme.dart and tooltip.dart by @albinpk in https://github.com/flutter/flutter/pull/106264
* [framework] remove opacity layer at fully opaque by @jonahwilliams in https://github.com/flutter/flutter/pull/106351
* [Keyboard, Web] Map from "Esc" to the Escape key by @dkwingsmt in https://github.com/flutter/flutter/pull/106133
* Update parameters to the `styleFrom` button methods. by @darrenaustin in https://github.com/flutter/flutter/pull/105291
* Fix TooltipState null check error by @bleroux in https://github.com/flutter/flutter/pull/106330
* Chip theme cleanup by @darrenaustin in https://github.com/flutter/flutter/pull/106384
* Expose smart punctuation options on CupertinoSearchTextField by @moffatman in https://github.com/flutter/flutter/pull/97980
* Revert "fix a Scaffold extendBodyBehindAppBar update bug" by @xu-baolin in https://github.com/flutter/flutter/pull/106396
* Disable cursor opacity animation on macOS, make iOS cursor animation discrete by @LongCatIsLooong in https://github.com/flutter/flutter/pull/104335
* Add "excluding" optional parameter to TargetPlatformVariant to communicate cases where test should be ran everywhere but specific platforms by @antholeole in https://github.com/flutter/flutter/pull/106216
* Mark use of deprecated type. by @lrhn in https://github.com/flutter/flutter/pull/106282
* [platform_view]Send platform message when platform view is focused by @hellohuanlin in https://github.com/flutter/flutter/pull/105050
* Add toggled semantics to `ToggleButtons` by @guidezpl in https://github.com/flutter/flutter/pull/106096
* docs: Add more potential use case for Bottom Navigation Bar by @amanv8060 in https://github.com/flutter/flutter/pull/99644
* Apply PrimaryScrollController updates to SingleChildScrollView by @Piinks in https://github.com/flutter/flutter/pull/106430
* Fix typo in flutter_test binding.dart by @bryanoltman in https://github.com/flutter/flutter/pull/106505
* Export public API types from foundation/scheduler/gestures/semantics by @a14n in https://github.com/flutter/flutter/pull/106409
* Fix BidirectionalIterator deprecation warning and roll engine to a1dd50405992 by @bdero in https://github.com/flutter/flutter/pull/106595
* Fix typo in compute documentation: "captures" -> "capture" by @hacker1024 in https://github.com/flutter/flutter/pull/106624
* Export SpellOutStringAttribute and LocaleStringAttribute by @Hixie in https://github.com/flutter/flutter/pull/106682
* Implement frameData for TestWindow by @dnfield in https://github.com/flutter/flutter/pull/105537
* Make TextInputClient a mixin by @justinmc in https://github.com/flutter/flutter/pull/104291
* Export public API types from services/*.dart library by @a14n in https://github.com/flutter/flutter/pull/106316
* Consistently capitalize Endpoint (not EndPoint) by @justinmc in https://github.com/flutter/flutter/pull/106706
* Revert "Disable cursor opacity animation on macOS, make iOS cursor animation discrete (#104335)" by @LongCatIsLooong in https://github.com/flutter/flutter/pull/106762
* Export public API types from animation and physics libraries by @a14n in https://github.com/flutter/flutter/pull/106757
* Add Scaffold drawers escape dismiss action. by @TahaTesser in https://github.com/flutter/flutter/pull/106186
* Reland  "Clipping if only one character text overflows" by @xu-baolin in https://github.com/flutter/flutter/pull/102130
* Set selection on tap down for desktop platforms and tap up for mobile by @Renzo-Olivares in https://github.com/flutter/flutter/pull/105505
* [gen_keycodes] Mark generated file names with infix `.g.` by @dkwingsmt in https://github.com/flutter/flutter/pull/106142
* Reland "fix a Scaffold extendBodyBehindAppBar update bug" by @xu-baolin in https://github.com/flutter/flutter/pull/106534
* Fix `DropdownButton` Inkwell border radius by @TahaTesser in https://github.com/flutter/flutter/pull/106657
* [Reland]: Fix `StretchingOverscrollIndicator` clipping and add `clipBehavior` parameter by @TahaTesser in https://github.com/flutter/flutter/pull/106287
* Documentation update to advertize timedDrag by @bleroux in https://github.com/flutter/flutter/pull/106489
* Reland "fix a Scaffold.bottomSheet update bug" by @xu-baolin in https://github.com/flutter/flutter/pull/106775
* Fix DraggableScrollableSheet crash when switching out scrollables by @Piinks in https://github.com/flutter/flutter/pull/105549
* Improve SnackBar error message when shown during build by @bleroux in https://github.com/flutter/flutter/pull/106658
* Fix scrollbar track offset by @Piinks in https://github.com/flutter/flutter/pull/106835
* Animated fractionally sized box by @Hari-07 in https://github.com/flutter/flutter/pull/106795
* [flutter roll] Revert "Reland "Clipping if only one character text overflows (#99146… by @XilaiZhang in https://github.com/flutter/flutter/pull/106964
* Add error messages to `_debugCanPerformMutations` by @LongCatIsLooong in https://github.com/flutter/flutter/pull/105638
* [framework] partial removal of forced compositing from opacity by @jonahwilliams in https://github.com/flutter/flutter/pull/106989
* [g3 roll] revert #105537 Implement frameData for TestWindow by @XilaiZhang in https://github.com/flutter/flutter/pull/107168
* Migrate `IconButton` to Material 3 - Part 2 by @QuncCccccc in https://github.com/flutter/flutter/pull/106437
* `SelectableText.rich`: Fix `TextSpan.style` not merged into default text style by @TahaTesser in https://github.com/flutter/flutter/pull/101911
* Migrate Chips to Material 3 by @darrenaustin in https://github.com/flutter/flutter/pull/107166
* Add documentation references to BottomSheetThemeData by @bleroux in https://github.com/flutter/flutter/pull/107149
* Fix typo in painting.TextStyle.merge docs by @Goddchen in https://github.com/flutter/flutter/pull/106511
* Clarify that inputFormatters don't run on programmatical changes by @LongCatIsLooong in https://github.com/flutter/flutter/pull/106904
* Fix disallowIndicator for RefreshIndicator by @Piinks in https://github.com/flutter/flutter/pull/106831
* Fix RawScrollbar colors by @Piinks in https://github.com/flutter/flutter/pull/107177
* Add `RelativeRect.fromDirectional` factory by @kseino in https://github.com/flutter/flutter/pull/107059
* `ui.PointerSignalKind` forwards-compatibility by @moffatman in https://github.com/flutter/flutter/pull/106906
* Improve pub root directory interface by @CoderDake in https://github.com/flutter/flutter/pull/106567
* [framework] don't composite with a scale of 0.0 by @jonahwilliams in https://github.com/flutter/flutter/pull/106982
* Fixed AnimatedSwitcher chain produced duplicates by @youssef-attia in https://github.com/flutter/flutter/pull/106962
* Remove listeners from pending images when clearing cache by @dnfield in https://github.com/flutter/flutter/pull/107276
* `InputDecorator`: Switch hint to Opacity instead of AnimatedOpacity by @markusaksli-nc in https://github.com/flutter/flutter/pull/107156
* Fix `ListTile` theme shape in a drawer by @TahaTesser in https://github.com/flutter/flutter/pull/106343
* Revert "Fixed AnimatedSwitcher chain produced duplicates" to investigate issue with g3 by @youssef-attia in https://github.com/flutter/flutter/pull/107318
* Add new widget of the week videos by @guidezpl in https://github.com/flutter/flutter/pull/107301
* Reland  "Disable cursor opacity animation on macOS, make iOS cursor animation discrete (#104335)" by @LongCatIsLooong in https://github.com/flutter/flutter/pull/106893
* Fix showDialog throws cryptic message when context is not active by @bleroux in https://github.com/flutter/flutter/pull/107323
* Reland"Make RenderSliverGrid more accurately report overflow" by @dnfield in https://github.com/flutter/flutter/pull/107329
* Refactor gen_defaults to support multiple generated code blocks in the same file independently. by @darrenaustin in https://github.com/flutter/flutter/pull/107278
* Fix TabController throws build scheduled during frame error by @bleroux in https://github.com/flutter/flutter/pull/105442
* Revert "`InputDecorator`: Switch hint to Opacity instead of AnimatedOpacity" by @CaseyHillers in https://github.com/flutter/flutter/pull/107406
* [flutter_releases] Flutter beta 3.3.0-0.2.pre Framework Cherrypicks by @godofredoc in https://github.com/flutter/flutter/pull/108831
* CP: Fix Android platform view creation flow by @stuartmorgan in https://github.com/flutter/flutter/pull/109544
* fix flutter not finding custom device (#108884) by @zanderso in https://github.com/flutter/flutter/pull/109957
### Tooling
* Run CADisableMinimumFrameDurationOnPhone migration on all example apps by @jmagman in https://github.com/flutter/flutter/pull/101314
* Catch errors in ProxiedDevice to make sure we don't crash on errors. by @chingjun in https://github.com/flutter/flutter/pull/101332
* Use single quotes for `dartSdkVersionBounds` by @creativecreatorormaybenot in https://github.com/flutter/flutter/pull/101270
* Partial revert of super params in tools by @goderbauer in https://github.com/flutter/flutter/pull/101436
* Add --use-application-binary to "flutter install" by @jmagman in https://github.com/flutter/flutter/pull/101324
* [Cherrypick] Partial revert of super params in tools (#101436) by @CaseyHillers in https://github.com/flutter/flutter/pull/101451
* Specify Kotlin version in modules and refactor by @blasten in https://github.com/flutter/flutter/pull/101315
* Remove --enable-web and --enable-windows-desktop from tests by @jmagman in https://github.com/flutter/flutter/pull/101208
* [flutter_tools] fix flutter create --offline by @Jasguerrero in https://github.com/flutter/flutter/pull/100941
* Run update-packages by @annagrin in https://github.com/flutter/flutter/pull/101450
* Test Flutter.xcframework directory ios-arm64_armv7 or ios-arm64 by @jmagman in https://github.com/flutter/flutter/pull/101592
* Log XCResult before other build issues by @cyanglaz in https://github.com/flutter/flutter/pull/100787
* [flutter_tools] Add --build-number and --build-name support to web and linux by @JankoLancer in https://github.com/flutter/flutter/pull/100377
* Add more debugging info to android_plugin_example_app_build_test by @dcharkes in https://github.com/flutter/flutter/pull/101685
* Create when offline style  by @Jasguerrero in https://github.com/flutter/flutter/pull/101589
* Pass multidex flag when using --machine mode by @DanTup in https://github.com/flutter/flutter/pull/101689
* Unpause and remove breakpoints when detaching from Flutter process with DAP by @DanTup in https://github.com/flutter/flutter/pull/101695
* Enable track widget creation when generating Generated.xcconfig by @Yeatse in https://github.com/flutter/flutter/pull/101123
* [flutter_tools] add test for dart binary arch by @christopherfujino in https://github.com/flutter/flutter/pull/101604
* [flutter.js] Wait for reg.update, then activate sw (if not active yet). by @ditman in https://github.com/flutter/flutter/pull/101464
* Remove the run_loop.h and run_loop.cpp files from template_manifest.json by @linxuebin1990 in https://github.com/flutter/flutter/pull/100976
* Add Gradle stacktrace and debug log level to verbose builds by @blasten in https://github.com/flutter/flutter/pull/101734
* [flutter_tools] Dump backtrace on ios app startup timeout by @christopherfujino in https://github.com/flutter/flutter/pull/101610
* Revert "[flutter_tools] Dump backtrace on ios app startup timeout" by @christopherfujino in https://github.com/flutter/flutter/pull/101761
* [flutter_tools] Re-land Dump backtrace on ios app startup timeout by @christopherfujino in https://github.com/flutter/flutter/pull/101763
* Disallow `flutter run`-ing on 32-bit development devices by @jmagman in https://github.com/flutter/flutter/pull/97339
* Do not build for iOS armv7 by @jmagman in https://github.com/flutter/flutter/pull/97341
* Add `flutter build ipa --no-codesign` flag by @jmagman in https://github.com/flutter/flutter/pull/101766
* Use the maven-publish plugin to publish AAR files. by @AesSedai101 in https://github.com/flutter/flutter/pull/101276
* Revert "Use the maven-publish plugin to publish AAR files." by @zanderso in https://github.com/flutter/flutter/pull/101827
* [flutter_tools] shard out two integration tests we want to run on macOS arm64 by @christopherfujino in https://github.com/flutter/flutter/pull/101769
* [web] remove timeout when waiting for browser to launch by @yjbanov in https://github.com/flutter/flutter/pull/101843
* Default to the newer version path when checking Android Studio Java path by @chingjun in https://github.com/flutter/flutter/pull/101862
* Migrate remaining files to super parameters by @goderbauer in https://github.com/flutter/flutter/pull/101919
* Use super parameters in templates by @goderbauer in https://github.com/flutter/flutter/pull/101157
* Add VMService command to get frame rasterization metrics by @iskakaushik in https://github.com/flutter/flutter/pull/100696
* ignore `prefer_final_parameters` in `generated_plugin_registrant` template by @DetachHead in https://github.com/flutter/flutter/pull/101253
* Detect ARM ffi CocoaPods bus error by @jmagman in https://github.com/flutter/flutter/pull/101796
* [flutter_tools] Remove usage of globals.flutterGit from version by @RoyARG02 in https://github.com/flutter/flutter/pull/100744
* Exclude armv7 from iOS add-to-app plugins by @jmagman in https://github.com/flutter/flutter/pull/101943
* Provide a flag for controlling the dart2js optimization level when building for web targets by @jason-simmons in https://github.com/flutter/flutter/pull/101945
* Remove trailing spaces in repo by @guidezpl in https://github.com/flutter/flutter/pull/101191
* Set template and migrate apps to iOS 11 minimum by @jmagman in https://github.com/flutter/flutter/pull/101963
* Hide default bundle id error when xcresult detects an error by @cyanglaz in https://github.com/flutter/flutter/pull/101993
* [flutter_tools] explicitly enable macos-desktop in macos_content_validation_test.dart by @christopherfujino in https://github.com/flutter/flutter/pull/102009
* Use the maven-publish plugin to publish AAR files. by @AesSedai101 in https://github.com/flutter/flutter/pull/101891
* Handle CocoaPods ffi stderr by @jmagman in https://github.com/flutter/flutter/pull/102327
* Enable jank metric collection in profile mode by @iskakaushik in https://github.com/flutter/flutter/pull/102334
* Hide unresolved DartUri log messages by @elliette in https://github.com/flutter/flutter/pull/102338
* [flutter_tools] Add test that "Unresolve URI" warnings from DWDS are filtered from logs by @christopherfujino in https://github.com/flutter/flutter/pull/102399
* [gen_l10n] Throw a specified exception when the language code is invalid by @AlexV525 in https://github.com/flutter/flutter/pull/102431
* Reduce Gradle log level in verbose output by @blasten in https://github.com/flutter/flutter/pull/102422
* [flutter_tools] remove UWP tooling by @jonahwilliams in https://github.com/flutter/flutter/pull/102174
* [flutter_tools] Add entries to HostArtifacts for impellerc, libtessellator by @zanderso in https://github.com/flutter/flutter/pull/102593
* [flutter_tools] rename local functions with `_`s by @pq in https://github.com/flutter/flutter/pull/102688
* fix `unnecessary_null_checks` by @pq in https://github.com/flutter/flutter/pull/102705
* Update features.dart by @timsneath in https://github.com/flutter/flutter/pull/102766
* [flutter_tool] New command project by @Jasguerrero in https://github.com/flutter/flutter/pull/102118
* Embed Flutter and App frameworks for add-to-app on iOS by @jmagman in https://github.com/flutter/flutter/pull/102538
* [flutter_tools] update feature defaults by @christopherfujino in https://github.com/flutter/flutter/pull/102937
* Update ffi gem installation instructions by @jmagman in https://github.com/flutter/flutter/pull/103008
* Remove unused flutterMacOSPodspec artifact by @jmagman in https://github.com/flutter/flutter/pull/103088
* Add debug logging to deferred components test for deflaking by @GaryQian in https://github.com/flutter/flutter/pull/103161
* Remove custom `unawaited`, prefer `dart:async` version by @jmagman in https://github.com/flutter/flutter/pull/103212
* [flutter_tools] add --uninstall-first flag and pipe it through to ios-deploy by @christopherfujino in https://github.com/flutter/flutter/pull/102948
* Use consistent date instead of DateTime.now() in evaluation tests to avoid flakes by @DanTup in https://github.com/flutter/flutter/pull/103269
* [flutter_tools] stringArg refactor by @Jasguerrero in https://github.com/flutter/flutter/pull/103231
* MigrateUtils and MigrateManifest classes by @GaryQian in https://github.com/flutter/flutter/pull/101937
* [flutter_tools] boolArg refactor by @amanv8060 in https://github.com/flutter/flutter/pull/102088
* [flutter_tools] pub roll by @christopherfujino in https://github.com/flutter/flutter/pull/103220
* Provide flutter sdk kernel files to dwds launcher instead of dart ones by @annagrin in https://github.com/flutter/flutter/pull/103436
* Add tests for migrate command methods by @GaryQian in https://github.com/flutter/flutter/pull/103466
* tools web Make Plugin Registrant file ephemeral. by @ditman in https://github.com/flutter/flutter/pull/102185
* [gen_l10n] Better blank lines in the header of generated files by @AlexV525 in https://github.com/flutter/flutter/pull/103414
* [flutter_tools] migrate some integration tests to null safety by @jonahwilliams in https://github.com/flutter/flutter/pull/103560
* Enforce minimum plugin version iOS 11 by @jmagman in https://github.com/flutter/flutter/pull/103545
* [flutter_tools] remove assertion for deprecation .packages by @jonahwilliams in https://github.com/flutter/flutter/pull/103729
* [flutter_tools] ensure linux doctor validator finishes when pkg-config is not installed by @christopherfujino in https://github.com/flutter/flutter/pull/103755
* Fix deprecation doc comment by @cbracken in https://github.com/flutter/flutter/pull/103776
* [tool] Fix BuildInfo.packagesPath doc comment by @cbracken in https://github.com/flutter/flutter/pull/103785
* [flutter_tools] fix test asset loading by @jonahwilliams in https://github.com/flutter/flutter/pull/103667
* [flutter_tools] fix missing cmake by @christopherfujino in https://github.com/flutter/flutter/pull/103761
* Roll dependendencies by @cbracken in https://github.com/flutter/flutter/pull/103771
* [macOS] Update template icons to Big Sur style by @cbracken in https://github.com/flutter/flutter/pull/103739
* Up CocoaPods minumum to 1.10 by @jmagman in https://github.com/flutter/flutter/pull/103655
* [tool] Consistent FakeProcessManager.run/runSync by @cbracken in https://github.com/flutter/flutter/pull/103947
* Add ability for PrebuiltWindowsApp to accept a zip archive. by @chingjun in https://github.com/flutter/flutter/pull/103918
* [flutter_tools] throw error when argResults is null by @amanv8060 in https://github.com/flutter/flutter/pull/103827
* [flutter_tools] pass --enable-impeller to android by @jonahwilliams in https://github.com/flutter/flutter/pull/104014
* [flutter_tools] fix RangeError in flutter channel command by @christopherfujino in https://github.com/flutter/flutter/pull/103766
* [tool] Add tests for FakeProcess by @cbracken in https://github.com/flutter/flutter/pull/104013
* Handle null values during yaml metadata parsing validation by @jmagman in https://github.com/flutter/flutter/pull/104022
* [flutter_tools] pass --compact-async to frontend_server by @jonahwilliams in https://github.com/flutter/flutter/pull/104026
* Remove extraneous org.jetbrains.kotlin:kotlin-stdlib-jdk7 gradle dep by @GaryQian in https://github.com/flutter/flutter/pull/104028
* Use libraryFilters flag to speed up coverage collection by @liamappelbe in https://github.com/flutter/flutter/pull/104122
* [flutter_tools] Upgrade only from flutter update-packages by @christopherfujino in https://github.com/flutter/flutter/pull/103924
* Show custom error message when Kotlin or Gradle bump is required by @blasten in https://github.com/flutter/flutter/pull/102421
* Pass --verbosity=error to the Dart front-end by @zanderso in https://github.com/flutter/flutter/pull/104020
* Refactor vswhere.exe integration by @loic-sharma in https://github.com/flutter/flutter/pull/104133
* fixes 103234 to enable debugging Flutter apps on VR headset by @csells in https://github.com/flutter/flutter/pull/104135
* continue->next in Ruby script by @jmagman in https://github.com/flutter/flutter/pull/104296
* [tool] Add tests for FakeProcessManager by @cbracken in https://github.com/flutter/flutter/pull/104456
* Ignore replacement characters from vswhere.exe output by @loic-sharma in https://github.com/flutter/flutter/pull/104284
* Fix existing DUPLICATE_IMPORT diagnostics. by @scheglov in https://github.com/flutter/flutter/pull/104533
* [web] [fix] Cache resource data only if the fetching succeed by @dacianf in https://github.com/flutter/flutter/pull/103816
* [flutter_tools] General info project validator by @Jasguerrero in https://github.com/flutter/flutter/pull/103653
* Migrate some test files to null safety by @jmagman in https://github.com/flutter/flutter/pull/104469
* Migrate create command to null safety by @jmagman in https://github.com/flutter/flutter/pull/104484
* Create static plugin frameworks build ios-framework --static by @jmagman in https://github.com/flutter/flutter/pull/104576
* Remove dead code in tools tests by @goderbauer in https://github.com/flutter/flutter/pull/104567
* Fix issues running integration tests through DAP debug adapter by @DanTup in https://github.com/flutter/flutter/pull/104618
* Add link to more detailed multidex information. by @GaryQian in https://github.com/flutter/flutter/pull/104558
* Retry getting tabs in chrome launcher on ConnectionException by @annagrin in https://github.com/flutter/flutter/pull/104218
* Update Windows manifest to declare Windows 11 by @timsneath in https://github.com/flutter/flutter/pull/104768
* tool web Fix flutter.js in Safari 13 by @ditman in https://github.com/flutter/flutter/pull/104761
* Fix plugin_ffi bindings regen command and bump ffigen by @dcharkes in https://github.com/flutter/flutter/pull/104844
* Support string compileSdkVersion for preview android SDKs by @GaryQian in https://github.com/flutter/flutter/pull/104662
* [tool] Migrate off deprecated coverage parameters by @cbracken in https://github.com/flutter/flutter/pull/104997
* Retry builds when SSL exceptions are thrown by @blasten in https://github.com/flutter/flutter/pull/105078
* [flutter_tools] flutter daemon handles a closed stdout IOSink by @christopherfujino in https://github.com/flutter/flutter/pull/105075
* [flutter_tools] handle HandshakeException in httphostvalidator by @christopherfujino in https://github.com/flutter/flutter/pull/105076
* Refactor BuildIOSFrameworkCommand with common darwin baseclass by @jmagman in https://github.com/flutter/flutter/pull/105194
* flutter drive --enable-software-rendering --skia-deterministic-rendering by @jmagman in https://github.com/flutter/flutter/pull/105161
* Remove `package:shelf` version pin by @elliette in https://github.com/flutter/flutter/pull/105261
* Extra timing on hot reload by @jensjoha in https://github.com/flutter/flutter/pull/104242
* Move corrupted zip to a separate handler and ask user by @blasten in https://github.com/flutter/flutter/pull/105054
* Add flutter build macos-framework command by @jmagman in https://github.com/flutter/flutter/pull/105242
* [flutter_tools] add needsFullRestart flag on hot runner by @Jasguerrero in https://github.com/flutter/flutter/pull/104562
* [flutter_tools] re-use findProjectRoot on flutter command by @Jasguerrero in https://github.com/flutter/flutter/pull/104850
* Migrate status by @GaryQian in https://github.com/flutter/flutter/pull/102785
* Pass run and drive --trace-systrace for iOS by @jmagman in https://github.com/flutter/flutter/pull/105321
* [flutter_tools] return terminal to echo and line mode before exiting resident_runner by @christopherfujino in https://github.com/flutter/flutter/pull/105283
* Migrate abandon by @GaryQian in https://github.com/flutter/flutter/pull/102789
* Migrate apply by @GaryQian in https://github.com/flutter/flutter/pull/102787
* Stop using `FallThroughError`. by @lrhn in https://github.com/flutter/flutter/pull/105600
* [flutter_tools] add shuffle to hermetic run_tests by @christopherfujino in https://github.com/flutter/flutter/pull/105462
* Make flutter attach respect the `--dds-port` flag. by @chingjun in https://github.com/flutter/flutter/pull/105560
* Enable skipped test for Dart URI logs from DWDS by @elliette in https://github.com/flutter/flutter/pull/105274
* [flutter_tools] Remove redundant/unused code in version.dart by @RoyARG02 in https://github.com/flutter/flutter/pull/105111
* [flutter_tools] Fix leaky test by @christopherfujino in https://github.com/flutter/flutter/pull/105927
* Remove unneeded date comment in `gradle-wrapper.properties` by @asashour in https://github.com/flutter/flutter/pull/104061
* [flutter_tool] partial null safety migration of tool source code by @jonahwilliams in https://github.com/flutter/flutter/pull/105798
* [flutter_tools] print override storage warning to STDERR instead of STDOUT by @christopherfujino in https://github.com/flutter/flutter/pull/106068
* Add more CMake unit tests by @loic-sharma in https://github.com/flutter/flutter/pull/106076
* parse build version on xcodeproj by @Jasguerrero in https://github.com/flutter/flutter/pull/105908
* [flutter_tools] update test/src to null safety by @jonahwilliams in https://github.com/flutter/flutter/pull/106064
* [web] Fix JS crash when FF blocks service workers. by @ditman in https://github.com/flutter/flutter/pull/106072
* [flutter_tools] temporary directory by @Jasguerrero in https://github.com/flutter/flutter/pull/105815
* Update package:archive and pin test_api by @jonahwilliams in https://github.com/flutter/flutter/pull/106157
* Add integration test for `flutter build windows` by @loic-sharma in https://github.com/flutter/flutter/pull/106053
* Do not show diagnostic warning for disconnected iOS devices by @jmagman in https://github.com/flutter/flutter/pull/105971
* migrate more unit tests to null safety by @jonahwilliams in https://github.com/flutter/flutter/pull/106153
* [flutter_tools] Have FlutterValidator fail on non-ideal git config by @RoyARG02 in https://github.com/flutter/flutter/pull/103259
* migrate web integration tests to null safety by @jonahwilliams in https://github.com/flutter/flutter/pull/106231
* Pass app.started events to the DAP client + dart.debuggerUris for Profile mode by @DanTup in https://github.com/flutter/flutter/pull/106337
* [flutter_tools] tool exit access denied during symlinking by @christopherfujino in https://github.com/flutter/flutter/pull/106213
* feat(tools): Arbitrary browser flags (closes #65575)  by @Gustl22 in https://github.com/flutter/flutter/pull/104935
* [flutter_tools] migrate project-validate to analyze --suggestions by @Jasguerrero in https://github.com/flutter/flutter/pull/106149
* [flutter_tools] tool exit from flutter create when provided just a drive letter by @christopherfujino in https://github.com/flutter/flutter/pull/106451
* Fix .packages breakage and roll engine to 83b9a591a3d5 by @bdero in https://github.com/flutter/flutter/pull/106584
* [Windows] Flow version information to the build output by @loic-sharma in https://github.com/flutter/flutter/pull/106145
* Refactor daemon to check for project's supported platforms by @helin24 in https://github.com/flutter/flutter/pull/106704
* Put shaders under a 'shaders' section in the manifest by @zanderso in https://github.com/flutter/flutter/pull/106752
* plugin_ffi warn about lack of platform support by @dcharkes in https://github.com/flutter/flutter/pull/106813
* [flutter_tool] Pass --input-type to impellerc by @zanderso in https://github.com/flutter/flutter/pull/106845
* Ignore invalid description in vswhere.exe JSON output by @loic-sharma in https://github.com/flutter/flutter/pull/106836
* tool web Create an early web plugin_registrant for dartpad. by @ditman in https://github.com/flutter/flutter/pull/106921
* manual pub package roll; remove test_api pin, unblock bumping dwds by @christopherfujino in https://github.com/flutter/flutter/pull/106887
* Ensure flutter run build is done in incremental mode. by @aam in https://github.com/flutter/flutter/pull/107184
* Pass URI converter from context to DDS by @helin24 in https://github.com/flutter/flutter/pull/106840
* [flutter_tools] catch StdinException while trying to re-set single char mode by @christopherfujino in https://github.com/flutter/flutter/pull/107256
* [fuchsia] Change format of ffx call to debug spam. by @akbiggs in https://github.com/flutter/flutter/pull/105169
* Remove superfluous periods from `pub --help` subcommand descriptions. by @bryanoltman in https://github.com/flutter/flutter/pull/106925
* [flutter_releases] Fix null check errors in attach command (CP of #107864) by @christopherfujino in https://github.com/flutter/flutter/pull/108394
* CP Catch more general XmlException #106365 by @christopherfujino in https://github.com/flutter/flutter/pull/108839
* Remove deprecated Ruby File.exists? in helper script by @jmagman in https://github.com/flutter/flutter/pull/110045
### MacOS
* macos support for image_list by @Abhishek01039 in https://github.com/flutter/flutter/pull/84899
* [macOS] Adds macOS project files to layers example by @cbracken in https://github.com/flutter/flutter/pull/102539

## New Contributors
* @matasb-google made their first contribution in https://github.com/flutter/flutter/pull/100267
* @guillempuche made their first contribution in https://github.com/flutter/flutter/pull/100893
* @JankoLancer made their first contribution in https://github.com/flutter/flutter/pull/100377
* @Yeatse made their first contribution in https://github.com/flutter/flutter/pull/101123
* @maxzod made their first contribution in https://github.com/flutter/flutter/pull/93408
* @AesSedai101 made their first contribution in https://github.com/flutter/flutter/pull/101276
* @DetachHead made their first contribution in https://github.com/flutter/flutter/pull/101253
* @egramond made their first contribution in https://github.com/flutter/flutter/pull/101938
* @TowaYamashita made their first contribution in https://github.com/flutter/flutter/pull/100860
* @drewroengoogle made their first contribution in https://github.com/flutter/flutter/pull/102259
* @elliette made their first contribution in https://github.com/flutter/flutter/pull/102338
* @rgevrek made their first contribution in https://github.com/flutter/flutter/pull/102270
* @DanielCardonaRojas made their first contribution in https://github.com/flutter/flutter/pull/102342
* @JsouLiang made their first contribution in https://github.com/flutter/flutter/pull/100761
* @apeltop made their first contribution in https://github.com/flutter/flutter/pull/102487
* @prateekmedia made their first contribution in https://github.com/flutter/flutter/pull/91982
* @jeremyschlatter made their first contribution in https://github.com/flutter/flutter/pull/102453
* @sealesj made their first contribution in https://github.com/flutter/flutter/pull/103134
* @Maistho made their first contribution in https://github.com/flutter/flutter/pull/102692
* @ktakayama made their first contribution in https://github.com/flutter/flutter/pull/103261
* @SuperPenguin made their first contribution in https://github.com/flutter/flutter/pull/103343
* @daniloapr made their first contribution in https://github.com/flutter/flutter/pull/103555
* @davidmigloz made their first contribution in https://github.com/flutter/flutter/pull/103701
* @csells made their first contribution in https://github.com/flutter/flutter/pull/104135
* @dacianf made their first contribution in https://github.com/flutter/flutter/pull/103816
* @ueman made their first contribution in https://github.com/flutter/flutter/pull/104321
* @justforlxz made their first contribution in https://github.com/flutter/flutter/pull/104606
* @cadenkriese made their first contribution in https://github.com/flutter/flutter/pull/105189
* @zeshuaro made their first contribution in https://github.com/flutter/flutter/pull/102501
* @KKimj made their first contribution in https://github.com/flutter/flutter/pull/91496
* @takassh made their first contribution in https://github.com/flutter/flutter/pull/102747
* @LempereurBenjamin made their first contribution in https://github.com/flutter/flutter/pull/104491
* @cedvdb made their first contribution in https://github.com/flutter/flutter/pull/105577
* @EnduringBeta made their first contribution in https://github.com/flutter/flutter/pull/105605
* @albinpk made their first contribution in https://github.com/flutter/flutter/pull/106264
* @CoderDake made their first contribution in https://github.com/flutter/flutter/pull/106197
* @Gustl22 made their first contribution in https://github.com/flutter/flutter/pull/104935
* @hacker1024 made their first contribution in https://github.com/flutter/flutter/pull/106624
* @Goddchen made their first contribution in https://github.com/flutter/flutter/pull/106511
* @kseino made their first contribution in https://github.com/flutter/flutter/pull/107059
* @akbiggs made their first contribution in https://github.com/flutter/flutter/pull/105169

**Full Changelog**: https://github.com/flutter/flutter/compare/3.0.0...3.3.0-0.5.pre
