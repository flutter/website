---
title: Migrate `of` to non-nullable return values, and add `maybeOf`
description: >
  To eliminate nullOk parameters to help with API clarity
  in the face of null safety.
---

{% render "docs/breaking-changes.md" %}

## Summary

This migration guide describes conversion of code that uses various static `of`
functions to retrieve information from a context that used to return nullable
values, but now return non-nullable values.

## Context

Flutter has a common pattern of allowing lookup of some types of widgets
(typically [`InheritedWidget`][]s, but also others) using static member
functions that are typically called `of`.

When non-nullability was made the default, it was then desirable to have the
most commonly used APIs return a non-nullable value. This is because saying
`Scrollable.of(context)` and then still requiring an `!` operator or `?` and a
fallback value after that call felt awkward, and was not idiomatic for
non-nullable Dart code.

A lot of this migration was performed when we eliminated `nullOk` parameters in
a [previous migration][], but some `of` methods were missed in that migration,
and some were subsequently added with nullable return types, counter to our
common pattern.

In this migration, the affected `of` accessors were split into two calls: one
that returned a non-nullable value and threw an exception when the sought-after
value was not present (still called `of`), and one that returned a nullable
value that didn't throw an exception, and returned null if the value was not
present (a new method called `maybeOf`).

## Description of change

The change modified these static `of` APIs to return non-nullable values.
If a value is not found, they will also now assert in debug mode, and
throw an exception in release mode.

* [`AutofillGroup.of`]
* [`DefaultTabController.of`]
* [`DefaultTextHeightBehavior.of`]
* [`Form.of`]
* [`HeroControllerScope.of`]
* [`Material.of`]
* [`Overlay.of`]
* [`PageStorage.of`]
* [`PrimaryScrollController.of`]
* [`RenderAbstractViewport.of`]
* [`RestorationScope.of`]
* [`Scrollable.of`]
* [`ScrollNotificationObserver.of`]

This change also introduced new static `maybeOf` APIs alongside
the above functions, which return a nullable version of the same value, and
simply return null if the value is not found, without throwing any exceptions.

* [`AutofillGroup.maybeOf`]
* [`DefaultTabController.maybeOf`]
* [`DefaultTextHeightBehavior.maybeOf`]
* [`Form.maybeOf`]
* [`HeroControllerScope.maybeOf`]
* [`Material.maybeOf`]
* [`Overlay.maybeOf`]
* [`PageStorage.maybeOf`]
* [`PrimaryScrollController.maybeOf`]
* [`RenderAbstractViewport.maybeOf`]
* [`RestorationScope.maybeOf`]
* [`Scrollable.maybeOf`]
* [`ScrollNotificationObserver.maybeOf`]

## Migration guide

To modify your code to use the new form of the APIs, first convert all
instances of the original static `of` functions (where its nullability is
important) to use the `maybeOf` form instead.

Code before migration:

```dart
ScrollController? controller = Scrollable.of(context);
```

Code after migration:

```dart
ScrollController? controller = Scrollable.maybeOf(context);
```

Then, for instances where the code calls the `of` API followed by
an exclamation point, just remove the exclamation point: it can
no longer return a nullable value.

Code before migration:

```dart
ScrollController controller = Scrollable.of(context)!;
```

Code after migration:

```dart
ScrollController controller = Scrollable.of(context);
```

The following can also be helpful:

* [`unnecessary_non_null_assertion`][] (linter message) identifies
  places where an  `!` operator should be removed
* [`unnecessary_null_checks`][] (analysis option) identifies places
  where the `?` operator isn't needed
* [`unnecessary_null_in_if_null_operators`][] identifies places
  where a `??` operator isn't needed
* [`unnecessary_nullable_for_final_variable_declarations`][] (analysis option)
  finds unnecessary question mark operators on `final` and `const` variables

## Timeline

In stable release: 3.7

## References

API documentation:

* [`Material.of`][]

Relevant PRs:

* [Add `maybeOf` for all the cases when `of` returns nullable][]
* [Add `Overlay.maybeOf`, make `Overlay.of` return a non-nullable instance][]

[previous migration]: /release/breaking-changes/eliminating-nullok-parameters
[`unnecessary_non_null_assertion`]: {{site.dart-site}}/tools/diagnostic-messages#unnecessary_non_null_assertion
[`unnecessary_null_checks`]: {{site.dart-site}}/tools/linter-rules#unnecessary_null_checks
[`unnecessary_null_in_if_null_operators`]: {{site.dart-site}}/tools/linter-rules#unnecessary_null_in_if_null_operators
[`unnecessary_nullable_for_final_variable_declarations`]: {{site.dart-site}}/tools/linter-rules#unnecessary_nullable_for_final_variable_declarations
[`AutofillGroup.maybeOf`]: {{site.api}}/flutter/widgets/AutofillGroup/maybeOf.html
[`AutofillGroup.of`]: {{site.api}}/flutter/widgets/AutofillGroup/of.html
[`DefaultTabController.maybeOf`]: {{site.api}}/flutter/material/DefaultTabController/maybeOf.html
[`DefaultTabController.of`]: {{site.api}}/flutter/material/DefaultTabController/of.html
[`DefaultTextHeightBehavior.maybeOf`]: {{site.api}}/flutter/widgets/DefaultTextHeightBehavior/maybeOf.html
[`DefaultTextHeightBehavior.of`]: {{site.api}}/flutter/widgets/DefaultTextHeightBehavior/of.html
[`Form.maybeOf`]: {{site.api}}/flutter/widgets/Form/maybeOf.html
[`Form.of`]: {{site.api}}/flutter/widgets/Form/of.html
[`HeroControllerScope.maybeOf`]: {{site.api}}/flutter/widgets/HeroControllerScope/maybeOf.html
[`HeroControllerScope.of`]: {{site.api}}/flutter/widgets/HeroControllerScope/of.html
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[`Material.maybeOf`]: {{site.api}}/flutter/material/Material/maybeOf.html
[`Material.of`]: {{site.api}}/flutter/material/Material/of.html
[`Overlay.maybeOf`]: {{site.api}}/flutter/widgets/Overlay/maybeOf.html
[`Overlay.of`]: {{site.api}}/flutter/widgets/Overlay/of.html
[`PageStorage.maybeOf`]: {{site.api}}/flutter/widgets/PageStorage/maybeOf.html
[`PageStorage.of`]: {{site.api}}/flutter/widgets/PageStorage/of.html
[`PrimaryScrollController.maybeOf`]: {{site.api}}/flutter/widgets/PrimaryScrollController/maybeOf.html
[`PrimaryScrollController.of`]: {{site.api}}/flutter/widgets/PrimaryScrollController/of.html
[`RenderAbstractViewport.maybeOf`]: {{site.api}}/flutter/rendering/RenderAbstractViewport/maybeOf.html
[`RenderAbstractViewport.of`]: {{site.api}}/flutter/rendering/RenderAbstractViewport/of.html
[`RestorationScope.maybeOf`]: {{site.api}}/flutter/widgets/RestorationScope/maybeOf.html
[`RestorationScope.of`]: {{site.api}}/flutter/widgets/RestorationScope/of.html
[`Scrollable.maybeOf`]: {{site.api}}/flutter/widgets/Scrollable/maybeOf.html
[`Scrollable.of`]: {{site.api}}/flutter/widgets/Scrollable/of.html
[`ScrollNotificationObserver.maybeOf`]: {{site.api}}/flutter/widgets/ScrollNotificationObserver/maybeOf.html
[`ScrollNotificationObserver.of`]: {{site.api}}/flutter/widgets/ScrollNotificationObserver/of.html
[Add `maybeOf` for all the cases when `of` returns nullable]: {{site.repo.flutter}}/pull/114120
[Add `Overlay.maybeOf`, make `Overlay.of` return a non-nullable instance]: {{site.repo.flutter}}/pull/110811
