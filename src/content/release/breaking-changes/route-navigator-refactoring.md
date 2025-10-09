---
title: Route and Navigator Refactoring
description: >
  Some APIs and function signatures of the
  Route and Navigator classes have changed.
---

{% render docs/breaking-changes.md %}

## Summary

The `Route` class no longer manages its overlay entries in overlay,
and its `install()` method no longer has an `insertionPoint` parameter.
The `isInitialRoute` property in `RouteSetting` has been deprecated,
and `Navigator.pop()` no longer returns a value.

## Context

We refactored the navigator APIs to prepare for the new page API
and the introduction of the `Router` widget as outlined in
the [Router][] design document.
This refactoring introduced some function signature changes
in order to make the existing navigator APIs continue to work
with the new page API.

## Description of change

The boolean return value of `Navigator.pop()` was not well
defined, and the user could achieve the same result by calling
`Navigator.canPop()`.
Since the API for `Navigator.canPop()` was better defined,
we simplified `Navigator.pop()` to not return a boolean value.
 
On the other hand, the navigator requires the ability
to manually rearrange entries in the overlay to allow
the user to change the route history in the new API.
We changed it so that the route only creates and destroys
its overlay entries, while the navigator inserts or
removes overlay entries from the overlay.
We also removed the `insertionPoint` argument of
`Route.install()` because it was obsolete after the change.

Finally, we removed the `isInitialRoute` property from
`RouteSetting` as part of refactoring, and provided the
`onGenerateInitialRoutes` API for full control of
initial routes generation.

## Migration guide

Case 1: An app depends on `pop()` returning a boolean value.

```dart
TextField(
  onTap: () {
    if (Navigator.pop(context))
      print('There still is at least one route after pop');
    else
      print('Oops! No more routes.');
  }
)
```

You could use `Navigator.canPop()` in combination with
`Navigator.pop()` to achieve the same result.

```dart
TextField(
  onTap: () {
    if (Navigator.canPop(context))
      print('There still is at least one route after pop');
    else
      print('Oops! No more routes.');
    // Our navigator pops the route anyway.
    Navigator.pop(context);
  }
)
```

Case 2: An app generates routes based on `isInitialRoute`.

```dart
MaterialApp(
  onGenerateRoute: (RouteSetting setting) {
    if (setting.isInitialRoute)
      return FakeSplashRoute();
    else
      return RealRoute(setting);
  }
)
```

There are different ways to migrate this change.
One way is to set an explicit value for `MaterialApp.initialRoute`.
You can then test for this value in place of `isInitialRoute`.
As `initialRoute` inherits its default value outside of Flutter's scope,
you must set an explicit value for it.

```dart
MaterialApp(
  initialRoute: '/', // Set this value explicitly. Default might be altered.
  onGenerateRoute: (RouteSetting setting) {
    if (setting.name == '/')
      return FakeSplashRoute();
    else
      return RealRoute(setting);
  }
)
```

If there is a more complicated use case,
you can use the new API, `onGenerateInitialRoutes`,
in `MaterialApp` or `CupertinoApp`.

```dart
MaterialApp(
  onGenerateRoute: (RouteSetting setting) {
    return RealRoute(setting);
  },
  onGenerateInitialRoutes: (String initialRouteName) {
    return <Route>[FakeSplashRoute()];
  }
)
```

## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

## References

Design doc:

* [Router][]

API documentation:

* [`Route`][]
* [`Route.install`][]
* [`RouteSetting.isInitialRoute`][]
* [`Navigator`][]
* [`Navigator.pop`][]
* [`Navigator.canPop`][]

Relevant issue:

* [Issue 45938: Router][]

Relevant PR:

* [PR 44930][] - Refactor the imperative api to continue working in the new navigation system


[Issue 45938: Router]: {{site.repo.flutter}}/issues/45938
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Navigator.pop`]: {{site.api}}/flutter/widgets/Navigator/pop.html
[`Navigator.canPop`]: {{site.api}}/flutter/widgets/Navigator/canPop.html
[Router]: /go/navigator-with-router
[PR 44930]: {{site.repo.flutter}}/pull/44930
[`Route`]: {{site.api}}/flutter/widgets/Route-class.html
[`Route.install`]: {{site.api}}/flutter/widgets/Route/install.html
[`RouteSetting.isInitialRoute`]: {{site.api}}/flutter/widgets/RouteSettings/isInitialRoute.html
