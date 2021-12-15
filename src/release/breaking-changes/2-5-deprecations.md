---
title: Deprecated API removed after v2.5
description: After reaching end of life, the following deprecated APIs were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
2.5 stable release have been removed.

All affected APIs have been compiled into this
primary source to aid in migration. A
[quick reference sheet][] is available as well.


[Deprecation Policy]: {{site.repo.flutter}}/wiki/Tree-hygiene#deprecation
[quick reference sheet]: {{site.url}}/go/deprecations-removed-after-2-5

## Changes

This section lists the deprecations by affected class.

---

### `autovalidate` of `Form` & related classes

Supported by Flutter Fix: yes

`autovalidate` was deprecated in v1.19.

Use `autovalidateMode` instead.
Where `autovalidate` was true, replace with `AutovalidateMode.always`.
Where `autovalidate` was false, replace with `AutovalidateMode.disabled`.
This change allows more behaviors to be specified beyond the original binary
choice, adding `AutovalidateMode.onUserInteraction` as an additional option.

The following classes all have the same change of API:

- `Form`
- `FormField`
- `DropdownButtonFormField`
- `TextFormField`

**Migration guide**

[In-depth migration guide available][]

Code before migration:
<!-- skip -->
```dart
const Form form = Form(autovalidate: true);
const Form form = Form(autovalidate: false);
final autoMode = form.autovalidate;

const FormField formField = FormField(autovalidate: true);
const FormField formField = FormField(autovalidate: false);
final autoMode = formField.autovalidate;

const TextFormField textFormField = TextFormField(autovalidate: true);
const TextFormField textFormField = TextFormField(autovalidate: false);

const DropdownButtonFormField dropDownButtonFormField = DropdownButtonFormField(autovalidate: true);
const DropdownButtonFormField dropdownButtonFormField = DropdownButtonFormField(autovalidate: false);
```

Code after migration:
<!-- skip -->
```dart
const Form form = Form(autovalidateMode: AutovalidateMode.always);
const Form form = Form(autovalidateMode: AutovalidateMode.disabled);
final autoMode = form.autovalidateMode;

const FormField formField = FormField(autovalidateMode: AutovalidateMode.always);
const FormField formField = FormField(autovalidateMode: AutovalidateMode.disabled);
final autoMode = formField.autovalidateMode;

const TextFormField textFormField = TextFormField(autovalidateMode: AutovalidateMode.always);
const TextFormField textFormField = TextFormField(autovalidateMode: AutovalidateMode.disabled);

const DropdownButtonFormField dropDownButtonFormField = DropdownButtonFormField(autovalidateMode: AutovalidateMode.always);
const DropdownButtonFormField dropdownButtonFormField = DropdownButtonFormField(autovalidateMode: AutovalidateMode.disabled);
```

[In-depth migration guide available]: {{site.url}}/release/breaking-changes/form-field-autovalidation-api

**References**

API documentation:
* [`Form`][]
* [`FormField`][]
* [`TextFormField`][]
* [`DropdownButtonFormField`][]
* [`AutovalidateMode`][]

Relevant issues:
* [Issue 56363]({{site.repo.flutter}}/issues/56363)
* [Issue 18885]({{site.repo.flutter}}/issues/18885)
* [Issue 15404]({{site.repo.flutter}}/issues/15404)
* [Issue 36154]({{site.repo.flutter}}/issues/36154)
* [Issue 48876]({{site.repo.flutter}}/issues/48876)

Relevant PRs:
* Deprecated in [#59766]({{site.repo.flutter}}/pull/59766)
* Removed in [#90292]({{site.repo.flutter}}/pull/90292)

[`Form`]: {{site.api}}/flutter/widgets/Form-class.html
[`FormField`]: {{site.api}}/flutter/widgets/FormField-class.html
[`TextFormField`]: {{site.api}}/flutter/material/TextFormField-class.html
[`DropdownButtonFormField`]: {{site.api}}/flutter/material/DropdownButtonFormField-class.html
[`AutovalidateMode`]: {{site.api}}/flutter/widgets/AutovalidateMode-class.html

---

### `FloatingHeaderSnapConfiguration.vsync`

Supported by Flutter Fix: no

The `TickerProvider` `vsync` property of `FloatingHeaderSnapConfiguration` was
deprecated in v1.19.

The `vsync` for the animation should instead be specified using
`SliverPersistentHeaderDelegate.vsync`.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  FloatingHeaderSnapConfiguration? get snapConfiguration => FloatingHeaderSnapConfiguration(vsync: myTickerProvider);
}
```

Code after migration:
<!-- skip -->
```dart
class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  FloatingHeaderSnapConfiguration? get snapConfiguration => FloatingHeaderSnapConfiguration();
  TickerProvider? get vsync => myTickerProvider;
}

```

**References**

Design document:
* [Control SliverPersistentHeader's showOnScreen Behavior][]

API documentation:
* [`FloatingHeaderSnapConfiguration`][]
* [`SliverPersistentHeaderDelegate`][]
* [`TickerProvider`][]

Relevant issues:
* [Issue 25507]({{site.repo.flutter}}/issues/25507)

Relevant PRs:
* Deprecated in [#56413]({{site.repo.flutter}}/pull/56413)
* Removed in [#90293]({{site.repo.flutter}}/pull/90293)

[Control SliverPersistentHeader's showOnScreen Behavior]: https://docs.google.com/document/d/1BZhxy176uUnqOCnXdnHM1XetS9mw9WIyUAOE-dgVdUM/edit?usp=sharing
[`FloatingHeaderSnapConfiguration`]: {{site.api}}/flutter/rendering/FloatingHeaderSnapConfiguration-class.html
[`SliverPersistentHeaderDelegate`]: {{site.api}}/flutter/widgets/SliverPersistentHeaderDelegate-class.html
[`TickerProvider`]: {{site.api}}/flutter/scheduler/TickerProvider-class.html

---

### `AndroidViewController` & subclasses' `id`

Supported by Flutter Fix: yes

The `id` of `AndroidViewController`, `TextureAndroidViewController`, and
`SurfaceAndroidViewController`, was deprecated in v1.20.

For all of these use cases, `viewId` should be used instead.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
final SurfaceAndroidViewController surfaceController = SurfaceAndroidViewController(
  viewId: 10,
  viewType: 'FixTester',
  layoutDirection: TextDirection.ltr,
);
int viewId = surfaceController.id;
final SurfaceAndroidViewController surfaceController = SurfaceAndroidViewController(
  error: '',
);
final TextureAndroidViewController textureController = TextureAndroidViewController(
  error: '',
);
final TextureAndroidViewController textureController = TextureAndroidViewController(
  viewId: 10,
  viewType: 'FixTester',
  layoutDirection: TextDirection.ltr,
);
viewId = textureController.id;
```

Code after migration:
<!-- skip -->
```dart
final SurfaceAndroidViewController surfaceController = SurfaceAndroidViewController(
  viewId: 10,
  viewType: 'FixTester',
  layoutDirection: TextDirection.ltr,
);
int viewId = surfaceController.viewId;
final SurfaceAndroidViewController surfaceController = SurfaceAndroidViewController(
  error: '',
);
final TextureAndroidViewController textureController = TextureAndroidViewController(
  error: '',
);
final TextureAndroidViewController textureController = TextureAndroidViewController(
  viewId: 10,
  viewType: 'FixTester',
  layoutDirection: TextDirection.ltr,
);
viewId = textureController.viewId;
```

**References**

Design document:
* [Flutter Hybrid Composition][]

API documentation:
* [`AndroidViewController`][]
* [`TextureAndroidViewController`][]
* [`SurfaceAndroidViewController`][]

Relevant issues:
* [Issue 55218]({{site.repo.flutter}}/issues/55218)

Relevant PRs:
* Deprecated in [#60320]({{site.repo.flutter}}/issues/60320)
* Removed in [#90294]({{site.repo.flutter}}/issues/90294)

[Flutter Hybrid Composition]: https://github.com/flutter/flutter/wiki/Hybrid-Composition
[`AndroidViewController`]: {{site.api}}/flutter/services/AndroidViewController-class.html
[`TextureAndroidViewController`]: {{site.api}}/flutter/services/TextureAndroidViewController-class.html
[`SurfaceAndroidViewController`]: {{site.api}}/flutter/services/SurfaceAndroidViewController-class.html

---

### `BlacklistingTextInputFormatter` & `WhitelistingTextInputFormatter`

Supported by Flutter Fix: no

The entire classes of `BlacklistingTextInputFormatter` and
`WhitelistingTextInoutFormatter` were deprecated in v1.20.

Their functionality has been rewritten into a single class,
`FilteringTextInputFormatter`.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
formatter = BlacklistingTextInputFormatter(pattern, replacementString: 'replacedPattern');
formatter = BlacklistingTextInputFormatter.singleLineFormatter;
pattern = formatter.blacklistedPattern;
formatter = WhitelistingTextInputFormatter(pattern);
formatter = WhitelistingTextInputFormatter.digitsOnly;
pattern = formatter.whitelistedPattern;
```

Code after migration:
<!-- skip -->
```dart
formatter = FilteringTextInputFormatter.deny(pattern, replacementString: 'replacedPattern');
formatter = FilteringTextInputFormatter.singleLineFormatter;
pattern = formatter.filterPattern;
formatter = FilteringTextInputFormatter.allow(pattern);
formatter = FilteringTextInputFormatter.digitsOnly;
pattern = formatter.filterPattern;
```

**References**

API documentation:
* [`FilteringTextInputFormatter`][]

Relevant PRs:
* Deprecated in [#59120]({{site.repo.flutter}}/issues/59120)
* Removed in [#90296]({{site.repo.flutter}}/issues/90296)

[`FilteringTextInputFormatter`]: {{site.api}}/flutter/services/FilteringTextInputFormatter-class.html

---

### `BottomNavigationBarItem.title`

Supported by Flutter Fix: yes

The `title` of `BottomNavigationBarItem` was deprecated in v1.19.
The `label` property should be used instead. This migration allows for better
text scaling, and presents built-in `Tooltip`s for the `BottomNavigationBarItem`
in the context of a `BottomNavigationBar`.

**Migration guide**

[In-depth migration guide available][]

Code before migration:
<!-- skip -->
```dart
const BottomNavigationBarItem bottomNavigationBarItem = BottomNavigationBarItem(title: myTitle);
const BottomNavigationBarItem bottomNavigationBarItem = BottomNavigationBarItem();
bottomNavigationBarItem.title;
```

Code after migration:
<!-- skip -->
```dart
const BottomNavigationBarItem bottomNavigationBarItem = BottomNavigationBarItem(label: myTitle);
const BottomNavigationBarItem bottomNavigationBarItem = BottomNavigationBarItem();
bottomNavigationBarItem.label;
```

**References**

Design Document
* [BottomNavigationBarItem title][]

API documentation:
* [`BottomNavigationBarItem`][]
* [`BottomNavigationBar`][]
* [`Tooltip`][]

Relevant PRs:
* Deprecated in [#59127]({{site.repo.flutter}}/issues/59127)
* Removed in [#90295]({{site.repo.flutter}}/issues/90295)

[In-depth migration guide available]: {{site.url}}/release/breaking-changes/bottom-navigation-title-to-label
[BottomNavigationBarItem title]: {{site.url}}/go/bottom-navigation-bar-title-deprecation
[`BottomNavigationBarItem`]: {{site.api}}/flutter/widgets/BottomNavigationBarItem-class.html
[`BottomNavigationBar`]: {{site.api}}/flutter/material/BottomNavigationBar-class.html
[`Tooltip`]: {{site.api}}/flutter/material/Tooltip-class.html

---

### `packageRoot` in `dart:core`, `dart:isolate`, and `package:platform`

The following APIs have been removed:

* [`Platform.packageRoot`][] in `dart:core`
* [`Isolate.packageRoot`][] in `dart:isolate`
* [`Platform.packageRoot`][] in `package:platform`

These APIs were marked deprecated [in Dart 2.0][dart-deprecated], and did not
work correctly in any Dart 2.x release.

**Migration guide**

These `packageRoot` APIs have been replaced by a new set of `packageConfig` APIs,
which you should migrate to.

* [`Platform.packageConfig`][] in `dart:core`
* [`Isolate.packageConfig`][] in `dart:isolate`
* [`Platform.packageConfig`][] in `package:platform`

If you are using the `package:platform` package, note that regardless of whether
you are using the `packageRoot` API or not, older versions of that package are
not compatible with Dart 2.16 and later, as they depend on the now removed
`packageConfig` API. You may see an error like this when attempting to run your
app:

```
../../.pub-cache/hosted/pub.dartlang.org/platform-3.0.0/
  lib/src/interface/local_platform.dart:46:19:
  Error: Member not found: 'packageRoot'.
      io.Platform.packageRoot; // ignore: deprecated_member_use
                  ^^^^^^^^^^^
```

To resolve that, upgrade to version `3.1.0` or later of `package:platform` by
upgrading the constraint in your `pubspec.yaml` file:

```yaml
dependencies:
  platform: ^3.1.0
```

**References**

Relevant PRs:
* Removed from the Dart libraries in [#47769][]
* Removed from `package:platform` in [PR #38][]
* Updated Flutter to use `package:platform` 3.1.0 in [PR #94603][]

[`Platform.packageRoot`]: {{site.dart.api}}/stable/2.15.1/dart-io/Platform/packageRoot.html
[`Isolate.packageRoot`]: {{site.dart.api}}/stable/2.15.1/dart-isolate/Isolate/packageRoot.html
[`Platform.packageRoot`]: {{site.pub-api}}/platform/3.0.0/platform/Platform/packageRoot.html
[dart-deprecated]: https://dart-review.googlesource.com/c/sdk/+/59100/16/CHANGELOG.md
[`Platform.packageConfig`]: {{site.dart.api}}/stable/2.15.1/dart-io/Platform/packageConfig.html
[`Isolate.packageConfig`]: {{site.dart.api}}/stable/2.15.1/dart-isolate/Isolate/packageConfig.html
[`Platform.packageConfig`]: {{site.pub-api}}/platform/3.0.0/platform/Platform/packageConfig.html
[#47769]: https://github.com/dart-lang/sdk/issues/47769
[PR #38]: https://github.com/google/platform.dart/pull/38
[PR #94603]: {{site.repo.flutter}}/pull/94603

---

## Timeline

In stable release: TBD
