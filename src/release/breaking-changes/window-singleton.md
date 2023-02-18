---
title: The window singleton is deprecated
description: In preparation for supporting multiple views and multiple windows the window singleton has been deprecated.
---

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
must chose a specific view they want to operate on and migrate to new multi-view
compatible APIs as outlined in this migration guide.

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
* TODO: mention any test related classes/properties (e.g. TestWindow).

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

TODO: Talk about what tests should do.

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
  return Text('The device pixel ratio is $pdr and the locale is $locale.');
}
```

Code after migration:

```dart
Widget build(BuildContext context) {
  final double dpr = View.of(context).devicePixelRatio;
  final Locale locale = View.of(context).platformDispatcher.locale;
  return Text('The device pixel ratio is $pdr and the locale is $locale.');
}
```

If no `BuildContext` is availabe, the `PlatformDispatcher` exposed by the
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

TODO: Example of how to migrate tests

## Timeline

Landed in version: TODO<br>
In stable release: not yet

## References

API documentation:

* [`View.of`][]
* [`FlutterView`][]
* [`PlatformDispatcher`][]

Relevant issues:

* [Issue 116929][]

Relevant PRs:

* [Deprecate SingletonFlutterWindow and global window singleton][]
* [Deprecate BindingBase.window][]
* TODO: add testing framework PR

{% include docs/master-api.md %}

[`View.of`]: {{site.master-api}}/flutter/widgets/View/of.html
[`FlutterView`]: {{site.api}}/flutter/dart-ui/FlutterView-class.html
[`PlatformDispatcher`]: {{site.api}}/flutter/dart-ui/PlatformDispatcher-class.html
[Issue 116929]: {{site.repo.flutter}}/issues/116929
[Deprecate SingletonFlutterWindow and global window singleton]: {{site.repo.engine}}/pull/39302
[Deprecate BindingBase.window]: {{site.repo.flutter}}/pull/120998
