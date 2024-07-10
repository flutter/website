---
title: Android predictive back
description: >-
  The ability to control back navigation at the time that a back gesture is
  received has been replaced with an ahead-of-time navigation API in order to
  support Android 14's Predictive Back feature.
---

## Summary

To support Android 14's Predictive Back feature,
a set of ahead-of-time APIs have replaced just-in-time navigation APIs,
like `WillPopScope` and `Navigator.willPop`.

:::note
The Flutter 3.22 release includes some updates
to predictive back behavior. For more info, check out
[Issue #132504][].
:::

[Issue #132504]: {{site.github}}/flutter/flutter/issues/132504#issuecomment-2025776552

## Background

Android 14 introduced the
[Predictive Back feature]({{site.android-dev}}/guide/navigation/predictive-back-gesture),
which allows the user to peek behind the current route during a valid back
gesture and decide whether to continue back or to cancel the gesture. This was
incompatible with Flutter's navigation APIs that allow the developer to cancel a
back gesture after it is received.

With predictive back, the back animation begins immediately when the
user initiates the gesture and before it has been committed. There is no
opportunity for the Flutter app to decide whether it's allowed to happen at that
time. It must be known ahead of time.

For this reason, all APIs that allow a Flutter app developer to cancel a back
navigation at the time that a back gesture is received are now deprecated. They
have been replaced with equivalent APIs that maintain a boolean state at all
times that dictates whether or not back navigation is possible. When it is, the
predictive back animation happens as usual. Otherwise, navigation is stopped. In
both cases, the app developer is informed that a back was attempted and
whether it was successful.

### PopScope

The `PopScope` class directly replaces `WillPopScope`. Instead of deciding
whether a pop is possible at the time it occurs, this is set ahead of time with
the `canPop` boolean. You can still listen to pops by using `onPopInvoked`.

```dart
PopScope(
  canPop: _myPopDisableEnableLogic(),
  onPopInvoked: (bool didPop) {
    // Handle the pop. If `didPop` is false, it was blocked.
  },
)
```

### Form.canPop and Form.onPopInvoked

These two new parameters are based on `PopScope` and replace the deprecated
`Form.onWillPop` parameter. They are used with `PopScope` in the same way as
above.

```dart
Form(
  canPop: _myPopDisableEnableLogic(),
  onPopInvoked: (bool didPop) {
    // Handle the pop. If `didPop` is false, it was blocked.
  },
)
```

### Route.popDisposition

This getter synchronously returns the `RoutePopDisposition`
for the route, which describes how pops will behave.

```dart
if (myRoute.popDisposition == RoutePopDisposition.doNotPop) {
  // Back gestures are disabled.
}
```

### ModalRoute.registerPopEntry and ModalRoute.unregisterPopEntry

Use these methods to register `PopScope` widgets,
to be evaluated when the route decides whether it can pop.
This functionality might be used when implementing a
custom `PopScope` widget.

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final ModalRoute<dynamic>? nextRoute = ModalRoute.of(context);
  if (nextRoute != _route) {
    _route?.unregisterPopEntry(this);
    _route = nextRoute;
    _route?.registerPopEntry(this);
  }
}
```

## Migration guide

### Migrating from `WillPopScope` to `PopScope`

The direct replacement of the `WillPopScope` widget is the `PopScope` widget.
In many cases, logic that was being run at the time of the back gesture in
`onWillPop` can be done at build time and set to `canPop`.

Code before migration:

```dart
WillPopScope(
  onWillPop: () async {
    return _myCondition;
  },
  child: ...
),
```

Code after migration:

```dart
PopScope(
  canPop: _myCondition,
  child: ...
),
```

For cases where it's necessary to be notified that a
pop was attempted, the `onPopInvoked` method can be
used in a similar way to `onWillPop`. Keep in mind
that while `onWillPop` was called before the pop
was handled and had the ability to cancel it,
`onPopInvoked` is called after the pop is finished being handled.

Code before migration:

```dart
WillPopScope(
  onWillPop: () async {
    _myHandleOnPopMethod();
    return true;
  },
  child: ...
),
```

Code after migration:

```dart
PopScope(
  canPop: true,
  onPopInvoked: (bool didPop) {
    _myHandleOnPopMethod();
  },
  child: ...
),
```

### Migrating from WillPopScope to NavigatorPopHandler for nested Navigators

A very common use case of `WillPopScope` was to properly handle
back gestures when using nested `Navigator` widgets.
It's possible to do this using `PopScope` as well,
but there is now a wrapper widget that makes this even easier:
`NavigatorPopHandler`.

Code before migration:

```dart
WillPopScope(
  onWillPop: () async => !(await _nestedNavigatorKey.currentState!.maybePop()),
  child: Navigator(
    key: _nestedNavigatorKey,
    …
  ),
)
```

Code after migration:

```dart
NavigatorPopHandler(
  onPop: () => _nestedNavigatorKey.currentState!.pop(),
  child: Navigator(
    key: _nestedNavigatorKey,
    …
  ),
)
```

### Migrating from Form.onWillPop to Form.canPop and Form.onPopInvoked

Previously, `Form` used a `WillPopScope` instance under
the hood and exposed its `onWillPop` method.
This has been replaced with a `PopScope` that exposes its
`canPop` and `onPopInvoked` methods.
Migrating is identical to migrating from
`WillPopScope` to `PopScope`, detailed above.

### Migrating from Route.willPop to Route.popDisposition

`Route`'s `willPop` method returned a
`Future<RoutePopDisposition>` to accommodate the fact
that pops could be canceled. Now that that's no longer true,
this logic has been simplified to a synchronous getter.

Code before migration:

```dart
if (await myRoute.willPop() == RoutePopDisposition.doNotPop) {
  ...
}
```

Code after migration:

```dart
if (myRoute.popDisposition == RoutePopDisposition.doNotPop) {
  ...
}
```

### Migrating from ModalRoute.add/removeScopedWillPopCallback to ModalRoute.(un)registerPopEntry

Internally, `ModalRoute` kept track of the existence of
`WillPopScope`s in its widget subtree by registering them
with `addScopedWillPopCallback` and
`removeScopedWillPopCallback`.
Since `PopScope` replaces `WillPopScope`,
these methods have been replaced by `registerPopEntry` and
`unregisterPopEntry`, respectively.

`PopEntry` is implemented by `PopScope` in order to expose only the minimal
information necessary to `ModalRoute`. Anyone writing their own `PopScope`
should implement `PopEntry` and register and unregister their widget with
its enclosing `ModalRoute`.

Code before migration:

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (widget.onWillPop != null) {
    _route?.removeScopedWillPopCallback(widget.onWillPop!);
  }
  _route = ModalRoute.of(context);
  if (widget.onWillPop != null) {
    _route?.addScopedWillPopCallback(widget.onWillPop!);
  }
}
```

Code after migration:

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _route?.unregisterPopEntry(this);
  _route = ModalRoute.of(context);
  _route?.registerPopEntry(this);
}
```

### Migrating from ModalRoute.hasScopedWillPopCallback to ModalRoute.popDisposition

This method was previously used for a use-case
very similar to Predictive Back but in the Cupertino library,
where certain back transitions allowed canceling
the navigation. The route transition was disabled
when there was even the possibility of a `WillPopScope`
widget canceling the pop.

Now that the API requires this to be decided ahead of time,
this no longer needs to be speculatively based on the
existence of `PopScope` widgets. The definitive
logic of whether a `ModalRoute` has popping blocked
by a `PopScope` widget is baked into `ModalRoute.popDisposition`.

Code before migration:

```dart
if (_route.hasScopedWillPopCallback) {
  // Disable predictive route transitions.
}
```

Code after migration:

```dart
if (_route.popDisposition == RoutePopDisposition.doNotPop) {
  // Disable predictive route transitions.
}
```

### Migrating a back confirmation dialog

`WillPopScope` was sometimes used to show a confirmation
dialog when a back gesture was received. 
This can still be done with `PopScope` in a similar pattern.

Code before migration:

```dart
WillPopScope(
  onWillPop: () async {
    final bool? shouldPop = await _showBackDialog();
    return shouldPop ?? false;
  },
  child: child,
)
```

Code after migration:

```dart
return PopScope(
  canPop: false,
  onPopInvoked: (bool didPop) async {
    if (didPop) {
      return;
    }
    final NavigatorState navigator = Navigator.of(context);
    final bool? shouldPop = await _showBackDialog();
    if (shouldPop ?? false) {
      navigator.pop();
    }
  },
  child: child,
)
```

### Supporting predictive back

  1. Run Android 33 or above.
  1. Enable the feature flag for predictive back on
     the device under "Developer options".
     This will be unnecessary on future versions of Android.
  1. Set `android:enableOnBackInvokedCallback="true"` in
     `android/app/src/main/AndroidManifest.xml`.
      If needed, refer to
     [Android's full guide]({{site.android-dev}}/guide/navigation/custom-back/predictive-back-gesture).
     for migrating Android apps to support predictive back.
  1. Make sure you're using version `3.14.0-7.0.pre`
     of Flutter or greater.
  1. Run the app and perform a back gesture (swipe from the
     left side of the screen).

## Timeline

Landed in version: 3.14.0-7.0.pre<br>
In stable release: 3.16

## References

API documentation:

* [`PopScope`][]
* [`NavigatorPopHandler`][]
* [`PopScope`][]
* [`NavigatorPopHandler`][]
* [`PopEntry`][]
* [`Form.canPop`][]
* [`Form.onPopInvoked`][]
* [`Route.popDisposition`][]
* [`ModalRoute.registerPopEntry`][]
* [`ModalRoute.unregisterPopEntry`][]

Relevant issues:

* [Issue 109513][]

Relevant PRs:

* [Predictive Back support for root routes][]
* [Platform channel for predictive back][]

[`PopScope`]: {{site.api}}/flutter/widgets/PopScope-class.html
[`NavigatorPopHandler`]: {{site.api}}/flutter/widgets/NavigatorPopHandler-class.html
[`PopEntry`]: {{site.api}}/flutter/widgets/PopEntry-class.html
[`Form.canPop`]: {{site.api}}/flutter/widgets/Form/canPop.html
[`Form.onPopInvoked`]: {{site.api}}/flutter/widgets/Form/onPopInvoked.html
[`Route.popDisposition`]: {{site.api}}/flutter/widgets/Route/popDisposition.html
[`ModalRoute.registerPopEntry`]: {{site.api}}/flutter/widgets/ModalRoute/registerPopEntry.html
[`ModalRoute.unregisterPopEntry`]: {{site.api}}/flutter/widgets/ModalRoute/unregisterPopEntry.html

[Issue 109513]: {{site.repo.flutter}}/issues/109513
[Predictive back support for root routes]: {{site.repo.flutter}}/pull/120385
[Platform channel for predictive back]: {{site.repo.engine}}/pull/39208
