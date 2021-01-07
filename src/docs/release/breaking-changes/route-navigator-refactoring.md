---
title: Route and Navigator Refactoring
description: Some APIs and function signatures of the Route and Navigator classes have changed.
---

## Summary

The `Route` class no longer manages its overlay entries in overlay,
and its `install()` method no longer has an `insertionPoint` parameter.
The `isInitialRoute` property in `RouteSetting` has been deprecated,
and `Navigator.pop()` no longer returns a value. 

## Context

We refactored the navigator APIs to prepare for the new page API
and the introduction of the `Router` widget as outlined in
the [Navigator 2.0 and Router][] design document.
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

<!-- skip -->
```dart
TextField(
  onTap: () {
    if (Navigator.pop(context))
      print(‘There still is at least one route after pop’);
    else
      print(‘Oops! No more routes.’);
  }
)
```

You could use `Navigator.canPop()` in combination with
`Navigator.pop()` to achieve the same result.

<!-- skip -->
```dart
TextField(
  onTap: () {
    if (Navigator.canPop(context))
      print(‘There still is at least one route after pop’);
    else
      print(‘Oops! No more routes.’);
    // Our navigator pops the route anyway.
    Navigator.pop(context);
  }
)
```


Case 2: An app generates routes based on `isInitialRoute`.

<!-- skip -->
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
One way is to set the initial route name
to a fixed value and generate a specific route
(`FakeSplashRoute` in the above example)
for the route name.

<!-- skip -->
```dart
MaterialApp(
  initialRouteName: ‘fakeSplash’,
  onGenerateRoute: (RouteSetting setting) {
    if (setting.name == ‘fakeSplash’)
      return FakeSplashRoute();
    else
      return RealRoute(setting);
  }
)
```

If there is a more complicated use case,
you can use the new API, `onGenerateInitialRoutes`,
in `MaterialApp` or `CupertinoApp`.

<!-- skip -->
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
* [Navigator 2.0 and Router][]

API documentation:
* [`Route`][]
* [`Route.install`][]
* [`RouteSetting.isInitialRoute`][]
* [`Navigator`][]
* [`Navigator.pop`][]
* [`Navigator.canPop`][]

Relevant issue:
* [Issue 45938: Navigator 2.0][]

Relevant PR:
* [PR 44930: Navigator 2.0][] - Refactor the imperative api to continue working in the new navigation system


[Issue 45938: Navigator 2.0]: {{site.github}}/flutter/flutter/issues/45938
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Navigator.pop`]: {{site.api}}/flutter/widgets/Navigator/pop.html
[`Navigator.canPop`]: {{site.api}}/flutter/widgets/Navigator/canPop.html
[Navigator 2.0 and Router]: /go/navigator-with-router
[PR 44930: Navigator 2.0]: {{site.github}}/flutter/flutter/pull/44930
[`Route`]: {{site.api}}/flutter/widgets/Route-class.html
[`Route.install`]: {{site.api}}/flutter/widgets/Route/install.html
[`RouteSetting.isInitialRoute`]: {{site.api}}/flutter/widgets/RouteSettings/isInitialRoute.html
