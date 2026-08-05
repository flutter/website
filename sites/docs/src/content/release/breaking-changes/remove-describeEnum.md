---
title: Remove describeEnum
description: >-
  The describeEnum method has been removed from the Flutter framework.
  since Dart 2.14 Enums has the name getter which does the same thing.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `describeEnum` has been removed from the framework because it's redundant to the `name`
getter on `Enum` which was introduced in `Dart 2.14`.

## Context

Historically, Flutter used used `describeEnum` to get a short description of an enum value,
this became redundant when `name` getter of `Enum` was introduced in `Dart 2.14`, all methods
that uses `describeEnum` in the framework have migrated to using `name` getter.

## Migration guide

If your code previously used `describeEnum` method to get the value name of an enum member.
migrate your code to use the `name` getter on the instance itself.

Code before migration:

```dart
enum Theme { light, dark }

final theme = describeEnum(Theme.light)
// theme will contain `light`
```

Code after migration:

```dart
Theme.light.name
// theme will contain `light`
```

## Timeline

Landed in version: TBD<br>
In stable release: TBD

## References

API documentation:

* [`enums`][]


Relevant PRs:

* [PR 190076][]

[`enums`]: {{site.dart-site}}/language/enums
[PR 190076]: {{site.repo.flutter}}/pull/190076


