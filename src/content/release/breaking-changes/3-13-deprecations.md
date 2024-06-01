---
title: Deprecated API removed after v3.13
description: >-
  After reaching end of life, the following deprecated APIs
  were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
3.13 stable release have been removed.

All affected APIs have been compiled into this
primary source to aid in migration.
To further aid your migration, check out this
[quick reference sheet][].

[Deprecation Policy]: {{site.repo.flutter}}/blob/master/docs/contributing/Tree-hygiene.md#deprecations
[quick reference sheet]: /go/deprecations-removed-after-3-13

## Changes

This section lists the deprecations by the package and affected class.

### Chip classes' useDeleteButtonTooltip

Package: flutter
Supported by Flutter Fix: yes

The `useDeleteButtonTooltip` property of the following classes was deprecated
in v2.10:

* `DeletableChipAttributes`
* `Chip`
* `RawChip`
* `InputChip`

`deleteButtonTooltipMessage` replaces `useDeleteButtonTooltip`. This change simplified the
API, as providing an empty String to `deleteButtonTooltipMessage` achieves the
same result as setting the original property `useDeleteButtonTooltip` to false.
When `deleteButtonTooltipMessage` is unset, the
`MaterialLocalizations.deleteButtonTooltip` is used by default.

The [Deprecate `useDeleteButtonTooltip` for Chips][] design document 
covers this update to chips and tooltips in greater depth.
To learn more, check out the [chips and tooltips migration guide][].

[Deprecate `useDeleteButtonTooltip` for Chips]: https://docs.google.com/document/d/1wc9ot7T2E7hJubYxEWMX230a79wYSiFey4BHxnEzHtw/edit?usp=sharing&resourcekey=0-Bo7KPqEtkWgZcSuRCqwQ5w
[chips and tooltips migration guide]: /release/breaking-changes/chip-usedeletebuttontooltip-migration

**Migration guide**

Code before migration:

```dart
Chip(useDeleteButtonTooltip: false);
InputChip(useDeleteButtonTooltip: true);
RawChip rawChip = RawChip();
rawChip.useDeleteButtonTooltip;
```

Code after migration:

```dart
Chip(deleteButtonTooltipMessage: '');
InputChip();
RawChip rawChip = RawChip();
rawChip.deleteButtonTooltipMessage;
```

**References**

API documentation:

* [`DeletableChipAttributes`][]
* [`Chip`][]
* [`RawChip`][]
* [`InputChip`][]
* [`MaterialLocalizations.deleteButtonTooltip`][]

Relevant PRs:

* Deprecated in [#96174][]
* Removed in [#134486][]

[`DeletableChipAttributes`]: {{site.api}}/flutter/material/DeletableChipAttributes-class.html
[`Chip`]: {{site.api}}/flutter/material/Chip-class.html
[`RawChip`]: {{site.api}}/flutter/material/RawChip-class.html
[`InputChip`]: {{site.api}}/flutter/material/InputChip-class.html
[`MaterialLocalizations.deleteButtonTooltip`]: {{site.api}}/flutter/material/MaterialLocalizations/deleteButtonTooltip.html

[#96174]: {{site.repo.flutter}}/pull/96174
[#134486]: {{site.repo.flutter}}/pull/134486

---

### MaterialButtonWithIconMixin

Package: flutter
Supported by Flutter Fix: no

The `MaterialButtonWithIconMixin` property was deprecated in v2.11.

With the introduction of new button classes `TextButton`, `OutlinedButton` and `ElevatedButton`,
this mixin is no longer used.
An earlier release removed old button classes that used this mixin.
As a result, this mixin no longer affects any classes that might mix it in.

**Migration guide**

Code before migration:

```dart
class MyButtonClass extends StatelessWidget with MaterialButtonWithIconMixin {
  // ...
}
```

Code after migration:

```dart
class MyButtonClass extends StatelessWidget {
  // ...
}
```

**References**

Relevant PRs:

* Deprecated in [#99088][]
* Removed in [#133173][]

[#99088]: {{site.repo.flutter}}/pull/99088
[#133173]: {{site.repo.flutter}}/pull/133173

---

### PlatformsViewsService.synchronizeToNativeViewHierarchy

Package: flutter
Supported by Flutter Fix: no

The static method `synchronizeToNativeViewHierarchy` of `PlatformsViewsService`
was deprecated in v2.11.

During the deprecation period, the method was a no-op function as it was no
longer required to call for performance improvements.
References to the method should be removed and won't impact the application.

**Migration guide**

Code before migration:

```dart
await PlatformsViewsService.synchronizeToNativeViewHierarchy(false);
````

Code after migration:

```dart
```

**References**

API documentation:

* [`PlatformViewsService`][]

Relevant PRs:

* Deprecated in [#100990][]
* Removed in [#133175][]

[`PlatformViewsService`]: {{site.api}}/flutter/services/PlatformViewsService-class.html

[#100990]: {{site.repo.flutter}}/pull/100990
[#133175]: {{site.repo.flutter}}/pull/133175

---

### TextSelectionOverlay.fadeDuration

Package: flutter
Supported by Flutter Fix: yes

The static `fadeDuration` property of `TextSelectionOverlay` was deprecated
in v2.12.

The `SelectionOverlay.fadeDuration` property replaces `TextSelectionOverlay.fadeDuration`.
With the `TextSelectionOverlay` refactor,
`SelectionOverlay` was added as a more generic widget without
the specific dependency on `RenderEditable`.

**Migration guide**

Code before migration:

```dart
TextSelectionOverlay.fadeDuration;
```

Code after migration:

```dart
SelectionOverlay.fadeDuration;
```

**References**

API documentation:

* [`TextSelectionOverlay`][]
* [`SelectionOverlay`][]

Relevant PRs:

* Deprecated in [#100381][]
* Removed in [#134485][]

[`TextSelectionOverlay`]: {{site.api}}/flutter/widgets/TextSelectionOverlay-class.html
[`SelectionOverlay`]: {{site.api}}/flutter/widgets/SelectionOverlay-class.html

[#100381]: {{site.repo.flutter}}/pull/100381
[#134485]: {{site.repo.flutter}}/pull/134485

---

### androidOverscrollIndicator

Package: flutter
Supported by Flutter Fix: no

The `androidOverscrollIndicator` property of the following classes was
deprecated in v2.13:

* `ScrollBehavior`
* `MaterialScrollBehavior`
* `ThemeData`

This flag was introduced to allow users to configure scrolling widgets to use
the `GlowingOverscrollIndicator` or the `StretchingOvercrollIndicator`.
It was deprecated in favor of the `ThemeData.useMaterial3` flag
as the framework introduced more support for Material 3-styled widgets.

Since `ThemeData.useMaterial3` is `true` by default,
the `StretchingOverscrollIndicator` is applied by default.
Setting this value to `false` will apply a `GlowingOverscrollIndicator` instead.

Alternatively, the `buildOverscrollIndicator` method of `ScrollBehavior` or
`MaterialScrollBehavior` can be overridden to further alter the appearance of
overscroll indicators.

**Migration guide**

Code before migration:

```dart
MaterialApp(
  scrollBehavior: MaterialScrollBehavior(
    androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
  ),
  //...
);

MaterialApp(
  scrollBehavior: ScrollBehavior(
    androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
  ),
  //...
);

MaterialApp(
  theme: Theme.light().copyWith(
    androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
  ),
  //...
);
```

Code after migration:

```dart
MaterialApp(
  theme: Theme.light().copyWith(
    // defaults to true and stretching indicator,
    // false results in glowing indicator
    useMaterial3: false,
  ),
  //...
);
```

**References**

API documentation:

* [`ScrollBehavior`][]
* [`MaterialScrollBehavior`][]
* [`ThemeData`][]
* [`GlowingOverscrollIndicator`][]
* [`StretchingOverscrollIndicator`][]

Relevant PRs:

* Deprecated in [#100234][]
* Removed in [#133181][]

[`ScrollBehavior`]: {{site.api}}/flutter/widgets/ScrollBehavior-class.html
[`MaterialScrollBehavior`]: {{site.api}}/flutter/material/MaterialScrollBehavior-class.html
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
[`GlowingOverscrollIndicator`]: {{site.api}}/flutter/widgets/GlowingOverscrollIndicator-class.html
[`StretchingOverscrollIndicator`]: {{site.api}}/flutter/widgets/StretchingOverscrollIndicator-class.html

[#100234]: {{site.repo.flutter}}/pull/100234
[#133181]: {{site.repo.flutter}}/pull/133181

---

### Updates to ImageProvider and PaintingBinding

Package: flutter
Supported by Flutter Fix: no

The `instantiateImageCodec` method of `PaintingBinding`, as well as the `load`
method of `ImageProvider` and the associated `DecoderCallback` were all
deprecated in v2.13.

The respective replacements are:

| Deprecated Method                       | Current Method                                    |
|-----------------------------------------|---------------------------------------------------|
| `PaintingBinding.instantiateImageCodec` | `PaintingBinding.instantiateImageCodecFromBuffer` |
| `ImageProvider.load`                    | `ImageProvider.loadBuffer`                        |
| `DecoderCallback`                       | `DecoderBufferCallback`                           |

This change enabled faster performance in image loading by using a buffer.

**Migration guide**

Code before migration:

```dart
PaintingBinding.instance.instantiateImageCodec
```

Code after migration:

```dart
PaintingBinding.instance.instantiateImageCodecFromBuffer
```

**References**

API documentation:

* [`PaintingBinding`][]
* [`ImageProvider`][]
* [`DecoderBufferCallback`][]

Relevant PRs:

* Deprecated in [#103496][]
* Removed in [#132679][]

[`PaintingBinding`]: {{site.api}}/flutter/painting/PaintingBinding-mixin.html
[`ImageProvider`]: {{site.api}}/flutter/painting/ImageProvider-class.html
[`DecoderBufferCallback`]: {{site.api}}/flutter/painting/DecoderBufferCallback.html

[#103496]: {{site.repo.flutter}}/pull/103496
[#132679]: {{site.repo.flutter}}/pull/132679

---

### TestWindow properties

Package: flutter_test
Supported by Flutter Fix: no

To prepare for multi-window support,
many deprecated properties of `TestWindow` have been removed.
While `TestWindow` has been deprecated, it does not qualify
for removal at this time.
Migrating the expired properties now will help in migrating from `TestWindow`.

The following properties were removed:

* `localeTestValue`
* `clearLocaleTestValue`
* `localesTestValue`
* `clearLocalesTestValue`
* `initialLifecycleStateTestValue`
* `textScaleFactorTestValue`
* `clearTextScaleFactorTestValue`
* `platformBrightnessTestValue`
* `clearPlatformBrightnessTestValue`
* `alwaysUse24HourFormatTestValue`
* `clearAlwaysUse24HourTestValue`
* `brieflyShowPasswordTestValue`
* `defaultRouteNameTestValue`
* `clearDefaultRouteNameTestValue`
* `semanticsEnabledTestValue`
* `clearSemanticsEnabledTestValue`
* `accessibilityFeaturesTestValue`
* `clearAccessibilityFeaturesTestValue`

To learn more about this `TestWindow` update, check out
[`TestWindow` migration guide][].

[`TestWindow` migration guide]: /release/breaking-changes/window-singleton

**Migration guide**

Code before migration:

```dart
testWidgets('My test', (WidgetTester tester) aysnc {
  // For all instances, replace window with platformDispatcher
  tester.binding.window.textScaleFactorTestValue = 42;
  addTearDown(tester.binding.window.clearTextScaleFactorTestValue);
  // ...
});
```

Code after migration:

```dart
testWidgets('My test', (WidgetTester tester) aysnc {
  // For all instances, replace window with platformDispatcher
  tester.binding.platformDispatcher.textScaleFactorTestValue = 42;
  addTearDown(tester.binding.platformDispatcher.clearTextScaleFactorTestValue);
  // ...
});
```

**References**

API documentation:

* [`WidgetTester`][]
* [`TestWidgetsFlutterBinding`][]
* [`TestPlatformDispatcher`][]

Relevant PRs:

* Deprecated in [#99443][]
* Removed in [#131098][]

[`WidgetTester`]: {{site.api}}/flutter/flutter_test/WidgetTester-class.html
[`TestWidgetsFlutterBinding`]: {{site.api}}/flutter/flutter_test/TestWidgetsFlutterBinding-class.html
[`TestPlatformDispatcher`]: {{site.api}}/flutter/flutter_test/TestPlatformDispatcher-class.html

[#99443]: {{site.repo.flutter}}/pull/99443
[#131098]: {{site.repo.flutter}}/pull/131098

---

## Timeline

In stable release: 3.16
