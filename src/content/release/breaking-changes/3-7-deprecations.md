---
title: Deprecated API removed after v3.7
description: >
  After reaching end of life, the following deprecated APIs
  were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
3.7 stable release have been removed.

All affected APIs have been compiled into this
primary source to aid in migration. A
[quick reference sheet][] is available as well.

[Deprecation Policy]: {{site.repo.flutter}}/blob/master/docs/contributing/Tree-hygiene.md#deprecations
[quick reference sheet]: /go/deprecations-removed-after-3-7

## Changes

This section lists the deprecations, listed by the affected class.

### `GestureRecognizer.kind` & subclasses

Supported by Flutter Fix: yes

`GestureRecognizer.kind` was deprecated in v2.3.
Use `GestureRecognizer.supportedDevices` instead.

This same change affects all subclasses of `GestureRecognizer`:

* `EagerGestureRecognizer`
* `ForcePressGestureRecognizer`
* `LongPressGestureRecognizer`
* `DragGestureRecognizer`
* `VerticalDragGestureRecognizer`
* `HorizontalDragGestureRecognizer`
* `MultiDragGestureRecognizer`
* `ImmediateMultiDragGestureRecognizer`
* `HorizontalMultiDragGestureRecognizer`
* `VerticalMultiDragGestureRecognizer`
* `DelayedMultiDragGestureRecognizer`
* `DoubleTapGestureRecognizer`
* `MultiTapGestureRecognizer`
* `OneSequenceGestureRecognizer`
* `PrimaryPointerGestureRecognizer`
* `ScaleGestureRecognizer`

This change allowed for multiple devices to be recognized for a gesture, rather
than the single option `kind` provided.

**Migration guide**

Code before migration:

```dart
var myRecognizer = GestureRecognizer(
  kind: PointerDeviceKind.mouse,  
);
```

Code after migration:

```dart
var myRecognizer = GestureRecognizer(
  supportedDevices: <PointerDeviceKind>[ PointerDeviceKind.mouse ],
);

```

**References**

API documentation:

* [`GestureRecognizer`][]
* [`EagerGestureRecognizer`][]
* [`ForcePressGestureRecognizer`][]
* [`LongPressGestureRecognizer`][]
* [`DragGestureRecognizer`][]
* [`VerticalDragGestureRecognizer`][]
* [`HorizontalDragGestureRecognizer`][]
* [`MultiDragGestureRecognizer`][]
* [`ImmediateMultiDragGestureRecognizer`][]
* [`HorizontalMultiDragGestureRecognizer`][]
* [`VerticalMultiDragGestureRecognizer`][]
* [`DelayedMultiDragGestureRecognizer`][]
* [`DoubleTapGestureRecognizer`][]
* [`MultiTapGestureRecognizer`][]
* [`OneSequenceGestureRecognizer`][]
* [`PrimaryPointerGestureRecognizer`][]
* [`ScaleGestureRecognizer`][]

Relevant PRs:

* Deprecated in [#81858][]
* Removed in [#119572][]

[`GestureRecognizer`]: {{site.api}}/flutter/gestures/GestureRecognizer-class.html
[`EagerGestureRecognizer`]: {{site.api}}/flutter/gestures/EagerGestureRecognizer-class.html
[`ForcePressGestureRecognizer`]: {{site.api}}/flutter/gestures/ForcePressGestureRecognizer-class.html
[`LongPressGestureRecognizer`]: {{site.api}}/flutter/gestures/LongPressGestureRecognizer-class.html
[`DragGestureRecognizer`]: {{site.api}}/flutter/gestures/DragGestureRecognizer-class.html
[`VerticalDragGestureRecognizer`]: {{site.api}}/flutter/gestures/VerticalDragGestureRecognizer-class.html
[`HorizontalDragGestureRecognizer`]: {{site.api}}/flutter/gestures/HorizontalDragGestureRecognizer-class.html
[`MultiDragGestureRecognizer`]: {{site.api}}/flutter/gestures/MultiDragGestureRecognizer-class.html
[`ImmediateMultiDragGestureRecognizer`]: {{site.api}}/flutter/gestures/ImmediateMultiDragGestureRecognizer-class.html
[`HorizontalMultiDragGestureRecognizer`]: {{site.api}}/flutter/gestures/HorizontalMultiDragGestureRecognizer-class.html
[`VerticalMultiDragGestureRecognizer`]: {{site.api}}/flutter/gestures/VerticalMultiDragGestureRecognizer-class.html
[`DelayedMultiDragGestureRecognizer`]: {{site.api}}/flutter/gestures/DelayedMultiDragGestureRecognizer-class.html
[`DoubleTapGestureRecognizer`]: {{site.api}}/flutter/gestures/DoubleTapGestureRecognizer-class.html
[`MultiTapGestureRecognizer`]: {{site.api}}/flutter/gestures/MultiTapGestureRecognizer-class.html
[`OneSequenceGestureRecognizer`]: {{site.api}}/flutter/gestures/OneSequenceGestureRecognizer-class.html
[`PrimaryPointerGestureRecognizer`]: {{site.api}}/flutter/gestures/PrimaryPointerGestureRecognizer-class.html
[`ScaleGestureRecognizer`]: {{site.api}}/flutter/gestures/ScaleGestureRecognizer-class.html


[#81858]: {{site.repo.flutter}}/pull/81858
[#119572]: {{site.repo.flutter}}/pull/119572

---

### `ThemeData` `accentColor`, `accentColorBrightness`, `accentColorTextTheme`, `accentColorIconTheme`, and `buttonColor`

Supported by Flutter Fix: yes

The `accentColor`, `accentColorBrightness`, `accentColorTextTheme`,
`accentColorIconTheme`, and `buttonColor` properties of `ThemeData` were
deprecated in v2.3.

This change better aligned `ThemeData` with Material Design guidelines. It also
created more clarity in theming by relying either on the core color scheme or
individual component themes for desired styling.

The `accentColorBrightness`, `accentColorTextTheme`,
`accentColorIconTheme`, and `buttonColor` are no longer used by the framework.
References should be removed.

Uses of `ThemeData.accentColor` should be replaced with
`ThemeData.colorScheme.secondary`.

## Migration guide

Code before migration:

```dart
var myTheme = ThemeData(
  //...
  accentColor: Colors.blue,
  //...
);
var color = myTheme.accentColor;
```

Code after migration:

```dart
var myTheme = ThemeData(
  //...
  colorScheme: ColorScheme(
    //...
    secondary:Colors.blue,
    //...
  ),
  //...
);
var color = myTheme.colorScheme.secondary;
```

**References**

* [Accent color migration guide][]

API documentation:

* [`ThemeData`][]
* [`ColorScheme`][]

Relevant issues:

* [#56639][]
* [#84748][]
* [#56918][]
* [#91772][]

Relevant PRs:

Deprecated in:

* [#92822][]
* [#81336][]
* [#85144][]

Removed in:

* [#118658][]
* [#119360][]
* [#120577][]
* [#120932][]

[Accent color migration guide]: /release/breaking-changes/theme-data-accent-properties
[`ThemeData`]: {{site.api}}/flutter/widgets/Draggable-class.html
[`ColorScheme`]: {{site.api}}/flutter/widgets/LongPressDraggable-class.html
[#56639]: {{site.repo.flutter}}/pull/56639
[#84748]: {{site.repo.flutter}}/pull/84748
[#56918]: {{site.repo.flutter}}/pull/56918
[#91772]: {{site.repo.flutter}}/pull/91772
[#92822]: {{site.repo.flutter}}/pull/92822
[#81336]: {{site.repo.flutter}}/pull/81336
[#85144]: {{site.repo.flutter}}/pull/85144
[#118658]: {{site.repo.flutter}}/pull/118658
[#119360]: {{site.repo.flutter}}/pull/119360
[#120577]: {{site.repo.flutter}}/pull/120577
[#120932]: {{site.repo.flutter}}/pull/120932

---

### `AppBar`, `SliverAppBar`, and `AppBarTheme` updates

Supported by Flutter Fix: yes

In v2.4, several changes were made ot the app bar classes and their themes to
better align with Material Design. Several properties were deprecated at that
time and have been removed.

For `AppBar`, `SliverAppBar` and `AppBarTheme`:

* `brightness` has been removed, and is replaced by `systemOverlayStyle`
* `textTheme` has been removed, and is replaced by either `toolbarTextStyle` or `titleTextStyle`.
* `backwardsCompatibility` can be removed, as it was a temporary migration flag for these properties.

Additionally, `AppBarTheme.color` was removed, with `AppBarTheme.backgroundColor`
as its replacement.

**Migration guide**

Code before migration:

```dart
var toolbarTextStyle = TextStyle(...);
var titleTextStyle = TextStyle(...);
AppBar(
  brightness: Brightness.light,
  textTheme: TextTheme(
    bodyMedium: toolbarTextStyle,
    titleLarge: titleTextStyle,
  )
  backwardsCompatibility: true,
);
AppBarTheme(color: Colors.blue);
```

Code after migration:

```dart
var toolbarTextStyle = TextStyle(...);
var titleTextStyle = TextStyle(...);
AppBar(
  systemOverlayStyle: SystemOverlayStyle(statusBarBrightness: Brightness.light),
  toolbarTextStyle: toolbarTextStyle,
  titleTextStyle: titleTextStyle,
);
AppBarTheme(backgroundColor: Colors.blue);
```

**References**

API documentation:

* [`AppBar`][]
* [`SliverAppBar`][]
* [`AppBarTheme`][]

Relevant issues:

* [#86127][]
* [#70645][]
* [#67921][]
* [#67497][]
* [#50606][]
* [#51820][]
* [#61618][]

Deprecated in:

* [#86198][]
* [#71184][]

Removed in:

* [#120618][]
* [#119253][]
* [#120575][]


[`AppBar`]: {{site.api}}/flutter/material/AppBar-class.html
[`SliverAppBar`]: {{site.api}}/flutter/material/SliverAppBar-class.html
[`AppBarTheme`]: {{site.api}}/flutter/material/AppBarTheme-class.html
[#86127]: {{site.repo.flutter}}/pull/86127
[#70645]: {{site.repo.flutter}}/pull/70645
[#67921]: {{site.repo.flutter}}/pull/67921
[#67497]: {{site.repo.flutter}}/pull/67497
[#50606]: {{site.repo.flutter}}/pull/50606
[#51820]: {{site.repo.flutter}}/pull/51820
[#61618]: {{site.repo.flutter}}/pull/61618
[#86198]: {{site.repo.flutter}}/pull/86198
[#71184]: {{site.repo.flutter}}/pull/71184
[#120618]: {{site.repo.flutter}}/pull/120618
[#119253]: {{site.repo.flutter}}/pull/119253
[#120575]: {{site.repo.flutter}}/pull/120575

---

### `SystemChrome.setEnabledSystemUIOverlays`

Supported by Flutter Fix: yes

In v2.3, `SystemChrome.setEnabledSystemUIOVerlays`, the static method for
setting device system level overlays like status and navigation bars, was
deprecated in favor of `SystemChrome.setEnabledSystemUIMode`.

This change allowed for setting up common fullscreen modes that match native
Android app designs like edge to edge.

Manually setting overlays, instead of choosing a specific mode, is still
supported through `SystemUiMode.manual`, allowing developers to pass the same
list of overlays as before.

**Migration guide**

Code before migration:
```dart
SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[
  SystemUiOverlay.top,
  SystemUiOverlay.bottom,
]);
```

Code after migration:
```dart
SystemChrome.setEnabledSystemUIMode(
  SystemUiMode.manual,
  overlays: <SystemUiOverlay>[
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ],
);
```

**References**

API documentation:

* [`SystemChrome`][]

Relevant issues:

* [#35748][]
* [#40974][]
* [#44033][]
* [#63761][]
* [#69999][]

Deprecated in:

* [#81303][]

Removed in:

* [#11957][]

[`SystemChrome`]: {{site.api}}/flutter/services/SystemChrome-class.html
[#35748]: {{site.repo.flutter}}/pull/35748
[#40974]: {{site.repo.flutter}}/pull/40974
[#44033]: {{site.repo.flutter}}/pull/44033
[#63761]: {{site.repo.flutter}}/pull/63761
[#69999]: {{site.repo.flutter}}/pull/69999
[#81303]: {{site.repo.flutter}}/pull/81303
[#11957]: {{site.repo.flutter}}/pull/11957

---

### `SystemNavigator.routeUpdated`

Supported by Flutter Fix: yes

In v2.3, `SystemNavigator.routeUpdated` was deprecated in favor of
`SystemNavigator.routeInformationUpdated`.

Instead of having two ways to update the engine about the current route, the
change moved everything to one API, which separately selects the single-entry
history mode if a `Navigator` that reports routes is created.

**Migration guide**

Code before migration:

```dart
SystemNavigator.routeUpdated(routeName: 'foo', previousRouteName: 'bar');
```

Code after migration:

```dart
SystemNavigator.routeInformationUpdated(location: 'foo');
```

**References**

API documentation:

* [`SystemNavigator`][]

Relevant issues:

* [#82574][]

Deprecated in:

* [#82594][]

Removed in:

* [#119187][]


[`SystemNavigator`]: {{site.api}}/flutter/services/SystemNavigator-class.html
[#82594]: {{site.repo.flutter}}/pull/82594
[#82574]: {{site.repo.flutter}}/pull/82574
[#119187]: {{site.repo.flutter}}/pull/119187

---

### `AnimatedSize.vsync`

Supported by Flutter Fix: yes

In v2.2, `AnimatedSize.vsyc` was deprecated. This property was no longer
necessary after `AnimatedSize` was converted to a `StatefulWidget` whose `State`
mixed in `SingleTickerProviderStateMixin`. The change was made to fix a memory
leak.

Uses of `vsync` should be removed, as `AnimatedSize` now handles this property.

**Migration guide**

Code before migration:

```dart
AnimatedSize(
  vsync: this,
  // ...
);
```

Code after migration:

```dart
AnimatedSize(
  // ...
);
```

**References**

API documentation:

* [`AnimatedSize`][]

Deprecated in:

* [#80554][]
* [#81067][]

Removed in:

* [#119186][]

[`AnimatedSize`]: {{site.api}}/flutter/widgets/AnimatedSize-class.html
[#80554]: {{site.repo.flutter}}/pull/80554
[#81067]: {{site.repo.flutter}}/pull/81067
[#119186]: {{site.repo.flutter}}/pull/119186

---

## Timeline

In stable release: 3.10
