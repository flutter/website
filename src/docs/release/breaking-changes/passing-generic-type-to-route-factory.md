---
title: Passing generic type to RouteFactory
description: The generic type is now passed to the RouteFactory.
---

## Summary

The generic type is now passed to the `RouteFactory`.

## Context

Previous `RouteFactory` only returns `Route<dynamic>`, typically the `onGenerateRoute` and the `onUnknownRoute` method in `MaterialApp` and `CupertinoApp`. When user called navigator and `await` for the `Navigator.pop` result with a specific type (such as boolean), but no route table defined at `routes`, the `onGenerateRoute` would try to resolve the route which the user was requesting, then it would throw a type error. With this change, `Route` will return the same route type if there's a generic type provided to `onGenerateRoute` or `onUnknownRoute`.

## Description of change

The generic type is added to `RouteFactory`'s `typedef`. You must pass generic type when defining `onGenerateRoute` or `onUnknownRoute`.

## Migration guide

You must migrate your code as described in this section
if you're subclassing or implementing `onGenerateRoute` / `onUnknownRoute`.
If you do, the analyzer shows the following warnings when you
upgrade to the Flutter version that includes this change:

```none
error • The argument type 'MaterialPageRoute<dynamic> Function(RouteSettings)' can't be assigned to the parameter type 'Route<T> Function<T>(RouteSettings)' • lib/main.dart:114:7 • argument_type_not_assignable
```

Code before migration:

<!-- skip -->
```dart
MaterialApp(
  onGenerateRoute: (RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return Container();
      },
    );
  },
)
```

Code after migration:

<!-- skip -->
```dart
MaterialApp(
  onGenerateRoute: <T>(RouteSettings settings) {
    return MaterialPageRoute<T>(
      builder: (BuildContext context) {
        return Container();
      },
    );
  },
)
```

You must pass generic type when you're trying to define `onGenerateRoute` or `onUnknownRoute` in `MaterialApp` or `CupertinoApp`.

## Timeline

This change was made in March of 2020 after the v1.16.3 release.

## References

API documentation:
* [`RouteFactory`][]

Relevant PR:
* [Passing generic type to `RouteFactory`][]


[Passing generic type to `RouteFactory`]: {{site.github}}/flutter/flutter/pull/53390

[`RouteFactory`]: {{site.api}}/flutter/widgets/RouteFactory.html
