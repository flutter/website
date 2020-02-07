---
title: The Route and Navigator Refactoring
description: Some of the apis and function signatures of the `Route` and
the `Navigator` have changed after the refactoring.
---

## Summary

The Route does not manage its overlay entries in overlay, and its
`install` method no longer has `insertionPoint` parameter. The
`isInitialRoute` in `RouteSetting` has been deprecated, and The Navigator.pop
no longer has return value. 

## Context

We refactored the navigator apis to prepare for the new page api and
Router widget as outlined in Navigator 2.0 design document. This refactoring
introduced certian function signature changes in order to make the existing
navigator apis continue to work with the new page api.


## Description of change

The boolean return value of `Navigator.pop` was not well defined and user
could achieve the same result by calling the `Navigator.canPop`. Since
the api of `Navigator.canPop` was better defined, we simplified the
Navigator.pop to not return the boolean value.
 
On the other hand, the navigator requires the ability to manually rearrange
overlay entries in the overlay to allow user to change routes history use the
new api. We changed it so that the route only creates and destroys its overlay
entries while the navigator inserts or removes overlay entries from the overlay.
We also removed the `insertionPoint` argument of `Route.install` because it was
obsolete after the change.
 
Finally, we removed the isInitialRoute property from the RouteSetting as part of
refactoring and provided `onGenerateInitialRoutes` api for full controll of
initial routes generation.


## Migration guide

Case 1: An app has dependency of pop to return a boolean value.

<!-- skip -->
```dart
TextField(
  onTap: () {
    if (Navigator.pop(context))
      print(‘There still is at least one route after pop’);
    else
      print(‘Oops! No more route.’);
  }
)

```

You can use the `Navigator.canPop` in combination of `Navigator.pop` to achieve
the same result

<!-- skip -->
```dart
TextField(
  onTap: () {
    if (Navigator.canPop(context))
      print(‘There still is at least one route after pop’);
    else
      print(‘Oops! No more route.’);
    // Our navigator will pop the route anyway.
    Navigator.pop(context);
  }
)
```


Case2: An app generate routes based on isInitialRoute

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

There are different ways to migrate this app. One way is to set initial route name
to a fixed value and generate a specific route (FakeSplashRoute in the above example)
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

If there is a more complicated use case, we can use the new api, onGenerateInitialRoutes,
in MaterialApp/CupertinoApp.

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

v1.14.7

## References

Design doc:
* [Navigator 2.0]

API documentation:
* [`Route`]
* [`Route.install`]
* [`RouteSetting.isInitialRoute`]
* [`Navigator`]
* [`Navigator.pop`]
* [`Navigator.canPop`]

Relevant issue:
* [Navigator 2.0]

Relevant PR:
* [Navigator 2.0: Refactor the imperative api to continue working in the new navigation system]

[Navigator 2.0]: /go/navigator-with-router
[`Route`]: {{site.api}}/flutter/widgets/Route-class.html
[`Route.install`]: {{site.api}}/flutter/widgets/Route/install.html
[`RouteSetting.isInitialRoute`]: {{site.api}}/flutter/widgets/RouteSettings/isInitialRoute.html
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Navigator.pop`]: {{site.api}}/flutter/widgets/Navigator/pop.html
[`Navigator.canPop`]: {{site.api}}/flutter/widgets/Navigator/canPop.html
[Navigator 2.0: Refactor the imperative api to continue working in the new navigation system]: {{site.github}}/flutter/flutter/pull/44930
[Navigator 2.0]: {{site.github}}/flutter/flutter/issues/45938
