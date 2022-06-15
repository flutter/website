---
title: Flutter 3.0.0 release notes
short-title: 3.0.0 release notes
description: Release notes for Flutter 3.0.0.
---
This page has release notes for 3.0.0.
For information about subsequent bug-fix releases,
see [Hotfixes to the Stable Channel][].

[Hotfixes to the Stable Channel]: {{site.github}}/flutter/flutter/wiki/Hotfixes-to-the-Stable-Channel

## If you see warnings about bindings

When migrating to Flutter 3,
you might see warnings like the following:

```
Warning: Operand of null-aware operation '!' has type 'SchedulerBinding' which excludes null.
```

These are caused by a simplification of the API
(the `instance` property on bindings is now non-nullable),
combined with an eager compiler that wants to report
any case where redundant null-aware operators
(such as `!` and `?.`) that are used when
they're not necessary.

If this happens,
there might be several causes with different solutions:

### Dependencies

If your dependencies use bindings,
they might need updating to silence the warnings.
Your builds should be unaffected except for
the verbose warnings.
You can ignore the warnings for now
(maybe reach out to your dependency's
developers to convince them to update).

### Your code

If the problem refers to your own code,
you can update it by running `dart fix --apply`.
This should resolve all the warnings.

If you need your code to support both
Flutter 3 and earlier versions
(maybe because your code is a library),
then you can wrap calls to `binding.instance`
with calls to a method such as the following:

```dart
/// This allows a value of type T or T?
/// to be treated as a value of type T?.
///
/// We use this so that APIs that have become
/// non-nullable can still be used with `!` and `?`
/// to support older versions of the API as well.
T? _ambiguate<T>(T? value) => value;
```

For example, instead of the following:

```dart
SchedulerBinding.instance!.addPostFrameCallback(...);
```

You can use:

```dart
_ambiguate(SchedulerBinding.instance)!.addPostFrameCallback(...);
```

When you no longer need to support versions of
Flutter before 3.0.0, you can remove this and
replace it with the following:

```dart
SchedulerBinding.instance.addPostFrameCallback(...);
```

### Framework issues

If the error messages do not point to one of your dependencies,
and `dart fix --apply` doesn't fix the issue,
or if the warnings are fatal
(for example, your application refuses to run), please
[file a bug]({{site.github}}/flutter/flutter/issues/new/choose).

## What's Changed

The following changes happened in this release:

### Framework

* Revert "[Fonts] Update icons" by @guidezpl in https://github.com/flutter/flutter/pull/95966
* Improve iOS fidelity of `barrierColor`s and edge decorations for full-screen Cupertino page transitions by @willlockwood in https://github.com/flutter/flutter/pull/95537
* [Fonts] Update icons by @guidezpl in https://github.com/flutter/flutter/pull/96115
* Allow `Checkbox`es in `DataTable`s to inherit colors from `CheckboxTheme` by @willlockwood in https://github.com/flutter/flutter/pull/96007
* Fix autofill eligibility check by @LongCatIsLooong in https://github.com/flutter/flutter/pull/95210
* [DropdownButtonFormField] Add borderRadius property by @dheerajv09 in https://github.com/flutter/flutter/pull/95944
* Fix `DataTable` `_SortArrow` changing orientation when state is updated by @markusaksli-nc in https://github.com/flutter/flutter/pull/94455
* Fix typo by @goderbauer in https://github.com/flutter/flutter/pull/96195
* RawKeyboard repeat events, and SingleActivator.includeRepeats by @dkwingsmt in https://github.com/flutter/flutter/pull/96154
* InteractiveViewer scaleFactor by @justinmc in https://github.com/flutter/flutter/pull/95224
* Reland "Ensure the engineLayer is disposed when an OpacityLayer is disabled"" by @dnfield in https://github.com/flutter/flutter/pull/96295
* Disallow copy and cut when `obscureText` is set on `TextField` by @gspencergoog in https://github.com/flutter/flutter/pull/96233
* Revert "Disallow copy and cut when `obscureText` is set on `TextField` (#96233)" by @gspencergoog in https://github.com/flutter/flutter/pull/96308
* Fix `paints..something` and `paints..everything` succeeding when they should fail by @willlockwood in https://github.com/flutter/flutter/pull/95993
* Fixes `RangeError` bug when length of `TabBar.tabs` is changed by @werainkhatri in https://github.com/flutter/flutter/pull/94623
* Make `FocusNode.traversalChildren` not be affected by parent's `canRequestFocus` by @gspencergoog in https://github.com/flutter/flutter/pull/95061
* fix a scrollbar bug by @xu-baolin in https://github.com/flutter/flutter/pull/95894
* Do not crash on LeaderLayer.applyTransform after retained rendering by @goderbauer in https://github.com/flutter/flutter/pull/96144
* LayerLink can temporary allow multiple leaders by @chunhtai in https://github.com/flutter/flutter/pull/95977
* TextEditingValue default selection docs by @justinmc in https://github.com/flutter/flutter/pull/96245
* Adds ability to mark a subtree as not traversable by @werainkhatri in https://github.com/flutter/flutter/pull/94626
* InkResponse enable if onTapDown is not null by @markusaksli-nc in https://github.com/flutter/flutter/pull/96224
* InkWell.overlayColor is now resolved against MaterialState.pressed by @HansMuller in https://github.com/flutter/flutter/pull/96435
* Support Scribble Handwriting by @fbcouch in https://github.com/flutter/flutter/pull/75472
* [RenderListWheelViewport] Update content dimensions to prevent scroll offset changes by @xu-baolin in https://github.com/flutter/flutter/pull/96102
* Fix Dialog alignment doc by @TahaTesser in https://github.com/flutter/flutter/pull/96388
* Enable no_leading_underscores_for_library_prefixes by @goderbauer in https://github.com/flutter/flutter/pull/96420
* Expose keyCode field in RawKeyEventDataWeb. by @b-luk in https://github.com/flutter/flutter/pull/96483
* enable more retained rendering opportunities for LeaderLayer by @goderbauer in https://github.com/flutter/flutter/pull/96486
* Migrate FloatingActionButton to Material 3 by @darrenaustin in https://github.com/flutter/flutter/pull/94486
* Make `DraggableScrollableController` a `ChangeNotifier` by @caseycrogers in https://github.com/flutter/flutter/pull/96089
* enable unnecessary_late by @goderbauer in https://github.com/flutter/flutter/pull/96417
* Correct scroll notifications for NestedScrollView by @Piinks in https://github.com/flutter/flutter/pull/96482
* MaterialStateProperty Docs by @Piinks in https://github.com/flutter/flutter/pull/96532
* Add debug property for onPointerHover by @WasserEsser in https://github.com/flutter/flutter/pull/96555
* Date Picker year selectors should announce as 'buttons' to accessibility framework. by @darrenaustin in https://github.com/flutter/flutter/pull/96546
* Revert "Support Scribble Handwriting" by @LongCatIsLooong in https://github.com/flutter/flutter/pull/96615
* Add Supported devices to the TapGestureRecognizer by @chunhtai in https://github.com/flutter/flutter/pull/96560
* Fix UNUSED_ELEMENT_PARAMETER for field formal initializers. by @scheglov in https://github.com/flutter/flutter/pull/96553
* Mac cmd + shift + left/right by @justinmc in https://github.com/flutter/flutter/pull/95948
* Modularize ReorderableListView auto scrolling logic by @chunhtai in https://github.com/flutter/flutter/pull/96563
* Slider: add themeable mouse cursor v2 by @HansMuller in https://github.com/flutter/flutter/pull/96623
* Land Set "basic" mouse cursor for disabled buttons, PR #89346 by @HansMuller in https://github.com/flutter/flutter/pull/96561
* Fix a [_ViewportElement] RenderObjectChild update bug by @xu-baolin in https://github.com/flutter/flutter/pull/96377
* Provide Appbar's `foregroundColor` to package license page titles by @TahaTesser in https://github.com/flutter/flutter/pull/95685
* Add example for CustomMultiChildLayout by @gspencergoog in https://github.com/flutter/flutter/pull/96632
* PopupMenu: add themeable mouse cursor v2 by @HansMuller in https://github.com/flutter/flutter/pull/96567
* Added TabBar.splashFactory, TabBarTheme.splashFactory,overlayColor by @HansMuller in https://github.com/flutter/flutter/pull/96252
* [framework] dont null assert in _debugVerifyIllFatedPopulation by @jonahwilliams in https://github.com/flutter/flutter/pull/96551
* Disallow copy and cut when text field is obscured. by @gspencergoog in https://github.com/flutter/flutter/pull/96309
* feat: Added more youtube refs to widgets docstrings by @albertodev01 in https://github.com/flutter/flutter/pull/96484
* update adaptive slider docs by @maheshmnj in https://github.com/flutter/flutter/pull/96599
* Fix UNUSED_ELEMENT_PARAMETER for unused field formal parameter. by @scheglov in https://github.com/flutter/flutter/pull/96684
* feat: added custom padding in PopupMenuButton by @arafaysaleem in https://github.com/flutter/flutter/pull/96657
* [framework] remove hashcode override for Element by @jonahwilliams in https://github.com/flutter/flutter/pull/96644
* Do not eagerly allocate inherited widget caches when initializing element tree by @jonahwilliams in https://github.com/flutter/flutter/pull/95596
* Revert "feat: added custom padding in PopupMenuButton (#96657)" by @gspencergoog in https://github.com/flutter/flutter/pull/96781
* Fix animate to curve argument by @caseycrogers in https://github.com/flutter/flutter/pull/96627
* Clean up mouse region code by @chunhtai in https://github.com/flutter/flutter/pull/96636
* Prevents DropdownButton from applying borderRadius property to first and last element of the list. by @chinmoy12c in https://github.com/flutter/flutter/pull/96695
* Adds BorderStyle property to TabPageSelector by @chinmoy12c in https://github.com/flutter/flutter/pull/92436
* Remove duplicate hashCode values & add missing commas  by @TahaTesser in https://github.com/flutter/flutter/pull/96844
* Removed the date from the Next/Previous month button's semantics for the Date Picker. by @darrenaustin in https://github.com/flutter/flutter/pull/96876
* chore: added YouTube ref to docstring by @albertodev01 in https://github.com/flutter/flutter/pull/96880
* chore(flutter_test): updated 'matchesGoldenFile' documentation by @albertodev01 in https://github.com/flutter/flutter/pull/96194
* Use strict-raw-types analysis instead of no-implicit-dynamic by @srawlins in https://github.com/flutter/flutter/pull/96296
* [Keyboard] Dispatch solitary synthesized `KeyEvent`s by @dkwingsmt in https://github.com/flutter/flutter/pull/96874
* [web] validate WebDriver responses by @yjbanov in https://github.com/flutter/flutter/pull/96884
* Call image stream listeners asynchronously if added asynchronously by @WasserEsser in https://github.com/flutter/flutter/pull/95525
* chore: Moved didUpdateWidget calls first by @albertodev01 in https://github.com/flutter/flutter/pull/96944
* Explain how MaterialApp renders text style in absence of Material Widget by @TahaTesser in https://github.com/flutter/flutter/pull/96530
* Enable no_leading_underscores_for_local_identifiers by @goderbauer in https://github.com/flutter/flutter/pull/96422
* Add ability to control if bottom child focus can be excluded in `AnimatedCrossFade` by @TahaTesser in https://github.com/flutter/flutter/pull/96593
* Add closeDrawer and closeEndDrawer in ScaffoldState by @pedromassango in https://github.com/flutter/flutter/pull/96960
* PageView scroll physics to match Android by @nt4f04uNd in https://github.com/flutter/flutter/pull/95423
* ListTile: add themeable mouse cursor  by @TahaTesser in https://github.com/flutter/flutter/pull/96740
* Adds `CheckboxListTile.checkboxShape` by @werainkhatri in https://github.com/flutter/flutter/pull/95714
* Allow current leader of layerlink to detach before the previous leade… by @chunhtai in https://github.com/flutter/flutter/pull/96810
* Export shadows to `Icon` API by @mateusfccp in https://github.com/flutter/flutter/pull/83638
* Deprecate Scrollbar isAlwaysShown -> thumbVisibility by @Piinks in https://github.com/flutter/flutter/pull/96957
* Show keyboard after text input connection restarts by @LongCatIsLooong in https://github.com/flutter/flutter/pull/96541
* Revert "PageView scroll physics to match Android" by @Piinks in https://github.com/flutter/flutter/pull/97150
* [framework] remove extra casts by @jonahwilliams in https://github.com/flutter/flutter/pull/97155
* add direction to CupertinoPickerDefaultSelectionOverlay by @Dan-Crane in https://github.com/flutter/flutter/pull/92959
* relax routerReportsNewRouteInformation function signature by @chunhtai in https://github.com/flutter/flutter/pull/97154
* Adds `CommonFinders.bySubtype<T extends Widget>()` finder. by @lrhn in https://github.com/flutter/flutter/pull/91415
* Use a more appropriate curve on ScrollsToTop by @SuhwanCha in https://github.com/flutter/flutter/pull/96574
* Deprecate Scrollbar hoverThickness and showTrackOnHover by @Piinks in https://github.com/flutter/flutter/pull/97173
* Add splashRadius to PopupMenuButton by @Moluram in https://github.com/flutter/flutter/pull/91148
* [framework] make HitTestEntry generic by @jonahwilliams in https://github.com/flutter/flutter/pull/97175
* Mirror before scaling in _AnimatedIconPainter by @Amir-P in https://github.com/flutter/flutter/pull/93312
* Flutter web add support for NetworkImage headers by @jonas-martinez in https://github.com/flutter/flutter/pull/85954
* Re-land "Support Scribble Handwriting" (#96615) by @fbcouch in https://github.com/flutter/flutter/pull/96881
* Revert the Scribble reland by @justinmc in https://github.com/flutter/flutter/pull/97405
* Update RawScrollbar to support the track by @Piinks in https://github.com/flutter/flutter/pull/97335
* Deprecate `useDeleteButtonTooltip` for Chips by @RoyARG02 in https://github.com/flutter/flutter/pull/96174
* `RefreshIndicator`: Add an interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/97254
* Add `CupertinoTimerPicker` Interactive Example by @TahaTesser in https://github.com/flutter/flutter/pull/93621
* Fix tappable area for `DropdownButtonFormField` & add `InkWell` to `DropdownButton` by @TahaTesser in https://github.com/flutter/flutter/pull/95906
* fixes navigator to be able to handle route with duplicate page key in… by @chunhtai in https://github.com/flutter/flutter/pull/97394
* Update `PopupMenuButton` example by @TahaTesser in https://github.com/flutter/flutter/pull/96681
* [Icons] Prevent double underscores after replacement by @guidezpl in https://github.com/flutter/flutter/pull/96904
* improve docs for testing dart fix by @werainkhatri in https://github.com/flutter/flutter/pull/97493
* PointerDeviceKind and ui.PointerChange forwards-compatibility by @moffatman in https://github.com/flutter/flutter/pull/97350
* Re-land "Support Scribble Handwriting" (#96615) by @fbcouch in https://github.com/flutter/flutter/pull/97437
* BottomNavigationBar: add themeable mouse cursor by @TahaTesser in https://github.com/flutter/flutter/pull/96736
* Fix VisualDensity's vertical lerp implementation by @WasserEsser in https://github.com/flutter/flutter/pull/96597
* chore: Updated AutofillContextAction documentation by @albertodev01 in https://github.com/flutter/flutter/pull/97245
* Updated gen_defaults to use new JSON output from the Material token database. by @darrenaustin in https://github.com/flutter/flutter/pull/97596
* Allow Clip.none as a valid clipBehavior by @Piinks in https://github.com/flutter/flutter/pull/95593
* Add DisplayFeatureSubScreen widget by @andreidiaconu in https://github.com/flutter/flutter/pull/92907
* Updated the FAB defaults to only use function overrides for computed values. by @darrenaustin in https://github.com/flutter/flutter/pull/97677
* Add docs about horizontal scrollbars by @Piinks in https://github.com/flutter/flutter/pull/97673
* Update SliverChildDelegate docs by @Piinks in https://github.com/flutter/flutter/pull/97674
* Add splashBorderRadius to TabBar by @nayeemtby in https://github.com/flutter/flutter/pull/97204
* Invalidate the TextPainter line metrics cache when redoing text layout by @jason-simmons in https://github.com/flutter/flutter/pull/97446
* Fix RouterObserver didPop is not called when reverseTransitionDuratio… by @chunhtai in https://github.com/flutter/flutter/pull/97171
* Fix Local `SwitchTheme` not being inherited by `Switch` Widget by @TahaTesser in https://github.com/flutter/flutter/pull/97705
* Clean up the bindings APIs. by @Hixie in https://github.com/flutter/flutter/pull/89451
* Fix Local `CheckBoxTheme` not being inherited by `CheckBox` Widget by @TahaTesser in https://github.com/flutter/flutter/pull/97715
* Fix Local `RadioTheme` not being inherited by `Radio` Widget by @TahaTesser in https://github.com/flutter/flutter/pull/97713
* Fix `PopupMenuButton` example tag by @TahaTesser in https://github.com/flutter/flutter/pull/97763
* Prepare the flutter.material.RawMaterialButton.mouseCursor doc template for themeable mouse cursors by @jpnurmi in https://github.com/flutter/flutter/pull/88470
* Text editing shift + tap + drag interaction by @justinmc in https://github.com/flutter/flutter/pull/95213
* Make the application lifecycle does not affect `SchedulerBinding.scheduleForcedFrame`. by @ColdPaleLight in https://github.com/flutter/flutter/pull/97468
* Report progress on Dismissible update callback by @cachapa in https://github.com/flutter/flutter/pull/95504
* RenderIndexedStack - Mark invisible children as offstage in debugDescribeProperties by @WasserEsser in https://github.com/flutter/flutter/pull/96639
* TabBar: add themeable mouse cursor  by @TahaTesser in https://github.com/flutter/flutter/pull/96737
* removes `Material` from tests of `FooButton`s that implement it internally by @werainkhatri in https://github.com/flutter/flutter/pull/96899
* Update default `ThemeData.textTheme` styles to Material 3 typography by @darrenaustin in https://github.com/flutter/flutter/pull/97829
* Undo/redo by @justinmc in https://github.com/flutter/flutter/pull/96968
* Remove RenderEditable dependency from TextSelectionHandleOverlay by @chunhtai in https://github.com/flutter/flutter/pull/97967
* [framework] don't hit test for system nav bar or system chrome on desktop by @jonahwilliams in https://github.com/flutter/flutter/pull/97883
* [framework] inline casts on Element.widget getter to improve web performance by @jonahwilliams in https://github.com/flutter/flutter/pull/97822
* [EditableText] honor the "brieflyShowPassword" system setting by @LongCatIsLooong in https://github.com/flutter/flutter/pull/97769
* Revert "[EditableText] honor the "brieflyShowPassword" system setting" by @godofredoc in https://github.com/flutter/flutter/pull/98089
* implemented TapUp within InkResponse and InkWell by @gslender in https://github.com/flutter/flutter/pull/93833
* Fix timer keeps active when resampling disabled in some cases by @wangying3426 in https://github.com/flutter/flutter/pull/97197
* Unify Text selection API by @chunhtai in https://github.com/flutter/flutter/pull/98073
* Allow remove listener on disposed change notifier by @chunhtai in https://github.com/flutter/flutter/pull/97988
* [flutter_driver] show refresh rate status in timeline summary by @cyanglaz in https://github.com/flutter/flutter/pull/95699
* Shift tap on an unfocused field by @justinmc in https://github.com/flutter/flutter/pull/97543
* Windows/Linux keyboard shortcuts at a wordwrap by @justinmc in https://github.com/flutter/flutter/pull/96323
* PointerDeviceKind forwards-compatibility in flutter_test by @moffatman in https://github.com/flutter/flutter/pull/98202
* EditableText does not request focus on autofill by @LongCatIsLooong in https://github.com/flutter/flutter/pull/97846
* [framework] use platform touchslop on Android by @jonahwilliams in https://github.com/flutter/flutter/pull/97971
* Fix NavigationRail Indicator alignment for `NavigationRailLabelType.none` by @TahaTesser in https://github.com/flutter/flutter/pull/98028
* Update Material tokens to v0.81. by @darrenaustin in https://github.com/flutter/flutter/pull/98149
* Add `keyLog` and `connectionFactory` to HttpClient implementations by @brianquinlan in https://github.com/flutter/flutter/pull/98045
* Reland "[EditableText] honor the "brieflyShowPassword" system setting #97769 " by @LongCatIsLooong in https://github.com/flutter/flutter/pull/98150
* [performance] Process dirty nodes from top to bottom during paint to avoid unnecessary layer tree walks by @goderbauer in https://github.com/flutter/flutter/pull/98219
* Refactor TextSelectionOverlay by @chunhtai in https://github.com/flutter/flutter/pull/98153
* [performance] Trace direct calls to inflateWidget by @goderbauer in https://github.com/flutter/flutter/pull/98277
* Add a BindingBase.debugBindingType() method to enable asserts that want to verify that the binding isn't initialized by @Hixie in https://github.com/flutter/flutter/pull/98226
* Fix `fooTheme.of(context);` usage docs by @TahaTesser in https://github.com/flutter/flutter/pull/98402
* Add `CupertinoSlider` example by @TahaTesser in https://github.com/flutter/flutter/pull/93633
* CupertinoActionSheet: Update sample by @TahaTesser in https://github.com/flutter/flutter/pull/98356
* CupertinoAlertDialog: Update sample by @TahaTesser in https://github.com/flutter/flutter/pull/98357
* Add custom size constraints parameter to `PopupMenu` by @TahaTesser in https://github.com/flutter/flutter/pull/97798
* Update `NavigationBar` to support Material 3 token by @darrenaustin in https://github.com/flutter/flutter/pull/98285
* Add `CupertinoPicker` interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/93622
* Add `ExpansionTileTheme` by @TahaTesser in https://github.com/flutter/flutter/pull/98405
* Update `CupertinoTextField` example  by @TahaTesser in https://github.com/flutter/flutter/pull/93738
* CupertinoSegmentedControl: Add an interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/98154
* CupertinoSlidingSegmentedControl: Add an interactive example by @TahaTesser in https://github.com/flutter/flutter/pull/98156
* Added a NavgationBar example with nested Navigators by @HansMuller in https://github.com/flutter/flutter/pull/98440
* Revert "[performance] Process dirty nodes from top to bottom during paint to avoid unnecessary layer tree walks" by @goderbauer in https://github.com/flutter/flutter/pull/98520
* Hide toolbar when selection is out of view by @Renzo-Olivares in https://github.com/flutter/flutter/pull/98152
* Add explanation to ChangeNotifier by @chunhtai in https://github.com/flutter/flutter/pull/98295
* Dismiss text selection toolbar with ESC by @markusaksli-nc in https://github.com/flutter/flutter/pull/98511
* Dismiss Autocomplete with ESC by @markusaksli-nc in https://github.com/flutter/flutter/pull/97790
* Revert "Dismiss text selection toolbar with ESC" by @markusaksli-nc in https://github.com/flutter/flutter/pull/98600
* Dismiss Modal Barrier on `handleTapCancel`  by @TahaTesser in https://github.com/flutter/flutter/pull/98191
* Remove unused parameter and consequently unused variable by @mateusfccp in https://github.com/flutter/flutter/pull/98428
* Update example code and docs for InteractiveViewer.builder by @goderbauer in https://github.com/flutter/flutter/pull/98623
* Remove deprecated RectangularSliderTrackShape.disabledThumbGapWidth by @Piinks in https://github.com/flutter/flutter/pull/98613
* Update stretching overscroll clip behavior by @Piinks in https://github.com/flutter/flutter/pull/97678
* Remove deprecated UpdateLiveRegionEvent by @Piinks in https://github.com/flutter/flutter/pull/98615
* Remove `clipBehavior == Clip.none` conditions by @TahaTesser in https://github.com/flutter/flutter/pull/98503
* Show `RefreshIndicator` on top when scroll's axis direction is up (matching native behaviour) by @TahaTesser in https://github.com/flutter/flutter/pull/93779
* Remove deprecated VelocityTracker constructor by @Piinks in https://github.com/flutter/flutter/pull/98541
* Add more tests to slider to avoid future breakages by @goderbauer in https://github.com/flutter/flutter/pull/98772
* Revert "Add more tests to slider to avoid future breakages" by @zanderso in https://github.com/flutter/flutter/pull/98783
* Spacebar and enter in EditableText work with Inkwells by @justinmc in https://github.com/flutter/flutter/pull/98469
* Avoid unnecessary lambdas in SelectionOverlay.showHandles() by @tgucio in https://github.com/flutter/flutter/pull/98912
* Update comments for chip tests by @RoyARG02 in https://github.com/flutter/flutter/pull/97476
* Added optional parameter keyboardType to showDatePicker by @kirolous-nashaat in https://github.com/flutter/flutter/pull/93439
* Fix getOffsetForCaret to return correct value if contains widget span by @chunhtai in https://github.com/flutter/flutter/pull/98542
* Reland "Add more tests to slider to avoid future breakages (#98772)" by @goderbauer in https://github.com/flutter/flutter/pull/98936
* Enable use_if_null_to_convert_nulls_to_bools lint by @tgucio in https://github.com/flutter/flutter/pull/98753
* Remove redundant hide handles API from TextSelectionDelegate by @chunhtai in https://github.com/flutter/flutter/pull/98944
* Test that render object changed its visual appearance after texture is create by @blasten in https://github.com/flutter/flutter/pull/98622
* Add actionsOverflowAlignment parameter to dialog by @himamis in https://github.com/flutter/flutter/pull/95995
* Fixed some issues and clarified the docs for ReorderableListView. by @darrenaustin in https://github.com/flutter/flutter/pull/98954
* Remove deprecated DayPicker and MonthPicker by @Piinks in https://github.com/flutter/flutter/pull/98543
* Adds `onReorderStart` and `onReorderEnd` arguments to `ReorderableList`. by @werainkhatri in https://github.com/flutter/flutter/pull/96049
* Correct the MediaQuery test name by @nt4f04uNd in https://github.com/flutter/flutter/pull/98984
* Revert "Remove redundant hide handles API from TextSelectionDelegate … by @chunhtai in https://github.com/flutter/flutter/pull/99008
* Clean up ClipboardStatusNotifier by @chunhtai in https://github.com/flutter/flutter/pull/98951
* Use int for PlaceholderSpan.placeholderCodeUnit by @tgucio in https://github.com/flutter/flutter/pull/98971
* Draggable can be accepted when the data is null by @xu-baolin in https://github.com/flutter/flutter/pull/97355
* Call bringIntoView after RenderEditable updates on paste by @tgucio in https://github.com/flutter/flutter/pull/98604
* Assert golden files use the right extension by @Piinks in https://github.com/flutter/flutter/pull/99016
* Revert "Assert golden files use the right extension" by @hterkelsen in https://github.com/flutter/flutter/pull/99075
* Pasting collapses the selection and puts it after the pasted content by @justinmc in https://github.com/flutter/flutter/pull/98679
* Correct font weight for Cupertino tab label by @SimonHausdorf in https://github.com/flutter/flutter/pull/90109
* adds `trackRadius` to `ScrollbarPainter` and `RawScrollbar` by @werainkhatri in https://github.com/flutter/flutter/pull/98018
* Fix a Tabs crash when change the TabControllers by @xu-baolin in https://github.com/flutter/flutter/pull/98242
* Re-land Assert golden files use the right extension by @Piinks in https://github.com/flutter/flutter/pull/99082
* Do not crash if dispatch the mouse events before the tooltip overlay detached by @xu-baolin in https://github.com/flutter/flutter/pull/97268
* [ReorderableListView] Add `footer` by @TahaTesser in https://github.com/flutter/flutter/pull/92086
* Add `clipBehavior` to `Snackbar` by @TahaTesser in https://github.com/flutter/flutter/pull/98252
* Add Widget of the Week links by @craiglabenz in https://github.com/flutter/flutter/pull/99178
* feat: Added docstring examples to AnimatedBuilder and ChangeNotifier by @albertodev01 in https://github.com/flutter/flutter/pull/98628
* [Keyboard] Correctly convert down events that are immediately synthesized released by @dkwingsmt in https://github.com/flutter/flutter/pull/99200
* Updated to v0.86 of the Material Design tokens. by @darrenaustin in https://github.com/flutter/flutter/pull/99292
* Add NavigationBar dartpad example  by @maheshmnj in https://github.com/flutter/flutter/pull/97046
* Migrates packages/flutter to from `hashValues` to `Object.hash` by @werainkhatri in https://github.com/flutter/flutter/pull/96109
* Added viewport fraction parameter to tabView by @Hari-07 in https://github.com/flutter/flutter/pull/98512
* [framework] improve Notification API performance by skipping full Element tree traversal by @jonahwilliams in https://github.com/flutter/flutter/pull/98451
* Remove redundant properties passed to _Editable by @Renzo-Olivares in https://github.com/flutter/flutter/pull/99192
* Revert "Clean up ClipboardStatusNotifier (#98951)" by @chunhtai in https://github.com/flutter/flutter/pull/99361
* Reland "Dismiss text selection toolbar with ESC" by @markusaksli-nc in https://github.com/flutter/flutter/pull/98995
* Fix a Scrollbar hittest penetration issue by @xu-baolin in https://github.com/flutter/flutter/pull/99328
* Revert "Draggable can be accepted when the data is null" by @Piinks in https://github.com/flutter/flutter/pull/99419
* Limit overscroll stretching by @Piinks in https://github.com/flutter/flutter/pull/99364
* Simplify SafeArea test for maintainBottomViewPadding to ensure maintainBottomViewPadding is always respected by @joellurcook in https://github.com/flutter/flutter/pull/97646
* Specify widget height in EditableText shortcuts tests by @tgucio in https://github.com/flutter/flutter/pull/98607
* More beautiful linear_gradient sample by @goderbauer in https://github.com/flutter/flutter/pull/99298
* `CupertinoSliverNavigationBar`: Add example by @TahaTesser in https://github.com/flutter/flutter/pull/99384
* Add material localizations for keyboard keys used for shortcut descriptions in menus. by @gspencergoog in https://github.com/flutter/flutter/pull/99020
* Deprecate MaterialButtonWithIconMixin by @Piinks in https://github.com/flutter/flutter/pull/99088
* Use `PlatformDispatcher.instance` over `window` where possible by @goderbauer in https://github.com/flutter/flutter/pull/99496
* Reland clean up clipboard. by @chunhtai in https://github.com/flutter/flutter/pull/99363
* Use `BindingBase.platformDispatcher` over `BindingBase.window` where possible by @goderbauer in https://github.com/flutter/flutter/pull/99443
* Improve documentation of  `EditableText`/`TextField` callbacks by @TahaTesser in https://github.com/flutter/flutter/pull/98414
* complete migration of flutter repo to Object.hash* by @werainkhatri in https://github.com/flutter/flutter/pull/99505
* Migrate `Dialog` to Material 3 by @TahaTesser in https://github.com/flutter/flutter/pull/98919
* Improve container widget by @r-mzy47 in https://github.com/flutter/flutter/pull/98389
* CupertinoButton: Add clickable cursor on web by @TahaTesser in https://github.com/flutter/flutter/pull/96863
* [framework] add gesture settings to draggable by @jonahwilliams in https://github.com/flutter/flutter/pull/99567
* Make popup menu position configurable by @TahaTesser in https://github.com/flutter/flutter/pull/98979
* Re-invoke DismissIntent in Autocomplete if ignored by @markusaksli-nc in https://github.com/flutter/flutter/pull/99403
* Remove package:typed_data from package:flutter dependencies by @jonahwilliams in https://github.com/flutter/flutter/pull/99604
* Remove deprecated RenderObjectElement methods by @Piinks in https://github.com/flutter/flutter/pull/98616
* CupertinoTabBar: Add clickable cursor on web by @TahaTesser in https://github.com/flutter/flutter/pull/96996
* Remove deprecated Overflow and Stack.overflow by @Piinks in https://github.com/flutter/flutter/pull/98583
* Remove deprecated CupertinoTextField, TextField, TextFormField maxLengthEnforced by @Piinks in https://github.com/flutter/flutter/pull/98539
* Fix: Date picker interactive sample not loading  by @maheshmnj in https://github.com/flutter/flutter/pull/99401
* Add Foldable support for modal routes by @andreidiaconu in https://github.com/flutter/flutter/pull/92909
* Revert "Remove deprecated CupertinoTextField, TextField, TextFormField maxLengthEnforced" by @Piinks in https://github.com/flutter/flutter/pull/99768
* Update Material tokens to v0.88 by @darrenaustin in https://github.com/flutter/flutter/pull/99568
* Remove deprecated OutlineButton by @Piinks in https://github.com/flutter/flutter/pull/98546
* Add the refresh rate fields to perf_test by @cyanglaz in https://github.com/flutter/flutter/pull/99710
* Re-land removal of maxLengthEnforced deprecation by @Piinks in https://github.com/flutter/flutter/pull/99787
* Revert "Add the refresh rate fields to perf_test" by @zanderso in https://github.com/flutter/flutter/pull/99801
* Avoid calling `performLayout` when only the relayout boundary is different by @LongCatIsLooong in https://github.com/flutter/flutter/pull/99056
* remove unnecessary null check by @a14n in https://github.com/flutter/flutter/pull/99507
* updateEditingValueWithDeltas snippet docs fix by @justinmc in https://github.com/flutter/flutter/pull/99570
* Updated tokens to v0.90. by @darrenaustin in https://github.com/flutter/flutter/pull/99782
* Fix `ColorScheme.shadow` to default to black even for dark themes. by @darrenaustin in https://github.com/flutter/flutter/pull/99722
* Remove deprecated RenderEditable.onSelectionChanged by @Piinks in https://github.com/flutter/flutter/pull/98582
* [Material] Create an InkSparkle splash effect that matches the Material 3 ripple effect by @clocksmith in https://github.com/flutter/flutter/pull/99731
* Remove expired ThemeData deprecations by @Piinks in https://github.com/flutter/flutter/pull/98578
* Update `NavigationRail` to support Material 3 tokens by @darrenaustin in https://github.com/flutter/flutter/pull/99171
* Revert "Remove expired ThemeData deprecations" by @Piinks in https://github.com/flutter/flutter/pull/99920
* Revert "[web] roll Chromium dep to 96.2" by @zanderso in https://github.com/flutter/flutter/pull/99949
* Fix/text containing finder work with rich texts by @valentinmarq in https://github.com/flutter/flutter/pull/99682
* Update semantics live region documentation by @jjoelson in https://github.com/flutter/flutter/pull/99987
* Fix AndroidView offset and resize by @blasten in https://github.com/flutter/flutter/pull/99888
* Revert "Avoid calling `performLayout` when only the relayout boundary is different" by @LongCatIsLooong in https://github.com/flutter/flutter/pull/100068
* Make NavigationRail.selectedIndex nullable by @Jjagg in https://github.com/flutter/flutter/pull/95336
* Revert "Do not eagerly allocate inherited widget caches when initializing element tree" by @jonahwilliams in https://github.com/flutter/flutter/pull/100152
* Add 'mouseCursor' to TextFormField by @SahajRana in https://github.com/flutter/flutter/pull/99822
* Web: treat modifier key without location by @moko256 in https://github.com/flutter/flutter/pull/98460
* Always use texture layer when displaying an Android view by @blasten in https://github.com/flutter/flutter/pull/100091
* Revert "Always use texture layer when displaying an Android view" by @zanderso in https://github.com/flutter/flutter/pull/100222
* Add missing `expansionTileTheme` theme copyWith test by @TahaTesser in https://github.com/flutter/flutter/pull/100165
* docs(flutter_test): fix mention of non-existing `matchesSemanticsNode` by @daadu in https://github.com/flutter/flutter/pull/99659
* Remove unnecessary ignore: override_on_non_overriding_member by @brianquinlan in https://github.com/flutter/flutter/pull/99793
* Disable Gold post-submit failures by @Piinks in https://github.com/flutter/flutter/pull/100308
* Reland: "Always use texture layer when displaying an Android view" by @blasten in https://github.com/flutter/flutter/pull/100237
* Roll chrome 96 attempt 2 by @yjbanov in https://github.com/flutter/flutter/pull/100073
* Refractor `compute` by @jellynoone in https://github.com/flutter/flutter/pull/99527
* Disable post-submit Gold failures entirely by @Piinks in https://github.com/flutter/flutter/pull/100332
* Add support for surface tint color overlays to `Material` widget. by @darrenaustin in https://github.com/flutter/flutter/pull/100036
* Material text selection menu should not show pointer cursor by @justinmc in https://github.com/flutter/flutter/pull/100248
* Revert "[framework] don't hit test for system nav bar or system chrome on desktop" by @jonahwilliams in https://github.com/flutter/flutter/pull/100263
* [Material] Use InkSparkle for splashFactory in ThemeData when useMaterial3 is true for Android non-web runtimes by @clocksmith in https://github.com/flutter/flutter/pull/99882
* Reorganize compute docs and add sample code by @goderbauer in https://github.com/flutter/flutter/pull/100253
* Fix `PopupMenuButton`'s `IconButton` not inheriting `IconTheme` size by @TahaTesser in https://github.com/flutter/flutter/pull/100199
* Hide toolbar after select all on desktop by @justinmc in https://github.com/flutter/flutter/pull/100261
* [framework] Remove danger zone  by @jonahwilliams in https://github.com/flutter/flutter/pull/100246
* Add fadeDuration back to TextSelectionOverlay by @chunhtai in https://github.com/flutter/flutter/pull/100381
* Fix wrong documentation: There is no `LeaderLayer._lastOffset` anymore by @fzyzcjy in https://github.com/flutter/flutter/pull/100300
* Introduce Theme extensions by @guidezpl in https://github.com/flutter/flutter/pull/98033
* `CupertinoSwitch`: Add clickable cursor for web by @TahaTesser in https://github.com/flutter/flutter/pull/99554
* Typo in EditableText strutStyle by @MrBirb in https://github.com/flutter/flutter/pull/100474
* Fix `deprecated_new_in_comment_reference` for `material` library by @guidezpl in https://github.com/flutter/flutter/pull/100289
* Fix stretch edge case by @Piinks in https://github.com/flutter/flutter/pull/99365
* Reland "Add the refresh rate fields to perf_test #99710" by @cyanglaz in https://github.com/flutter/flutter/pull/99854
* Put stretch indicator behind m3 flag by @Piinks in https://github.com/flutter/flutter/pull/100234
* Re-land text selection theme clean up by @Piinks in https://github.com/flutter/flutter/pull/99927
* Hide autocomplete menu on select. by @LongCatIsLooong in https://github.com/flutter/flutter/pull/100251
* Add `surfaceTint` color to the ColorScheme. by @darrenaustin in https://github.com/flutter/flutter/pull/100153
* Revert "Re-land text selection theme clean up" by @Piinks in https://github.com/flutter/flutter/pull/100564
* Make `Tooltip` state class public by @TahaTesser in https://github.com/flutter/flutter/pull/100553
* [RenderAnimatedSize] Resume interrupted resizing animation on attach by @LongCatIsLooong in https://github.com/flutter/flutter/pull/100519
* Migrate `Card` widget to support Material 3 by @darrenaustin in https://github.com/flutter/flutter/pull/100532
* Add back Gold `passfail` by @Piinks in https://github.com/flutter/flutter/pull/100576
* [framework] use Uint8List for SMC by @jonahwilliams in https://github.com/flutter/flutter/pull/100582
* Fix a ModalbottomSheet bug by @xu-baolin in https://github.com/flutter/flutter/pull/99970
* Add `HitTestBehavior` property to `MouseRegion` by @xu-baolin in https://github.com/flutter/flutter/pull/100405
* Fix: fix the delay of showOnScreen animation when keyboard comes up. by @luckysmg in https://github.com/flutter/flutter/pull/99546
* Fix crash after paste and unmount by @justinmc in https://github.com/flutter/flutter/pull/100589
* Fix `compute` in unsound null safety debug mode by @jellynoone in https://github.com/flutter/flutter/pull/100544
* Updated tokens to v0.92. by @darrenaustin in https://github.com/flutter/flutter/pull/100599
* Add child for placeholder widget by @M97Chahboun in https://github.com/flutter/flutter/pull/100372
* Move `ListTileTheme` and its tests into separate classes and  add `visualDensity` to the `ListTileTheme` by @TahaTesser in https://github.com/flutter/flutter/pull/100622
* Revert "Reland: "Always use texture layer when displaying an Android view"" by @blasten in https://github.com/flutter/flutter/pull/100660
* fix hidden TextSpan with recognizer does not auto scroll by @chunhtai in https://github.com/flutter/flutter/pull/100494
* Fix typo (again) by @fzyzcjy in https://github.com/flutter/flutter/pull/100684
* Fixes some widgets(`ListView.builder`, `GridView.builder` etc.) state-lose issue by @xu-baolin in https://github.com/flutter/flutter/pull/100547
* Revert "Dismiss Modal Barrier on `handleTapCancel`  (#98191)" by @chunhtai in https://github.com/flutter/flutter/pull/100784
* Check for mount after cut postframecallback by @justinmc in https://github.com/flutter/flutter/pull/100776
* Editable text sends enableInteractiveSelection to text input client by @chunhtai in https://github.com/flutter/flutter/pull/100649
* Allow Drawer width to be customized by @TytaniumDev in https://github.com/flutter/flutter/pull/99777
* Android Q transition by default by @AlexV525 in https://github.com/flutter/flutter/pull/98559
* Revert "Android Q transition by default" by @zanderso in https://github.com/flutter/flutter/pull/100799
* `Tooltip`: Add an example for `TooltipTriggerMode.manual` and add tests for existing `Tooltip` examples by @TahaTesser in https://github.com/flutter/flutter/pull/100554
* Reland "Avoid calling `performLayout` when only the relayout boundary is different" by @LongCatIsLooong in https://github.com/flutter/flutter/pull/100581
* Fix `FollowerLayer` (`CompositedTransformFollower`) has null pointer error when using with some kinds of `Layer`s by @fzyzcjy in https://github.com/flutter/flutter/pull/100672
* Consider backgroundBlendMode in equality of BoxDecoration by @goderbauer in https://github.com/flutter/flutter/pull/100788
* ✨ Android Q transition by default by @AlexV525 in https://github.com/flutter/flutter/pull/100812
* `CupertinoActionSheet`/`CupertinoAlertDialog`: Add clickable cursor for web by @TahaTesser in https://github.com/flutter/flutter/pull/99548
* `CupertinoSegmentedControl`/`CupertinoSlidingSegmentedControl`: Add clickable cursor for web by @TahaTesser in https://github.com/flutter/flutter/pull/99551
* Make popup menus avoid display features by @andreidiaconu in https://github.com/flutter/flutter/pull/98981
* Update performanceOverlay links  by @danagbemava-nc in https://github.com/flutter/flutter/pull/100894
* Relands "Starts using the --source flag to compile the dart registrant. (#98046)" by @gaaclarke in https://github.com/flutter/flutter/pull/100572
* Reland: "Use texture layer when displaying an Android view"  by @blasten in https://github.com/flutter/flutter/pull/100934
* Revert "Reland: "Use texture layer when displaying an Android view" " by @zanderso in https://github.com/flutter/flutter/pull/100950
* Allow unknown device kind to scroll scrollables by @chunhtai in https://github.com/flutter/flutter/pull/100800
* Reland: "Use texture layer when displaying an Android view" by @blasten in https://github.com/flutter/flutter/pull/100990
* Add isActivatedBy to ShortcutActivator by @gspencergoog in https://github.com/flutter/flutter/pull/100167
* [Fonts] Update icons by @guidezpl in https://github.com/flutter/flutter/pull/100885
* Fix `IconTheme` is not inherited when `Icon` is provided to `ListTile.title` and `ListTile.subtitle` by @TahaTesser in https://github.com/flutter/flutter/pull/100757
* Minor improvements to `ThemeExtension` example by @guidezpl in https://github.com/flutter/flutter/pull/100693
* Fix `LicensePage` too much spacing padding when `applicationVersion` and  `applicationLegalese` are empty by @TahaTesser in https://github.com/flutter/flutter/pull/101030
* Fix constructor doc for ScrollView.primary by @goderbauer in https://github.com/flutter/flutter/pull/100935
* Prepare `packages` (minus tools,framework) for `use_super_parameters` by @goderbauer in https://github.com/flutter/flutter/pull/100510
* Material 3 common buttons should use sparkle splash effect on Android. by @darrenaustin in https://github.com/flutter/flutter/pull/101075
* Revert "Allow unknown device kind to scroll scrollables (#100800)" by @chunhtai in https://github.com/flutter/flutter/pull/101129
* Fix Local `DataTableTheme` not being inherited by `DataTable` Widget by @TahaTesser in https://github.com/flutter/flutter/pull/101112
* Refactor `ToggleButtons` (remove `RawMaterialButton`) by @TahaTesser in https://github.com/flutter/flutter/pull/99493
* Reland "Allow unknown device kind to scroll scrollables (#100800)" by @chunhtai in https://github.com/flutter/flutter/pull/101301
* Fix crashes when current route parsing transactions are discarded by @chunhtai in https://github.com/flutter/flutter/pull/100657
* Implements a PlatformMenuBar widget and associated data structures by @gspencergoog in https://github.com/flutter/flutter/pull/100274
* Made flag for debugging build time of user created widgets by @gaaclarke in https://github.com/flutter/flutter/pull/100926
* [Cherrypick] Revert "Refactor `ToggleButtons` (remove `RawMaterialButton`) (#99493)" by @CaseyHillers in https://github.com/flutter/flutter/pull/101538
* [flutter_releases] Flutter beta 2.13.0-0.2.pre Framework Cherrypicks by @CaseyHillers in https://github.com/flutter/flutter/pull/102193
* [flutter_releases] Upgrade dwds to 12.1.1 by @christopherfujino in https://github.com/flutter/flutter/pull/101546

### Tooling

* FFI plugin by @dcharkes in https://github.com/flutter/flutter/pull/94101
* Revert "FFI plugin" by @zanderso in https://github.com/flutter/flutter/pull/96122
* Add a new PrebuiltFlutterApplicationPackage interface. by @chingjun in https://github.com/flutter/flutter/pull/95290
* Do not show v1 Android embedding message for non-Android commands by @jmagman in https://github.com/flutter/flutter/pull/96148
* Migrate build commands to null safety by @jmagman in https://github.com/flutter/flutter/pull/95649
* Migrate emulators, packages, upgrade, and downgrade to null safety by @jmagman in https://github.com/flutter/flutter/pull/95712
* feat(flutter_tools): Added doctor path printing on verbose by @crisboarna in https://github.com/flutter/flutter/pull/95453
* feat(flutter_tools): Changed NoIdeValidator validation type from error to warning by @crisboarna in https://github.com/flutter/flutter/pull/95492
* Fix analyze --watch command iterator by @jmagman in https://github.com/flutter/flutter/pull/96264
* Warm cache with all transitive dependencies in `flutter update-packages` command by @gspencergoog in https://github.com/flutter/flutter/pull/96258
* Hide PII from doctor validators for GitHub template by @jmagman in https://github.com/flutter/flutter/pull/96250
* Revert "feat(flutter_tools): Added doctor path printing on verbose" by @zanderso in https://github.com/flutter/flutter/pull/96414
* Add suggestion for compileSdkVersion warning by @blasten in https://github.com/flutter/flutter/pull/95369
* Fix typo by @utibeabasi6 in https://github.com/flutter/flutter/pull/96058
* Update Flutter desktop doc URL in error message by @cbracken in https://github.com/flutter/flutter/pull/96559
* Bump Android dependencies that rely on Jcenter by @blasten in https://github.com/flutter/flutter/pull/96558
* Fully support Dart-only mobile and macOS plugins by @stuartmorgan in https://github.com/flutter/flutter/pull/96183
* fix rsync output utf8decode bug by @intspt in https://github.com/flutter/flutter/pull/95881
* Fix wrong documentation URL for adding desktop support to existing app by @PoojaB26 in https://github.com/flutter/flutter/pull/94399
* Document template CMake files by @stuartmorgan in https://github.com/flutter/flutter/pull/96534
* Migrate assemble and integration_test_device to null safety by @jmagman in https://github.com/flutter/flutter/pull/96630
* Skip flaky test: background_isolate_test.dart: Hot restart kills background isolates by @keyonghan in https://github.com/flutter/flutter/pull/96678
* feat: support configure a custom launch url for flutter web by @wangying3426 in https://github.com/flutter/flutter/pull/95002
* Add boxes around version freshness alerts by @jmagman in https://github.com/flutter/flutter/pull/96152
* Enable inline Dart plugin implementation on Desktop by @stuartmorgan in https://github.com/flutter/flutter/pull/96610
* Pass 'build ios' device ID into xcodebuild by @jmagman in https://github.com/flutter/flutter/pull/96669
* Take screenshot when drive fails to start app or test by @jmagman in https://github.com/flutter/flutter/pull/96828
* Fix SDK versions for Flutter packages in analyze tests to enable null-safe mode by @DanTup in https://github.com/flutter/flutter/pull/96950
* Remove unused code from android_device.dart by @swift-kim in https://github.com/flutter/flutter/pull/95450
* Adjust lipo thinning input/output for macOS by @zanderso in https://github.com/flutter/flutter/pull/97111
* Use frontend_server from the Dart SDK by @zanderso in https://github.com/flutter/flutter/pull/97078
* [flutter_tools] support files in flutter analyze #96231 by @Jasguerrero in https://github.com/flutter/flutter/pull/97021
* Don't use example folder as a project type signal by @stuartmorgan in https://github.com/flutter/flutter/pull/97157
* [flutter_tools] Fix bug in background_isolate_test.dart by @christopherfujino in https://github.com/flutter/flutter/pull/97170
* [flutter_tools] auto-migrate dev users to beta by @christopherfujino in https://github.com/flutter/flutter/pull/97028
* Take drive screenshot on test failure before app is stopped by @jmagman in https://github.com/flutter/flutter/pull/96973
* Fix hot-restart background-isolate-test test by ensuring updated timestamp is in the future. by @aam in https://github.com/flutter/flutter/pull/97247
* [flutter_tools] add validation of paths of contained files to os_utils _unpackArchive() by @christopherfujino in https://github.com/flutter/flutter/pull/96565
* ProxiedDevice, connection to a remotely connected device via flutter daemon. by @chingjun in https://github.com/flutter/flutter/pull/95738
* [tool] Use an arm64 Dart SDK on arm64 macOS by @zanderso in https://github.com/flutter/flutter/pull/97189
* FFI plugins by @dcharkes in https://github.com/flutter/flutter/pull/96225
* Make remaining DAP tests null-safe by @DanTup in https://github.com/flutter/flutter/pull/97368
* [flutter_tools] remove dummy implementation from abstract class .isEnabled() by @christopherfujino in https://github.com/flutter/flutter/pull/96888
* Make DAP tests more tolerant of output that didn't come from the app being tested by @DanTup in https://github.com/flutter/flutter/pull/97291
* Fix typo: recieve => receive by @caioagiani in https://github.com/flutter/flutter/pull/97488
* Disallow running on unsupported devices by @jmagman in https://github.com/flutter/flutter/pull/97338
* Export an IPA for distribution via "flutter build ipa" without --export-options-plist by @jmagman in https://github.com/flutter/flutter/pull/97243
* Revert "Export an IPA for distribution via "flutter build ipa" without --export-options-plist" by @jmagman in https://github.com/flutter/flutter/pull/97616
* [flutter_tools] Use proper project name in templates by @collinjackson in https://github.com/flutter/flutter/pull/96373
* [flutter_tool] Download gen_snapshot.zip for macOS desktop by @zanderso in https://github.com/flutter/flutter/pull/97627
* Change all instance of throwing strings to throw specific error classes. by @chingjun in https://github.com/flutter/flutter/pull/97325
* Revert "[flutter_tool] Download gen_snapshot.zip for macOS desktop (#97627) by @zanderso in https://github.com/flutter/flutter/pull/97664
* Addresses the feedbacks in #95738 by @chingjun in https://github.com/flutter/flutter/pull/97457
* Reland: [flutter_tool] Download gen_snapshot.zip for macOS desktop by @zanderso in https://github.com/flutter/flutter/pull/97671
* Exit the tool if a DevTools subprocess fails when running on a bot by @jason-simmons in https://github.com/flutter/flutter/pull/97613
* [flutter_tool] allow disabling profile mode timeline traces by @jonahwilliams in https://github.com/flutter/flutter/pull/97622
* Export an IPA for distribution via "flutter build ipa" without --export-options-plist by @jmagman in https://github.com/flutter/flutter/pull/97672
* Pin `package:ffi` in `plugin_ffi` template by @dcharkes in https://github.com/flutter/flutter/pull/97720
* Restructure Windows plugin template by @stuartmorgan in https://github.com/flutter/flutter/pull/93511
* [flutter_tools] Fix bundle file not found when flavor contains upperc… by @MichaelTamm in https://github.com/flutter/flutter/pull/92660
* Fix error in type cast. by @chingjun in https://github.com/flutter/flutter/pull/97778
* [flutter_tools] increment y instead of m when calling flutter --version on master by @christopherfujino in https://github.com/flutter/flutter/pull/97827
* Include -isysroot -arch and -miphoneos-version-min when creating dummy module App.framework by @jmagman in https://github.com/flutter/flutter/pull/97689
* Add support for attachRequest in DAP, running "flutter attach" by @DanTup in https://github.com/flutter/flutter/pull/97652
* Fix how Gradle resolves Android plugin by @blasten in https://github.com/flutter/flutter/pull/97823
* Fix typo FutterApplication -> FlutterApplication by @bannzai in https://github.com/flutter/flutter/pull/97897
* Revert "Fix how Gradle resolves Android plugin" by @blasten in https://github.com/flutter/flutter/pull/98050
* Export activity for module in AndroidManifest.xml by @blasten in https://github.com/flutter/flutter/pull/98076
* Add debugging info to android_plugin_example_app_build_test by @dcharkes in https://github.com/flutter/flutter/pull/98107
* [flutter_tools] Make variants of Pub have consistent method signatures by @swift-kim in https://github.com/flutter/flutter/pull/98119
* Fix flutter gen-l10n help message by @TahaTesser in https://github.com/flutter/flutter/pull/98147
* [flutter_tools] fix type error in flutter update-packages --jobs=n by @christopherfujino in https://github.com/flutter/flutter/pull/98283
* flutter_build_null_unsafe_test print failed build output by @jmagman in https://github.com/flutter/flutter/pull/98310
* [flutter_tools] remove pub dependencies from universal by @Jasguerrero in https://github.com/flutter/flutter/pull/97722
* [flutter_tools] rename two unit tests that were not actually being run on CI by @christopherfujino in https://github.com/flutter/flutter/pull/98299
* Update flutter_tools to look for new VM service message by @bkonyi in https://github.com/flutter/flutter/pull/97683
* [flutter_tools] do not validate maven upstream if cloud storage override provided by @christopherfujino in https://github.com/flutter/flutter/pull/98293
* Dump backtrace when cannot attach to observatory by @jmagman in https://github.com/flutter/flutter/pull/98550
* Remove "beta-quality" for Windows by @timsneath in https://github.com/flutter/flutter/pull/98614
* [flutter_tools] remove flaky web vm service test by @christopherfujino in https://github.com/flutter/flutter/pull/98540
* Reland "Enable caching of CPU samples collected at application startup (#89600)" by @bkonyi in https://github.com/flutter/flutter/pull/98769
* Improve Gradle retry logic by @blasten in https://github.com/flutter/flutter/pull/96554
* [flutter_tools] deprecate the dev branch from the feature system by @christopherfujino in https://github.com/flutter/flutter/pull/98689
* Revert "Reland "Enable caching of CPU samples collected at application startup (#89600)"" by @zanderso in https://github.com/flutter/flutter/pull/98803
* Fixed order dependency and removed no-shuffle-tag in build_ios_framew… by @Swiftaxe in https://github.com/flutter/flutter/pull/94699
* Add option in ProxiedDevice to only transfer the delta when deploying. by @chingjun in https://github.com/flutter/flutter/pull/97462
* Removed no-shuffle tag and fixed order dependency in daemon_test.dart by @Swiftaxe in https://github.com/flutter/flutter/pull/98970
* Skip `can validate flutter version in parallel` test in `Linux web_tool_tests` by @keyonghan in https://github.com/flutter/flutter/pull/99017
* Increase recommended CocoaPods version to 1.11 by @jmagman in https://github.com/flutter/flutter/pull/98621
* reads min/target sdk versions from localproperties by @brunotacca in https://github.com/flutter/flutter/pull/98450
* [dap] Don't use --start-paused when running in Profile/Release mode by @DanTup in https://github.com/flutter/flutter/pull/98926
* Wait for ios-deploy stdout before closing logLine stream by @jmagman in https://github.com/flutter/flutter/pull/99041
* Work around VS CMake generation bug by @stuartmorgan in https://github.com/flutter/flutter/pull/98945
* Print events and views when first frame is taking awhile during tracing by @jmagman in https://github.com/flutter/flutter/pull/98957
* Revert "reads min/target sdk versions from localproperties" by @blasten in https://github.com/flutter/flutter/pull/99191
* Starts using the `--source` flag to compile the dart registrant. by @gaaclarke in https://github.com/flutter/flutter/pull/98046
* Update minimum required version to Xcode 13 by @jmagman in https://github.com/flutter/flutter/pull/97746
* Fix the race condition in cache_test.dart by @gspencergoog in https://github.com/flutter/flutter/pull/99423
* Fix custom-device default forwardPortSuccessRegex by @mbriand in https://github.com/flutter/flutter/pull/97719
* Add Windows performance benchmark by @jonahwilliams in https://github.com/flutter/flutter/pull/99564
* Add logging when first frame is not rendering by @jmagman in https://github.com/flutter/flutter/pull/99566
* [flutter_tools] Add timeout duration to error and handle exceptions for HttpHostValidator. by @RoyARG02 in https://github.com/flutter/flutter/pull/98290
* Support route on ios by @Jasguerrero in https://github.com/flutter/flutter/pull/99078
* Check string size before Win32 MultiByte <-> WideChar conversions by @cbracken in https://github.com/flutter/flutter/pull/99729
* Handle hidden dot files in iOS framework bundles by @jmagman in https://github.com/flutter/flutter/pull/99771
* Fix Typo by @Phelicks in https://github.com/flutter/flutter/pull/97793
* 95533 min sdk error msgs enhancements by @brunotacca in https://github.com/flutter/flutter/pull/99550
* Remove tool crash git.io link shortener by @jmagman in https://github.com/flutter/flutter/pull/99574
* Pass 'assume-initialize-from-dill-up-to-date' flag to the frontend server by @chingjun in https://github.com/flutter/flutter/pull/99791
* First pass at using platform abstraction for plugins by @fuzzybinary in https://github.com/flutter/flutter/pull/92672
* [tool] Add CADisableMinimumFrameDurationOnPhone to iOS templates by @cyanglaz in https://github.com/flutter/flutter/pull/94509
* Fix flutter web app not respecting assets path when in non-root folder by @nicolasvac in https://github.com/flutter/flutter/pull/96774
* Fix route integration test on ios by @Jasguerrero in https://github.com/flutter/flutter/pull/99781
* [flutter_tools] exec rather than spawn subprocess from bin/internal/shared.sh by @christopherfujino in https://github.com/flutter/flutter/pull/99871
* Add portForwarder for ProxiedDevice. by @chingjun in https://github.com/flutter/flutter/pull/100111
* Add more specific cause on web development tool error output by @yuseok in https://github.com/flutter/flutter/pull/98553
* MigrateConfig and migrate integration testing base by @GaryQian in https://github.com/flutter/flutter/pull/99092
* [macOS] Enable universal binary builds by default by @cbracken in https://github.com/flutter/flutter/pull/100271
* [flutter_tools] Null safe update packages by @christopherfujino in https://github.com/flutter/flutter/pull/99357
* Reintroduce the ability to override the coverage formatter by @liamappelbe in https://github.com/flutter/flutter/pull/100320
* [flutter_tools] check if stream is open before sending message in ios device by @christopherfujino in https://github.com/flutter/flutter/pull/99947
* Handle Flutter.Error events and disable structure errors for noDebug mode by @DanTup in https://github.com/flutter/flutter/pull/100149
* [flutter_tools] process exception during linux_doctor is handled by @Jasguerrero in https://github.com/flutter/flutter/pull/100159
* Specify destination when building for macOS by @dnfield in https://github.com/flutter/flutter/pull/100315
* Revert "Starts using the `--source` flag to compile the dart registrant. (#98046) by @gaaclarke in https://github.com/flutter/flutter/pull/100493
* Revert "[flutter_tools] remove pub dependencies from universal #97722" by @Jasguerrero in https://github.com/flutter/flutter/pull/100508
* [macOS] Use arm64 snapshot in arm64 App.framework by @cbracken in https://github.com/flutter/flutter/pull/100504
* Upgrade to flutter_lints 2.0 by @goderbauer in https://github.com/flutter/flutter/pull/99881
* [flutter_tools] Skip version freshness check for non-standard remotes by @RoyARG02 in https://github.com/flutter/flutter/pull/97202
* [dap] Remove some code that's not longer required by @DanTup in https://github.com/flutter/flutter/pull/98928
* Don't terminate Dart process pids from VM Service, record flutter_tools VM pid by @DanTup in https://github.com/flutter/flutter/pull/100223
* Remove the end period of a URL in project template by @asashour in https://github.com/flutter/flutter/pull/99816
* Filter out some stray Xcode logging during macOS builds by @jmagman in https://github.com/flutter/flutter/pull/100707
* [flutter_tools] Fix VersionUpstreamValidator to respect FLUTTER_GIT_URL by @RoyARG02 in https://github.com/flutter/flutter/pull/100605
* Add `CADisableMinimumFrameDurationOnPhone` migration by @cyanglaz in https://github.com/flutter/flutter/pull/100647
* [flutter_tool] Adds `--enable-impeller` flag to the run command by @zanderso in https://github.com/flutter/flutter/pull/100835
* Pass ARCHS build setting to flutter assemble on macOS by @jmagman in https://github.com/flutter/flutter/pull/100811
* [flutter_tools] warn when doctor takes long by @christopherfujino in https://github.com/flutter/flutter/pull/100805
* [macOS] Remove beta-quality wording from messages by @cbracken in https://github.com/flutter/flutter/pull/99699
* [Linux] Remove beta-quality wording from messages by @cbracken in https://github.com/flutter/flutter/pull/99700
* Set ARCHS to single-arch for local engine macOS builds by @jmagman in https://github.com/flutter/flutter/pull/100917
* [flutter_tool] Have long-running validators fail by @christopherfujino in https://github.com/flutter/flutter/pull/100936
* [flutter_conductor] Extend timeout for codesign integration test by @christopherfujino in https://github.com/flutter/flutter/pull/100940
* Migrate .packages -> package_config.json by @sigurdm in https://github.com/flutter/flutter/pull/99677
* Reland "Enable caching of CPU samples collected at application startup (#89600)" by @bkonyi in https://github.com/flutter/flutter/pull/100995
* Migrate AGP and Gradle versions to 7.1.2/7.4 by @blasten in https://github.com/flutter/flutter/pull/99723
* [web] flutter.js initialization with ui.webOnlyWarmupEngine by @ditman in https://github.com/flutter/flutter/pull/100177
* [winuwp] Add removal warning in config help text by @cbracken in https://github.com/flutter/flutter/pull/101086
* Retire v1 embedding compatibility from automatic multidex support by @GaryQian in https://github.com/flutter/flutter/pull/100685
* Prepare `flutter_tools` for `use_super_parameters` by @goderbauer in https://github.com/flutter/flutter/pull/100509
* [Revert] Skip overall_experience_test.dart: flutter run writes and clears pidfile appropriately by @keyonghan in https://github.com/flutter/flutter/pull/101267
* Add note to doctor validator if script is running Rosetta by @jmagman in https://github.com/flutter/flutter/pull/101309
* [Cherrypick] Partial revert of super params in tools (#101436) by @CaseyHillers in https://github.com/flutter/flutter/pull/101527
* [flutter_releases] Flutter beta 2.13.0-0.3.pre Framework Cherrypicks by @CaseyHillers in https://github.com/flutter/flutter/pull/102620

### MacOS

* [macOS] Add run release test in devicelab by @cbracken in https://github.com/flutter/flutter/pull/100526

## New Contributors

Thanks to the following contributors in this release:

* @willlockwood made their first contribution in https://github.com/flutter/flutter/pull/95537
* @utibeabasi6 made their first contribution in https://github.com/flutter/flutter/pull/96058
* @fbcouch made their first contribution in https://github.com/flutter/flutter/pull/75472
* @b-luk made their first contribution in https://github.com/flutter/flutter/pull/96483
* @WasserEsser made their first contribution in https://github.com/flutter/flutter/pull/96555
* @intspt made their first contribution in https://github.com/flutter/flutter/pull/95881
* @PoojaB26 made their first contribution in https://github.com/flutter/flutter/pull/94399
* @ipowell made their first contribution in https://github.com/flutter/flutter/pull/91899
* @swift-kim made their first contribution in https://github.com/flutter/flutter/pull/95450
* @Dan-Crane made their first contribution in https://github.com/flutter/flutter/pull/92959
* @SuhwanCha made their first contribution in https://github.com/flutter/flutter/pull/96574
* @Amir-P made their first contribution in https://github.com/flutter/flutter/pull/93312
* @jonas-martinez made their first contribution in https://github.com/flutter/flutter/pull/85954
* @caioagiani made their first contribution in https://github.com/flutter/flutter/pull/97488
* @MichaelTamm made their first contribution in https://github.com/flutter/flutter/pull/92660
* @cachapa made their first contribution in https://github.com/flutter/flutter/pull/95504
* @bannzai made their first contribution in https://github.com/flutter/flutter/pull/97897
* @gslender made their first contribution in https://github.com/flutter/flutter/pull/93833
* @brianquinlan made their first contribution in https://github.com/flutter/flutter/pull/98045
* @KristinBi made their first contribution in https://github.com/flutter/flutter/pull/98159
* @kirolous-nashaat made their first contribution in https://github.com/flutter/flutter/pull/93439
* @himamis made their first contribution in https://github.com/flutter/flutter/pull/95995
* @brunotacca made their first contribution in https://github.com/flutter/flutter/pull/98450
* @SimonHausdorf made their first contribution in https://github.com/flutter/flutter/pull/90109
* @Hari-07 made their first contribution in https://github.com/flutter/flutter/pull/98512
* @mbriand made their first contribution in https://github.com/flutter/flutter/pull/97719
* @r-mzy47 made their first contribution in https://github.com/flutter/flutter/pull/98389
* @Phelicks made their first contribution in https://github.com/flutter/flutter/pull/97793
* @nicolasvac made their first contribution in https://github.com/flutter/flutter/pull/96774
* @valentinmarq made their first contribution in https://github.com/flutter/flutter/pull/99682
* @jjoelson made their first contribution in https://github.com/flutter/flutter/pull/99987
* @SahajRana made their first contribution in https://github.com/flutter/flutter/pull/99822
* @yuseok made their first contribution in https://github.com/flutter/flutter/pull/98553
* @jellynoone made their first contribution in https://github.com/flutter/flutter/pull/99527
* @luckysmg made their first contribution in https://github.com/flutter/flutter/pull/99546
* @M97Chahboun made their first contribution in https://github.com/flutter/flutter/pull/100372
* @TytaniumDev made their first contribution in https://github.com/flutter/flutter/pull/99777

**Full Changelog**: https://github.com/flutter/flutter/compare/2.10.0...2.13.0-0.4.pre
