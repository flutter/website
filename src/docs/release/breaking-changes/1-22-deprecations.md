---
title: Deprecated API removed after v1.22
description: After reaching end of life, the following deprecated APIs were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
1.22 stable release have been removed.
This is the first time deprecated APIs
have been removed from Flutter,
and some of these deprecations predate our
migration guide policy.

All affected APIs have been compiled into this
primary source to aid in migration. A
[quick reference sheet][] is available as well.

A [design document][] and [article][] are available
for more context on Flutter's deprecation policy.

[Deprecation Policy]: {{site.github}}/flutter/flutter/wiki/Tree-hygiene#deprecation
[quick reference sheet]: /go/deprecations-removed-after-1-22
[design document]: /go/deprecation-lifetime
[article]: {{site.flutter-medium}}/deprecation-lifetime-in-flutter-e4d76ee738ad

## Changes

This section lists the deprecations, listed by the affected class.

### `CupertinoDialog`

Supported by fix tool: IDE fix only.

`CupertinoDialog` was deprecated in v0.2.3.
Use `CupertinoAlertDialog` or `CupertinoPopupSurface` instead.

**Migration guide**

*CupertinoAlertDialog*

Code before migration:
<!-- skip -->
```dart
CupertinoDialog(child: myWidget);
```

Code after migration:
<!-- skip -->
```dart
CupertinoAlertDialog(content: myWidget);
```

*CupertinoPopupSurface*

Code before migration:
<!-- skip -->
```dart
CupertinoDialog(child: myWidget);
```

Code after migration:
<!-- skip -->
```dart
CupertinoPopupSurface(child: myWidget);
```

**References**

API documentation:
* [`CupertinoAlertDialog`][]
* [`CupertinoPopupSurface`][]

Relevant issues:
* [Deprecate CupertinoDialog class][]

Relevant PRs:
* Deprecated in [#20649][]
* Removed in [#73604][]

[`CupertinoAlertDialog`]: {{site.api}}/flutter/cupertino/CupertinoAlertDialog-class.html
[`CupertinoPopupSurface`]: {{site.api}}/flutter/cupertino/CupertinoPopupSurface-class.html
[Deprecate CupertinoDialog class]: {{site.github}}/flutter/flutter/issues/20397
[#20649]: {{site.github}}/flutter/flutter/pull/20649
[#73604]: {{site.github}}/flutter/flutter/pull/73604

---

### Cupertino navigation bars' `actionsForegroundColor`

Supported by fix tool: No

`CupertinoNavigationBar.actionsForegroundColor`
and `CupertinoSliverNavigationBar.actionsForegroundColor`
were deprecated in v1.1.2.
Setting `primaryColor` in your `CupertinoTheme` propagates this instead.
To access the `primaryColor`,
call `CupertinoTheme.of(context).primaryColor`.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
CupertinoNavigationBar(
  actionsForegroundColor: CupertinoColors.systemBlue,
);
CupertinoSliverNavigationBar(
  actionsForegroundColor: CupertinoColors.systemBlue,
);
```

Code after migration:
<!-- skip -->
```dart
CupertinoTheme(
  data: CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue
  ),
  child: ...
);

// To access the color from the `CupertinoTheme`
CupertinoTheme.of(context).primaryColor;
```

**References**

API documentation:
* [`CupertinoNavigationBar`][]
* [`CupertinoSliverNavigationBar`][]
* [`CupertinoTheme`][]
* [`CupertinoThemeData`][]

Relevant issues:
* [Create a CupertinoApp and a CupertinoTheme][]

Relevant PRs:
* Deprecated in [#23759][]
* Removed in [#73745][]

[`CupertinoNavigationBar`]: {{site.api}}/flutter/cupertino/CupertinoNavigationBar-class.html
[`CupertinoSliverNavigationBar`]: {{site.api}}/flutter/cupertino/CupertinoSliverNavigationBar-class.html
[`CupertinoTheme`]: {{site.api}}/flutter/cupertino/CupertinoTheme-class.html
[`CupertinoThemeData`]: {{site.api}}/flutter/cupertino/CupertinoThemeData-class.html
[Create a CupertinoApp and a CupertinoTheme]: {{site.github}}/flutter/flutter/issues/18037
[#23759]: {{site.github}}/flutter/flutter/pull/23759
[#73745]: {{site.github}}/flutter/flutter/pull/73745

---

### `CupertinoTextThemeData.brightness`

Supported by fix tool: Yes

`CupertinoTextThemeData.brightness` was deprecated in v1.10.14.
This field member was made ineffective at the time of deprecation.
There is no replacement for this
parameter, references should be removed.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
const CupertinoTextThemeData themeData = CupertinoTextThemeData(brightness: Brightness.dark);
themeData.copyWith(brightness: Brightness.light);
```

Code after migration:
<!-- skip -->
```dart
const CupertinoTextThemeData themeData = CupertinoTextThemeData();
themeData.copyWith();
```

**References**

API documentation:
* [`CupertinoTextThemeData`][]

Relevant issues:
* [Revise CupertinoColors and CupertinoTheme for dynamic colors][]

Relevant PRs:
* Deprecated in [#41859][]
* Removed in [#72017][]

[`CupertinoTextThemeData`]: {{site.api}}/flutter/cupertino/CupertinoTextThemeData-class.html
[Revise CupertinoColors and CupertinoTheme for dynamic colors]: {{site.github}}/flutter/flutter/issues/35541
[#41859]: {{site.github}}/flutter/flutter/pull/41859
[#72017]: {{site.github}}/flutter/flutter/pull/72017

---

### Pointer events constructed `fromHoverEvent`

Supported by fix tool: Yes
 
The `fromHoverEvent` constructors for `PointerEnterEvent`
and `PointerExitEvent` were deprecated in v1.4.3.
The `fromMouseEvent` constructor should be used instead.
 
**Migration guide**
 
Code before migration:
<!-- skip -->
```dart
final PointerEnterEvent enterEvent = PointerEnterEvent.fromHoverEvent(PointerHoverEvent());
final PointerExitEvent exitEvent = PointerExitEvent.fromHoverEvent(PointerHoverEvent());
```
 
Code after migration:
<!-- skip -->
```dart
final PointerEnterEvent enterEvent = PointerEnterEvent.fromMouseEvent(PointerHoverEvent());
final PointerExitEvent exitEvent = PointerExitEvent.fromMouseEvent(PointerHoverEvent());
```
 
**References**
 
API documentation:
* [`PointerEnterEvent`][]
* [`PointerExitEvent`][]
 
Relevant issues:
* [PointerEnterEvent and PointerExitEvent can only
  be created from hover events][]
 
Relevant PRs:
* Deprecated in [#28602][]
* Removed in [#72395][]
 
[`PointerEnterEvent`]: {{site.api}}/flutter/gestures/PointerEnterEvent-class.html
[`PointerExitEvent`]: {{site.api}}/flutter/gestures/PointerExitEvent-class.html
[PointerEnterEvent and PointerExitEvent can only be created from hover events]: {{site.github}}/flutter/flutter/issues/29696
[#28602]: {{site.github}}/flutter/flutter/pull/28602
[#72395]: {{site.github}}/flutter/flutter/pull/72395

---

### `showDialog` uses `builder`

Supported by fix tool: Yes
 
The `child` parameter of `showDialog` was deprecated in in v0.2.3.
The `builder` parameter should be used instead.
 
**Migration guide**
 
Code before migration:
<!-- skip -->
```dart
showDialog(child: myWidget);
```
 
Code after migration:
<!-- skip -->
```dart
showDialog(builder: (context) => myWidget);
```
 
**References**
 
API documentation:
* [`showDialog`][]
 
Relevant issues:
* [showDialog should take a builder rather than a child][]
 
Relevant PRs:
* Deprecated in [#15303][]
* Removed in [#72532][]
 
[`showDialog`]: {{site.api}}/flutter/material/showDialog.html
[showDialog should take a builder rather than a child]: {{site.github}}/flutter/flutter/issues/14341
[#15303]: {{site.github}}/flutter/flutter/pull/15303
[#72532]: {{site.github}}/flutter/flutter/pull/72532

---

### `Scaffold.resizeToAvoidBottomPadding`

Supported by fix tool: Yes
 
The `resizeToAvoidBottomPadding` parameter of `Scaffold` was deprecated in in v1.1.9.
The `resizeToAvoidBottomInset` parameter should be used instead.
 
**Migration guide**
 
Code before migration:
<!-- skip -->
```dart
Scaffold(resizeToAvoidBottomPadding: true);
```
 
Code after migration:
<!-- skip -->
```dart
Scaffold(resizeToAvoidBottomInset: true);
```
 
**References**
 
API documentation:
* [`Scaffold`][]
 
Relevant issues:
* [Show warning when nesting Scaffolds][]
* [SafeArea with keyboard][]
* [Double stacked material scaffolds shouldn't double resizeToAvoidBottomPadding][]
* [viewInsets and padding on Window and MediaQueryData should define how they interact][]
* [bottom overflow issue, when using textfields inside tabbarview][]
 
Relevant PRs:
* Deprecated in [#26259][]
* Removed in [#72890][]
 
[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html
[Show warning when nesting Scaffolds]: {{site.github}}/flutter/flutter/issues/23106
[SafeArea with keyboard]: {{site.github}}/flutter/flutter/issues/25758
[Double stacked material scaffolds shouldn't double resizeToAvoidBottomPadding]: {{site.github}}/flutter/flutter/issues/12084
[viewInsets and padding on Window and MediaQueryData should define how they interact]: {{site.github}}/flutter/flutter/issues/15424
[bottom overflow issue, when using textfields inside tabbarview]: {{site.github}}/flutter/flutter/issues/20295
[#26259]: {{site.github}}/flutter/flutter/pull/26259
[#72890]: {{site.github}}/flutter/flutter/pull/72890

---

### `ButtonTheme.bar`

Supported by fix tool: No
 
The `bar` constructor of `ButtonTheme` was deprecated in in v1.9.1.
`ButtonBarTheme` can be used instead for `ButtonBar`s,
or use another constructor of `ButtonTheme`
if the use is not specific to `ButtonBar`.

Button-specific theming is also available with the `TextButtonTheme`,
`ElevatedButtonTheme`, and `OutlinedButtonTheme` classes,
each corresponding with the appropriate button class,
`TextButton`, `ElevatedButton` and `OutlinedButton`.
 
**Migration guide**
 
Code before migration:
<!-- skip -->
```dart
ButtonTheme.bar(
  minWidth: 10.0,
  alignedDropdown: true,
  height: 40.0,
);
```
 
Code after migration, using `ButtonTheme`:
<!-- skip -->
```dart
ButtonTheme(
  minWidth: 10.0,
  alignedDropdown: true,
  height: 40.0,
);
```

Code after migration, using `ButtonBarTheme`:
<!-- skip -->
```dart
ButtonBarTheme(
  data: ButtonBarThemeData(
    buttonMinWidth: 10.0,
    buttonAlignedDropdown: true,
    buttonHeight: 40.0,
  )
);
```
 
**References**
 
API documentation:
* [`ButtonTheme`][]
* [`ButtonBarTheme`][]
* [`ButtonBar`][]
* [`TextButtonTheme`][]
* [`TextButton`][]
* [`ElevatedButtonTheme`][]
* [`ElevatedButton`][]
* [`OutlinedButtonTheme`][]
* [`OutlinedButton`][]
 
Relevant issues:
* [ButtonTheme.bar uses accent color when it should be using primary color][]
* [ThemeData.accentColor has insufficient contrast for text][]
* [Increased height as a result of changes to materialTapTargetSize affecting AlertDialog/ButtonBar heights][]
 
Relevant PRs:
* Deprecated in [#37544][]
* Removed in [#73746][]
 
[`ButtonTheme`]: {{site.api}}/flutter/material/ButtonTheme-class.html
[`ButtonBarTheme`]: {{site.api}}/flutter/material/ButtonBarTheme-class.html
[`ButtonBar`]: {{site.api}}/flutter/material/ButtonBar-class.html
[`TextButtonTheme`]: {{site.api}}/flutter/material/TextButtonTheme-class.html 
[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html 
[`ElevatedButtonTheme`]: {{site.api}}/flutter/material/ElevatedButtonTheme-class.html 
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html 
[`OutlinedButtonTheme`]: {{site.api}}/flutter/material/OutlinedButtonTheme-class.html 
[`OutlinedButton`]: {{site.api}}/flutter/material/OutlinedButton-class.html 
[ButtonTheme.bar uses accent color when it should be using primary color]: {{site.github}}/flutter/flutter/issues/31333
[ThemeData.accentColor has insufficient contrast for text]: {{site.github}}/flutter/flutter/issues/19946
[Increased height as a result of changes to materialTapTargetSize affecting AlertDialog/ButtonBar heights]: {{site.github}}/flutter/flutter/issues/20585
[#37544]: {{site.github}}/flutter/flutter/pull/37544
[#73746]: {{site.github}}/flutter/flutter/pull/73746

---

### `InlineSpan`, `TextSpan`, `PlaceholderSpan`

Supported by fix tool: No
 
The following methods were deprecated in the `InlineSpan`, `TextSpan` and `PlaceholderSpan` in order
to enable embedding widgets inline into paragraphs, like images. 
 
**Migration guide**
 
Code before migration | Code after migration
-- | --
`InlineSpan.text` | `TextSpan.text`
`InlineSpan.children` | `TextSpan.children`
`InlineSpan.visitTextSpan` | `InlineSpan.visitChildren`
`InlineSpan.recognizer` | `TextSpan.recognizer`
`InlineSpan.describeSemantics` | `InlineSpan.computeSemanticsInformation`
`PlaceholderSpan.visitTextSpan` | `PlaceHolderSpan.visitChildren`
`TextSpan.visitTextSpan` |  `TextSpan.visitChildren`
 
**References**
 
API documentation:
* [`InlineSpan`][]
* [`TextSpan`][]
* [`PlaceholderSpan`][]
* [`WidgetSpan`][]
 
Relevant issues:
* [Text: support inline images][]

Relevant PRs:
* Development history:
  * [#30069][]
  * [#33946][]
  * [#33794][]
* Deprecated in [#34051][]
* Removed in [#73747][]
 
[`InlineSpan`]: {{site.api}}/flutter/painting/InlineSpan-class.html
[`TextSpan`]: {{site.api}}/flutter/painting/TextSpan-class.html
[`PlaceholderSpan`]: {{site.api}}/flutter/painting/PlaceholderSpan-class.html
[`WidgetSpan`]: {{site.api}}/flutter/widgets/WidgetSpan-class.html
[Text: support inline images]: {{site.github}}/flutter/flutter/issues/2022
[#30069]: {{site.github}}/flutter/flutter/pull/30069
[#33946]: {{site.github}}/flutter/flutter/pull/33946
[#33794]: {{site.github}}/flutter/flutter/pull/33794
[#34051]: {{site.github}}/flutter/flutter/pull/34051
[#73747]: {{site.github}}/flutter/flutter/pull/73747

---

### `RenderView.scheduleInitialFrame`

Supported by fix tool: No
 
The `RenderView.scheduleInitialFrame` method was deprecated and removed in order to prevent
splash screens from being taken down too early, resulting in a black screen. This would happen when
`WidgetsFlutterBinding.ensureInitialized` was called. Instead, replace calls to this method with
`RenderView.prepareInitialFrame`, followed by `RenderView.owner.requestVisualUpdate`.
 
**Migration guide**
 
Code before migration:
<!-- skip -->
```dart
scheduleInitialFrame();
```
 
Code after migration:
<!-- skip -->
```dart
prepareInitialFrame();	
owner.requestVisualUpdate();
```
 
**References**
 
API documentation:
* [`RenderView`][]
* [`WidgetsFlutterBinding`][]
 
Relevant issues:
* [WidgetsFlutterBinding.ensureInitialized() takes down splash screen too early][]

Relevant PRs:
* Deprecated in [#39535][]
* Removed in [#73748][]
 
[`RenderView`]: {{site.api}}/flutter/rendering/RenderView-class.html
[`TextSpan`]: {{site.api}}/flutter/widgets/WidgetsFlutterBinding-class.html
[`WidgetsFlutterBinding`]: {{site.api}}/flutter/widgets/WidgetsFlutterBinding-class.html
[WidgetsFlutterBinding.ensureInitialized() takes down splash screen too early]: {{site.github}}/flutter/flutter/issues/39494
[#39535]: {{site.github}}/flutter/flutter/pull/39535
[#73748]: {{site.github}}/flutter/flutter/pull/73748

---

### `Layer.findAll`

Supported by fix tool: No

The `Layer.findAll` method was deprecated with the introduction of `Layer.findAnnotations` in order
to unify the implementations of `find` and `findAll`. To migrate affected code, call
`findAllAnnotations` instead. This method returns an `AnnotationResult`, containing the former
return value of `findAll` in `AnnotationResult.annotations`.

 
**Migration guide**
 
Code before migration:
<!-- skip -->
```dart
findAll(offset);
```
 
Code after migration:
<!-- skip -->
```dart
findAllAnnotations(offset).annotations;
```
 
**References**
 
API documentation:
* [`Layer`][]
* [`MouseRegion`][]
* [`RenderMouseRegion`][]
* [`AnnotatedRegionLayer`][]
* [`AnnotationResult`][]
 
Relevant issues:
* [Breaking Proposal: MouseRegion defaults to opaque; Layers are required to implement findAnnotations][]

Relevant PRs:
* Initially changed in [#37896][]
* Deprecated in [#42953][]
* Removed in [#73749][]
 
[`Layer`]: {{site.api}}/flutter/rendering/Layer-class.html
[`MouseRegion`]: {{site.api}}/flutter/widgets/MouseRegion-class.html
[`RenderMouseRegion`]: {{site.api}}/flutter/rendering/RenderMouseRegion-class.html
[`AnnotatedRegionLayer`]: {{site.api}}/flutter/rendering/AnnotatedRegionLayer-class.html
[`AnnotationResult`]: {{site.api}}/flutter/rendering/AnnotationResult-class.html
[Breaking Proposal: MouseRegion defaults to opaque; Layers are required to implement findAnnotations]: {{site.github}}/flutter/flutter/issues/38488
[#37896]: {{site.github}}/flutter/flutter/pull/37896
[#42953]: {{site.github}}/flutter/flutter/pull/42953
[#73749]: {{site.github}}/flutter/flutter/pull/73749

---

### `BinaryMessages`

Supported by fix tool: No

The `BinaryMessages` class, its associated static methods and the `defaultBinaryMessenger` getter
were deprecated and removed. The `defaultBinaryMessenger` instance was moved to `ServicesBinding`.
This made it possible to register a different default `BinaryMessenger` under testing environment,
by creating a `ServicesBinding` subclass for testing. Doing so allows you to track the number of
pending platform messages for synchronization purposes.

 
**Migration guide**
 
Code before migration: | Code after migration:
-- | --
`defaultBinaryMessenger` | `ServicesBinding.instance.defaultBinaryMessenger`
`BinaryMessages` | `BinaryMessenger`
`BinaryMessages.handlePlatformMessage` | `ServicesBinding.instance.defaultBinaryMessenger.handlePlatformMessage`
`BinaryMessages.send` | `ServicesBinding.instance.defaultBinaryMessenger.send`
`BinaryMessages.setMessageHandler` | `ServicesBinding.instance.defaultBinaryMessenger.setMessageHandler`
`BinaryMessages.setMockMessageHandler` | `ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler`
 
**References**
 
API documentation:
* [`ServicesBinding`][]
* [`BinaryMessenger`][]
 
Relevant issues:
* [Flutter synchronization support for Espresso/EarlGrey][]

Relevant PRs:
* Initially changed in [#37489][]
* Deprecated in [#38464][]
* Removed in [#73750][]
 
[`ServicesBinding`]: {{site.api}}/flutter/services/ServicesBinding-mixin.html
[`BinaryMessenger`]: {{site.api}}/flutter/services/BinaryMessenger-class.html
[Flutter synchronization support for Espresso/EarlGrey]: {{site.github}}/flutter/flutter/issues/37409
[#37489]: {{site.github}}/flutter/flutter/pull/37489
[#38464]: {{site.github}}/flutter/flutter/pull/38464
[#73750]: {{site.github}}/flutter/flutter/pull/73750

---

### Generic methods for `BuildContext`

Supported by fix tool: Yes

Several methods in `BuildContext` were using `Type` to search for ancestors. Most of those methods
implied a cast at call site because their return type was a parent type. Moreover the type provided
was not checked at analysis time even if the type is actually constrained. Making these methods
generics improves type safety and requires less code.

These method changes affect the `BuildContext`, `Element`, and `StatefulElement` classes. The
`TypeMatcher` class was also removed.

 
**Migration guide**

Code before migration:
<!-- skip -->
```dart
ComplexLayoutState state = context.ancestorStateOfType(const TypeMatcher<ComplexLayoutState>()) as ComplexLayoutState;
```

Code after migration:
<!-- skip -->
```dart
ComplexLayoutState state = context.ancestorStateOfType<ComplexLayoutState>();
```

`BuildContext`

Code before migration: | Code after migration:
--  | --
`inheritFromElement` | `dependOnInheritedElement`
`inheritFromWidgetOfExactType` | `dependOnInheritedWidgetOfExactType`
`ancestorInheritedElementForWidgetOfExactType` | `getElementForInheritedWidgetOfExactType`
`ancestorWidgetOfExactType` | `findAncestorWidgetOfExactType`
`ancestorStateOfType` | `findAncestorStateOfType`
`rootAncestorStateOfType` | `findRootAncestorStateOfType`
`ancestorRenderObjectOfType` | `findAncestorRenderObjectOfType`

`Element`

Code before migration: | Code after migration:
--  | --
`inheritFromElement` | `dependOnInheritedElement`
`inheritFromWidgetOfExactType` | `dependOnInheritedWidgetOfExactType`
`ancestorInheritedElementForWidgetOfExactType` | `getElementForInheritedWidgetOfExactType`
`ancestorWidgetOfExactType` | `findAncestorWidgetOfExactType`
`ancestorStateOfType` | `findAncestorStateOfType`
`rootAncestorStateOfType` | `findRootAncestorStateOfType`
`ancestorRenderObjectOfType` | `findAncestorRenderObjectOfType`

`StatefulElement`

Code before migration: | Code after migration:
--  | --
`inheritFromElement` | `dependOnInheritedElement`
 
**References**
 
API documentation:
* [`Type`][]
* [`BuildContext`][]
* [`Element`][]
* [`StatefulElement`][]

Relevant PRs:
* Deprecated in [#44189][]
* Removed in:
  * [#69620][]
  * [#72903][]
  * [#72901][]
  * [#73751][]
 
[`Type`]: {{site.api}}/flutter/dart-core/Type-class.html
[`BuildContext`]: {{site.api}}/flutter/widgets/BuildContext-class.html
[`Element`]: {{site.api}}/flutter/widgets/Element-class.html
[`StatefulElement`]: {{site.api}}/flutter/widgets/StatefulElement-class.html
[#44189]: {{site.github}}/flutter/flutter/pull/44189
[#69620]: {{site.github}}/flutter/flutter/pull/69620
[#72903]: {{site.github}}/flutter/flutter/pull/72903
[#72901]: {{site.github}}/flutter/flutter/pull/72901
[#73751]: {{site.github}}/flutter/flutter/pull/73751

---

### `WidgetsBinding.deferFirstFrameReport` & `WidgetsBinding.allowFirstFrameReport`

Supported by fix tool: Yes

The `deferFirstFrameReport` and `allowFirstFrameReport` methods of `WidgetsBinding` were deprecated
and removed in order to provide the option to delay rendering the first frame. This is useful for
widgets that need to obtain initialization information asynchronously and while they are waiting for
that information no frame should render as that would take down the splash screen pre-maturely.
The `deferFirstFrame` and `allowFirstFrame` methods should be used respectively instead.
 
**Migration guide**
 
Code before migration:
<!-- skip -->
```dart
final WidgetsBinding binding = WidgetsBinding.instance;
binding.deferFirstFrameReport();
binding.allowFirstFrameReport();
```
 
Code after migration:
<!-- skip -->
```dart
final WidgetsBinding binding = WidgetsBinding.instance;
binding.deferFirstFrame();
binding.allowFirstFrame();
```
 
**References**
 
API documentation:
* [`WidgetsBinding`][]
 
Relevant PRs:
* Initially changed in
  * [#45135][]
  * [#45588][]
* Deprecated in [#45941][]
* Removed in [#72893][]
 
[`WidgetsBinding`]: {{site.api}}/flutter/widgets/WidgetsBinding-mixin.html
[#45135]: {{site.github}}/flutter/flutter/pull/45135
[#45588]: {{site.github}}/flutter/flutter/pull/45588
[#45941]: {{site.github}}/flutter/flutter/pull/45941
[#72893]: {{site.github}}/flutter/flutter/pull/72893

---

### `WaitUntilNoTransientCallbacks`, `WaitUntilNoPendingFrame`, & `WaitUntilFirstFrameRasterized`

Supported by fix tool: No

The `WaitUntilNoTransientCallbacks`, `WaitUntilNoPendingFrame`, and `WaitUntilFirstFrameRasterized`
methods from the `flutter_driver` packages were deprecated and removed in order to provide a more
composable `waitForCondition` API that can be used to compose conditions that the client would like
to wait for.
 
**Migration guide**
 
Code before migration: | Code after migration:
-- | --
`WaitUntilNoTransientCallbacks` | `WaitForCondition(NoTransientCallbacks())`
`WaitUntilNoPendingFrame` | `WaitForCondition(NoPendingFrame())`
`WaitUntilFirstFrameRasterized` | `WaitForCondition(FirstFrameRasterized))`
 
**References**
 
API documentation:
* [`WaitForCondition`][]

Relevant issues:
* [Flutter synchronization support for Espresso/EarlGrey][]
 
Relevant PRs:
* Initially changed in [#37736][]
* Deprecated in [#38836][]
* Removed in [#73754][]
 
[`WaitForCondition`]: {{site.api}}/flutter/flutter_driver/WaitForCondition-class.html
[#37736]: {{site.github}}/flutter/flutter/pull/37736
[#38836]: {{site.github}}/flutter/flutter/pull/38836
[#73754]: {{site.github}}/flutter/flutter/pull/73754

---

## Timeline

In stable release: 2.0.0
