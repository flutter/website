---
title: Flutter 3.7.0 release notes
short-title: 3.7.0 release notes
description: Release notes for Flutter 3.7.0.
---
This page has release notes for 3.7.0.
For information about subsequent bug-fix releases,
see [Hotfixes to the Stable Channel][].

[Hotfixes to the Stable Channel]: {{site.repo.flutter}}/blob/master/docs/releases/Hotfixes-to-the-Stable-Channel.md

## What's changed

The following changes happened in this release:

### Framework
* Add a matcher for Matrix4 that includes epsilon by @jonahwilliams in https://github.com/flutter/flutter/pull/107326
* Expose the duration and curve for theme animation in MaterialApp. by @darrenaustin in https://github.com/flutter/flutter/pull/107383
* Persistent BottomSheet are not dismissible via a11y by @goderbauer in https://github.com/flutter/flutter/pull/107435
* [framework] SliverDecoration by @jonahwilliams in https://github.com/flutter/flutter/pull/107269
* Update `PopupRoute` docs and add an example by @TahaTesser in https://github.com/flutter/flutter/pull/106948
* Add a snapAnimationDuration param in DraggableScrollableSheet by @hangyujin in https://github.com/flutter/flutter/pull/107396
* Remerge "Fixed AnimatedSwitcher chain produced duplicates" after fixing issues with g3 by @youssef-attia in https://github.com/flutter/flutter/pull/107476
* updateEditingValueWithDeltas should fail loudly when TextRange is invalid by @Renzo-Olivares in https://github.com/flutter/flutter/pull/107426
* [PopupMenu]: Add menu `ClipBehavior` by @TahaTesser in https://github.com/flutter/flutter/pull/107466
* Update `ListTile` and `ListTile` based widget docs for Material usage by @TahaTesser in https://github.com/flutter/flutter/pull/107104
* Update `ListTile` docs for color animation issues and add example by @TahaTesser in https://github.com/flutter/flutter/pull/106955
* Revert "[framework] SliverDecoration" by @jonahwilliams in https://github.com/flutter/flutter/pull/107561
* fix null safe check in RenderIndexedStack by @christopherfujino in https://github.com/flutter/flutter/pull/107581
* [Keyboard, iOS] Generate iOS's special key mapping by @dkwingsmt in https://github.com/flutter/flutter/pull/106909
* Fix scrollbar margins by @Piinks in https://github.com/flutter/flutter/pull/107172
* [flutter_driver] support send text input action by @nploi in https://github.com/flutter/flutter/pull/106561
* Add an example for `AppBar.notificationPredicate` by @TahaTesser in https://github.com/flutter/flutter/pull/106018
* Add an interactive example for `Overlay` by @TahaTesser in https://github.com/flutter/flutter/pull/107531
* `DropdownButton`: Fix hint alignment when `selectedItemBuilder` is non-null. by @TahaTesser in https://github.com/flutter/flutter/pull/106731
* Fix dragging while the text selection toolbar is up doesn't hide toolbar by @TahaTesser in https://github.com/flutter/flutter/pull/106878
* Remove exclamation marks by @LongCatIsLooong in https://github.com/flutter/flutter/pull/107683
* Allow key reparenting between slots in `SlottedMultiChildRenderObjectWidgetMixin` by @LongCatIsLooong in https://github.com/flutter/flutter/pull/106977
* Fix `Scaffold` `setState` during locked framework due to open drawer by @markusaksli-nc in https://github.com/flutter/flutter/pull/107173
* enable combinators_ordering by @a14n in https://github.com/flutter/flutter/pull/107847
* PointerEvent asserts device kinds by @dkwingsmt in https://github.com/flutter/flutter/pull/105987
* Do not copy the old selection when applying localization to dates in InputDatePickerFormField by @jason-simmons in https://github.com/flutter/flutter/pull/107268
* Expose padding on RawScrollbar by @Piinks in https://github.com/flutter/flutter/pull/107756
* Update the documentation of `IconButton`'s `color` parameter. by @ValentinVignal in https://github.com/flutter/flutter/pull/107819
* Make the cursor no longer blinking when move, as same as the effect of iOS platform. by @talisk in https://github.com/flutter/flutter/pull/107221
* Add SafeArea for NavigationRail by @QuncCccccc in https://github.com/flutter/flutter/pull/107605
* Error in docs: `CustomPaint` instead of `CustomPainter` by @0xba1 in https://github.com/flutter/flutter/pull/107836
* Dropdown height large scale text fix by @foongsq in https://github.com/flutter/flutter/pull/107201
* [Keyboard] Make CharacterActivator support Ctrl and Meta modifiers, and repeats by @dkwingsmt in https://github.com/flutter/flutter/pull/107195
* Add  transitionOnUserGestures to true on SnackBar for back swipe by @letsar in https://github.com/flutter/flutter/pull/106638
* Cupertino date picker fix for minDate, maxDate when using minuteInterval by @NikosTsesmelis in https://github.com/flutter/flutter/pull/105958
* Implement `CupertinoListSection` and `CupertinoListTile` by @campovski in https://github.com/flutter/flutter/pull/78732
* Add `useSafeArea` parameter to `showModalBottomSheet` by @bleroux in https://github.com/flutter/flutter/pull/107140
* Add support for fill, weight, grade, and optical size to `Icon` by @guidezpl in https://github.com/flutter/flutter/pull/106896
* Use persistent hash map to store _inheritedWidgets by @mraleph in https://github.com/flutter/flutter/pull/107068
* Allow setting of TestWidgetsFlutterBinding.pointerEventSource by @HelioStrike in https://github.com/flutter/flutter/pull/107976
* Revert "Allow setting of TestWidgetsFlutterBinding.pointerEventSource" by @dnfield in https://github.com/flutter/flutter/pull/108038
* Add OvalBorder and BoxShape.oval  by @bernaferrari in https://github.com/flutter/flutter/pull/103833
* Fix BottomNavigationBarItem tooltip defaults to label by @bleroux in https://github.com/flutter/flutter/pull/107715
* Pointer events: Allow hover events from trackpad by @dkwingsmt in https://github.com/flutter/flutter/pull/108116
* Scroll inertia cancel [framework] by @moffatman in https://github.com/flutter/flutter/pull/106891
* Add supportedDevices parameter to GestureDetector by @moffatman in https://github.com/flutter/flutter/pull/107312
* [flutter_tool] Build shaders as .iplr and use FragmentProgram.fromAsset for ink_sparkle by @zanderso in https://github.com/flutter/flutter/pull/108071
* Use toPictureSync for faster zoom page transition by @jonahwilliams in https://github.com/flutter/flutter/pull/106621
* Allow trackpad inertia cancel events by @moffatman in https://github.com/flutter/flutter/pull/108190
* fix GestureDetector.onDoubleTapDown not getting called by @pedromassango in https://github.com/flutter/flutter/pull/108056
* [web] define $flutterDriverResult variable early in driver test initalization by @yjbanov in https://github.com/flutter/flutter/pull/107337
* Add optional flag to determine assertiveness level in aria announcement for flutter web by @nbayati in https://github.com/flutter/flutter/pull/107568
* Fixes issue with sheet reset on rebuild by @caseycrogers in https://github.com/flutter/flutter/pull/107876
* Revert "Add optional flag to determine assertiveness level in aria announcement for flutter web" by @CaseyHillers in https://github.com/flutter/flutter/pull/108262
* flutter update-packages --force-upgrade + analyzer fix by @goderbauer in https://github.com/flutter/flutter/pull/108198
* Migrate InputDecorator to Material 3 by @hangyujin in https://github.com/flutter/flutter/pull/107943
* Added iconSize parameter in ButtonStyle by @QuncCccccc in https://github.com/flutter/flutter/pull/108268
* Explain the "patching" protocol in `KeyMessageManager.keyMessageHandler` and add an example by @dkwingsmt in https://github.com/flutter/flutter/pull/105280
* Dispose scaffold drawers. by @polina-c in https://github.com/flutter/flutter/pull/108234
* Dispose _TextSpanEditingController. by @polina-c in https://github.com/flutter/flutter/pull/108228
* Dispose painters by @polina-c in https://github.com/flutter/flutter/pull/108233
* Dispose widgets to stop leaks. by @polina-c in https://github.com/flutter/flutter/pull/108193
* Dispose KeepAliveHandle. by @polina-c in https://github.com/flutter/flutter/pull/108227
* Update docs on ChangeNotifier.dispose and KeepAliveHandle.release by @dnfield in https://github.com/flutter/flutter/pull/108384
* Modify dataMap to include assertiveness only if it's not set to polite by @nbayati in https://github.com/flutter/flutter/pull/108396
* [flutter_tools] add tool support for shader hot reload by @jonahwilliams in https://github.com/flutter/flutter/pull/107963
* Removed references to deprecated styleFrom parameters. by @darrenaustin in https://github.com/flutter/flutter/pull/108401
* Add RenderRepaintBoundary.toImageSync() method by @tgucio in https://github.com/flutter/flutter/pull/108280
* Do not crash when remove SelectableText during handle drag by @xu-baolin in https://github.com/flutter/flutter/pull/108369
* Use FragmentProgram.fromAssetAsync by @zanderso in https://github.com/flutter/flutter/pull/108415
* FloatingActionButton: add themeable mouse cursor by @jpnurmi in https://github.com/flutter/flutter/pull/103473
* Added a clarification on scrollBehaviour in BoxScroll and ListView by @snat-s in https://github.com/flutter/flutter/pull/107738
* Optimize closure in input_decorator_theme by @hangyujin in https://github.com/flutter/flutter/pull/108379
* Suggest predicate-based formatter in [FilteringTextInputFormatter] docs for whole string matching by @LongCatIsLooong in https://github.com/flutter/flutter/pull/107848
* Simplify mark needs build by @goderbauer in https://github.com/flutter/flutter/pull/108383
* Nth part of async FragmentProgram.fromAsset transition by @zanderso in https://github.com/flutter/flutter/pull/108473
* Add StarBorder and StarBorder.polygon, with example. by @gspencergoog in https://github.com/flutter/flutter/pull/108489
* fix a tabs indicator padding update bug by @xu-baolin in https://github.com/flutter/flutter/pull/108287
* Fixes a NestedScrollView UserScrollNotification issue by @xu-baolin in https://github.com/flutter/flutter/pull/107632
* Migrate TextField to Material 3 by @hangyujin in https://github.com/flutter/flutter/pull/108366
* Change default value of `effectiveInactivePressedOverlayColor` in Switch to refer to `effectiveInactiveThumbColor` by @QuncCccccc in https://github.com/flutter/flutter/pull/108477
* Guard against usage after async callbacks in RenderAndroidView, unregister listener by @dnfield in https://github.com/flutter/flutter/pull/108496
* disable new transition while toPictureSync is fixed by @jonahwilliams in https://github.com/flutter/flutter/pull/108565
* Mark NavigationBar as non-const to match reality by @goderbauer in https://github.com/flutter/flutter/pull/108562
* Add shadowColor and surfaceTintColor to Dialog and DialogTheme. by @darrenaustin in https://github.com/flutter/flutter/pull/108405
* Update Chips examples and rename files by @TahaTesser in https://github.com/flutter/flutter/pull/108538
* Replace FocusTrap with TapRegionSurface by @gspencergoog in https://github.com/flutter/flutter/pull/107262
* "Select All" Automatically scrolls EditableText to the end of the text field, which doesn't happen on native iOS by @antholeole in https://github.com/flutter/flutter/pull/105799
* Add onTapOutside to TextFormField by @gspencergoog in https://github.com/flutter/flutter/pull/108629
* Revert "Add shadowColor and surfaceTintColor to Dialog and DialogTheme." by @CaseyHillers in https://github.com/flutter/flutter/pull/108621
* Quick Documentation Fix for Sliver by @youssef-attia in https://github.com/flutter/flutter/pull/108633
* Improve dumpSemanticsTree error when semantics are unavailable by @goderbauer in https://github.com/flutter/flutter/pull/108574
* Update web links for autofill by @kevmoo in https://github.com/flutter/flutter/pull/108640
* Fix doc comment line accidentally removed by @kevmoo in https://github.com/flutter/flutter/pull/108654
* [framework] create animation from value listenable by @jonahwilliams in https://github.com/flutter/flutter/pull/108644
* TextPainter throw with stack trace to help track down read-before-layout  by @LongCatIsLooong in https://github.com/flutter/flutter/pull/108571
* Override PlaceholderDimensions equality operator to avoid unnecessary TextPainter re-layouts by @tgucio in https://github.com/flutter/flutter/pull/108623
* Fix lerp to eccentric circle. by @gspencergoog in https://github.com/flutter/flutter/pull/108743
* Fix ExpansionTile shows children background when expanded by @bleroux in https://github.com/flutter/flutter/pull/107834
* Create `containsSemantics` to allow for partial matching of semantics in tests. by @pdblasi-google in https://github.com/flutter/flutter/pull/108573
* [SelectionOverlay]Move the debug statement to the scope of the assertion. by @xu-baolin in https://github.com/flutter/flutter/pull/108508
* Loupe Android + iOS by @antholeole in https://github.com/flutter/flutter/pull/107477
* Deprecate `toggleableActiveColor` by @TahaTesser in https://github.com/flutter/flutter/pull/97972
* Revert "Fix ExpansionTile shows children background when expanded" by @Piinks in https://github.com/flutter/flutter/pull/108844
* Update docs to show ImageChunkEvent is an optional param by @parkershepherd in https://github.com/flutter/flutter/pull/108843
* Reland "Add shadowColor and surfaceTintColor to Dialog and DialogTheme." by @darrenaustin in https://github.com/flutter/flutter/pull/108718
* [flutter_test] Add flag to send device pointer events to the framework by @jiahaog in https://github.com/flutter/flutter/pull/108430
* Update `equalsIgnoringHashCodes` to take a list of Strings by @gspencergoog in https://github.com/flutter/flutter/pull/108507
* [macOS] Use editing intents from engine by @knopp in https://github.com/flutter/flutter/pull/105407
* Added `IconButtonTheme` and apply it to `IconButton` in M3 by @QuncCccccc in https://github.com/flutter/flutter/pull/108332
* [flutter_test] perf: find.ancestor by @passsy in https://github.com/flutter/flutter/pull/108868
* Remove some outdated ignores from framework by @goderbauer in https://github.com/flutter/flutter/pull/108915
* Clean up ScrollbarPainter by @Piinks in https://github.com/flutter/flutter/pull/107179
* Remove outdated ignores by @goderbauer in https://github.com/flutter/flutter/pull/108924
* Add more logs to diagnose Gold flake by @Piinks in https://github.com/flutter/flutter/pull/108930
* Update Text field counter error style to material 3 by @hangyujin in https://github.com/flutter/flutter/pull/108704
* Fix an issue that semantics on TextField is not updated when changing obscureText by @hangyujin in https://github.com/flutter/flutter/pull/108545
* Don't redefine SkSL builtin function 'saturate' by @zanderso in https://github.com/flutter/flutter/pull/108946
* Can call ChangeNotifier.hasListeners after disposed by @chunhtai in https://github.com/flutter/flutter/pull/108931
* Typo in Documentation for Restoration with didChangeDependencies by @Stitch-Taotao in https://github.com/flutter/flutter/pull/108659
* Apply `indexToItemIndex` to indices returned by `findChildIndexCallback` in `SliverAnimatedListState` by @otto-dev in https://github.com/flutter/flutter/pull/108710
* [Fonts] Update icons by @guidezpl in https://github.com/flutter/flutter/pull/108858
* Revert "[Fonts] Update icons" by @zanderso in https://github.com/flutter/flutter/pull/109073
* Add `outlineVariant` and `scrim` colors to `ColorScheme` by @guidezpl in https://github.com/flutter/flutter/pull/109071
* [flutter roll] Revert "Reland "Add shadowColor and surfaceTintColor to Dialog and Di… by @XilaiZhang in https://github.com/flutter/flutter/pull/109170
* Fix autocomplete selections by @gspencergoog in https://github.com/flutter/flutter/pull/109185
* Add support for font variation based theming to `Icon` by @guidezpl in https://github.com/flutter/flutter/pull/109140
* Revert "Add `outlineVariant` and `scrim` colors to `ColorScheme`" by @CaseyHillers in https://github.com/flutter/flutter/pull/109199
* Fix DraggableScrollableSheet and ListView has tiny scroll of one pixel by @xu-baolin in https://github.com/flutter/flutter/pull/109081
* [framework] Animatable.fromCallback and code snippet by @jonahwilliams in https://github.com/flutter/flutter/pull/108661
* Reland: "Add example and troubleshooting comment for `showSnackBar`" by @bleroux in https://github.com/flutter/flutter/pull/105195
* Deprecate ThemeData.selectedRowColor by @Piinks in https://github.com/flutter/flutter/pull/109070
* Reland: "Add `outlineVariant` and `scrim` colors to `ColorScheme`" by @guidezpl in https://github.com/flutter/flutter/pull/109203
* Replace NavigatorObserver._navigator with a static expando. by @stereotype441 in https://github.com/flutter/flutter/pull/109238
* Implements browser context menu in selectable region by @chunhtai in https://github.com/flutter/flutter/pull/108909
* Revert "disable new transition while toPictureSync is fixed" by @jonahwilliams in https://github.com/flutter/flutter/pull/109327
* Move MagnifierBuilder, MagnifierOverlayInfoBearer from text_selection.dart by @tgucio in https://github.com/flutter/flutter/pull/108956
* API documentation cleanup by @Hixie in https://github.com/flutter/flutter/pull/108500
* Change ClipboardStatusNofifier parameter in buildToolbar to ValueLise… by @chunhtai in https://github.com/flutter/flutter/pull/108917
* Fix Android platform view creation flow by @stuartmorgan in https://github.com/flutter/flutter/pull/109232
* Minor fix compendium by @Hixie in https://github.com/flutter/flutter/pull/107874
* Revert "Fix Android platform view creation flow" by @CaseyHillers in https://github.com/flutter/flutter/pull/109389
* [framework] document backdropfilter antipattern by @jonahwilliams in https://github.com/flutter/flutter/pull/109340
* Revert "Change ClipboardStatusNofifier parameter in buildToolbar to V… by @CaseyHillers in https://github.com/flutter/flutter/pull/109388
* Set `IconButton.visualDensity` default to `VisualDensity.standard` by @QuncCccccc in https://github.com/flutter/flutter/pull/109349
* Added documentation for AppBar actions by @QuncCccccc in https://github.com/flutter/flutter/pull/109351
* Revert "Set `IconButton.visualDensity` default to `VisualDensity.standard`" by @QuncCccccc in https://github.com/flutter/flutter/pull/109421
* Reland: Fix Android platform view creation flow by @stuartmorgan in https://github.com/flutter/flutter/pull/109405
* Keep `dirty` manipulations private to `Element` base class by @goderbauer in https://github.com/flutter/flutter/pull/109401
* Revert "Keep `dirty` manipulations private to `Element` base class (#109401)" by @gspencergoog in https://github.com/flutter/flutter/pull/109481
* Single tap on the previous selection should toggle the toolbar on iOS… by @Renzo-Olivares in https://github.com/flutter/flutter/pull/108913
* Add onOpened callback to PopupMenuButton by @limonadev in https://github.com/flutter/flutter/pull/103753
* Reland "Keep `dirty` manipulations private to `Element` base class (#109401)" by @goderbauer in https://github.com/flutter/flutter/pull/109562
* Refactor StrokeAlign to allow double values. by @bernaferrari in https://github.com/flutter/flutter/pull/108339
* Fix Text selection handler disappear when dragged to new words by @xu-baolin in https://github.com/flutter/flutter/pull/108808
* Revert "Refactor StrokeAlign to allow double values." by @CaseyHillers in https://github.com/flutter/flutter/pull/109591
* Fix `CupertinoListTile``s onTap with delay throws exception by @TahaTesser in https://github.com/flutter/flutter/pull/109038
* Pass fit property to RenderIndexedStack by @maheshmnj in https://github.com/flutter/flutter/pull/109295
* Fix that RenderEditable (TextField) ignores offset in painting, making text selections shifted when offset is nonzero by @fzyzcjy in https://github.com/flutter/flutter/pull/109287
* Add Spellcheck to EditableText (Android) by @camsim99 in https://github.com/flutter/flutter/pull/109334
* Revert "Add Spellcheck to EditableText (Android)" by @jonahwilliams in https://github.com/flutter/flutter/pull/109631
* Change "Unicode scalar values" to "Unicode grapheme clusters" in maxLength docs by @olof-dev in https://github.com/flutter/flutter/pull/106275
* Some changes needed to PlatformMenuBar before the MenuBar implementation change lands. by @gspencergoog in https://github.com/flutter/flutter/pull/109556
* Scrollbar respect the NeverScrollableScrollPhysics physics by @xu-baolin in https://github.com/flutter/flutter/pull/109609
* Fix a type casting error in text_input.dart by @LongCatIsLooong in https://github.com/flutter/flutter/pull/109635
* Re-land Add Spell Check to EditableText  by @camsim99 in https://github.com/flutter/flutter/pull/109643
* [docs][FWW] DropdownButton, ScaffoldMessenger, and StatefulBuilder links by @craiglabenz in https://github.com/flutter/flutter/pull/100316
* Fix AppBar centerTitle position with actions. by @bernaferrari in https://github.com/flutter/flutter/pull/106256
* Improve ShapeDecoration performance. by @bernaferrari in https://github.com/flutter/flutter/pull/108648
* 109638: Windows framework_tests_misc is 2.06% flaky by @pdblasi-google in https://github.com/flutter/flutter/pull/109640
* Some misc changes needed for MenuBar implementation. by @gspencergoog in https://github.com/flutter/flutter/pull/109555
* Don't disable pointer interaction during trackpad scroll by @moffatman in https://github.com/flutter/flutter/pull/106890
* Add an example for how to hide default scrollbar on desktop platform. by @TahaTesser in https://github.com/flutter/flutter/pull/108542
* Reland: Set IconButton.visualDensity default to VisualDensity.standard by @QuncCccccc in https://github.com/flutter/flutter/pull/109432
* [Dismissible]Fix a state lose issue by @xu-baolin in https://github.com/flutter/flutter/pull/108971
* Replace empty Container with const SizedBox by @tgucio in https://github.com/flutter/flutter/pull/108672
* Update Ballistic animation & ClampingScrollSimulation by @Piinks in https://github.com/flutter/flutter/pull/107735
* Re-Land "Refactor StrokeAlign to allow double values." (#109591) by @gspencergoog in https://github.com/flutter/flutter/pull/109805
* Add some logs to catch flake by @goderbauer in https://github.com/flutter/flutter/pull/109887
* [framework] remove restriction on texture layer rasterization by @jonahwilliams in https://github.com/flutter/flutter/pull/109900
* Revert "Re-Land "Refactor StrokeAlign to allow double values." (#109805)" by @gspencergoog in https://github.com/flutter/flutter/pull/109955
* Support inputDecoration's iconColor, prefixIconColor and suffixIconColor by @hangyujin in https://github.com/flutter/flutter/pull/109988
* Remove the FocusScopeNode in the navigator by @gspencergoog in https://github.com/flutter/flutter/pull/109702
* Deprecate 2018 text theme parameters by @Piinks in https://github.com/flutter/flutter/pull/109817
* Fixed leading button size on app bar by @QuncCccccc in https://github.com/flutter/flutter/pull/110043
* Document tristate value by @yaakovschectman in https://github.com/flutter/flutter/pull/110106
* Revert "Fixed leading button size on app bar" by @QuncCccccc in https://github.com/flutter/flutter/pull/110103
* Revert "Reland: Set IconButton.visualDensity default to VisualDensity.standard" by @QuncCccccc in https://github.com/flutter/flutter/pull/110119
* Fix some typos by @eggfly in https://github.com/flutter/flutter/pull/110077
* Fix `floatingActionButtonAnimator` not being updated by @TahaTesser in https://github.com/flutter/flutter/pull/110067
* Add covariant to `ThemeExtension.lerp` by @guidezpl in https://github.com/flutter/flutter/pull/105207
* use super parameters in framework by @newtaDev in https://github.com/flutter/flutter/pull/103620
* Support for FilterQuality in FadeInImage by @FluentCoding in https://github.com/flutter/flutter/pull/110096
* [framework] simplify raster widget, rename, combine painters by @jonahwilliams in https://github.com/flutter/flutter/pull/109485
* Update accessibility contrast test coverage by @ankur2136 in https://github.com/flutter/flutter/pull/109784
* Added support for M3 filled and filled tonal buttons. by @darrenaustin in https://github.com/flutter/flutter/pull/107382
* Re-Land "Refactor StrokeAlign to allow double values." (#108339) by @gspencergoog in https://github.com/flutter/flutter/pull/110234
* Fix Image's logical flow which disposes its image too early, causing errors such as "Cannot clone a disposed image" by @fzyzcjy in https://github.com/flutter/flutter/pull/110131
* Replace `_lerpProperties` with `MaterialStateProperty.lerp` in `button_style.dart` by @TahaTesser in https://github.com/flutter/flutter/pull/110323
* Fixed some doc typos in OutlinedButton and TextButton.styleFrom deprecations by @darrenaustin in https://github.com/flutter/flutter/pull/110308
* Revert "Update accessibility contrast test coverage" by @CaseyHillers in https://github.com/flutter/flutter/pull/110436
* [flutter_driver] make empty duration messages more helpful by @jonahwilliams in https://github.com/flutter/flutter/pull/110441
* add material slider secondary value by @akshdeep-singh in https://github.com/flutter/flutter/pull/109808
* Added onSelectionChange callback to SelectionRegion and SelectionArea by @chinmoy12c in https://github.com/flutter/flutter/pull/108985
* Fix an exception in `StarBorder`s that are scaled to small or infinite sizes by @gspencergoog in https://github.com/flutter/flutter/pull/110419
* Remove warnings when `UnconstrainedBox` and `ConstraintsTransformBox` are clipped by @gspencergoog in https://github.com/flutter/flutter/pull/110393
* Fix some tap region bugs by @gspencergoog in https://github.com/flutter/flutter/pull/110398
* Refactor macOS text editing shortcuts by @chunhtai in https://github.com/flutter/flutter/pull/110289
* Clear the static _debugDoingBaseline flag if baseline calculation throws by @jason-simmons in https://github.com/flutter/flutter/pull/110387
* Add test where white text on white background fails contrast. by @ankur2136 in https://github.com/flutter/flutter/pull/110217
* Fixed the default color of the trailing widget on app bar by @QuncCccccc in https://github.com/flutter/flutter/pull/110635
* Migrated `Checkbox` to Material 3 Colors by @QuncCccccc in https://github.com/flutter/flutter/pull/110537
* Add splashColor property for ListTile widget by @M97Chahboun in https://github.com/flutter/flutter/pull/100652
* Fixed the leading IconButton size by @QuncCccccc in https://github.com/flutter/flutter/pull/110722
* Make ink_sparkle use FragmentShader by @zanderso in https://github.com/flutter/flutter/pull/110552
* Add `Overlay.maybeOf`, make `Overlay.of` return a non-nullable instance by @gspencergoog in https://github.com/flutter/flutter/pull/110811
* Fix `Action.overridable` example by @LongCatIsLooong in https://github.com/flutter/flutter/pull/110824
* Remove errant double spaces by @guidezpl in https://github.com/flutter/flutter/pull/110758
* Deprecate `ThemeData` `errorColor` and `backgroundColor` by @guidezpl in https://github.com/flutter/flutter/pull/110162
* Fix Tooltip Issue on Switch by @QuncCccccc in https://github.com/flutter/flutter/pull/110830
* Use semantics label for backbutton and closebutton for Android by @chunhtai in https://github.com/flutter/flutter/pull/110873
* Add `inherit: false` to material2018 text geometry text themes by @LongCatIsLooong in https://github.com/flutter/flutter/pull/110870
* Update `MaterialBanner` to support Material 3 by @TahaTesser in https://github.com/flutter/flutter/pull/105957
* Migrate `ListTile` unselected icon color to Material 3 by @TahaTesser in https://github.com/flutter/flutter/pull/102078
* Preliminary PR for engine changes for Tristate checkboxes by @yaakovschectman in https://github.com/flutter/flutter/pull/110859
* Adds `PopupMenuPosition position` to the `PopupMenuThemeData` by @ValentinVignal in https://github.com/flutter/flutter/pull/110268
* Dispose Paragraph objects by @dnfield in https://github.com/flutter/flutter/pull/110627
* Fixing elevation issues with Material 3 by @darrenaustin in https://github.com/flutter/flutter/pull/110624
* Request `DartPerformanceMode.latency` during transitions by @iskakaushik in https://github.com/flutter/flutter/pull/110600
* [Fonts] Update icons by @guidezpl in https://github.com/flutter/flutter/pull/111092
* Use raw fontFamilyFallback values without packages when constructing a merged TextStyle by @jason-simmons in https://github.com/flutter/flutter/pull/110887
* [web] skip flaky date picker golden tests by @yjbanov in https://github.com/flutter/flutter/pull/111114
* 110598: expect() in semantic test producing unhelpful output by @pdblasi-google in https://github.com/flutter/flutter/pull/110613
* Create consts for service extension names so they can be accessed from tooling by @kenzieschmoll in https://github.com/flutter/flutter/pull/110876
* Create consts for foundation service extension names so they can be accessed from tooling by @kenzieschmoll in https://github.com/flutter/flutter/pull/111146
* Annual spelling error fix by @gspencergoog in https://github.com/flutter/flutter/pull/111132
* Create consts for rendering service extension names so they can be accessed from tooling by @kenzieschmoll in https://github.com/flutter/flutter/pull/111149
* fixes FadeInImage for an edge case by @werainkhatri in https://github.com/flutter/flutter/pull/111035
* Deprecate ThemeData.bottomAppBarColor by @esouthren in https://github.com/flutter/flutter/pull/111080
* Fixed one-frame InkWell overlay color problem on unhover by @HansMuller in https://github.com/flutter/flutter/pull/111112
* Revert Ballistic & Clamping simulation updates by @Piinks in https://github.com/flutter/flutter/pull/111201
* [framework] revert removal of opacity by @jonahwilliams in https://github.com/flutter/flutter/pull/111202
* Fix spell_check_test by @camsim99 in https://github.com/flutter/flutter/pull/110814
* Use tristate checkbox engine changes by @yaakovschectman in https://github.com/flutter/flutter/pull/111032
* Migrated `Checkbox` to Material 3 - Added Error State by @QuncCccccc in https://github.com/flutter/flutter/pull/111153
* Fix TabBarView with no animation not navigating by @tomgilder in https://github.com/flutter/flutter/pull/110985
* Add ability to show magnifier on long press by @Renzo-Olivares in https://github.com/flutter/flutter/pull/111224
* Create enum for scheduler service extension names so they can be accessed from tooling by @kenzieschmoll in https://github.com/flutter/flutter/pull/111222
* Fix typos introduced typos in `popup_menu_theme_test.dart` by @ValentinVignal in https://github.com/flutter/flutter/pull/111060
* Revert "Update `MaterialBanner` to support Material 3" by @CaseyHillers in https://github.com/flutter/flutter/pull/111288
* Migrated `Switch` to Material 3 by @QuncCccccc in https://github.com/flutter/flutter/pull/110095
* Fix documentation for InputDecoration.focusColor by @gspencergoog in https://github.com/flutter/flutter/pull/111290
* Normalize examples by @gspencergoog in https://github.com/flutter/flutter/pull/111223
* fix: removed Widget type from child parameter in OutlinedButton by @alestiago in https://github.com/flutter/flutter/pull/111034
* Started handling messages from background isolates. by @gaaclarke in https://github.com/flutter/flutter/pull/109005
* Revert "Started handling messages from background isolates." by @gaaclarke in https://github.com/flutter/flutter/pull/111318
* Create class MemoryAllocations. by @polina-c in https://github.com/flutter/flutter/pull/110230
* [web] skip more perspective text tests by @yjbanov in https://github.com/flutter/flutter/pull/111402
* Reland: Started handling messages from background isolates. by @gaaclarke in https://github.com/flutter/flutter/pull/111320
* [framework] work around to load self packages from packages/ by @jonahwilliams in https://github.com/flutter/flutter/pull/111350
* Fix references to symbols to use brackets instead of backticks by @gspencergoog in https://github.com/flutter/flutter/pull/111331
* Add doc note about when to dispose TextPainter by @dnfield in https://github.com/flutter/flutter/pull/111403
* Revert "Use semantics label for backbutton and closebutton for Android" by @XilaiZhang in https://github.com/flutter/flutter/pull/111305
* Fix Magnifier crash by @justinmc in https://github.com/flutter/flutter/pull/111303
* Allow Navigator to inherit traversal policy from parent. by @gspencergoog in https://github.com/flutter/flutter/pull/110818
* Create enum for service extensions in services library by @kenzieschmoll in https://github.com/flutter/flutter/pull/111412
* Create an enum for widget inspector service extensions for use by tools by @kenzieschmoll in https://github.com/flutter/flutter/pull/111405
* Enable android isolate platform channels tests by @gaaclarke in https://github.com/flutter/flutter/pull/111279
* Fix DraggableScrollableSheet rebuilding during drag by @moffatman in https://github.com/flutter/flutter/pull/111010
* Utility methods for measuring text by @dnfield in https://github.com/flutter/flutter/pull/111493
* Fix the TimePicker hour/minute field's input actions by @TahaTesser in https://github.com/flutter/flutter/pull/97361
* Fix text direction nullability by @dnfield in https://github.com/flutter/flutter/pull/111513
* Reland "Update accessibility contrast test coverage (#109784)" by @chunhtai in https://github.com/flutter/flutter/pull/110502
* Updated tokens to v0.127 by @QuncCccccc in https://github.com/flutter/flutter/pull/111495
* Updated the Action chip's documentation regarding disabled states. by @darrenaustin in https://github.com/flutter/flutter/pull/111598
* Prepare the framework for having RRect assert on negative radii by @gspencergoog in https://github.com/flutter/flutter/pull/111515
* Fix performance regression. by @polina-c in https://github.com/flutter/flutter/pull/111615
* Add BuildContext.mounted by @goderbauer in https://github.com/flutter/flutter/pull/111619
* Revert "Single tap on the previous selection should toggle the toolbar on iOS…" by @godofredoc in https://github.com/flutter/flutter/pull/111662
* Remove no-longer-needed clamping of RRect radii by @gspencergoog in https://github.com/flutter/flutter/pull/111668
* Fix todo format by @pq in https://github.com/flutter/flutter/pull/111685
* Fix RangeSlider constructor reference to `[value]` by @srawlins in https://github.com/flutter/flutter/pull/111694
* Revert isolate platform channels because of google integration tooling by @gaaclarke in https://github.com/flutter/flutter/pull/111702
* panningDirection parameter added to InteractiveViewer by @NazarenoCavazzon in https://github.com/flutter/flutter/pull/109014
* Reland "Update `MaterialBanner` to support Material 3" by @TahaTesser in https://github.com/flutter/flutter/pull/111299
* Fix OutlineInputBorder with BorderRadius.zero is distorted by @bleroux in https://github.com/flutter/flutter/pull/106849
* Add missing deprecation notice for toggleableActiveColor by @Piinks in https://github.com/flutter/flutter/pull/111707
* Reset missing deprecation for ScrollbarThemeData.copyWith(showTrackOnHover) by @Piinks in https://github.com/flutter/flutter/pull/111706
* Makes TextBoundary and its subclasses public by @chunhtai in https://github.com/flutter/flutter/pull/110367
* Fix a CupertinoScrollbar NNBD issue by @xu-baolin in https://github.com/flutter/flutter/pull/111198
* fix a draggableScrollableSheet's LocalHistoryEntry leaking by @xu-baolin in https://github.com/flutter/flutter/pull/110576
* Fix changing DraggableScrollableSheet controller by @moffatman in https://github.com/flutter/flutter/pull/111445
* fixed inconsistent file names for *_chip.dart files and added a test by @werainkhatri in https://github.com/flutter/flutter/pull/111364
* Fix `Scrollbar` thumb drag behavior on desktop. by @TahaTesser in https://github.com/flutter/flutter/pull/111250
* Reland isolate platform channels with conditional compilation by @gaaclarke in https://github.com/flutter/flutter/pull/111712
* Fix UiKitView which wrongly unconditionally repaints by @fzyzcjy in https://github.com/flutter/flutter/pull/111790
* Migrate package/flutter to JS static interop. by @joshualitt in https://github.com/flutter/flutter/pull/111315
* Remove deprecated drag anchor by @Piinks in https://github.com/flutter/flutter/pull/111713
* Provide Material 3 defaults for vanilla `Chip` widget. by @darrenaustin in https://github.com/flutter/flutter/pull/111597
* Add macOS-specific scroll physics by @moffatman in https://github.com/flutter/flutter/pull/108298
* Avoid sending zero transform semantic nodes to the engine by @dnfield in https://github.com/flutter/flutter/pull/111843
* Remove deprecated ScrollBehavior.buildViewportChrome by @Piinks in https://github.com/flutter/flutter/pull/111715
* Update token v0.127 to v0.132 by @QuncCccccc in https://github.com/flutter/flutter/pull/111913
* Fixed an issue with FilterChips changing size when selected. by @darrenaustin in https://github.com/flutter/flutter/pull/111916
* fix: bottom navigation bar colors by @talamaska in https://github.com/flutter/flutter/pull/107924
* Remove Deprecated RenderUnconstrainedBox by @Piinks in https://github.com/flutter/flutter/pull/111711
* Fix an reorderable list animation issue:"Reversed ReorderableListView drop animation moves item one row higher than it should #110949" by @hangyujin in https://github.com/flutter/flutter/pull/111027
* Revert "Fix `Scrollbar` thumb drag behavior on desktop." by @Piinks in https://github.com/flutter/flutter/pull/111978
* [framework] avoid compositing with visibility by @jonahwilliams in https://github.com/flutter/flutter/pull/111844
* Remove controller listener on CupertinoPicker dispose by @moffatman in https://github.com/flutter/flutter/pull/111977
* Re-add the ability to return null in ListView.builder by @rrousselGit in https://github.com/flutter/flutter/pull/108706
* Add  friction coefficient to InteractiveViewer by @codeforce-dev in https://github.com/flutter/flutter/pull/109443
* Some miscellaneous changes found while making another PR by @gspencergoog in https://github.com/flutter/flutter/pull/111620
* Update Radio button to material 3 by @QuncCccccc in https://github.com/flutter/flutter/pull/111774
* Fix `InputDecorator` child vertical alignment by @LongCatIsLooong in https://github.com/flutter/flutter/pull/112003
* Update showCupertinoModalPopup documentation by @yunusemrebakir in https://github.com/flutter/flutter/pull/106274
* Instrument State, Layer, RenderObject and Element. by @polina-c in https://github.com/flutter/flutter/pull/111328
* Allow Hybrid Composition fallback for Android platform views by @stuartmorgan in https://github.com/flutter/flutter/pull/109161
* Isolate platform channels for macos by @gaaclarke in https://github.com/flutter/flutter/pull/110882
* Added `iconTheme` to `RawChip` in `ChoiceChip` by @Mayb3Nots in https://github.com/flutter/flutter/pull/110908
* Prevent committing text from triggering EditableText.onChanged by @LongCatIsLooong in https://github.com/flutter/flutter/pull/112010
* Update `InheritedWidget` example parameter naming by @robiness in https://github.com/flutter/flutter/pull/112137
* ui.PointerSignalKind forwards compatibility for scale by @moffatman in https://github.com/flutter/flutter/pull/112170
* Fixed an iconTheme lerping problem with ChipThemeData. by @darrenaustin in https://github.com/flutter/flutter/pull/112216
* Fix RenderEditable not able to update backgroundCursorColor when the user provides a new one by @fzyzcjy in https://github.com/flutter/flutter/pull/112045
* `PerformanceOverlay`'s multiple fields are not updated when the user wants to update it by @fzyzcjy in https://github.com/flutter/flutter/pull/112039
* Add assertion to _CupertinoSwitchRenderObjectWidget, otherwise it is confusing why updateRenderObject omits state update by @fzyzcjy in https://github.com/flutter/flutter/pull/112044
* Fix CupertinoAlertDialog and CupertinoActionSheet, which mis-behave when orientation changes by @fzyzcjy in https://github.com/flutter/flutter/pull/112041
* Fix SliverScrollingPersistentHeader not able to update stretchConfiguration by @fzyzcjy in https://github.com/flutter/flutter/pull/112042
* Fix SliverPinnedPersistentHeader, also not able to update stretchConfiguration and showOnScreenConfiguration by @fzyzcjy in https://github.com/flutter/flutter/pull/112043
* Revert "Migrate package/flutter to JS static interop. (#111315)" by @CaseyHillers in https://github.com/flutter/flutter/pull/112247
* Update TabBarView children after a transition to an adjacent tab by @bleroux in https://github.com/flutter/flutter/pull/112168
* [Material] Remove "down position" from toggleable ripple calculation by @johnsonmh in https://github.com/flutter/flutter/pull/112209
* Updated `ProgressIndicator` to M3 by @QuncCccccc in https://github.com/flutter/flutter/pull/112139
* Added example for Magnifier and TextMagnifier by @antholeole in https://github.com/flutter/flutter/pull/110218
* Revert DraggableScrollableSheet controller changes by @CaseyHillers in https://github.com/flutter/flutter/pull/112293
* Add support for Material 3 `Divider` and `VerticalDivider` by @TahaTesser in https://github.com/flutter/flutter/pull/112378
* Expose text boundary combiner class by @chunhtai in https://github.com/flutter/flutter/pull/112085
* Revert "Add support for Material 3 `Divider` and `VerticalDivider`" by @CaseyHillers in https://github.com/flutter/flutter/pull/112471
* Change default text color of CupertinoAlertDialog to theme primary color by @MitchellGoodwin in https://github.com/flutter/flutter/pull/111785
* Fixes Text contrast test rect check by @chunhtai in https://github.com/flutter/flutter/pull/112492
* [framework] use Visibility instead of Opacity by @jonahwilliams in https://github.com/flutter/flutter/pull/112191
* Add regression test for TextPainter.getWordBoundary by @LongCatIsLooong in https://github.com/flutter/flutter/pull/112229
* Doc fix, followerAnchor changed to targetAnchor by @gazialankus in https://github.com/flutter/flutter/pull/112054
* [RawKeyboard] Allow inconsistent modifiers for iOS and Android by @dkwingsmt in https://github.com/flutter/flutter/pull/108926
* Add mouse region for InputDecorationIcons in the textfield by @hangyujin in https://github.com/flutter/flutter/pull/112543
* unnecessary_stateful_widgets by @a14n in https://github.com/flutter/flutter/pull/112296
* Reland "Fix DraggableScrollableSheet rebuilding during drag" by @moffatman in https://github.com/flutter/flutter/pull/112479
* Implement Material MenuBar and MenuAnchor by @gspencergoog in https://github.com/flutter/flutter/pull/112239
* [`RenderEditable`] report real height when `maxLines == 1`.  by @LongCatIsLooong in https://github.com/flutter/flutter/pull/112029
* fix some DSS bugs by @xu-baolin in https://github.com/flutter/flutter/pull/112142
* Reland "Migrate package/flutter to JS static interop. (#111315)" by @joshualitt in https://github.com/flutter/flutter/pull/112418
* Add `Dialog.fullscreen` and example by @TahaTesser in https://github.com/flutter/flutter/pull/112261
* Fixed the `CircularProgressIndicator` default size issue by @QuncCccccc in https://github.com/flutter/flutter/pull/112601
* Add support for Material 3 Divider and VerticalDivider by @darrenaustin in https://github.com/flutter/flutter/pull/112655
* Fix menu_anchor_test.dart's state leak by @gspencergoog in https://github.com/flutter/flutter/pull/112718
* Add button semantics in list tile by @hangyujin in https://github.com/flutter/flutter/pull/112593
* URI-decode asset paths before writing them to the asset manifest by @andrewkolos in https://github.com/flutter/flutter/pull/112415
* Revert "Add button semantics in list tile" by @CaseyHillers in https://github.com/flutter/flutter/pull/112779
* Added ShapeBorder to expansionTile by @DattatreyaReddy in https://github.com/flutter/flutter/pull/112218
* Update `AnimatedSlide` example by @TahaTesser in https://github.com/flutter/flutter/pull/112803
* [web] Fix `kIsWeb` for Dart2wasm. by @joshualitt in https://github.com/flutter/flutter/pull/112122
* [text_input] introduce TextInputControl by @jpnurmi in https://github.com/flutter/flutter/pull/76072
* Fix outdated comment about overflow by @Hixie in https://github.com/flutter/flutter/pull/112595
* Add width property to SnackBarThemeData by @esouthren in https://github.com/flutter/flutter/pull/112636
* Wait for non-empty layout in platform view placeholder by @stuartmorgan in https://github.com/flutter/flutter/pull/112402
* Export `elapseBlocking` to test binding, so slow sync work can be simulated such as a slow widget build by @fzyzcjy in https://github.com/flutter/flutter/pull/112619
* Switched `Element.renderObject` to iterative implementation. by @gaaclarke in https://github.com/flutter/flutter/pull/112885
* Add PointerScaleEvent and use in InteractiveViewer by @moffatman in https://github.com/flutter/flutter/pull/112172
* Consider Scrollable location in text selection drag events by @justinmc in https://github.com/flutter/flutter/pull/102992
* Add `overlay` MaterialStateProperty property to `Slider` by @TahaTesser in https://github.com/flutter/flutter/pull/112922
* Added keyboardType in CupertinoSearchTextField by @Hardeepsingh980 in https://github.com/flutter/flutter/pull/83994
* Schedule tasks which are futures to completion by @jiahaog in https://github.com/flutter/flutter/pull/112269
* typo by @MrBirb in https://github.com/flutter/flutter/pull/113043
* [framework] load files through ImmutableBuffer.fromFilePath (if exact file type) by @jonahwilliams in https://github.com/flutter/flutter/pull/112892
* Remove NavigationToolbar condition that leading widget cannot be larger than 1/3 the total space available. by @math1man in https://github.com/flutter/flutter/pull/112548
* shader warm up with canvaskit and corresponding test by @alanwutang11 in https://github.com/flutter/flutter/pull/113060
* Send text selection rects to engine on iPhone by @moffatman in https://github.com/flutter/flutter/pull/113048
* Add error message when lerping between TextStyles different `inherit` values by @LongCatIsLooong in https://github.com/flutter/flutter/pull/112837
* Add asset manifest parsing benchmark by @andrewkolos in https://github.com/flutter/flutter/pull/112836
* fix a CupertinoDatePicker bug by @xu-baolin in https://github.com/flutter/flutter/pull/112697
* Typo in border_test.dart by @MrBirb in https://github.com/flutter/flutter/pull/113046
* Add `SliverGrid.builder` constructor by @gspencergoog in https://github.com/flutter/flutter/pull/113116
* Fix TabBar with padding is not centered by @bleroux in https://github.com/flutter/flutter/pull/113091
* Add checkbox and radio menu buttons by @gspencergoog in https://github.com/flutter/flutter/pull/112821
* Add `SliverAnimatedGrid` and `AnimatedGrid` by @gspencergoog in https://github.com/flutter/flutter/pull/112982
* Deprecate `AnimatedListItemBuilder` and `AnimatedListRemovedItemBuilder`  by @gspencergoog in https://github.com/flutter/flutter/pull/113131
* `AutomatedTestWidgetsFlutterBinding.pump` provides wrong pump time stamp, probably because of forgetting the precision by @fzyzcjy in https://github.com/flutter/flutter/pull/112609
* Fix selection area causes small scrollables to bounce by @chunhtai in https://github.com/flutter/flutter/pull/112816
* [framework] add ignores for platformDispatcher deprecation by @jonahwilliams in https://github.com/flutter/flutter/pull/113238
* Minor change type nullability by @fzyzcjy in https://github.com/flutter/flutter/pull/112778
* Revert "Minor change type nullability" by @jmagman in https://github.com/flutter/flutter/pull/113246
* Support Material 3 in bottom sheet by @hangyujin in https://github.com/flutter/flutter/pull/112466
* Added `Switch` Animation for Material 3 by @QuncCccccc in https://github.com/flutter/flutter/pull/113090
* pushnamed can handle Object as type by @chunhtai in https://github.com/flutter/flutter/pull/113242
* Change type in `ImplicitlyAnimatedWidget` to remove type cast to improve performance and style by @fzyzcjy in https://github.com/flutter/flutter/pull/111849
* make ModalBottomSheetRoute public by @The-Redhat in https://github.com/flutter/flutter/pull/108112
* Document that TooltipTriggerMode has no impact on hovering by @bleroux in https://github.com/flutter/flutter/pull/113324
* Revert "`AutomatedTestWidgetsFlutterBinding.pump` provides wrong pump time stamp, probably because of forgetting the precision" by @XilaiZhang in https://github.com/flutter/flutter/pull/113415
* [web] Migrate selectable_region to static interop. by @joshualitt in https://github.com/flutter/flutter/pull/113292
* Make TextEditingDelta diagnosticable and override debugFillProperties for concrete TextEditingDelta implementations by @Renzo-Olivares in https://github.com/flutter/flutter/pull/113395
* fix overflow error in `CupertinoListTile` by @alex-sandri in https://github.com/flutter/flutter/pull/113010
* Added statesController to the button icon constructors. by @darrenaustin in https://github.com/flutter/flutter/pull/113419
* Fix bar height changes when toggle keyboard by @luckysmg in https://github.com/flutter/flutter/pull/106542
* fix permanent choice chip icon with material3 by @AbhiShake1 in https://github.com/flutter/flutter/pull/113485
* Fix typo of PrimaryScrollController documentation by @mono0926 in https://github.com/flutter/flutter/pull/113361
* Clean up `_updateSelectionRects`  by @LongCatIsLooong in https://github.com/flutter/flutter/pull/113425
* Reland "Single tap on the previous selection should toggle the toolbar on iOS #108913" by @Renzo-Olivares in https://github.com/flutter/flutter/pull/111995
* Add support for Alt to CharacterActivator, add tests by @gspencergoog in https://github.com/flutter/flutter/pull/113466
* [Docs] Clarify that Flex does not wrap by @TzviPM in https://github.com/flutter/flutter/pull/113404
* Fix StarBorder operator== by @gspencergoog in https://github.com/flutter/flutter/pull/113588
* Add HitTestBehavior to TapRegion by @gspencergoog in https://github.com/flutter/flutter/pull/113634
* Use ScrollbarTheme instead Theme for Scrollbar by @Oleh-Sv in https://github.com/flutter/flutter/pull/113237
* Add `AnimatedIcons` previews and examples by @TahaTesser in https://github.com/flutter/flutter/pull/113700
* Handle privatecommand messages that pass no data by @justinmc in https://github.com/flutter/flutter/pull/112590
* Revert "[text_input] introduce TextInputControl" by @zanderso in https://github.com/flutter/flutter/pull/113724
* Composing text shouldn't be part of undo/redo by @justinmc in https://github.com/flutter/flutter/pull/108765
* Overlay always applies clip by @chunhtai in https://github.com/flutter/flutter/pull/113770
* link "iOS PlatformView BackdropFilter design doc" in the BackdropFilter widget's documentation by @cyanglaz in https://github.com/flutter/flutter/pull/113779
* Add fontFamilyFallback to ThemeData by @justinmc in https://github.com/flutter/flutter/pull/112976
* Reland "[text_input] introduce TextInputControl" by @jpnurmi in https://github.com/flutter/flutter/pull/113758
* Use correct semantics for toggle buttons by @guidezpl in https://github.com/flutter/flutter/pull/113851
* [framework] re-rasterize when window size or insets changes by @jonahwilliams in https://github.com/flutter/flutter/pull/113647
* Fix selectWordsInRange when last word is located before the first word by @Renzo-Olivares in https://github.com/flutter/flutter/pull/113224
* Update Popup Menu to support Material 3 by @TahaTesser in https://github.com/flutter/flutter/pull/103606
* Scribble mixin by @justinmc in https://github.com/flutter/flutter/pull/104128
* Fix edge scrolling on platforms that select word by word on long press move by @Renzo-Olivares in https://github.com/flutter/flutter/pull/113128
* Updated tokens to v0.137. by @darrenaustin in https://github.com/flutter/flutter/pull/113970
* Fix ScrollPosition.isScrollingNotifier.value for pointer scrolling by @Piinks in https://github.com/flutter/flutter/pull/113972
* Improve Scrollbar drag behavior by @xu-baolin in https://github.com/flutter/flutter/pull/112434
* Fix `Slider` overlay and value indicator interactive behavior on desktop. by @TahaTesser in https://github.com/flutter/flutter/pull/113543
* Move `AnimatedIcons` example and fix typo in `cupertino/text_selection_toolbar.dart` by @TahaTesser in https://github.com/flutter/flutter/pull/113937
* Add Material 3 `ProgressIndicator` examples by @TahaTesser in https://github.com/flutter/flutter/pull/113950
* Fix an issue that Dragging the iOS text selection handles is jumpy and iOS text selection update incorrectly. by @ksballetba in https://github.com/flutter/flutter/pull/109136
* Page Up / Page Down in text fields by @tgucio in https://github.com/flutter/flutter/pull/107602
* Add Focus.parentNode to allow controlling the shape of the Focus tree. by @gspencergoog in https://github.com/flutter/flutter/pull/113655
* Hide debug logs from a MemoryAllocations test that intentionally throws an exception by @jason-simmons in https://github.com/flutter/flutter/pull/113786
* Add `clipBehavior`  and apply `borderRadius` to DataTable's Material by @TahaTesser in https://github.com/flutter/flutter/pull/113205
* Cache TextPainter plain text value to improve performance by @tgucio in https://github.com/flutter/flutter/pull/109841
* fix stretch effect with rtl support by @youssefali424 in https://github.com/flutter/flutter/pull/113214
* Replace menu defaults with tokens by @QuncCccccc in https://github.com/flutter/flutter/pull/113963
* Add parentNode to FocusScope widget by @gspencergoog in https://github.com/flutter/flutter/pull/114034
* Fix wasted memory caused by debug fields - 16 bytes per object (when adding that should-be-removed field crosses double-word alignment) by @fzyzcjy in https://github.com/flutter/flutter/pull/113927
* Fix text field label animation duration and curve by @Pourqavam in https://github.com/flutter/flutter/pull/105966
* M3 Text field UI update by @hangyujin in https://github.com/flutter/flutter/pull/113776
* Expose `alwaysShowMiddle` in `CupertinoSliverNavigationBar` by @campovski in https://github.com/flutter/flutter/pull/113544
* Provide test API for accessibility announcements by @nbayati in https://github.com/flutter/flutter/pull/109661
* Update Cupertino text input padding by @MitchellGoodwin in https://github.com/flutter/flutter/pull/113958
* Revert "Update Cupertino text input padding" by @zanderso in https://github.com/flutter/flutter/pull/114102
* 107866: Add support for verifying SemanticsNode ordering in widget tests by @pdblasi-google in https://github.com/flutter/flutter/pull/113133
* Remove deprecated `updateSemantics` API usage. by @a-wallen in https://github.com/flutter/flutter/pull/113382
* Fix logical error in TimePickerDialog - the RenderObject forgets to update fields by @fzyzcjy in https://github.com/flutter/flutter/pull/112040
* Remove RouteSetting.copyWith by @chunhtai in https://github.com/flutter/flutter/pull/113860
* Move Widget Inspector service extensions from DevTools to Flutter by @kenzieschmoll in https://github.com/flutter/flutter/pull/113861
* Fix DDS do not support Curves.easeInOutBack curve by @xu-baolin in https://github.com/flutter/flutter/pull/114222
* Fix Color Scheme Defaults in Material 3 by @QuncCccccc in https://github.com/flutter/flutter/pull/112666
* Context Menus by @justinmc in https://github.com/flutter/flutter/pull/107193
* SingleChildScrollView does not clip semantics child by @chunhtai in https://github.com/flutter/flutter/pull/114194
* Fix incorrectly named "debug" prefix by @fzyzcjy in https://github.com/flutter/flutter/pull/114117
* Add `maybeOf` for all the cases where `of` returns nullable. by @gspencergoog in https://github.com/flutter/flutter/pull/114120
* Added token files for badges and lists. by @darrenaustin in https://github.com/flutter/flutter/pull/114382
* 🎨 Improve exceptions thrown by asset bundle by @AlexV525 in https://github.com/flutter/flutter/pull/114313
* Minor code cleanup: remove redundant return by @fzyzcjy in https://github.com/flutter/flutter/pull/114290
* Add Material 3 support for BottomAppBar by @elbeicktalat in https://github.com/flutter/flutter/pull/106525
* Revert "Add Material 3 support for BottomAppBar" by @zanderso in https://github.com/flutter/flutter/pull/114421
* hintText TextOverflow by @justinmc in https://github.com/flutter/flutter/pull/114378
* Revert "Overlay always applies clip (#113770)" by @chunhtai in https://github.com/flutter/flutter/pull/114442
* Handle dragging improvements by @justinmc in https://github.com/flutter/flutter/pull/114042
* Add Material 3 Popup Menu example and update existing example by @TahaTesser in https://github.com/flutter/flutter/pull/114228
* `Layer ... was previously used as oldLayer` assertion error in debug mode, and page being blank in release mode, caused by LeaderLayer addToScene bug by @fzyzcjy in https://github.com/flutter/flutter/pull/113998
* Introduce debugWithActiveLayoutCleared to avoid duplicated code by @fzyzcjy in https://github.com/flutter/flutter/pull/114003
* Fix `addToScene` documentation by @fzyzcjy in https://github.com/flutter/flutter/pull/113987
* Fix bug that`timeDilation` is not reset, causing subsequent test errors, and add verifications to ensure such problem does not exist in the future by @fzyzcjy in https://github.com/flutter/flutter/pull/113830
* Add Material 3 support for `Slider` - Part 1 by @TahaTesser in https://github.com/flutter/flutter/pull/114079
* Add Material 3 support for BottomAppBar (reland #106525) by @darrenaustin in https://github.com/flutter/flutter/pull/114439
* [web] Changes to web keyboard selection shortcuts for more consistent behavior by @htoor3 in https://github.com/flutter/flutter/pull/114264
* Refactor Animated[List, Grid, SliverList, SliverGrid] to share common code by @Piinks in https://github.com/flutter/flutter/pull/113793
* fixes for incoming linter by @pq in https://github.com/flutter/flutter/pull/113794
* Revert "Scribble mixin" by @CaseyHillers in https://github.com/flutter/flutter/pull/114647
* Revert "Fix text field label animation duration and curve" by @CaseyHillers in https://github.com/flutter/flutter/pull/114646
* WidgetController.startGesture trackpad support by @moffatman in https://github.com/flutter/flutter/pull/114631
* Support keyboard selection in SelectabledRegion by @chunhtai in https://github.com/flutter/flutter/pull/112584
* [New Feature]Support mouse wheel event on the scrollbar widget by @xu-baolin in https://github.com/flutter/flutter/pull/109659
* Adds support for the Material Badge widget, BadgeTheme, BadgeThemeData by @HansMuller in https://github.com/flutter/flutter/pull/114560
* Revert "Adds support for the Material Badge widget, BadgeTheme, BadgeThemeData" by @HansMuller in https://github.com/flutter/flutter/pull/114819
* Delegate TestWindow.updateSemantics to the wrapped SingletonFlutterWindow by @jason-simmons in https://github.com/flutter/flutter/pull/114733
* Fix TextField/CupertinoTextField hint style overflow not work. by @ksballetba in https://github.com/flutter/flutter/pull/114335
* Mac Page Up / Page Down in text fields by @justinmc in https://github.com/flutter/flutter/pull/105497
* Reland "Scribble mixin" by @justinmc in https://github.com/flutter/flutter/pull/114698
* feat: [InteractiveViewer] provide a way to set the initial child's alignment by @pedromassango in https://github.com/flutter/flutter/pull/114745
* [RawKeyboard] Allow inconsistent modifiers for Web by @bleroux in https://github.com/flutter/flutter/pull/114499
* Use AppBar.systemOverlayStyle to style system navigation bar by @bleroux in https://github.com/flutter/flutter/pull/104827
* Fix `CastError` in `StadiumBorder.lerpTo` and  `StadiumBorder.lerpFrom` when using `BorderRadiusDirectional` by @gspencergoog in https://github.com/flutter/flutter/pull/114826
* Allow Flutter golden file tests to be flaky by @Piinks in https://github.com/flutter/flutter/pull/114450
* Refactor fix_data.yaml by @Piinks in https://github.com/flutter/flutter/pull/114192
* Revert "Allow Flutter golden file tests to be flaky" by @zanderso in https://github.com/flutter/flutter/pull/114902
* Update `CircleAvatar` to support Material 3 by @TahaTesser in https://github.com/flutter/flutter/pull/114812
* `updateSemantics` in TestWindow should always be implemented. by @a-wallen in https://github.com/flutter/flutter/pull/114857
* [cleanup] remove unnecessary brace in string interpolation by @pq in https://github.com/flutter/flutter/pull/115032
* Reland: Adds support for the Material Badge widget, BadgeTheme, BadgeThemeData (#114560) by @HansMuller in https://github.com/flutter/flutter/pull/115002
* Fix `RangeSlider` semantics node size by @TahaTesser in https://github.com/flutter/flutter/pull/114999
* Fix shrinkwrap on AnimatedList by @Piinks in https://github.com/flutter/flutter/pull/115104
* Load assets in flutter_test without turning event loop. by @dnfield in https://github.com/flutter/flutter/pull/115123
* Revert "Reland "Scribble mixin"" by @XilaiZhang in https://github.com/flutter/flutter/pull/115146
* Revert "Load assets in flutter_test without turning event loop." by @dnfield in https://github.com/flutter/flutter/pull/115156
* Make FutureBuilder handle SynchronousFuture correctly, reland SynchronousFuture usage in test assets by @dnfield in https://github.com/flutter/flutter/pull/115173
* M3 Segmented Button widget by @darrenaustin in https://github.com/flutter/flutter/pull/113723
* Fixed the color curve issue by @QuncCccccc in https://github.com/flutter/flutter/pull/115188
* Fix test in preparation of the Dart VM dropping support for language versions < 2.12.0 by @a-siva in https://github.com/flutter/flutter/pull/115176
* Incorrect rendering of `SnapshotWidget` by @fzyzcjy in https://github.com/flutter/flutter/pull/114400
* [Impeller] Add shader include with FlutterFragCoord for use by FragmentProgram by @bdero in https://github.com/flutter/flutter/pull/114214
* Include initial offset when using PlatformViewSurface by @bparrishMines in https://github.com/flutter/flutter/pull/114103
* Updated tokens to v0.141 by @darrenaustin in https://github.com/flutter/flutter/pull/115298
* Hint text semantics to be excluded in a11y read out if textfield is not empty and label text is provided  by @hangyujin in https://github.com/flutter/flutter/pull/115010
* Change button and label text to sentence case for Material 3 by @thkim1011 in https://github.com/flutter/flutter/pull/115187
* Add a way to customize padding in BottomAppBar  by @hangyujin in https://github.com/flutter/flutter/pull/115175
* Fix logic error in `markNeedsPaint` by @fzyzcjy in https://github.com/flutter/flutter/pull/112735
* Add `RestorableEnumN<T>` and `RestorableEnum<T>` to restorable primitive types by @gspencergoog in https://github.com/flutter/flutter/pull/115050
* Make Flutter Driver actively wait for runnable isolate by @jakubfijalkowski in https://github.com/flutter/flutter/pull/113969
* Updated instructions for adding new localized messages. by @harperl-lgtm in https://github.com/flutter/flutter/pull/115390
* Use concrete factory constructor for DomXMLHttpRequest by @srujzs in https://github.com/flutter/flutter/pull/115094
* Fixed label alignment by @QuncCccccc in https://github.com/flutter/flutter/pull/115409
* [framework] re-rasterize page transition when layout size changes by @jonahwilliams in https://github.com/flutter/flutter/pull/115371
* Remove unneeded comparison to `double.nan` by @asashour in https://github.com/flutter/flutter/pull/115470
* Added Badge.isLabelVisible flag by @HansMuller in https://github.com/flutter/flutter/pull/115292
* Added Badge.count constructor by @HansMuller in https://github.com/flutter/flutter/pull/115297
* Revert "Added Badge.count constructor" by @HansMuller in https://github.com/flutter/flutter/pull/115564
* Reland Added Badge.count constructor by @HansMuller in https://github.com/flutter/flutter/pull/115566
* Label should always be aligned with text in filled input decoration by @QuncCccccc in https://github.com/flutter/flutter/pull/115540
* Add selection feedback for both selection area and text field by @chunhtai in https://github.com/flutter/flutter/pull/115373
* Add Material 3 support for `Slider` - Part 2  by @TahaTesser in https://github.com/flutter/flutter/pull/114624
* Fixes a bug where dragging a collapsed handle in TextField does not v… by @chunhtai in https://github.com/flutter/flutter/pull/115586
* Improve showSnackBar documentation by @bleroux in https://github.com/flutter/flutter/pull/114612
* Update comments in theme data files by @hangyujin in https://github.com/flutter/flutter/pull/115603
* Use `double.isNaN` instead of `... == double.nan` (which is always false) by @mkustermann in https://github.com/flutter/flutter/pull/115424
* InkResponse highlights can be updated by @bleroux in https://github.com/flutter/flutter/pull/115635
* Disallow dispose during listener callback by @chunhtai in https://github.com/flutter/flutter/pull/114530
* Fix `NavigationBar` ripple by @TahaTesser in https://github.com/flutter/flutter/pull/115499
* Tiny improvement of RouteSettings display by @fzyzcjy in https://github.com/flutter/flutter/pull/114481
* Add more InkWell tests by @bleroux in https://github.com/flutter/flutter/pull/115634
* Remove unneeded comparison to `double.nan` by @asashour in https://github.com/flutter/flutter/pull/115547
* Fix formatting in BottomAppBar test by @bernaferrari in https://github.com/flutter/flutter/pull/115520
* Allows pushing page based route as pageless route by @chunhtai in https://github.com/flutter/flutter/pull/114362
* Material 3 navigation drawer by @hangyujin in https://github.com/flutter/flutter/pull/115668
* Add Spell Check to Editable Text (iOS) by @camsim99 in https://github.com/flutter/flutter/pull/110193
* Add clip option for navigator by @chunhtai in https://github.com/flutter/flutter/pull/115775
* [RawKeyboard] Fix Linux remapped CapsLock throws by @bleroux in https://github.com/flutter/flutter/pull/115009
* BouncingScrollPhysics should propagate decelerationRate by @moffatman in https://github.com/flutter/flutter/pull/115797
* Use the new pushImageFilter offset parameter to fix the transform of the children by @flar in https://github.com/flutter/flutter/pull/113673
* Revert "Use the new pushImageFilter offset parameter to fix the transform of the children" by @jonahwilliams in https://github.com/flutter/flutter/pull/115861
* Provide an option to update `Focus` semantics under `FocusableActionDetector` by @TahaTesser in https://github.com/flutter/flutter/pull/115833
* Update documentation for `PlatformException.stacktrace` by @ueman in https://github.com/flutter/flutter/pull/114028
* Use the new pushImageFilter offset parameter to fix the transform of the children by @flar in https://github.com/flutter/flutter/pull/115884
* Updated tokens to v0_143. by @darrenaustin in https://github.com/flutter/flutter/pull/115890
* Fix current day not being decorated when it was disabled for picking. by @jgoyvaerts in https://github.com/flutter/flutter/pull/115240
* TabBar should adjust scroll position when Controller is changed by @bleroux in https://github.com/flutter/flutter/pull/116019
* Fix iOS selectWordEdge doesn't account for affinity by @chunhtai in https://github.com/flutter/flutter/pull/115849
* Add `IndicatorShape` to `NavigationRailTheme` and fix indicator ripple. by @TahaTesser in https://github.com/flutter/flutter/pull/116108
* Reland Cupertino text input padding by @MitchellGoodwin in https://github.com/flutter/flutter/pull/115164
* Fix LayoutExplorer cycle by @LongCatIsLooong in https://github.com/flutter/flutter/pull/115526
* Tiny code cleanup: remove unnecessary comparisons by @fzyzcjy in https://github.com/flutter/flutter/pull/114488
* Menu bar accelerators by @gspencergoog in https://github.com/flutter/flutter/pull/114852
* Ignore NullThrownError deprecation by @mit-mit in https://github.com/flutter/flutter/pull/116135
* Disable backspace/delete handling on iOS & macOS by @LongCatIsLooong in https://github.com/flutter/flutter/pull/115900
* Update SnackBar to support Material 3 by @esouthren in https://github.com/flutter/flutter/pull/115750
* Revert "Update SnackBar to support Material 3" by @Piinks in https://github.com/flutter/flutter/pull/116199
* Use Isolate.run as implementation for compute by @dnfield in https://github.com/flutter/flutter/pull/115779
* iOS 16 context menu by @justinmc in https://github.com/flutter/flutter/pull/115805
* Create `DropdownMenu` Widget to Support Material 3 by @QuncCccccc in https://github.com/flutter/flutter/pull/116088
* Add Material 3 support for `TabBar` by @TahaTesser in https://github.com/flutter/flutter/pull/116110
* Add onFocusChange property for ListTile widget by @M97Chahboun in https://github.com/flutter/flutter/pull/111498
* labeledTapTargetGuideline should passe if textfield does not have label by @chunhtai in https://github.com/flutter/flutter/pull/116221
* Adjust Material 3 textfield padding to align with specs by @hangyujin in https://github.com/flutter/flutter/pull/116225
* Updated the M3 textTheme to use `onSurface` color for all styles. by @darrenaustin in https://github.com/flutter/flutter/pull/116125
* Fix Material 3 `BottomSheet` example by @TahaTesser in https://github.com/flutter/flutter/pull/116112
* Fix `Slider` semantics node size by @TahaTesser in https://github.com/flutter/flutter/pull/115285
* Updated `useMaterial3` documentation to include missing M3 components. by @darrenaustin in https://github.com/flutter/flutter/pull/116234
* Remove shrinkWrap from samples that don't need it by @goderbauer in https://github.com/flutter/flutter/pull/116236
* Revert "Add Material 3 support for `TabBar`" by @guidezpl in https://github.com/flutter/flutter/pull/116273
* [Reland] Add Material 3 support for `TabBar` by @TahaTesser in https://github.com/flutter/flutter/pull/116283
* M3 snackbar [re-land] by @esouthren in https://github.com/flutter/flutter/pull/116218
* Revert "Fix `Slider` semantics node size" by @CaseyHillers in https://github.com/flutter/flutter/pull/116294
* Update CupertinoContextMenu to iOS 16 visuals by @MitchellGoodwin in https://github.com/flutter/flutter/pull/110616
* Add Material 3 `Slider` example by @TahaTesser in https://github.com/flutter/flutter/pull/115638
* Added `controller` and `onSelected` properties to DropdownMenu by @QuncCccccc in https://github.com/flutter/flutter/pull/116259
* Revert "iOS 16 context menu" due to theme color mix up by @justinmc in https://github.com/flutter/flutter/pull/116312
* Add clarification to CupertinoUserInterfaceLevel docs by @MitchellGoodwin in https://github.com/flutter/flutter/pull/116371
* [CP] Fix Snackbar TalkBack regression by @zanderso in https://github.com/flutter/flutter/pull/116608
* Fix scroll jump when NestedScrollPosition is inertia-cancelled. (#116… by @Piinks in https://github.com/flutter/flutter/pull/117343
* Fix `NavigationRail` highlight (#117320) by @Piinks in https://github.com/flutter/flutter/pull/117344
* Fix `InkRipple` doesn't respect `rectCallback` when rendering ink cir… by @Piinks in https://github.com/flutter/flutter/pull/117500
### Tooling
* [flutter_tools] [dap] Add support for passing env variables to spawned processes by @DanTup in https://github.com/flutter/flutter/pull/107415
* [flutter_tools] Replace android v2 embedding broken doc link by @RoyARG02 in https://github.com/flutter/flutter/pull/107456
* Improve coverage speed by using new caching option for package:coverage by @jensjoha in https://github.com/flutter/flutter/pull/107395
* Check for analyzer rule names instead of descriptions in a flutter_tools test by @jason-simmons in https://github.com/flutter/flutter/pull/107541
* [flutter_tools] Catch more general XmlException rather than XmlParserException by @christopherfujino in https://github.com/flutter/flutter/pull/107574
* [flutter_tools] Make android gradle builder test hermetic by @christopherfujino in https://github.com/flutter/flutter/pull/107606
* Add `UIApplicationSupportsIndirectInputEvents` migration by @moffatman in https://github.com/flutter/flutter/pull/106889
* Check device type using platformType instead of type check to support proxied devices. by @chingjun in https://github.com/flutter/flutter/pull/107618
* [Windows] Remove the usage of `SETLOCAL ENABLEDELAYEDEXPANSION` from bat scripts. by @moko256 in https://github.com/flutter/flutter/pull/106861
* Increase app minimum supported macOS version from 10.11 to 10.13 by @jmagman in https://github.com/flutter/flutter/pull/107689
* [gen_l10n] Throw error when arb file does not exist by @thkim1011 in https://github.com/flutter/flutter/pull/107583
* [flutter_tools] fix RangeError in gen-l10n by checking for empty string by @christopherfujino in https://github.com/flutter/flutter/pull/107604
* [flutter_tools] Migrate commands.shard/hermetic/doctor_test to null-safety and make hermetic by @christopherfujino in https://github.com/flutter/flutter/pull/107670
* Read dart_plugin_registrant path from FlutterProject to support non-standard path. by @chingjun in https://github.com/flutter/flutter/pull/107617
* Pass device-user in machine mode by @chingjun in https://github.com/flutter/flutter/pull/107747
* Pub dependencies project validator by @Jasguerrero in https://github.com/flutter/flutter/pull/106895
* [flutter_tools] Remove shuffle from doctor test by @christopherfujino in https://github.com/flutter/flutter/pull/107744
* [flutter_tools] migrate clean_test to null-safety by @christopherfujino in https://github.com/flutter/flutter/pull/107750
* Revert "Read dart_plugin_registrant path from FlutterProject to support non-standard path." by @christopherfujino in https://github.com/flutter/flutter/pull/107850
* [flutter_tools] Fix null check errors in attach command by @christopherfujino in https://github.com/flutter/flutter/pull/107864
* [flutter_tool] Allow includes relative to shader path by @zanderso in https://github.com/flutter/flutter/pull/107862
* Provide more useful error message if a non-compliant DAP tool (or user) sends bad input to DAP server by @DanTup in https://github.com/flutter/flutter/pull/107827
* [web][debug] Remove RequireJS timeouts for debug builds. by @ditman in https://github.com/flutter/flutter/pull/107868
* Dart registrant location by @chingjun in https://github.com/flutter/flutter/pull/107967
* Check for bad characters in path on Windows build by @yaakovschectman in https://github.com/flutter/flutter/pull/107949
* check for pubspec instead of lib/ by @Jasguerrero in https://github.com/flutter/flutter/pull/107968
* [flutter_tools] add more debugging when pub get fails by @christopherfujino in https://github.com/flutter/flutter/pull/108062
* Remove outdated Fuchsia concepts by @richkadel in https://github.com/flutter/flutter/pull/107335
* [flutter_tools] Remove unused parameter when connecting DAP to VM Service by @DanTup in https://github.com/flutter/flutter/pull/108285
* [iOS] Update template icons by @RockerFlower in https://github.com/flutter/flutter/pull/107873
* Upgrade Gradle and AGP versions to 7.5/7.2 and migrate examples/tests by @GaryQian in https://github.com/flutter/flutter/pull/108197
* Revert "Upgrade Gradle and AGP versions to 7.5/7.2 and migrate examples/tests" by @zanderso in https://github.com/flutter/flutter/pull/108349
* [flutter_tools] Remove more shuffles by @christopherfujino in https://github.com/flutter/flutter/pull/107759
* [flutter_tools] [dap] Ensure DAP sends app.stop/app.detach during terminate by @DanTup in https://github.com/flutter/flutter/pull/108310
* Only show iOS simulators, reduce output spew in verbose by @jmagman in https://github.com/flutter/flutter/pull/108345
* Set Xcode build script phases to always run by @jmagman in https://github.com/flutter/flutter/pull/108331
* Only run `pod install` on the first iOS build by @jmagman in https://github.com/flutter/flutter/pull/108205
* [flutter_tools] Suggest actions to fix failing `FlutterValidator` by @RoyARG02 in https://github.com/flutter/flutter/pull/106355
* [gen_l10n] Warn users when placeholder types are converted to 'num' when using pluralization by @thkim1011 in https://github.com/flutter/flutter/pull/108036
* Handle updated error message when iOS device is locked by @jmagman in https://github.com/flutter/flutter/pull/108057
* Reland "Upgrade Gradle and AGP versions to 7.5/7.2 and migrate benchmarks+examples" by @GaryQian in https://github.com/flutter/flutter/pull/108355
* Revert "Reland "Upgrade Gradle and AGP versions to 7.5/7.2 and migrate benchmarks+examples"" by @zanderso in https://github.com/flutter/flutter/pull/108407
* [flutter_tool] Include impellerc output in ShaderCompilerException by @zanderso in https://github.com/flutter/flutter/pull/108348
* Reland "Upgrade Gradle and AGP versions to 7.5/7.2 and migrate benchmarks+examples" #108355 by @GaryQian in https://github.com/flutter/flutter/pull/108472
* Revert "Reland "Upgrade Gradle and AGP versions to 7.5/7.2 and migrate benchmarks+examples" #108355" by @Piinks in https://github.com/flutter/flutter/pull/108488
* Unify analysis options by @goderbauer in https://github.com/flutter/flutter/pull/108462
* Reland "Upgrade Gradle and AGP versions to 7.5/7.2 and migrate benchmarks+examples" #108472 by @GaryQian in https://github.com/flutter/flutter/pull/108510
* Remove doc for --ignore-deprecation and check for pubspec before v1 embedding check by @GaryQian in https://github.com/flutter/flutter/pull/108523
* [flutter_tools] join flutter specific with home cache by @Jasguerrero in https://github.com/flutter/flutter/pull/105343
* Ignore body_might_complete_normally_catch_error violations by @srawlins in https://github.com/flutter/flutter/pull/106563
* Add usage event when iOS app is archived by @jmagman in https://github.com/flutter/flutter/pull/108643
* Add usage event when macOS app is archived by @jmagman in https://github.com/flutter/flutter/pull/108651
* Use `hasNoRemainingExpectations` matcher for fake process manager in tool tests by @jmagman in https://github.com/flutter/flutter/pull/108649
* [flutter_tools] Test that DAP process terminates at the end of a session by @DanTup in https://github.com/flutter/flutter/pull/108301
* fix noop toString() diagnostics by @pq in https://github.com/flutter/flutter/pull/108836
* [flutter_tools] Migrate more tool tests to null-safety by @christopherfujino in https://github.com/flutter/flutter/pull/108639
* fix flutter not finding custom device by @ardera in https://github.com/flutter/flutter/pull/108884
* [web] Add onEntrypointLoaded to FlutterLoader. by @ditman in https://github.com/flutter/flutter/pull/108776
* Add avoid_redundant_argument_values ignores back by @goderbauer in https://github.com/flutter/flutter/pull/108984
* Plugin FFI template bump ffigen to 6.0.1 by @dcharkes in https://github.com/flutter/flutter/pull/108792
* [flutter_tools] refactor stringsArg by @amanv8060 in https://github.com/flutter/flutter/pull/105032
* [flutter_tools] ensure setAssetDirectory uses windows path by @jonahwilliams in https://github.com/flutter/flutter/pull/109021
* Update packages by @guidezpl in https://github.com/flutter/flutter/pull/109054
* Add quotes to Gradle NDK version error message by @dcharkes in https://github.com/flutter/flutter/pull/109026
* [flutter_tools] support hot reload of font assets by @jonahwilliams in https://github.com/flutter/flutter/pull/109091
* [flutter_tools] Fix tool crash for map cast by @dnys1 in https://github.com/flutter/flutter/pull/107648
* [flutter_tools] Adds test of impellerc output file mode by @zanderso in https://github.com/flutter/flutter/pull/109190
* Add info project validator status by @Jasguerrero in https://github.com/flutter/flutter/pull/109169
* [flutter_tools] Fix race condition with completer in devfs_web by @christopherfujino in https://github.com/flutter/flutter/pull/109059
* Disable jank metrics for web by @Jasguerrero in https://github.com/flutter/flutter/pull/109356
* Fix Transporter app name in log after upload by @xvrh in https://github.com/flutter/flutter/pull/107414
* Free library even if proc lookup fails by @verath in https://github.com/flutter/flutter/pull/108312
* [flutter_tools] Pin path_provider_android by @christopherfujino in https://github.com/flutter/flutter/pull/109429
* Remove deprecated Ruby File.exists? in helper script by @jmagman in https://github.com/flutter/flutter/pull/109428
* Update `flutter.gradle` AGP to 7.2.0 and bump default NDK version by @GaryQian in https://github.com/flutter/flutter/pull/109211
* Introduce stubbed `exclusive` parameter to `File.create`-overridden method by @aam in https://github.com/flutter/flutter/pull/109646
* [flutter_tools] Make flutter test -v print timing of different phases by @jensjoha in https://github.com/flutter/flutter/pull/108864
* Generate syntax for plugin registration that works both with and without null safety. by @eyebrowsoffire in https://github.com/flutter/flutter/pull/109480
* Temporarily remove a bogus warning until fixed by dwds update by @annagrin in https://github.com/flutter/flutter/pull/109793
* remove passing --debugger-module-names to frontend server by @annagrin in https://github.com/flutter/flutter/pull/109791
* [gen_l10n] Add option to format generated localizations files by @thkim1011 in https://github.com/flutter/flutter/pull/109171
* add GeneralInfo project validator to analyze --suggestions by @Jasguerrero in https://github.com/flutter/flutter/pull/109874
* [flutter_tools] Enable custom devices on all channels by @zanderso in https://github.com/flutter/flutter/pull/109953
* [flutter_tools] Fix _CastError in HotRunner._resetDirtyAssets by @christopherfujino in https://github.com/flutter/flutter/pull/108771
* [dap] Don't wait for appStarted before responding to launch/attach + don't call app.stop for unstarted app by @DanTup in https://github.com/flutter/flutter/pull/109386
* FFI plugin bump FFIgen to 6.1.2 by @dcharkes in https://github.com/flutter/flutter/pull/110246
* [flutter_tools] unpin path_provider_android and roll by @christopherfujino in https://github.com/flutter/flutter/pull/110216
* [web] fix hot restart in entrypoint generated by `flutter create` by @yjbanov in https://github.com/flutter/flutter/pull/110229
* [flutter_tools] migrate some files to null safety by @jonahwilliams in https://github.com/flutter/flutter/pull/110354
* Show output from `pub get` in `flutter pub get` by @sigurdm in https://github.com/flutter/flutter/pull/106300
* Revert "Show output from `pub get` in `flutter pub get`" by @zanderso in https://github.com/flutter/flutter/pull/110478
* [flutter_tools] Pull more arm64 artifacts on Apple Silicon by @zanderso in https://github.com/flutter/flutter/pull/110291
* [flutter_tools] migrate gradle errors and project test to null safety by @jonahwilliams in https://github.com/flutter/flutter/pull/110530
* [Windows] Hide app until first frame is drawn by @loic-sharma in https://github.com/flutter/flutter/pull/109816
* [Windows] add generated plugins ignores by @hlwhl in https://github.com/flutter/flutter/pull/109973
* Support single arch local engines for 'build macos-framework' and 'ios-framework' by @jmagman in https://github.com/flutter/flutter/pull/110564
* Make module tests pass on Xcode 14 by @jmagman in https://github.com/flutter/flutter/pull/110556
* Use UriConverter from context for test by @helin24 in https://github.com/flutter/flutter/pull/110539
* [flutter_tools] Generate Localizations on `flutter run` for web by @thkim1011 in https://github.com/flutter/flutter/pull/110526
* Track platform in MigratePlaformConfig and enforce metadata file being provided by @GaryQian in https://github.com/flutter/flutter/pull/110540
* [flutter_tools] change the way version is calculated on master by @christopherfujino in https://github.com/flutter/flutter/pull/110791
* [tool] Fix flutter.js regression with hot-reload on promise-based init. by @ditman in https://github.com/flutter/flutter/pull/110805
* Delete errant .packages by @guidezpl in https://github.com/flutter/flutter/pull/110749
* Bump android SDK to 33 by @GaryQian in https://github.com/flutter/flutter/pull/109583
* [flutter_tools] Instantiate shutdown hooks before localfilesystem by @christopherfujino in https://github.com/flutter/flutter/pull/110693
* Manually update DWDS version to `v.16.0.0` by @elliette in https://github.com/flutter/flutter/pull/110822
* Update issue reference for skipped hot restart tests by @annagrin in https://github.com/flutter/flutter/pull/110881
* [Windows] Use dark title bar on dark system theme by @loic-sharma in https://github.com/flutter/flutter/pull/110615
* Revert "[Windows] Use dark title bar on dark system theme" by @jmagman in https://github.com/flutter/flutter/pull/110890
* Feat: dSYM debug info for iOS & macOS builds by @vaind in https://github.com/flutter/flutter/pull/101586
* Null safety migration of packages/flutter_tools/test/commands.shard/permeable by @liamappelbe in https://github.com/flutter/flutter/pull/110710
* Null safety migration of packages/flutter_tools/test/commands.shard/hermetic, part 3/3 by @liamappelbe in https://github.com/flutter/flutter/pull/110709
* Null safety migration of packages/flutter_tools/test/commands.shard/hermetic, part 2/3 by @liamappelbe in https://github.com/flutter/flutter/pull/110708
* Null safety migration of packages/flutter_tools/test/web.shard by @liamappelbe in https://github.com/flutter/flutter/pull/110713
* Null safety migration of packages/flutter_tools/test/commands.shard/hermetic, part 1/3 by @liamappelbe in https://github.com/flutter/flutter/pull/110707
* Update null safety warnings in prep for Dart 3 by @mit-mit in https://github.com/flutter/flutter/pull/110998
* Null safety migration of packages/flutter_tools/test/general.shard, part 2/2 by @liamappelbe in https://github.com/flutter/flutter/pull/110712
* Reland: Show output from pub get in flutter pub get by @sigurdm in https://github.com/flutter/flutter/pull/110851
* Windows version check in doctor by @eliasyishak in https://github.com/flutter/flutter/pull/110013
* Null safety migration of packages/flutter_tools/test/general.shard, part 1/2 by @liamappelbe in https://github.com/flutter/flutter/pull/110711
* [flutter_tools] add test debugging for #111272 by @christopherfujino in https://github.com/flutter/flutter/pull/111280
* refactor: strip all local symbols from macOS and iOS App.framework - reduces app size by @vaind in https://github.com/flutter/flutter/pull/111264
* Remove .pub directories from iml templates by @natebosch in https://github.com/flutter/flutter/pull/109622
* [Windows] Use dark title bar on dark system theme by @loic-sharma in https://github.com/flutter/flutter/pull/111042
* [flutter_tools] Pin url_launcher_android and update packages by @christopherfujino in https://github.com/flutter/flutter/pull/111309
* [flutter_tools] filter "Resolving dependencies..." from dart pub get output to fix test flakiness by @christopherfujino in https://github.com/flutter/flutter/pull/111312
* Null safety migration of packages/flutter_tools/bin by @liamappelbe in https://github.com/flutter/flutter/pull/110706
* Revert "Null safety migration of packages/flutter_tools/bin" by @zanderso in https://github.com/flutter/flutter/pull/111506
* let the plugin's output generated in flutter/.android/plugins_build_output/${androidPlugin.name} by @chunfengyao in https://github.com/flutter/flutter/pull/94645
* error handling when path to dir provided instead of file by @eliasyishak in https://github.com/flutter/flutter/pull/109796
* [flutter_tools] reduce doctor timeout to debug 111686 by @christopherfujino in https://github.com/flutter/flutter/pull/111687
* [flutter_tools] fix AndroidSdk.reinitialize bad state error by @christopherfujino in https://github.com/flutter/flutter/pull/111527
* Return null rather than fall off nullable onError catchError handler. by @srawlins in https://github.com/flutter/flutter/pull/111581
* Do not codesign transitive dependency iOS pod resource bundles by @jmagman in https://github.com/flutter/flutter/pull/111714
* Reland "Null safety migration of packages/flutter_tools/bin" by @liamappelbe in https://github.com/flutter/flutter/pull/111756
* Startup flutter faster (faster wrapper script on Windows) by @jensjoha in https://github.com/flutter/flutter/pull/111465
* Startup `flutter` faster (Only access globals.deviceManager if actually setting something) by @jensjoha in https://github.com/flutter/flutter/pull/111461
* Startup `flutter` faster (use app-jit snapshot) by @jensjoha in https://github.com/flutter/flutter/pull/111459
* fix for flakey analyze test by @eliasyishak in https://github.com/flutter/flutter/pull/111895
* [flutter_tools] Fix type error in ChromiumDevice.startApp by @christopherfujino in https://github.com/flutter/flutter/pull/111935
* Refactor `DeviceManager.findTargetDevices()` and `FlutterCommand.findAllTargetDevices()`, and add a flag to not show prompt. by @chingjun in https://github.com/flutter/flutter/pull/112223
* [tool] Proposal to support dart define config from a json file by @hai046 in https://github.com/flutter/flutter/pull/108098
* Fix null safety error in fuchsia_tester.dart by @liamappelbe in https://github.com/flutter/flutter/pull/112414
* Tighten asset variant detection criteria to only include device-pixel-ratio variants by @andrewkolos in https://github.com/flutter/flutter/pull/110721
* Use directory exists instead of path.dirname by @Jasguerrero in https://github.com/flutter/flutter/pull/112219
* Treat assets as variants only if they share the same filename by @jason-simmons in https://github.com/flutter/flutter/pull/112602
* Send progress notifications to clients during hot reload / hot restart by @DanTup in https://github.com/flutter/flutter/pull/112455
* Migrate flutter_tools to use package:coverage by @liamappelbe in https://github.com/flutter/flutter/pull/111681
* Return ErrorHandlingFileSystem backed objects in ErrorHandlingFileSystem file/directory APIs by @jason-simmons in https://github.com/flutter/flutter/pull/112673
* [flutter_tools] cache more directories by @jonahwilliams in https://github.com/flutter/flutter/pull/112651
* [flutter_tools] analyze --suggestions --machine command by @GaryQian in https://github.com/flutter/flutter/pull/112217
* Turn off bitcode in existing iOS Xcode projects by @jmagman in https://github.com/flutter/flutter/pull/112828
* Stop embedding bitcode for iOS in tool by @jmagman in https://github.com/flutter/flutter/pull/112831
* Revert file naming convention of .aar files to support fuzzy matching in build.gradle by @JunhuaLin in https://github.com/flutter/flutter/pull/112149
* Return void from project migrate() by @jmagman in https://github.com/flutter/flutter/pull/112897
* improve debugging when dart pub get call fails by @christopherfujino in https://github.com/flutter/flutter/pull/112968
* When updating packages, do not delete the simulated SDK directory until all pub invocations have finished by @jason-simmons in https://github.com/flutter/flutter/pull/112975
* Add bitcode deprecation note for add-to-app iOS developers by @jmagman in https://github.com/flutter/flutter/pull/112900
* Upgrade targetSdkVersion and compileSdkVersion to 33 by @GaryQian in https://github.com/flutter/flutter/pull/112936
* Revert "Upgrade targetSdkVersion and compileSdkVersion to 33" by @zanderso in https://github.com/flutter/flutter/pull/113064
* [flutter_tool] Don't download CanvasKit if it's already in flutter_web_sdk by @hterkelsen in https://github.com/flutter/flutter/pull/113072
* Fix for Issue #112983 by @domesticmouse in https://github.com/flutter/flutter/pull/112985
* Scramble order of operations of flutter.gradle by @GaryQian in https://github.com/flutter/flutter/pull/111747
* BufferLogger should log stacktrace by @jmagman in https://github.com/flutter/flutter/pull/113240
* Write crash report in temp directory if writing to CWD failed. by @chingjun in https://github.com/flutter/flutter/pull/113316
* Fix Android Studio version string nullablity, fake AndroidStudio in test by @jmagman in https://github.com/flutter/flutter/pull/113295
* Enable impeller flags for iOS simulator by @jmagman in https://github.com/flutter/flutter/pull/113350
* Make AndroidApk nullable in stopApp. by @chingjun in https://github.com/flutter/flutter/pull/113353
* Handle null exception case in ProxiedDevice.stopApp. by @chingjun in https://github.com/flutter/flutter/pull/113317
* Support the --no-devtools flag in "flutter run --machine" by @jason-simmons in https://github.com/flutter/flutter/pull/113414
* Show Xcode compilation errors at end of build, suppress stdout and stderr from Xcode by @jmagman in https://github.com/flutter/flutter/pull/113302
* [tool] ⚡️ Install the corresponding APK in `flutter run` by @AlexV525 in https://github.com/flutter/flutter/pull/112768
* Revert "[tool] ⚡️ Install the corresponding APK in `flutter run`" by @godofredoc in https://github.com/flutter/flutter/pull/113614
* Dependency injection Attach command by @Jasguerrero in https://github.com/flutter/flutter/pull/113227
* Remove Swift plugin Objective-C files by @jmagman in https://github.com/flutter/flutter/pull/113585
* Terminate simulator app on "q" by @jmagman in https://github.com/flutter/flutter/pull/113581
* [tool] Install the corresponding APK in `flutter run` by @AlexV525 in https://github.com/flutter/flutter/pull/113622
* [Impeller] Build Impeller iOS runtime stage shaders when Impeller is enabled by @bdero in https://github.com/flutter/flutter/pull/113689
* [flutter_tools] Implement NotifyingLogger.supportsColor by @christopherfujino in https://github.com/flutter/flutter/pull/113635
* Validate bins on path in doctor by @christopherfujino in https://github.com/flutter/flutter/pull/113106
* [web] Use TrustedTypes in flutter.js and other tools by @ditman in https://github.com/flutter/flutter/pull/112969
* Avoid creating map literal in `flutter.gradle` multidex check by @GaryQian in https://github.com/flutter/flutter/pull/113845
* Fix --local-engine for the new web/wasm mode by @mdebbar in https://github.com/flutter/flutter/pull/113759
* Add --empty to the flutter create command by @gspencergoog in https://github.com/flutter/flutter/pull/113873
* Add branch coverage to flutter test by @liamappelbe in https://github.com/flutter/flutter/pull/113802
* Add support for expression compilation when debugging integration tests by @DanTup in https://github.com/flutter/flutter/pull/113481
* Upgrade gradle for flutter tool to 7.3.0 by @GaryQian in https://github.com/flutter/flutter/pull/114023
* [macOS] Flavors project throws `no flavor specified` for creating a project. by @a-wallen in https://github.com/flutter/flutter/pull/113979
* Check for watch companion in build settings by @vashworth in https://github.com/flutter/flutter/pull/113956
* Revert "Check for watch companion in build settings" by @jmagman in https://github.com/flutter/flutter/pull/114035
* Don't specify libraries-spec argument if we are passing a platform dill. by @eyebrowsoffire in https://github.com/flutter/flutter/pull/114045
* [flutter_tools] Decouple fatal-warnings check from fatal-infos by @lubritto in https://github.com/flutter/flutter/pull/113748
* Revert part of "Terminate simulator app on "q" (#113581)" by @jmagman in https://github.com/flutter/flutter/pull/114083
* [flutter_tools] allow flutter drive to take screenshots when sent a terminating signal by @christopherfujino in https://github.com/flutter/flutter/pull/114118
* Fix typo in flutter.gradle by @akhial in https://github.com/flutter/flutter/pull/114143
* Check for watch companion in build settings by @vashworth in https://github.com/flutter/flutter/pull/114078
* Terminate simulator app on "q" by @jmagman in https://github.com/flutter/flutter/pull/114114
* Make `Logger` required when injected in flutter_tool by @jmagman in https://github.com/flutter/flutter/pull/114111
* Fix NPE in coverage collector by @liamappelbe in https://github.com/flutter/flutter/pull/114177
* [flutter_tools] Add support for compiling shaders to JSON bundle for web by @jonahwilliams in https://github.com/flutter/flutter/pull/114295
* Delete flutter_migrate code by @GaryQian in https://github.com/flutter/flutter/pull/114253
* [flutter_tools] Introducing arg option for specifying the output directory for web by @eliasyishak in https://github.com/flutter/flutter/pull/113076
* Always invoke impeller ios shader target by @jonahwilliams in https://github.com/flutter/flutter/pull/114451
* [flutter_tools/dap] Map org-dartlang-sdk URIs to the location of the source files found by the analyzer by @DanTup in https://github.com/flutter/flutter/pull/114369
* [flutter_tools/dap] Add a base Flutter adapter class to avoid duplication between adapters by @DanTup in https://github.com/flutter/flutter/pull/114533
* [flutter_tools] provide --timeout option to flutter drive by @christopherfujino in https://github.com/flutter/flutter/pull/114458
* [tools]validation basic Xcode settings for build ipa by @hellohuanlin in https://github.com/flutter/flutter/pull/113412
* Revert "[tools]validation basic Xcode settings for build ipa" by @zanderso in https://github.com/flutter/flutter/pull/114615
* Do not assume that pub is the first command run by "flutter create" by @jason-simmons in https://github.com/flutter/flutter/pull/114621
* [tools]reland validation basic Xcode settings for build ipa by @hellohuanlin in https://github.com/flutter/flutter/pull/114634
* Change some required nullable parameters in tool to non-null by @jmagman in https://github.com/flutter/flutter/pull/114115
* Switch the way we retrieve the vm_service_port from /hub to iquery, on device. by @naudzghebre in https://github.com/flutter/flutter/pull/114637
* Revert "Switch the way we retrieve the vm_service_port from /hub to i… by @cbracken in https://github.com/flutter/flutter/pull/114715
* ICU Message Syntax Parser by @thkim1011 in https://github.com/flutter/flutter/pull/112390
* Fix macOS migration nothing-to-upgrade test by @cbracken in https://github.com/flutter/flutter/pull/114703
* Increase minimum supported macOS version from 10.13 to 10.14 by @cbracken in https://github.com/flutter/flutter/pull/114713
* when getting xcworkspace, exclude hidden files by @vashworth in https://github.com/flutter/flutter/pull/114099
* [flutter_tools] add compilation failure tests for new cases added in impellerc by @jonahwilliams in https://github.com/flutter/flutter/pull/114757
* Switch the way we retrieve the vm_service_port from /hub to iquery, on device. by @naudzghebre in https://github.com/flutter/flutter/pull/114834
* [tool] Support `--flavor` option for `flutter install`. by @a-wallen in https://github.com/flutter/flutter/pull/114048
* Build command dependency injection by @Jasguerrero in https://github.com/flutter/flutter/pull/114383
* Apply multidex config in kotlin dsl gradle file by @GaryQian in https://github.com/flutter/flutter/pull/114660
* Add more supported simulator debugging options and improve tests by @vashworth in https://github.com/flutter/flutter/pull/114628
* [flutter_tools/dap] Add support for forwarding `flutter run --machine` exposeUrl requests to the DAP client by @DanTup in https://github.com/flutter/flutter/pull/114539
* Roll ios-deploy iOS artifact to arm slice version by @jmagman in https://github.com/flutter/flutter/pull/115042
* Prevent tests from producing dill files alongside the test file by @DanTup in https://github.com/flutter/flutter/pull/115075
* Include stdout in codesign failure output by @jmagman in https://github.com/flutter/flutter/pull/115115
* chore: enable Flutter Android workflow on aarch64 by @TheOneWithTheBraid in https://github.com/flutter/flutter/pull/113829
* Explicitly call out documentation links in "flutter create" by @Hixie in https://github.com/flutter/flutter/pull/114181
* [flutter_tools] support github reporter by @jonahwilliams in https://github.com/flutter/flutter/pull/115137
* [flutter_tools] Fix so that the value set by `--dart-define-from-file` can be passed to Gradle by @blendthink in https://github.com/flutter/flutter/pull/114297
* [web] Add `--local-web-sdk` flag and use precompiled platform kernels for dart2js and ddc by @eyebrowsoffire in https://github.com/flutter/flutter/pull/114639
* Revert "[web] Add `--local-web-sdk` flag and use precompiled platform kernels for dart2js and ddc" by @jonahwilliams in https://github.com/flutter/flutter/pull/115242
* Do not strip architecture suffixes from host local-engine by @jmagman in https://github.com/flutter/flutter/pull/115320
* [flutter_tools] add uint compilation test by @jonahwilliams in https://github.com/flutter/flutter/pull/115317
* [tools] Fix plugin_ffi template lint violation by @dcharkes in https://github.com/flutter/flutter/pull/115356
* Remove dev channel reference from build ios-frameworks error by @jmagman in https://github.com/flutter/flutter/pull/115166
* Create a main alias for master channel. by @godofredoc in https://github.com/flutter/flutter/pull/115388
* removing default values for [reporter] and [timeout] in flutter test by @eliasyishak in https://github.com/flutter/flutter/pull/115160
* [flutter_tools] remove all body_might_complete_normally_catch_error ignores by @christopherfujino in https://github.com/flutter/flutter/pull/115184
* [tools]build ipa validate template icon files by @hellohuanlin in https://github.com/flutter/flutter/pull/114841
* Remove redundant arguments passed to redirecting factory constructors by @srawlins in https://github.com/flutter/flutter/pull/115497
* Rev package:pub_semver to the latest version by @devoncarew in https://github.com/flutter/flutter/pull/115570
* [flutter_tools] Pin package:archive and manual roll by @christopherfujino in https://github.com/flutter/flutter/pull/115662
* [flutter_tools] Add flutter update-packages --synthetic-package-path by @christopherfujino in https://github.com/flutter/flutter/pull/115665
* Updated the kotlinlang version url. by @gaaclarke in https://github.com/flutter/flutter/pull/115782
* [flutter_tool] Adds --enable-dart-profiling flag by @zanderso in https://github.com/flutter/flutter/pull/115863
* [flutter_tools] Add --dump-info, --no-frequency-based-minification flags by @kevmoo in https://github.com/flutter/flutter/pull/115862
* Refactor Message class to hold all translations by @thkim1011 in https://github.com/flutter/flutter/pull/115506
* [flutter_tools] use absolute path for shader lib by @jonahwilliams in https://github.com/flutter/flutter/pull/116123
* Add Escaping Option for ICU MessageFormat Syntax by @thkim1011 in https://github.com/flutter/flutter/pull/116137
* [tools]build ipa validate app icon size by @hellohuanlin in https://github.com/flutter/flutter/pull/115594
* [flutter_tools] normalize windows file path cases in flutter validator by @christopherfujino in https://github.com/flutter/flutter/pull/115889
* [flutter_tools] add debug trace when compiling dart2js by @christopherfujino in https://github.com/flutter/flutter/pull/116238
* [flutter_tools] Forward app.webLaunchUrl event from Flutter to DAP clients by @DanTup in https://github.com/flutter/flutter/pull/116275
* [flutter_tools] add deprecation message for "flutter format" by @christopherfujino in https://github.com/flutter/flutter/pull/116145
* [gen_l10n] Improvements to `gen_l10n` by @thkim1011 in https://github.com/flutter/flutter/pull/116202
* Reland "Upgrade targetSdkVersion and compileSdkVersion to 33" by @GaryQian in https://github.com/flutter/flutter/pull/116146
* Suggest Rosetta when x64 binary cannot be run by @jmagman in https://github.com/flutter/flutter/pull/114558
* Removes retries from "dart pub get" and un-buffers its stdout/stderr output by @nehalvpatel in https://github.com/flutter/flutter/pull/115801
* [flutter_tools] disable web compilation of shaders by @jonahwilliams in https://github.com/flutter/flutter/pull/116368
* [flutter_tools] dont include material shaders in web builds (#116538) by @jonahwilliams in https://github.com/flutter/flutter/pull/116554
* [CP] [flutter_tools] Add remap sampler support (#116861) by @jonahwilliams in https://github.com/flutter/flutter/pull/116922
### MacOS
* Update CI to use Xcode 14 beta 5 by @jmagman in https://github.com/flutter/flutter/pull/110302
* Remove Apple Silicon workarounds from plugin lint test by @jmagman in https://github.com/flutter/flutter/pull/111432
* Update macOS gallery display name by @jmagman in https://github.com/flutter/flutter/pull/113658

## New Contributors
* @talisk made their first contribution in https://github.com/flutter/flutter/pull/107221
* @0xba1 made their first contribution in https://github.com/flutter/flutter/pull/107836
* @foongsq made their first contribution in https://github.com/flutter/flutter/pull/107201
* @NikosTsesmelis made their first contribution in https://github.com/flutter/flutter/pull/105958
* @yaakovschectman made their first contribution in https://github.com/flutter/flutter/pull/107949
* @richkadel made their first contribution in https://github.com/flutter/flutter/pull/107335
* @nbayati made their first contribution in https://github.com/flutter/flutter/pull/107568
* @RockerFlower made their first contribution in https://github.com/flutter/flutter/pull/107873
* @polina-c made their first contribution in https://github.com/flutter/flutter/pull/108234
* @snat-s made their first contribution in https://github.com/flutter/flutter/pull/107738
* @pdblasi-google made their first contribution in https://github.com/flutter/flutter/pull/108573
* @parkershepherd made their first contribution in https://github.com/flutter/flutter/pull/108843
* @Stitch-Taotao made their first contribution in https://github.com/flutter/flutter/pull/108659
* @otto-dev made their first contribution in https://github.com/flutter/flutter/pull/108710
* @dnys1 made their first contribution in https://github.com/flutter/flutter/pull/107648
* @verath made their first contribution in https://github.com/flutter/flutter/pull/108312
* @limonadev made their first contribution in https://github.com/flutter/flutter/pull/103753
* @eggfly made their first contribution in https://github.com/flutter/flutter/pull/110077
* @newtaDev made their first contribution in https://github.com/flutter/flutter/pull/103620
* @FluentCoding made their first contribution in https://github.com/flutter/flutter/pull/110096
* @ankur2136 made their first contribution in https://github.com/flutter/flutter/pull/109784
* @akshdeep-singh made their first contribution in https://github.com/flutter/flutter/pull/109808
* @hlwhl made their first contribution in https://github.com/flutter/flutter/pull/109973
* @vaind made their first contribution in https://github.com/flutter/flutter/pull/101586
* @eliasyishak made their first contribution in https://github.com/flutter/flutter/pull/110013
* @tomgilder made their first contribution in https://github.com/flutter/flutter/pull/110985
* @alestiago made their first contribution in https://github.com/flutter/flutter/pull/111034
* @prateekbytes made their first contribution in https://github.com/flutter/flutter/pull/111401
* @NazarenoCavazzon made their first contribution in https://github.com/flutter/flutter/pull/109014
* @talamaska made their first contribution in https://github.com/flutter/flutter/pull/107924
* @codeforce-dev made their first contribution in https://github.com/flutter/flutter/pull/109443
* @yunusemrebakir made their first contribution in https://github.com/flutter/flutter/pull/106274
* @Mayb3Nots made their first contribution in https://github.com/flutter/flutter/pull/110908
* @robiness made their first contribution in https://github.com/flutter/flutter/pull/112137
* @hai046 made their first contribution in https://github.com/flutter/flutter/pull/108098
* @sarannng made their first contribution in https://github.com/flutter/flutter/pull/112454
* @DattatreyaReddy made their first contribution in https://github.com/flutter/flutter/pull/112218
* @JunhuaLin made their first contribution in https://github.com/flutter/flutter/pull/112149
* @Hardeepsingh980 made their first contribution in https://github.com/flutter/flutter/pull/83994
* @math1man made their first contribution in https://github.com/flutter/flutter/pull/112548
* @The-Redhat made their first contribution in https://github.com/flutter/flutter/pull/108112
* @alex-sandri made their first contribution in https://github.com/flutter/flutter/pull/113010
* @AbhiShake1 made their first contribution in https://github.com/flutter/flutter/pull/113485
* @TzviPM made their first contribution in https://github.com/flutter/flutter/pull/113404
* @Oleh-Sv made their first contribution in https://github.com/flutter/flutter/pull/113237
* @ksballetba made their first contribution in https://github.com/flutter/flutter/pull/109136
* @youssefali424 made their first contribution in https://github.com/flutter/flutter/pull/113214
* @kyeshmz made their first contribution in https://github.com/flutter/flutter/pull/109650
* @Pourqavam made their first contribution in https://github.com/flutter/flutter/pull/105966
* @lubritto made their first contribution in https://github.com/flutter/flutter/pull/113748
* @akhial made their first contribution in https://github.com/flutter/flutter/pull/114143
* @elbeicktalat made their first contribution in https://github.com/flutter/flutter/pull/106525
* @naudzghebre made their first contribution in https://github.com/flutter/flutter/pull/114637
* @blendthink made their first contribution in https://github.com/flutter/flutter/pull/114297
* @jakubfijalkowski made their first contribution in https://github.com/flutter/flutter/pull/113969
* @srujzs made their first contribution in https://github.com/flutter/flutter/pull/115094
* @jgoyvaerts made their first contribution in https://github.com/flutter/flutter/pull/115240

**Full Changelog**: https://github.com/flutter/flutter/compare/3.3.0...3.7.0-1.4.pre
