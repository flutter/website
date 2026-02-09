---
title: The window singleton is deprecated
description: >
  In preparation for supporting multiple views and
  multiple windows the window singleton has been deprecated.
---

{% render "docs/breaking-changes.md" %}

## Summary

In preparation for supporting multiple views and multiple windows, the `window`
singleton has been deprecated. Code previously relying on the `window` singleton
needs to look up the specific view it wants to operate on via the `View.of` API
or interact with the `PlatformDispatcher` directly.

## Context

Originally, Flutter assumed that an application would only consist of a single
view (the `window`) into which content can be drawn. In a multi-view world, this
assumption no longer makes sense and the APIs encoding this assumption have
been deprecated. Instead, applications and libraries that relied on these APIs
must choose a specific view they want to operate on and
migrate to new multi-view compatible APIs as outlined in this migration guide.

## Description of change

The APIs that have been deprecated as part of this change are:

* The global `window` property exposed by `dart:ui`.
* The `window` property on the `BaseBinding` class,
  which is usually accessed via
  * `GestureBinding.instance.window`,
  * `SchedulerBinding.instance.window`,
  * `ServicesBinding.instance.window`,
  * `PaintingBinding.instance.window`,
  * `SemanticsBinding.instance.window`,
  * `RendererBinding.instance.window`,
  * `WidgetsBinding.instance.window`, or
  * `WidgetTester.binding.window`.
* The `SingletonFlutterView` class from `dart:ui`.
* `TestWindow` from `flutter_test`, its constructors,
  and all of its properties and methods.

The following options exist to migrate application and library code that relies
on these deprecated APIs:

If a `BuildContext` is available, consider looking up the current `FlutterView`
via `View.of`. This returns the `FlutterView` into
which the widgets built by the `build` method associated with the given context
will be drawn. The `FlutterView` provides access to the same functionality
that was previously available on the deprecated `SingletonFlutterView` class
returned by the deprecated `window` properties mentioned above. However, some
of the platform-specific functionality has moved to the `PlatformDispatcher`,
which can be accessed from the `FlutterView` returned by `View.of` via
`FlutterView.platformDispatcher`. Using `View.of` is the preferred way of
migrating away from the deprecated properties mentioned above.

If no `BuildContext` is available to look up a `FlutterView`, the
`PlatformDispatcher` can be consulted directly to access platform-specific
functionality. It also maintains a list of all available `FlutterView`s in
`PlatformDispatcher.views` to access view-specific functionality. If possible,
the `PlatformDispatcher` should be accessed via a binding (for example
`WidgetsBinding.instance.platformDispatcher`) instead of using the static
`PlatformDispatcher.instance` property. This ensures that the functionality
of the `PlatformDispatcher` can be properly mocked out in tests.

### Testing

For tests that accessed the `WidgetTester.binding.window` property to change
window properties for testing, the following migrations are available:

In tests written with `testWidgets`, two new properties have been added that
together replace the functionality of `TestWindow`.

* `WidgetTester.view` will provide a `TestFlutterView` that can be modified
  similarly to `WidgetTester.binding.window`, but with only view-specific
  properties such as the size of a view, its display pixel ratio, etc.
  * `WidgetTester.viewOf` is available for certain multi-view use cases, but
      should not be required for any migrations from
      `WidgetTester.binding.window`.
* `WidgetTester.platformDispatcher` will provide access to a
  `TestPlatformDispatcher` that can be used to modify platform specific
  properties such as the platform's locale, whether certain system features
  are available, etc.

## Migration guide

Instead of accessing the static `window` property, application and library code
that has access to a `BuildContext` should use `View.of` to look up the
`FlutterView` the context is associated with. Some properties have moved to
the `PlatformDispatcher` accessible from the view via the `platformDispatcher`
getter.

Code before migration:

```dart
Widget build(BuildContext context) {
  final double dpr = WidgetsBinding.instance.window.devicePixelRatio;
  final Locale locale = WidgetsBinding.instance.window.locale;
  return Text('The device pixel ratio is $dpr and the locale is $locale.');
}
```

Code after migration:

```dart
Widget build(BuildContext context) {
  final double dpr = View.of(context).devicePixelRatio;
  final Locale locale = View.of(context).platformDispatcher.locale;
  return Text('The device pixel ratio is $dpr and the locale is $locale.');
}
```

If no `BuildContext` is available, the `PlatformDispatcher` exposed by the
bindings can be consulted directly.

Code before migration:

```dart
double getTextScaleFactor() {
  return WidgetsBinding.instance.window.textScaleFactor;
}
```

Code after migration:

```dart
double getTextScaleFactor() {
  // View.of(context).platformDispatcher.textScaleFactor if a BuildContext is available, otherwise:
  return WidgetsBinding.instance.platformDispatcher.textScaleFactor;
}
```

### Testing

In tests written with `testWidget`, the new `view` and `platformDispatcher`
accessors should be used instead.

#### Setting view-specific properties

`TestFlutterView` has also made an effort to make the test API clearer and more
concise by using setters with the same name as their related getter instead of
setters with the `TestValue` suffix.

Code before migration:

```dart
testWidget('test name', (WidgetTester tester) async {
  tester.binding.window.devicePixelRatioTestValue = 2.0;
  tester.binding.window.displayFeaturesTestValue = <DisplayFeatures>[];
  tester.binding.window.gestureSettingsTestValue = const GestureSettings(physicalTouchSlop: 100);
  tester.binding.window.paddingTestValue = FakeViewPadding.zero;
  tester.binding.window.physicalGeometryTestValue = const Rect.fromLTRB(0,0, 500, 800);
  tester.binding.window.physicalSizeTestValue = const Size(300, 400);
  tester.binding.window.systemGestureInsetsTestValue = FakeViewPadding.zero;
  tester.binding.window.viewInsetsTestValue = FakeViewPadding.zero;
  tester.binding.window.viewPaddingTestValue = FakeViewPadding.zero;
});
```

Code after migration

```dart
testWidget('test name', (WidgetTester tester) async {
  tester.view.devicePixelRatio = 2.0;
  tester.view.displayFeatures = <DisplayFeatures>[];
  tester.view.gestureSettings = const GestureSettings(physicalTouchSlop: 100);
  tester.view.padding = FakeViewPadding.zero;
  tester.view.physicalGeometry = const Rect.fromLTRB(0,0, 500, 800);
  tester.view.physicalSize = const Size(300, 400);
  tester.view.systemGestureInsets = FakeViewPadding.zero;
  tester.view.viewInsets = FakeViewPadding.zero;
  tester.view.viewPadding = FakeViewPadding.zero;
});
```

#### Resetting view-specific properties

`TestFlutterView` retains the capability to reset individual properties or the
entire view but, in order to be more clear and consist, the naming of these
methods has changed from `clear<property>TestValue` and `clearAllTestValues` to
`reset<property>` and `reset` respectively.

##### Resetting individual properties

Code before migration:

```dart
testWidget('test name', (WidgetTester tester) async {
  addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
  addTearDown(tester.binding.window.clearDisplayFeaturesTestValue);
  addTearDown(tester.binding.window.clearGestureSettingsTestValue);
  addTearDown(tester.binding.window.clearPaddingTestValue);
  addTearDown(tester.binding.window.clearPhysicalGeometryTestValue);
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  addTearDown(tester.binding.window.clearSystemGestureInsetsTestValue);
  addTearDown(tester.binding.window.clearViewInsetsTestValue);
  addTearDown(tester.binding.window.clearViewPaddingTestValue);
});
```

Code after migration

```dart
testWidget('test name', (WidgetTester tester) async {
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetDisplayFeatures);
  addTearDown(tester.view.resetGestureSettings);
  addTearDown(tester.view.resetPadding);
  addTearDown(tester.view.resetPhysicalGeometry);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetSystemGestureInsets);
  addTearDown(tester.view.resetViewInsets);
  addTearDown(tester.view.resetViewPadding);
});
```

##### Resetting all properties at once

Code before migration:

```dart
testWidget('test name', (WidgetTester tester) async {
  addTearDown(tester.binding.window.clearAllTestValues);
});
```

Code after migration

```dart
testWidget('test name', (WidgetTester tester) async {
  addTearDown(tester.view.reset);
});
```

#### Setting platform-specific properties

`TestPlatformDispatcher` retains the same functionality and naming scheme for
test setters as did `TestWindow`, so migration of platform-specific properties
mainly consists of calling the same setters on the new
`WidgetTester.platformDispatcher` accessor.

Code before migration:

```dart
testWidgets('test name', (WidgetTester tester) async {
  tester.binding.window.accessibilityFeaturesTestValue = FakeAccessibilityFeatures.allOn;
  tester.binding.window.alwaysUse24HourFormatTestValue = false;
  tester.binding.window.brieflyShowPasswordTestValue = true;
  tester.binding.window.defaultRouteNameTestValue = '/test';
  tester.binding.window.initialLifecycleStateTestValue = 'painting';
  tester.binding.window.localesTestValue = <Locale>[const Locale('en-us'), const Locale('ar-jo')];
  tester.binding.window.localeTestValue = const Locale('ar-jo');
  tester.binding.window.nativeSpellCheckServiceDefinedTestValue = false;
  tester.binding.window.platformBrightnessTestValue = Brightness.dark;
  tester.binding.window.semanticsEnabledTestValue = true;
  tester.binding.window.textScaleFactorTestValue = 2.0;
});
```

Code after migration:

```dart
testWidgets('test name', (WidgetTester tester) async {
  tester.platformDispatcher.accessibilityFeaturesTestValue = FakeAccessibilityFeatures.allOn;
  tester.platformDispatcher.alwaysUse24HourFormatTestValue = false;
  tester.platformDispatcher.brieflyShowPasswordTestValue = true;
  tester.platformDispatcher.defaultRouteNameTestValue = '/test';
  tester.platformDispatcher.initialLifecycleStateTestValue = 'painting';
  tester.platformDispatcher.localesTestValue = <Locale>[const Locale('en-us'), const Locale('ar-jo')];
  tester.platformDispatcher.localeTestValue = const Locale('ar-jo');
  tester.platformDispatcher.nativeSpellCheckServiceDefinedTestValue = false;
  tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
  tester.platformDispatcher.semanticsEnabledTestValue = true;
  tester.platformDispatcher.textScaleFactorTestValue = 2.0;
});
```

#### Resetting platform-specific properties

Similarly to setting properties, resetting platform-specific properties consists
mainly of changing from the `binding.window` accessor to the
`platformDispatcher` accessor.

##### Resetting individual properties

Code before migration:

```dart
testWidgets('test name', (WidgetTester tester) async {
  addTeardown(tester.binding.window.clearAccessibilityFeaturesTestValue);
  addTeardown(tester.binding.window.clearAlwaysUse24HourFormatTestValue);
  addTeardown(tester.binding.window.clearBrieflyShowPasswordTestValue);
  addTeardown(tester.binding.window.clearDefaultRouteNameTestValue);
  addTeardown(tester.binding.window.clearInitialLifecycleStateTestValue);
  addTeardown(tester.binding.window.clearLocalesTestValue);
  addTeardown(tester.binding.window.clearLocaleTestValue);
  addTeardown(tester.binding.window.clearNativeSpellCheckServiceDefinedTestValue);
  addTeardown(tester.binding.window.clearPlatformBrightnessTestValue);
  addTeardown(tester.binding.window.clearSemanticsEnabledTestValue);
  addTeardown(tester.binding.window.clearTextScaleFactorTestValue);
});
```

Code after migration:

```dart
testWidgets('test name', (WidgetTester tester) async {
  addTeardown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
  addTeardown(tester.platformDispatcher.clearAlwaysUse24HourFormatTestValue);
  addTeardown(tester.platformDispatcher.clearBrieflyShowPasswordTestValue);
  addTeardown(tester.platformDispatcher.clearDefaultRouteNameTestValue);
  addTeardown(tester.platformDispatcher.clearInitialLifecycleStateTestValue);
  addTeardown(tester.platformDispatcher.clearLocalesTestValue);
  addTeardown(tester.platformDispatcher.clearLocaleTestValue);
  addTeardown(tester.platformDispatcher.clearNativeSpellCheckServiceDefinedTestValue);
  addTeardown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
  addTeardown(tester.platformDispatcher.clearSemanticsEnabledTestValue);
  addTeardown(tester.platformDispatcher.clearTextScaleFactorTestValue);
});
```

##### Resetting all properties at once

Code before migration:

```dart
testWidgets('test name', (WidgetTester tester) async {
  addTeardown(tester.binding.window.clearAllTestValues);
});
```

Code after migration:

```dart
testWidgets('test name', (WidgetTester tester) async {
  addTeardown(tester.platformDispatcher.clearAllTestValues);
});
```

## Timeline

Landed in version: 3.9.0-13.0.pre.20<br>
In stable release: 3.10.0

## References

API documentation:

* [`View.of`][]
* [`FlutterView`][]
* [`PlatformDispatcher`][]
* [`TestPlatformDispatcher`][]
* [`TestFlutterView`][]
* [`TestWidgetsFlutterBinding.window`][]

Relevant issues:

* [Issue 116929][]
* [Issue 117481][]
* [Issue 121915][]

Relevant PRs:

* [Deprecate SingletonFlutterWindow and global window singleton][]
* [Deprecate BindingBase.window][]
* [Deprecates `TestWindow`][]


[`View.of`]: {{site.api}}/flutter/widgets/View/of.html
[`FlutterView`]: {{site.api}}/flutter/dart-ui/FlutterView-class.html
[`PlatformDispatcher`]: {{site.api}}/flutter/dart-ui/PlatformDispatcher-class.html
[`TestPlatformDispatcher`]: {{site.api}}/flutter/flutter_test/TestPlatformDispatcher-class.html
[`TestFlutterView`]: {{site.api}}/flutter/flutter_test/TestFlutterView-class.html
[`TestWidgetsFlutterBinding.window`]: {{site.api}}/flutter/flutter_test/TestWidgetsFlutterBinding/window.html
[Issue 116929]: {{site.repo.flutter}}/issues/116929
[Issue 117481]: {{site.repo.flutter}}/issues/117481
[Issue 121915]: {{site.repo.flutter}}/issues/121915
[Deprecate SingletonFlutterWindow and global window singleton]: {{site.repo.engine}}/pull/39302
[Deprecate BindingBase.window]: {{site.repo.flutter}}/pull/120998
[Deprecates `TestWindow`]: {{site.repo.flutter}}/pull/122824
