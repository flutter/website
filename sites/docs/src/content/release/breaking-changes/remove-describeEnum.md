---
title: Remove describeEnum
description: >-
  The `describeEnum` method has been removed from the Flutter framework.
  Since Dart 2.14, enums have a `name` getter that does the same thing.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `describeEnum` method has been removed from the framework because it's redundant with the `name`
getter on `Enum` which was introduced in `Dart 2.14`.

## Context

Historically, Flutter used `describeEnum` to return a `String` description of an enum value.
This became redundant when the `name` getter of `Enum` was introduced in `Dart 2.14`.

## Migration guide

If your code previously used the `describeEnum` method to get the value name of an enum member,
migrate your code to use the `name` getter on the instance itself.

```dart diff
  enum Theme { light, dark }

- final theme = describeEnum(Theme.light);

+ Theme.light.name;
```

:::important
This migration isn't supported by `dart fix`.
:::

## Timeline

Landed in version: TBD<br>
In stable release: TBD

## References

API documentation:

* [`enums`][]


Relevant PRs:

* [PR 94496][]
* [PR 190076][]

[`enums`]: {{site.dart-site}}/language/enums
[PR 94496]: {{site.repo.flutter}}/pull/94496
[PR 190076]: {{site.repo.flutter}}/pull/190076


