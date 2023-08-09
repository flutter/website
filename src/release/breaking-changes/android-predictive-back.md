---
title: Android Predictive Back
description: >
  The ability to control back navigation at the time that a back gesture is
  received has been replaced with an ahead-of-time navigation API in order to
  support Android 14's Predictive Back feature.
---

## Summary

To support Android 14's Predictive Back feature, a set of ahead-of-time APIs
have replaced just-in-time navigation APIs, like `WillPopScope` and
`Navigator.willPop`.

## Background

Android 14 introduced the
[Predictive Back feature](https://developer.android.com/guide/navigation/predictive-back-gesture),
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
both cases, the app developer is informed that a back was attempted and whether
or not it was successful.

### `PopScope`
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

### `Form.canPop` and `Form.onPopInvoked`
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

### `Route.popDisposition`
This getter synchronously returns the `RoutePopDisposition` for the route, which
describes how pops will behave.

```dart
if (myRoute.popDisposition == RoutePopDisposition.doNotPop) {
  // Back gestures are disabled.
}
```

### `ModalRoute.registerPopInterface` and `ModalRoute.unregisterPopInterface`
Use these methods to register `PopScope` widgets, to be evaluated when the route
decides whether it can pop. This functionality might be used when implementing a
custom `PopScope` widget.

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final ModalRoute<dynamic>? nextRoute = ModalRoute.of(context);
  if (nextRoute != _route) {
    _route?.unregisterPopInterface(this);
    _route = nextRoute;
    _route?.registerPopInterface(this);
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

For cases where it's necessary to be notified that a pop was attempted, the
`onPopInvoked` method can be used in a similar way to `onWillPop`. Keep in mind
that while `onWillPop` was called before the pop was handled and had the ability
to cancel it, `onPopInvoked` is called after the pop is finished being handled.

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
  onPopInvoked (bool didPop) {
    _myHandleOnPopMethod();
  },
  child: ...
),
```

### Migrating from `WillPopScope` to `NavigatorPopHandler` for nested `Navigator`s
A very common use case of `WillPopScope` was to properly handle back gestures
when using nested `Navigator` widgets. It's possible to do this using `PopScope`
as well, but there is now a wrapper widget that makes this even easier:
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

### Migrating from `Form.onWillPop` to `Form.canPop` and `Form.onPopInvoked`
Previously, `Form` used a `WillPopScope` instance under the hood and exposed its
`onWillPop` method. This has been replaced with a `PopScope` that exposes its
`canPop` and `onPopInvoked` methods. Migrating is identical to migrating from
`WillPopScope` to `PopScope`, detailed above.

### Migrating from `Route.willPop` to `Route.popDisposition`
`Route`'s `willPop` method returned a `Future<RoutePopDisposition>` to
accommodate the fact that pops could be canceled.  Now that that's no longer
true, this logic has been simplified to a synchronous getter.

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

### Migrating from `ModalRoute.add/removeScopedWillPopCallback` to `ModalRoute.(un)registerPopInterface`
Internally, `ModalRoute` kept track of the existence of `WillPopScope`s in its
widget subtree by registering them with `addScopedWillPopCallback` and
`removeScopedWillPopCallback`. Since `PopScope` replaces `WillPopScope`, these
methods have been replaced by `registerPopInterface` and
`unregisterPopInterface`, respectively.

`PopInterface` is implemented by `PopScope` in order to expose only the minimal
information necessary to `ModalRoute`. Anyone writing their own `PopScope`
should implement `PopInterface` and register and unregister their widget with
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
  _route?.unregisterPopInterface(this);
  _route = ModalRoute.of(context);
  _route?.registerPopInterface(this);
}
```

### Migrating from `ModalRoute.hasScopedWillPopCallback` to `ModalRoute.popDisposition`
This method was previously used for a use-case very similar to Predictive Back
but in the Cupertino library, where certain back transitions allowed canceling
the navigation. The route transition was disabled when there was even the
possibility of a `WillPopScope` widget canceling the pop.

Now that the API requires this to be decided ahead of time, this no longer needs
to be speculatively based on the existence of `PopScope` widgets. The definitive
logic of whether a `ModalRoute` is having popping blocked by a `PopScope` widget
is baked into `ModalRoute.popDisposition`.

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

## Timeline

Landed in version: 3.13<br>
In stable release: 3.13

## References

{% include docs/master-api.md %}

API documentation:

* [`PopScope`][]
* [`NavigatorPopHandler`][]
* [`PopScope`][]
* [`NavigatorPopHandler`][]
* [`PopInterface`][]
* [`Form.canPop`][]
* [`Form.onPopInvoked`][]
* [`Route.popDisposition`][]
* [`ModalRoute.registerPopInterface`][]
* [`ModalRoute.unregisterPopInterface`][]

Relevant issues:

* [Issue 109513][]

Relevant PRs:

* [Predictive Back support for root routes][]
* [Platform channel for predictive back][]

{% include docs/master-api.md %}

[`PopScope`]: {{site.master-api}}/flutter/widgets/PopScope-class.html
[`NavigatorPopHandler`]: {{site.master-api}}/flutter/widgets/NavigatorPopHandler-class.html
[`PopInterface`]: {{site.master-api}}/flutter/widgets/PopInterface-class.html
[`Form.canPop`]: {{site.master-api}}/flutter/widgets/Form/canPop.html
[`Form.onPopInvoked`]: {{site.master-api}}/flutter/widgets/Form/onPopInvoked.html
[`Route.popDisposition`]: {{site.master-api}}/flutter/widgets/Route/popDisposition.html
[`ModalRoute.registerPopInterface`]: {{site.master-api}}/flutter/widgets/ModalRoute/registerPopInterface.html
[`ModalRoute.unregisterPopInterface`]: {{site.master-api}}/flutter/widgets/ModalRoute/unregisterPopInterface.html

[Issue 109513]: {{site.repo.flutter}}/issues/109513
[Predictive back support for root routes]: {{site.repo.flutter}}/pull/120385
[Platform channel for predictive back]: {{site.repo.engine}}/pull/39208
