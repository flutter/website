---
title: Eliminating nullOk Parameters
description: To eliminate nullOk parameters to help with API sanity in the face of null safety.
---

## Summary

This migration guide describes conversion of code that uses the `nullOk`
parameter on multiple `of` static accessors and related accessors to use
alternate APIs with nullable return values.

## Context

Flutter has a common pattern of allowing lookup of some types of widgets
([`InheritedWidget`][]s) using static member functions that are typically called
`of`, and take a `BuildContext`.

Before non-nullability was the default, it was useful to have a toggle on these
APIs that swapped between throwing an exception if the widget was not present in
the widget tree and returning null if it was not found. It was useful, and
wasn't confusing, since every variable was nullable.

When non-nullability was made the default, it was then desirable to have the
most commonly used APIs return a non-nullable value. This is because saying
`MediaQuery.of(context, nullOk: false)` and then still requiring an `!` operator
or `?` and a fallback value after that call felt awkward.

The `nullOk` parameter was a cheap form of providing a null safety toggle, which
in the face of true language support for non-nullability, was then supplying
redundant, and perhaps contradictory signals to the developer.

To solve this, the `of` accessors (and some related accessors that also used
`nullOk`) were split into two calls: one that returned a non-nullable value and
threw an exception when the sought-after widget was not present, and one that
returned a nullable value that didn't throw an exception, and returned null if
the widget was not present.

The design document for this change is [Eliminating nullOk parameters][].

[Eliminating nullOk parameters]: /go/eliminating-nullok-parameters


## Description of change

The actual change modified these APIs to not have a `nullOk` parameter, and to
return a non-nullable value:

* [`MediaQuery.of`][]
* [`Navigator.of`][]
* [`ScaffoldMessenger.of`][]
* [`Scaffold.of`][]
* [`Router.of`][]
* [`Localizations.localeOf`][]
* [`FocusTraversalOrder.of`][]
* [`FocusTraversalGroup.of`][]
* [`Focus.of`][]
* [`Shortcuts.of`][]
* [`Actions.handler`][]
* [`Actions.find`][]
* [`Actions.invoke`][]
* [`AnimatedList.of`][]
* [`SliverAnimatedList.of`][]
* [`CupertinoDynamicColor.resolve`][]
* [`CupertinoDynamicColor.resolveFrom`][]
* [`CupertinoUserInterfaceLevel.of`][]
* [`CupertinoTheme.brightnessOf`][]
* [`CupertinoThemeData.resolveFrom`][]
* [`NoDefaultCupertinoThemeData.resolveFrom`][]
* [`CupertinoTextThemeData.resolveFrom`][]
* [`MaterialBasedCupertinoThemeData.resolveFrom`][]

And introduced these new APIs alongside those, to return a nullable
value:

* [`MediaQuery.maybeOf`][]
* [`Navigator.maybeOf`][]
* [`ScaffoldMessenger.maybeOf`][]
* [`Scaffold.maybeOf`][]
* [`Router.maybeOf`][]
* [`Localizations.maybeLocaleOf`][]
* [`FocusTraversalOrder.maybeOf`][]
* [`FocusTraversalGroup.maybeOf`][]
* [`Focus.maybeOf`][]
* [`Shortcuts.maybeOf`][]
* [`Actions.maybeFind`][]
* [`Actions.maybeInvoke`][]
* [`AnimatedList.maybeOf`][]
* [`SliverAnimatedList.maybeOf`][]
* [`CupertinoDynamicColor.maybeResolve`][]
* [`CupertinoUserInterfaceLevel.maybeOf`][]
* [`CupertinoTheme.maybeBrightnessOf`][]

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

You also need to modify all instances of calling the API with `nullOk =
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
finding the places where the `!` operator should be removed, and the
`unnecessary_nullable_for_final_variable_declarations` analysis option can be
helpful in finding unnecessary question mark operators on `final` and `const`
variables.

## Timeline

Landed in version: 1.24.0<br>
In stable release: 2.0.0

## References

API documentation:
 * [`MediaQuery.of`][]
 * [`Navigator.of`][]
 * [`ScaffoldMessenger.of`][]
 * [`Scaffold.of`][]
 * [`Router.of`][]
 * [`Localizations.localeOf`][]
 * [`FocusTraversalOrder.of`][]
 * [`FocusTraversalGroup.of`][]
 * [`Focus.of`][]
 * [`Shortcuts.of`][]
 * [`Actions.handler`][]
 * [`Actions.find`][]
 * [`Actions.invoke`][]
 * [`AnimatedList.of`][]
 * [`SliverAnimatedList.of`][]
 * [`CupertinoDynamicColor.resolve`][]
 * [`CupertinoDynamicColor.resolveFrom`][]
 * [`CupertinoUserInterfaceLevel.of`][]
 * [`CupertinoTheme.brightnessOf`][]
 * [`CupertinoThemeData.resolveFrom`][]
 * [`NoDefaultCupertinoThemeData.resolveFrom`][]
 * [`CupertinoTextThemeData.resolveFrom`][]
 * [`MaterialBasedCupertinoThemeData.resolveFrom`][]
 * [`MediaQuery.maybeOf`][]
 * [`Navigator.maybeOf`][]
 * [`ScaffoldMessenger.maybeOf`][]
 * [`Scaffold.maybeOf`][]
 * [`Router.maybeOf`][]
 * [`Localizations.maybeLocaleOf`][]
 * [`FocusTraversalOrder.maybeOf`][]
 * [`FocusTraversalGroup.maybeOf`][]
 * [`Focus.maybeOf`][]
 * [`Shortcuts.maybeOf`][]
 * [`Actions.maybeFind`][]
 * [`Actions.maybeInvoke`][]
 * [`AnimatedList.maybeOf`][]
 * [`SliverAnimatedList.maybeOf`][]
 * [`CupertinoDynamicColor.maybeResolve`][]
 * [`CupertinoUserInterfaceLevel.maybeOf`][]
 * [`CupertinoTheme.maybeBrightnessOf`][]

Relevant issues:
* [Issue 68637][]

Relevant PRs:
* [Remove `nullOk` in `MediaQuery.of`][]
* [Remove `nullOk` in `Navigator.of`][]
* [Remove `nullOk` parameter from `AnimatedList.of` and `SliverAnimatedList.of`][]
* [Remove `nullOk` parameter from `Shortcuts.of`, `Actions.find`, and `Actions.handler`][]
* [Remove `nullOk` parameter from `Focus.of`, `FocusTraversalOrder.of`, and `FocusTraversalGroup.of`][]
* [Remove `nullOk` parameter from `Localizations.localeOf`][]
* [Remove `nullOk` parameter from `Router.of`][]
* [Remove `nullOk` from `Scaffold.of` and `ScaffoldMessenger.of`][]
* [Remove `nullOk` parameter from Cupertino color resolution APIs][]
* [Remove vestigial `nullOk` parameter from `Localizations.localeOf`][]
* [Remove `nullOk` from `Actions.invoke`, add `Actions.maybeInvoke`][]

[`MediaQuery.of`]: {{site.api}}/flutter/widgets/MediaQuery/of.html
[`Navigator.of`]: {{site.api}}/flutter/widgets/Navigator/of.html
[`ScaffoldMessenger.of`]: {{site.api}}/flutter/material/ScaffoldMessenger/of.html
[`Scaffold.of`]: {{site.api}}/flutter/material/Scaffold/of.html
[`Router.of`]: {{site.api}}/flutter/widgets/Router/of.html
[`Localizations.localeOf`]: {{site.api}}/flutter/widgets/Localizations/localeOf.html
[`FocusTraversalOrder.of`]: {{site.api}}/flutter/widgets/FocusTraversalOrder/of.html
[`FocusTraversalGroup.of`]: {{site.api}}/flutter/widgets/FocusTraversalGroup/of.html
[`Focus.of`]: {{site.api}}/flutter/widgets/Focus/of.html
[`Shortcuts.of`]: {{site.api}}/flutter/widgets/Shortcuts/of.html
[`Actions.handler`]: {{site.api}}/flutter/widgets/Actions/handler.html
[`Actions.find`]: {{site.api}}/flutter/widgets/Actions/find.html
[`Actions.invoke`]: {{site.api}}/flutter/widgets/Actions/invoke.html
[`AnimatedList.of`]: {{site.api}}/flutter/widgets/AnimatedList/of.html
[`SliverAnimatedList.of`]: {{site.api}}/flutter/widgets/SliverAnimatedList/of.html
[`CupertinoDynamicColor.resolve`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/resolve.html
[`CupertinoDynamicColor.resolveFrom`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/resolveFrom.html
[`CupertinoUserInterfaceLevel.of`]: {{site.api}}/flutter/cupertino/CupertinoUserInterfaceLevel/of.html
[`CupertinoTheme.brightnessOf`]: {{site.api}}/flutter/cupertino/CupertinoTheme/brightnessOf.html
[`CupertinoThemeData.resolveFrom`]: {{site.api}}/flutter/cupertino/CupertinoThemeData/resolveFrom.html
[`NoDefaultCupertinoThemeData.resolveFrom`]: {{site.api}}/flutter/cupertino/NoDefaultCupertinoThemeData/resolveFrom.html
[`CupertinoTextThemeData.resolveFrom`]: {{site.api}}/flutter/cupertino/CupertinoTextThemeData/resolveFrom.html
[`MaterialBasedCupertinoThemeData.resolveFrom`]: {{site.api}}/flutter/cupertino/MaterialBasedCupertinoThemeData/resolveFrom.html
[`MediaQuery.maybeOf`]: {{site.api}}/flutter/widgets/MediaQuery/maybeOf.html
[`Navigator.maybeOf`]: {{site.api}}/flutter/widgets/Navigator/maybeOf.html
[`ScaffoldMessenger.maybeOf`]: {{site.api}}/flutter/material/ScaffoldMessenger/maybeOf.html
[`Scaffold.maybeOf`]: {{site.api}}/flutter/material/Scaffold/maybeOf.html
[`Router.maybeOf`]: {{site.api}}/flutter/widgets/Router/maybeOf.html
[`Localizations.maybeLocaleOf`]: {{site.api}}/flutter/widgets/Localizations/maybeLocaleOf.html
[`FocusTraversalOrder.maybeOf`]: {{site.api}}/flutter/widgets/FocusTraversalOrder/maybeOf.html
[`FocusTraversalGroup.maybeOf`]: {{site.api}}/flutter/widgets/FocusTraversalGroup/maybeOf.html
[`Focus.maybeOf`]: {{site.api}}/flutter/widgets/Focus/maybeOf.html
[`Shortcuts.maybeOf`]: {{site.api}}/flutter/widgets/Shortcuts/maybeOf.html
[`Actions.maybeFind`]: {{site.api}}/flutter/widgets/Actions/maybeFind.html
[`Actions.maybeInvoke`]: {{site.api}}/flutter/widgets/Actions/maybeInvoke.html
[`AnimatedList.maybeOf`]: {{site.api}}/flutter/widgets/AnimatedList/maybeOf.html
[`SliverAnimatedList.maybeOf`]: {{site.api}}/flutter/widgets/SliverAnimatedList/maybeOf.html
[`CupertinoDynamicColor.maybeResolve`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/maybeResolve.html
[`CupertinoUserInterfaceLevel.maybeOf`]: {{site.api}}/flutter/cupertino/CupertinoUserInterfaceLevel/maybeOf.html
[`CupertinoTheme.maybeBrightnessOf`]: {{site.api}}/flutter/cupertino/CupertinoTheme/maybeBrightnessOf.html
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
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
[Remove vestigial `nullOk` parameter from `Localizations.localeOf`]: {{site.github}}/flutter/flutter/pull/74657
[Remove `nullOk` from `Actions.invoke`, add `Actions.maybeInvoke`]: {{site.github}}/flutter/flutter/pull/74680

