---
title: Eliminating `nullOk` Parameters
description: To eliminate `nullOk` parameters to help with API sanity in the face of null safety.
---

## Summary

This migration guide describes conversion of code that uses the `nullOk`
parameter on multiple `of` static accessors and related accessors to use
alternate APIs with nullable return values.

## Context

Flutter has a common pattern of allowing lookup of some types of widgets
(`InheritedWidget`s) using static member functions that are typically called
`of`, and take a `BuildContext`.

Before non-nullability was the default, it was useful to have a toggle on these
APIs that swapped between throwing an exception if the widget was not present in
the widget tree and returning null if it was not found. It was useful, and
wasn't confusing, since every variable was nullable.

When non-nullability was made the default, it was then desirable to have the
most commonly used APIs return a non-nullable value, since saying
`MediaQuery.of(context, nullOk: false)` and then still requiring an `!` operator
or `?` and a fallback value after that call felt awkward, since the `nullOk`
parameter was a cheap form of providing a null safety toggle, which in the face
of true language support for non-nullability, was then supplying redundant, and
perhaps contradictory signals to the developer.

To solve this, the `of` accessors (and some related accessors that also used
`nullOk`) were split into two calls: one that returned a non-nullable value and
threw an exception when the sought-after widget was not present, and one that
returned a nullable value that didn't throw an exception, and returned null if
the widget was not present.

The design doc for this change is here:
https://flutter.dev/go/eliminating-nullok-parameters

## Description of change

The actual change modified these APIs to not have a `nullOk` parameter, and to
return a non-nullable value:

1. [`MediaQuery.of`]
1. [`Navigator.of`]
1. [`ScaffoldMessenger.of`]
1. [`Scaffold.of`]
1. [`Router.of`]
1. [`Localizations.localeOf`]
1. [`FocusTraversalOrder.of`]
1. [`FocusTraversalGroup.of`]
1. [`Focus.of`]
1. [`Shortcuts.of`]
1. [`Actions.handler`]
1. [`Actions.find`]
1. [`AnimatedList.of`]
1. [`SliverAnimatedList.of`]
1. [`CupertinoDynamicColor.resolve`]
1. [`CupertinoDynamicColor.resolveFrom`]
1. [`CupertinoUserInterfaceLevel.of`]
1. [`CupertinoTheme.brightnessOf`]
1. [`CupertinoThemeData.resolveFrom`]
1. [`NoDefaultCupertinoThemeData.resolveFrom`]
1. [`CupertinoTextThemeData.resolveFrom`]
1. [`MaterialBasedCupertinoThemeData.resolveFrom`]

And introduced these new APIs alongside those, to return a nullable
value:

1. [`MediaQuery.maybeOf`]
1. [`Navigator.maybeOf`]
1. [`ScaffoldMessenger.maybeOf`]
1. [`Scaffold.maybeOf`]
1. [`Router.maybeOf`]
1. [`Localizations.maybeLocaleOf`]
1. [`FocusTraversalOrder.maybeOf`]
1. [`FocusTraversalGroup.maybeOf`]
1. [`Focus.maybeOf`]
1. [`Shortcuts.maybeOf`]
1. [`Actions.maybeHandler`]
1. [`Actions.maybeFind`]
1. [`AnimatedList.maybeOf`]
1. [`SliverAnimatedList.maybeOf`]
1. [`CupertinoDynamicColor.maybeResolve`]
1. [`CupertinoDynamicColor.maybeResolveFrom`]
1. [`CupertinoUserInterfaceLevel.maybeOf`]
1. [`CupertinoTheme.maybeBrightnessOf`]
1. [`CupertinoThemeData.maybeResolveFrom`]
1. [`NoDefaultCupertinoThemeData.maybeResolveFrom`]
1. [`CupertinoTextThemeData.maybeResolveFrom`]
1. [`MaterialBasedCupertinoThemeData.maybeResolveFrom`]

## Migration guide

In order to modify your code to use the new form of the APIs, convert all
instances of calls that include `nullOk = true` as a parameter to use the
`maybe` form of the API instead.

So this:
```
MediaQueryData? data = MediaQuery.of(context, nullOk: true);
```
becomes:
```
MediaQueryData? data = MediaQuery.maybeOf(context);
```

You will also need to modify all instances of calling the API with `nullOk =
false` (often the default), to accept non-nullable return values, or remove any
`!` operators:

So either of:
```
MediaQueryData data = MediaQuery.of(context)!; // nullOk false by default.
MediaQueryData? data = MediaQuery.of(context); // nullOk false by default.
```

both become:
```
MediaQueryData data = MediaQuery.of(context); // No ! or ? operator here now.
```

The `unnecessary_non_null_assertion` analysis option can be quite helpful in
finding the places where the `!` operator should be removed.

## Timeline

Landed in version: 1.24.0<br>
In stable release: not yet

## References

{% include master-api.md %}

API documentation:
 * [`MediaQuery.of`]
 * [`Navigator.of`]
 * [`ScaffoldMessenger.of`]
 * [`Scaffold.of`]
 * [`Router.of`]
 * [`Localizations.localeOf`]
 * [`FocusTraversalOrder.of`]
 * [`FocusTraversalGroup.of`]
 * [`Focus.of`]
 * [`Shortcuts.of`]
 * [`Actions.handler`]
 * [`Actions.find`]
 * [`AnimatedList.of`]
 * [`SliverAnimatedList.of`]
 * [`CupertinoDynamicColor.resolve`]
 * [`CupertinoDynamicColor.resolveFrom`]
 * [`CupertinoUserInterfaceLevel.of`]
 * [`CupertinoTheme.brightnessOf`]
 * [`CupertinoThemeData.resolveFrom`]
 * [`NoDefaultCupertinoThemeData.resolveFrom`]
 * [`CupertinoTextThemeData.resolveFrom`]
 * [`MaterialBasedCupertinoThemeData.resolveFrom`]

Relevant issues:
* [Issue 68637][Issue 68637]

Relevant PRs:
* [Remove `nullOk` in `MediaQuery.of`]
* [Remove `nullOk` in `Navigator.of`]
* [Remove `nullOk` parameter from `AnimatedList.of` and `SliverAnimatedList.of`]
* [Remove `nullOk` parameter from `Shortcuts.of`, `Actions.find`, and `Actions.handler`]
* [Remove `nullOk` parameter from `Focus.of`, `FocusTraversalOrder.of`, and `FocusTraversalGroup.of`]
* [Remove `nullOk` parameter from `Localizations.localeOf`]
* [Remove `nullOk` parameter from `Router.of`]
* [Remove `nullOk` from `Scaffold.of` and `ScaffoldMessenger.of`]
* [Remove `nullOk` parameter from Cupertino color resolution APIs]

[`MediaQuery.of`]: {{site.api}}/flutter/widgets/MediaQuery/of.html
[`Navigator.of`]: {{site.api}}/flutter/widgets/Navigator/of.html
[`ScaffoldMessenger.of`]: https://master-api.flutter.dev/flutter/material/ScaffoldMessenger/of.html
[`Scaffold.of`]: https://master-api.flutter.dev/flutter/material/Scaffold/of.html
[`Router.of`]: https://master-api.flutter.dev/flutter/widgets/Router/of.html
[`Localizations.localeOf`]: https://master-api.flutter.dev/flutter/widgets/Localizations/localeOf.html
[`FocusTraversalOrder.of`]: https://master-api.flutter.dev/flutter/widgets/FocusTraversalOrder/of.html
[`FocusTraversalGroup.of`]: https://master-api.flutter.dev/flutter/widgets/FocusTraversalGroup/of.html
[`Focus.of`]: https://master-api.flutter.dev/flutter/widgets/Focus/of.html
[`Shortcuts.of`]: https://master-api.flutter.dev/flutter/widgets/Shortcuts/of.html
[`Actions.handler`]: https://master-api.flutter.dev/flutter/widgets/Actions/handler.html
[`Actions.find`]: https://master-api.flutter.dev/flutter/widgets/Actions/find.html
[`AnimatedList.of`]: https://master-api.flutter.dev/flutter/widgets/AnimatedList/of.html
[`SliverAnimatedList.of`]: https://master-api.flutter.dev/flutter/widgets/SliverAnimatedList/of.html
[`CupertinoDynamicColor.resolve`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoDynamicColor/resolve.html
[`CupertinoDynamicColor.resolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoDynamicColor/resolveFrom.html
[`CupertinoUserInterfaceLevel.of`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoUserInterfaceLevel/of.html
[`CupertinoTheme.brightnessOf`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoTheme/brightnessOf.html
[`CupertinoThemeData.resolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoThemeData/resolveFrom.html
[`NoDefaultCupertinoThemeData.resolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/NoDefaultCupertinoThemeData/resolveFrom.html
[`CupertinoTextThemeData.resolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoTextThemeData/resolveFrom.html
[`MaterialBasedCupertinoThemeData.resolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/MaterialBasedCupertinoThemeData/resolveFrom.html
[`MediaQuery.maybeOf`]: {{site.api}}/flutter/widgets/MediaQuery/maybeOf.html
[`Navigator.maybeOf`]: {{site.api}}/flutter/widgets/Navigator/maybeOf.html
[`ScaffoldMessenger.maybeOf`]: https://master-api.flutter.dev/flutter/material/ScaffoldMessenger/maybeOf.html
[`Scaffold.maybeOf`]: https://master-api.flutter.dev/flutter/material/Scaffold/maybeOf.html
[`Router.maybeOf`]: https://master-api.flutter.dev/flutter/widgets/Router/maybeOf.html
[`Localizations.maybeLocaleOf`]: https://master-api.flutter.dev/flutter/widgets/Localizations/maybeLocaleOf.html
[`FocusTraversalOrder.maybeOf`]: https://master-api.flutter.dev/flutter/widgets/FocusTraversalOrder/maybeOf.html
[`FocusTraversalGroup.maybeOf`]: https://master-api.flutter.dev/flutter/widgets/FocusTraversalGroup/maybeOf.html
[`Focus.maybeOf`]: https://master-api.flutter.dev/flutter/widgets/Focus/maybeOf.html
[`Shortcuts.maybeOf`]: https://master-api.flutter.dev/flutter/widgets/Shortcuts/maybeOf.html
[`Actions.maybeHandler`]: https://master-api.flutter.dev/flutter/widgets/Actions/maybeHandler.html
[`Actions.maybeFind`]: https://master-api.flutter.dev/flutter/widgets/Actions/maybeFind.html
[`AnimatedList.maybeOf`]: https://master-api.flutter.dev/flutter/widgets/AnimatedList/maybeOf.html
[`SliverAnimatedList.maybeOf`]: https://master-api.flutter.dev/flutter/widgets/SliverAnimatedList/maybeOf.html
[`CupertinoDynamicColor.maybeResolve`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoDynamicColor/maybeResolve.html
[`CupertinoDynamicColor.maybeResolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoDynamicColor/maybeResolveFrom.html
[`CupertinoUserInterfaceLevel.maybeOf`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoUserInterfaceLevel/maybeOf.html
[`CupertinoTheme.maybeBrightnessOf`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoTheme/maybeBrightnessOf.html
[`CupertinoThemeData.maybeResolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoThemeData/maybeResolveFrom.html
[`NoDefaultCupertinoThemeData.maybeResolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/NoDefaultCupertinoThemeData/maybeResolveFrom.html
[`CupertinoTextThemeData.maybeResolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoTextThemeData/maybeResolveFrom.html
[`MaterialBasedCupertinoThemeData.maybeResolveFrom`]: https://master-api.flutter.dev/flutter/cupertino/MaterialBasedCupertinoThemeData/maybeResolveFrom.html
[Issue 68637]: {{site.github}}/flutter/flutter/issues/68637
[Remove `nullOk` in `MediaQuery.of`]: {{site.github}}/flutter/flutter/pull/68736
[Remove `nullOk` in `Navigator.of`]: {{site.github}}/flutter/flutter/pull/70726
[Remove `nullOk` parameter from `AnimatedList.of` and `SliverAnimatedList.of`]: {{site.github}}/flutter/flutter/pull/68925
[Remove `nullOk` parameter from `Shortcuts.of`, `Actions.find`, and `Actions.handler`]: {{site.github}}/flutter/flutter/pull/68921
[Remove `nullOk` parameter from `Shortcuts.of`, `Actions.find`, and `Actions.handler`]: {{site.github}}/flutter/flutter/pull/68921
[Remove `nullOk` parameter from `Focus.of`, `FocusTraversalOrder.of`, and `FocusTraversalGroup.of`]: {{site.github}}/flutter/flutter/pull/68917
[Remove `nullOk` parameter from `Localizations.localeOf`]: {{site.github}}/flutter/flutter/pull/68911
[Remove `nullOk` parameter from `Router.of`]: {{site.github}}/flutter/flutter/pull/68910
[Remove `nullOk` from `Scaffold.of` and `ScaffoldMessenger.of`]: {{site.github}}/flutter/flutter/pull/68908
[Remove `nullOk` parameter from Cupertino color resolution APIs]: {{site.github}}/flutter/flutter/pull/68905

