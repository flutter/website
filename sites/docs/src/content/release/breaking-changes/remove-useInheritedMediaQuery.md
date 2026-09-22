---
title: Remove useInheritedMediaQuery
description: >-
  The `useInheritedMediaQuery` property has been removed from the Flutter framework.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `useInheritedMediaQuery` property in `WidgetsApp`, `MaterialApp`, and `CupertinoApp` was removed because these widgets never introduced their own `MediaQuery`; the `View` widget takes care of that.

## Context

Historically, Flutter used `useInheritedMediaQuery` to determine whether a `WidgetsApp`, `MaterialApp` or `CupertinoApp` should inherit the MediaQuery from its parent. This became redundant when MediaQuery inheritance became the default behavior.

## Migration guide

If your code previously used `useInheritedMediaQuery`, you can migrate it by deleting any usage of the property.

```dart diff
- useInheritedMediaQuery: true,
```

```dart diff
- useInheritedMediaQuery: false,
```

:::important
This migration isn't supported by `dart fix`.
:::

## Timeline

Landed in version: TBD<br>
In stable release: TBD

## References

API documentation:

* [`WidgetsApp`][]
* [`MaterialApp`][]
* [`CupertinoApp`][]


Relevant PRs:

* [PR 193146][]
* [PR 12970][]
* [PR 12969][]

[`WidgetsApp`]: {{site.api}}/flutter/widgets/WidgetsApp-class.html
[`MaterialApp`]: {{site.pub}}/documentation/material_ui/latest/material_ui/MaterialApp-class.html
[`CupertinoApp`]: {{site.pub}}/documentation/cupertino_ui/latest/cupertino_ui/CupertinoApp-class.html
[PR 193146]: {{site.repo.flutter}}/pull/193146
[PR 12970]: {{site.repo.packages}}/pull/12970
[PR 12969]: {{site.repo.packages}}/pull/12969