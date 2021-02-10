---
title: Deprecated API removed after v1.22
description: After reaching end of life, the following deprecated APIs were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][], deprecated APIs that reached end of life after the
1.22 stable release have been removed. This is the first time deprecated APIs have been removed from
Flutter, and some of these deprecations pre-date our migration guide policy.

All affected APIs have been compiled into this primary source to aid in migration. A
[quick reference sheet] is available as well.

A [design document] and [article] are available for more context on Flutter's deprecation policy.

[Deprecation Policy]: {{site.github}}/flutter/flutter/wiki/Tree-hygiene#deprecation
[quick reference sheet]: /go/deprecations-removed-after-1-22
[design document]: /go/flutter-deprecation-lifetime
[article]: https://medium.com/flutter/deprecation-lifetime-in-flutter-e4d76ee738ad

## Changes

### `CupertinoDialog`

Supported by fix tool: IDE fix only.

`CupertinoDialog` was deprecated in v0.2.3.
`CupertinoAlertDialog` or `CupertinoPopupSurface` should be used instead.

#### Migration guide

**CupertinoAlertDialog**

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

**CupertinoPopupSurface**

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

#### References

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

### Cupertino Navigation Bars' `actionsForegroundColor`

Supported by fix tool: No

`CupertinoNavigationBar.actionsForegroundColor` and `CupertinoSliverNavigationBar.actionsForegroundColor`
were deprecated in v1.1.2.
Setting `primaryColor` in your `CupertinoTheme` propagates this instead. To access the
`primaryColor`, call `CupertinoTheme.of(context).primaryColor`.

#### Migration Guide

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

#### References

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
This field member was made ineffective at the time of deprecation. There is no replacement for this
parameter, references should be removed.

#### Migration Guide

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

#### References

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

### Pointer Events Constructed `fromHoverEvent`

Supported by fix tool: Yes
 
The `fromHoverEvent` constructors for `PointerEnterEvent` and `PointerExitEvent` were deprecated
in v1.4.3.
The `fromMouseEvent` constructor should be used instead.
 
#### Migration Guide
 
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
 
#### References
 
API documentation:
* [`PointerEnterEvent`][]
* [`PointerExitEvent`][]
 
Relevant issues:
* [PointerEnterEvent and PointerExitEvent can only be created from hover events][]
 
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
 
#### Migration Guide
 
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
 
#### References
 
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
 
#### Migration Guide
 
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
 
#### References
 
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
`ButtonBarTheme` can be used instead for `ButtonBar`s, or use another constructor of `ButtonTheme`
if the use is not specific to `ButtonBar`.
 
#### Migration Guide
 
Code before migration:
<!-- skip -->
```dart

```
 
Code after migration:
<!-- skip -->
```dart

```
 
#### References
 
API documentation:
* [``][]
 
Relevant issues:
* [][]
 
Relevant PRs:
* Deprecated in [#][]
* Removed in [#72890][]
 
[``]: {{site.api}}/flutter/material/Scaffold-class.html
[]: {{site.github}}/flutter/flutter/issues/23106
[#]: {{site.github}}/flutter/flutter/pull/26259
[#]: {{site.github}}/flutter/flutter/pull/72890

---

## Timeline

In stable release: TBD
