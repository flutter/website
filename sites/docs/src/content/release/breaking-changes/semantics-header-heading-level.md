---
title: Update semantics header and headingLevel behavior on iOS and Android
description: >-
  The `header` semantics property is now a no-op on iOS and Android.
  Accessibility heading behaviors are now controlled with `headingLevel`.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `header` semantics property now behaves as a no-op on iOS and Android.
To declare a section heading for accessibility purposes on these platforms,
use the `headingLevel` property with a value greater than `0`.

## Context

Historically, Flutter used the boolean `header` semantics property
to denote headings on platform implementations:
* On Android, a `header` value of `true` mapped to
  `View.setHeading(true)`.
* On iOS, a `header` value of `true` mapped to the
  `UIAccessibilityTraitHeader` accessibility trait.

However, `setHeading` and `UIAccessibilityTraitHeader`
represent headings (equivalent to section headers/headings),
which are best represented by a heading level.
In contrast, "header" on these platforms often represents a banner
or an app bar (such as `SliverAppBar` or `AppBar`),
creating confusion and mismatch
between platform APIs and Flutter properties.

With this change:
* The `header` semantics property behaves as a no-op
  on iOS and Android. It remains available in the API and can
  still be used in the future if similar APIs are provided.
* The `headingLevel` property is updated so that setting it
  to a value greater than `0` maps directly to
  `View.setHeading(true)` on Android
  and `UIAccessibilityTraitHeader` on iOS.
  On iOS 13+, it also maps to `accessibilityHeadingLevel`.

## Migration guide

If your code previously used `Semantics(header: true, ...)` or
`SemanticsProperties(header: true, ...)` to declare headings,
migrate your code to use `headingLevel: 1`
(or another integer greater than `0`).

Note that while setting `headingLevel` to any value greater than `0`
declares a heading on Android and iOS, other platforms (such as the web)
treat the specific heading level number differently. For example,
on the web, values `1` through `6` map to the corresponding
`<h1>` through `<h6>` HTML elements.

Code before migration:

```dart
Semantics(
  header: true,
  child: Text('Section Title'),
)
```

Code after migration:

```dart
Semantics(
  headingLevel: 1,
  child: Text('Section Title'),
)
```

Similarly, if you used `SemanticsProperties`:

Code before migration:

```dart
SemanticsProperties(
  header: true,
)
```

Code after migration:

```dart
SemanticsProperties(
  headingLevel: 1,
)
```

## Timeline

Landed in version: 3.45.0-0.1.pre<br>
In stable release: TBD

## References

API documentation:

* [`Semantics`][]
* [`SemanticsProperties`][]
* [`SemanticsConfiguration`][]

Relevant issues:

* [Issue 175416][]

Relevant PRs:

* [PR 186916][]
* [PR 175416][]

[`Semantics`]: {{site.api}}/flutter/widgets/Semantics-class.html
[`SemanticsProperties`]: {{site.api}}/flutter/semantics/SemanticsProperties-class.html
[`SemanticsConfiguration`]: {{site.api}}/flutter/semantics/SemanticsConfiguration-class.html
[Issue 175416]: {{site.repo.flutter}}/issues/175416
[PR 186916]: {{site.repo.flutter}}/pull/186916
[PR 175416]: {{site.repo.flutter}}/pull/175416
